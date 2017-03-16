Received: from eggs.gnu.org ([2001:4830:134:3::10]:44300)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1coMce-0003bz-Ce
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 00:02:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1coMcZ-0002jS-8W
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 00:02:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40034)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1coMcY-0002iu-Vo
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 00:02:39 -0400
References: <20170315092940.1367-1-stefanha@redhat.com>
	<20170315092940.1367-2-stefanha@redhat.com>
	<5251b9a6-9e00-d11e-ac23-304accfda59a@redhat.com>
	<20170316033844.GI11074@stefanha-x1.localdomain>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <7d5c16a0-a658-e813-aad1-67b8a4bf0e17@redhat.com>
Date: Thu, 16 Mar 2017 05:02:26 +0100
MIME-Version: 1.0
In-Reply-To: <20170316033844.GI11074@stefanha-x1.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="XAg3SOxJtKx5rcmUQMpfs4m2sHTkRsT6L"
Subject: Re: [Qemu-devel] [RFC v2 1/8] block: add bdrv_measure() API
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>, Nir Soffer <nsoffer@redhat.com>, Maor Lipchuk <mlipchuk@redhat.com>, Alberto Garcia <berto@igalia.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XAg3SOxJtKx5rcmUQMpfs4m2sHTkRsT6L
From: Max Reitz <mreitz@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 John Snow <jsnow@redhat.com>, Nir Soffer <nsoffer@redhat.com>,
 Maor Lipchuk <mlipchuk@redhat.com>, Alberto Garcia <berto@igalia.com>
Message-ID: <7d5c16a0-a658-e813-aad1-67b8a4bf0e17@redhat.com>
Subject: Re: [Qemu-devel] [RFC v2 1/8] block: add bdrv_measure() API
References: <20170315092940.1367-1-stefanha@redhat.com>
 <20170315092940.1367-2-stefanha@redhat.com>
 <5251b9a6-9e00-d11e-ac23-304accfda59a@redhat.com>
 <20170316033844.GI11074@stefanha-x1.localdomain>
In-Reply-To: <20170316033844.GI11074@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 16.03.2017 04:38, Stefan Hajnoczi wrote:
> On Thu, Mar 16, 2017 at 02:01:03AM +0100, Max Reitz wrote:
>> On 15.03.2017 10:29, Stefan Hajnoczi wrote:
>>> bdrv_measure() provides a conservative maximum for the size of a new
>>> image.  This information is handy if storage needs to be allocated (e=
=2Eg.
>>> a SAN or an LVM volume) ahead of time.
>>>
>>> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
>>> ---
>>>  qapi/block-core.json      | 19 +++++++++++++++++++
>>>  include/block/block.h     |  4 ++++
>>>  include/block/block_int.h |  2 ++
>>>  block.c                   | 33 +++++++++++++++++++++++++++++++++
>>>  4 files changed, 58 insertions(+)
>>>
>>> diff --git a/qapi/block-core.json b/qapi/block-core.json
>>> index 786b39e..673569d 100644
>>> --- a/qapi/block-core.json
>>> +++ b/qapi/block-core.json
>>> @@ -463,6 +463,25 @@
>>>             '*dirty-bitmaps': ['BlockDirtyInfo'] } }
>>> =20
>>>  ##
>>> +# @BlockMeasureInfo:
>>> +#
>>> +# Image size calculation information.  This structure describes the =
size
>>> +# requirements for creating a new image.
>>> +#
>>> +# @required-bytes: Amount of space required for image creation.  Thi=
s value is
>>> +#                  the host file size including sparse file regions.=
  A new 5
>>> +#                  GB raw file therefore has a required size of 5 GB=
, not 0
>>> +#                  bytes.
>>
>> This should probably note that it's a conservative estimation (and I
>> agree that it should be). It's nice to have it in the commit message b=
ut
>> few people are going to run git blame on the QAPI documentation to fin=
d
>> out the rest of its story. :-)
>=20
> Will fix.
>=20
>>> +#
>>> +# @fully-allocated-bytes: Space required once data has been written =
to all
>>> +#                         sectors
>>> +#
>>> +# Since: 2.10
>>> +##
>>> +{ 'struct': 'BlockMeasureInfo',
>>> +  'data': {'required-bytes': 'int', 'fully-allocated-bytes': 'int'} =
}
>>> +
>>> +##
>>>  # @query-block:
>>>  #
>>>  # Get a list of BlockInfo for all virtual block devices.
>>> diff --git a/include/block/block.h b/include/block/block.h
>>> index 5149260..43c789f 100644
>>> --- a/include/block/block.h
>>> +++ b/include/block/block.h
>>> @@ -298,6 +298,10 @@ int bdrv_truncate(BdrvChild *child, int64_t offs=
et);
>>>  int64_t bdrv_nb_sectors(BlockDriverState *bs);
>>>  int64_t bdrv_getlength(BlockDriverState *bs);
>>>  int64_t bdrv_get_allocated_file_size(BlockDriverState *bs);
>>> +void bdrv_measure(BlockDriver *drv, QemuOpts *opts,
>>> +                  BlockDriverState *in_bs,
>>> +                  BlockMeasureInfo *info,
>>> +                  Error **errp);
>>>  void bdrv_get_geometry(BlockDriverState *bs, uint64_t *nb_sectors_pt=
r);
>>>  void bdrv_refresh_limits(BlockDriverState *bs, Error **errp);
>>>  int bdrv_commit(BlockDriverState *bs);
>>> diff --git a/include/block/block_int.h b/include/block/block_int.h
>>> index 6c699ac..45a7fbe 100644
>>> --- a/include/block/block_int.h
>>> +++ b/include/block/block_int.h
>>> @@ -201,6 +201,8 @@ struct BlockDriver {
>>>      int64_t (*bdrv_getlength)(BlockDriverState *bs);
>>>      bool has_variable_length;
>>>      int64_t (*bdrv_get_allocated_file_size)(BlockDriverState *bs);
>>> +    void (*bdrv_measure)(QemuOpts *opts, BlockDriverState *in_bs,
>>> +                         BlockMeasureInfo *info, Error **errp);
>>> =20
>>>      int coroutine_fn (*bdrv_co_pwritev_compressed)(BlockDriverState =
*bs,
>>>          uint64_t offset, uint64_t bytes, QEMUIOVector *qiov);
>>> diff --git a/block.c b/block.c
>>> index cb57370..532a4d1 100644
>>> --- a/block.c
>>> +++ b/block.c
>>> @@ -3260,6 +3260,39 @@ int64_t bdrv_get_allocated_file_size(BlockDriv=
erState *bs)
>>>      return -ENOTSUP;
>>>  }
>>> =20
>>> +/*
>>> + * bdrv_measure:
>>> + * @drv: Format driver
>>> + * @opts: Creation options
>>> + * @in_bs: Existing image containing data for new image (may be NULL=
)
>>> + * @info: Result object
>>> + * @errp: Error object
>>> + *
>>> + * Calculate file size required to create a new image.
>>> + *
>>> + * If @in_bs is given then space for allocated clusters and zero clu=
sters
>>> + * from that image are included in the calculation.  If @opts contai=
ns a
>>> + * backing file that is shared by @in_bs then backing clusters are o=
mitted
>>> + * from the calculation.
>>
>> This seems to run a bit contrary to the documentation of
>> BlockMeasureInfo.required-bytes, and I don't fully understand it eithe=
r.
>>
>> What does "space for zero clusters" mean? Do zero clusters take space?=

>> Does it depend on the image format? (i.e. would they take space for ra=
w
>> but not for qcow2?)
>=20
> Yes, zero clusters are an image format-specific feature.  A contrived
> example:
>=20
>   in_bs: qcow2 version=3D3 with zero clusters
>   Output format: qcow2 version=3D2 (zero clusters not supported!)
>   Image creation options: backing file given
>=20
> We must take care to allocate clusters in the new image for zero
> clusters in in_bs.  We cannot simply skip allocating those zero cluster=
s
> since there is a backing file and the contents of the backing file
> must not be visible where there is a zero cluster.
>=20
> This is a scenario where zero clusters must be included in the
> size calculation.
>=20
> Perhaps this is an internal detail and it shouldn't be mentioned in the=

> doc comment?

Probably, yes, or it should be phrased differently so it's clear that
zero clusters do not contribute to the required space if it is possible
to represent them efficiently.

(Or explicitly state that the reason zero clusters may contribute to the
allocation size is that they may have to be converted to allocated
clusters.)

>> And is space for unallocated clusters included or not? Do unallocated
>> clusters without a backing image count as zero clusters?
>=20
> This depends on the output image format.  The raw format requires space=

> even for unallocated regions.  The qcow2 format is compact and only
> requires space for allocated clusters.

Right, that's what I would have thought.

>> If that space is not included, then it would run contrary to the QAPI
>> documentation which states that it should be included.
>=20
> Sorry, the raw format example in the QAPI doc is misleading without a
> qcow2 example.  The point of the raw format example was not to state
> that unallocated regions are included for *all* image formats.  It was
> just to show how the raw format behaves.

Oh, now I see. The "sparse file regions" bit was confusing for me. I
thought about format-specific sparse regions but it's actually about the
protocol level. Maybe that should be made more clear.

> I'll reword things in the next revision.
>=20
>> Finally, how are you supposed to check whether the backing file in @op=
ts
>> is shared by @in_bs?
>=20
> qemu-img convert -B <base> and -o backing_file=3D<base> simply do not
> check.  They rely on good old-fashioned^W^W^Wthe bad practice of
> trusting the user to provide valid input.
>=20
> qemu-img measure will work like this:
> 1. If the new image has a backing file, use has_zero_init=3Dfalse
>    semantics.
> 2. Do *not* rely on bdrv_get_block_status_above() because it's hard to
>    check how the backing chains of in_bs and the new image compare.
>=20
> This means the result will be conservative - perhaps clusters could hav=
e
> been shared with the backing file.

OK, that's what I had hoped. I was asking because this comment seems to
imply that somebody actually checks whether the backing file is shared.

>>> + *
>>> + * If @in_bs is NULL then the calculation includes no allocated clus=
ters
>>> + * unless a preallocation option is given in @opts.
>>
>> But the BlockMeasureInfo.required-bytes documentation states that a ne=
w
>> 5 GB raw image should still report 5 GB of required space.
>=20
> Even with 0 allocated clusters, the raw format always reports the
> virtual disk size (5 GB).  There is no contradiction here.

Yes, right. For some reason I thought about "allocated clusters" in the
new image rather than assumed allocated clusters in the input. For raw,
every cluster is always fully allocated.

Max


--XAg3SOxJtKx5rcmUQMpfs4m2sHTkRsT6L
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAljKDlISHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AzcQH/2DHq8EUYNNI7iNK9kA3GAM+c9Kz35T/
YOm81slarMmTfqL7phyjp4JDTXeOxICfpshgWJDL2r6Awd9c88sjM/cb1hGqGNkb
sSJF9O+aSTKANX8AYSJxvIaASurpk/HLbh0+VQJT6MwuBpCscKl9zPDPcPlXVeLI
/x32v1la+/Rf6gEptn0aGi6JD0nad0Ocq81G4rcKxCyO1Zr7aatFlCecKCmC4IYN
pNPo7am+jXWTiWjuN3BjBFB//k+FWI0eNYwU6vo2V3UExm9Ikg9tVvPh752823Vx
TDeBywcMtGkqbq2fpOS076gH02WUwMIKXNa6h7RUXdiu71zpZTMmP9c=
=2kyJ
-----END PGP SIGNATURE-----

--XAg3SOxJtKx5rcmUQMpfs4m2sHTkRsT6L--
