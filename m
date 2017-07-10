Received: from eggs.gnu.org ([2001:4830:134:3::10]:57809)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dUdQG-0002x7-Fo
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 14:28:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dUdQD-0002aa-9m
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 14:28:40 -0400
Received: from mail-wr0-x22d.google.com ([2a00:1450:400c:c0c::22d]:34914)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dUdQD-0002aJ-1U
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 14:28:37 -0400
Received: by mail-wr0-x22d.google.com with SMTP id k67so149394265wrc.2
	for <qemu-devel@nongnu.org>; Mon, 10 Jul 2017 11:28:36 -0700 (PDT)
References: <20170710142850.10468-1-alex.bennee@linaro.org>
	<1e34d387-753b-14ff-dcc0-226515ff0124@twiddle.net>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <1e34d387-753b-14ff-dcc0-226515ff0124@twiddle.net>
Date: Mon, 10 Jul 2017 19:28:34 +0100
Message-ID: <87o9ss9mel.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH] include/exec/cpu-defs.h: try and make
 SoftMMU page size match target
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: peter.maydell@linaro.org, bobby.prani@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>


Richard Henderson <rth@twiddle.net> writes:

> On 07/10/2017 04:28 AM, Alex Bennée wrote:
>> While the SoftMMU is not emulating the target MMU of a system there is
>> a relationship between its page size and that of the target. If the
>> target MMU is full featured the functions called to re-fill the
>> entries in the SoftMMU entries start moving up the perf profiles. If
>> we can we should try and prevent too much thrashing around by having
>> the page sizes the same.
>
> What you are changing has absolutely nothing to do with page size.
> Mentioning page sizes just confuses the issue.
>
> What you're changing is the number of entries in the TLB, and the
> mapping between pages and TLB entries.  And I'm quite certain that you
> saw a performance increase by increasing the size of the TLB.

You are quite right, I'm going to claim Monday brain on the commit text.

There is some relationship though as the index into the SoftMMU TLB is a
product of the target page number masked by the total number of SoftMMU
TLB entries we have. By increasing the SoftMMU TLB size we reduce the
number of aliased target pages for any given SoftMMU entry.

I guess to have a better understanding of the slow-path fill patterns we
would want to have an idea of which entries are getting re-filled more
often and if there is an even distribution over the TLB?

>
>
>>   #define CPU_TLB_BITS                                             \
>> -    MIN(8,                                                       \
>> +    MIN(10,                                                      \
>
> You will find this has broken tcg/arm, because the operand to an armv6
> AND (immediate) instruction is only 8 bits.
>
> I will grant you that we could do a better job of configuring this
> across the tcg backends.
>
> It also possibly warrants some work in the tcg/arm backend so that
> armv7 makes use of UBFX so that not-ancient arm is not so constrained.

I think Pranith is going to take this forward with a patch set to expand
the SoftMMU TLB to the maximum supported by whichever the backend can
do.

--
Alex Bennée
