Received: from eggs.gnu.org ([2001:4830:134:3::10]:54691)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cbTJH-0001VU-06
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 09:33:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cbTJF-0007Wm-S8
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 09:33:27 -0500
References: <20170123123056.30383-1-famz@redhat.com>
	<20170123123056.30383-16-famz@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <20d35345-34de-db04-d6d4-59a0babda81e@redhat.com>
Date: Wed, 8 Feb 2017 15:33:15 +0100
MIME-Version: 1.0
In-Reply-To: <20170123123056.30383-16-famz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="EbjUXJcOutmvQTXrlFoh2rL0cOsPJrf1X"
Subject: Re: [Qemu-devel] [PATCH v12 15/16] qcow2: Force "no other writer"
 lock on bs->file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: "Daniel P. Berrange" <berrange@redhat.com>, qemu-block@nongnu.org, eblake@redhat.com, Kevin Wolf <kwolf@redhat.com>, rjones@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--EbjUXJcOutmvQTXrlFoh2rL0cOsPJrf1X
From: Max Reitz <mreitz@redhat.com>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: "Daniel P. Berrange" <berrange@redhat.com>, qemu-block@nongnu.org,
 eblake@redhat.com, Kevin Wolf <kwolf@redhat.com>, rjones@redhat.com
Message-ID: <20d35345-34de-db04-d6d4-59a0babda81e@redhat.com>
Subject: Re: [PATCH v12 15/16] qcow2: Force "no other writer" lock on bs->file
References: <20170123123056.30383-1-famz@redhat.com>
 <20170123123056.30383-16-famz@redhat.com>
In-Reply-To: <20170123123056.30383-16-famz@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 23.01.2017 13:30, Fam Zheng wrote:
> Writing to the same qcow2 file from two QEMU processes at the same time=

> will never work correctly, so disable it even when the caller specifies=

> BDRV_O_RDWR.
>=20
> Other formats are less vulnerable because they don't have internal
> snapshots thus qemu-img is less often misused to create live snapshot.

Hm, OK, reasonable. Also reasonable since we can just wait with those
until we have op blockers.

Which brings me to the op blocker point. I don't know the exact
influence Kevin's patches will have on this series, but I'd imagine they
mostly change where the BDRV_O_SHARE_RW flag comes from or whether we
need that flag at all. Therefore, I personally don't mind the order in
which your series land in master.

> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  block/qcow2.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>=20
> diff --git a/block/qcow2.c b/block/qcow2.c
> index 96fb8a8..879361a 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -1177,6 +1177,17 @@ static int qcow2_open(BlockDriverState *bs, QDic=
t *options, int flags,
>          }
>      }
> =20
> +    if ((flags & BDRV_O_SHARE_RW) && (flags & BDRV_O_RDWR)) {
> +        /* Shared write is never a good idea for qcow2, override it.
> +         * XXX: Use permission propagation and masking mechanism in op=
 blockers
> +         * API once it's there. */
> +        ret =3D bdrv_reopen(bs->file->bs, flags & ~BDRV_O_SHARE_RW, &l=
ocal_err);
> +        if (ret) {
> +            error_propagate(errp, local_err);
> +            goto fail;
> +        }
> +    }
> +

Good in principle, but I don't think it should be at the bottom of this
function, especially not after "Repair image if dirty". I think it would
be good to put this right at the start of qcow2_open(), actually.

Max

>  #ifdef DEBUG_ALLOC
>      {
>          BdrvCheckResult result =3D {0};
>=20



--EbjUXJcOutmvQTXrlFoh2rL0cOsPJrf1X
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlibLCsSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9A29YH/AwxdFx6wLRq9gYiLt5KHtM7HkUrzq9I
P+c3euHIE8gwdp10hxbRKZo3JghuWIM44+1gdlhS9guxbhAQcm49d/5U1WxrZA+m
3YIWcF2DNAl98qe8mEulzjqeHnIYKH0IycmNam3FMK4KmZB2fTzzFqbjwbvRo3ho
QAmxTEhi4zlsoQkH+AYSgVu0ZzMNBtu+9SHaQvaFGhdj7hJfnSwSOIo5ho68dJxF
atJ0RdrgRhyDW0cZ8PfKbtDCBGivXuYxAwwTOVv+t1h7L02/evilTHJQLdAqxzjW
4U1M9RKSbEz4tvmOSG/XbTY3vEArIDocf5QVzfWyt9WRDuk4iqc6vlM=
=k0Wg
-----END PGP SIGNATURE-----

--EbjUXJcOutmvQTXrlFoh2rL0cOsPJrf1X--
