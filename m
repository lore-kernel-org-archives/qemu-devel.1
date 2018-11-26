Received: from eggs.gnu.org ([2001:4830:134:3::10]:48300)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gRGBx-0004e3-0n
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 07:40:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gRGBv-0004Q9-3D
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 07:40:44 -0500
From: Max Reitz <mreitz@redhat.com>
References: <20181126112828.23047-1-kwolf@redhat.com>
	<20181126112828.23047-2-kwolf@redhat.com>
	<7b3288b3-f7f8-b6cf-d4b1-b0540205e3df@redhat.com>
Message-ID: <db0fee59-5344-4bb8-8620-72e5123392b6@redhat.com>
Date: Mon, 26 Nov 2018 13:40:30 +0100
MIME-Version: 1.0
In-Reply-To: <7b3288b3-f7f8-b6cf-d4b1-b0540205e3df@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="seqWQCFYQhUjEZIbuZKmKY07vdMwpE29N"
Subject: Re: [Qemu-devel] [PATCH for-3.1 1/2] block: Don't inactivate
 children before parents
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--seqWQCFYQhUjEZIbuZKmKY07vdMwpE29N
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org
Message-ID: <db0fee59-5344-4bb8-8620-72e5123392b6@redhat.com>
Subject: Re: [PATCH for-3.1 1/2] block: Don't inactivate children before
 parents
References: <20181126112828.23047-1-kwolf@redhat.com>
 <20181126112828.23047-2-kwolf@redhat.com>
 <7b3288b3-f7f8-b6cf-d4b1-b0540205e3df@redhat.com>
In-Reply-To: <7b3288b3-f7f8-b6cf-d4b1-b0540205e3df@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 26.11.18 13:05, Max Reitz wrote:
> On 26.11.18 12:28, Kevin Wolf wrote:
>> bdrv_child_cb_inactivate() asserts that parents are already inactive
>> when children get inactivated. This precondition is necessary because
>> parents could still issue requests in their inactivation code.
>>
>> When block nodes are created individually with -blockdev, all of them
>> are monitor owned and will be returned by bdrv_next() in an undefined
>> order (in practice, in the order of their creation, which is usually
>> children before parents), which obviously fails the assertion.
>>
>> This patch fixes the ordering by skipping nodes with still active
>> parents in bdrv_inactivate_recurse() because we know that they will be=

>> covered by recursion when the last active parent becomes inactive.
>>
>> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
>> ---
>>  block.c | 22 ++++++++++++++++++++++
>>  1 file changed, 22 insertions(+)
>>
>> diff --git a/block.c b/block.c
>> index 5ba3435f8f..0569275e31 100644
>> --- a/block.c
>> +++ b/block.c
>> @@ -4612,6 +4612,22 @@ void bdrv_invalidate_cache_all(Error **errp)
>>      }
>>  }
>> =20
>> +static bool bdrv_has_active_bds_parent(BlockDriverState *bs)
>> +{
>> +    BdrvChild *parent;
>> +
>> +    QLIST_FOREACH(parent, &bs->parents, next_parent) {
>> +        if (parent->role->parent_is_bds) {
>> +            BlockDriverState *parent_bs =3D parent->opaque;
>> +            if (!(parent_bs->open_flags & BDRV_O_INACTIVE)) {
>> +                return true;
>> +            }
>> +        }
>> +    }
>=20
> Now I see why you say this might make sense as a permission.
>=20
>> +
>> +    return false;
>> +}
>> +
>>  static int bdrv_inactivate_recurse(BlockDriverState *bs,
>>                                     bool setting_flag)
>>  {
>> @@ -4622,6 +4638,12 @@ static int bdrv_inactivate_recurse(BlockDriverS=
tate *bs,
>>          return -ENOMEDIUM;
>>      }
>> =20
>> +    /* Make sure that we don't inactivate a child before its parent.
>> +     * It will be covered by recursion from the yet active parent. */=

>> +    if (bdrv_has_active_bds_parent(bs)) {

Another thing I found while testing: I think this should only return
early if setting_flag is true.  BDRV_O_INACTIVE will only be set on the
second pass.  If you skip nodes with active parents unconditionally,
bs->drv->bdrv_inactivate() will not be called for any non-root BDS
(because bdrv_has_active_bds_parents() returns true for all non-root
BDSs during the first pass).

>> +        return 0;
>> +    }
>> +
>=20
> Hm.  Wouldn't it make more sense to always return early when there are
> any BDS parents?  Because if there are any BDS parents and none of them=

> are active (anymore), then this child will have been inactivated
> already, and we can save ourselves the trouble of going through the res=
t
> of the function again.

Hm, well, no, at least not directly here.  (Otherwise
bdrv_inactive_recurse() will not really recurse when it calls itself...)
But bdrv_inactive_all() could check that before invoking this function.

Ah, but then it is possible to still run into the exact bug you're
fixing here, because a node might inactivate a child that has another
parent still (which is inactivated later).

But still, I think bdrv_inactive_all() should skip non-root BDSs,
because calling bs->drv->bdrv_inactive() and parent->role->inactivate()
multiple times cannot be right.

Max

> Do drivers support multiple calls to .bdrv_in_activate() at all?
>=20
> Max
>=20
>>      if (!setting_flag && bs->drv->bdrv_inactivate) {
>>          ret =3D bs->drv->bdrv_inactivate(bs);
>>          if (ret < 0) {
>>
>=20
>=20



--seqWQCFYQhUjEZIbuZKmKY07vdMwpE29N
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlv76b4ACgkQ9AfbAGHV
z0BebQf9Ex73Ha/tqWDrlQ0TBooGcb5EnfQojqX0cPjYNmAV/lc8BQkuRkYNs4wt
e807iJASECgPPdjDAnz8uRQHOoCUJ7oD49t1NR2O4yuA0ZxcrcE7trSOwVJk9Gde
NjfKnzakCGo6rTqtGND1popPYeNVh8rYGRhy6HR0XFeVRU5M4yv2smfB64uc6hVs
1q1Wddqxvat1udsJ32YbWC2TPDNyhJivI9di0yLVyJzUbYVScoO/i/CZ2iy7SU2l
2iT+skDop84SPRJBbrZQxF2z1nK8AvkOzwMOpBE2AVbavMaNwWSb8jAeAna+hf8O
wZ2FnvWCne9eTOSaWNtXb4p49e0nTg==
=82nt
-----END PGP SIGNATURE-----

--seqWQCFYQhUjEZIbuZKmKY07vdMwpE29N--
