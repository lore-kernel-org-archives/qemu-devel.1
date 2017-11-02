Received: from eggs.gnu.org ([2001:4830:134:3::10]:46056)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eAF79-0003U2-EF
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 09:00:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eAF73-00053Y-F4
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 09:00:55 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:49265)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eAF73-000532-83
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 09:00:49 -0400
Received: by mail-wm0-x243.google.com with SMTP id b189so10843904wmd.4
	for <qemu-devel@nongnu.org>; Thu, 02 Nov 2017 06:00:49 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1508772937-21054-3-git-send-email-eric.auger@redhat.com>
References: <1508772937-21054-1-git-send-email-eric.auger@redhat.com>
	<1508772937-21054-3-git-send-email-eric.auger@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 2 Nov 2017 13:00:27 +0000
Message-ID: <CAFEAcA_QH_zzrzGteL-i-WUPMQa7OZhix8EqtkKNoTRL4iNQew@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [RFC v2 2/4] hw/intc/arm_gicv3_its: Implement a
 minimalist reset
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
> At the moment the ITS is not properly reset and this causes
> various bugs on save/restore. We implement a minimalist cold reset
> through individual register writes. This does not void the ITS cache
> though. This full reset will be addressed through a specific ioctl.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>

> diff --git a/hw/intc/arm_gicv3_its_kvm.c b/hw/intc/arm_gicv3_its_kvm.c
> index 1ae205f..537cea1 100644
> --- a/hw/intc/arm_gicv3_its_kvm.c
> +++ b/hw/intc/arm_gicv3_its_kvm.c
> @@ -28,6 +28,16 @@
>
>  #define TYPE_KVM_ARM_ITS "arm-its-kvm"
>  #define KVM_ARM_ITS(obj) OBJECT_CHECK(GICv3ITSState, (obj), TYPE_KVM_ARM_ITS)
> +#define KVM_ARM_ITS_CLASS(klass) \
> +     OBJECT_CLASS_CHECK(KVMARMITSClass, (klass), TYPE_KVM_ARM_ITS)
> +#define KVM_ARM_ITS_GET_CLASS(obj) \
> +     OBJECT_GET_CLASS(KVMARMITSClass, (obj), TYPE_KVM_ARM_ITS)
> +
> +typedef struct KVMARMITSClass {
> +    GICv3ITSCommonClass parent_class;
> +    void (*parent_reset)(DeviceState *dev);
> +} KVMARMITSClass;
> +

The infrastructure here for having a place to hang reset is
all fine, but it's a bit out of place because this patch doesn't
actually use any of it.

>  static int kvm_its_send_msi(GICv3ITSState *s, uint32_t value, uint16_t devid)
>  {
> @@ -153,12 +163,25 @@ static void kvm_arm_its_pre_save(GICv3ITSState *s)
>   */
>  static void kvm_arm_its_post_load(GICv3ITSState *s)
>  {
> +    bool cold_reset = !s->iidr;
>      int i;
>
> -    if (!s->iidr) {
> +    if (cold_reset) {
> +        kvm_device_access(s->dev_fd, KVM_DEV_ARM_VGIC_GRP_ITS_REGS,
> +                          GITS_CTLR, &s->ctlr, true, &error_abort);
> +
> +        kvm_device_access(s->dev_fd, KVM_DEV_ARM_VGIC_GRP_ITS_REGS,
> +                          GITS_CBASER, &s->cbaser, true, &error_abort);
> +
> +        for (i = 0; i < 8; i++) {
> +            kvm_device_access(s->dev_fd, KVM_DEV_ARM_VGIC_GRP_ITS_REGS,
> +                              GITS_BASER + i * 8, &s->baser[i], true,
> +                              &error_abort);
> +        }
>          return;
>      }

I don't understand why we need to treat the "iidr zero" case
differently here. Why can't we just restore the register state
like we do now? (Also, all resets in QEMU are cold resets,
and post_load isn't called for reset, so the flag naming is
a bit odd.)

(I don't understand why the code in master at the moment does
nothing for iidr == 0, for that matter. We should always tell
the kernel the state of the device regs.)

thanks
-- PMM
