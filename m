Received: from eggs.gnu.org ([2001:4830:134:3::10]:48571)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1eouDP-0002I5-4I
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 11:59:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1eouDL-0006ZN-VY
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 11:59:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39908)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1eouDL-0006YX-PK
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 11:59:23 -0500
Date: Thu, 22 Feb 2018 09:59:17 -0700
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20180222095917.29eda1d9@w520.home>
In-Reply-To: <CAFEAcA8_VRML=FopCKdGnrPCyZ9MwKokMj60962=tgCNwNT2oA@mail.gmail.com>
References: <20180219111458.25983-1-kraxel@redhat.com>
	<20180219111458.25983-5-kraxel@redhat.com>
	<20180222153740.3zkvjen77uwjqhd2@sirius.home.kraxel.org>
	<CAFEAcA8_VRML=FopCKdGnrPCyZ9MwKokMj60962=tgCNwNT2oA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 4/7] qdev: add hotpluggable to
 DeviceState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Gerd Hoffmann <kraxel@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Tina Zhang <tina.zhang@intel.com>, intel-gvt-dev@lists.freedesktop.org, Kirti Wankhede <kwankhede@nvidia.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Thu, 22 Feb 2018 15:46:17 +0000
Peter Maydell <peter.maydell@linaro.org> wrote:

> On 22 February 2018 at 15:37, Gerd Hoffmann <kraxel@redhat.com> wrote:
> > On Mon, Feb 19, 2018 at 12:14:55PM +0100, Gerd Hoffmann wrote: =20
> >> vfio display support wants disable hotplug for certain devices, because
> >> qemu doesn't support hotplugging display devices and qemu consoles.
> >>
> >> Add a hotpluggable bool to DeviceState, initialize it from
> >> DeviceClass->hotpluggable, update device_get_hotpluggable accordingly.
> >>
> >> Devices can flip the new variable from true to false if needed. =20
> >
> > Alex wants an ack for this one.  Who maintains it these days?
> >
> > MAINTAINERS doesn't list qdev.  For QOM which is closest probably
> > Andreas F=C3=A4rber is listed.  Havn't seen him on the list for a while
> > though.
> >
> > Ok, lets try some usual suspects...
> > Markus? Eric? Paolo? Peter?  Any comments on this one? =20
>=20
> What type of device is only sometimes hotpluggable ?
> The commit message says "display devices" and "consoles",
> but I would expect those to both be types of device which
> have a class which is never hotpluggable, so you can mark
> them non-hotpluggable with the existing class flag rather
> than needing a per-instance flag.

With this series, a vfio-pci device optionally supports a display.  The
vfio-pci device is hotpluggable, but QEMU display support is not.  So
the solution here is to make the vfio-pci device non-hotpluggable only
when it supports and enables a display.

Gerd, is there another solution that the display object is instantiated
separately from the vfio-pci object and the display support in the
vfio-pci device references the display object via an id.  Possibly
vfio-pci could remain hotpluggable while the display class device is
not.  Potentially one display could be switched between multiple
display capable devices, like an input control button on a monitor,
losing signal if none are connected.  Possible?  Clearly I have no idea
how display objects actually work in QEMU.  Thanks,

Alex
