Received: from eggs.gnu.org ([2001:4830:134:3::10]:33756)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cHSKt-0007tu-RT
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 04:28:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cHSKq-0007lw-NM
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 04:28:23 -0500
Message-ID: <1481794097.21413.11.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 15 Dec 2016 10:28:17 +0100
In-Reply-To: <421b6da7-1197-83a4-a8a1-e34bcf15904e@redhat.com>
References: <1481633076-24521-1-git-send-email-thuth@redhat.com>
	<1481637176.27088.132.camel@redhat.com>
	<282345c0-fad3-eb66-63c5-3d1d24ab6d6d@redhat.com>
	<1481708165.8440.19.camel@redhat.com>
	<421b6da7-1197-83a4-a8a1-e34bcf15904e@redhat.com>
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

> That's true for the default case, but for the pseries machine, there is
> already code that changes the boot path for virtual usb-storage devices,
> see the function spapr_get_fw_dev_path() :
>=20
>         ... else if (usb) {
>             /*
>              * We use SRP luns of the form 01000000 | (usb-port << 16) | =
lun
>              * in the top 32 bits of the 64-bit LUN
>              */
>             unsigned usb_port =3D atoi(usb->port->path);
>             unsigned id =3D 0x1000000 | (usb_port << 16) | d->lun;
>             return g_strdup_printf("%s@%"PRIX64, qdev_fw_name(dev),
>                                    (uint64_t)id << 32);
>         }

Hmm, I thought the point of using standard open firmware paths was that
we don't need hacks like this.  Looks like things are not *that*
standardized then if some archs need extra tweaks ...

But if that is needed for pseries *anyway* it doesn't hurt to do the
same for usb-host.

> > If usb-host (and usb-redir too btw) create paths identical to the ones
> > created by usb-storage.  Existing firmware should cope just fine
> > (assuming bootindex for usb-storage works).
>=20
> Which firmware can deal with these original device paths with "channel@0"
> in it? Certainly not SLOF. Maybe OpenBIOS? Does OpenBIOS support USB stor=
age
> devices?

seabios does, and I expect ovmf too (didn't test though).

cheers,
  Gerd
