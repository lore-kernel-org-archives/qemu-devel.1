Received: from eggs.gnu.org ([2001:4830:134:3::10]:35577)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dUcCw-0004oY-79
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 13:10:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dUcCu-0008Hs-QK
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 13:10:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40924)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dUcCu-0008Gy-KZ
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 13:10:48 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AA4373D944
	for <qemu-devel@nongnu.org>; Mon, 10 Jul 2017 17:10:47 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Mon, 10 Jul 2017 18:10:33 +0100
Message-Id: <20170710171040.21021-3-dgilbert@redhat.com>
In-Reply-To: <20170710171040.21021-1-dgilbert@redhat.com>
References: <20170710171040.21021-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 2/9] vl: move global property,
 migrate init earlier
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, lvivier@redhat.com, peterx@redhat.com

From: Peter Xu <peterx@redhat.com>

Currently drive_init_func() may call migrate_get_current() while the
migrate object is still not ready yet at that time. Move the migration
object init earlier, along with the global properties, right after
acceleration init.

This fixes a breakage for iotest 055, which caused an assertion failure.

Reported-by: Max Reitz <mreitz@redhat.com>
Reported-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Tested-by: QingFeng Hao <haoqf@linux.vnet.ibm.com>
Fixes: 3df663 ("migration: move only_migratable to MigrationState")
Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <1499242883-2184-3-git-send-email-peterx@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 vl.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/vl.c b/vl.c
index 7a015eccc6..f7560de622 100644
--- a/vl.c
+++ b/vl.c
@@ -4418,6 +4418,18 @@ int main(int argc, char **argv, char **envp)
=20
     configure_accelerator(current_machine);
=20
+    /*
+     * Register all the global properties, including accel properties,
+     * machine properties, and user-specified ones.
+     */
+    register_global_properties(current_machine);
+
+    /*
+     * Migration object can only be created after global properties
+     * are applied correctly.
+     */
+    migration_object_init();
+
     if (qtest_chrdev) {
         qtest_init(qtest_chrdev, qtest_log, &error_fatal);
     }
@@ -4601,18 +4613,6 @@ int main(int argc, char **argv, char **envp)
             exit (i =3D=3D 1 ? 1 : 0);
     }
=20
-    /*
-     * Register all the global properties, including accel properties,
-     * machine properties, and user-specified ones.
-     */
-    register_global_properties(current_machine);
-
-    /*
-     * Migration object can only be created after global properties
-     * are applied correctly.
-     */
-    migration_object_init();
-
     /* This checkpoint is required by replay to separate prior clock
        reading from the other reads, because timer polling functions que=
ry
        clock values from the log. */
--=20
2.13.0
