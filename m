Received: from eggs.gnu.org ([2001:4830:134:3::10]:35281)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e5qr2-0003So-Rs
	for qemu-devel@nongnu.org; Sat, 21 Oct 2017 06:18:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e5qr1-0007QG-LY
	for qemu-devel@nongnu.org; Sat, 21 Oct 2017 06:18:08 -0400
Received: from mail-wm0-x232.google.com ([2a00:1450:400c:c09::232]:52234)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e5qr1-0007OE-FL
	for qemu-devel@nongnu.org; Sat, 21 Oct 2017 06:18:07 -0400
Received: by mail-wm0-x232.google.com with SMTP id k4so1876189wmc.1
	for <qemu-devel@nongnu.org>; Sat, 21 Oct 2017 03:18:07 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <19d12a08-9ecd-8c91-4652-28773ca35d8e@twiddle.net>
References: <1508522170-22539-1-git-send-email-peter.maydell@linaro.org>
	<19d12a08-9ecd-8c91-4652-28773ca35d8e@twiddle.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 21 Oct 2017 11:17:45 +0100
Message-ID: <CAFEAcA_HWF_TD190CSVNbgeu-NGrzWsJmFN_u97CRNA8y-yW0w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] translate.c: Fix usermode big-endian
 AArch32 LDREXD and STREXD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, Christophe Lyon <christophe.lyon@linaro.org>

On 20 October 2017 at 19:15, Richard Henderson <rth@twiddle.net> wrote:
> On 10/20/2017 10:56 AM, Peter Maydell wrote:
>> +        if (s->be_data) {
>> +            tcg_gen_extr_i64_i32(tmp2, tmp, t64);
>> +        } else {
>> +            tcg_gen_extr_i64_i32(tmp, tmp2, t64);
>> +        }
>
> The test against be_data must be of the form s->be_data == MO_BE/LE.
>
> The actual bits have MO_BSWAP non-zero, and then set MO_BE/LE to either 0 or
> MO_BSWAP depending on the host endianness.

Oops, yes.

>> -        gen_aa32_frob64(s, o64);
>> +        if (s->be_data) {
>> +            tcg_gen_rotri_i64(o64, o64, 32);
>> +        }
>>          tcg_gen_setcond_i64(TCG_COND_NE, o64, o64, cpu_exclusive_val);
>
> We're not splitting o64 to parts.  Are you sure it shouldn't stay as frob?

This is confusing, but I don't think frob is right. We want to
be matching either (a) the transformation we just did to produce
the 64 bit data we're storing, or (b) the transformation we
do on the ldrexd, don't we? Neither of those is frob.

I think I need to think through a bit more carefully about
what's actually going on here, since we seem to have the
value in two places (actual memory, and the cpu_exclusive_val
TCGv.)

thanks
-- PMM
