Received: from eggs.gnu.org ([2001:4830:134:3::10]:52458)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e5ywM-0008QK-Cj
	for qemu-devel@nongnu.org; Sat, 21 Oct 2017 14:56:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e5ywI-0001WM-G5
	for qemu-devel@nongnu.org; Sat, 21 Oct 2017 14:56:10 -0400
Received: from mail-pg0-x22a.google.com ([2607:f8b0:400e:c05::22a]:56251)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e5ywI-0001Uz-9Y
	for qemu-devel@nongnu.org; Sat, 21 Oct 2017 14:56:06 -0400
Received: by mail-pg0-x22a.google.com with SMTP id 15so4247018pgc.12
	for <qemu-devel@nongnu.org>; Sat, 21 Oct 2017 11:56:05 -0700 (PDT)
References: <1508522170-22539-1-git-send-email-peter.maydell@linaro.org>
	<19d12a08-9ecd-8c91-4652-28773ca35d8e@twiddle.net>
	<CAFEAcA_HWF_TD190CSVNbgeu-NGrzWsJmFN_u97CRNA8y-yW0w@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <b96c8607-8c7e-a403-d4e7-9e864dd4c6b7@linaro.org>
Date: Sat, 21 Oct 2017 11:56:01 -0700
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_HWF_TD190CSVNbgeu-NGrzWsJmFN_u97CRNA8y-yW0w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <rth@twiddle.net>
Cc: Christophe Lyon <christophe.lyon@linaro.org>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>

On 10/21/2017 03:17 AM, Peter Maydell wrote:
>>> -        gen_aa32_frob64(s, o64);
>>> +        if (s->be_data) {
>>> +            tcg_gen_rotri_i64(o64, o64, 32);
>>> +        }
>>>          tcg_gen_setcond_i64(TCG_COND_NE, o64, o64, cpu_exclusive_val);
>>
>> We're not splitting o64 to parts.  Are you sure it shouldn't stay as frob?
> 
> This is confusing, but I don't think frob is right. We want to
> be matching either (a) the transformation we just did to produce
> the 64 bit data we're storing, or (b) the transformation we
> do on the ldrexd, don't we? Neither of those is frob.
> 
> I think I need to think through a bit more carefully about
> what's actually going on here, since we seem to have the
> value in two places (actual memory, and the cpu_exclusive_val
> TCGv.)

We should match what we do in ldrexd, I think.  Which is just a straight BE
load.  So I guess the frob64 should be dropped and nothing should replace it.


r~
