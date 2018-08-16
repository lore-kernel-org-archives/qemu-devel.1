Received: from eggs.gnu.org ([2001:4830:134:3::10]:34165)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fqLOr-0006gV-FT
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 12:45:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fqLOn-000286-Gy
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 12:45:28 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:46246)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fqLOm-00022j-Hc
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 12:45:25 -0400
Received: by mail-oi0-x242.google.com with SMTP id y207-v6so9136709oie.13
	for <qemu-devel@nongnu.org>; Thu, 16 Aug 2018 09:45:21 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1531969910-32843-1-git-send-email-jia.he@hxt-semitech.com>
References: <1531969910-32843-1-git-send-email-jia.he@hxt-semitech.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 Aug 2018 17:45:00 +0100
Message-ID: <CAFEAcA8a1z2DXRQwdR1+Dtdu5uGdypYa7TR_gGq0v3hd02X-1A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] hw/intc/arm_gicv3_its: downgrade
 error_report to warn_report in kvm_arm_its_reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jia He <hejianet@gmail.com>
Cc: Eric Auger <eric.auger@redhat.com>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Jia He <jia.he@hxt-semitech.com>

On 19 July 2018 at 04:11, Jia He <hejianet@gmail.com> wrote:
> In scripts/arch-run.bash of kvm-unit-tests, it will check the qemu
> output log with:
> if [ -z "$(echo "$errors" | grep -vi warning)" ]; then
>
> Thus without the warning prefix, all of the test fail.
>
> Since it is not unrecoverable error in kvm_arm_its_reset for
> current implementation, downgrading the report from error to
> warn makes sense.
>
> Signed-off-by: Jia He <jia.he@hxt-semitech.com>
> ---
>  hw/intc/arm_gicv3_its_kvm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/intc/arm_gicv3_its_kvm.c b/hw/intc/arm_gicv3_its_kvm.c
> index 271ebe4..01573ab 100644
> --- a/hw/intc/arm_gicv3_its_kvm.c
> +++ b/hw/intc/arm_gicv3_its_kvm.c
> @@ -211,7 +211,7 @@ static void kvm_arm_its_reset(DeviceState *dev)
>          return;
>      }
>
> -    error_report("ITS KVM: full reset is not supported by the host kernel");
> +    warn_report("ITS KVM: full reset is not supported by the host kernel");
>
>      if (!kvm_device_check_attr(s->dev_fd, KVM_DEV_ARM_VGIC_GRP_ITS_REGS,
>                                 GITS_CTLR)) {

Applied to target-arm.next, thanks.

(I'm still not entirely sure of our warn-vs-error criteria, but
I guess since we don't actually bail out of QEMU here it's more
of a warning than an error.)

-- PMM
