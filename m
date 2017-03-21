Received: from eggs.gnu.org ([2001:4830:134:3::10]:35354)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jiahuanzhang90@gmail.com>) id 1cqOG5-0000Ig-LY
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 14:11:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jiahuanzhang90@gmail.com>) id 1cqOG4-0002XD-Ei
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 14:11:49 -0400
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:35343)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jiahuanzhang90@gmail.com>)
	id 1cqOG4-0002Wy-9e
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 14:11:48 -0400
Received: by mail-qk0-x244.google.com with SMTP id o135so23193928qke.2
	for <qemu-devel@nongnu.org>; Tue, 21 Mar 2017 11:11:48 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAJy91CaCV40FgSP55qWZeZgkQ=2+E8Cr7xdbu9pn5HLEo+6JJQ@mail.gmail.com>
References: <CAJy91CY1SOwi7D-kyU0ooe5SyhM414WaBCedXuPfXXhJpbo1fg@mail.gmail.com>
	<CAFEAcA8HrEsuEYgpe9pJQkwSnSTU74G+3i7vWk8ka5cJ+UWFDQ@mail.gmail.com>
	<CAJy91CZ=QbhyeakFCSq3n6+d_cGO8hpT8o8EUwUTdkX-iE1eLg@mail.gmail.com>
	<CAFEAcA9XRwW0=UzuAXwjB-a_vWepfh+mus9bgpmdsCoQH6sDEQ@mail.gmail.com>
	<CAJy91CbwRd0u+RJiXZZP11J6pU4Pw-FDGbf=hLSBPejNb78bDA@mail.gmail.com>
	<CAFEAcA_etsFstPtUzs0AZjWD35MhMLhwru0ibJzS_upgE-nsng@mail.gmail.com>
	<CAJy91CZmqEUXLKjRJ0JdUEf83E3FwE_24qmej-4C8uAGQkTPWA@mail.gmail.com>
	<CAFEAcA-mzO7vniDEaZeueVFQ7+MVBB7pnzHhahv2Yk_f3q0mJw@mail.gmail.com>
	<CAJy91CZ4Ed-HGHLkzEc1dqQbo32d-eTE1S1ovO_ZwkDdTpkQXQ@mail.gmail.com>
	<CAJy91CaCV40FgSP55qWZeZgkQ=2+E8Cr7xdbu9pn5HLEo+6JJQ@mail.gmail.com>
From: Jiahuan Zhang <jiahuanzhang90@gmail.com>
Date: Tue, 21 Mar 2017 19:11:47 +0100
Message-ID: <CAJy91CYEwOVT7oEdYY=21__c2kcLTyxyjAaq7Zx4VnQdeLdQQQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

2017=E5=B9=B43=E6=9C=8821=E6=97=A5 18:55=EF=BC=8C"Peter Maydell" <peter.may=
dell@linaro.org>=E5=86=99=E9=81=93=EF=BC=9A

On 21 March 2017 at 17:48, Jiahuan Zhang <jiahuanzhang90@gmail.com> wrote:
> The guest program is as follows.
>
> While (*UART_FR & PL011_RXFE); //wait until fifo not empty
> for (i=3D0;i <16;i++){
>    data [i] =3D (unsigned char) *UART_DR; //read from the data register.
> }

This is buggy. You must check RXFE every time, because
RXFE will be cleared as soon as even a single byte is
in the FIFO. It does not mean "FIFO full", it just
means "FIFO not empty".


Yes, here I need to make sure there are real data in the fifo, or data [i]
will get null.
Do you mean that I also need to make sure fifo is not full before reading?
For example, by while(*UART_FR & RXFF); ?

What do you mean "RXFE will be cleared"?
Here RXFE is
#define PL011_RXFE   0x10

By the way, at the beginning of the guest program, I set the line control
register s->lcr =3D 0x70 for pl011_can_recieve.

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


Yes, exactly when fifo is full, s->count =3D 16. pl011_can_recieve keeps
returning 0.
The guest program is blocked.

That would be a QEMU bug, but it seems unlikely or we'd have
noticed it before.

What chardev backend are you connecting to the pl011 to
feed data to it?


I am using a windows named pipe to get the data from a window host program,
which uses ReadFile () in char_win.c


thanks
-- PMM
