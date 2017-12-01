Received: from eggs.gnu.org ([2001:4830:134:3::10]:50945)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eKrCB-0006UN-FP
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 14:42:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eKrCA-00039p-J3
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 14:41:59 -0500
References: <20171109141631.25688-1-vsementsov@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <8ade3dfe-ec27-a096-5d09-9e694f03935a@redhat.com>
Date: Fri, 1 Dec 2017 20:41:47 +0100
MIME-Version: 1.0
In-Reply-To: <20171109141631.25688-1-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="OolHdcIEcD2v5Oi8lkviUfKDTdWnMSF37"
Subject: Re: [Qemu-devel] [PATCH] blockdev-backup: enable non-root nodes for
 backup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, den@openvz.org, eblake@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--OolHdcIEcD2v5Oi8lkviUfKDTdWnMSF37
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, den@openvz.org, eblake@redhat.com
Message-ID: <8ade3dfe-ec27-a096-5d09-9e694f03935a@redhat.com>
Subject: Re: [PATCH] blockdev-backup: enable non-root nodes for backup
References: <20171109141631.25688-1-vsementsov@virtuozzo.com>
In-Reply-To: <20171109141631.25688-1-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-11-09 15:16, Vladimir Sementsov-Ogievskiy wrote:
> This is needed to implement image-fleecing scheme, when we create
> a temporary node, mark our active node to be backing for the temp,
> and start backup(sync=3Dnone) from active node to the temp node.
> Temp node then represents a kind of snapshot and may be used
> for external backup through NBD.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>=20
> What was the reason to abandon non-root nodes?
>=20
>  blockdev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/blockdev.c b/blockdev.c
> index 56a6b24a0b..d0a5a107f0 100644
> --- a/blockdev.c
> +++ b/blockdev.c
> @@ -3345,7 +3345,7 @@ BlockJob *do_blockdev_backup(BlockdevBackup *back=
up, BlockJobTxn *txn,
>          backup->compress =3D false;
>      }
> =20
> -    bs =3D qmp_get_root_bs(backup->device, errp);
> +    bs =3D bdrv_lookup_bs(backup->device, backup->device, errp);
>      if (!bs) {
>          return NULL;
>      }

I can't find anything wrong with it, but it will need some more changes.

One is the comment in bdrv_backing_attach() that unsets the
BLOCK_OP_TYPE_BACKUP_SOURCE blocker which claims that it's safe to do so
because a backing file can never be a backup source anyway.  Question
here: Why did that seem to be important?

Other places to look into are all callers of bdrv_op_block_all() that do
not unblock BLOCK_OP_TYPE_BACKUP_SOURCE afterwards (i.e. all but
bdrv_backing_attach()).  I suspect this is because they were not sure
whether they could guarantee consistent data...  But does that extend to
their children?  (Because the exact node that is blocked will still be
seen as blocked by the backup job, so that is safe.)  This wouldn't give
us any data corruption, though, because the user just gets garbage data
in their backup -- their fault for using a garbage node, I'd argue.

Maybe it doesn't matter at all.  If you really want to you can probably
already attach some raw node to any node you want to backup and hey,
that's a root node, so congratulations, you can run blockdev-backup on
it.  Well, I mean, you can run it but it won't do you any good because
the before_write notifiers don't work then.

(Same for mirror, by the way -- the dirty bitmap of that raw node
wouldn't get set.)

((By the way, I don't suppose that's how it should work...  But I don't
suppose that we want propagation of dirtying towards the BDS roots, do
we? :-/))


Finally, there is the BlockdevBackup and DriveBackup QAPI documentation
that would each need one "root" removed.

Max


--OolHdcIEcD2v5Oi8lkviUfKDTdWnMSF37
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlohsHsSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9A6NYH+QHtmCqtEVYIhEhQpSnbIfLUWP3rpax/
JK0/H2Wt4bf665tJiWtVkwE1q2DrxkXst8nzs6eUv8s4JRIZ29oV3SrIB7fimDH4
vDt71p3yox/IsCI5lyO2IWQ97JU8m+p+KIm9o0s4RnLtBzYIMgwtdCFoAiQwmGU+
EqqK5NSTF+cfnxNoxGtKtILDJ/3z4KKvRmGp8LTuCW02MnYCwqcJIOhckT6VV9Rx
z5vKAtpzxr8iYeGx/i4Sh3dw4JuMR7JB1NcigURugZQ0dEGptbhf8/Y6JHpRt2nu
iZlKDe0NGCYfqZn7WaWaeK1wEoUS05DwlPXeDbiXJRDYk8A/H7c77sU=
=x8La
-----END PGP SIGNATURE-----

--OolHdcIEcD2v5Oi8lkviUfKDTdWnMSF37--
