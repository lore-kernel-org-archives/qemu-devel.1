Received: from eggs.gnu.org ([2001:4830:134:3::10]:41518)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1djmjw-00047b-LZ
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 09:27:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1djmjs-0000W8-NY
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 09:27:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56222)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1djmjs-0000VL-I3
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 09:27:32 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 95F9EC0587F2
	for <qemu-devel@nongnu.org>; Mon, 21 Aug 2017 13:27:31 +0000 (UTC)
Message-ID: <1503322045.26016.21.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 21 Aug 2017 15:27:25 +0200
In-Reply-To: <20170809050846-mutt-send-email-mst@kernel.org>
References: <20170808224750.23904-1-marcandre.lureau@redhat.com>
	<20170809050846-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] virtio-input: send rel-wheel events for
 wheel buttons
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, =?ISO-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org

  Hi,

> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.select=C2=A0=C2=
=A0=C2=A0=C2=A0=3D VIRTIO_INPUT_CFG_EV_BITS,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.subsel=C2=A0=C2=
=A0=C2=A0=C2=A0=3D EV_REL,
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.size=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=3D 1,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.size=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=3D 2,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.u.bitmap=C2=A0=
=C2=A0=3D {
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0(1 << REL_X) | (1 << REL_Y),
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0(1 << REL_X) | (1 << REL_Y),=C2=A0=C2=A0(1 << (REL_WHEEL - 8))
>=20
> Works only when REL_WHEEL is between 8 and 15.
> Add BUILD_BUG_ON?

Not needed IMO, REL_WHEEL value is kernel/userspace abi and will never
change.

>=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0},
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0},
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0{ /* end of list */ },
>=20
> Is it problematic e.g. if you migrate from a host with REL_WHEEL
> to one without? Should we maintain a version without REL_WHEEL
> for old machine types?

Yes, we need a compat property.

Possibly it is easier to fix on the guest side, assuming it is actually
needed (see other reply).

cheers,
  Gerd
