Received: from eggs.gnu.org ([2001:4830:134:3::10]:53381)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fXSHb-0005Lt-Tr
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 10:15:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fXSHa-0006z5-Ra
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 10:15:55 -0400
References: <20180621170657.27542-1-kwolf@redhat.com>
	<20180621170657.27542-2-kwolf@redhat.com>
	<20180625090213.GB29002@stefanha-x1.localdomain>
	<20180625095105.GD5024@localhost.localdomain>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <3b55e145-4000-dfc6-6303-c670c47bdd93@redhat.com>
Date: Mon, 25 Jun 2018 16:15:45 +0200
MIME-Version: 1.0
In-Reply-To: <20180625095105.GD5024@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Y4DgjiB05X4K5dQktJBJEpVpKsfynitpu"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 1/2] block: Convert
 .bdrv_truncate callback to coroutine_fn
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Y4DgjiB05X4K5dQktJBJEpVpKsfynitpu
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org
Message-ID: <3b55e145-4000-dfc6-6303-c670c47bdd93@redhat.com>
Subject: Re: [Qemu-block] [PATCH 1/2] block: Convert .bdrv_truncate callback
 to coroutine_fn
References: <20180621170657.27542-1-kwolf@redhat.com>
 <20180621170657.27542-2-kwolf@redhat.com>
 <20180625090213.GB29002@stefanha-x1.localdomain>
 <20180625095105.GD5024@localhost.localdomain>
In-Reply-To: <20180625095105.GD5024@localhost.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 2018-06-25 11:51, Kevin Wolf wrote:
> Am 25.06.2018 um 11:02 hat Stefan Hajnoczi geschrieben:
>> On Thu, Jun 21, 2018 at 07:06:56PM +0200, Kevin Wolf wrote:
>>> bdrv_truncate() is an operation that can block (even for a quite long=

>>> time, depending on the PreallocMode) in I/O paths that shouldn't bloc=
k.
>>> Convert it to a coroutine_fn so that we have the infrastructure for
>>> drivers to make their .bdrv_co_truncate implementation asynchronous.

parallels_co_check() is a remaining coroutine_fn that calls
bdrv_truncate(), maybe it should call bdrv_co_truncate() now.

(And vhdx_allocate_block() probably should be a coroutine_fn, but that's
something for another time, I suppose.)

>> block/commit.c:commit_run() invokes blk_truncate() outside of a draine=
d
>> region.  I haven't looked for other instances, but this patch opens th=
e
>> door for races with other I/O requests.  Are you sure it's safe to mak=
e
>> this asynchronous without request serialization?
>=20
> After trying to explain why it's correct, I start to think that you're
> right at least in one case. The new thing after this patch is that the
> truncate operation isn't atomic any more. What this means depends on th=
e
> block driver:
>=20
> * file-posix/win32: I think this one is okay. The truncate
>   implementation doesn't depend in any way on the content of the image.=

>   Preallocation could be critical (in that it could overwrite
>   concurrently issued write requests), but the BDS size is only adjuste=
d
>   after the driver callback has returned, so there can't be a concurren=
t
>   write request.

Except when the BDS is growable (which every BDS is).  qcow2 generally
writes beyond the EOF, so I suppose a concurrent preallocating
truncation may result in a race.

We don't have preallocating truncation over QMP yet, so technically this
is not an issue, but with your jobs series and this series, we may well
have it soon.

> * copy-on-read, crypto, raw-format: Essentially just filter drivers tha=
t
>   pass the request to a child node, no problem.
>=20
> * gluster, iscsi, nfs, rbd, ssh: Won't yield even after this series, so=

>   trivially okay.
>=20
> * qcow2: This one is where you're right, it needs to hold s->lock so
>   that the metadata modifications become safe.
>=20
> * qed: Does a single header update, should be fine without locking.
>=20
> * sheepdog: Doesn't yield until it starts preallocation. For
>   preallocation, the same reasoning as for file-posix applies.
>=20
> So, if I got this right, the only thing to change is holding s->lock in=

> qcow2_co_truncate().

By holding the lock, we would probably solve the race for qcow2, but
probably not for raw-format.

(And I think qcow2 and raw are the only formats that support
preallocation on truncation.  (Well, raw doesn't really support it, but
it does allow it.))

Max


--Y4DgjiB05X4K5dQktJBJEpVpKsfynitpu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlsw+REACgkQ9AfbAGHV
z0BVRwf/ZKijrj/V1Sx0HLrZbeJhfLGu2JwsWaHWQuK/Et2krl3Oz5gVcHoeHd2b
SSlyygjQ1DyAgwQ43CH+yxktjWx+t/XlPtfz0iWIScl4tJyBMmuwgf/3A0hoRaZy
jiTujRsdnCijjfZj9MgbNUpZpTPoAyEIFuqUiTeceNdCYbkIlPz/OKG4yldAoSaD
dhcBs6+Bc+8IM2SLcJCAgcdUD59YPZ2LH53k05EYwwqu7vZT7J6LsQG9HVjvdoAZ
QTL1iCzwiHIOdWTNkU4fYM+N7IeeW7vis56JFOzNwjuFZcBdNRGkLwBI4wSNDWOm
UzO+J5hRsD1DyVVVc5SPnLbq7fJFpA==
=T9B4
-----END PGP SIGNATURE-----

--Y4DgjiB05X4K5dQktJBJEpVpKsfynitpu--
