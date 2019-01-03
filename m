Received: from eggs.gnu.org ([208.118.235.92]:34653)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gf3pz-0007sx-8Q
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 09:19:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gf3py-0005vW-H2
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 09:19:07 -0500
MIME-Version: 1.0
References: <20181214145152.27250-1-stefanha@redhat.com>
	<CAFEAcA9OwKJQ0iWtuxMJrNPL5r_qtuZz57H=Dtcr6X45XqQ3TQ@mail.gmail.com>
In-Reply-To: <CAFEAcA9OwKJQ0iWtuxMJrNPL5r_qtuZz57H=Dtcr6X45XqQ3TQ@mail.gmail.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Thu, 3 Jan 2019 14:18:53 +0000
Message-ID: <CAJSP0QWEVr=0XaYbd10-_4_9Vm_9tfKTw3Paj2QR_Wb1ev416g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] microbit: make -kernel optional
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Jim Mussared <jim@groklearning.com>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Steffen Gortz <qemu.ml@steffen-goertz.de>, qemu-arm <qemu-arm@nongnu.org>, Joel Stanley <joel@jms.id.au>, Julia Suvorova <jusual@mail.ru>

On Thu, Jan 3, 2019 at 1:07 PM Peter Maydell <peter.maydell@linaro.org> wrote:
> On Fri, 14 Dec 2018 at 14:51, Stefan Hajnoczi <stefanha@redhat.com> wrote:
> > ARMv7M machine types support -kernel for ELF and raw image files.
> > Microbit programs are typically in Intel HEX (.hex) format.  The generic
> > loader supports .hex files but it doesn't work as expected:
> >
> >   $ qemu-system-arm -M microbit -device loader,file=microbit.hex
> >   Guest image must be specified (using -kernel)
> >
> > This error comes from armv7m_load_kernel() but we don't have -kernel in
> > this case.
> >
> > This patch makes -kernel optional since most of the time we'll want to
> > use -device loader instead.
> >
> > Note that we need to register the reset handler that
> > armv7m_load_kernel() used to register for us.
> >
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
>
> Hi, Stefan. (Happy new year :-))
>
> Looking at this, I think I'd prefer it if we handled
> this in the armv7m_load_kernel() code, since having to register
> your own reset handler to reset the CPU is a weird thing for
> board level code to have to do. That then means the M-profile
> kernel load code is in line with the A-profile load code, which
> if it has no kernel to load will still register the reset handler,
> and let the machine run however it ends up running.
>
> I think this basically amounts to "remove the 'insist that
> kernel_filename is not NULL' check from armv7m_load_kernel()",
> aka "revert commit 01fd41ab3fb69971". That commit's commit
> message is correct that the behaviour if the user didn't
> specify anything to run is a bit unhelpful, but it predates
> the generic loader so it's no longer necessarily true that
> a kernel must be specified, either for this or for any other
> M-profile machine. (There's also the case of "board has a
> flash device that was populated via a -pflash or -drive
> option".)

Happy New Year!

That makes sense.  I will send a patch.

Stefan
