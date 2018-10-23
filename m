Received: from eggs.gnu.org ([2001:4830:134:3::10]:33585)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Manish.Jaggi@cavium.com>) id 1gEt2S-0001Pq-Fk
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 05:31:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Manish.Jaggi@cavium.com>) id 1gEt2O-0007M2-Ok
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 05:31:48 -0400
Received: from mail-eopbgr690088.outbound.protection.outlook.com
	([40.107.69.88]:17488
	helo=NAM04-CO1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Manish.Jaggi@cavium.com>)
	id 1gEt2O-000724-FY
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 05:31:44 -0400
From: <mjaggi@caviumnetworks.com>
Date: Tue, 23 Oct 2018 09:31:19 +0000
Message-ID: <492d066a988d7f22c9438c19f312c2e1f2b3d473.1536948621.git.manish.jaggi@cavium.com>
References: <cover.1536948621.git.manish.jaggi@cavium.com>
In-Reply-To: <cover.1536948621.git.manish.jaggi@cavium.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH v2 2/2] [RFC] arm: program migrated guests'
 invariant registers with host ones
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Jaggi, Manish" <Manish.Jaggi@cavium.com>, "quintela@redhat.com" <quintela@redhat.com>, "dgilbert@redhat.com" <dgilbert@redhat.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "Nair, Jayachandran" <Jayachandran.Nair@cavium.com>, "Nowicki,
	Tomasz" <Tomasz.Nowicki@cavium.com>

From: Manish Jaggi <manish.jaggi@cavium.com>

When KVM_SET_ONE_REG returns KVM_EINVARIANT call KVM_GET_ONE_REG to query
and then replace the particular guest invariant register value with destina=
tion
hosts register.

Signed-off-by: Manish Jaggi <manish.jaggi@cavium.com>

diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 65f867d..8cf4dc9 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -19,6 +19,7 @@
 #include "sysemu/sysemu.h"
 #include "sysemu/kvm.h"
 #include "kvm_arm.h"
+#include "standard-headers/asm-arm/kvm_para.h"
 #include "cpu.h"
 #include "trace.h"
 #include "internals.h"
@@ -37,6 +38,8 @@ static bool cap_has_mp_state;
=20
 static ARMHostCPUFeatures arm_host_cpu_features;
=20
+extern bool enable_hostinvariant;
+
 int kvm_arm_vcpu_init(CPUState *cs)
 {
     ARMCPU *cpu =3D ARM_CPU(cs);
@@ -451,8 +454,16 @@ bool write_list_to_kvmstate(ARMCPU *cpu, int level)
         default:
             abort();
         }
-        ret =3D kvm_vcpu_ioctl(cs, KVM_SET_ONE_REG, &r);
-        if (ret) {
+	ret =3D kvm_vcpu_ioctl(cs, KVM_SET_ONE_REG, &r);
+	if (enable_hostinvariant && ret =3D=3D -KVM_EINVARIANT) {
+		/* Update Guest invariant to match with migrated host regs*/
+		ret =3D kvm_vcpu_ioctl(cs, KVM_GET_ONE_REG, &r);
+		if (ret)
+			ok =3D false;
+		else
+                	cpu->cpreg_values[i] =3D r.addr;
+        }
+        else if (ret) {
             /* We might fail for "unknown register" and also for
              * "you tried to set a register which is constant with
              * a different value from what it actually contains".
--=20
1.8.3.1
