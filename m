Received: from eggs.gnu.org ([2001:4830:134:3::10]:42399)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pisa@cmp.felk.cvut.cz>) id 1eepAE-0000tz-Np
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 16:34:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pisa@cmp.felk.cvut.cz>) id 1eepAA-0006VR-PE
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 16:34:30 -0500
Received: from relay.felk.cvut.cz ([2001:718:2:1611:0:1:0:70]:36124)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pisa@cmp.felk.cvut.cz>) id 1eepAA-0006Tz-CA
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 16:34:26 -0500
From: Pavel Pisa <pisa@cmp.felk.cvut.cz>
Date: Thu, 25 Jan 2018 22:33:45 +0100
References: <cover.1515960078.git.pisa@cmp.felk.cvut.cz>
	<201801232242.31243.pisa@cmp.felk.cvut.cz>
	<ca52867f-08bf-e79f-db63-0698ccd1a106@redhat.com>
In-Reply-To: <ca52867f-08bf-e79f-db63-0698ccd1a106@redhat.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <201801252233.45477.pisa@cmp.felk.cvut.cz>
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

thanks for suggestions. I understand and fully agree with your
request to switch to QOM. I have succeed with that for CAN devices
some time ago. It worth to be done for the rest of the objects
but I fear that I do not find time to complete QOMification
in reasonable future. Contributions/suggestions from other
are welcomed. I can look for students for GSoC at our university
or under other funding.

On Thursday 25 of January 2018 14:58:41 Paolo Bonzini wrote:
> On 23/01/2018 22:42, Pavel Pisa wrote:
> > Do you think QOM based? I would like it to be implemented
> > that way but I need some assistance where to look how this
> > object kind should be implemented and from which base object
> > inherit from. But I prefer to left that for later work.
> >
> > I would definitely like to use some mechanism which allows
> > to get rid of externally visible pointer and need to assign
> > it in the stub. It has been my initial idea and your review
> > sumbled across this hack as well. But I need suggestion what
> > is the preferred way for QEMU.
>
> The best way would be a QOM object.  That is, you would do
>
>    -object can-bus,id=canbus0
>    -object can-host-socketcan,id=can0-host,canbus=canbus0,if=can0
>    -device kvaser_pci,canbus=canbus0

I would prefer to allow CAN emulation to be used without
explicit can-bus object creation specified on the command line.
The bus object could be created when requested by
can-host-socketcan or device (kvaser_pci) automatically.

When multiple QOM object are put on the list then the list content
should be preserved over save+restore (mostly hypothetical question
for now). There should be probably used some other construct instead
of

  QTAILQ_HEAD(, CanBusClientState) clients;
  QTAILQ_ENTRY(CanBusState) next;

> In the current version, it's not clear to me:
>
> * what it means if multiple controllers have the same canbus

That is fully supported and sane configuration.
CAN is publis/subscribe network in principle
so sending message from one controller to another
one on the host side is intended and can be used
to test drivers even if host connection is
not available/supported on given OS/setup.
Interconnection of multiple controllers with
host CAN bus is functional as well.

> * what it means if multiple controllers with the same canbus have
> different host interfaces

It is legitimate but probably not much usesfull/intended setup.
It would result is bridging two host CAN busses
together. It would work because SocketCAN does not
deliver message back to the socket which has been used to send
it by default. Connecting twice to the same SocketCAN bus
would lead to infinite message loop.

Connection of given can bus to the host twice can be prevented
if host connection flag is included in CanBusState and if it is
already set then next host connection attempt would be reported
as error.

> Separating the QOM objects is a bit more work, but it makes the
> semantics clearer.  The classes would be:
>
> - can-bus and an abstract class can-host, which would inherit directly
> from TYPE_OBJECT and implement TYPE_USER_CREATABLE
>
> - can-host-socketcan, which would inherit from can-host (and take the
> TYPE_USER_CREATABLE implementation from there)
>
> while CanBusClientState and CanBusClientInfo need not be QOMified.

May it be, can-host-socketcan can be based directly on TYPE_OBJECT,
because only QEMU CAN bus specific part is CanBusClientState which
allows it to connect to the CAN bus same way as other CAN controllers
connect to the bus.

> can-host's class structure would define a function pointer corresponding
> to what you have now for the function pointer, more or less---except
> that allocation is handled by QOM and the method only has to do the
> connection.  You would have something like this:
>
> static void can_host_disconnect(CANHost *ch, Error **errp)
> {
>     CANHostClass *chc = CAN_HOST_GET_CLASS(ch);
>
>     chc->disconnect(ch);
> }
>
> static void can_host_connect(CANHost *ch, Error **errp)
> {
>     CANHostClass *chc = CAN_HOST_GET_CLASS(ch);
>     Error *local_err = NULL;
>
>     chc->connect(ch, &local_err);
>     if (local_err) {
>         error_propagate(errp, local_err);
>         return;
>     }
>
>     can_bus_insert_client(ch->bus, &ch->bus_client, local_err);
>     if (local_err) {
>         can_host_disconnect(ch);
>         error_propagate(errp, local_err);
>         return;
>     }
> }
>
> and TYPE_USER_CREATABLE's "complete" method would simply invoke
> can_host_connect.  For can-host-socketcan, chc->connect would be
> assigned something like this:
>
> static void can_host_socketcan_connect(CANHost *ch, Error **errp)
> {
>     CANHostSocketCAN *chs = CAN_HOST_SOCKETCAN(ch);
>
>     s = socket(PF_CAN, SOCK_RAW, CAN_RAW);
>     if (s < 0) {
>         error_setg_errno(errp, errno "CAN_RAW socket create failed");
>         return;
>     }
>
>     addr.can_family = AF_CAN;
>     memset(&ifr.ifr_name, 0, sizeof(ifr.ifr_name));
>     strcpy(ifr.ifr_name, chs->host_dev_name);
>     if (ioctl(s, SIOCGIFINDEX, &ifr) < 0) {
>         error_setg_errno(errp, "host interface %s not available",
>                          chs->host_dev_name);
>         goto fail;
>     }
>     addr.can_ifindex = ifr.ifr_ifindex;
>     ....
> }

Thanks for providing ideas for future development directions.

> In particular, note the difference in error reporting with
> error_report/exit vs. error_setg/error_propagate.  Any call to "exit" is
> probably grounds for instant rejection of your patch. :)

It seems that it is necessary to switch to use realize()
method instead of init() to have initial **errp pointer
in the call chain.

> This also means that you have to check for leaks in the failure paths,
> such as  forgetting to close the PF_CAN socket.

The socket is closed in can_bus_socketcan_cleanup()
in the failure case. g_free(c->rfilter); is there
as well.

Thanks for ideas and review,

Pavel
