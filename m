Received: from eggs.gnu.org ([209.51.188.92]:49665)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=987289301=Paul.Durrant@citrix.com>)
	id 1hAtY7-0000Qq-AH
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 05:48:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=987289301=Paul.Durrant@citrix.com>)
	id 1hAtY6-0000Us-CM
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 05:48:15 -0400
From: Paul Durrant <Paul.Durrant@citrix.com>
Date: Mon, 1 Apr 2019 09:48:08 +0000
Message-ID: <02a2ce18ff4a4170beaa07f38bc77290@AMSPEX02CL02.citrite.net>
References: <20190327173206.9065-1-paul.durrant@citrix.com>
	<3585a316-6349-b89e-99be-799b055594db@citrix.com>
	<f9a7e4fa5b794cf88593a86923142a87@AMSPEX02CL02.citrite.net>
	<20190328114012.GG1420@perard.uk.xensource.com>
	<28bfdf32-916f-fb55-e2ab-13871b5e0fdd@citrix.com>
	<20190328115619.GC4857@localhost.localdomain>
	<b961ee21f8db448fab6b84bb79c37eab@AMSPEX02CL02.citrite.net>
	<20190401093405.GA4935@localhost.localdomain>
In-Reply-To: <20190401093405.GA4935@localhost.localdomain>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [Xen-devel] [PATCH v2 0/2] xen-block: fix sector
 size confusion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: 'Kevin Wolf' <kwolf@redhat.com>
Cc: Andrew Cooper <Andrew.Cooper3@citrix.com>, Anthony Perard <anthony.perard@citrix.com>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Stefano Stabellini <sstabellini@kernel.org>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

> -----Original Message-----
[snip]
> > >
> > > The old implementation has the sector size hardcoded:
> > >
> > >     #define BLOCK_SIZE  512
> > >
> > > Whereas the qdevified version uses DEFINE_BLOCK_PROPERTIES(), which
> > > includes user-visible options for logical/physical_block_size.
> > >
> > > So before, you couldn't even define a different sector size and the
> > > question whether 512 or the sector size should be used didn't make a
> > > difference anyway.
> > >
> > > > If so, then I think it is fine for this series to state (much more
> > > > clearly than it does) that it is returning qemu's behaviour to matc=
h the
> > > > currently released version, because we've discovered an issue in th=
e
> > > > spec/protocol, and that we will subsequently work address the issue=
 in
> > > > the spec and provide a forwards path which doesn't involve nailing =
our
> > > > feet to the floor.
> > >
> > > The closest thing to returning to the old behaviour would be erroring
> > > out during device initialisation if logical_block_size !=3D 512.
> >
> > One thing I've not figured out... If I create a blockdev in QEMU that
> > is pointing at a real device with a logical_block_size of 4k, will the
> > QEMU block layer perform the necessary read-modify-write cycles for
> > accesses < 4k? IOW would it be safe to always advertise a size of 512
> > to a frontend?
>=20
> Yes, for 512 accesses on native 4k disks with O_DIRECT, the QEMU block
> layer performs the necessary RMW. Of course, it still comes with a
> performance penalty, so you want to avoid such setups, but they do work.
>=20

Ok, that's good. Thanks.

> > The problem with erroring out during device init is that it does not
> > give us a way of fixing things in future, as the frontend has not
> > started at that time and thus we'd have no idea whether it could use
> > whatever protocol fix we come up with. I think the only thing the
> > backend could do is refuse to connect to an old frontend if
> > logical_block_size !=3D 512.
>=20
> I was just thinking of getting back to the old state, with a quick fix
> (by making the problematic new setting inaccessible) for the bug in 4.0
> that could possible be merged today or tomorrow for rc2.
>=20

Ok, I see what you mean. I'll modify and resubmit patch #1 today.

> What you need to do for actually supporting 4k disks in the long term
> (QEMU 4.1 or later) depends on what the drivers look like currently and
> is a separate discussion.
>=20

Yes, agreed.

  Paul

> Kevin
