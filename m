Received: from eggs.gnu.org ([2001:4830:134:3::10]:40798)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dWzxR-0002hQ-2n
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 02:56:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dWzxP-0001gB-DL
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 02:56:41 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Mon, 17 Jul 2017 16:56:21 +1000
Message-Id: <20170717065621.4688-22-david@gibson.dropbear.id.au>
In-Reply-To: <20170717065621.4688-1-david@gibson.dropbear.id.au>
References: <20170717065621.4688-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 21/21] target/ppc: fix CPU hotplug when radix is
 enabled (TCG)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, mdroth@linux.vnet.ibm.com, aik@ozlabs.ru, sjitindarsingh@gmail.com, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, David Gibson <david@gibson.dropbear.id.au>

From: C=C3=A9dric Le Goater <clg@kaod.org>

But when a guest initializes radix mode, it issues a H_REGISTER_PROC_TBL
to update the LPCR of all CPUs. Hot-plugged CPUs inherit from the same
setting under KVM but not under TCG. So, Let's check for radix and update
the default LPCR to keep new CPUs in sync.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/translate_init.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
index ae25fafab9..b325c2cce6 100644
--- a/target/ppc/translate_init.c
+++ b/target/ppc/translate_init.c
@@ -9011,8 +9011,16 @@ void cpu_ppc_set_papr(PowerPCCPU *cpu, PPCVirtualH=
ypervisor *vhyp)
         /* By default we choose legacy mode and switch to new hash or ra=
dix
          * when a register process table hcall is made. So disable proce=
ss
          * tables and guest translation shootdown by default
+         *
+         * Hot-plugged CPUs inherit from the guest radix setting under
+         * KVM but not under TCG. Update the default LPCR to keep new
+         * CPUs in sync when radix is enabled.
          */
-        lpcr->default_value &=3D ~(LPCR_UPRT | LPCR_GTSE);
+        if (ppc64_radix_guest(cpu)) {
+            lpcr->default_value |=3D LPCR_UPRT | LPCR_GTSE;
+        } else {
+            lpcr->default_value &=3D ~(LPCR_UPRT | LPCR_GTSE);
+        }
         lpcr->default_value |=3D LPCR_PDEE | LPCR_HDEE | LPCR_EEE | LPCR=
_DEE |
                                LPCR_OEE;
         break;
--=20
2.13.3
