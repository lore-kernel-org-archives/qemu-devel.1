Received: from eggs.gnu.org ([2001:4830:134:3::10]:42567)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pisa@cmp.felk.cvut.cz>) id 1ecWmN-00056p-Ke
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 08:32:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pisa@cmp.felk.cvut.cz>) id 1ecWmK-00008z-Fy
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 08:32:23 -0500
Received: from relay.felk.cvut.cz ([2001:718:2:1611:0:1:0:70]:46104)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pisa@cmp.felk.cvut.cz>) id 1ecWmK-00007J-61
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 08:32:20 -0500
From: Pavel Pisa <pisa@cmp.felk.cvut.cz>
Date: Fri, 19 Jan 2018 14:28:05 +0100
References: <cover.1515960078.git.pisa@cmp.felk.cvut.cz>
	<ba1a251965e9b9ee62d32e8580c7a041fb423c36.1515960078.git.pisa@cmp.felk.cvut.cz>
	<ed771781-5985-0998-cec2-71bdeccd03d4@amsat.org>
In-Reply-To: <ed771781-5985-0998-cec2-71bdeccd03d4@amsat.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <201801191428.05659.pisa@cmp.felk.cvut.cz>
Subject: Re: [Qemu-devel] [PATCH V4 1/7] CAN bus simple messages transport
 implementation for QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org, Marek Vasut <marex@denx.de>, Oliver Hartkopp <socketcan@hartkopp.net>, Stefan Hajnoczi <stefanha@gmail.com>, Deniz Eren <deniz.eren@icloud.com>, Oleksij Rempel <o.rempel@pengutronix.de>, Konrad Frederic <frederic.konrad@adacore.com>, Jan Kiszka <jan.kiszka@siemens.com>

Hello Philippe,

On Friday 19 of January 2018 13:38:11 Philippe Mathieu-Daud=C3=A9 wrote:
> On 01/14/2018 05:14 PM, pisa@cmp.felk.cvut.cz wrote:
> > From: Pavel Pisa <pisa@cmp.felk.cvut.cz>
> >
> > +extern int (*can_bus_connect_to_host_variant)(CanBusState *bus,
> > +                                              const char *name);
>
> Isn't extern (*func) an anti-pattern?
> One might be tempted to call it without checking it is non-NULL...
>
> Please declare it as a function, and using a static pointer, i.e.:
>
> typedef int (*can_bus_connect_to_host_variant_t)(CanBusState *bus,
>                                        const char *name);
>
>
> static can_bus_connect_to_host_variant_t
> can_bus_connect_to_host_variant_handler;
>
> void
> set_can_bus_connect_to_host_variant(can_bus_connect_to_host_variant_t
> handler)
> {
>     can_bus_connect_to_host_variant_handler =3D handler;
> }
>
> int can_bus_connect_to_host_variant(CanBusState *bus,
>                           const char *name)
> {
>     if (!can_bus_connect_to_host_variant_handler) {
>         return ERROR;
>     }
>     return can_bus_connect_to_host_variant_handler(bus, name);
> }


Yes, that has been my initial idea but then I need
some way how to setup variant from can_socketcan.c
when it is linked in

Something like

static void __attribute__((constructor)) can_socketcan_setup_variant(void)
{

}

or

module_init()

or

in can_socketcan.c or have there some QOM object which
type initialization setups pointer early before
individual instances of kvaser_pci

Thanks for suggestion in advance,

Pavel
