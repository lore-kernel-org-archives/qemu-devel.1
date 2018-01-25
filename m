Received: from eggs.gnu.org ([2001:4830:134:3::10]:60818)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pisa@cmp.felk.cvut.cz>) id 1eecqn-0007Gi-8L
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 03:25:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pisa@cmp.felk.cvut.cz>) id 1eecqj-0001VM-Vc
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 03:25:37 -0500
Received: from relay.felk.cvut.cz ([2001:718:2:1611:0:1:0:70]:15587)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pisa@cmp.felk.cvut.cz>) id 1eecqj-0001UZ-Gu
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 03:25:33 -0500
From: Pavel Pisa <pisa@cmp.felk.cvut.cz>
Date: Thu, 25 Jan 2018 09:24:50 +0100
References: <cover.1515960078.git.pisa@cmp.felk.cvut.cz>
	<201801242122.31033.pisa@cmp.felk.cvut.cz>
	<abe89c1b-b6fa-3021-fad1-469d2eb2060a@amsat.org>
In-Reply-To: <abe89c1b-b6fa-3021-fad1-469d2eb2060a@amsat.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <201801250924.50877.pisa@cmp.felk.cvut.cz>
Subject: Re: [Qemu-devel] [PATCH V4 0/7] CAN bus support for QEMU (SJA1000
 PCI so far)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org, =?utf-8?q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Marek Vasut <marex@denx.de>, Oliver Hartkopp <socketcan@hartkopp.net>, Stefan Hajnoczi <stefanha@gmail.com>, Deniz Eren <deniz.eren@icloud.com>, Oleksij Rempel <o.rempel@pengutronix.de>, Konrad Frederic <frederic.konrad@adacore.com>, Jan Kiszka <jan.kiszka@siemens.com>

Hello Philippe,

On Wednesday 24 of January 2018 22:41:16 Philippe Mathieu-Daud=C3=A9 wrote:
> Hi Pavel,
> > I have seen that a few other type_init-s do more
> > than simple sequence of type_register_static().
> > Is it acceptable to use type_init for registration
> > to CAN core by function call for now? Conversion simplifies
> > makefiles and unnecessary stub file is removed.
> >
> > But I would use attribute if that solution is preferred because
> > it is allways present on Linux where SocketCAN is used anyway
> > and it is used in other Qemu subsystems as well.
>
> using stubs/monitor.c as a template for stubs/can_host_variant.c doesn't
> work?

If that is preferred then I implement the stub this way.
As for the location, can I add

  stub-obj-y +=3D can_host_stub.o

into hw/can/Makefile.objs same as it is in crypto/Makefile.objs
to keep CAN stuff together at least for now or it should go
to stubs directory?

  stub-obj-$(CONFIG_CAN_BUS) +=3D can_host_variant.o

As for connection to host, again I have weak preference
to keep it in hw/can to keep CAN related code together
but if you think that it should go t chardev, I would prepare
patch that way

  chardev/can-socketcan.c

As for the rest of the remarks

You are right that there is some code duplication
in the SJA1000 CAN PCI cards support but problem
is that KVASER single uses S5920 PCI local bus bridge
which requires additional BARs and additional bridge
specific interrupt enable support. There are more KVASER
variants which combine multiple SJA1000 in a single BAR.
pcm3680 and mioe3680 have different BAR structure,
each SJA1000 uses one BAR. The first uses I/O mapped
SJA1000 and another memory mapped with stride 4.
Yes, it all can be combined into one C file.
But it would require to to add more more fields
into CardX_PCIState structure and some mechanisms
and code to select right combination of the BARs,
handlers etc for each card. It all can be done,
but I am not sure if I find time for such changes now.
I expect to have time again in summer when my teaching
semester ends.
Another disadvantage is that if somebody else wants
to implement other card emulation then actual simple
can_kvaser_pci.c is easily readable. Code gets much
more complex with all variants selection logic and
we have already abandoned that simple PCI example
(can_pci.c) with dummy PCI ID which as been included
in the past.

If the code duplication is a problem for now then
I vote to include only can_kvaser_pci.c for now.
But Deniz Eren would be sad because he uses the
cards (which he has contributed) in his test environment.

Anyway, I would follow what is proposed.

Thanks for your review and time,

Pavel
