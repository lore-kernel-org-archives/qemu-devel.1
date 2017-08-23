Received: from eggs.gnu.org ([2001:4830:134:3::10]:59252)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dkZIA-0000iX-5D
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 13:18:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dkZI5-0006Lo-6G
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 13:18:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58569)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dkZI4-0006LG-W1
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 13:18:05 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CB7C7C0467DE
	for <qemu-devel@nongnu.org>; Wed, 23 Aug 2017 17:18:03 +0000 (UTC)
Date: Wed, 23 Aug 2017 14:17:49 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170823171749.GP19998@localhost.localdomain>
References: <20170814215748.5158-1-ehabkost@redhat.com>
	<20170814215748.5158-13-ehabkost@redhat.com>
	<1503315859.26016.9.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <1503315859.26016.9.camel@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC v4 12/13] usb: enumerate_slots implementation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Laine Stump <laine@redhat.com>

On Mon, Aug 21, 2017 at 01:44:19PM +0200, Gerd Hoffmann wrote:
>   Hi,
>=20
> -ENOCONTEXT
>=20
> What is the use case?

I want to let libvirt know what are the available
slots/ports/addresses for devices in a machine, before it uses
device_add or -device.  This is useful when the machine creates
some devices implicitly, when different machine-types provide
different bus topologies, or when a device was created with no
explicit slot/port/address options.

Currently libvirt work around the lack of such interface by
hardcoding information on the implicitly-created devices/buses
and available slots for each machine-type.  See, for example,
src/qemu/qemu_domain_address.c in the libvirt source tree.

>=20
> > +=A0=A0=A0=A0QTAILQ_FOREACH(port, l, next) {
> > +=A0=A0=A0=A0=A0=A0=A0=A0DeviceSlotInfo *slot =3D make_slot(BUS(bus))=
;
> > +=A0=A0=A0=A0=A0=A0=A0=A0/*
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0* TODO: should the "bus" option be includ=
ed, or is
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0* "port" enough to identify the USB bus +=
 port?
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0*/
>=20
> Yes, bus must be included, port alone isn't enough in case multiple usb
> host adapters are present.

Thanks!

--=20
Eduardo
