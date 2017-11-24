Received: from eggs.gnu.org ([2001:4830:134:3::10]:48706)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eIEEU-0000uc-Qt
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 08:41:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eIEEU-0001Ec-0z
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 08:41:30 -0500
Received: from mail-ot0-x243.google.com ([2607:f8b0:4003:c0f::243]:37390)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eIEET-0001E2-T1
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 08:41:29 -0500
Received: by mail-ot0-x243.google.com with SMTP id s4so18815548ote.4
	for <qemu-devel@nongnu.org>; Fri, 24 Nov 2017 05:41:29 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1511530238-18318-2-git-send-email-eric.auger@redhat.com>
References: <1511530238-18318-1-git-send-email-eric.auger@redhat.com>
	<1511530238-18318-2-git-send-email-eric.auger@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 24 Nov 2017 13:41:08 +0000
Message-ID: <CAFEAcA_54_CVmkNM=4ufFJzYT5hWhgcfjt6wGFsuVBJnnC0+4Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v4 1/4] hw/intc/arm_gicv3_its: Don't call
 post_load on reset
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
> From the very beginning, post_load() was called from common
> reset. This is not standard and obliged to discriminate the
> reset case from the restore case using the iidr value.
>
> Let's get rid of that call.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>  hw/intc/arm_gicv3_its_common.c | 2 --
>  hw/intc/arm_gicv3_its_kvm.c    | 4 ----
>  2 files changed, 6 deletions(-)
>
> diff --git a/hw/intc/arm_gicv3_its_common.c b/hw/intc/arm_gicv3_its_common.c
> index f2cce59..2bd2f0f 100644
> --- a/hw/intc/arm_gicv3_its_common.c
> +++ b/hw/intc/arm_gicv3_its_common.c
> @@ -131,8 +131,6 @@ static void gicv3_its_common_reset(DeviceState *dev)
>      s->creadr = 0;
>      s->iidr = 0;
>      memset(&s->baser, 0, sizeof(s->baser));
> -
> -    gicv3_its_post_load(s, 0);
>  }
>
>  static void gicv3_its_common_class_init(ObjectClass *klass, void *data)
> diff --git a/hw/intc/arm_gicv3_its_kvm.c b/hw/intc/arm_gicv3_its_kvm.c
> index 6fb45df..b1b322b 100644
> --- a/hw/intc/arm_gicv3_its_kvm.c
> +++ b/hw/intc/arm_gicv3_its_kvm.c
> @@ -155,10 +155,6 @@ static void kvm_arm_its_post_load(GICv3ITSState *s)
>  {
>      int i;
>
> -    if (!s->iidr) {
> -        return;
> -    }
> -
>      kvm_device_access(s->dev_fd, KVM_DEV_ARM_VGIC_GRP_ITS_REGS,
>                        GITS_IIDR, &s->iidr, true, &error_abort);
>
> --

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
