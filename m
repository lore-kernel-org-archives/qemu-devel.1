Received: from eggs.gnu.org ([2001:4830:134:3::10]:39071)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cdKm0-0003Xs-DD
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 12:50:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cdKly-0005wG-Tr
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 12:50:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36636)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cdKly-0005vv-Mh
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 12:50:46 -0500
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Mon, 13 Feb 2017 17:50:25 +0000
Message-Id: <20170213175033.7314-7-dgilbert@redhat.com>
In-Reply-To: <20170213175033.7314-1-dgilbert@redhat.com>
References: <20170213175033.7314-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 06/14] migrate: Introduce zero RAM checks to
 skip RAM migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, ashijeetacharya@gmail.com, amit@kernel.org, pbutsykin@virtuozzo.com, zhang.zhanghailiang@huawei.com

From: Ashijeet Acharya <ashijeetacharya@gmail.com>

Migration of a "none" machine with no RAM crashes abruptly as
bitmap_new() fails and thus aborts. Instead place zero RAM checks at
appropriate places to skip migration of RAM in this case and complete
migration successfully for devices only.

Signed-off-by: Ashijeet Acharya <ashijeetacharya@gmail.com>
Message-Id: <1486564125-31366-1-git-send-email-ashijeetacharya@gmail.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/ram.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 67f2efb..f289fcd 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1346,6 +1346,11 @@ static int ram_find_and_save_block(QEMUFile *f, bo=
ol last_stage,
     ram_addr_t dirty_ram_abs; /* Address of the start of the dirty page =
in
                                  ram_addr_t space */
=20
+    /* No dirty page as there is zero RAM */
+    if (!ram_bytes_total()) {
+        return pages;
+    }
+
     pss.block =3D last_seen_block;
     pss.offset =3D last_offset;
     pss.complete_round =3D false;
@@ -1952,14 +1957,17 @@ static int ram_save_init_globals(void)
     bytes_transferred =3D 0;
     reset_ram_globals();
=20
-    ram_bitmap_pages =3D last_ram_offset() >> TARGET_PAGE_BITS;
     migration_bitmap_rcu =3D g_new0(struct BitmapRcu, 1);
-    migration_bitmap_rcu->bmap =3D bitmap_new(ram_bitmap_pages);
-    bitmap_set(migration_bitmap_rcu->bmap, 0, ram_bitmap_pages);
-
-    if (migrate_postcopy_ram()) {
-        migration_bitmap_rcu->unsentmap =3D bitmap_new(ram_bitmap_pages)=
;
-        bitmap_set(migration_bitmap_rcu->unsentmap, 0, ram_bitmap_pages)=
;
+    /* Skip setting bitmap if there is no RAM */
+    if (ram_bytes_total()) {
+        ram_bitmap_pages =3D last_ram_offset() >> TARGET_PAGE_BITS;
+        migration_bitmap_rcu->bmap =3D bitmap_new(ram_bitmap_pages);
+        bitmap_set(migration_bitmap_rcu->bmap, 0, ram_bitmap_pages);
+
+        if (migrate_postcopy_ram()) {
+            migration_bitmap_rcu->unsentmap =3D bitmap_new(ram_bitmap_pa=
ges);
+            bitmap_set(migration_bitmap_rcu->unsentmap, 0, ram_bitmap_pa=
ges);
+        }
     }
=20
     /*
--=20
2.9.3
