Received: from eggs.gnu.org ([2001:4830:134:3::10]:40776)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1cSsjB-0001p1-SX
	for qemu-devel@nongnu.org; Sun, 15 Jan 2017 16:52:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1cSsjA-0007ec-PU
	for qemu-devel@nongnu.org; Sun, 15 Jan 2017 16:52:41 -0500
Received: from mail-io0-x244.google.com ([2607:f8b0:4001:c06::244]:35642)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1cSsjA-0007d5-KA
	for qemu-devel@nongnu.org; Sun, 15 Jan 2017 16:52:40 -0500
Received: by mail-io0-x244.google.com with SMTP id m98so10902569iod.2
	for <qemu-devel@nongnu.org>; Sun, 15 Jan 2017 13:52:40 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <001201d26cc6$f023ad00$d06b0700$@ru>
References: <CAMo8BfLRP8qUgJAkU3fSwE_H6EmqYmPKO_MhMn7B6WpwGWUudw@mail.gmail.com>
	<001201d26b1b$e5a8ce20$b0fa6a60$@ru>
	<CAMo8BfJKXOhiPQz8GT6hXNNBXKsz-67iKx9ct9tEwukVLWR3QA@mail.gmail.com>
	<001201d26cc6$f023ad00$d06b0700$@ru>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Sun, 15 Jan 2017 13:52:38 -0800
Message-ID: <CAMo8BfLdG5_kiYqFk9bqM5xjMBH+i8ehFZGT_29sbSjDrdM7Lg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] implementing architectural timers using QEMU timers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Dovgalyuk <dovgaluk@ispras.ru>
Cc: qemu-devel <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>, Alex Bligh <alex@alex.org.uk>, Pavel Dovgaluk <Pavel.Dovgaluk@ispras.ru>

On Thu, Jan 12, 2017 at 3:28 AM, Pavel Dovgalyuk <dovgaluk@ispras.ru> wrote:
>> From: Max Filippov [mailto:jcmvbkbc@gmail.com]
>> On Tue, Jan 10, 2017 at 12:31 AM, Pavel Dovgalyuk <dovgaluk@ispras.ru> wrote:
>> >> From: Max Filippov [mailto:jcmvbkbc@gmail.com]
>> >
>> >> I'm trying to reimplement xtensa CCOUNT (cycle counter) and
>> >> CCOMPARE (CCOUNT-based timer interrupts) using QEMU
>> >> timers. That is CCOUNT value is derived from the
>> >> QEMU_CLOCK_VIRTUAL clock and CCOMPARE interrupts are
>> >> generated from the QEMU_CLOCK_VIRTUAL timer callbacks.
>> >> The code is here:
>> >>   https://github.com/OSLL/qemu-xtensa/commits/xtensa-ccount
>> >>
>> >> I've got the following issues doing that:
>> >>
>> >> - I thought that could be improved in -icount mode, so I tried that.
>> >>   It is better with -icount, but it's still not 100% accurate. That is
>> >>   I was able to observe guest reading QEMU clock value that is
>> >>   past QEMU timer deadline before that timer callback was
>> >>   invoked.
>> >
>> > icount is meant to be 100% accurate.
>> > tcg_get_icount_limit function calculates the deadline before the soonest
>> > virtual timer and executes number of instructions that will fit this
>> > timeout.
>>
>> Ok, looks like what happens in my case is that instruction that
>> sets CCOMPARE and thus changes remaining icount does not
>> cause exit from the cpu_exec. So merely ending TB on
>> QEMU_CLOCK_VIRTUAL timer update is not enough, I need to
>> throw an exception of some kind? Or does the timer code need
>> to take care of that?
>
> Yes, it seems that you should end the block with an exception,
> to allow icount loop recalculate the timeouts.

I've added raising EXCP_YIELD in the next TB:
  http://lists.nongnu.org/archive/html/qemu-devel/2017-01/msg02811.html
With that icount timers work perfectly for me.

-- 
Thanks.
-- Max
