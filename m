Received: from eggs.gnu.org ([2001:4830:134:3::10]:39087)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1ceMRH-0002NM-9L
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 08:49:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1ceMRC-0005i2-EC
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 08:49:39 -0500
Received: from 5.mo173.mail-out.ovh.net ([46.105.40.148]:44431)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1ceMRC-0005hq-6m
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 08:49:34 -0500
Received: from player791.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo173.mail-out.ovh.net (Postfix) with ESMTP id 03766241CE
	for <qemu-devel@nongnu.org>; Thu, 16 Feb 2017 14:49:32 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Thu, 16 Feb 2017 14:47:36 +0100
Message-Id: <1487252865-12064-14-git-send-email-clg@kaod.org>
In-Reply-To: <1487252865-12064-1-git-send-email-clg@kaod.org>
References: <1487252865-12064-1-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 13/22] ppc/xics: simplify the cpu_setup()
 handler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

The cpu_setup() handler currently takes a 'XICSState *' argument to
grab the kernel ICP file descriptor. This interface can be simplified
by using the 'xics' backlink of the ICP object.

This change is also required by subsequent patches which makes use of
the QOM interface for XICS.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/intc/xics.c        |  5 +++--
 hw/intc/xics_kvm.c    | 11 +++--------
 include/hw/ppc/xics.h |  2 +-
 3 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/hw/intc/xics.c b/hw/intc/xics.c
index 7168c2cfd8a1..c14797fb1964 100644
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
+    info =3D XICS_COMMON_GET_CLASS(ss->xics);
     if (info->cpu_setup) {
-        info->cpu_setup(xics, cpu);
+        info->cpu_setup(ss, cpu);
     }
=20
     switch (PPC_INPUT(env)) {
diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
index 6cabc11f6be1..3941f31c5b3f 100644
--- a/hw/intc/xics_kvm.c
+++ b/hw/intc/xics_kvm.c
@@ -334,17 +334,12 @@ static const TypeInfo ics_kvm_info =3D {
 /*
  * XICS-KVM
  */
-static void xics_kvm_cpu_setup(XICSState *xics, PowerPCCPU *cpu)
+static void xics_kvm_cpu_setup(ICPState *ss, PowerPCCPU *cpu)
 {
-    CPUState *cs;
-    ICPState *ss;
-    KVMXICSState *xicskvm =3D XICS_SPAPR_KVM(xics);
+    CPUState *cs =3D CPU(cpu);
+    KVMXICSState *xicskvm =3D XICS_SPAPR_KVM(ss->xics);
     int ret;
=20
-    cs =3D CPU(cpu);
-    ss =3D &xics->ss[cs->cpu_index];
-
-    assert(cs->cpu_index < xics->nr_servers);
     if (xicskvm->kernel_xics_fd =3D=3D -1) {
         abort();
     }
diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
index 7004c851e250..0375d7d481ef 100644
--- a/include/hw/ppc/xics.h
+++ b/include/hw/ppc/xics.h
@@ -73,7 +73,7 @@ typedef struct ICSIRQState ICSIRQState;
 struct XICSStateClass {
     DeviceClass parent_class;
=20
-    void (*cpu_setup)(XICSState *icp, PowerPCCPU *cpu);
+    void (*cpu_setup)(ICPState *icp, PowerPCCPU *cpu);
 };
=20
 struct XICSState {
--=20
2.7.4
