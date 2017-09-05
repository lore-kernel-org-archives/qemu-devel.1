Received: from eggs.gnu.org ([2001:4830:134:3::10]:55569)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dpGsx-0000Aa-SK
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 12:39:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dpGss-0007dD-R8
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 12:39:35 -0400
Received: from mail-wr0-x235.google.com ([2a00:1450:400c:c0c::235]:32786)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dpGss-0007ch-Kg
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 12:39:30 -0400
Received: by mail-wr0-x235.google.com with SMTP id a43so9928677wrc.0
	for <qemu-devel@nongnu.org>; Tue, 05 Sep 2017 09:39:30 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <93e924b9-e8db-124b-8a17-a16f6abf5e0a@linaro.org>
References: <1503414539-28762-1-git-send-email-peter.maydell@linaro.org>
	<1503414539-28762-17-git-send-email-peter.maydell@linaro.org>
	<93e924b9-e8db-124b-8a17-a16f6abf5e0a@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 5 Sep 2017 17:39:08 +0100
Message-ID: <CAFEAcA82DLRjLaO=5TDdo7KXw9vYKnO=suz+9hBFLgEkzefc_g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 16/20] target/arm: Make CCR register banked
 for v8M
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>

On 29 August 2017 at 17:08, Richard Henderson
<richard.henderson@linaro.org> wrote:
> On 08/22/2017 08:08 AM, Peter Maydell wrote:
>> +        if (attrs.secure) {
>> +            /* the BFHFNMIGN bit is not banked; keep that in the NS copy */
>> +            int new_bfhnmign = !!(value & R_V7M_CCR_BFHFNMIGN_MASK);
>> +
>> +            cpu->env.v7m.ccr[M_REG_NS] = deposit32(cpu->env.v7m.ccr[M_REG_NS],
>> +                                                    R_V7M_CCR_BFHFNMIGN_SHIFT,
>> +                                                    R_V7M_CCR_BFHFNMIGN_LENGTH,
>> +                                                    new_bfhnmign);
>> +            value &= ~R_V7M_CCR_BFHFNMIGN_MASK;
>> +        }
>
> No need to extract and then redeposit, just use the mask.
>
>     cpu->env.v7m.ccr[M_REG_NS] =
>       (cpu->env.v7m.ccr[M_REG_NS] & ~R_V7M_CCR_BFHFNMIGN_MASK)
>       | (value & R_V7M_CCR_BFHFNMIGN_MASK);

Mmm. This is one of the operations that deposit/extract aren't
too wonderful for. I don't generally like direct messing with
bit operations, I think they're harder to read, but there's not
much in it here so I'll go with your version.

thanks
-- PMM
