Received: from eggs.gnu.org ([2001:4830:134:3::10]:52568)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dRrLX-00071z-SH
	for qemu-devel@nongnu.org; Sun, 02 Jul 2017 22:44:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dRrLW-0006nk-Ik
	for qemu-devel@nongnu.org; Sun, 02 Jul 2017 22:44:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41550)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dRrLW-0006nJ-Cv
	for qemu-devel@nongnu.org; Sun, 02 Jul 2017 22:44:18 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 756AF83F3D
	for <qemu-devel@nongnu.org>; Mon,  3 Jul 2017 02:44:17 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Mon,  3 Jul 2017 10:44:06 +0800
Message-Id: <1499049848-18012-3-git-send-email-peterx@redhat.com>
In-Reply-To: <1499049848-18012-1-git-send-email-peterx@redhat.com>
References: <1499049848-18012-1-git-send-email-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 2/4] vl: move global property,
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com

Currently drive_init_func() may call migrate_get_current() while the
migrate object is still not ready yet at that time. Move the migration
object init earlier, along with the global properties, right after
acceleration init.

This fixes a breakage for iotest 055, which caused an assertion failure.

Reported-by: Max Reitz <mreitz@redhat.com>
Reported-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Fixes: 3df663 ("migration: move only_migratable to MigrationState")
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 vl.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/vl.c b/vl.c
index 0c497a3..2ae4313 100644
--- a/vl.c
+++ b/vl.c
@@ -4414,6 +4414,18 @@ int main(int argc, char **argv, char **envp)
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
@@ -4595,18 +4607,6 @@ int main(int argc, char **argv, char **envp)
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
2.7.4
