Received: from eggs.gnu.org ([2001:4830:134:3::10]:57596)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pisa@cmp.felk.cvut.cz>) id 1eca6V-000852-0r
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 12:05:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pisa@cmp.felk.cvut.cz>) id 1eca6Q-0000yC-2M
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 12:05:22 -0500
Received: from relay.felk.cvut.cz ([2001:718:2:1611:0:1:0:70]:65292)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pisa@cmp.felk.cvut.cz>) id 1eca6P-0000vz-7Y
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 12:05:17 -0500
From: Pavel Pisa <pisa@cmp.felk.cvut.cz>
Date: Fri, 19 Jan 2018 18:04:31 +0100
References: <cover.1515960078.git.pisa@cmp.felk.cvut.cz>
	<ba1a251965e9b9ee62d32e8580c7a041fb423c36.1515960078.git.pisa@cmp.felk.cvut.cz>
	<ed771781-5985-0998-cec2-71bdeccd03d4@amsat.org>
In-Reply-To: <ed771781-5985-0998-cec2-71bdeccd03d4@amsat.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <201801191804.31746.pisa@cmp.felk.cvut.cz>
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
> > diff --git a/hw/can/Makefile.objs b/hw/can/Makefile.objs
> > new file mode 100644
> > index 0000000000..1028d7c455
> > --- /dev/null
> > +++ b/hw/can/Makefile.objs
> > @@ -0,0 +1,6 @@
> > +# CAN bus interfaces emulation and infrastructure
> > +
> > +ifeq ($(CONFIG_CAN_CORE),y)
> > +common-obj-y +=3D can_core.o
>
> Please follow QEMU style:
>
> common-obj-$(CONFIG_CAN_BUS) +=3D can_core.o

I agree that in the first patch it is not logical
to use if but problem is that final Makefile.objs
needs to resolve operating system logic and other
conditions.

ifeq ($(CONFIG_CAN_BUS),y)
common-obj-y +=3D can_core.o
ifeq ($(CONFIG_LINUX),y)
common-obj-y +=3D can_socketcan.o
else
common-obj-y +=3D can_host_stub.o
endif
common-obj-$(CONFIG_CAN_SJA1000) +=3D can_sja1000.o
common-obj-$(CONFIG_CAN_PCI) +=3D can_kvaser_pci.o
common-obj-$(CONFIG_CAN_PCI) +=3D can_pcm3680_pci.o
common-obj-$(CONFIG_CAN_PCI) +=3D can_mioe3680_pci.o
endif

If there is Kconfig style system
controlling mutual options combination then plain
common-obj-$(CONFIG_*) would work but it is not
the case and I have followed seen in another QEMU=20

I have followed style found in another subsystems

qemu-git/hw/smbios/Makefile.objs

ifeq ($(CONFIG_SMBIOS),y)
common-obj-y +=3D smbios.o
common-obj-$(CONFIG_IPMI) +=3D smbios_type_38.o
common-obj-$(call lnot,$(CONFIG_IPMI)) +=3D smbios_type_38-stub.o
else
common-obj-y +=3D smbios-stub.o
endif

common-obj-$(CONFIG_ALL) +=3D smbios-stub.o
common-obj-$(CONFIG_ALL) +=3D smbios_type_38-stub.o

qemu-git/hw/timer/Makefile.objs

=2E..
=2E..
qemu-git/hw/vfio/Makefile.objs

I am not sure how to resolve these conditions better way.

Best wishes,

Pavel
