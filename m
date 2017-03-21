Received: from eggs.gnu.org ([2001:4830:134:3::10]:47078)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jiahuanzhang90@gmail.com>) id 1cqObS-0000H0-Iq
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 14:33:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jiahuanzhang90@gmail.com>) id 1cqObR-0004m4-E5
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 14:33:54 -0400
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:33918)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jiahuanzhang90@gmail.com>)
	id 1cqObR-0004lu-7E
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 14:33:53 -0400
Received: by mail-qk0-x241.google.com with SMTP id v127so23258183qkb.1
	for <qemu-devel@nongnu.org>; Tue, 21 Mar 2017 11:33:53 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_t9iLude4Vu3Zc=_wcXMTtFb4Q4oJ8O+zLAJ9isAPqHQ@mail.gmail.com>
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
	<CAJy91CYEwOVT7oEdYY=21__c2kcLTyxyjAaq7Zx4VnQdeLdQQQ@mail.gmail.com>
	<CAFEAcA_t9iLude4Vu3Zc=_wcXMTtFb4Q4oJ8O+zLAJ9isAPqHQ@mail.gmail.com>
From: Jiahuan Zhang <jiahuanzhang90@gmail.com>
Date: Tue, 21 Mar 2017 19:33:52 +0100
Message-ID: <CAJy91CbNq+1XNgGyvPv+2WHqHbOu3Ee7xcaLSKF0TKB5poAPSg@mail.gmail.com>
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
Cc: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

Okay. Thank you very much.
I'll take your advice and test.
Let's see the chardev maintainers reply.

Best,
Huan

2017=E5=B9=B43=E6=9C=8821=E6=97=A5 19:28=EF=BC=8C"Peter Maydell" <peter.may=
dell@linaro.org>=E5=86=99=E9=81=93=EF=BC=9A

> On 21 March 2017 at 18:11, Jiahuan Zhang <jiahuanzhang90@gmail.com> wrote=
:
> > What do you mean "RXFE will be cleared"?
> > Here RXFE is
> > #define PL011_RXFE   0x10
>
> I mean that as soon as 1 byte of data is ready to read the
> RXFE bit will be cleared in the FR register. So you need:
>
> /* probably you want to actually detect EOF somehow but let's
>  * just read 16 bytes
>  */
> for (i =3D 0; i < 16; i++) {
>     while (*UART_FR & PL011_RXFE) {
>         /* loop until data available */
>     }
>     /* now read 1 byte, that's all we can be certain is there */
>     data[i] =3D *UART_DR;
>     /* ...and then go back and check RXFE again */
> }
>
> >> Are you saying that QEMU is looping round indefinitely calling
> >> pl011_can_receive() and never running the guest at all?
> >
> >
> > Yes, exactly when fifo is full, s->count =3D 16. pl011_can_recieve keep=
s
> > returning 0.
> > The guest program is blocked.
>
> Right, but if can_receive returns 0, then QEMU should decide
> "OK, can't do anything here" and run the guest.
>
> > I am using a windows named pipe to get the data from a window
> > host program, which uses ReadFile () in char_win.c
>
> OK, bugs in the windows-specific char backend would be
> unsurprising.
>
> I'm not entirely sure how the chardev layer works, but
> at the pl011 end if we return 0 from our can_receive
> function then the chardev layer should decide it has
> nothing to do until the pl011 later calls
> qemu_chr_fe_accept_input(), I think.
>
> I've cc'd Paolo and Marc-Andr=C3=A9 Lureau as the chardev
> maintainers.
>
> thanks
> -- PMM
>
