Received: from eggs.gnu.org ([2001:4830:134:3::10]:34721)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1da2P8-0008IA-Ex
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 12:09:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1da2P3-0001M4-FQ
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 12:09:50 -0400
Date: Tue, 25 Jul 2017 17:09:41 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170725160941.GT23343@stefanha-x1.localdomain>
References: <20170714094521.4909-1-el13635@mail.ntua.gr>
	<20170714094521.4909-5-el13635@mail.ntua.gr>
	<20170724151247.GJ2784@stefanha-x1.localdomain>
	<20170725102908.6bwzz543pfi7ef7z@postretch>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="G2d+m75Tjo442KmM"
Content-Disposition: inline
In-Reply-To: <20170725102908.6bwzz543pfi7ef7z@postretch>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 4/7] block: convert
 ThrottleGroup to object with QOM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>, qemu-block <qemu-block@nongnu.org>


--G2d+m75Tjo442KmM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 25, 2017 at 01:29:08PM +0300, Manos Pitsidianakis wrote:
> On Mon, Jul 24, 2017 at 04:12:47PM +0100, Stefan Hajnoczi wrote:
> > On Fri, Jul 14, 2017 at 12:45:18PM +0300, Manos Pitsidianakis wrote:
> > > ThrottleGroup is converted to an object. This will allow the future
> > > throttle block filter drive easy creation and configuration of thrott=
le
> > > groups in QMP and cli.
> > >=20
> > > A new QAPI struct, ThrottleLimits, is introduced to provide a shared
> > > struct for all throttle configuration needs in QMP.
> > >=20
> > > ThrottleGroups can be created via CLI as
> > >     -object throttling-group,id=3Dfoo,x-iops-total=3D100,x-..
> >=20
> > Please make the QOM name and struct name consistent.  Either
> > ThrottleGroup/throttle-group or ThrottlingGroup/throttling-group but not
> > ThrottleGroup/throttling-group.
>=20
> I did this on purpose because current throttling has ThrottleGroup
> internally and throttling.group in the command line. Should we keep this
> only in legacy and make it throttle-group everywhere?

I don't see a compatibility issue because -drive throttling.group=3D is a
-drive property while THROTTLE_GROUP ("throttling-group") is a QOM class
name.  They are unrelated and the QOM convention is for the
typedef/struct name (ThrottleGroup) to be consistent with the QOM class
name.

Therefore it should be safe to use "throttle-group" as the QOM class
name instead of "throttling-group".

> > > +    visit_type_int64(v, name, &value, &local_err);
> > > +    if (local_err) {
> > > +        goto fail;
> > > +    }
> > > +    if (value < 0) {
> > > +        error_setg(&local_err, "Property value must be in range "
> > > +                               "[0, %"PRId64"]", INT64_MAX);
> >=20
> > Please print the maximum value relevant to the actual field type instead
> > of INT64_MAX.
>=20
> This checks the limits of the int64 field you give to QOM. I think you me=
an
> in the value assignment to each field that follows? In any case, since
> unsigned is the only smaller field we could convert it to uint64_t/uint32=
_t
> internally.

I'm saying that UNSIGNED fields are silently truncated if the value is
larger than UINT_MAX, and also that the error message is misleading
since UNSIGNED fields cannot take values in the whole range we print.

--G2d+m75Tjo442KmM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZd21FAAoJEJykq7OBq3PI1WYH/2rz1RKen8x8srm38+9BpfzY
5gyzpwQD6u0QE0CbkvnRN0wax8X2A+vg8FNVSGStkOT3wDcc6VljVqN55eo3yW+Q
Sfp6Z40CKQxbScu7GhkSjO08vr4gmXaU1pPLV/JOHwHU6BON7jDsbixx+KQmrRoY
YNhrbWJoyZm2aP35j3a213IeYiXwU97+utXFs+Ee6L9Vdo08rYs+rtqwJRK/2Ux8
lyzvxgIV5ttJH3/hKQT+mhVm2IoHA28K5sA8LlkGG+XRt60lochaAIEJh8XjOAsv
MN9UG9+t1jtlNq+dcJGQnOVUV2bRBhrPiz5eCfe2DZa9tC5r+J/1BmIDyRinE54=
=q7SC
-----END PGP SIGNATURE-----

--G2d+m75Tjo442KmM--
