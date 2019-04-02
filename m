Received: from eggs.gnu.org ([209.51.188.92]:34483)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hBJ2S-0005RM-AQ
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 09:01:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hBJ2R-0001Gj-8C
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 09:01:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42180)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hBJ2Q-0001F2-W0
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 09:01:15 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 309603688E
	for <qemu-devel@nongnu.org>; Tue,  2 Apr 2019 13:01:14 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-116.ams2.redhat.com
	[10.36.116.116])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id D89757F2F6
	for <qemu-devel@nongnu.org>; Tue,  2 Apr 2019 13:01:13 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Tue,  2 Apr 2019 15:01:08 +0200
Message-Id: <20190402130112.15142-5-armbru@redhat.com>
In-Reply-To: <20190402130112.15142-1-armbru@redhat.com>
References: <20190402130112.15142-1-armbru@redhat.com>
Subject: [Qemu-devel] [PULL 4/8] Revert "vl: Fix to create migration object
 before block backends again"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

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
Message-Id: <20190401090827.20793-2-armbru@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
---
 vl.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/vl.c b/vl.c
index 24572de0bd..9b215341a3 100644
--- a/vl.c
+++ b/vl.c
@@ -4277,17 +4277,10 @@ int main(int argc, char **argv, char **envp)
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
 
@@ -4305,6 +4298,12 @@ int main(int argc, char **argv, char **envp)
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
