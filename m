Received: from eggs.gnu.org ([2001:4830:134:3::10]:33262)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gMBYt-0004Fc-7W
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 07:43:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gMBYn-0005Kv-LS
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 07:43:24 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:46228)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gMBYj-0005Gw-8s
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 07:43:17 -0500
Received: by mail-oi1-x244.google.com with SMTP id e19-v6so6992554oii.13
	for <qemu-devel@nongnu.org>; Mon, 12 Nov 2018 04:43:15 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20181108175246.13416-5-richard.henderson@linaro.org>
References: <20181108175246.13416-1-richard.henderson@linaro.org>
	<20181108175246.13416-5-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 12 Nov 2018 12:42:53 +0000
Message-ID: <CAFEAcA-ooeVt=GRmu2Q+9DcaAs96B5AonpspVVExqQbf3kORPQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 4/5] target/arm: Fill in ARMISARegisters
 for kvm32
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On 8 November 2018 at 17:52, Richard Henderson
<richard.henderson@linaro.org> wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/kvm32.c | 33 ++++++++++++++++++++++++++++-----
>  1 file changed, 28 insertions(+), 5 deletions(-)
>
> diff --git a/target/arm/kvm32.c b/target/arm/kvm32.c
> index de573f9aa8..9ededa3c73 100644
> --- a/target/arm/kvm32.c
> +++ b/target/arm/kvm32.c
> @@ -44,7 +44,7 @@ bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
>       * and then query that CPU for the relevant ID registers.
>       */
>      int err = 0, fdarray[3];
> -    uint32_t midr, id_pfr0, mvfr1;
> +    uint32_t midr, id_pfr0;
>      uint64_t features = 0;
>
>      /* Old kernels may not know about the PREFERRED_TARGET ioctl: however
> @@ -71,9 +71,32 @@ bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
>
>      err |= read_sys_reg32(fdarray[2], &midr, ARM_CP15_REG32(0, 0, 0, 0));
>      err |= read_sys_reg32(fdarray[2], &id_pfr0, ARM_CP15_REG32(0, 0, 1, 0));
> -    err |= read_sys_reg32(fdarray[2], &mvfr1,
> +
> +    err |= read_sys_reg32(fdarray[2], &ahcf->isar.id_isar0,
> +                          ARM_CP15_REG32(0, 0, 2, 0));
> +    err |= read_sys_reg32(fdarray[2], &ahcf->isar.id_isar1,
> +                          ARM_CP15_REG32(0, 0, 2, 1));
> +    err |= read_sys_reg32(fdarray[2], &ahcf->isar.id_isar2,
> +                          ARM_CP15_REG32(0, 0, 2, 2));
> +    err |= read_sys_reg32(fdarray[2], &ahcf->isar.id_isar3,
> +                          ARM_CP15_REG32(0, 0, 2, 3));
> +    err |= read_sys_reg32(fdarray[2], &ahcf->isar.id_isar4,
> +                          ARM_CP15_REG32(0, 0, 2, 4));
> +    err |= read_sys_reg32(fdarray[2], &ahcf->isar.id_isar5,
> +                          ARM_CP15_REG32(0, 0, 2, 5));
> +    err |= read_sys_reg32(fdarray[2], &ahcf->isar.id_isar6,
> +                          ARM_CP15_REG32(0, 0, 2, 7));
> +
> +    err |= read_sys_reg32(fdarray[2], &ahcf->isar.mvfr0,
> +                          KVM_REG_ARM | KVM_REG_SIZE_U32 |
> +                          KVM_REG_ARM_VFP | KVM_REG_ARM_VFP_MVFR0);
> +    err |= read_sys_reg32(fdarray[2], &ahcf->isar.mvfr1,
>                            KVM_REG_ARM | KVM_REG_SIZE_U32 |
>                            KVM_REG_ARM_VFP | KVM_REG_ARM_VFP_MVFR1);

Testing this on my aarch32 system (a cubieboard running 4.0.0-rc4)
this fails with
qemu-system-arm: Failed to retrieve host CPU features

strace says:
ioctl(14, KVM_CREATE_VM, 0)             = 15
ioctl(15, KVM_CREATE_VCPU, 0)           = 16
ioctl(15, 0x8020aeaf, 0xbea1bc74)       = 0
ioctl(16, KVM_ARM_VCPU_INIT, 0xbea1bc74) = 0
ioctl(16, KVM_ARM_SET_DEVICE_ADDR or KVM_GET_ONE_REG, 0xbea1bc30) = 0
ioctl(16, KVM_ARM_SET_DEVICE_ADDR or KVM_GET_ONE_REG, 0xbea1bc30) = 0
ioctl(16, KVM_ARM_SET_DEVICE_ADDR or KVM_GET_ONE_REG, 0xbea1bc30) = 0
ioctl(16, KVM_ARM_SET_DEVICE_ADDR or KVM_GET_ONE_REG, 0xbea1bc30) = 0
ioctl(16, KVM_ARM_SET_DEVICE_ADDR or KVM_GET_ONE_REG, 0xbea1bc30) = 0
ioctl(16, KVM_ARM_SET_DEVICE_ADDR or KVM_GET_ONE_REG, 0xbea1bc30) = 0
ioctl(16, KVM_ARM_SET_DEVICE_ADDR or KVM_GET_ONE_REG, 0xbea1bc30) = 0
ioctl(16, KVM_ARM_SET_DEVICE_ADDR or KVM_GET_ONE_REG, 0xbea1bc30) = 0
ioctl(16, KVM_ARM_SET_DEVICE_ADDR or KVM_GET_ONE_REG, 0xbea1bc30) = -1
ENOENT (No such file or directory)
ioctl(16, KVM_ARM_SET_DEVICE_ADDR or KVM_GET_ONE_REG, 0xbea1bc30) = 0
ioctl(16, KVM_ARM_SET_DEVICE_ADDR or KVM_GET_ONE_REG, 0xbea1bc30) = 0

so I deduce that this is because the kernel doesn't support reading
ID_ISAR6.

Adding the following change allowed me to boot:

diff --git a/target/arm/kvm32.c b/target/arm/kvm32.c
index 8b2c9b3..2f7df81 100644
--- a/target/arm/kvm32.c
+++ b/target/arm/kvm32.c
@@ -84,9 +84,15 @@ bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
                           ARM_CP15_REG32(0, 0, 2, 4));
     err |= read_sys_reg32(fdarray[2], &ahcf->isar.id_isar5,
                           ARM_CP15_REG32(0, 0, 2, 5));
-    err |= read_sys_reg32(fdarray[2], &ahcf->isar.id_isar6,
-                          ARM_CP15_REG32(0, 0, 2, 7));
-
+    if (read_sys_reg32(fdarray[2], &ahcf->isar.id_isar6,
+                          ARM_CP15_REG32(0, 0, 2, 7))) {
+        /*
+         * Older kernels don't support reading ID_ISAR6. This register was
+         * only introduced in ARMv8, so we can assume that it is zero on a
+         * CPU that a kernel this old is running on.
+         */
+        ahcf->isar.id_isar6 = 0;
+    }
     err |= read_sys_reg32(fdarray[2], &ahcf->isar.mvfr0,
                           KVM_REG_ARM | KVM_REG_SIZE_U32 |
                           KVM_REG_ARM_VFP | KVM_REG_ARM_VFP_MVFR0);

thanks
-- PMM
