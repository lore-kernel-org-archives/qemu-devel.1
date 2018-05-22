Received: from eggs.gnu.org ([2001:4830:134:3::10]:35737)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fL6UC-0001Iq-03
	for qemu-devel@nongnu.org; Tue, 22 May 2018 08:33:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fL6UB-0000tg-2i
	for qemu-devel@nongnu.org; Tue, 22 May 2018 08:33:52 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:32882)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fL6UA-0000tJ-Td
	for qemu-devel@nongnu.org; Tue, 22 May 2018 08:33:51 -0400
Received: by mail-oi0-x243.google.com with SMTP id k5-v6so16021643oiw.0
	for <qemu-devel@nongnu.org>; Tue, 22 May 2018 05:33:50 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1526222114-5324-3-git-send-email-eric.auger@redhat.com>
References: <1526222114-5324-1-git-send-email-eric.auger@redhat.com>
	<1526222114-5324-3-git-send-email-eric.auger@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 22 May 2018 13:33:29 +0100
Message-ID: <CAFEAcA8T0sQ_dZ7079WSx0FHp21F3xiWfNY6OFgO4Z0uBAPpLA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [RFC v2 2/7] target/arm: Allow KVM device address
 overwriting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Auger <eric.auger@redhat.com>
Cc: Eric Auger <eric.auger.pro@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Shannon Zhao <zhaoshenglong@huawei.com>, Christoffer Dall <christoffer.dall@arm.com>, Marc Zyngier <marc.zyngier@arm.com>, Andrew Jones <drjones@redhat.com>, Wei Huang <wei@redhat.com>

On 13 May 2018 at 15:35, Eric Auger <eric.auger@redhat.com> wrote:
> for KVM_VGIC_V3_ADDR_TYPE_REDIST_REGION attribute, the attribute
> data pointed to by kvm_device_attr.addr is a OR of the
> redistributor region address and other fields such as the index
> of the redistributor region and the number of redistributors the
> region can contain.
>
> The existing machine init done notifier framework sets the address
> field to the actual address of the device and does not allow to OR
> this value with other fields.
>
> This patch extends the KVMDevice struct with a new kda_addr_fixup
> member. Its value is passed at registration time and OR'ed with the
> resolved address on kvm_arm_set_device_addr().


> diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
> index 1e23640..4050017 100644
> --- a/target/arm/kvm_arm.h
> +++ b/target/arm/kvm_arm.h
> @@ -34,6 +34,7 @@ int kvm_arm_vcpu_init(CPUState *cs);
>   * @group: device control API group for setting addresses
>   * @attr: device control API address type
>   * @dev_fd: device control device file descriptor (or -1 if not supported)
> + * @addr_fixup: value to be OR'ed with resolved address

I think addr_fixup is a bit vague; how about
 addr_fixed_bits ?
(here and in the function argument name). Or something else if
somebody has a better idea.

>   *
>   * Remember the memory region @mr, and when it is mapped by the
>   * machine model, tell the kernel that base address using the
> @@ -45,7 +46,7 @@ int kvm_arm_vcpu_init(CPUState *cs);
>   * address at the point where machine init is complete.
>   */
>  void kvm_arm_register_device(MemoryRegion *mr, uint64_t devid, uint64_t group,
> -                             uint64_t attr, int dev_fd);
> +                             uint64_t attr, int dev_fd, uint64_t addr_fixup);
>
>  /**
>   * kvm_arm_init_cpreg_list:
> --
> 2.5.5

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
