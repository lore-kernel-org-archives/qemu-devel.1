Received: from eggs.gnu.org ([2001:4830:134:3::10]:40807)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eJiNC-0003Et-6D
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 11:04:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eJiN8-0006b2-15
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 11:04:38 -0500
Received: from mail-ot0-x242.google.com ([2607:f8b0:4003:c0f::242]:35447)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eJiN7-0006ai-Te
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 11:04:33 -0500
Received: by mail-ot0-x242.google.com with SMTP id q3so302964oth.2
	for <qemu-devel@nongnu.org>; Tue, 28 Nov 2017 08:04:33 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1511883692-11511-5-git-send-email-eric.auger@redhat.com>
References: <1511883692-11511-1-git-send-email-eric.auger@redhat.com>
	<1511883692-11511-5-git-send-email-eric.auger@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Nov 2017 16:04:12 +0000
Message-ID: <CAFEAcA__YJ5KPMk-oo4OixQ21ssTiyNy1nnn+UqDLdzSNhVojQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v6 4/4] hw/intc/arm_gicv3_its: Implement
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

On 28 November 2017 at 15:41, Eric Auger <eric.auger@redhat.com> wrote:
> Voiding the ITS caches is not supposed to happen via
> individual register writes. So we introduced a dedicated
> ITS KVM device ioctl to perform a cold reset of the ITS:
> KVM_DEV_ARM_VGIC_GRP_CTRL/KVM_DEV_ARM_ITS_CTRL_RESET. Let's
> use this latter if the kernel supports it.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>  hw/intc/arm_gicv3_its_kvm.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/hw/intc/arm_gicv3_its_kvm.c b/hw/intc/arm_gicv3_its_kvm.c
> index 1c663ac..bf290b8 100644
> --- a/hw/intc/arm_gicv3_its_kvm.c
> +++ b/hw/intc/arm_gicv3_its_kvm.c
> @@ -204,7 +204,14 @@ static void kvm_arm_its_reset(DeviceState *dev)
>
>      c->parent_reset(dev);
>
> -    error_report("ITS KVM: full reset is not supported by QEMU");
> +    if (kvm_device_check_attr(s->dev_fd, KVM_DEV_ARM_VGIC_GRP_CTRL,
> +                               KVM_DEV_ARM_ITS_CTRL_RESET)) {
> +        kvm_device_access(s->dev_fd, KVM_DEV_ARM_VGIC_GRP_CTRL,
> +                          KVM_DEV_ARM_ITS_CTRL_RESET, NULL, true, &error_abort);
> +        return;
> +    }
> +
> +    error_report("ITS KVM: full reset is not supported by the host kernel");
>
>      if (!kvm_device_check_attr(s->dev_fd, KVM_DEV_ARM_VGIC_GRP_ITS_REGS,
>                                 GITS_CTLR)) {
> --

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
