Received: from eggs.gnu.org ([2001:4830:134:3::10]:57692)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1cRdYF-0002JV-T8
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 06:28:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1cRdYB-0007oJ-UV
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 06:28:15 -0500
Received: from mail.ispras.ru ([83.149.199.45]:45926)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1cRdYB-0007nx-Lb
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 06:28:11 -0500
From: "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
References: <CAMo8BfLRP8qUgJAkU3fSwE_H6EmqYmPKO_MhMn7B6WpwGWUudw@mail.gmail.com>
	<001201d26b1b$e5a8ce20$b0fa6a60$@ru>
	<CAMo8BfJKXOhiPQz8GT6hXNNBXKsz-67iKx9ct9tEwukVLWR3QA@mail.gmail.com>
In-Reply-To: <CAMo8BfJKXOhiPQz8GT6hXNNBXKsz-67iKx9ct9tEwukVLWR3QA@mail.gmail.com>
Date: Thu, 12 Jan 2017 14:28:03 +0300
Message-ID: <001201d26cc6$f023ad00$d06b0700$@ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: ru
Subject: Re: [Qemu-devel] implementing architectural timers using QEMU timers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: 'Max Filippov' <jcmvbkbc@gmail.com>
Cc: 'qemu-devel' <qemu-devel@nongnu.org>, 'Richard Henderson' <rth@twiddle.net>, 'Alex Bligh' <alex@alex.org.uk>, 'Pavel Dovgaluk' <Pavel.Dovgaluk@ispras.ru>

> From: Max Filippov [mailto:jcmvbkbc@gmail.com]
> On Tue, Jan 10, 2017 at 12:31 AM, Pavel Dovgalyuk <dovgaluk@ispras.ru> wrote:
> >> From: Max Filippov [mailto:jcmvbkbc@gmail.com]
> >
> >> I'm trying to reimplement xtensa CCOUNT (cycle counter) and
> >> CCOMPARE (CCOUNT-based timer interrupts) using QEMU
> >> timers. That is CCOUNT value is derived from the
> >> QEMU_CLOCK_VIRTUAL clock and CCOMPARE interrupts are
> >> generated from the QEMU_CLOCK_VIRTUAL timer callbacks.
> >> The code is here:
> >>   https://github.com/OSLL/qemu-xtensa/commits/xtensa-ccount
> >>
> >> I've got the following issues doing that:
> >>
> >> - I thought that could be improved in -icount mode, so I tried that.
> >>   It is better with -icount, but it's still not 100% accurate. That is
> >>   I was able to observe guest reading QEMU clock value that is
> >>   past QEMU timer deadline before that timer callback was
> >>   invoked.
> >
> > icount is meant to be 100% accurate.
> > tcg_get_icount_limit function calculates the deadline before the soonest
> > virtual timer and executes number of instructions that will fit this
> > timeout.
> 
> Ok, looks like what happens in my case is that instruction that
> sets CCOMPARE and thus changes remaining icount does not
> cause exit from the cpu_exec. So merely ending TB on
> QEMU_CLOCK_VIRTUAL timer update is not enough, I need to
> throw an exception of some kind? Or does the timer code need
> to take care of that?

Yes, it seems that you should end the block with an exception,
to allow icount loop recalculate the timeouts.

Pavel Dovgalyuk
