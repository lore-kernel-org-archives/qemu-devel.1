Received: from eggs.gnu.org ([209.51.188.92]:42726)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h2to3-0000rZ-U0
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 04:27:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h2to2-0001HM-8F
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 04:27:39 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Sun, 10 Mar 2019 19:26:20 +1100
Message-Id: <20190310082703.1245-18-david@gibson.dropbear.id.au>
In-Reply-To: <20190310082703.1245-1-david@gibson.dropbear.id.au>
References: <20190310082703.1245-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 17/60] target/ppc/spapr: Clear partition table
 entry when allocating hash table
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, lvivier@redhat.com, Suraj Jitindar Singh <sjitindarsingh@gmail.com>, David Gibson <david@gibson.dropbear.id.au>

From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>

If we allocate a hash page table then we know that the guest won't be
using process tables, so set the partition table entry maintained for
the guest to zero. If this isn't done, then the guest radix bit will
remain set in the entry. This means that when the guest calls
H_REGISTER_PROCESS_TABLE there will be a mismatch between then flags
and the value in spapr->patb_entry, and the call will fail. The guest
will then panic:

Failed to register process table (rc=3D-4)
kernel BUG at arch/powerpc/platforms/pseries/lpar.c:959

The result being that it isn't possible to boot a hash guest on a P9
system.

Also fix a bug in the flags parsing in h_register_process_table() which
was introduced by the same patch, and simplify the handling to make it
less likely that errors will be introduced in the future. The effect
would have been setting the host radix bit LPCR_HR for a hash guest
using process tables, which currently isn't supported and so couldn't
have been triggered.

Fixes: 00fd075e18 "target/ppc/spapr: Set LPCR:HR when using Radix mode"

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Message-Id: <20190305022102.17610-1-sjitindarsingh@gmail.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c       |  1 +
 hw/ppc/spapr_hcall.c | 12 ++++++++----
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 946bbcf9ee..755056875c 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1632,6 +1632,7 @@ void spapr_reallocate_hpt(sPAPRMachineState *spapr,=
 int shift,
         }
     }
     /* We're setting up a hash table, so that means we're not radix */
+    spapr->patb_entry =3D 0;
     spapr_set_all_lpcrs(0, LPCR_HR | LPCR_UPRT);
 }
=20
diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 8bfdddc964..7016a09386 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -1339,6 +1339,7 @@ static target_ulong h_register_process_table(PowerP=
CCPU *cpu,
     target_ulong proc_tbl =3D args[1];
     target_ulong page_size =3D args[2];
     target_ulong table_size =3D args[3];
+    target_ulong update_lpcr =3D 0;
     uint64_t cproc;
=20
     if (flags & ~FLAGS_MASK) { /* Check no reserved bits are set */
@@ -1394,10 +1395,13 @@ static target_ulong h_register_process_table(Powe=
rPCCPU *cpu,
     spapr->patb_entry =3D cproc; /* Save new process table */
=20
     /* Update the UPRT, HR and GTSE bits in the LPCR for all cpus */
-    spapr_set_all_lpcrs(((flags & (FLAG_RADIX | FLAG_HASH_PROC_TBL)) ?
-                         (LPCR_UPRT | LPCR_HR) : 0) |
-                        ((flags & FLAG_GTSE) ? LPCR_GTSE : 0),
-                        LPCR_UPRT | LPCR_HR | LPCR_GTSE);
+    if (flags & FLAG_RADIX)     /* Radix must use process tables, also s=
et HR */
+        update_lpcr |=3D (LPCR_UPRT | LPCR_HR);
+    else if (flags & FLAG_HASH_PROC_TBL) /* Hash with process tables */
+        update_lpcr |=3D LPCR_UPRT;
+    if (flags & FLAG_GTSE)      /* Guest translation shootdown enable */
+        update_lpcr |=3D FLAG_GTSE;
+    spapr_set_all_lpcrs(update_lpcr, LPCR_UPRT | LPCR_HR | LPCR_GTSE);
=20
     if (kvm_enabled()) {
         return kvmppc_configure_v3_mmu(cpu, flags & FLAG_RADIX,
--=20
2.20.1
