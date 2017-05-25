Received: from eggs.gnu.org ([2001:4830:134:3::10]:51414)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dDvgX-000486-Vc
	for qemu-devel@nongnu.org; Thu, 25 May 2017 12:32:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dDvgW-0003cK-S1
	for qemu-devel@nongnu.org; Thu, 25 May 2017 12:32:26 -0400
References: <20170525152628.37628-1-vsementsov@virtuozzo.com>
	<20170525152628.37628-2-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <3fdd3178-89d7-2819-d040-1e5132d655ec@redhat.com>
Date: Thu, 25 May 2017 11:32:14 -0500
MIME-Version: 1.0
In-Reply-To: <20170525152628.37628-2-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="8sWJgmRTDloDKr6xcRrsWAD28RBQ76xU1"
Subject: Re: [Qemu-devel] [PATCH 1/7] block: fix comment for
 bdrv_get_allocated_file_size()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: armbru@redhat.com, mreitz@redhat.com, kwolf@redhat.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8sWJgmRTDloDKr6xcRrsWAD28RBQ76xU1
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: armbru@redhat.com, mreitz@redhat.com, kwolf@redhat.com, den@openvz.org
Message-ID: <3fdd3178-89d7-2819-d040-1e5132d655ec@redhat.com>
Subject: Re: [PATCH 1/7] block: fix comment for bdrv_get_allocated_file_size()
References: <20170525152628.37628-1-vsementsov@virtuozzo.com>
 <20170525152628.37628-2-vsementsov@virtuozzo.com>
In-Reply-To: <20170525152628.37628-2-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/25/2017 10:26 AM, Vladimir Sementsov-Ogievskiy wrote:
> Current comment is not clear enough: which sparseness is meant, coming
> from sparse image format or from sparse file system?
>=20
> For example, if we have qcow2 above raw file on non-sparse file system,=

> this function will say nothing about unallocated (by qcow2 layer)
> clusters.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/block.c b/block.c
> index 50ba264143..ba22fc0dfb 100644
> --- a/block.c
> +++ b/block.c
> @@ -3388,8 +3388,8 @@ int bdrv_truncate(BdrvChild *child, int64_t offse=
t, Error **errp)
>  }
> =20
>  /**
> - * Length of a allocated file in bytes. Sparse files are counted by ac=
tual

Yay for getting rid of bad grammar (s/a /an /)

> - * allocated space. Return < 0 if error or unknown.
> + * Size of allocated in underlying file system area. Sparseness is tak=
en into

Doesn't read well.  Maybe: s/Size of allocated/Allocation size/ ?

> + * account for sparse file systems. Return < 0 if error or unknown.

I still don't get what we are trying to present.

If we have the following 6 qcow2 file clusters backed by the underlying
lseek(SEEK_DATA/HOLE) file system contents:

BDRV_BLOCK_UNALLOCATED   N/A
BDRV_BLOCK_ZERO_PLAIN    N/A
BDRV_BLOCK_ZERO_ALLOC    hole
BDRV_BLOCK_ZERO_ALLOC    data
BDRV_BLOCK_DATA          hole
BDRV_BLOCK_DATA          data

Then is our answer the size of all qcow2 allocations regardless of
underlying status (4, due to clusters 3-6), or the size of only the
clusters that read from the backing file (2, due to clusters 5-6), or
the size of only the clusters that currently occupy space in the file
system (2, due to clusters 4 and 6), or the size of clusters that are
not provably read-as-zero (1, due to cluster 6)?

Does the answer change if you can have underlying holes happen at a
smaller granularity than clusters?

What happens for compressed clusters?

I think we still need to do a better job at writing a precise comment.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--8sWJgmRTDloDKr6xcRrsWAD28RBQ76xU1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZJwcOAAoJEKeha0olJ0Nq9IwIAKlByUdyMavcRauDeOa8jYlI
uHdyXOwvBu1831WzX+PwAUKk6tJr/f3MgICPUn4XPN03bHxR7S/95iWQBu2FgkIE
8nXePvReLeP+SM220lQ3OfrSk+SIdHrU1S+pA0EBVVuRw+MphEHQAPr6i+5QGT+i
j0mYiQ6FxO+NAqTlTv3ohPfS93p5gPjp4eGFETQ7BQJdkkCSGSE+t3Z3gM0Uvo6s
aIeN6fpr3Lf9/+LrBH3u5189gBeSznN5BUVKGM+BfFqTJri5ok234RAWOAId4mzF
Ns9cUCGSW0qJcmzd+9AtatckXUcdPJILCSWKcCQSBUffp0JaDmdpRzkjbBU/xiQ=
=yYw+
-----END PGP SIGNATURE-----

--8sWJgmRTDloDKr6xcRrsWAD28RBQ76xU1--
