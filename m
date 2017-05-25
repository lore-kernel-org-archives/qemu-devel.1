Received: from eggs.gnu.org ([2001:4830:134:3::10]:58748)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dDy2A-0001t8-LL
	for qemu-devel@nongnu.org; Thu, 25 May 2017 15:02:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dDy29-0007Tw-Ok
	for qemu-devel@nongnu.org; Thu, 25 May 2017 15:02:54 -0400
References: <20170525152628.37628-1-vsementsov@virtuozzo.com>
	<20170525152628.37628-3-vsementsov@virtuozzo.com>
	<4d041d0a-ed17-4d72-fce2-e2500e9ec0fc@redhat.com>
	<245523c5-59fd-f585-291f-fe7fe64bb500@virtuozzo.com>
	<6d16d9d2-cd5b-a71f-740d-0721845cca96@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <5c38f770-40d7-ee89-7fd1-edad4a9927b6@redhat.com>
Date: Thu, 25 May 2017 14:02:45 -0500
MIME-Version: 1.0
In-Reply-To: <6d16d9d2-cd5b-a71f-740d-0721845cca96@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="GTGvvs8pJv3gHcv98REe10XlgbEFkEet7"
Subject: Re: [Qemu-devel] [PATCH 2/7] block: add
 bdrv_get_format_allocated_size format interface
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
--GTGvvs8pJv3gHcv98REe10XlgbEFkEet7
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: armbru@redhat.com, mreitz@redhat.com, kwolf@redhat.com, den@openvz.org
Message-ID: <5c38f770-40d7-ee89-7fd1-edad4a9927b6@redhat.com>
Subject: Re: [PATCH 2/7] block: add bdrv_get_format_allocated_size format
 interface
References: <20170525152628.37628-1-vsementsov@virtuozzo.com>
 <20170525152628.37628-3-vsementsov@virtuozzo.com>
 <4d041d0a-ed17-4d72-fce2-e2500e9ec0fc@redhat.com>
 <245523c5-59fd-f585-291f-fe7fe64bb500@virtuozzo.com>
 <6d16d9d2-cd5b-a71f-740d-0721845cca96@virtuozzo.com>
In-Reply-To: <6d16d9d2-cd5b-a71f-740d-0721845cca96@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/25/2017 01:19 PM, Vladimir Sementsov-Ogievskiy wrote:

> No, it will not be negative, all OK. I've mistaken. length of
> bs->file->bs will be positive anyway.
>=20
> Actually, current approach is the following:
>=20
> a. clusters allocated in qcow2 and after the end of bs->file: unallocat=
ed

How often do we actually end up in this situation? I know there are a
few cases where it makes sense (for example, if your image is large
enough to have L1 occupy two clusters, but the guest hasn't written
anything in the second half of the guest-visible area, then the second
cluster of the L1 table can be all zeroes - and depending on allocation
patterns, it is feasible that the L1 table can occupy the end of the
image, where the second cluster of the L1 table thus points beyond
end-of-file of the underlying image while still being a well-formed
qcow2 image).  It may also be a common transitory state in how we expand
a qcow2 image; if the expansion is interrupted in the middle, we could
easily have the refcount table saying a cluster has been allocated while
we have not yet actually written to the host file.

> b. clusters allocated in qcow2 and which are holes bs->file: allocated

This may be more common; a typical example is if we have a cluster
marked QCOW2_CLUSTER_NORMAL but which maps to a hole (and therefore
bdrv_get_block_status will report it as BDRV_BLOCK_DATA|BDRV_BLOCK_ZERO).=


>=20
> (a) look inconsistent with b and with commit message and other things.
> But if I just account (a) clusters, it will lead to negative size of
> unallocated and will spoil the whole stat.. Something should be
> adjusted, at least at comment/commit-message level.

Exposing the stat as a difference may not make as much sense as
reporting actual numbers (this image requires an allocation of this many
bytes to fully represent current guest- and meta-data, even if some of
the allocation is currently pointing to holes or beyond the end of the
underlying file).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--GTGvvs8pJv3gHcv98REe10XlgbEFkEet7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZJypVAAoJEKeha0olJ0Nqwx0H/Awhk9Oy2Zjuw5sTuDTRNx7X
w4rXIAxPOlS2O+S/L08PUrGUWlVzi3CWVs/dRBgdQ8xrqaKVt9STr1I7F+8kzpuy
fsr6rWr3bE8f6YkYP2mN7TxMBq+vIKPmCZqdbAGbePMKdAXu7mJzLSDvHCOYcWCV
I2cZzqZ7jv7NretrcnEbkTXXaBhPPpFu1IwbJbZaQUkkyChO9o8vKahli7g2o9iD
ji5ySE2urLhRqEYT4XPqFyOuUDZLoLfQFbu67klZe0h5TeNreup27WGSIyBRvmNh
4GN8u3kgJC8NLZyM5elV8x1UetBPUTWiCmG8w8nj0EUYOQPtIfFcA83R5FWVovo=
=7AUv
-----END PGP SIGNATURE-----

--GTGvvs8pJv3gHcv98REe10XlgbEFkEet7--
