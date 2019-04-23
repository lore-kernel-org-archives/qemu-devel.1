Received: from eggs.gnu.org ([209.51.188.92]:53827)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jermar@gorgo>) id 1hIsqc-0002wt-N1
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 06:40:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jermar@gorgo>) id 1hIsqb-0002A2-JW
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 06:40:22 -0400
Received: from [93.153.64.87] (port=41040 helo=gorgo)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jermar@gorgo>) id 1hIsqb-00026k-9L
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 06:40:21 -0400
From: =?UTF-8?q?Jakub=20Jerm=C3=A1=C5=99?= <jakub.jermar@kernkonzept.com>
Date: Tue, 23 Apr 2019 12:38:55 +0200
Message-Id: <20190423103855.1257968-1-jakub.jermar@kernkonzept.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] mips: Decide to map PAGE_EXEC in map_address
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Jakub=20Jerm=C3=A1=C5=99?= <jakub.jermar@kernkonzept.com>, Aurelien Jarno <aurelien@aurel32.net>, Aleksandar Markovic <amarkovic@wavecomp.com>, Aleksandar Rikalo <arikalo@wavecomp.com>

This commit addresses QEMU Bug #1825311:

  mips_cpu_handle_mmu_fault renders all accessed pages executable

It allows finer-grained control over whether the accessed page should be
executable by moving the decision to the underlying map_address
function, which has more information for this.

As a result, pages that have the XI bit set in the TLB and are accessed
for read/write, don't suddenly end up being executable.

Signed-off-by: Jakub Jerm=C3=A1=C5=99 <jakub.jermar@kernkonzept.com>
---
 target/mips/helper.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/target/mips/helper.c b/target/mips/helper.c
index c44cdca3b5..f182935fcf 100644
--- a/target/mips/helper.c
+++ b/target/mips/helper.c
@@ -43,7 +43,7 @@ int no_mmu_map_address (CPUMIPSState *env, hwaddr *phys=
ical, int *prot,
                         target_ulong address, int rw, int access_type)
 {
     *physical =3D address;
-    *prot =3D PAGE_READ | PAGE_WRITE;
+    *prot =3D PAGE_READ | PAGE_WRITE | PAGE_EXEC;
     return TLBRET_MATCH;
 }
=20
@@ -61,7 +61,7 @@ int fixed_mmu_map_address (CPUMIPSState *env, hwaddr *p=
hysical, int *prot,
     else
         *physical =3D address;
=20
-    *prot =3D PAGE_READ | PAGE_WRITE;
+    *prot =3D PAGE_READ | PAGE_WRITE | PAGE_EXEC;
     return TLBRET_MATCH;
 }
=20
@@ -101,6 +101,8 @@ int r4k_map_address (CPUMIPSState *env, hwaddr *physi=
cal, int *prot,
                 *prot =3D PAGE_READ;
                 if (n ? tlb->D1 : tlb->D0)
                     *prot |=3D PAGE_WRITE;
+                if (!(n ? tlb->XI1 : tlb->XI0))
+                    *prot |=3D PAGE_EXEC;
                 return TLBRET_MATCH;
             }
             return TLBRET_DIRTY;
@@ -182,7 +184,7 @@ static int get_seg_physical_address(CPUMIPSState *env=
, hwaddr *physical,
     } else {
         /* The segment is unmapped */
         *physical =3D physical_base | (real_address & segmask);
-        *prot =3D PAGE_READ | PAGE_WRITE;
+        *prot =3D PAGE_READ | PAGE_WRITE | PAGE_EXEC;
         return TLBRET_MATCH;
     }
 }
@@ -913,8 +915,8 @@ int mips_cpu_handle_mmu_fault(CPUState *cs, vaddr add=
ress, int size, int rw,
     }
     if (ret =3D=3D TLBRET_MATCH) {
         tlb_set_page(cs, address & TARGET_PAGE_MASK,
-                     physical & TARGET_PAGE_MASK, prot | PAGE_EXEC,
-                     mmu_idx, TARGET_PAGE_SIZE);
+                     physical & TARGET_PAGE_MASK, prot, mmu_idx,
+                     TARGET_PAGE_SIZE);
         ret =3D 0;
     } else if (ret < 0)
 #endif
@@ -936,8 +938,8 @@ int mips_cpu_handle_mmu_fault(CPUState *cs, vaddr add=
ress, int size, int rw,
                                            address, rw, access_type, mmu=
_idx);
                 if (ret =3D=3D TLBRET_MATCH) {
                     tlb_set_page(cs, address & TARGET_PAGE_MASK,
-                            physical & TARGET_PAGE_MASK, prot | PAGE_EXE=
C,
-                            mmu_idx, TARGET_PAGE_SIZE);
+                            physical & TARGET_PAGE_MASK, prot, mmu_idx,
+                            TARGET_PAGE_SIZE);
                     ret =3D 0;
                     return ret;
                 }
--=20
2.20.1
