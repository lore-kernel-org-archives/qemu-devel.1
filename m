Received: from eggs.gnu.org ([2001:4830:134:3::10]:47545)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pisa@cmp.felk.cvut.cz>) id 1efj10-00043y-SO
	for qemu-devel@nongnu.org; Sun, 28 Jan 2018 04:12:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pisa@cmp.felk.cvut.cz>) id 1efj0x-00006o-NU
	for qemu-devel@nongnu.org; Sun, 28 Jan 2018 04:12:42 -0500
Received: from relay.felk.cvut.cz ([2001:718:2:1611:0:1:0:70]:20197)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pisa@cmp.felk.cvut.cz>) id 1efj0x-00006D-Dr
	for qemu-devel@nongnu.org; Sun, 28 Jan 2018 04:12:39 -0500
From: Pavel Pisa <pisa@cmp.felk.cvut.cz>
Date: Sun, 28 Jan 2018 10:02:40 +0100
References: <cover.1515960078.git.pisa@cmp.felk.cvut.cz>
	<201801252233.45477.pisa@cmp.felk.cvut.cz>
	<8f7d0063-6290-bdd5-7383-5bf3ae10e6dd@redhat.com>
In-Reply-To: <8f7d0063-6290-bdd5-7383-5bf3ae10e6dd@redhat.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <201801281002.40862.pisa@cmp.felk.cvut.cz>
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
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Philippe =?utf-8?q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Marek Vasut <marex@denx.de>, Stefan Hajnoczi <stefanha@gmail.com>, Deniz Eren <deniz.eren@icloud.com>, qemu-devel@nongnu.org, Oleksij Rempel <o.rempel@pengutronix.de>, Konrad Frederic <frederic.konrad@adacore.com>, Jan Kiszka <jan.kiszka@siemens.com>, Oliver Hartkopp <socketcan@hartkopp.net>, =?utf-8?q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>

Hello Paolo,

On Friday 26 of January 2018 12:12:32 Paolo Bonzini wrote:
> Coincidentially, I have some time on a flight next Monday. :)  I
> obviously cannot really _test_ anything, but I can at least do the
> changes below and set up all the QOM boilerplate.

thanks much for offer to help.

Deniz Eren or Oleksij Rempel can test your changes as well.

I have prepared branch "can-pci-qom" in GitLab repository

  https://gitlab.fel.cvut.cz/canbus/qemu-canbus

  https://gitlab.fel.cvut.cz/canbus/qemu-canbus/tree/can-pci-qom

and I have updated all PCI devices to use realize() instead of init(),
eliminated all uses of exit() and changed error reporting to use
error_setg() and error_setg_errno(). So I think that there is
no fatal blocker in these files. Problematic is setup
of connect_to_host variant

 can_bus_set_connect_to_host(can_bus_connect_to_host_socketcan);

in "hw/can/can_socketcan.c" and location of this file
in HW. I keep it there to have all CAN support *.c
files in single place for now.

I have studied "tests/check-qom-proplist.c" for while
but I expect that you will be much more successfull
and efficient to define mainline acceptable object model.

Thanks again,

Pavel

> >> The best way would be a QOM object.  That is, you would do
> >>
> >>    -object can-bus,id=canbus0
> >>    -object can-host-socketcan,id=can0-host,canbus=canbus0,if=can0
> >>    -device kvaser_pci,canbus=canbus0
> >
> > I would prefer to allow CAN emulation to be used without
> > explicit can-bus object creation specified on the command line.
> > The bus object could be created when requested by
> > can-host-socketcan or device (kvaser_pci) automatically.
>
> It could be fine to allow "-device kvaser_pci" to automatically create a
> private bus.  However, IMO it's better to be explicit in the case where
> multiple objects (e.g. can-host-socketcan and the kvaser_pci device, or
> two controllers) want to connect to the same object.
>
> >> Separating the QOM objects is a bit more work, but it makes the
> >> semantics clearer.  The classes would be:
> >>
> >> - can-bus and an abstract class can-host, which would inherit directly
> >> from TYPE_OBJECT and implement TYPE_USER_CREATABLE
> >>
> >> - can-host-socketcan, which would inherit from can-host (and take the
> >> TYPE_USER_CREATABLE implementation from there)
> >>
> >> while CanBusClientState and CanBusClientInfo need not be QOMified.
> >
> > May it be, can-host-socketcan can be based directly on TYPE_OBJECT,
> > because only QEMU CAN bus specific part is CanBusClientState which
> > allows it to connect to the CAN bus same way as other CAN controllers
> > connect to the bus.
>
> The abstract class "can-host" is useful to keep can-host-socketcan free
> of things that are not specific to SocketCAN, but it's just a small detail.
