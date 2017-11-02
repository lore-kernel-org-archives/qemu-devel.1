Received: from eggs.gnu.org ([2001:4830:134:3::10]:47663)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eAFBG-0004ZI-T6
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 09:05:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eAFBC-00005I-96
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 09:05:10 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:49339)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eAFBC-0008WG-2h
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 09:05:06 -0400
Received: by mail-wm0-x242.google.com with SMTP id b189so10872145wmd.4
	for <qemu-devel@nongnu.org>; Thu, 02 Nov 2017 06:05:05 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1508772937-21054-5-git-send-email-eric.auger@redhat.com>
References: <1508772937-21054-1-git-send-email-eric.auger@redhat.com>
	<1508772937-21054-5-git-send-email-eric.auger@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 2 Nov 2017 13:04:44 +0000
Message-ID: <CAFEAcA-ePpQn44zURCOyOV9cm6HAOD2YP4SLgWjkqzJErpEO5Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [RFC v2 4/4] hw/intc/arm_gicv3_its: Implement full
 reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, wanghaibin.wang@huawei.com, Vijay Kilari <vijay.kilari@gmail.com>, Andrew Jones <drjones@redhat.com>, Wei Huang <wei@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Christoffer Dall <christoffer.dall@linaro.org>, wu.wubin@huawei.com

On 23 October 2017 at 16:35, Eric Auger <eric.auger@redhat.com> wrote:
> Voiding the ITS caches is not supposed to happen via
> individual register writes. So we introduced a dedicated
> ITS KVM device ioctl to perform a cold reset of the ITS:
> KVM_DEV_ARM_VGIC_GRP_CTRL/KVM_DEV_ARM_ITS_CTRL_RESET. Let's
> use this latter if the kernel supports it.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>  hw/intc/arm_gicv3_its_kvm.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/hw/intc/arm_gicv3_its_kvm.c b/hw/intc/arm_gicv3_its_kvm.c
> index 537cea1..73e2530 100644
> --- a/hw/intc/arm_gicv3_its_kvm.c
> +++ b/hw/intc/arm_gicv3_its_kvm.c
> @@ -215,9 +215,19 @@ static void kvm_arm_its_post_load(GICv3ITSState *s)
>
>  static void kvm_arm_its_reset(DeviceState *dev)
>  {
> +    GICv3ITSState *s = ARM_GICV3_ITS_COMMON(dev);
>      KVMARMITSClass *c = KVM_ARM_ITS_GET_CLASS(s);
>
>      c->parent_reset(dev);
> +
> +    if (!kvm_device_check_attr(s->dev_fd, KVM_DEV_ARM_VGIC_GRP_CTRL,
> +                               KVM_DEV_ARM_ITS_CTRL_RESET)) {
> +        error_report("ITS KVM: reset is not supported by the kernel");

Best to say "host kernel" so users know we're not complaining about
the guest kernel.

> +        return;
> +    }
> +
> +    kvm_device_access(s->dev_fd, KVM_DEV_ARM_VGIC_GRP_CTRL,
> +                      KVM_DEV_ARM_ITS_CTRL_RESET, NULL, true, &error_abort);
>  }
>
>  static Property kvm_arm_its_props[] = {
> --

This would be the right patch for the boilerplate for adding
the parent class and hooking into the reset function chain.

thanks
-- PMM
