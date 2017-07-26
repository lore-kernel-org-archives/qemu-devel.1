Received: from eggs.gnu.org ([2001:4830:134:3::10]:48451)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1daKg9-0004pc-Tj
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 07:40:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1daKg8-0003Ug-JL
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 07:40:37 -0400
Date: Wed, 26 Jul 2017 12:40:25 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170726114025.GH18489@stefanha-x1.localdomain>
References: <20170714094521.4909-1-el13635@mail.ntua.gr>
	<20170714094521.4909-5-el13635@mail.ntua.gr>
	<20170724151247.GJ2784@stefanha-x1.localdomain>
	<20170725102908.6bwzz543pfi7ef7z@postretch>
	<20170725160941.GT23343@stefanha-x1.localdomain>
	<20170725162145.algud34mtktskw2c@postretch>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="a8sldprk+5E/pDEv"
Content-Disposition: inline
In-Reply-To: <20170725162145.algud34mtktskw2c@postretch>
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
To: Manos Pitsidianakis <el13635@mail.ntua.gr>, Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>, qemu-block <qemu-block@nongnu.org>


--a8sldprk+5E/pDEv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 25, 2017 at 07:21:45PM +0300, Manos Pitsidianakis wrote:
> On Tue, Jul 25, 2017 at 05:09:41PM +0100, Stefan Hajnoczi wrote:
> > On Tue, Jul 25, 2017 at 01:29:08PM +0300, Manos Pitsidianakis wrote:
> > > On Mon, Jul 24, 2017 at 04:12:47PM +0100, Stefan Hajnoczi wrote:
> > > > On Fri, Jul 14, 2017 at 12:45:18PM +0300, Manos Pitsidianakis wrote:
> > > > > ThrottleGroup is converted to an object. This will allow the futu=
re
> > > > > throttle block filter drive easy creation and configuration of th=
rottle
> > > > > groups in QMP and cli.
> > > > >
> > > > > A new QAPI struct, ThrottleLimits, is introduced to provide a sha=
red
> > > > > struct for all throttle configuration needs in QMP.
> > > > >
> > > > > ThrottleGroups can be created via CLI as
> > > > >     -object throttling-group,id=3Dfoo,x-iops-total=3D100,x-..
> > > >
> > > > Please make the QOM name and struct name consistent.  Either
> > > > ThrottleGroup/throttle-group or ThrottlingGroup/throttling-group bu=
t not
> > > > ThrottleGroup/throttling-group.
> > >=20
> > > I did this on purpose because current throttling has ThrottleGroup
> > > internally and throttling.group in the command line. Should we keep t=
his
> > > only in legacy and make it throttle-group everywhere?
> >=20
> > I don't see a compatibility issue because -drive throttling.group=3D is=
 a
> > -drive property while THROTTLE_GROUP ("throttling-group") is a QOM class
> > name.  They are unrelated and the QOM convention is for the
> > typedef/struct name (ThrottleGroup) to be consistent with the QOM class
> > name.
> >=20
> > Therefore it should be safe to use "throttle-group" as the QOM class
> > name instead of "throttling-group".
>=20
> I meant for consistency not compatibility. Otherwise it probably would be
> better to keep throttle-group/ThrottleGroup in the new interfaces.

You could call it ThrottlingGroup ("throttling-group") for consistency.

> >=20
> > > > > +    visit_type_int64(v, name, &value, &local_err);
> > > > > +    if (local_err) {
> > > > > +        goto fail;
> > > > > +    }
> > > > > +    if (value < 0) {
> > > > > +        error_setg(&local_err, "Property value must be in range "
> > > > > +                               "[0, %"PRId64"]", INT64_MAX);
> > > >
> > > > Please print the maximum value relevant to the actual field type in=
stead
> > > > of INT64_MAX.
> > >=20
> > > This checks the limits of the int64 field you give to QOM. I think yo=
u mean
> > > in the value assignment to each field that follows? In any case, since
> > > unsigned is the only smaller field we could convert it to uint64_t/ui=
nt32_t
> > > internally.
> >=20
> > I'm saying that UNSIGNED fields are silently truncated if the value is
> > larger than UINT_MAX, and also that the error message is misleading
> > since UNSIGNED fields cannot take values in the whole range we print.
>=20
> Yes, wouldn't it be better to convert the unsigned field burst_length to
> uint64_t and take care of the overflow case? The field describes seconds,
> but there's no reason to keep it that small.

A burst_length of UINT_MAX seconds is over 136 years.  I guess unsigned
int was chosen because larger values will never be used :).

That said, making burst_length uint64_t is fine from a compatibility
point of view.

--a8sldprk+5E/pDEv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZeH+pAAoJEJykq7OBq3PIybQIAKUg+jXSV7LS7AuqO/sM7vdw
W75437yCVR+LAGW5s3aLbmUjXDVHBl7eD9oFosRM+MD1GUU+K9tT/ryDu+afVEc5
JfkACU24uxKFbDIyjmBAU6H/rqnxktjA1QLcMVSA9SOLDjsV6Sq/+9C4nPiLVFa0
oyXlAc7g8FeQwFKhGRbnKlqLx7JJGGrjgNWj8+jSIyaNxWfe+TzXoBu1d9Ka6S1A
upw7JJEHAYmQorUnaUl0YWpszBlNBYSL7rHdX2jMEnptV+mGJ/IQb1lYPkaDmoeV
3xEi3hyvF44zb0E7Mu72J2TqU7vDcodywCvD7gVOwmtbctnFQ9u8HFUbm69lIn8=
=X85D
-----END PGP SIGNATURE-----

--a8sldprk+5E/pDEv--
