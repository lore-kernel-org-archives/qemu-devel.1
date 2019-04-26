Received: from eggs.gnu.org ([209.51.188.92]:60591)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hJu19-0006F4-HO
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 02:07:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hJu17-0005K5-JP
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 02:07:27 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 26 Apr 2019 16:06:23 +1000
Message-Id: <20190426060627.18153-33-david@gibson.dropbear.id.au>
In-Reply-To: <20190426060627.18153-1-david@gibson.dropbear.id.au>
References: <20190426060627.18153-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 32/36] target/ppc: Don't check UPRT in radix
 mode when in HV real mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: gkurz@kaod.org, clg@kaod.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, David Gibson <david@gibson.dropbear.id.au>

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>

It appears that during kexec, we run for a while in hypervisor
real mode with LPCR:HR set and LPCR:UPRT clear, which trips
the assertion in ppc_radix64_handle_mmu_fault().

First this shouldn't be an assertion, it's a guest error.

Then we shouldn't be checking these things in hypervisor real
mode (or in virtual hypervisor guest real mode which is similar)
as the real HW won't use those LPCR bits in those cases anyway,
so technically it's ok to have this discrepancy.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Message-Id: <20190411080004.8690-2-clg@kaod.org>
[dwg: Fix for 32-bit builds]
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/mmu-radix64.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/target/ppc/mmu-radix64.c b/target/ppc/mmu-radix64.c
index ca1fb2673f..066e324464 100644
--- a/target/ppc/mmu-radix64.c
+++ b/target/ppc/mmu-radix64.c
@@ -228,10 +228,10 @@ int ppc_radix64_handle_mmu_fault(PowerPCCPU *cpu, v=
addr eaddr, int rwx,
     ppc_v3_pate_t pate;
=20
     assert((rwx =3D=3D 0) || (rwx =3D=3D 1) || (rwx =3D=3D 2));
-    assert(ppc64_use_proc_tbl(cpu));
=20
-    /* Real Mode Access */
-    if (((rwx =3D=3D 2) && (msr_ir =3D=3D 0)) || ((rwx !=3D 2) && (msr_d=
r =3D=3D 0))) {
+    /* HV or virtual hypervisor Real Mode Access */
+    if ((msr_hv || cpu->vhyp) &&
+        (((rwx =3D=3D 2) && (msr_ir =3D=3D 0)) || ((rwx !=3D 2) && (msr_=
dr =3D=3D 0)))) {
         /* In real mode top 4 effective addr bits (mostly) ignored */
         raddr =3D eaddr & 0x0FFFFFFFFFFFFFFFULL;
=20
@@ -241,6 +241,16 @@ int ppc_radix64_handle_mmu_fault(PowerPCCPU *cpu, va=
ddr eaddr, int rwx,
         return 0;
     }
=20
+    /*
+     * Check UPRT (we avoid the check in real mode to deal with
+     * transitional states during kexec.
+     */
+    if (!ppc64_use_proc_tbl(cpu)) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "LPCR:UPRT not set in radix mode ! LPCR=3D"
+                      TARGET_FMT_lx "\n", env->spr[SPR_LPCR]);
+    }
+
     /* Virtual Mode Access - get the fully qualified address */
     if (!ppc_radix64_get_fully_qualified_addr(env, eaddr, &lpid, &pid)) =
{
         ppc_radix64_raise_segi(cpu, rwx, eaddr);
--=20
2.20.1
