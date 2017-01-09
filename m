Received: from eggs.gnu.org ([2001:4830:134:3::10]:35147)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex@alex.org.uk>) id 1cQc5C-0007r4-RY
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 10:42:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex@alex.org.uk>) id 1cQc5B-0001xy-Gl
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 10:42:02 -0500
Received: from mail.avalus.com ([2001:41c8:10:1dd::10]:51024)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex@alex.org.uk>) id 1cQc5B-0001vW-72
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 10:42:01 -0500
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
From: Alex Bligh <alex@alex.org.uk>
In-Reply-To: <CAMo8BfLRP8qUgJAkU3fSwE_H6EmqYmPKO_MhMn7B6WpwGWUudw@mail.gmail.com>
Date: Mon, 9 Jan 2017 15:41:57 +0000
Content-Transfer-Encoding: 7bit
Message-Id: <C5E4DA8A-2E1B-4514-8F51-8FE8A0DD52C7@alex.org.uk>
References: <CAMo8BfLRP8qUgJAkU3fSwE_H6EmqYmPKO_MhMn7B6WpwGWUudw@mail.gmail.com>
Subject: Re: [Qemu-devel] implementing architectural timers using QEMU timers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Filippov <jcmvbkbc@gmail.com>
Cc: Alex Bligh <alex@alex.org.uk>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Pavel Dovgaluk <Pavel.Dovgaluk@ispras.ru>, "rth@twiddle.net" <rth@twiddle.net>


> On 9 Jan 2017, at 15:18, Max Filippov <jcmvbkbc@gmail.com> wrote:
> 
> Hello,
> 
> I'm trying to reimplement xtensa CCOUNT (cycle counter) and
> CCOMPARE (CCOUNT-based timer interrupts) using QEMU
> timers. That is CCOUNT value is derived from the
> QEMU_CLOCK_VIRTUAL clock and CCOMPARE interrupts are
> generated from the QEMU_CLOCK_VIRTUAL timer callbacks.
> The code is here:
>  https://github.com/OSLL/qemu-xtensa/commits/xtensa-ccount
> 
> I've got the following issues doing that:
> 
> - in non-icount mode I can often read CCOUNT and get a value
>  that is greater than programmed CCOMPARE value, which
>  means that QEMU timer must have been fired at that point, but
>  no sign of timer callback being called. That is timer callback
>  invocation lags behind due time.
> 
>  Is my understanding correct that there's no hard expectations
>  that firing of QEMU timers will be correctly sequenced with
>  readings of QEMU clock?

My understanding is that the intent of the API contract is that

* The timer will not fire earlier than the time requested (but
  can fire later)

* Timers on the same clock and context will fire in the order
  of their expiry time (with the ordering being undefined in
  the event the expiry times are equal).

Whether in practice any users make use of the second guarantee
above I don't know.

> 
> - I thought that could be improved in -icount mode, so I tried that.
>  It is better with -icount, but it's still not 100% accurate. That is
>  I was able to observe guest reading QEMU clock value that is
>  past QEMU timer deadline before that timer callback was
>  invoked.
> 
>  That sounds like a bug to me, is it?

Hmm... that would be a bug if it were guaranteed that the
guest reads are always perfectly in sync with the timer
itself. I don't know whether that is the case.

Even though I authored a large timer patch, I found the icount
stuff confusing.

> - when guest sets a timer and halts itself waiting for timer
>  interrupt with waiti opcode QEMU behaviour is very strange with
>  -icount: regardless of the programmed timeout QEMU waits for
>  about a second before it delivers interrupt, and, AFAICT,
>  interrupt delivery it is not caused by the corresponding CCOUNT
>  timer. I was able to track this issue down to the
>  qemu_clock_use_for_deadline function, i.e. always returning true
>  'fixes' that unwanted delay, but looking around the timer code
>  I've got the impression that that's not the correct fix.
> 
>  Any suggestions on how to fix that?

This could be someone using timerlistgroup_deadline_ns rather than
qemu_clock_deadline_ns_all.

The comment at the top of qemu_clock_deadline_ns_all says:

/* Calculate the soonest deadline across all timerlists attached
 * to the clock. This is used for the icount timeout so we
 * ignore whether or not the clock should be used in deadline
 * calculations.
 */

I'm wondering whether there is something up with that logic.

-- 
Alex Bligh
