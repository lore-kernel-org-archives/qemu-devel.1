Received: from eggs.gnu.org ([2001:4830:134:3::10]:49690)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dPq3d-0002JQ-MN
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 08:57:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dPq3c-00076c-Pt
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 08:57:29 -0400
Date: Tue, 27 Jun 2017 13:57:20 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170627125720.GG8555@stefanha-x1.localdomain>
References: <20170623124700.1389-1-el13635@mail.ntua.gr>
	<20170623124700.1389-5-el13635@mail.ntua.gr>
	<20170626145234.GE29664@stefanha-x1.localdomain>
	<20170626152409.banswonpr6aj4h55@postretch>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="f5QefDQHtn8hx44O"
Content-Disposition: inline
In-Reply-To: <20170626152409.banswonpr6aj4h55@postretch>
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


--f5QefDQHtn8hx44O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 26, 2017 at 06:24:09PM +0300, Manos Pitsidianakis wrote:
> On Mon, Jun 26, 2017 at 03:52:34PM +0100, Stefan Hajnoczi wrote:
> > > +static void throttle_group_set(Object *obj, Visitor *v, const char *=
 name,
> > > +        void *opaque, Error **errp)
> > > +
> > > +{
> > > +    ThrottleGroup *tg =3D THROTTLE_GROUP(obj);
> > > +    ThrottleConfig cfg =3D tg->ts.cfg;
> > > +    Error *local_err =3D NULL;
> > > +    ThrottleParamInfo *info =3D opaque;
> > > +    int64_t value;
> >=20
> > What happens if this property is set while QEMU is already running?
>=20
> I assume you mean setting a property while a group has active members and
> requests? My best answer would be "don't do that". I couldn't figure a way
> to do this cleanly. Individual limit changes may render a ThrottleConfig
> invalid, so it should not be allowed. ThrottleGroups and throttle nodes
> should be destroyed and recreated to change limits with this version, but=
 in
> the next it will be done through block_set_io_throttle() which is the
> existing way to change limits and check for validity. This was discussed =
in
> the proposal about the new syntax we had on the list.

Please ask on IRC or the mailing list if you have questions.

If you are aware of a limitation and don't know the answer then
submitting the code without any comment or question is dangerous.
Reviewers may miss the problem :) and broken code gets merged.

UserCreatableClass has a ->complete() callback.  You can use this to
perform final initialization and then "freeze" the properties by setting
a bool flag.  The property accessor functions can do:

  if (tg->init_complete) {
      error_setg(errp, "Property modification is not allowed at run-time");
      return;
  }

Something like this is used by
backends/hostmem.c:host_memory_backend_set_size(), for example.

> >=20
> > > +        goto out;
> > > +    }
> >=20
> > This doesn't validate inputs properly for non int64_t types.
> >=20
> > I'm also worried that the command-line bps=3D,iops=3D,... options do not
> > have unsigned or double types.  Input ranges and validation should match
> > the QEMU command-line (I know this is a bit of a pain with QOM since the
> > property types are different from QEMU option types).
>=20
> I don't know what should be done about this, to be honest, except for
> manually checking the limits for each datatype in the QOM setters.

I believe all throttling parameter types are int64_t in QemuOpts.  If we
want to be compatible with the command-line parameters then they should
also be int64_t here instead of unsigned int or double.

This approach makes sense from the QMP user perspective.  QMP clients
shouldn't have to deal with different data types depending on which
throttling API they use.  Let's keep it consistent - there's no real
drawback to using int64_t.

--f5QefDQHtn8hx44O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEbBAEBAgAGBQJZUlYwAAoJEJykq7OBq3PIJ8AH+IIxRq5ai659O7lioJxd/rGF
OI6Vse5wAtZ4xk5Mh+9YqErsTJl+/S0gvuL4RDUEJhs4TPuStdi2FWAvIJmSz8zM
ZSD+xl56knDIxRrCJEM0z+o5feQHZyXE6DxBqIk6CV/gRWHs7h7kjqNl7rDbfjwt
UJsOkMbClgXRkFBTzbiIrfBHQnzwN76JczB1iuU6vccjezyszCUX402/AsgfCuke
9u1F1ZJsSsK8GMNazha98vgj8nk0xQsCxtb8fl8H2rCm8qMgfwxIMGSD+upspXdX
nRgv74xfGS32WI411PF97HuMGsB+NoKp5RK+YdZITLXGiMoJiTWF+6o6LK1ATQ==
=njQE
-----END PGP SIGNATURE-----

--f5QefDQHtn8hx44O--
