Received: from eggs.gnu.org ([2001:4830:134:3::10]:53838)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dG8do-00041C-Nf
	for qemu-devel@nongnu.org; Wed, 31 May 2017 14:46:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dG8dl-0003Qa-Il
	for qemu-devel@nongnu.org; Wed, 31 May 2017 14:46:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41270)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dG8dl-0003QH-92
	for qemu-devel@nongnu.org; Wed, 31 May 2017 14:46:41 -0400
References: <20170531165541.47338-1-vsementsov@virtuozzo.com>
	<20170531165541.47338-2-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <70aa332e-c868-15ac-0c4c-23d41a777b6c@redhat.com>
Date: Wed, 31 May 2017 13:46:38 -0500
MIME-Version: 1.0
In-Reply-To: <20170531165541.47338-2-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="uK77p4oAj6CRNiODifQd7A6Ovwtg4aPn8"
Subject: Re: [Qemu-devel] [PATCH 01/12] nbd: rename read_sync and friends
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--uK77p4oAj6CRNiODifQd7A6Ovwtg4aPn8
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, den@openvz.org
Message-ID: <70aa332e-c868-15ac-0c4c-23d41a777b6c@redhat.com>
Subject: Re: [PATCH 01/12] nbd: rename read_sync and friends
References: <20170531165541.47338-1-vsementsov@virtuozzo.com>
 <20170531165541.47338-2-vsementsov@virtuozzo.com>
In-Reply-To: <20170531165541.47338-2-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/31/2017 11:55 AM, Vladimir Sementsov-Ogievskiy wrote:
> Rename
>   nbd_wr_syncv -> nbd_rwv
>   read_sync -> nbd_read
>   read_sync_eof -> nbd_read_eof
>   write_sync -> nbd_write
>   drop_sync -> nbd_drop
>=20
> 1. nbd_ prefix
>    read_sync and write_sync are already shared, so it is good to have a=

>    namespace prefix. drop_sync will be shared, and read_sync_eof is
>    related to read_sync, so let's rename them all.
>=20
> 2. _sync suffix
>    _sync is related to the fact, that nbd_wr_syncv doesn't return if

s/fact,/fact/

>    write to socket returns EAGAIN. In first implementation nbd_wr_syncv=

>    just loops while getting EAGAIN, current implementation yields in
>    this case.

As mentioned in your followup, you may want to rewrite this to:

_sync was originally used (back in commit 7a5ca864 when it was named
wr_sync) to indicate that we looped rather than returned on EAGAIN.  But
now we use qio_channel which yields on our behalf rather than giving us
EAGAIN.

>    Why to get rid of it:
>    - it is normal for r/w functions to be synchronous, so having
>      additional suffix for it looks redundant (contrariwise, we have
>      _aio suffix for async functions)
>    - _sync suffix in block layer is used when function does flush (so
>      using it for other thing is confusing a bit)
>    - keep function names short after adding nbd_ prefix
>=20
> 3. for nbd_wr_syncv let's use more common notation 'rw'
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---

The maintainer may be willing to tweak the commit message without
needing a v2.


> +++ b/nbd/nbd-internal.h
> @@ -94,14 +94,14 @@
>  #define NBD_ENOSPC     28
>  #define NBD_ESHUTDOWN  108
> =20
> -/* read_sync_eof
> +/* nbd_read_eof
>   * Tries to read @size bytes from @ioc. Returns number of bytes actual=
ly read.
>   * May return a value >=3D 0 and < size only on EOF, i.e. when iterati=
vely called
> - * qio_channel_readv() returns 0. So, there are no needs to call read_=
sync_eof
> + * qio_channel_readv() returns 0. So, there are no needs to call nbd_r=
ead_eof

As long as you are touching this:

s/are no needs/is no need/

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--uK77p4oAj6CRNiODifQd7A6Ovwtg4aPn8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZLw+OAAoJEKeha0olJ0Nq1/MH/2syDbyXkd9brBGi9f9Dtlqj
EY+9iDVXfGDdsOC6xGxcFXfYBdKds1iCmcYCcwUxL0/A0LNu8v8wu99eiXynqyfa
A69rD0YjEcUoKlEZwwlk4bGny+bTRm4O1n1zIiPbwLGqsBs5dmazJyDhdU1Iwapa
cXF21G6uA27HEsZpkNNQA2N9SPRBmX+HoroCdkg2dkSlcn36C0/faJgPCF8+JAEW
C6H3IK/xFnAYokwUps1ek8y2bj2qF4+M0Xtaf6e5ilK3gVbNgDSRAiwQpY2Jt6kQ
CKSyhhLpJzVWuG5b7ztL/dWLFZNAOZGes9qwa9Y80nEDUkhW8K7CqZROH2KgxBw=
=ccGp
-----END PGP SIGNATURE-----

--uK77p4oAj6CRNiODifQd7A6Ovwtg4aPn8--
