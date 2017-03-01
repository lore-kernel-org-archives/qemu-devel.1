Received: from eggs.gnu.org ([2001:4830:134:3::10]:46921)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ciw7y-0008HC-RA
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 23:44:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ciw7t-0000FZ-Ti
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 23:44:38 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed,  1 Mar 2017 15:43:54 +1100
Message-Id: <20170301044405.1792-40-david@gibson.dropbear.id.au>
In-Reply-To: <20170301044405.1792-1-david@gibson.dropbear.id.au>
References: <20170301044405.1792-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 39/50] ppc/xics: simplify the cpu_setup() handler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com, aik@ozlabs.ru, thuth@redhat.com, lvivier@redhat.com, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, David Gibson <david@gibson.dropbear.id.au>

From: C=C3=A9dric Le Goater <clg@kaod.org>

The cpu_setup() handler currently takes a 'XICSState *' argument to
grab the kernel ICP file descriptor. This interface can be simplified
by using the 'xics' backlink of the ICP object.

This change is also required by subsequent patches which makes use of
the QOM interface for XICS.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/intc/xics.c        | 5 +++--
 hw/intc/xics_kvm.c    | 9 ++-------
 include/hw/ppc/xics.h | 2 +-
 3 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/hw/intc/xics.c b/hw/intc/xics.c
index f828bcb..a5be0d8 100644
--- a/hw/intc/xics.c
+++ b/hw/intc/xics.c
@@ -66,14 +66,15 @@ void xics_cpu_setup(XICSState *xics, PowerPCCPU *cpu)
     CPUState *cs =3D CPU(cpu);
     CPUPPCState *env =3D &cpu->env;
     ICPState *ss =3D &xics->ss[cs->cpu_index];
-    XICSStateClass *info =3D XICS_COMMON_GET_CLASS(xics);
+    XICSStateClass *info;
=20
     assert(cs->cpu_index < xics->nr_servers);
=20
     ss->cs =3D cs;
=20
+    info =3D XICS_COMMON_GET_CLASS(xics);
     if (info->cpu_setup) {
-        info->cpu_setup(xics, cpu);
+        info->cpu_setup(ss, cpu);
     }
=20
     switch (PPC_INPUT(env)) {
diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
index 86ddf47..7588280 100644
--- a/hw/intc/xics_kvm.c
+++ b/hw/intc/xics_kvm.c
@@ -324,16 +324,11 @@ static const TypeInfo ics_kvm_info =3D {
 /*
  * XICS-KVM
  */
-static void xics_kvm_cpu_setup(XICSState *xics, PowerPCCPU *cpu)
+static void xics_kvm_cpu_setup(ICPState *ss, PowerPCCPU *cpu)
 {
-    CPUState *cs;
-    ICPState *ss;
+    CPUState *cs =3D CPU(cpu);
     int ret;
=20
-    cs =3D CPU(cpu);
-    ss =3D &xics->ss[cs->cpu_index];
-
-    assert(cs->cpu_index < xics->nr_servers);
     if (kernel_xics_fd =3D=3D -1) {
         abort();
     }
diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
index 01ca5e2..8325dbd 100644
--- a/include/hw/ppc/xics.h
+++ b/include/hw/ppc/xics.h
@@ -74,7 +74,7 @@ typedef struct XICSFabric XICSFabric;
 struct XICSStateClass {
     DeviceClass parent_class;
=20
-    void (*cpu_setup)(XICSState *icp, PowerPCCPU *cpu);
+    void (*cpu_setup)(ICPState *icp, PowerPCCPU *cpu);
 };
=20
 struct XICSState {
--=20
2.9.3
