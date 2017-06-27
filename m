Received: from eggs.gnu.org ([2001:4830:134:3::10]:51599)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dPq94-0005Fq-8D
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 09:03:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dPq93-0001ka-D5
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 09:03:06 -0400
Date: Tue, 27 Jun 2017 14:02:55 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170627130255.GH8555@stefanha-x1.localdomain>
References: <20170623124700.1389-1-el13635@mail.ntua.gr>
	<20170623124700.1389-5-el13635@mail.ntua.gr>
	<20170626145234.GE29664@stefanha-x1.localdomain>
	<20170626165832.32mzemh4jiwpquo4@postretch>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="h3LYUU6HlUDSAOzy"
Content-Disposition: inline
In-Reply-To: <20170626165832.32mzemh4jiwpquo4@postretch>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH RFC v3 4/8] block: convert
 ThrottleGroup to object with QOM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>, Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, qemu-block <qemu-block@nongnu.org>, Alberto Garcia <berto@igalia.com>
Cc: Pradeep Jagadeesh <pradeepkiruvale@gmail.com>


--h3LYUU6HlUDSAOzy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 26, 2017 at 07:58:32PM +0300, Manos Pitsidianakis wrote:
> On Mon, Jun 26, 2017 at 03:52:34PM +0100, Stefan Hajnoczi wrote:
> > On Fri, Jun 23, 2017 at 03:46:56PM +0300, Manos Pitsidianakis wrote:
> > > +static bool throttle_group_exists(const char *name)
> > > +{
> > > +    ThrottleGroup *iter;
> > > +    bool ret =3D false;
> > > +
> > > +    qemu_mutex_lock(&throttle_groups_lock);
> >=20
> > Not sure if this lock or the throttle_groups list are necessary.
> >=20
> > Have you seen iothread.c:qmp_query_iothreads()?  All objects are put
> > into a container (the parent object), so you can just iterate over its
> > children.  There's no need for a separate list because QOM already has
> > all the objects.
> >=20
>=20
> > > +static void throttle_group_obj_complete(UserCreatable *obj, Error **=
errp)
> > > +{
> > > +    char *name =3D NULL;
> > > +    Error *local_error =3D NULL;
> > > +    ThrottleGroup *tg =3D THROTTLE_GROUP(obj);
> > > +
> > > +    name =3D object_get_canonical_path_component(OBJECT(obj));
> > > +    if (throttle_group_exists(name)) {
> > > +        error_setg(&local_error, "A throttle group with this name al=
ready \
> > > +                                  exists.");
> > > +        goto ret;
> > > +    }
> >=20
> > QOM should enforce unique id=3D<ID>.  I don't think this is necessary.
> >=20
> > > +
> > > +    qemu_mutex_lock(&throttle_groups_lock);
> > > +    tg->name =3D name;
> > > +    qemu_mutex_init(&tg->lock);
> > > +    QLIST_INIT(&tg->head);
> > > +    QTAILQ_INSERT_TAIL(&throttle_groups, tg, list);
> > > +    tg->refcount++;
> > > +    qemu_mutex_unlock(&throttle_groups_lock);
> > > +
>=20
> Sorry for the multiple replies but I just remembered this.
>=20
> This is necessary because throttle groups are created by other interfaces=
 as
> well. Of course block/throttle-groups.c could use only QOM objects
> internally to eliminate the housekeeping.

I suggest all throttle group objects are visible in QOM.  Who are the
non-QOM users?

I have CCed Pradeep who has been working on virtio-9p throttling.

Pradeep: You may be interested in this series, which makes the throttle
group a QOM object (-object throttle-group,id=3Dgroup0,bps=3D1235678).  In
other words, groups are becoming first-class objects instead of being
hidden behind the member devices that use them.

Stefan

--h3LYUU6HlUDSAOzy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZUld/AAoJEJykq7OBq3PIbjwIAIJyDSO/7RZiMW+I8hRmYeuJ
lQJ1Q5ovHGpSvABjK4XXcv/urOMac1OS+0pbqYD3nu3kE7pZxTdKxd/RSBcucZe9
Laggs8gLKh8tdlEGeDui2xgs4grzYgkRgBHAsZNNk8pZCBRkimTM2qrgRpPbz5+T
h2anNEYLWYbMLVmSs4Q1CBcSR8oJSyXh0dHeE2jQy/3MZycAStaGHRb/LUXXTL0W
yGeqA6dI/BFKTclLhgKSS/K6xAnj1vy2Jnqyzpag+NIRw/14vqG0Zf8JA/+Z5sED
aX4y7IGxDSMLPYbyIgSmIi1G9LvTs6bjpZ3B9l6ZgjDMSKBUfpJY3a2ui/Fz+14=
=fKAJ
-----END PGP SIGNATURE-----

--h3LYUU6HlUDSAOzy--
