Received: from eggs.gnu.org ([209.51.188.92]:46529)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gtxci-0006gq-62
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 11:43:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gtxcg-0002mN-FE
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 11:43:00 -0500
From: Max Reitz <mreitz@redhat.com>
References: <20180809223117.7846-1-mreitz@redhat.com>
	<20180809223117.7846-4-mreitz@redhat.com>
	<e855b03b-67e0-d822-d9fe-dedc1456011e@redhat.com>
	<f5d4e779-26c3-fd93-cae9-7d202242fd8c@redhat.com>
Message-ID: <2f3a2dc2-f074-064f-d3f2-c167555ddd05@redhat.com>
Date: Wed, 13 Feb 2019 17:42:49 +0100
MIME-Version: 1.0
In-Reply-To: <f5d4e779-26c3-fd93-cae9-7d202242fd8c@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="tleedLCsT0VmtREyOyaEyCSewSIi2IWwQ"
Subject: Re: [Qemu-devel] [PATCH v2 03/11] block: Filtered children access
 functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--tleedLCsT0VmtREyOyaEyCSewSIi2IWwQ
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Message-ID: <2f3a2dc2-f074-064f-d3f2-c167555ddd05@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 03/11] block: Filtered children access
 functions
References: <20180809223117.7846-1-mreitz@redhat.com>
 <20180809223117.7846-4-mreitz@redhat.com>
 <e855b03b-67e0-d822-d9fe-dedc1456011e@redhat.com>
 <f5d4e779-26c3-fd93-cae9-7d202242fd8c@redhat.com>
In-Reply-To: <f5d4e779-26c3-fd93-cae9-7d202242fd8c@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 14.11.18 20:52, Max Reitz wrote:
> On 12.11.18 23:17, Eric Blake wrote:
>> On 8/9/18 5:31 PM, Max Reitz wrote:

[...]

>>> +++ b/block/io.c
>>> @@ -120,6 +120,7 @@ static void bdrv_merge_limits(BlockLimits *dst,
>>> const BlockLimits *src)
>>> =C2=A0 void bdrv_refresh_limits(BlockDriverState *bs, Error **errp)
>>> =C2=A0 {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BlockDriver *drv =3D bs->drv;
>>> +=C2=A0=C2=A0=C2=A0 BlockDriverState *cow_bs =3D bdrv_filtered_cow_bs=
(bs);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Error *local_err =3D NULL;
>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 memset(&bs->bl, 0, sizeof(bs->b=
l));
>>> @@ -148,13 +149,13 @@ void bdrv_refresh_limits(BlockDriverState *bs,
>>> Error **errp)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bs->bl.max_iov=
 =3D IOV_MAX;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> =C2=A0 -=C2=A0=C2=A0=C2=A0 if (bs->backing) {
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bdrv_refresh_limits(bs->b=
acking->bs, &local_err);
>>> +=C2=A0=C2=A0=C2=A0 if (cow_bs) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bdrv_refresh_limits(cow_b=
s, &local_err);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (local_err)=
 {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 error_propagate(errp, local_err);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 return;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bdrv_merge_limits(&bs->bl=
, &bs->backing->bs->bl);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bdrv_merge_limits(&bs->bl=
, &cow_bs->bl);
>>
>> Is this doing the right things with blkdebug?
>=20
> First, blkdebug doesn't have a COW child, does it?
>=20
> Second, we still always invoke the driver's implementation (if there is=

> one).  All of the code at the beginning of the function just chooses
> some defaults.  So blkdebug can still override everything.
>=20
> But there is indeed something wrong here.  And that is: What is with R/=
W
> filter drivers that use bs->backing?  After this patch, they won't get
> any defaults.

Hm, yeah, but after the next one they're alright because
bdrv_storage_bs() returns filtered children.  So the issue is just the
span in between...

I suppose I can solve this by assigning bs->file to storage_bs, or
bs->backing if both bs->file and cow_bs are NULL.  And then put a FIXME
behind it that the next patch will solve.

Max


--tleedLCsT0VmtREyOyaEyCSewSIi2IWwQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlxkSQkACgkQ9AfbAGHV
z0AvRAgAk5neoW+GSo4YsxkZX4dZO+sbJJysoUEKxyuJ6gZ1/dL2S7NkwRiFhzMK
8MAeu3rkKKuQBgHR9KAny3zyFkKa4artqGqZH+w9lMnyxKQXikz/3gQdThv2mmEa
7q40Q6Onp9zJI+sqzAqMPL+3dzTe6BtLIw28bbsfjT5uhLhzIi/3Pjc5efk8odzB
QkTWx1RZdwLfw6If+Sn0b4PoTfoGmUheY9iibhxROGo9QxIujbqd5F4kMAV81zHf
E1LSplVFyHo7D+fIzmmFG1eyLU8RqkigRLX0IKQaseYXWAQCMeUaW/YNr38xA9e6
U1Zg8Bmk6jG4U4HLYtPAeh/YbedBfQ==
=sIJw
-----END PGP SIGNATURE-----

--tleedLCsT0VmtREyOyaEyCSewSIi2IWwQ--
