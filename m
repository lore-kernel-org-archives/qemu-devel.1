Received: from eggs.gnu.org ([2001:4830:134:3::10]:39492)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fYwrg-0008RM-UJ
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 13:07:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fYwrg-00014k-3n
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 13:07:20 -0400
Date: Fri, 29 Jun 2018 18:07:09 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180629170709.GD16547@stefanha-x1.localdomain>
References: <20180622201122.9358-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+B+y8wtTXqdUj1xM"
Content-Disposition: inline
In-Reply-To: <20180622201122.9358-1-jsnow@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] migration: Appease coverity,
 skip empty block trees
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Juan Quintela <quintela@redhat.com>, peter.maydell@linaro.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Fam Zheng <famz@redhat.com>


--+B+y8wtTXqdUj1xM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 22, 2018 at 04:11:22PM -0400, John Snow wrote:
> If a tree consists exclusively of implicit filter nodes, we might crash
> QEMU. This configuration should not exist in practice, but if it did,
> skipping it would be fine.
>=20
> For the purposes of debug builds, throw an assert to remind us that
> this configuration is truly unexpected, but if it's compiled out we
> will cope just fine.
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  migration/block-dirty-bitmap.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitma=
p.c
> index 3bafbbdc4c..02725293dd 100644
> --- a/migration/block-dirty-bitmap.c
> +++ b/migration/block-dirty-bitmap.c
> @@ -287,6 +287,10 @@ static int init_dirty_bitmap_migration(void)
>          while (bs && bs->drv && bs->implicit) {
>              bs =3D backing_bs(bs);
>          }
> +        if (!bs) {
> +            g_assert_not_reached();
> +            continue;
> +        }

If bs can never be NULL, why test that it is non-NULL in the while loop
condition?

Try:

  /* Precondition: bs !=3D NULL thanks to the for loop */
  while (bs->drv && bs->implicit) {
      bs =3D backing_bs(bs);
  }
  /* Postcondition: bs !=3D NULL due to implicit node layout assumption */

Does this silence Coverity?  ISTR it looks for cues like the bs check in
the while loop condition to decide whether it's likely that a variable
could be NULL.

--+B+y8wtTXqdUj1xM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbNmc9AAoJEJykq7OBq3PIxPEH/js+OIiAZvn5D2xdugST2TNH
A5VsmSTNzMJ0oESJfeFOIzPAPF5CNGAy+MQKhTdYEyniZOI38vL/qa03l9p/ITmm
aPdw1L6T6/GLtAKQ1mVkRijXW/2wODmH6/NvGEwce4K9pKOE/YOti29wvfKTAffb
upo6UCAeo9WzwqzgNUQy30eJWhWq+Cg0P5FNdwDJZnHPvcrzO8TUlS0FD6dSi+4g
8xMOSwy0DKoAFKfdcXeUuVStda5qA/NpkyKrQd4glt9rO5j3rygdOANK2/fqNnnv
507zbW+tnpH5jWYoT2ZTdQZ5+WqTKfow+ssunrNMJakFnUm60pIKAWUYCa86QWs=
=x180
-----END PGP SIGNATURE-----

--+B+y8wtTXqdUj1xM--
