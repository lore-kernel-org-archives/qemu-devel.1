Received: from eggs.gnu.org ([2001:4830:134:3::10]:45844)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d1XCq-0003GW-VU
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 07:58:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d1XCq-0007os-4R
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 07:58:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38090)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1d1XCp-0007oX-Re
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 07:58:32 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AE295AA442
	for <qemu-devel@nongnu.org>; Fri, 21 Apr 2017 11:58:30 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Fri, 21 Apr 2017 13:56:30 +0200
Message-Id: <20170421115646.15544-50-quintela@redhat.com>
In-Reply-To: <20170421115646.15544-1-quintela@redhat.com>
References: <20170421115646.15544-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 49/65] ram: Remember last_page instead of
 last_offset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com

Signed-off-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

--

Improve comment
Fix typo
---
 migration/ram.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 52ab14b..d501040 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -171,8 +171,8 @@ struct RAMState {
     RAMBlock *last_seen_block;
     /* Last block from where we have sent data */
     RAMBlock *last_sent_block;
-    /* Last offset we have sent data from */
-    ram_addr_t last_offset;
+    /* Last dirty target page we have sent */
+    ram_addr_t last_page;
     /* last ram version we have seen */
     uint32_t last_version;
     /* We are in the first round */
@@ -1061,7 +1061,7 @@ static bool find_dirty_block(RAMState *rs, PageSear=
chStatus *pss,
     pss->offset =3D migration_bitmap_find_dirty(rs, pss->block, pss->off=
set,
                                               page_abs);
     if (pss->complete_round && pss->block =3D=3D rs->last_seen_block &&
-        pss->offset >=3D rs->last_offset) {
+        (pss->offset >> TARGET_PAGE_BITS) >=3D rs->last_page) {
         /*
          * We've been once around the RAM and haven't found anything.
          * Give up.
@@ -1402,7 +1402,7 @@ static int ram_find_and_save_block(RAMState *rs, bo=
ol last_stage)
     }
=20
     pss.block =3D rs->last_seen_block;
-    pss.offset =3D rs->last_offset;
+    pss.offset =3D rs->last_page << TARGET_PAGE_BITS;
     pss.complete_round =3D false;
=20
     if (!pss.block) {
@@ -1424,7 +1424,7 @@ static int ram_find_and_save_block(RAMState *rs, bo=
ol last_stage)
     } while (!pages && again);
=20
     rs->last_seen_block =3D pss.block;
-    rs->last_offset =3D pss.offset;
+    rs->last_page =3D pss.offset >> TARGET_PAGE_BITS;
=20
     return pages;
 }
@@ -1499,7 +1499,7 @@ static void ram_state_reset(RAMState *rs)
 {
     rs->last_seen_block =3D NULL;
     rs->last_sent_block =3D NULL;
-    rs->last_offset =3D 0;
+    rs->last_page =3D 0;
     rs->last_version =3D ram_list.version;
     rs->ram_bulk_stage =3D true;
 }
@@ -1844,7 +1844,7 @@ static int postcopy_chunk_hostpages(MigrationState =
*ms)
     /* Easiest way to make sure we don't resume in the middle of a host-=
page */
     rs->last_seen_block =3D NULL;
     rs->last_sent_block =3D NULL;
-    rs->last_offset     =3D 0;
+    rs->last_page =3D 0;
=20
     QLIST_FOREACH_RCU(block, &ram_list.blocks, next) {
         unsigned long first =3D block->offset >> TARGET_PAGE_BITS;
--=20
2.9.3
