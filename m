Received: from eggs.gnu.org ([2001:4830:134:3::10]:56008)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eZhqm-00050G-DD
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 13:45:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eZhql-0006uv-F5
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 13:45:16 -0500
Received: from mail-ot0-x229.google.com ([2607:f8b0:4003:c0f::229]:43728)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eZhql-0006uc-BG
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 13:45:15 -0500
Received: by mail-ot0-x229.google.com with SMTP id t28so2943258oti.10
	for <qemu-devel@nongnu.org>; Thu, 11 Jan 2018 10:45:15 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171218173022.18418-8-richard.henderson@linaro.org>
References: <20171218173022.18418-1-richard.henderson@linaro.org>
	<20171218173022.18418-8-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 11 Jan 2018 18:44:54 +0000
Message-ID: <CAFEAcA9EZ0jY6tR2E7ZzfWnAfSJ3hjGNT7za+RZC-SGuBY6Hfg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 7/9] target/arm: Expand vector registers
 for SVE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On 18 December 2017 at 17:30, Richard Henderson
<richard.henderson@linaro.org> wrote:
> Change vfp.regs as a uint64_t to vfp.zregs as an ARMVectorReg.
> The previous patches have made the change in representation
> relatively painless.
>
> Add vfp.pregs as an ARMPredicateReg.  Let FFR be P16 to make
> it easier to treat it as for any other predicate.

> diff --git a/target/arm/machine.c b/target/arm/machine.c
> index a85c2430d3..39f3123b10 100644
> --- a/target/arm/machine.c
> +++ b/target/arm/machine.c
> @@ -50,7 +50,42 @@ static const VMStateDescription vmstate_vfp = {
>      .minimum_version_id = 3,
>      .needed = vfp_needed,
>      .fields = (VMStateField[]) {
> -        VMSTATE_UINT64_ARRAY(env.vfp.regs, ARMCPU, 64),
> +        /* For compatibility, store Qn out of Zn here.  */
> +        /* TODO: store the other quadwords in another subsection,
> +           along with predicate registers and ZCR_EL[1-3].  */

I think we should get the migration state stuff right at the point
where we change the data structure in cpu.h.


> +        VMSTATE_UINT64_SUB_ARRAY(env.vfp.zregs[0].d, ARMCPU, 0, 2),
> +        VMSTATE_UINT64_SUB_ARRAY(env.vfp.zregs[1].d, ARMCPU, 0, 2),
> +        VMSTATE_UINT64_SUB_ARRAY(env.vfp.zregs[2].d, ARMCPU, 0, 2),

David: does the migration code guarantee that we can split an
old VMSTATE_UINT64_ARRAY into being a sequence of SUB_ARRAYs
like this and retain the same on-the-wire format (ie and
keep migration compat) ?

I suspect we've used this clever trick before elsewhere, but thought
it better to check...

thanks
-- PMM
