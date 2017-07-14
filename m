Received: from eggs.gnu.org ([2001:4830:134:3::10]:33901)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dW0US-000298-5c
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 09:18:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dW0UO-0004ML-VV
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 09:18:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52684)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1dW0UO-0004Lu-M6
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 09:18:36 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7B99EC0467DE
	for <qemu-devel@nongnu.org>; Fri, 14 Jul 2017 13:18:35 +0000 (UTC)
Date: Fri, 14 Jul 2017 14:18:31 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170714131831.GA17616@stefanha-x1.localdomain>
References: <20170710072027.7948-1-famz@redhat.com>
	<20170711145813.GX17792@stefanha-x1.localdomain>
	<20170712110633.GB11040@lemon>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FL5UXtIhxfXey3p5"
Content-Disposition: inline
In-Reply-To: <20170712110633.GB11040@lemon>
Subject: Re: [Qemu-devel] [PATCH RFC 0/5] Introduce "-object iothread-group"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com


--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 12, 2017 at 07:06:33PM +0800, Fam Zheng wrote:
> On Tue, 07/11 15:58, Stefan Hajnoczi wrote:
> > On Mon, Jul 10, 2017 at 03:20:22PM +0800, Fam Zheng wrote:
> > > Last time we've looked at "-object iothread,spawns=3DN" but it was a =
bit abusive.
> > > A dedicated "iothread-group" class is cleaner from the interface poin=
t of view.
> > > This series does that.
> > >=20
> > > It has the same set of poll parameters as the existing "iothread" obj=
ect, plus
> > > a "size" option to specify how many threads to start. Using iothread-=
group
> > > doesn't require the user to explicitly create the contained IOThreads=
=2E The
> > > IOThreads are created by the group object.
> > >=20
> > > Internally, IOThreads share one AioContext.  This is to make it easie=
r to adapt
> > > this to the current data plane code (see the last patch). But it is an
> > > implementation detail, and will change depending on the block layer m=
ultiqueue
> > > needs.
> > >=20
> > > TODO:
> > >=20
> > > - qmp_query_iothread_groups, in addition to proper QOM @child propert=
y from
> > >   IOThreadGroup to its IOThread instances.
> > > - Add virtio-scsi.
> > > - Variant of iothread_stop_all().
> > >=20
> > > Fam Zheng (5):
> > >   aio: Wrap poll parameters into AioContextPollParams
> > >   iothread: Don't error on windows
> > >   iothread: Extract iothread_start
> > >   Introduce iothread-group
> > >   virtio-blk: Add iothread-group property
> > >=20
> > >  Makefile.objs                   |   2 +-
> > >  hw/block/dataplane/virtio-blk.c |  18 ++--
> > >  hw/block/virtio-blk.c           |   6 ++
> > >  include/block/aio.h             |  18 ++--
> > >  include/hw/virtio/virtio-blk.h  |   2 +
> > >  include/sysemu/iothread.h       |  35 ++++++-
> > >  iothread-group.c                | 210 ++++++++++++++++++++++++++++++=
++++++++++
> > >  iothread.c                      |  97 +++++++++----------
> > >  util/aio-posix.c                |  10 +-
> > >  util/aio-win32.c                |   8 +-
> > >  10 files changed, 328 insertions(+), 78 deletions(-)
> > >  create mode 100644 iothread-group.c
> >=20
> > I reviewed QOM "foo[*]" array syntax but it's very limited.  Basically
> > all it does it append the new property to foo[0], foo[1], ... (i.e. it
> > allocates an index).  AFAICT there is no way to specify an array
> > property and really arrays are just individual properties.
> >=20
> > Daniel Berrange has a patch for non-scalar properties:
> > "[PATCH v14 15/21] qom: support non-scalar properties with -object"
> > https://patchwork.kernel.org/patch/9358503/
> >=20
> > I think the challenge with existing "[*]" or pre-allocated "foo[0]",
> > "foo[1]", ... is that they don't support variable-sized arrays via QAPI.
>=20
> Plus I'm not a fan of such a "spelling out indexes explicitly" syntax. It=
 makes
> me feel like a slave of a poorly coded programme. With it we'll avoid open
> coding an iothread group class in QEMU, but will ask the user to "open ty=
pe"
> group configurations.

Indexes are necessary if the user wants to remove, swap, etc elements
later, so they do serve a purpose.  Sometimes they might not be
necessary.

> > When the virtio-blk-pci object is realized it can loop over iothread[*]
> > properties to set them up (if necessary).
> >=20
> > Your current RFC series uses a single AioContext in IOThreadGroup.  I
> > think something similar can be achieved with an iothread property:
> >=20
> >   -object iothread,id=3Diothread1,share-event-loop-with=3Diothread0
> >=20
> > The reason I am suggesting this approach is to keep IOThread as the
> > first-class object.  Existing QMP APIs continue to apply to all objects.
> > We avoid introducing an ad-hoc group object just for IOThread.
>=20
> Another possibility is to introduce 1) a "TYPE_GROUPABLE" InterfaceInfo t=
hat
> will add a ".group" str property to IOThread, and build a generic group o=
bject
> out of the objects sharing the same .group name; 2) a qdev prop
> DEFINE_PROP_LINK_TO_GROUP() that can be used to reference a QOM object gr=
oup
> from virtio-blk/scsi. That way it is not specific to IOThread. (Since I a=
m not
> QOM expert, this is basically brainstorming.)

What you describe sounds like qom/container.c except QOM links are used
instead of a QOM child relationship.

No new QOM interface is necessary in order to do this - the objects in a
group don't have to be aware that they are being grouped.

Stefan

--FL5UXtIhxfXey3p5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZaMSnAAoJEJykq7OBq3PIuk0H/33Dk5FZtKwruXTaCLPwZzqZ
06D2N9HHJ+0B/winbHnvcwBhcjPRQKF6cR4HqK4FKA6uCdlAeA4C3uNWwlQ1XEwI
SnKHAGbe2bjYUm0MU2TkGZVhrfQur0SBBda9adbrqNFMLEExNNUPDrYALPW7uQgJ
h1G7KdKQb2O86j3sotO8kxyJWh/AFMeET3kkg1oLgLOWEhSVg1pYv5+BO7OfSjjU
RC5PIlO9W9W4Ts7P7zc0+NoFttOEPdqUOTCI5G+3eyQTfEfa+T4jFbG7PmgTGYrX
lfXTU6jEpvG608rZsR4JScpbNfAydr9aYgf0Oj+TPR/jQEHrn+Jd25HIm1xeGOg=
=H5cF
-----END PGP SIGNATURE-----

--FL5UXtIhxfXey3p5--
