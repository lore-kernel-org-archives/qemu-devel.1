Received: from eggs.gnu.org ([2001:4830:134:3::10]:58221)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cnmVR-0005O0-Dz
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 09:28:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cnmVQ-0006xt-EJ
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 09:28:53 -0400
References: <20170314023050.32756-1-famz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <02221132-c55f-e7af-67f2-5f7da67f30a0@redhat.com>
Date: Tue, 14 Mar 2017 08:28:45 -0500
MIME-Version: 1.0
In-Reply-To: <20170314023050.32756-1-famz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="qKLGgjVjOMOUaNRbvJgEfNuevovrwPEIQ"
Subject: Re: [Qemu-devel] [PATCH] block: Always call bdrv_child_check_perm
 first
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--qKLGgjVjOMOUaNRbvJgEfNuevovrwPEIQ
From: Eric Blake <eblake@redhat.com>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Message-ID: <02221132-c55f-e7af-67f2-5f7da67f30a0@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] block: Always call bdrv_child_check_perm
 first
References: <20170314023050.32756-1-famz@redhat.com>
In-Reply-To: <20170314023050.32756-1-famz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/13/2017 09:30 PM, Fam Zheng wrote:
> bdrv_child_set_perm alone is not very usable because the caller must
> call bdrv_child_check_perm first. This is already encapsulated
> conveniently in bdrv_child_try_set_perm, so remove the other prototypes=

> from the header and fix the one wrong caller, block/mirror.c.
>=20
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  block.c                   | 13 +++++++++----
>  block/mirror.c            |  6 ++++--
>  include/block/block_int.h |  4 ----
>  3 files changed, 13 insertions(+), 10 deletions(-)
>=20
> diff --git a/block.c b/block.c
> index cb57370..a77e8a0 100644
> --- a/block.c
> +++ b/block.c
> @@ -1393,6 +1393,11 @@ static int bdrv_fill_options(QDict **options, co=
nst char *filename,
>      return 0;
>  }
> =20
> +static int bdrv_child_check_perm(BdrvChild *c, uint64_t perm, uint64_t=
 shared,
> +                                 GSList *ignore_children, Error **errp=
);
> +static void bdrv_child_abort_perm_update(BdrvChild *c);
> +static void bdrv_child_set_perm(BdrvChild *c, uint64_t perm, uint64_t =
shared);
> +

Now that you have static prototypes, is it worth rearranging the file
(in a followup) to sort the function implementations into topological
order so that a prototype is not necessary?  [In general, I try to code
so that static prototypes are only necessary if I am implementing
mutually-referencing recursive code. But it's not a strict requirement]

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--qKLGgjVjOMOUaNRbvJgEfNuevovrwPEIQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYx/ANAAoJEKeha0olJ0NqC60H/2eOTtdpoTzUeH1+ffyyMSvD
ZyIE2EF/I5qV4hJCEGzVl8V9pYkBcxx9NdRU3JK7BlBnLOWVc6A2YCMosY7EYbPY
t2oQXpgPodZT6d430mOsBkxKoEXB9IQIcvYy4McGBDJe0bOikmCazTcTi7tZ16YU
TX1rzJ/zLyEmX+ZcLv94iKt/ouyMZ37+ssKvVg79UeZqnR/nO9s7tl6bKLyXKUox
KZIU64oOXbNweUEZSZ9vMDZUZW3vvOs+CkK7YbgjeaEdI+xOmWpMI6fHR82AJaAo
QESs1Ez/1MAsfcSxeLBvii9Jrko2RSizVLVuX2Fh6I4vi/S8LDj6AoLh5IMQ8P8=
=kK7O
-----END PGP SIGNATURE-----

--qKLGgjVjOMOUaNRbvJgEfNuevovrwPEIQ--
