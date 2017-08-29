Received: from eggs.gnu.org ([2001:4830:134:3::10]:48367)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dmUCc-0001Sx-Tu
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:16:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dmUCZ-0005hh-P7
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:16:22 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55491
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1dmUCZ-0005h1-K6
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:16:19 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v7T0EUPM087789
	for <qemu-devel@nongnu.org>; Mon, 28 Aug 2017 20:16:19 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2cmvhgar8s-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 28 Aug 2017 20:16:18 -0400
Received: from localhost
	by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 28 Aug 2017 18:16:18 -0600
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 28 Aug 2017 19:14:25 -0500
In-Reply-To: <1503965694-10794-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1503965694-10794-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1503965694-10794-51-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 50/79] monitor: fix object_del for
 command-line-created objects
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, Daniel Berrange <berrange@redhat.com>

Currently objects specified on the command-line are only partially
cleaned up when 'object_del' is issued in either HMP or QMP: the
object itself is fully finalized, but the QemuOpts are not removed.
This results in the following behavior:

  x86_64-softmmu/qemu-system-x86_64 -monitor stdio \
    -object memory-backend-ram,id=ram1,size=256M

  QEMU 2.7.91 monitor - type 'help' for more information
  (qemu) object_del ram1
  (qemu) object_del ram1
  object 'ram1' not found
  (qemu) object_add memory-backend-ram,id=ram1,size=256M
  Duplicate ID 'ram1' for object
  Try "help object_add" for more information

which can be an issue for use-cases like memory hotplug.

This happens on the HMP side because hmp_object_add() attempts to
create a temporary QemuOpts entry with ID 'ram1', which ends up
conflicting with the command-line-created entry, since it was never
cleaned up during the previous hmp_object_del() call.

We address this by adding a check in user_creatable_del(), which
is called by both qmp_object_del() and hmp_object_del() to handle
the actual object cleanup, to determine whether an option group entry
matching the object's ID is present and removing it if it is.

Note that qmp_object_add() never attempts to create a temporary
QemuOpts entry, so it does not encounter the duplicate ID error,
which is why this isn't generally visible in libvirt.

Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>
Cc: Eric Blake <eblake@redhat.com>
Cc: Daniel Berrange <berrange@redhat.com>
Cc: qemu-stable@nongnu.org
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
Reviewed-by: Daniel P. Berrange <berrange@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <1496531612-22166-3-git-send-email-mdroth@linux.vnet.ibm.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
(cherry picked from commit c645d5acee0ae022534cb609184277ec2b4a8577)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 qom/object_interfaces.c    | 9 +++++++++
 tests/check-qom-proplist.c | 4 ++--
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/qom/object_interfaces.c b/qom/object_interfaces.c
index d4253a8..ff27e06 100644
--- a/qom/object_interfaces.c
+++ b/qom/object_interfaces.c
@@ -4,6 +4,7 @@
 #include "qemu/module.h"
 #include "qapi-visit.h"
 #include "qapi/opts-visitor.h"
+#include "qemu/config-file.h"
 
 void user_creatable_complete(Object *obj, Error **errp)
 {
@@ -181,6 +182,14 @@ void user_creatable_del(const char *id, Error **errp)
         error_setg(errp, "object '%s' is in use, can not be deleted", id);
         return;
     }
+
+    /*
+     * if object was defined on the command-line, remove its corresponding
+     * option group entry
+     */
+    qemu_opts_del(qemu_opts_find(qemu_find_opts_err("object", &error_abort),
+                                 id));
+
     object_unparent(obj);
 }
 
diff --git a/tests/check-qom-proplist.c b/tests/check-qom-proplist.c
index e3b3ae4..8e432e9 100644
--- a/tests/check-qom-proplist.c
+++ b/tests/check-qom-proplist.c
@@ -438,9 +438,9 @@ static void test_dummy_createcmdl(void)
      * check for this in user_creatable_del() and remove the QemuOpts if
      * it is present.
      *
-     * FIXME: add an assert to verify that the QemuOpts is cleaned up
-     * once the corresponding cleanup code is added.
+     * The below check ensures this works as expected.
      */
+    g_assert_null(qemu_opts_find(&qemu_object_opts, "dev0"));
 }
 
 static void test_dummy_badenum(void)
-- 
2.7.4
