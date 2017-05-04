Received: from eggs.gnu.org ([2001:4830:134:3::10]:40195)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d6KmP-0000IV-PK
	for qemu-devel@nongnu.org; Thu, 04 May 2017 13:43:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d6KmO-0002PN-Mv
	for qemu-devel@nongnu.org; Thu, 04 May 2017 13:43:05 -0400
References: <1493916761-32319-1-git-send-email-kwolf@redhat.com>
	<1493916761-32319-6-git-send-email-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9b4c624c-94b0-3cd3-4e19-fd998e042d07@redhat.com>
Date: Thu, 4 May 2017 12:42:55 -0500
MIME-Version: 1.0
In-Reply-To: <1493916761-32319-6-git-send-email-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="9Glp7M6b9CETPrCEX6x6crwveNKIMODBJ"
Subject: Re: [Qemu-devel] [PATCH 5/6] block: Fix write/resize permissions
 for inactive images
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: famz@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9Glp7M6b9CETPrCEX6x6crwveNKIMODBJ
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: famz@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com
Message-ID: <9b4c624c-94b0-3cd3-4e19-fd998e042d07@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 5/6] block: Fix write/resize permissions for
 inactive images
References: <1493916761-32319-1-git-send-email-kwolf@redhat.com>
 <1493916761-32319-6-git-send-email-kwolf@redhat.com>
In-Reply-To: <1493916761-32319-6-git-send-email-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/04/2017 11:52 AM, Kevin Wolf wrote:
> Format drivers for inactive nodes don't need write/resize permissions o=
n
> their bs->file and can share write/resize with another VM (in fact, thi=
s
> is the whole point of keeping images inactive). Represent this fact in
> the op blocker system, so that image locking does the right thing
> without special-casing inactive images.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block.c               | 35 +++++++++++++++++++++++++++++++++--
>  include/block/block.h |  1 +
>  2 files changed, 34 insertions(+), 2 deletions(-)
>=20
> diff --git a/block.c b/block.c
> index 773bd64..cd89467 100644
> --- a/block.c
> +++ b/block.c
> @@ -192,11 +192,20 @@ void path_combine(char *dest, int dest_size,
>      }
>  }
> =20
> +/* Returns whether the image file is opened as read-only. Note that th=
is can
> + * return false and writing to the image file is still not possible be=
cause the

s/false and/false but/
s/is still not/still not be/

> + * image is inactivated. */
>  bool bdrv_is_read_only(BlockDriverState *bs)
>  {
>      return bs->read_only;
>  }
> =20
> +/* Returns whether the image file can be written to right now */
> +bool bdrv_is_writable(BlockDriverState *bs)
> +{
> +    return !bdrv_is_read_only(bs) && !(bs->open_flags & BDRV_O_INACTIV=
E);
> +}

Nice.

Up to you if you think the grammar suggestion helps.
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--9Glp7M6b9CETPrCEX6x6crwveNKIMODBJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZC2gfAAoJEKeha0olJ0Nqb+8H/3PYS8q9dxgiPPDVHnlu74y9
ak6McrHmhDJO5Wk5MTrcoskdHuBCBJUIyNiwlPvbMeDkvXSAfgiNESVEX2xNbqw3
4j+tLGYi0JD+rB8OfgDMEDcAQzR0toCEvtwxbuyniyFiSXQiginHcryLy9sZwuew
+sNYsFNuFwqdfiSTPoLUaUdzcWzEDKg9OStBv1Vxj2vfxfMH+brta/bpjiovpreB
gxFiBi0y6ObvXcW6yDw92a/i4Y7RH+nzylYt36obXulPQH/fzogQcTXskeIp4Tzq
saYJq6FJBS9vPzmfFIlDmp6k89AzKTMrvvR/o1gUOxtQgqyYWcFoh4KCPql7fcE=
=1jd9
-----END PGP SIGNATURE-----

--9Glp7M6b9CETPrCEX6x6crwveNKIMODBJ--
