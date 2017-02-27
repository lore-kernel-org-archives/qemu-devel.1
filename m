Received: from eggs.gnu.org ([2001:4830:134:3::10]:38539)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1ciML0-00020g-Pk
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 09:31:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1ciMKw-00081J-Rl
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 09:31:42 -0500
Received: from 9.mo6.mail-out.ovh.net ([87.98.171.146]:39543)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1ciMKw-000812-Mb
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 09:31:38 -0500
Received: from player761.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo6.mail-out.ovh.net (Postfix) with ESMTP id 73B8AA528F
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 15:31:37 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Mon, 27 Feb 2017 15:29:23 +0100
Message-Id: <1488205773-30436-17-git-send-email-clg@kaod.org>
In-Reply-To: <1488205773-30436-1-git-send-email-clg@kaod.org>
References: <1488205773-30436-1-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 16/26] ppc/xics: simplify the cpu_setup()
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
 hw/intc/xics.c        | 5 +++--
 hw/intc/xics_kvm.c    | 9 ++-------
 include/hw/ppc/xics.h | 2 +-
 3 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/hw/intc/xics.c b/hw/intc/xics.c
index f828bcb07026..a5be0d83cf36 100644
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
index 86ddf470e546..7588280b5d69 100644
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
index 01ca5e2dab50..8325dbdaf104 100644
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
2.7.4
