Received: from eggs.gnu.org ([2001:4830:134:3::10]:35817)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cno43-00076d-OY
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 11:08:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cno3y-00046R-SL
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 11:08:43 -0400
References: <20170314144453.5027-1-andreas@grapentin.org>
	<20170314144453.5027-2-andreas@grapentin.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <4d72ba80-0e37-b9f7-3258-cb3506b49827@redhat.com>
Date: Tue, 14 Mar 2017 10:08:36 -0500
MIME-Version: 1.0
In-Reply-To: <20170314144453.5027-2-andreas@grapentin.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Qh1kQofUvwSA2gfViksKMMuLtMEbjoI6P"
Subject: Re: [Qemu-devel] [PATCH 1/1] added configure check for
 _Static_assert and updated QEMU_BUILD_BUG_ON(...) accordingly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andreas Grapentin <andreas@grapentin.org>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Qh1kQofUvwSA2gfViksKMMuLtMEbjoI6P
From: Eric Blake <eblake@redhat.com>
To: Andreas Grapentin <andreas@grapentin.org>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org
Message-ID: <4d72ba80-0e37-b9f7-3258-cb3506b49827@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/1] added configure check for _Static_assert
 and updated QEMU_BUILD_BUG_ON(...) accordingly
References: <20170314144453.5027-1-andreas@grapentin.org>
 <20170314144453.5027-2-andreas@grapentin.org>
In-Reply-To: <20170314144453.5027-2-andreas@grapentin.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/14/2017 09:44 AM, Andreas Grapentin wrote:
> ---

Missing a Signed-off-by, so you'll need to send a v2 before we can apply =
it.

Subject line is long; I suggest shortening it to something like:

build: use _Static_assert in QEMU_BUILD_BUG_ON

then going into details in the rest of the commit body (see also my
comments on your 0/1 mail about content that should have been on this
commit).

>  configure               | 18 ++++++++++++++++++
>  include/qemu/compiler.h |  4 +++-
>  2 files changed, 21 insertions(+), 1 deletion(-)
>=20
> diff --git a/configure b/configure
> index 75c7c3526c..e9b33d9cf8 100755
> --- a/configure
> +++ b/configure
> @@ -4725,6 +4725,20 @@ if compile_prog "" "" ; then
>  fi
> =20
>  ##########################################
> +# check for _Static_assert()
> +
> +have_static_assert=3Dno
> +cat > $TMPC << EOF
> +_Static_assert(1, "success.");

trailing dot looks awkward; the test is the same if you omit it.

> +++ b/include/qemu/compiler.h
> @@ -90,7 +90,9 @@
>          int:(x) ? -1 : 1; \
>      }
> =20
> -#ifdef __COUNTER__
> +#if defined(CONFIG_STATIC_ASSERT)
> +#define QEMU_BUILD_BUG_ON(x) _Static_assert(!(x), #x)

Should we add any explanatory text in addition to just the expression
being tested?  For example:

block/raw-format.c:        QEMU_BUILD_BUG_ON(BDRV_SECTOR_SIZE !=3D 512);

A message of "static assertion failed: BDRV_SECTOR_SIZE !=3D 512" is
tricky: it can only trip if the sector size was not 512, but normally
when I see a _Static_assert message, I assume that I should fix my code
to make the expression true, and the expression printed is already true.

Maybe _Static_assert(!(x), "not expecting " #x) is better, because it
would give a message of "static assertion failed: not expecting
BDRV_SECTOR_SIZE !=3D 512".

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--Qh1kQofUvwSA2gfViksKMMuLtMEbjoI6P
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYyAd0AAoJEKeha0olJ0NqN+kIAKbq0xgaGkoO0KZgwNQwYxhk
EebJ1cji/6OA6vKZK2ebX71wQpEulKWcdqT7FZ2ii1eKTwmexapz6moC9vFG4m6e
46ojvGaRmxZucYIo+br0bL58dzYrBw7zVSdgTytj0EVz7QHAKxs2mV3fqLWH3hFv
nyvPe1cotLdQ25/L/BxAETNwd3D03Z1cHc9QqMjBIAgRy6wJa7lljCkK38c36t0/
MC06kSNWLnP1qE9FInyr5thTrO/0pRH4HPwFHghSvcPWrQKQHwcktdCAfUKbga4r
mAoSgqYYKOSweLHKhnplbw8EJb5CMnw6ELh1lgloJq9SToCTaPJUOYz67IA5PZw=
=8FfN
-----END PGP SIGNATURE-----

--Qh1kQofUvwSA2gfViksKMMuLtMEbjoI6P--
