Received: from eggs.gnu.org ([2001:4830:134:3::10]:37311)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ej58o-0004ct-8u
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 10:26:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ej58j-0005KK-7P
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 10:26:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:21126)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1ej58i-0005HG-Ue
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 10:26:33 -0500
Date: Tue, 6 Feb 2018 15:26:22 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180206152622.GD13343@stefanha-x1.localdomain>
References: <20180202111022.rtnvwmjs4r4jzttq@olga.proxmox.com>
	<20180205153140.GD28241@stefanha-x1.localdomain>
	<20180206105451.grddvo3fvk25gz5z@olga.proxmox.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="T7mxYSe680VjQnyC"
Content-Disposition: inline
In-Reply-To: <20180206105451.grddvo3fvk25gz5z@olga.proxmox.com>
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


--T7mxYSe680VjQnyC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 06, 2018 at 11:54:51AM +0100, Wolfgang Bumiller wrote:
> On Mon, Feb 05, 2018 at 03:31:40PM +0000, Stefan Hajnoczi wrote:
> > On Fri, Feb 02, 2018 at 12:10:22PM +0100, Wolfgang Bumiller wrote:
> (...)
> > > Explanation:
> > > The ratelimiting code in include/qemu/ratelimit.h currently uses slic=
es with
> > > quotas. Finishing up the quota for one slice means it'll wait for the=
 end of
> > > this _and_ the next slice before resetting the accounting and start o=
ver.
> > > If that first slice was exceeded by only a tiny bit, we effectively s=
pend every
> > > second slice waiting around. before starting over.
> (...)
> > > typedef struct {
> > >     int64_t last_time;
> > >     uint64_t speed;
> > >     int64_t allowed;
> > > } RateLimit;
> > >=20
> > > static inline int64_t ratelimit_calculate_delay(RateLimit *limit, uin=
t64_t n)
> > > {
> (... wrong code)
> > > }
> >=20
> > This does not implement a rate limit, at least not in the way that users
> > expect:
> >=20
> > Imagine there is no activity for 24 hours.  We accumulate a huge number
> > of allowed units and can exceed the rate limit for some time.
>=20
> Indeed, I forgot that blockjobs can be paused, which affects both
> versions.
> So we need slices, but do they need to be aligned? Changing the current
> code to not try align the waiting period with where a slice would start
> also seems to work better...
>=20
> ---8<---
> From e50097e88a04eae0d1d40bed5fb940dc4baa835d Mon Sep 17 00:00:00 2001
> From: Wolfgang Bumiller <w.bumiller@proxmox.com>
> Date: Tue, 6 Feb 2018 11:34:34 +0100
> Subject: [PATCH] ratelimit: don't align wait time with slices
>=20
> It is possible for rate limited writes to keep overshooting a slice's
> quota by a tiny amount causing the slice-aligned waiting period to
> effectively halve the rate.
>=20
> Signed-off-by: Wolfgang Bumiller <w.bumiller@proxmox.com>
> ---
>  include/qemu/ratelimit.h | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
>=20
> diff --git a/include/qemu/ratelimit.h b/include/qemu/ratelimit.h
> index 8da1232574..01a5d535ec 100644
> --- a/include/qemu/ratelimit.h
> +++ b/include/qemu/ratelimit.h
> @@ -35,7 +35,7 @@ typedef struct {
>  static inline int64_t ratelimit_calculate_delay(RateLimit *limit, uint64=
_t n)
>  {
>      int64_t now =3D qemu_clock_get_ns(QEMU_CLOCK_REALTIME);
> -    uint64_t delay_slices;
> +    double delay_slices;
> =20
>      assert(limit->slice_quota && limit->slice_ns);
> =20
> @@ -54,12 +54,11 @@ static inline int64_t ratelimit_calculate_delay(RateL=
imit *limit, uint64_t n)
>          return 0;
>      }
> =20
> -    /* Quota exceeded. Calculate the next time slice we may start
> -     * sending data again. */
> -    delay_slices =3D (limit->dispatched + limit->slice_quota - 1) /
> -        limit->slice_quota;
> +    /* Quota exceeded. Wait based on the excess amount and then start a =
new
> +     * slice. */
> +    delay_slices =3D (double)limit->dispatched / limit->slice_quota;
>      limit->slice_end_time =3D limit->slice_start_time +
> -        delay_slices * limit->slice_ns;
> +        (uint64_t)(delay_slices * limit->slice_ns);
>      return limit->slice_end_time - now;
>  }

Looks good, thanks!  Please send the patch as a top-level email thread
so it can be merged:
https://wiki.qemu.org/Contribute/SubmitAPatch

Stefan

--T7mxYSe680VjQnyC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaeckeAAoJEJykq7OBq3PIvJ0H/1Dnc4S57CYVnQMlrVTytJKz
cpcqHNB/KxGO+e8OsxHRL/VzGIFc5HZAcF4JbUcwiaLQNwwsouiqNIIR+XEpAdSu
WqPG2L92ui0EyfDct7js78vqvb8jRmfi7kz8TlExhH3K2H03Y4oafoh32KG605fa
HyTQ+S7w8uEQUJ/NiXStimpoY3BpWXjDc7QHlB7rv5KT40ApRmwSf/Z4jLJl43G1
flLNXIfCiLUN+9C64SJnQ+g46IppI+ivSLoSlquPZkwkpmth8o+NVwlyCitrVEA3
ZIH7sXKc9lktzSek0ckZyDdrYdD66195qz6kpjaz+l66pdsFryy2aZvs08T98Co=
=c9ff
-----END PGP SIGNATURE-----

--T7mxYSe680VjQnyC--
