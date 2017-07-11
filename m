Received: from eggs.gnu.org ([2001:4830:134:3::10]:55625)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dUsCZ-00028k-9Q
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 06:15:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dUsCU-0000GS-UV
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 06:15:31 -0400
Received: from mail-wr0-f177.google.com ([209.85.128.177]:33450)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dUsCU-0000GM-NR
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 06:15:26 -0400
Received: by mail-wr0-f177.google.com with SMTP id r103so176640128wrb.0
	for <qemu-devel@nongnu.org>; Tue, 11 Jul 2017 03:15:26 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170711100334.GA25504@toto>
References: <1498830302-19274-1-git-send-email-edgar.iglesias@gmail.com>
	<1498830302-19274-3-git-send-email-edgar.iglesias@gmail.com>
	<CAFEAcA-dssYnbZjuWTjBta1aK3iL3pyRKh5Qs4hFh=bPONgnTA@mail.gmail.com>
	<20170711100334.GA25504@toto>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 11 Jul 2017 11:14:04 +0100
Message-ID: <CAFEAcA_XTrkAN1ATpp6DLZqGh4aL1gECzQGyubJmoGjtw_pPbA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v1 2/2] target-arm: Extend PAR format
 determination
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, qemu-arm <qemu-arm@nongnu.org>

On 11 July 2017 at 11:03, Edgar E. Iglesias <edgar.iglesias@xilinx.com> wrote:
> On Mon, Jul 10, 2017 at 04:11:29PM +0100, Peter Maydell wrote:
>> So this kind of worries me, because what it's coded as is "determine
>> whether architecturally we should be returning a 64-bit or 32-bit
>> PAR format", but what the code below it uses the format64 flag for is
>> "manipulate whatever PAR we got handed back by get_phys_addr()".
>> So we have two separate bits of code that are both choosing
>> 32 vs 64 bit PAR (the code in this patch, and the logic inside
>> get_phys_addr()), and they have to come to the same conclusion
>> or we'll silently mangle the PAR. It seems like it would be
>> better to either have get_phys_addr() explicitly tell us what kind
>> of format it is returning to us, or to have the caller tell it
>> what kind of PAR it needs.
>
> Yes, I see your point and that's exactly what's happenning before the patch.
> Some of these new checks are generic in the sense that they check for LPAE/64bitness
> but others are I guess ATS specific for lack of a better term.
> It feels a bit weird to put the ATS specific PAR format logic into get_phys_addr.
>
> The basic idea here is that we never downgrade to the 32bit format, we only uprgade.
> The following line was meant to get the initial format I think you are requesting:
> format64 = regime_using_lpae_format(env, mmu_idx);
>
> After that, we apply possible ATS specfic upgrades to 64bit PAR format if needed.
>
> For clarity, perhaps we could make get_phys_addr return this same initial format, and then
> we can follow up with the ATS specific upgrades. E.g:
>
>     ret = get_phys_addr(env, value, access_type, mmu_idx,
>                         &phys_addr, &attrs, &prot, &page_size, &fsr, &fi,
>                         &format64);
>
>     /* Apply possible ATS/PAR 64bit upgrades if format64 is false.  */
>     if (is_a64(env)) {
>         format64 = true;
>     } else if (arm_feature(env, ARM_FEATURE_LPAE)) {
>         if (arm_feature(env, ARM_FEATURE_EL2)) {
>             if (mmu_idx == ARMMMUIdx_S12NSE0 || mmu_idx == ARMMMUIdx_S12NSE1) {
>                 format64 |= env->cp15.hcr_el2 & HCR_VM;
>             } else {
>                 format64 |= arm_current_el(env) == 2;
>             }
>         }
>     }

This still has the same problem, doesn't it? If get_phys_addr()
has given you back a short-descriptor format PAR then you cannot
simply "upgrade" it to a long-descriptor format PAR -- the
fault status codes are all different. I think the "short desc
vs long desc" condition used to be simple but the various
upgrades to get_phys_addr() to handle EL2 have made it much
more complicated, and so we'll be much better off just handing
get_phys_addr() a flag to say how we want the status reported,
if it's really dependent on ATS vs not-ATS.

thanks
-- PMM
