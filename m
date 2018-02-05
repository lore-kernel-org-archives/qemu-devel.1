Received: from eggs.gnu.org ([2001:4830:134:3::10]:56860)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eiikF-0001rT-AS
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 10:31:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eiikB-00062R-6R
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 10:31:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39602)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1eiikA-00060u-Tp
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 10:31:43 -0500
Date: Mon, 5 Feb 2018 15:31:40 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180205153140.GD28241@stefanha-x1.localdomain>
References: <20180202111022.rtnvwmjs4r4jzttq@olga.proxmox.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RhUH2Ysw6aD5utA4"
Content-Disposition: inline
In-Reply-To: <20180202111022.rtnvwmjs4r4jzttq@olga.proxmox.com>
Subject: Re: [Qemu-devel] rate limiting issues
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wolfgang Bumiller <w.bumiller@proxmox.com>
Cc: qemu-devel@nongnu.org


--RhUH2Ysw6aD5utA4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 02, 2018 at 12:10:22PM +0100, Wolfgang Bumiller wrote:
> Summary:
> Rate limit is effectively halved when the size of written chunks adds up =
to
> exceeding the quota of a slice only slightly. This is surprisingly reliab=
le.
>=20
> Explanation:
> The ratelimiting code in include/qemu/ratelimit.h currently uses slices w=
ith
> quotas. Finishing up the quota for one slice means it'll wait for the end=
 of
> this _and_ the next slice before resetting the accounting and start over.
> If that first slice was exceeded by only a tiny bit, we effectively spend=
 every
> second slice waiting around. before starting over.
>=20
> Here if I use a limit of 30000KiB/s I get 30000KiB/s.
> Increasing the limit to 30700KiB/s gives me 30700KiB/s.
> Increasing it to 30720KiB/s reliably gives me 15000KiB/s.
>=20
> Making it wait to the end of only the current slice means the excess data=
 is not
> counted at all and we may go above the limit (though by at most one write=
-chunk,
> so I'm not sure if that's fine for most of the users, for backup jobs it =
seems
> to be 64k always).
>=20
> I'd like to fix this and am unsure about which way to go. On the one hand=
 I
> think the old code (before f14a39ccb922) may be fixable in a better way b=
y not
> resetting the accounting completely but subtracting the amount of data the
> wait-period would have added.
>=20
> At the same time, though, this could be simplified to not using slices but
> always comparing the amount of actually written data to the amount of data
> which should at most have been written.
>=20
> Here are two approaches which seem to fix my issues:
>=20
> --- Old code revised:
>=20
> typedef struct {
>     int64_t next_slice_time;
>     uint64_t slice_quota;
>     uint64_t slice_ns;
>     int64_t dispatched;
> } RateLimit;
>=20
> static inline int64_t ratelimit_calculate_delay(RateLimit *limit, uint64_=
t n)
> {
>     int64_t now =3D qemu_clock_get_ns(QEMU_CLOCK_REALTIME);
>=20
>     assert(limit->slice_quota && limit->slice_ns);
>=20
>     if (limit->next_slice_time =3D=3D 0) { /* first call */
>         limit->dispatched =3D 0;
>         limit->next_slice_time =3D now + limit->slice_ns;
>         return 0;
>     }
>=20
>     if (limit->next_slice_time < now) {
>         uint64_t passed_slices =3D DIV_ROUND_UP(now - limit->next_slice_t=
ime,
>             limit->slice_ns);
>         limit->next_slice_time =3D now + limit->slice_ns;
>         limit->dispatched -=3D passed_slices * limit->slice_quota;
>     }
>     limit->dispatched +=3D n;
>     if (limit->dispatched+n <=3D limit->slice_quota) {

This looks buggy.  n is added twice?

>         return 0;
>     }
>     return limit->next_slice_time - now;
> }
>=20
> static inline void ratelimit_set_speed(RateLimit *limit, uint64_t speed,
>                                        uint64_t slice_ns)
> {
>     limit->slice_ns =3D slice_ns;
>     limit->slice_quota =3D MAX(((double)speed * slice_ns) / 1000000000ULL=
, 1);
> }
>=20
> ---
>=20
> And this is a short slice-less version. I wonder if there's any particular
> reason for sticking to slices?
>=20
> --- Version without slices:
>=20
> typedef struct {
>     int64_t last_time;
>     uint64_t speed;
>     int64_t allowed;
> } RateLimit;
>=20
> static inline int64_t ratelimit_calculate_delay(RateLimit *limit, uint64_=
t n)
> {
>     int64_t delta, now =3D qemu_clock_get_ns(QEMU_CLOCK_REALTIME);
>=20
>     if (limit->last_time =3D=3D 0) { /* first call */
>         limit->allowed =3D -n;
>         limit->last_time =3D now;
>         return (n * 1000000000ULL) / limit->speed;
>     }
>=20
>     delta =3D (now - limit->last_time);
>     limit->allowed +=3D (delta * limit->speed)/1000000000ULL - n;
>     limit->last_time =3D now;
>     if (limit->allowed < 0) {
>         return ((uint64_t)-limit->allowed * 1000000000ULL) / limit->speed;
>     }
>     return 0;
> }

This does not implement a rate limit, at least not in the way that users
expect:

Imagine there is no activity for 24 hours.  We accumulate a huge number
of allowed units and can exceed the rate limit for some time.

--RhUH2Ysw6aD5utA4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaeHjcAAoJEJykq7OBq3PIAxwIAJyfcOThUbvYck9QyGgZpBVn
brDpKlfYf93hAG1tOF3Gamuj4IHjFaxs11PfUB2PSWaTpMbMEsP0UMc0G0a7siyC
+FgtSIFo1mt7IHAoTv82JZElmoA1CnlS+cBm9nZwWOk8UHqMI+ypshBCwVeTRrlf
gefcwvEATQj6cj2EMgqrjfDL8Qv+yp3NCX8NGtWZMYnOhISPJkK2DBHNwgi50o6L
4LBu/XFc2BAzdFZ6exeJnrbkGuDG+6vn8ePGr+mUg9hUL3hUqusF3GsEiCAFPNoK
sO2fxzWtFwJ/EhlGqjgGDQMfKPLMS56tXgIWKfgBKfFSpnKPl4djsfTDjKw6rXo=
=xXVQ
-----END PGP SIGNATURE-----

--RhUH2Ysw6aD5utA4--
