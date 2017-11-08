Received: from eggs.gnu.org ([2001:4830:134:3::10]:37667)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eCMuT-0007Fh-3l
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 04:44:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eCMuN-0004RW-3G
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 04:44:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46544)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eCMuM-0004Qr-Sp
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 04:44:31 -0500
Date: Wed, 8 Nov 2017 10:44:21 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20171108094421.ta2wumq36gux3m5s@sirius.home.kraxel.org>
References: <20171108022828.7242-1-f4bug@amsat.org>
	<20171108022828.7242-7-f4bug@amsat.org>
	<20171108090900.GF12670@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20171108090900.GF12670@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 6/6] hw/i386: deprecate the "isapc"
 machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, Alistair Francis <alistair.francis@xilinx.com>, Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On Wed, Nov 08, 2017 at 09:09:00AM +0000, Daniel P. Berrange wrote:
> On Tue, Nov 07, 2017 at 11:28:28PM -0300, Philippe Mathieu-Daud=E9 wrot=
e:
> > Deprecated since 2.9.0, guests should be able to use "pc" instead.
>=20
> Isn't isapc important to allow QEMU to old operating systems that
> predate the PCI era.

They should work fine.  The early pci chipsets like the piix4 have
built-in backward compatibility.  The IDE controller can be driven by
simply accessing the isa ide ports.  Likewise vga.  You can plug in ne2k
(we have both isa and pci variants) for ethernet and sb16 (isa too) for
sound.

That should make guests which don't know anything about pci happy.

> I do recall seeing some messages about specific
> cases where you cannot use the 'pc' machine type and we suggested
> used of 'isapc' instead, but can't remember the exact details..

I'd like to see such use cases where isapc is actually required.

> I know that's not a typical usecase for modern cloud / data center
> virt, but it is interesting for usage of QEMU as a archeology tool,
> so I'm loathe to see this removed unless it is demonstrably causing
> an unacceptable maint burden to keep it.

Well, nobody maintains it.  Nobody tests it.

>From a firmware point of view it *is* quite different from pc.  isapc
has no rom shadowing, so firmware init code paths are different.  isapc
has no resource management, so isa-vga maps the vesa 2.0 framebuffer at
a hardcoded address instead of placing it in a pci bar and the vgabios
has to know where it is.

So there is a non-zero chance that things break by accident.  IIRC we
even had a qemu release with broken isapc in the past ...

cheers,
  Gerd
