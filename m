Received: from eggs.gnu.org ([209.51.188.92]:48322)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1guLwT-0005yX-Of
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 13:41:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1guLwS-0003UK-SP
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 13:41:01 -0500
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329]:41009)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1guLwS-0003Tp-Km
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 13:41:00 -0500
Received: by mail-ot1-x329.google.com with SMTP id u16so12214818otk.8
	for <qemu-devel@nongnu.org>; Thu, 14 Feb 2019 10:41:00 -0800 (PST)
MIME-Version: 1.0
References: <1547830785-7079-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1547830785-7079-8-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1547830785-7079-8-git-send-email-aleksandar.markovic@rt-rk.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 14 Feb 2019 18:40:48 +0000
Message-ID: <CAFEAcA8gk8MsDoHA5mzO0q16odQs-++rY=QbjZu=dkC+=5OjFg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v2 07/12] target/mips: Update ITU to utilize
 SAARI and SAAR CP0 registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Aleksandar Markovic <amarkovic@wavecomp.com>

On Fri, 18 Jan 2019 at 16:59, Aleksandar Markovic
<aleksandar.markovic@rt-rk.com> wrote:
>
> From: Yongbok Kim <yongbok.kim@mips.com>
>
> Update ITU to utilize SAARI and SAAR CP0 registers.

Hi; Coverity complains (CID 1398648) about this bit of code:

> -static void itc_reconfigure(MIPSITUState *tag)
> +void itc_reconfigure(MIPSITUState *tag)
>  {
>      uint64_t *am = &tag->ITCAddressMap[0];
>      MemoryRegion *mr = &tag->storage_io;
> @@ -92,6 +92,12 @@ static void itc_reconfigure(MIPSITUState *tag)
>      uint64_t size = (1 * KiB) + (am[1] & ITC_AM1_ADDR_MASK_MASK);
>      bool is_enabled = (am[0] & ITC_AM0_EN_MASK) != 0;
>
> +    if (tag->saar_present) {
> +        address = ((*(uint64_t *) tag->saar) & 0xFFFFFFFFE000ULL) << 4;
> +        size = 1 << ((*(uint64_t *) tag->saar >> 1) & 0x1f);
> +        is_enabled = *(uint64_t *) tag->saar & 1;
> +    }
> +

because the "1 << ..." calculation of size is done as a 32-bit
signed integer which may then be unintentionally sign-extended
into the 64-bit result. Using "1ULL" instead of "1" on the LHS
of the shift would fix this.

thanks
-- PMM
