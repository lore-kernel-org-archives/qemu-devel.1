Received: from eggs.gnu.org ([2001:4830:134:3::10]:53241)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d5zWl-0003uh-01
	for qemu-devel@nongnu.org; Wed, 03 May 2017 15:01:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d5zWk-0001Gg-3V
	for qemu-devel@nongnu.org; Wed, 03 May 2017 15:01:31 -0400
From: Max Reitz <mreitz@redhat.com>
References: <20170429191419.30051-1-eblake@redhat.com>
	<20170429191419.30051-8-eblake@redhat.com>
	<106645b1-81e0-398d-88ab-2b1573171c1d@redhat.com>
Message-ID: <fc77ac15-9708-1c0c-6ac4-7d255ba9fae1@redhat.com>
Date: Wed, 3 May 2017 21:01:19 +0200
MIME-Version: 1.0
In-Reply-To: <106645b1-81e0-398d-88ab-2b1573171c1d@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="pxJpHeBlkl3mKOKEaseJ6dSglod9CIjar"
Subject: Re: [Qemu-devel] [PATCH v11 7/9] blkdebug: Simplify override logic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--pxJpHeBlkl3mKOKEaseJ6dSglod9CIjar
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org
Message-ID: <fc77ac15-9708-1c0c-6ac4-7d255ba9fae1@redhat.com>
Subject: Re: [PATCH v11 7/9] blkdebug: Simplify override logic
References: <20170429191419.30051-1-eblake@redhat.com>
 <20170429191419.30051-8-eblake@redhat.com>
 <106645b1-81e0-398d-88ab-2b1573171c1d@redhat.com>
In-Reply-To: <106645b1-81e0-398d-88ab-2b1573171c1d@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03.05.2017 20:59, Max Reitz wrote:
> On 29.04.2017 21:14, Eric Blake wrote:
>> Rather than store into a local variable, then copy to the struct
>> if the value is valid, then reporting errors otherwise, it is
>> simpler to just store into the struct and report errors if the
>> value is invalid.  This however requires that the struct store
>> a 64-bit number, rather than a narrower type.  Likewise, setting
>> a sane errno value in ret prior to the sequence of parsing and
>> jumping to out: on error makes it easier for the next patch to
>> add a chain of similar checks.
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>>
>> ---
>> v11: rebase to master, enough changed to drop R-b
>> v10: no change
>> v9: no change
>> v7-v8: not submitted (earlier half of series sent for 2.9)
>> v6: tweak error message, but R-b kept
>> v5: no change
>> v4: fix typo in commit message, move errno assignment
>> v3: new patch
>> ---
>>  block/blkdebug.c | 16 ++++++----------
>>  1 file changed, 6 insertions(+), 10 deletions(-)
>>
>> diff --git a/block/blkdebug.c b/block/blkdebug.c
>> index 6414f1c..8e0f596 100644
>> --- a/block/blkdebug.c
>> +++ b/block/blkdebug.c
>> @@ -38,7 +38,7 @@
>>  typedef struct BDRVBlkdebugState {
>>      int state;
>>      int new_state;
>> -    int align;
>> +    uint64_t align;
>>
>>      /* For blkdebug_refresh_filename() */
>>      char *config_file;
>> @@ -353,7 +353,6 @@ static int blkdebug_open(BlockDriverState *bs, QDi=
ct *options, int flags,
>>      BDRVBlkdebugState *s =3D bs->opaque;
>>      QemuOpts *opts;
>>      Error *local_err =3D NULL;
>> -    uint64_t align;
>>      int ret;
>>
>>      opts =3D qemu_opts_create(&runtime_opts, NULL, 0, &error_abort);
>> @@ -387,20 +386,17 @@ static int blkdebug_open(BlockDriverState *bs, Q=
Dict *options, int flags,
>>          bs->file->bs->supported_write_flags;
>>      bs->supported_zero_flags =3D (BDRV_REQ_FUA | BDRV_REQ_MAY_UNMAP) =
&
>>          bs->file->bs->supported_zero_flags;
>> +    ret =3D -EINVAL;
>>
>>      /* Set request alignment */
>> -    align =3D qemu_opt_get_size(opts, "align", 0);
>> -    if (align < INT_MAX && is_power_of_2(align)) {
>> -        s->align =3D align;
>> -    } else if (align) {
>> -        error_setg(errp, "Invalid alignment");
>> -        ret =3D -EINVAL;
>> +    s->align =3D qemu_opt_get_size(opts, "align", 0);
>> +    if (s->align && (s->align >=3D INT_MAX || !is_power_of_2(s->align=
))) {
>> +        error_setg(errp, "Cannot meet constraints with align %" PRIu6=
4,
>> +                   s->align);
>=20
> Why don't you just keep the ret =3D -EINVAL here and not add it above?
> It's not wrong, I just think it makes the code a bit weird to read.

Ah. Read the next patch, that is why you don't. Well, I would've
probably still added it to each goto out;, but it does make sense to
just set it once here, so:

Reviewed-by: Max Reitz <mreitz@redhat.com>


--pxJpHeBlkl3mKOKEaseJ6dSglod9CIjar
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlkKKP8SHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9ATw4H/1gIvaaMMzzTD95kTZ/iIQMifMev0I9v
i0D1libG6NDA2Vaxwq0dO8GrVFLCJ0ntZRZcJs0y4NJ/jeUDfVccBTt/GHTw/SRX
MX9CRVui4FHay9YbCxFY2+7YQ2GaJsbww1FxLuRJ018YNbI/uZqWnDGSDMAIvujZ
0MOixCYMfkfYvP7ErJmUWmK8/tzd2PAnybyuNosip3SwBrD5k2uJh0oMnokiHAUb
OxffkG6hUY1RS+5pOCGkIu8ghBmfqS21n/tm9TbOhPNv2C0t1YAX3k0HS6LMN1T5
mZ3C8PeEwclCNdnfDqEx9EznMPcfe8JUXX32F7dJ2Nb6Us6jzZtggus=
=qfAz
-----END PGP SIGNATURE-----

--pxJpHeBlkl3mKOKEaseJ6dSglod9CIjar--
