Received: from eggs.gnu.org ([209.51.188.92]:59822)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hBcWD-0003C3-0Z
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 05:49:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hBcWB-0003Ud-QL
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 05:49:16 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:34198)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hBcWB-0003SN-Eg
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 05:49:15 -0400
Received: by mail-pg1-x543.google.com with SMTP id v12so8065060pgq.1
	for <qemu-devel@nongnu.org>; Wed, 03 Apr 2019 02:49:15 -0700 (PDT)
References: <1554218121-26766-1-git-send-email-mateja.marjanovic@rt-rk.com>
	<1554218121-26766-3-git-send-email-mateja.marjanovic@rt-rk.com>
	<CAL1e-=hG_3htcguRp11NGx3pZP5QY8V6r1kYONYxbcE+NkmQ8Q@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <92db38b6-176b-7cbe-b546-242c926d6bf4@linaro.org>
Date: Wed, 3 Apr 2019 16:49:06 +0700
MIME-Version: 1.0
In-Reply-To: <CAL1e-=hG_3htcguRp11NGx3pZP5QY8V6r1kYONYxbcE+NkmQ8Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v5 2/2] target/mips: Optimize
 ILVEV.<B|H|W|D> MSA instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>, Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
Cc: amarkovic@wavecomp.com, qemu-devel@nongnu.org, aurelien@aurel32.net, arikalo@wavecomp.com

On 4/3/19 6:25 AM, Aleksandar Markovic wrote:
> 
> On Apr 2, 2019 5:20 PM, "Mateja Marjanovic" <mateja.marjanovic@rt-rk.com
> <mailto:mateja.marjanovic@rt-rk.com>> wrote:
>>
>> From: Mateja Marjanovic <Mateja.Marjanovic@rt-rk.com
> <mailto:Mateja.Marjanovic@rt-rk.com>>
>>
>> Optimize set of MSA instructions ILVEV, using directly
> 
> Use full instruction names, with the only exception of possible Bachus-Naur
> forms... again.
> 
>> tcg registers and performing logic on them instead of
>> using helpers.
>>
>> In the following table, the first column is the performance
>> before this patch. The second represents the performance,
>> after converting from helpers to tcg, but without using
>> tcg_gen_deposit function. The third one is the solution
>> which is implemented in this patch.
>>
>>  instr    ||   before    || no-deposit ||  with-deposit
>> ========================================================
>>  ilvev.b  ||  126.92 ms  ||  24.52 ms  ||  24.43 ms
>>  ilvev.h  ||   93.67 ms  ||  23.92 ms  ||  23.86 ms
>>  ilvev.w  ||  117.86 ms  ||  23.83 ms  ||  22.17 ms
>>  ilvev.d  ||   45.49 ms  ||  19.74 ms  ||  19.71 ms
>>
>> The solution with deposit is suggested by Richard Henderson.
>>
>> Signed-off-by: Mateja Marjanovic <mateja.marjanovic@rt-rk.com
> <mailto:mateja.marjanovic@rt-rk.com>>
>> ---
> 
> The byte and halfword cases of this patch most likely produce highly
> unoptimized code for cases:
> 
> wd == wt == ws
> wd == wt != ws
> wd != ws == wt
> wd == ws != wt
> 
> Please take these cases into account.

I beg to differ.  We want to minimize the amount of special cases.

If you multiply the different cases like this you also multiply the maintenance
overhead.  You force future maintainers to wonder if the cases are truly
distinct or if they are mere optimization.

The only special cases that I advocate that you add are driven by standard
macros that the assembler generates -- e.g. register move (via or), register
negate (via nor), etc.


r~
