Received: from eggs.gnu.org ([2001:4830:134:3::10]:57725)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cqO0V-00023i-MS
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 13:55:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cqO0U-00057d-Px
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 13:55:43 -0400
Received: from mail-wr0-x22e.google.com ([2a00:1450:400c:c0c::22e]:34980)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cqO0U-00057Q-ID
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 13:55:42 -0400
Received: by mail-wr0-x22e.google.com with SMTP id g10so116853231wrg.2
	for <qemu-devel@nongnu.org>; Tue, 21 Mar 2017 10:55:42 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAJy91CZmqEUXLKjRJ0JdUEf83E3FwE_24qmej-4C8uAGQkTPWA@mail.gmail.com>
References: <CAJy91CY1SOwi7D-kyU0ooe5SyhM414WaBCedXuPfXXhJpbo1fg@mail.gmail.com>
	<CAFEAcA8HrEsuEYgpe9pJQkwSnSTU74G+3i7vWk8ka5cJ+UWFDQ@mail.gmail.com>
	<CAJy91CZ=QbhyeakFCSq3n6+d_cGO8hpT8o8EUwUTdkX-iE1eLg@mail.gmail.com>
	<CAFEAcA9XRwW0=UzuAXwjB-a_vWepfh+mus9bgpmdsCoQH6sDEQ@mail.gmail.com>
	<CAJy91CbwRd0u+RJiXZZP11J6pU4Pw-FDGbf=hLSBPejNb78bDA@mail.gmail.com>
	<CAFEAcA_etsFstPtUzs0AZjWD35MhMLhwru0ibJzS_upgE-nsng@mail.gmail.com>
	<CAJy91CZmqEUXLKjRJ0JdUEf83E3FwE_24qmej-4C8uAGQkTPWA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 21 Mar 2017 17:55:20 +0000
Message-ID: <CAFEAcA-mzO7vniDEaZeueVFQ7+MVBB7pnzHhahv2Yk_f3q0mJw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] Guest application reading from pl011 without
 device driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jiahuan Zhang <jiahuanzhang90@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 21 March 2017 at 17:48, Jiahuan Zhang <jiahuanzhang90@gmail.com> wrote:
> The guest program is as follows.
>
> While (*UART_FR & PL011_RXFE); //wait until fifo not empty
> for (i=0;i <16;i++){
>    data [i] = (unsigned char) *UART_DR; //read from the data register.
> }

This is buggy. You must check RXFE every time, because
RXFE will be cleared as soon as even a single byte is
in the FIFO. It does not mean "FIFO full", it just
means "FIFO not empty".

(You should also check that you're correctly using
'volatile' or some other mechanism for ensuring that
the C compiler does not decide that it can collapse
away accesses to hardware registers because it thinks
they're just memory and won't change value.)

> But what I met is that, when the receiving data is small,
> no data is knocking the door of the fifo by ReadFile (),
> then pl011_read can starts.
> When the data is large, after the fifo is full, there are still
> data requesting to get into the fifo. Then the device is busy
> with pl011_can_receive.

Are you saying that QEMU is looping round indefinitely calling
pl011_can_receive() and never running the guest at all?
That would be a QEMU bug, but it seems unlikely or we'd have
noticed it before.

What chardev backend are you connecting to the pl011 to
feed data to it?

thanks
-- PMM
