Received: from eggs.gnu.org ([209.51.188.92]:43451)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=945ec5b1b=Paul.Durrant@citrix.com>)
	id 1gvgAb-0000Lm-NQ
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 05:29:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=945ec5b1b=Paul.Durrant@citrix.com>)
	id 1gvgAZ-0006UP-Qp
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 05:29:05 -0500
Received: from smtp.ctxuk.citrix.com ([185.25.65.24]:7487
	helo=SMTP.EU.CITRIX.COM)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prvs=945ec5b1b=Paul.Durrant@citrix.com>)
	id 1gvgAV-000647-Ne
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 05:29:00 -0500
From: Paul Durrant <Paul.Durrant@citrix.com>
Date: Mon, 18 Feb 2019 10:28:20 +0000
Message-ID: <1dd9342a7ee149f2beaaebc27c72fd15@AMSPEX02CL03.citrite.net>
References: <CAFEAcA-W7AAFsrEkmUSpwqoQic7TDHnPGwnpFB_FQ25ad32n0A@mail.gmail.com>
	<596fc361faea408cabae8a5f41df2e41@AMSPEX02CL03.citrite.net>
	<61c2a38ace454e2d963dcdd89d53737d@AMSPEX02CL03.citrite.net>
	<20190218100919.GB5303@dhcp-200-176.str.redhat.com>
In-Reply-To: <20190218100919.GB5303@dhcp-200-176.str.redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] QEMU xen coverity issues
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: 'Kevin Wolf' <kwolf@redhat.com>
Cc: 'Peter Maydell' <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Anthony Perard <anthony.perard@citrix.com>

> -----Original Message-----
> From: Kevin Wolf [mailto:kwolf@redhat.com]
> Sent: 18 February 2019 10:09
> To: Paul Durrant <Paul.Durrant@citrix.com>
> Cc: 'Peter Maydell' <peter.maydell@linaro.org>; QEMU Developers <qemu-
> devel@nongnu.org>; Anthony Perard <anthony.perard@citrix.com>
> Subject: Re: [Qemu-devel] QEMU xen coverity issues
>=20
> Am 15.02.2019 um 17:20 hat Paul Durrant geschrieben:
> > > -----Original Message-----
> > [snip]
> > > >
> > > > (5) CID 1398649: resource leak in xen_block_drive_create():
> > > >
> > > > In hw/block/xen-block.c xen_block_drive_create() Coverity
> > > > complains that the call "driver_layer =3D qdict_new()" allocates
> > > > memory that's leaked because we don't save the pointer anywhere
> > > > but don't deallocate it before the end of the function either.
> > > > Coverity is not great at understanding our refcounting objects,
> > > > but this does look like either we're missing a qobject_unref()
> > > > or something should be keeping hold of the dictionary. Probably
> > > > best to ask a block layer expert.
> > >
> > > AFAICT nothing will consume the dictionary so it does appear that
> we're
> > > missing an unref here.
> >
> > Testing proves me wrong... This one is a false positive.
>=20
> Hm, but where is it freed?
>=20
> xen_block_blockdev_add() only feeds it to an input visitor, which
> doesn't take ownership of the QDict (and in the first error path, it
> hasn't even done that yet).

Agreed that error path does not free things... that's definitely a leak... =
but attempting to free the QDict's on return from xen_block_blockdev_add() =
certainly causes a seg fault. My assumption was that, having been fed throu=
gh the input visitor and then through the output visitor in qmp_blockdev_ad=
d() that the BlockDriverState eventually takes ownership... but maybe that'=
s not true?

  Paul

>=20
> Kevin
