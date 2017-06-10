Received: from eggs.gnu.org ([2001:4830:134:3::10]:36055)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dJc6q-0002Fx-2C
	for qemu-devel@nongnu.org; Sat, 10 Jun 2017 04:51:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dJc6l-0004uQ-Da
	for qemu-devel@nongnu.org; Sat, 10 Jun 2017 04:51:04 -0400
Received: from mail-wr0-x22c.google.com ([2a00:1450:400c:c0c::22c]:36591)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dJc6l-0004tS-2v
	for qemu-devel@nongnu.org; Sat, 10 Jun 2017 04:50:59 -0400
Received: by mail-wr0-x22c.google.com with SMTP id v111so52737825wrc.3
	for <qemu-devel@nongnu.org>; Sat, 10 Jun 2017 01:50:58 -0700 (PDT)
References: <20170609170100.3599-1-alex.bennee@linaro.org>
	<20170609170100.3599-4-alex.bennee@linaro.org>
	<fc351edb-7c08-c341-d8ee-85f6768e4931@twiddle.net>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <fc351edb-7c08-c341-d8ee-85f6768e4931@twiddle.net>
Date: Sat, 10 Jun 2017 09:51:26 +0100
Message-ID: <87vao4b4z5.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC DEBUG PATCH 3/3] translate-a64: fix
 lookup_tb_ptr hang (DEBUG!)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: peter.maydell@linaro.org, pbonzini@redhat.com, edgar.iglesias@xilinx.com, cota@braap.org, qemu-devel@nongnu.org, Peter Crosthwaite <crosthwaite.peter@gmail.com>, "open list:ARM" <qemu-arm@nongnu.org>


Richard Henderson <rth@twiddle.net> writes:

> On 06/09/2017 10:01 AM, Alex Bennée wrote:
>> THIS IS A DEBUG PATCH DO NOT MERGE
>>
>> I include all the comments to show my working. I was trying to
>> isolate which instructions cause the problem. It turns out it is the
>> RET instruction. I don't understand why because AFAICT it is a
>> pretty much a BR instruction.
>
> Yeah, same thing for Alpha.
>
> It has been my guess that not chaining through RET means that we get
> back to the main loop regularly and often, letting interrupts be
> recognized in a timely manner.
>
> I can't figure out why that would be, however, since interrupts
> *ought* to be setting icount_decr, and the TB to which we chain *is*
> checking that to return to the main loop.

Indeed - if that was broken a lot more stuff wouldn't work.

> Since changing the timing affects the outcome (e.g. -d exec), it
> follows that this *must* be some sort of race condition.  But since
> this still happens with single-threaded mode, I can't imagine what
> sort of race condition it might be.

Apart from timer expiry I can't think what other interactions the other
threads have on the main TCG thread. I guess there is IO but my test
hangs way before the kernel starts poking the disk. Is there an
interaction between IRQs and QEMU's serial driver?

>
> More data points.  I removed the tb_htable_lookup, and that by itself
> is enough to fix Alpha booting.  But it doesn't help the aarch64
> kernel+image that I have.  Which does still boot with -d nochain
> (which, along with disabling goto_tb chaining, also disables all
> goto_ptr).

I wonder what is different about your aarch64 image and mine then?
Because mine works just with suppressing the chaining for RET.

>
> Not really sure where to go from here.

I would agree with Emilio that we revert but I can't quite shake the
feeling we are missing an underlying problem. Would just skipping the
htable lookup (but keeping the tb_jmp_cache) be an OK fix for now? Have
we just been lucky that whatever mechanism causes the "hang" wasn't due
to?

>
>
> r~


--
Alex Bennée
