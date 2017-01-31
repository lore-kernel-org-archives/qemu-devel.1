Received: from eggs.gnu.org ([2001:4830:134:3::10]:57669)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cYf7x-0001yh-32
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 15:34:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cYf7t-0007pA-5N
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 15:34:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60734)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cYf7s-0007p2-S7
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 15:34:05 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EBDE2155E4
	for <qemu-devel@nongnu.org>; Tue, 31 Jan 2017 20:34:03 +0000 (UTC)
Message-ID: <1485894840.1076.45.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 31 Jan 2017 21:34:00 +0100
In-Reply-To: <1485788877-3823-1-git-send-email-abologna@redhat.com>
References: <1485788877-3823-1-git-send-email-abologna@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] q35: Provide improved sample configurations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrea Bolognani <abologna@redhat.com>
Cc: qemu-devel@nongnu.org, drjones@redhat.com

  Hi,

> Both configuration file are full commented, neatly
> organized, and use paravirtualized devices instead of
> emulated devices whenever possible for a better user
> experience. Moreover, they follow the PCI Express
> Guidelines (docs/pcie.txt) for their topology.
> ---
> I plan to provide similar sample configurations for
> aarch64/virt guests once the generic PCIe Root Ports
> have been merged.
>=20
>  docs/q35-chipset.cfg   | 152 -------------------------------------------=
-----

Please leave q35-chipset.cfg there.

The purpose of q35-chipset.cfg is to document how you can build a
virtual machine which comes as close as possible to physical hardware
with q35 northbridge and ich9 southbridge.  So it is pretty much
fixed ;)  Maybe it makes sense to add a comment at the top clarifying
this.  The (currently commented out) pcie switch configuration can be
dropped or moved to another file.  And maybe we can add the ethernet
device meanwhile (has the e1000e emulation a ich9 device?).

Adding another sample config focusing on pcie and good performance is
perfectly fine of course.

>  docs/q35-graphical.cfg | 154 +++++++++++++++++++++++++++++++++++++++++++=
++++++
>  docs/q35-serial.cfg    | 110 +++++++++++++++++++++++++++++++++++

Note that you can specify -readconfig multiple times, so you can split
out common stuff and ask people to run "qemu -readconfig
q35-paravirt-base.cfg -readconfig q35-paravirt-$style.cfg"

> +# PCIe controllers
> +# =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +#
> +# We create four PCIe Root Ports: the first three are used
> +# by devices defined below, while the last one is left
> +# unused so that one more device can be hotplugged.
> +
> +[device "pci.1"]
> +  driver =3D "ioh3420"
> +  bus =3D "pcie.0"
> +  addr =3D "0x2"
> +  port =3D "0x10"
> +  chassis =3D "1"

I'd suggest to create 8 pcie root ports, as multifunction device in a
single slot, following pcie.txt suggestions.

And I'd pick slot 1c for that, simply because the pcie root ports are in
that slot on physical hardware, but that is just cosmetic and a matter
of taste.

> +[device "usb"]
> +  driver =3D "nec-usb-xhci"
> +  bus =3D "pci.3"
> +  addr =3D "0x0"

Good, needs promotion ;)

> +[device "keyboard"]
> +  driver =3D "usb-kbd"
> +  bus =3D "usb.0"
> +  port =3D "1"

We have a ps/2 keyboard anyway, so this is pointless (on x86, arm is a
different story of course).

> +[device "tablet"]
> +  driver =3D "usb-tablet"
> +  bus =3D "usb.0"
> +  port =3D "2"

There is also virtio-tablet, but for a generic config usb is probably
the better choice as virtio-tablet is supported by modern linux only (on
x86, on arm we have only modern linux anyway so picking virtio-tablet
should be fine).

> +# Video card
> +# =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +#
> +# We plug the QXL video card directly into the PCIe Root
> +# Bus as it is a legacy PCI device; this way, we can reduce
> +# the number of PCIe controllers in the guest.
> +
> +[device "video"]
> +  driver =3D "qxl-vga"
> +  bus =3D "pcie.0"
> +  addr =3D "0x1"

Note that you can put multiple devices into a single root port, using
multifunction.  I have a guest here which looks like this:

root@localhost ~# lspci -vt
-[0000:00]-+-00.0  Intel Corporation 82G33/G31/P35/P31 Express DRAM
Controller
           +-02.0  Device 1234:1111
           +-1b.0  Intel Corporation 82801I (ICH9 Family) HD Audio
Controller
           +-1c.0-[01]----00.0  Red Hat, Inc Virtio SCSI
           +-1c.1-[02]----00.0  Red Hat, Inc Virtio network device
           +-1c.2-[03]--
           +-1c.3-[04]--
           +-1c.4-[05]--+-00.0  Red Hat, Inc Virtio console
           |            +-00.1  Red Hat, Inc Virtio memory balloon
           |            \-00.2  Red Hat, Inc Virtio input
           +-1c.5-[06]----00.0  NEC Corporation uPD720200 USB 3.0 Host
Controller
           +-1c.6-[07]--
           +-1c.7-[08]--
           +-1e.0-[09-0a]----00.0-[0a]--
           +-1f.0  Intel Corporation 82801IB (ICH9) LPC Interface
Controller
           +-1f.2  Intel Corporation 82801IR/IO/IH (ICH9R/DO/DH) 6 port
SATA Controller [AHCI mode]
           \-1f.3  Intel Corporation 82801I (ICH9 Family) SMBus
Controller

cheers,
  Gerd
