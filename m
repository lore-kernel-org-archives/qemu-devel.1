Received: from eggs.gnu.org ([209.51.188.92]:48212)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1hEUdk-0007jZ-Cy
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 04:01:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1hEUdf-00086g-GQ
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 04:00:56 -0400
Received: from 9.mo5.mail-out.ovh.net ([178.32.96.204]:47170)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1hEUdZ-00080d-Pr
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 04:00:47 -0400
Received: from player779.ha.ovh.net (unknown [10.109.160.143])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 6BC6E22864D
	for <qemu-devel@nongnu.org>; Thu, 11 Apr 2019 10:00:41 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Thu, 11 Apr 2019 09:59:59 +0200
Message-Id: <20190411080004.8690-2-clg@kaod.org>
In-Reply-To: <20190411080004.8690-1-clg@kaod.org>
References: <20190411080004.8690-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 1/6] target/ppc: Don't check UPRT in radix mode
 when in HV real mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, Suraj Jitindar Singh <sjitindarsingh@gmail.com>, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

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
---
 target/ppc/mmu-radix64.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/target/ppc/mmu-radix64.c b/target/ppc/mmu-radix64.c
index ca1fb2673f93..cac076ee92d9 100644
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
+                      "LPCR:UPRT not set in radix mode ! LPCR=3D%016lx\n=
",
+                      env->spr[SPR_LPCR]);
+    }
+
     /* Virtual Mode Access - get the fully qualified address */
     if (!ppc_radix64_get_fully_qualified_addr(env, eaddr, &lpid, &pid)) =
{
         ppc_radix64_raise_segi(cpu, rwx, eaddr);
--=20
2.20.1
