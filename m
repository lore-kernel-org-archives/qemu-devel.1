Received: from eggs.gnu.org ([2001:4830:134:3::10]:33350)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cTU8f-0004Ek-2y
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 08:49:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cTU8e-0003bZ-Cj
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 08:49:29 -0500
Received: from mail-vk0-x232.google.com ([2607:f8b0:400c:c05::232]:36713)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cTU8e-0003ah-89
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 08:49:28 -0500
Received: by mail-vk0-x232.google.com with SMTP id t8so92339517vke.3
	for <qemu-devel@nongnu.org>; Tue, 17 Jan 2017 05:49:28 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1484204658-28058-5-git-send-email-wei@redhat.com>
References: <1484204658-28058-1-git-send-email-wei@redhat.com>
	<1484204658-28058-5-git-send-email-wei@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 17 Jan 2017 13:49:07 +0000
Message-ID: <CAFEAcA8Scivg0rd9+vUpXAuT-NDAwsD92pn9X9jxm5rNw49Jpw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH V1 4/4] target-arm: Hook up TCG vPMU with
 CPU pmu option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Huang <wei@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On 12 January 2017 at 07:04, Wei Huang <wei@redhat.com> wrote:
> Remove the checking of kvm_enabled(). With this, .pmu option can also
> control vPMU under TCG mode.
>
> Signed-off-by: Wei Huang <wei@redhat.com>
> ---
>  target/arm/cpu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index f5cb30a..2f87a4b 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -692,7 +692,7 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
>          cpu->id_aa64pfr0 &= ~0xf000;
>      }
>
> -    if (!cpu->has_pmu || !kvm_enabled()) {
> +    if (!cpu->has_pmu) {
>          cpu->has_pmu = false;
>          unset_feature(env, ARM_FEATURE_PMU);
>      }

I notice that the ARM_FEATURE_PMU bit doesn't seem to control whether
we actually provide the TCG PMU registers, so this patch is OK but
doesn't actually change the behaviour of the emulated cpu AFAICT.

Don't we now need to remove the hack where we mask out the PMUVer field
of ID_AA64DFR1_EL1 ?

thanks
-- PMM
