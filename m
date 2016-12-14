Received: from eggs.gnu.org ([2001:4830:134:3::10]:59688)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cHHB7-00056a-8J
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 16:33:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cHHB4-0005Y8-5E
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 16:33:33 -0500
References: <1481633076-24521-1-git-send-email-thuth@redhat.com>
	<1481637176.27088.132.camel@redhat.com>
	<282345c0-fad3-eb66-63c5-3d1d24ab6d6d@redhat.com>
	<1481708165.8440.19.camel@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <421b6da7-1197-83a4-a8a1-e34bcf15904e@redhat.com>
Date: Wed, 14 Dec 2016 22:33:24 +0100
MIME-Version: 1.0
In-Reply-To: <1481708165.8440.19.camel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org

On 14.12.2016 10:36, Gerd Hoffmann wrote:
>   Hi,
>=20
>>>> in the /chosen/qemu,boot-list property. SLOF, however, probes the
>>>> USB device, recognizes that it is a storage device and thus changes
>>>> its name to "storage", and additionally adds a child node for the
>>>> SCSI LUN, so the correct boot path in SLOF is something like
>>>> "/pci@800000020000000/usb@0/storage@1/disk@101000000000000" instead.
>=20
> Sure this is correct?

Yes, this is what SLOF is using / expecting.

> usb-storage (aka virtual usb stick) creates paths like this:
>=20
>   /pci@i0cf8/usb@1,2/storage@1/channel@0/disk@0,0
>=20
> i.e. there is a extra channel element (probably for host adapters with
> multiple scsi busses).

That's true for the default case, but for the pseries machine, there is
already code that changes the boot path for virtual usb-storage devices,
see the function spapr_get_fw_dev_path() :

        ... else if (usb) {
            /*
             * We use SRP luns of the form 01000000 | (usb-port << 16) | =
lun
             * in the top 32 bits of the 64-bit LUN
             */
            unsigned usb_port =3D atoi(usb->port->path);
            unsigned id =3D 0x1000000 | (usb_port << 16) | d->lun;
            return g_strdup_printf("%s@%"PRIX64, qdev_fw_name(dev),
                                   (uint64_t)id << 32);
        }

>>>> So when we detect an USB mass storage device with SCSI interface,
>>>> we've got to adjust the firmware boot-device path properly, so that
>>>> SLOF can automatically boot from the device.
>=20
>>> Any reason why this is hidden in ppc/spapr?
>>>
>>> usb-host could implement the ->fw_name callback instead to create a n=
ame
>>> depending on the device type ...
>=20
>> The naming is specific to SLOF ... not sure what happens with other
>> firmware implementations, so spapr.c sounds like the better place to m=
e
>> right now.
>=20
> If usb-host (and usb-redir too btw) create paths identical to the ones
> created by usb-storage.  Existing firmware should cope just fine
> (assuming bootindex for usb-storage works).

Which firmware can deal with these original device paths with "channel@0"
in it? Certainly not SLOF. Maybe OpenBIOS? Does OpenBIOS support USB stor=
age
devices?

 Thomas
