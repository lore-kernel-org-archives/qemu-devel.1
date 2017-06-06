Received: from eggs.gnu.org ([2001:4830:134:3::10]:41427)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dI90G-0007fO-IH
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 03:34:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dI90F-0001SY-Ea
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 03:34:12 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Tue,  6 Jun 2017 09:34:08 +0200
Message-Id: <1496734448-19256-5-git-send-email-armbru@redhat.com>
In-Reply-To: <1496734448-19256-1-git-send-email-armbru@redhat.com>
References: <1496734448-19256-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PULL 4/4] monitor: fix object_del for
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
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Eric Blake <eblake@redhat.com>, Daniel Berrange <berrange@redhat.com>, qemu-stable@nongnu.org

From: Michael Roth <mdroth@linux.vnet.ibm.com>

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
2.7.5
