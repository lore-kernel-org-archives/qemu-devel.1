Received: from eggs.gnu.org ([208.118.235.92]:54056)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gdLDA-0003qB-Kx
	for qemu-devel@nongnu.org; Sat, 29 Dec 2018 15:27:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gdL9s-0003Q0-7p
	for qemu-devel@nongnu.org; Sat, 29 Dec 2018 15:24:35 -0500
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532]:44137)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gdL9s-0003OY-1T
	for qemu-devel@nongnu.org; Sat, 29 Dec 2018 15:24:32 -0500
Received: by mail-pg1-x532.google.com with SMTP id t13so11336597pgr.11
	for <qemu-devel@nongnu.org>; Sat, 29 Dec 2018 12:24:31 -0800 (PST)
References: <CAObpvQ=1dw4pTX3aiDvOvgnAkZQ0d9svMaL4Bwz55nkE8i4yrQ@mail.gmail.com>
	<945511ac-d99a-d483-12a2-e6ad4dda09c2@linaro.org>
	<CAObpvQktCHp-9V40z7kDaTU2CwRWSq8ZVS1PxRg3WK01TFXCzQ@mail.gmail.com>
	<b4cdc06a-8114-48d2-2c0a-9fea876fee4a@linaro.org>
	<CAObpvQmejWBh+RNz2vhk16-kcY_QveM_pSmM5ZeWqWv1d8AJzQ@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <aeeb8c50-0293-e37b-9f9f-5d392b7e10f6@linaro.org>
Date: Sun, 30 Dec 2018 07:24:23 +1100
MIME-Version: 1.0
In-Reply-To: <CAObpvQmejWBh+RNz2vhk16-kcY_QveM_pSmM5ZeWqWv1d8AJzQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] AVX support for TCG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nick Renieris <makren67@gmail.com>
Cc: qemu-devel@nongnu.org

On 12/29/18 12:43 AM, Nick Renieris wrote:
>>> Do you think this could work as a GSoC project? I'm potentially
>>> interested in working on it this summer.
> 
>> Could be.  My first guess is something like 4 months work for this.
> 
> Four months full-time? If so I would say it's not viable for a GSoC
> project (it's 3 months), I've done the 12-hours-a-day-crunch thing for
> a week or so in GSoC 2017 and it was _not_ fun.
> Also, I hope you meant four months for me, not for you - I'm
> completely new to the QEMU codebase. I expect it will take me weeks
> just to understand x86's 'translate.c' (who thought it'd be a good
> idea to put all this stuff in _one_ file?).

I did have a beginner in mind when guessing 4 months.  Don't take that as a
fully speced out answer, but it may well be that full avx2 support cannot be
done within the 3 months of gsoc.  I would certainly expect avx512 to take even
longer.

> Another question, are there existing discussions about this
> refactoring effort or specifically AVX? I asked a similar question on
> IRC a few days ago and got no answers.

Not that I recall.  I have some code at

https://github.com/rth7680/qemu/commits/i386-avx

that attempts to remove the sse_op_table(s).  However, it also splits up the
sse operations into units of uint64_t.  Which seemed sort of reasonable at the
time, considering that a lot of sse is 2*mmx.

But in the intervening 2.5 years since I worked on that branch, we have learned
that calls to helpers dominate.  It's better to have a single call that does 4x
the work than 4 separate calls.

The tcg-op-gvec.h infrastructure allows for the different modes that avx+mmx
allows:

(1) 64-bit operations,
(2) 128-bit operations, modifying only the low 128 bits,
(3) 128-bit operations, zeroing bits beyond the first 128,
(4) N*128-bit operations, zeroing bits beyond the first N*128.

so we should not need a great proliferation of helper functions, merely a
re-organization of what we have now.


r~
