Received: from eggs.gnu.org ([2001:4830:134:3::10]:46503)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eIE8R-00057c-2t
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 08:35:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eIE8P-0005Wo-Qv
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 08:35:14 -0500
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:35556)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eIE8P-0005Vg-Ly
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 08:35:13 -0500
Received: by mail-ot0-x244.google.com with SMTP id b17so18790885oth.2
	for <qemu-devel@nongnu.org>; Fri, 24 Nov 2017 05:35:13 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1511530238-18318-3-git-send-email-eric.auger@redhat.com>
References: <1511530238-18318-1-git-send-email-eric.auger@redhat.com>
	<1511530238-18318-3-git-send-email-eric.auger@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 24 Nov 2017 13:34:52 +0000
Message-ID: <CAFEAcA-7s8D1mts4LG81DoRM6x-wwT3mOPTcZJJ+EKi72tCjJw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v4 2/4] hw/intc/arm_gicv3_its: Implement a
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

On 24 November 2017 at 13:30, Eric Auger <eric.auger@redhat.com> wrote:
> At the moment the ITS is not properly reset and this causes
> various bugs on save/restore. We implement a minimalist reset
> through individual register writes but for kernel versions
> before v4.15 this fails voiding the vITS cache. We cannot
> claim we have a comprehensive reset (hence the error message)
> but that's better than nothing.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>
> ---
>
> v2 -> v3:
> - individual register writes performed in kvm_arm_its_reset
> - check KVM_DEV_ARM_VGIC_GRP_ITS_REGS support
> ---
>  hw/intc/arm_gicv3_its_kvm.c | 41 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
>
> diff --git a/hw/intc/arm_gicv3_its_kvm.c b/hw/intc/arm_gicv3_its_kvm.c
> index b1b322b..83e5268 100644
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
>
>  static int kvm_its_send_msi(GICv3ITSState *s, uint32_t value, uint16_t devid)
>  {
> @@ -186,6 +196,34 @@ static void kvm_arm_its_post_load(GICv3ITSState *s)
>                        GITS_CTLR, &s->ctlr, true, &error_abort);
>  }
>
> +static void kvm_arm_its_reset(DeviceState *dev)
> +{
> +    GICv3ITSState *s = ARM_GICV3_ITS_COMMON(dev);
> +    KVMARMITSClass *c = KVM_ARM_ITS_GET_CLASS(s);
> +    int i;
> +
> +    c->parent_reset(dev);
> +
> +    error_report("ITS KVM: full reset is not supported by the host kernel");

This message claims that we have a problem because of the host
kernel version, but I can't see where we do the check on the
host kernel that lets us avoid the error message when it's
new enough ?

thanks
-- PMM
