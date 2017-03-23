Received: from eggs.gnu.org ([2001:4830:134:3::10]:53797)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cr5Cy-0000WK-Pa
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 12:03:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cr5Ct-0007kS-QN
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 12:03:28 -0400
From: Eric Blake <eblake@redhat.com>
Date: Thu, 23 Mar 2017 11:03:15 -0500
Message-Id: <20170323160315.19696-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.9] qom: Fix regression with 'qom-type'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: rjones@redhat.com, armbru@redhat.com, qemu-stable@nongnu.org, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>

Commit 9a6d1ac assumed that 'qom-type' could be removed from QemuOpts
with no ill effects.  However, this command line proves otherwise:

$ ./x86_64-softmmu/qemu-system-x86_64 -nodefaults -nographic -qmp stdio \
  -object rng-random,filename=/dev/urandom,id=rng0 \
  -device virtio-rng-pci,rng=rng0
qemu-system-x86_64: -object rng-random,filename=/dev/urandom,id=rng0: Parameter 'qom-type' is missing

Fix the regression by restoring qom-type in opts after its temporary
removal that was needed for the duration of user_creatable_add_opts().

Reported-by: Richard W. M. Jones <rjones@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 qom/object_interfaces.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/qom/object_interfaces.c b/qom/object_interfaces.c
index 9c271ad..d4253a8 100644
--- a/qom/object_interfaces.c
+++ b/qom/object_interfaces.c
@@ -122,6 +122,7 @@ Object *user_creatable_add_opts(QemuOpts *opts, Error **errp)
     }
     if (!id) {
         error_setg(errp, QERR_MISSING_PARAMETER, "id");
+        qemu_opt_set(opts, "qom-type", type, &error_abort);
         g_free(type);
         return NULL;
     }
@@ -134,6 +135,7 @@ Object *user_creatable_add_opts(QemuOpts *opts, Error **errp)
     visit_free(v);

     qemu_opts_set_id(opts, (char *) id);
+    qemu_opt_set(opts, "qom-type", type, &error_abort);
     g_free(type);
     QDECREF(pdict);
     return obj;
-- 
2.9.3
