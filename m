Received: from eggs.gnu.org ([2001:4830:134:3::10]:60092)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fred.konrad@greensocs.com>) id 1cQsS2-00086n-3O
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 04:10:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fred.konrad@greensocs.com>) id 1cQsRx-0001HJ-W3
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 04:10:42 -0500
Received: from greensocs.com ([193.104.36.180]:50687)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fred.konrad@greensocs.com>) id 1cQsRx-0001Gt-Ai
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 04:10:37 -0500
References: <CAMo8BfLRP8qUgJAkU3fSwE_H6EmqYmPKO_MhMn7B6WpwGWUudw@mail.gmail.com>
From: Frederic Konrad <fred.konrad@greensocs.com>
Message-ID: <cd817ab9-fd77-f52c-5ee7-7502b68959cb@greensocs.com>
Date: Tue, 10 Jan 2017 10:10:30 +0100
MIME-Version: 1.0
In-Reply-To: <CAMo8BfLRP8qUgJAkU3fSwE_H6EmqYmPKO_MhMn7B6WpwGWUudw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
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
Cc: qemu-devel <qemu-devel@nongnu.org>, Pavel Dovgaluk <Pavel.Dovgaluk@ispras.ru>, Alex Bligh <alex@alex.org.uk>, Richard Henderson <rth@twiddle.net>

On 01/09/2017 04:18 PM, Max Filippov wrote:
> Hello,
> 
> I'm trying to reimplement xtensa CCOUNT (cycle counter) and
> CCOMPARE (CCOUNT-based timer interrupts) using QEMU
> timers. That is CCOUNT value is derived from the
> QEMU_CLOCK_VIRTUAL clock and CCOMPARE interrupts are
> generated from the QEMU_CLOCK_VIRTUAL timer callbacks.
> The code is here:
>   https://github.com/OSLL/qemu-xtensa/commits/xtensa-ccount
> 
> I've got the following issues doing that:
> 
> - in non-icount mode I can often read CCOUNT and get a value
>   that is greater than programmed CCOMPARE value, which
>   means that QEMU timer must have been fired at that point, but
>   no sign of timer callback being called. That is timer callback
>   invocation lags behind due time.
> 
>   Is my understanding correct that there's no hard expectations
>   that firing of QEMU timers will be correctly sequenced with
>   readings of QEMU clock?
> 
> - I thought that could be improved in -icount mode, so I tried that.
>   It is better with -icount, but it's still not 100% accurate. That is
>   I was able to observe guest reading QEMU clock value that is
>   past QEMU timer deadline before that timer callback was
>   invoked.
> 
>   That sounds like a bug to me, is it?

Did you try "sleep" icount option?

eg:
-icount 1,sleep=off

Fred

> 
> - when guest sets a timer and halts itself waiting for timer
>   interrupt with waiti opcode QEMU behaviour is very strange with
>   -icount: regardless of the programmed timeout QEMU waits for
>   about a second before it delivers interrupt, and, AFAICT,
>   interrupt delivery it is not caused by the corresponding CCOUNT
>   timer. I was able to track this issue down to the
>   qemu_clock_use_for_deadline function, i.e. always returning true
>   'fixes' that unwanted delay, but looking around the timer code
>   I've got the impression that that's not the correct fix.
> 
>   Any suggestions on how to fix that?
> 
