Received: from eggs.gnu.org ([2001:4830:134:3::10]:42671)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1cReM5-0005oi-SN
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 07:19:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1cReM1-0003xG-8P
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 07:19:45 -0500
Received: from mail.ispras.ru ([83.149.199.45]:51596)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1cReM1-0003x3-0Y
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 07:19:41 -0500
From: "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
References: <CAMo8BfLRP8qUgJAkU3fSwE_H6EmqYmPKO_MhMn7B6WpwGWUudw@mail.gmail.com>
	<001201d26b1b$e5a8ce20$b0fa6a60$@ru>
	<CAMo8BfJKXOhiPQz8GT6hXNNBXKsz-67iKx9ct9tEwukVLWR3QA@mail.gmail.com>
	<001201d26cc6$f023ad00$d06b0700$@ru>
	<CAFEAcA-AMJ33g9hO2k9oGJfDr-Fatk7TY+Sbs_wRC-OfCjWhmQ@mail.gmail.com>
In-Reply-To: <CAFEAcA-AMJ33g9hO2k9oGJfDr-Fatk7TY+Sbs_wRC-OfCjWhmQ@mail.gmail.com>
Date: Thu, 12 Jan 2017 15:19:32 +0300
Message-ID: <001301d26cce$21ad3d30$6507b790$@ru>
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
To: 'Peter Maydell' <peter.maydell@linaro.org>
Cc: 'Max Filippov' <jcmvbkbc@gmail.com>, 'Pavel Dovgaluk' <Pavel.Dovgaluk@ispras.ru>, 'qemu-devel' <qemu-devel@nongnu.org>, 'Alex Bligh' <alex@alex.org.uk>, 'Richard Henderson' <rth@twiddle.net>

> From: Peter Maydell [mailto:peter.maydell@linaro.org]
> On 12 January 2017 at 11:28, Pavel Dovgalyuk <dovgaluk@ispras.ru> wrote:
> >> From: Max Filippov [mailto:jcmvbkbc@gmail.com]
> >> Ok, looks like what happens in my case is that instruction that
> >> sets CCOMPARE and thus changes remaining icount does not
> >> cause exit from the cpu_exec. So merely ending TB on
> >> QEMU_CLOCK_VIRTUAL timer update is not enough, I need to
> >> throw an exception of some kind? Or does the timer code need
> >> to take care of that?
> >
> > Yes, it seems that you should end the block with an exception,
> > to allow icount loop recalculate the timeouts.
> 
> Really? The ARM translate.c doesn't generate an exception.
> It just does
>  gen_io_end();
>  gen_lookup_tb();
> 
> (so we force a lookup of the next TB, but don't throw an
> exception of any kind).

Maybe I missing something. As far as I understand, changing the virtual timer 
notifies the iothread and os_host_main_loop_wait kicks the CPU thread.

But within that period of time before changing the timer and kicking the thread
CPU may proceed some instructions and the timer will be expired if it was set
to one of the soonest instructions.

Pavel Dovgalyuk
