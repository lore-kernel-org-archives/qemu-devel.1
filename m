Received: from eggs.gnu.org ([2001:4830:134:3::10]:51973)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dZeuE-0001qn-Vz
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 11:04:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dZeuB-0002ny-K8
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 11:04:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:12552)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dZeuB-0002nl-Dz
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 11:04:19 -0400
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Mon, 24 Jul 2017 16:04:13 +0100
Message-Id: <20170724150413.19357-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for 2.10]
 cpu_physical_memory_sync_dirty_bitmap: Fix alignment check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, pbonzini@redhat.com, quintela@redhat.com, alex.bennee@linaro.org
Cc: haozhong.zhang@intel.com, peterx@redhat.com, lvivier@redhat.com

From: Dr. David Alan Gilbert <dgilbert@redhat.com>

This code has an optimised, word aligned version, and a boring
unaligned version.  Recently 084140bd498909 fixed a missing offset
addition from the core of both versions.  However, the offset isn't
necessarily aligned and thus the choice between the two versions
needs fixing up to also include the offset.

Symptom:
  A few stuck unsent pages during migration; not normally noticed
unless under very low bandwidth in which case the migration may get
stuck never ending and never performing a 2nd sync; noticed by
a hanging postcopy-test on a very heavily loaded system.

Fixes: 084140bd498909

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reported-by: Alex Benne=C3=A9 <alex.benee@linaro.org>
Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
---
 include/exec/ram_addr.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
index c04f4f67f6..c802f7f364 100644
--- a/include/exec/ram_addr.h
+++ b/include/exec/ram_addr.h
@@ -378,15 +378,16 @@ uint64_t cpu_physical_memory_sync_dirty_bitmap(RAMB=
lock *rb,
 {
     ram_addr_t addr;
     unsigned long page =3D BIT_WORD(start >> TARGET_PAGE_BITS);
+    unsigned long word =3D BIT_WORD((start + rb->offset) >> TARGET_PAGE_=
BITS);
     uint64_t num_dirty =3D 0;
     unsigned long *dest =3D rb->bmap;
=20
     /* start address is aligned at the start of a word? */
-    if (((page * BITS_PER_LONG) << TARGET_PAGE_BITS) =3D=3D start) {
+    if (((word * BITS_PER_LONG) << TARGET_PAGE_BITS) =3D=3D
+         (start + rb->offset)) {
         int k;
         int nr =3D BITS_TO_LONGS(length >> TARGET_PAGE_BITS);
         unsigned long * const *src;
-        unsigned long word =3D BIT_WORD((start + rb->offset) >> TARGET_P=
AGE_BITS);
         unsigned long idx =3D (word * BITS_PER_LONG) / DIRTY_MEMORY_BLOC=
K_SIZE;
         unsigned long offset =3D BIT_WORD((word * BITS_PER_LONG) %
                                         DIRTY_MEMORY_BLOCK_SIZE);
--=20
2.13.3
