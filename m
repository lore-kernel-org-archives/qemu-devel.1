Received: from eggs.gnu.org ([2001:4830:134:3::10]:47707)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dFjD8-0006Jw-OX
	for qemu-devel@nongnu.org; Tue, 30 May 2017 11:37:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dFjD7-0007PV-Vb
	for qemu-devel@nongnu.org; Tue, 30 May 2017 11:37:30 -0400
Received: from mail-wm0-x230.google.com ([2a00:1450:400c:c09::230]:37117)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dFjD7-0007PI-Nz
	for qemu-devel@nongnu.org; Tue, 30 May 2017 11:37:29 -0400
Received: by mail-wm0-x230.google.com with SMTP id d127so101406071wmf.0
	for <qemu-devel@nongnu.org>; Tue, 30 May 2017 08:37:29 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1495123889-32301-1-git-send-email-wei@redhat.com>
References: <1495123889-32301-1-git-send-email-wei@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 May 2017 16:37:07 +0100
Message-ID: <CAFEAcA_FiqcFz_8o-Mavgq8sfkr6dRv3fnRzytaQsr5pJ4Dagg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 1/1] target/arm: clear PMUVER field of
 AA64DFR0 when vPMU=off
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Huang <wei@redhat.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 18 May 2017 at 17:11, Wei Huang <wei@redhat.com> wrote:
> The PMUv3 driver of linux kernel (in arch/arm64/kernel/perf_event.c)
> relies on the PMUVER field of id_aa64dfr0_el1 to decide if PMU support
> is present or not. This patch clears the PMUVER field under TCG mode
> when vPMU=off. Without it, PMUv3 will init insider guest VMs even
> with vPMU=off. This patch also removes a redundant line inside the
> if-statement.
>
> Signed-off-by: Wei Huang <wei@redhat.com>
> ---
>  target/arm/cpu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index c185eb1..4e8fe1c 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -750,8 +750,8 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
>      }
>
>      if (!cpu->has_pmu) {
> -        cpu->has_pmu = false;
>          unset_feature(env, ARM_FEATURE_PMU);
> +        cpu->id_aa64dfr0 &= ~0xf00;
>      }
>
>      if (!arm_feature(env, ARM_FEATURE_EL2)) {
> --
> 1.8.3.1



Applied to target-arm.next, thanks.

-- PMM
