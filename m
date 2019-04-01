Received: from eggs.gnu.org ([209.51.188.92]:40780)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hAsvi-0005MW-SY
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 05:08:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hAsvh-0004Ea-Ol
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 05:08:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37706)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hAsvh-0004Dw-H0
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 05:08:33 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Mon,  1 Apr 2019 11:08:23 +0200
Message-Id: <20190401090827.20793-2-armbru@redhat.com>
In-Reply-To: <20190401090827.20793-1-armbru@redhat.com>
References: <20190401090827.20793-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v2 1/5] Revert "vl: Fix to create migration
 object before block backends again"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: anthony.perard@citrix.com, peterx@redhat.com, quintela@redhat.com, dgilbert@redhat.com, kwolf@redhat.com, imammedo@redhat.com

This reverts commit e60483f2f8498ae08ae79ca4c6fb03a3317f5e1e.

Recent commit cda4aa9a5a0 moved block backend creation before machine
property evaluation.  This broke block backends registering migration
blockers.  Commit e60483f2f84 fixed it by moving migration object
creation before block backend creation.  This broke migration with
Xen.  Turns out we need to configure the accelerator before we create
the migration object so that Xen's accelerator compat properties get
applied.  Revert the flawed commit.  This fixes the Xen regression,
but brings back the block backend regression.  The next commits will
fix it again.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 vl.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/vl.c b/vl.c
index d61d5604e5..c1d5484e12 100644
--- a/vl.c
+++ b/vl.c
@@ -4276,17 +4276,10 @@ int main(int argc, char **argv, char **envp)
         exit(0);
     }
 
-    /*
-     * Migration object can only be created after global properties
-     * are applied correctly.
-     */
-    migration_object_init();
-
     /*
      * Note: we need to create block backends before
      * machine_set_property(), so machine properties can refer to
-     * them, and after migration_object_init(), so we can create
-     * migration blockers.
+     * them.
      */
     configure_blockdev(&bdo_queue, machine_class, snapshot);
 
@@ -4304,6 +4297,12 @@ int main(int argc, char **argv, char **envp)
                      machine_class->name, machine_class->deprecation_reason);
     }
 
+    /*
+     * Migration object can only be created after global properties
+     * are applied correctly.
+     */
+    migration_object_init();
+
     if (qtest_chrdev) {
         qtest_init(qtest_chrdev, qtest_log, &error_fatal);
     }
-- 
2.17.2
