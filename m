Received: from eggs.gnu.org ([2001:4830:134:3::10]:45393)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pisa@cmp.felk.cvut.cz>) id 1ee6Ld-0008Ry-Dd
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 16:43:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pisa@cmp.felk.cvut.cz>) id 1ee6LY-0004Ya-Hd
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 16:43:17 -0500
Received: from relay.felk.cvut.cz ([2001:718:2:1611:0:1:0:70]:38488)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pisa@cmp.felk.cvut.cz>) id 1ee6LY-0004Y9-6d
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 16:43:12 -0500
From: Pavel Pisa <pisa@cmp.felk.cvut.cz>
Date: Tue, 23 Jan 2018 22:42:31 +0100
References: <cover.1515960078.git.pisa@cmp.felk.cvut.cz>
	<6408e418-c2b5-61fe-be3d-137ba9fab113@amsat.org>
In-Reply-To: <6408e418-c2b5-61fe-be3d-137ba9fab113@amsat.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <201801232242.31243.pisa@cmp.felk.cvut.cz>
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

On Monday 22 of January 2018 12:35:33 Philippe Mathieu-Daud=C3=A9 wrote:
> Hi Pavel,
>
> On 01/14/2018 05:14 PM, pisa@cmp.felk.cvut.cz wrote:
>
> I think your series is quite ready to get accepted, although I'm not
> sure through with tree it will goes.
>
> Most of my review comments are not blocking issues and might get
> addressed later (like having an abstract sja1000).

Great, I would be happy to reach acceptable state when development
can switch to incremental mode as time allows. I hope than even
actual state is usable from reports (at least for some usescases).

> The principal issue I'd like to discuss with Paolo/Marc-Andr=C3=A9 is the
> chardev backend, they might say it's OK to accept it in this current
> state and refactor the CANBus backend later.

Do you think QOM based? I would like it to be implemented
that way but I need some assistance where to look how this
object kind should be implemented and from which base object
inherit from. But I prefer to left that for later work.

I would definitely like to use some mechanism which allows
to get rid of externally visible pointer and need to assign
it in the stub. It has been my initial idea and your review
sumbled across this hack as well. But I need suggestion what
is the preferred way for QEMU.

When Linux specific object file is linked in then some local
function needs to be called before QOM instances population.
I know how to do that GCC specific/non-portable way

static void __attribute__((constructor)) can_socketcan_setup_variant(void)
{

}

but I expect that something like

module_init()

in can_socketcan.c should be used.

Problem is that there is not module_init
type for plain function in include/qemu/module.h

    MODULE_INIT_BLOCK,
    MODULE_INIT_OPTS,
    MODULE_INIT_QOM,
    MODULE_INIT_TRACE,
    MODULE_INIT_MAX

I expect that QOM object would solve that in future
but I would be happy to left it simple for now.

What is preferred solution there?

> I'd still avoid using directly the socket() syscall and use the QEMU
> socket API instead (also suggested by Daniel).

I have already switched to qemu_socket(), implementation
looks fine and I have tested that it works.
I have tested functionality and updated can-pci branch.

> I have been thinking a bit about how to test some frame operations
> (rather than the PCI devices) and the Linux vcan driver might be a good
> option (Virtual Local CAN Interface). This is also useful to test this
> series without having CAN hardware. How to use vcan might be worth his
> own paragraph in docs/can.txt.
>
> Do you think some of your tests can be added in the QEMU test suite
> (qtests)?

I have added some more infomation into docs file

+ The CAN interface of the host system has to be configured for proper
+ bitrate and set up. Configuration is not propagated from emulated
+ devices through bus to the physical host device. Example configuration
+ for 1 Mbit/s
+
+   ip link set can0 type can bitrate 1000000
+   ip link set can0 up
+
+ Virtual (host local only) can interface can be used on the host
+ side instead of physical interface
+
+   ip link add dev can0 type vcan
+
+ The CAN interface on the host side can be used to analyze CAN
+ traffic with "candump" command which is included in "can-utils".
+
+   candump can0

As for the automatic testing, iproute2 tools are required
on host and guest side (considering use of Linux)
and kernel with CAN drivers support.
Root access is required on the host side to setup CAN
interface. Some simple tool is required. It can be based
on can-utils code or our older canping code for example.

Best wishes,

Pavel
