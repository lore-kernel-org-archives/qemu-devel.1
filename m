Received: from eggs.gnu.org ([2001:4830:134:3::10]:35504)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cH5yy-0007vB-96
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 04:36:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cH5yt-0005zV-F2
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 04:36:16 -0500
Message-ID: <1481708165.8440.19.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 14 Dec 2016 10:36:05 +0100
In-Reply-To: <282345c0-fad3-eb66-63c5-3d1d24ab6d6d@redhat.com>
References: <1481633076-24521-1-git-send-email-thuth@redhat.com>
	<1481637176.27088.132.camel@redhat.com>
	<282345c0-fad3-eb66-63c5-3d1d24ab6d6d@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] hw/ppc/spapr: Fix boot path of usb-host
 storage devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org

  Hi,

> >> in the /chosen/qemu,boot-list property. SLOF, however, probes the
> >> USB device, recognizes that it is a storage device and thus changes
> >> its name to "storage", and additionally adds a child node for the
> >> SCSI LUN, so the correct boot path in SLOF is something like
> >> "/pci@800000020000000/usb@0/storage@1/disk@101000000000000" instead.

Sure this is correct?

usb-storage (aka virtual usb stick) creates paths like this:

  /pci@i0cf8/usb@1,2/storage@1/channel@0/disk@0,0

i.e. there is a extra channel element (probably for host adapters with
multiple scsi busses).

> >> So when we detect an USB mass storage device with SCSI interface,
> >> we've got to adjust the firmware boot-device path properly, so that
> >> SLOF can automatically boot from the device.

> > Any reason why this is hidden in ppc/spapr?
> >=20
> > usb-host could implement the ->fw_name callback instead to create a nam=
e
> > depending on the device type ...

> The naming is specific to SLOF ... not sure what happens with other
> firmware implementations, so spapr.c sounds like the better place to me
> right now.

If usb-host (and usb-redir too btw) create paths identical to the ones
created by usb-storage.  Existing firmware should cope just fine
(assuming bootindex for usb-storage works).

cheers,
  Gerd
