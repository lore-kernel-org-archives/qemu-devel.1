Received: from eggs.gnu.org ([2001:4830:134:3::10]:48552)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eIEED-0000f6-68
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 08:41:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eIEEC-00012Q-7y
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 08:41:13 -0500
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:36256)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eIEEC-000121-3G
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 08:41:12 -0500
Received: by mail-oi0-x243.google.com with SMTP id n16so15117099oig.3
	for <qemu-devel@nongnu.org>; Fri, 24 Nov 2017 05:41:11 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1511530238-18318-5-git-send-email-eric.auger@redhat.com>
References: <1511530238-18318-1-git-send-email-eric.auger@redhat.com>
	<1511530238-18318-5-git-send-email-eric.auger@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 24 Nov 2017 13:40:50 +0000
Message-ID: <CAFEAcA-m6gwgu90kUFa94ZPtKGpZLKUigJzc31SidMt-DTVpTA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v4 4/4] hw/intc/arm_gicv3_its: Implement
 full reset
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

On 24 November 2017 at 13:30, Eric Auger <eric.auger@redhat.com> wrote:
> Voiding the ITS caches is not supposed to happen via
> individual register writes. So we introduced a dedicated
> ITS KVM device ioctl to perform a cold reset of the ITS:
> KVM_DEV_ARM_VGIC_GRP_CTRL/KVM_DEV_ARM_ITS_CTRL_RESET. Let's
> use this latter if the kernel supports it.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>  hw/intc/arm_gicv3_its_kvm.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/hw/intc/arm_gicv3_its_kvm.c b/hw/intc/arm_gicv3_its_kvm.c
> index 83e5268..bad593f 100644
> --- a/hw/intc/arm_gicv3_its_kvm.c
> +++ b/hw/intc/arm_gicv3_its_kvm.c
> @@ -204,6 +204,13 @@ static void kvm_arm_its_reset(DeviceState *dev)
>
>      c->parent_reset(dev);
>
> +    if (kvm_device_check_attr(s->dev_fd, KVM_DEV_ARM_VGIC_GRP_CTRL,
> +                               KVM_DEV_ARM_ITS_CTRL_RESET)) {
> +        kvm_device_access(s->dev_fd, KVM_DEV_ARM_VGIC_GRP_CTRL,
> +                          KVM_DEV_ARM_ITS_CTRL_RESET, NULL, true, &error_abort);
> +        return;
> +    }
> +
>      error_report("ITS KVM: full reset is not supported by the host kernel");
>
>      if (!kvm_device_check_attr(s->dev_fd, KVM_DEV_ARM_VGIC_GRP_ITS_REGS,
> --
> 2.5.5

Ah, here's the check that makes the error message correct. If we're
applying the whole series at once, no big deal; but if we want to
put the earlier patches in 2.11 but not this one we need the
error message to be correct for the situation at that release.

thanks
-- PMM
