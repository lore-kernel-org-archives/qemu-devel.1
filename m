Received: from eggs.gnu.org ([209.51.188.92]:39071)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=987289301=Paul.Durrant@citrix.com>)
	id 1hAspO-0007rI-Gu
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 05:02:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=987289301=Paul.Durrant@citrix.com>)
	id 1hAspJ-0001qi-7g
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 05:02:02 -0400
From: Paul Durrant <Paul.Durrant@citrix.com>
Date: Mon, 1 Apr 2019 09:01:50 +0000
Message-ID: <b961ee21f8db448fab6b84bb79c37eab@AMSPEX02CL02.citrite.net>
References: <20190327173206.9065-1-paul.durrant@citrix.com>
	<3585a316-6349-b89e-99be-799b055594db@citrix.com>
	<f9a7e4fa5b794cf88593a86923142a87@AMSPEX02CL02.citrite.net>
	<20190328114012.GG1420@perard.uk.xensource.com>
	<28bfdf32-916f-fb55-e2ab-13871b5e0fdd@citrix.com>
	<20190328115619.GC4857@localhost.localdomain>
In-Reply-To: <20190328115619.GC4857@localhost.localdomain>
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
To: 'Kevin Wolf' <kwolf@redhat.com>, Andrew Cooper <Andrew.Cooper3@citrix.com>
Cc: Anthony Perard <anthony.perard@citrix.com>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Stefano Stabellini <sstabellini@kernel.org>, Max
	Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

> -----Original Message-----
> From: Kevin Wolf [mailto:kwolf@redhat.com]
> Sent: 28 March 2019 11:56
> To: Andrew Cooper <Andrew.Cooper3@citrix.com>
> Cc: Anthony Perard <anthony.perard@citrix.com>; Paul Durrant <Paul.Durran=
t@citrix.com>; xen-
> devel@lists.xenproject.org; qemu-block@nongnu.org; qemu-devel@nongnu.org;=
 Stefano Stabellini
> <sstabellini@kernel.org>; Max Reitz <mreitz@redhat.com>; Stefan Hajnoczi =
<stefanha@redhat.com>
> Subject: Re: [Xen-devel] [PATCH v2 0/2] xen-block: fix sector size confus=
ion
>=20
> Am 28.03.2019 um 12:46 hat Andrew Cooper geschrieben:
> > On 28/03/2019 11:40, Anthony PERARD wrote:
> > > On Wed, Mar 27, 2019 at 08:32:28PM +0000, Paul Durrant wrote:
> > >>> -----Original Message-----
> > >>> From: Andrew Cooper
> > >>> Sent: 27 March 2019 18:20
> > >>> To: Paul Durrant <Paul.Durrant@citrix.com>; xen-devel@lists.xenproj=
ect.org; qemu-
> block@nongnu.org;
> > >>> qemu-devel@nongnu.org
> > >>> Cc: Kevin Wolf <kwolf@redhat.com>; Stefano Stabellini <sstabellini@=
kernel.org>; Max Reitz
> > >>> <mreitz@redhat.com>; Stefan Hajnoczi <stefanha@redhat.com>; Anthony=
 Perard
> <anthony.perard@citrix.com>
> > >>> Subject: Re: [Xen-devel] [PATCH v2 0/2] xen-block: fix sector size =
confusion
> > >>>
> > >>> On 27/03/2019 17:32, Paul Durrant wrote:
> > >>>> The Xen blkif protocol is confusing but discussion with the mainta=
iner
> > >>>> has clarified that sector based quantities in requests and the 'se=
ctors'
> > >>>> value advertized in xenstore should always be in terms of 512-byte
> > >>>> units and not the advertised logical 'sector-size' value.
> > >>>>
> > >>>> This series fixes xen-block to adhere to the spec.
> > >>> I thought we agreed that hardcoding things to 512 bytes was the wro=
ng
> > >>> thing to do.
> > >> To some extent we decided it was the *only* thing to do.
> > >>
> > >>> I was expecting something like:
> > >>>
> > >>> 1) Clarify the spec with the intended meaning, (which is what some
> > >>> implementations actually use already) and wont cripple 4k datapaths=
.
> > >>> 2) Introduce a compatibility key for "I don't rely on sector-size b=
eing
> > >>> 512", which fixed implementations should advertise.
> > >>> 3) Specify that because of bugs in the spec which got out into the =
wild,
> > >>> drivers which don't find the key being advertised by the other end
> > >>> should emulate sector-size=3D512 for compatibility with broken
> > >>> implementations.
> > >> Yes, that's how we are going to fix things.
> > >>
> > >>> Whatever the eventual way out, the first thing which needs to happe=
n is
> > >>> an update to the spec, before actions are taken to alter existing
> > >>> implementations.
> > >> Well the implementation is currently wrong w.r.t. the spec and these=
 patches fix that. As long as
> sector-size remains at 512 then no existing frontend should break, so I g=
uess you could argue that
> patch #2 should also make sure that sector-size is also 512... but that i=
s not yet in the spec.
> > >> I guess I'm ok to defer patch #2 until a revised spec. is agreed, bu=
t the ship has already sailed
> as far as patch #1 goes.
> > >>
> > >> Anthony, thoughts?
> > > So QEMU used to always set "sector-size" to 512, and used that for
> > > request. The new implementation (not released yet) doesn't do that
> > > anymore, and may set "sector-size" to a different value and used that
> > > for requests.
> > >
> > > patch #1 is one way to fix the requests (and avoid regression) and
> > > more clearly spell out the weird thing about the spec.
> > >
> > > I also think patch #2 is too soon and should point to a commit in
> > > xen.git instead of a thread on xen-devel.
> > >
> > > In the meantime, we should probably set "sector-size" to 512, like QE=
MU
> > > used to do anyway, with a comment about the fact that different
> > > implementations uses sector-size differently and a value of 512 would
> > > work fine.
> >
> > Hmm - I hadn't realised this is an unreleased issue in qemu.
> >
> > So, Qemu used to unconditionally set sector-size=3D512, and your work t=
o
> > qdev-ify everything introduced a change which has identified a
> > spec/protocol issue?
>=20
> The old implementation has the sector size hardcoded:
>=20
>     #define BLOCK_SIZE  512
>=20
> Whereas the qdevified version uses DEFINE_BLOCK_PROPERTIES(), which
> includes user-visible options for logical/physical_block_size.
>=20
> So before, you couldn't even define a different sector size and the
> question whether 512 or the sector size should be used didn't make a
> difference anyway.
>=20
> > If so, then I think it is fine for this series to state (much more
> > clearly than it does) that it is returning qemu's behaviour to match th=
e
> > currently released version, because we've discovered an issue in the
> > spec/protocol, and that we will subsequently work address the issue in
> > the spec and provide a forwards path which doesn't involve nailing our
> > feet to the floor.
>=20
> The closest thing to returning to the old behaviour would be erroring
> out during device initialisation if logical_block_size !=3D 512.

One thing I've not figured out... If I create a blockdev in QEMU that is po=
inting at a real device with a logical_block_size of 4k, will the QEMU bloc=
k layer perform the necessary read-modify-write cycles for accesses < 4k? I=
OW would it be safe to always advertise a size of 512 to a frontend?

The problem with erroring out during device init is that it does not give u=
s a way of fixing things in future, as the frontend has not started at that=
 time and thus we'd have no idea whether it could use whatever protocol fix=
 we come up with. I think the only thing the backend could do is refuse to =
connect to an old frontend if logical_block_size !=3D 512.

  Paul

>=20
> Kevin
