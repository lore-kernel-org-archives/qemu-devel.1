Received: from eggs.gnu.org ([2001:4830:134:3::10]:46129)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Manish.Jaggi@cavium.com>) id 1gEtp1-000314-NA
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 06:22:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Manish.Jaggi@cavium.com>) id 1gEtow-0005Cz-LJ
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 06:21:59 -0400
Received: from mail-bn3nam01on0050.outbound.protection.outlook.com
	([104.47.33.50]:21833
	helo=NAM01-BN3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Manish.Jaggi@cavium.com>)
	id 1gEtow-0005Ci-Ef
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 06:21:54 -0400
From: <mjaggi@caviumnetworks.com>
Date: Tue, 23 Oct 2018 10:21:50 +0000
Message-ID: <1540290099-146109-1-git-send-email-mjaggi@caviumnetworks.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [RFC] [PATCH] kvm: arm: Introduce error code
 KVM_EINVARIANT
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

This patch introduces an error code KVM_EINVARIANT which is returned
by KVM when userland tries to set an invariant register.

The need for this error code is in VM Migration for arm64.
ARM64 systems use mainly -machine virt -cpu host as parameter to qemu.
Migration requires both Source and destination machines to have same
physical cpu. There are cases where the overall architecture of CPU is
same but the next version of the chip with some bug fixes which have no
effect on qemu operation. In such cases invariant registers like MIDR
have a different value.
Currently Migration fails in such cases.

Rather than sending a EINVAL, a specifc error code will help
userland program the guest invariant register by querying the migrated
host machines invariant registers.

Qemu will have a parameter -hostinvariant along with checking of this
error code. So it can be safely assumed that the feature is opt-in

Corresponding Qemu patcset can be found at :
https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg05048.html


Signed-off-by: Manish Jaggi <manish.jaggi@cavium.com>
---
 arch/arm64/kvm/sys_regs.c     | 9 ++++-----
 include/uapi/linux/kvm_para.h | 1 +
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 22fbbdb..78ffc02 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -1111,7 +1111,7 @@ static int __set_id_reg(const struct sys_reg_desc *rd=
, void __user *uaddr,
=20
 	/* This is what we mean by invariant: you can't change it. */
 	if (val !=3D read_id_reg(rd, raz))
-		return -EINVAL;
+		return -KVM_EINVARIANT;
=20
 	return 0;
 }
@@ -2254,9 +2254,8 @@ static int set_invariant_sys_reg(u64 id, void __user =
*uaddr)
 		return err;
=20
 	/* This is what we mean by invariant: you can't change it. */
-	if (r->val !=3D val)
-		return -EINVAL;
-
+	if (r->val !=3D val)=09
+		return -KVM_EINVARIANT;
 	return 0;
 }
=20
@@ -2335,7 +2334,7 @@ static int demux_c15_set(u64 id, void __user *uaddr)
=20
 		/* This is also invariant: you can't change it. */
 		if (newval !=3D get_ccsidr(val))
-			return -EINVAL;
+			return -KVM_EINVARIANT;
 		return 0;
 	default:
 		return -ENOENT;
diff --git a/include/uapi/linux/kvm_para.h b/include/uapi/linux/kvm_para.h
index 6c0ce49..4358669 100644
--- a/include/uapi/linux/kvm_para.h
+++ b/include/uapi/linux/kvm_para.h
@@ -17,6 +17,7 @@
 #define KVM_E2BIG		E2BIG
 #define KVM_EPERM		EPERM
 #define KVM_EOPNOTSUPP		95
+#define KVM_EINVARIANT          96
=20
 #define KVM_HC_VAPIC_POLL_IRQ		1
 #define KVM_HC_MMU_OP			2
--=20
1.8.3.1
