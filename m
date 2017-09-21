Received: from eggs.gnu.org ([2001:4830:134:3::10]:34783)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dv4eW-0001G0-FR
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 12:48:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dv4eU-000174-Nk
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 12:48:40 -0400
References: <20170920135833.20472-1-pbutsykin@virtuozzo.com>
	<20170920135833.20472-3-pbutsykin@virtuozzo.com>
	<ac533c95-a0f5-c6ce-cc6a-7fab63eb0517@redhat.com>
	<79eb6628-130e-af9d-cd39-56bf71194ae3@virtuozzo.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <ccbd7d7e-512a-76ea-5b03-8853fd88fda2@redhat.com>
Date: Thu, 21 Sep 2017 12:48:30 -0400
MIME-Version: 1.0
In-Reply-To: <79eb6628-130e-af9d-cd39-56bf71194ae3@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 2/2] qcow2: truncate the tail
 of the image file after shrinking the image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Butsykin <pbutsykin@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, den@openvz.org, mreitz@redhat.com



On 09/21/2017 05:49 AM, Pavel Butsykin wrote:
> On 21.09.2017 00:38, John Snow wrote:
>>
>>
>> On 09/20/2017 09:58 AM, Pavel Butsykin wrote:
>>> Now after shrinking the image, at the end of the image file, there
>>> might be a
>>> tail that probably will never be used. So we can find the last used
>>> cluster and
>>> cut the tail.
>>>
>>> Signed-off-by: Pavel Butsykin <pbutsykin@virtuozzo.com>
>>> ---
>>> =C2=A0 block/qcow2-refcount.c | 21 +++++++++++++++++++++
>>> =C2=A0 block/qcow2.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | 19 +++++++++++++++++++
>>> =C2=A0 block/qcow2.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 1 +
>>> =C2=A0 3 files changed, 41 insertions(+)
>>>
>>> diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
>>> index 88d5a3f1ad..5e221a166c 100644
>>> --- a/block/qcow2-refcount.c
>>> +++ b/block/qcow2-refcount.c
>>> @@ -3181,3 +3181,24 @@ out:
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_free(reftable_tmp);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>>> =C2=A0 }
>>> +
>>> +int64_t qcow2_get_last_cluster(BlockDriverState *bs, int64_t size)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 BDRVQcow2State *s =3D bs->opaque;
>>> +=C2=A0=C2=A0=C2=A0 int64_t i, last_cluster, nb_clusters =3D size_to_=
clusters(s, size);
>>> +=C2=A0=C2=A0=C2=A0 uint64_t refcount;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 for (i =3D 0, last_cluster =3D 0; i < nb_clusters=
; i++) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int ret =3D qcow2_get_ref=
count(bs, i, &refcount);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret < 0) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 f=
printf(stderr, "Can't get refcount for cluster %"
>>> PRId64 ": %s\n",
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 i, strerror(-ret));
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 c=
ontinue;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (refcount > 0) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 l=
ast_cluster =3D i;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0 return last_cluster;
>>> +}> diff --git a/block/qcow2.c b/block/qcow2.c
>>> index 8a4311d338..c3b6dd44c4 100644
>>> --- a/block/qcow2.c
>>> +++ b/block/qcow2.c
>>> @@ -3106,6 +3106,7 @@ static int qcow2_truncate(BlockDriverState *bs,
>>> int64_t offset,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 new_l1_size =3D size_to_l1(s, offset);
>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (offset < old_length) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int64_t image_end_offset,=
 old_file_size;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (prealloc !=
=3D PREALLOC_MODE_OFF) {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 error_setg(errp,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 "Preallocation can't be used for shrinking
>>> an image");
>>> @@ -3134,6 +3135,24 @@ static int qcow2_truncate(BlockDriverState
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
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 image_end_offset =3D (qco=
w2_get_last_cluster(bs,
>>> old_file_size) + 1) *
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 s->cluster_size;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (image_end_offset < ol=
d_file_size) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r=
et =3D bdrv_truncate(bs->file, image_end_offset,
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
>>
>> I've recently become skeptical of what partial resize successes look
>> like, but that's an issue for another day entirely.
>>
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 return ret;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D qcow2_=
grow_l1_table(bs, new_l1_size, true);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret < 0) {
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
>> Reviewed-by: John Snow <jsnow@redhat.com>
>>
>> Looks sane to me, but under which circumstances might we grow such a
>> tail? I assume the actual truncate call aligns to cluster boundaries a=
s
>> appropriate, so is this a bit of a "quick fix" to cull unused clusters
>> that happened to be near the truncate boundary?
>>
>> It might be worth documenting the circumstances that produces this
>> unused space that will never get used. My hunch is that such unused
>> space should likely be getting reclaimed elsewhere and not here, but
>> perhaps I'm misunderstanding the causal factors.
>>
>=20
> This is a consequence of how we implemented shrinking the qcow2 image.
> (https://lists.gnu.org/archive/html/qemu-devel/2017-09/msg04580.html)
> But on the other hand, if we need to shrink the qcow2 image without
> copying the data, this is the only way. The same guest offset can be
> converted to almost any host offset in the file i.e. the first guest
> cluster may be located somewhere at the end or the middle of the image
> file. So we can't just take and truncate the image file on the border o=
f
> the truncation, therefore to shrink the image we just discard the
> clusters that corresponds to the truncated area. The result is a
> sparse image file where the apparent file size differs from actual size=
.
> And the tail in this case is the difference between the actual size and
> last used cluster in the image, so in fact the cutting of the tail does
> not change the apparent file size.
>=20

Oh, duh, I get it. The truncation itself creates a lot of sparseness.

Thanks for the explanation.
