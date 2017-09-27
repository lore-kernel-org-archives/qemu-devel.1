Received: from eggs.gnu.org ([2001:4830:134:3::10]:52739)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dxFKC-0001bU-QC
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 12:36:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dxFKB-0001mk-Il
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 12:36:40 -0400
References: <20170922093926.9723-1-pbutsykin@virtuozzo.com>
	<20170922093926.9723-3-pbutsykin@virtuozzo.com>
	<46949467-5bed-602b-5d64-badf92c059e1@redhat.com>
	<6a53fa30-03b0-cd04-ef12-e41656e78900@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <8cdd4df8-a9c0-70f1-909c-ba7e91ab554c@redhat.com>
Date: Wed, 27 Sep 2017 18:36:26 +0200
MIME-Version: 1.0
In-Reply-To: <6a53fa30-03b0-cd04-ef12-e41656e78900@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="5Vopc6NxQjKWEwukvwH3mcKV3IScMoPMG"
Subject: Re: [Qemu-devel] [PATCH v2 2/2] qcow2: truncate the tail of the
 image file after shrinking the image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Butsykin <pbutsykin@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, eblake@redhat.com, jsnow@redhat.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5Vopc6NxQjKWEwukvwH3mcKV3IScMoPMG
From: Max Reitz <mreitz@redhat.com>
To: Pavel Butsykin <pbutsykin@virtuozzo.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Cc: kwolf@redhat.com, eblake@redhat.com, jsnow@redhat.com, den@openvz.org
Message-ID: <8cdd4df8-a9c0-70f1-909c-ba7e91ab554c@redhat.com>
Subject: Re: [PATCH v2 2/2] qcow2: truncate the tail of the image file after
 shrinking the image
References: <20170922093926.9723-1-pbutsykin@virtuozzo.com>
 <20170922093926.9723-3-pbutsykin@virtuozzo.com>
 <46949467-5bed-602b-5d64-badf92c059e1@redhat.com>
 <6a53fa30-03b0-cd04-ef12-e41656e78900@virtuozzo.com>
In-Reply-To: <6a53fa30-03b0-cd04-ef12-e41656e78900@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-09-27 18:27, Pavel Butsykin wrote:
> On 27.09.2017 19:00, Max Reitz wrote:
>> On 2017-09-22 11:39, Pavel Butsykin wrote:
>>> Now after shrinking the image, at the end of the image file, there
>>> might be a
>>> tail that probably will never be used. So we can find the last used
>>> cluster and
>>> cut the tail.
>>>
>>> Signed-off-by: Pavel Butsykin <pbutsykin@virtuozzo.com>
>>> ---
>>> =C2=A0 block/qcow2-refcount.c | 22 ++++++++++++++++++++++
>>> =C2=A0 block/qcow2.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | 23 +++++++++++++++++++++++
>>> =C2=A0 block/qcow2.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 1 +
>>> =C2=A0 3 files changed, 46 insertions(+)
>>>
>>> diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
>>> index 88d5a3f1ad..aa3fd6cf17 100644
>>> --- a/block/qcow2-refcount.c
>>> +++ b/block/qcow2-refcount.c
>>> @@ -3181,3 +3181,25 @@ out:
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_free(reftable_tmp);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>>> =C2=A0 }
>>> +
>>> +int64_t qcow2_get_last_cluster(BlockDriverState *bs, int64_t size)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 BDRVQcow2State *s =3D bs->opaque;
>>> +=C2=A0=C2=A0=C2=A0 int64_t i;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 for (i =3D size_to_clusters(s, size) - 1; i >=3D =
0; i--) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint64_t refcount;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int ret =3D qcow2_get_ref=
count(bs, i, &refcount);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret < 0) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 f=
printf(stderr, "Can't get refcount for cluster %"
>>> PRId64 ": %s\n",
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 i, strerror(-ret));
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r=
eturn ret;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (refcount > 0) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r=
eturn i;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0 qcow2_signal_corruption(bs, true, -1, -1,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 "There are no references in the refcount
>>> table.");
>>> +=C2=A0=C2=A0=C2=A0 return -EIO;
>>> +}
>>> diff --git a/block/qcow2.c b/block/qcow2.c
>>> index 8a4311d338..8dfb5393a7 100644
>>> --- a/block/qcow2.c
>>> +++ b/block/qcow2.c
>>> @@ -3106,6 +3106,7 @@ static int qcow2_truncate(BlockDriverState *bs,=

>>> int64_t offset,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 new_l1_size =3D size_to_l1(s, offset);=

>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (offset < old_length) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int64_t last_cluster, old=
_file_size;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (prealloc !=
=3D PREALLOC_MODE_OFF) {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 error_setg(errp,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 "Preallocation can't be used for shrinking
>>> an image");
>>> @@ -3134,6 +3135,28 @@ static int qcow2_truncate(BlockDriverState
>>> *bs, int64_t offset,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "Failed to discard unused refblocks"=
);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 return ret;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 old_file_size =3D bdrv_ge=
tlength(bs->file->bs);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (old_file_size < 0) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 e=
rror_setg_errno(errp, -old_file_size,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 "Failed to inquire current file length");
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r=
eturn old_file_size;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 last_cluster =3D qcow2_ge=
t_last_cluster(bs, old_file_size);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (last_cluster < 0) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 e=
rror_setg_errno(errp, -last_cluster,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 "Failed to find the last cluster");
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r=
eturn last_cluster;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>
>> My idea was rather that you just wouldn't truncate the image file if
>> something fails here.=C2=A0 So in any of these new cases where you cur=
rently
>> just report the whole truncate operation as having failed, you could
>> just emit a warning and not do the truncation of bs->file.
>=20
> I'm not sure that's right. If the qcow2_get_last_cluster() returned an
> error, probably with the image was a problem.. can we continue to work
> with the image without risking to damage it even more? if something bad=

> happened with the reftable we usually mark the image as corrupted, it's=

> the same thing.

Well, the only thing that's left to do is to write the new size into the
image header, so I think that should work just fine...

I won't disagree that bdrv_getlength() or qcow2_get_last_cluster()
failing may be reasons to stop truncation (although I don't think they
necessarily are at this point).

But I could well imagine that the below bdrv_truncate() of bs->file
fails for benign reasons, e.g. because the underlying protocol does not
support shrinking of images or something.  Then we probably should carry =
on.

Max

> Although if the shrink is almost complete, the truncation of bs->file
> isn't so important thing and we could update qcow2 header.
>=20
>> I can live with the current version, though, so:
>>
>> Reviewed-by: Max Reitz <mreitz@redhat.com>
>>
>> But I'll wait for a response from you before merging this series.
>>
>> Max
>>
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if ((last_cluster + 1) * =
s->cluster_size < old_file_size) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r=
et =3D bdrv_truncate(bs->file, (last_cluster + 1) *
>>> s->cluster_size,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 PREALLOC_MODE_OFF, NULL);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 i=
f (ret < 0) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 error_setg_errno(errp, -ret,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "Failed to truncate the =
tail of the
>>> image");
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 return ret;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }=

>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D qcow2_=
grow_l1_table(bs, new_l1_size, true);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret < 0) {=

>>> diff --git a/block/qcow2.h b/block/qcow2.h
>>> index 5a289a81e2..782a206ecb 100644
>>> --- a/block/qcow2.h
>>> +++ b/block/qcow2.h
>>> @@ -597,6 +597,7 @@ int qcow2_change_refcount_order(BlockDriverState
>>> *bs, int refcount_order,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BlockDriverAmendSt=
atusCB *status_cb,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 void *cb_opaque, E=
rror **errp);
>>> =C2=A0 int qcow2_shrink_reftable(BlockDriverState *bs);
>>> +int64_t qcow2_get_last_cluster(BlockDriverState *bs, int64_t size);
>>> =C2=A0 =C2=A0 /* qcow2-cluster.c functions */
>>> =C2=A0 int qcow2_grow_l1_table(BlockDriverState *bs, uint64_t min_siz=
e,
>>>
>>
>>



--5Vopc6NxQjKWEwukvwH3mcKV3IScMoPMG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlnL04oSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AKm4H/jt0XZUPtSb6LWN567U/+WxV0fdaBNkA
qoyRZXPrVYuwOk4A1sB+tfxdqupPllEWRHgLsJHNbuiZsJ2Nr20VNk8GRrWFUyD2
Ay9idDzFcuXwCuLXH8liUKjM0cmnmcWi9KmXOTBLD2yKcpI3mvglpoD0zfO5WCsh
gZUgIy5FEoqDhnNLOFMQhIGCxDrysDHQPtr/daO5yEDAQeM5HE79jIP1v4a6zKuZ
LN/6SaVKqzPEiXebfahmsL+xnAHu5tI/SqGIfhuOjG/3S/xEWqQGIsBNv+EfGaEK
dQBtQSIIOmxWf6YeQyKw/xd/PDSUSbZ5BcKBHuEiwe465HWkmlUhrnU=
=/kRe
-----END PGP SIGNATURE-----

--5Vopc6NxQjKWEwukvwH3mcKV3IScMoPMG--
