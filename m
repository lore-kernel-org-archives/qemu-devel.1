Received: from eggs.gnu.org ([2001:4830:134:3::10]:58758)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cHZmj-0000tC-Kz
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 12:25:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cHZme-0005ft-KM
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 12:25:37 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45620
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1cHZme-0005fK-Db
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 12:25:32 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	uBFHNpB5131240
	for <qemu-devel@nongnu.org>; Thu, 15 Dec 2016 12:25:31 -0500
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	by mx0b-001b2d01.pphosted.com with ESMTP id 27bdmfxtu0-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 15 Dec 2016 12:25:31 -0500
Received: from localhost
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Thu, 15 Dec 2016 10:25:30 -0700
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Thu, 15 Dec 2016 11:24:04 -0600
In-Reply-To: <1481822644-617-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1481822644-617-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1481822644-617-3-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 2/2] monitor: fix object_del for
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
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, Daniel Berrange <berrange@redhat.com>, qemu-stable@nongnu.org

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
---
 qom/object_interfaces.c    | 9 +++++++++
 tests/check-qom-proplist.c | 4 ++--
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/qom/object_interfaces.c b/qom/object_interfaces.c
index ded4d84..994d0c7 100644
--- a/qom/object_interfaces.c
+++ b/qom/object_interfaces.c
@@ -5,6 +5,7 @@
 #include "qapi-visit.h"
 #include "qapi/qobject-output-visitor.h"
 #include "qapi/opts-visitor.h"
+#include "qemu/config-file.h"
 
 void user_creatable_complete(Object *obj, Error **errp)
 {
@@ -209,6 +210,14 @@ void user_creatable_del(const char *id, Error **errp)
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
index e3f56ca..ddec574 100644
--- a/tests/check-qom-proplist.c
+++ b/tests/check-qom-proplist.c
@@ -437,9 +437,9 @@ static void test_dummy_createcmdl(void)
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
1.9.1
