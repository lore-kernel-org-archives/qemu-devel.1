Received: from eggs.gnu.org ([2001:4830:134:3::10]:49974)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fVwWy-0007Dn-Ee
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 06:09:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fVwWt-00030J-DP
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 06:09:32 -0400
References: <20180609151758.17343-1-vsementsov@virtuozzo.com>
	<20180609151758.17343-5-vsementsov@virtuozzo.com>
	<899fcefc-84f1-7238-c77b-9c925c9872c5@redhat.com>
	<37e9fc1c-9c65-2121-12c9-4b648fea3947@virtuozzo.com>
	<d297899a-5019-4d14-37fd-6d35b932d0d8@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <09060574-28ed-f2ee-f9ff-1c4974293566@virtuozzo.com>
Date: Thu, 21 Jun 2018 13:09:19 +0300
MIME-Version: 1.0
In-Reply-To: <d297899a-5019-4d14-37fd-6d35b932d0d8@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v5 4/6] nbd/server: implement dirty bitmap
 export
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: armbru@redhat.com, pbonzini@redhat.com, mreitz@redhat.com, kwolf@redhat.com, den@openvz.org

20.06.2018 21:09, Eric Blake wrote:
> On 06/20/2018 12:04 PM, Vladimir Sementsov-Ogievskiy wrote:
>> 20.06.2018 19:27, Eric Blake wrote:
>>> On 06/09/2018 10:17 AM, Vladimir Sementsov-Ogievskiy wrote:
>>>> Handle new NBD meta namespace: "qemu", and corresponding queries:
>>>> "qemu:dirty-bitmap:<export bitmap name>".
>>>>
>>>> With new metadata context negotiated, BLOCK_STATUS query will reply
>>>> with dirty-bitmap data, converted to extents. New public function
>>>> nbd_export_bitmap selects bitmap to export. For now, only one bitmap
>>>> may be exported.
>>>>
>
>>> =C2=A0static int nbd_co_send_extents(NBDClient *client, uint64_t handle=
,
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 NBDExtent *extents, unsigned=20
>>> nb_extents,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 NBDExtent *extents, unsigned int=20
>>> nb_extents,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint64_t length, bool last,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint32_t context_id, Error **err=
p)
>>> =C2=A0{
>>> =C2=A0=C2=A0=C2=A0=C2=A0 NBDStructuredMeta chunk;
>>> @@ -1890,7 +1897,9 @@ static int nbd_co_send_extents(NBDClient=20
>>> *client, uint64_t handle,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {.iov_base =3D extents=
, .iov_len =3D nb_extents *=20
>>> sizeof(extents[0])}
>>> =C2=A0=C2=A0=C2=A0=C2=A0 };
>>>
>>> -=C2=A0=C2=A0=C2=A0 set_be_chunk(&chunk.h, 0, NBD_REPLY_TYPE_BLOCK_STAT=
US,
>>> +=C2=A0=C2=A0=C2=A0 trace_nbd_co_send_extents(handle, nb_extents, conte=
xt_id,=20
>>> length, last);
>>
>> hm, length variable added only to be traced.. Ok, but a bit strange.
>
> Yes. It doesn't affect what goes over the wire, but when it comes to=20
> tracing, knowing the sum of the extents can be quite helpful=20
> (especially knowing if the server's reply is shorter or longer than=20
> the client's request, and the fact that when two or more contexts are=20
> negotiated by the client, the different contexts can have different=20
> length replies)
>
>
>>> +static unsigned int bitmap_to_extents(BdrvDirtyBitmap *bitmap,=20
>>> uint64_t offset,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 uint64_t *length, NBDExtent=20
>>> *extents,
>>
>> length - in-out? worth comment?
>
> Sure.
>
>>
>>> + unsigned int nb_extents,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 bool dont_fragment)
>>> =C2=A0{
>>> =C2=A0=C2=A0=C2=A0=C2=A0 uint64_t begin =3D offset, end;
>>> -=C2=A0=C2=A0=C2=A0 uint64_t overall_end =3D offset + length;
>>> -=C2=A0=C2=A0=C2=A0 unsigned i =3D 0;
>>> +=C2=A0=C2=A0=C2=A0 uint64_t overall_end =3D offset + *length;
>>> +=C2=A0=C2=A0=C2=A0 unsigned int i =3D 0;
>>> =C2=A0=C2=A0=C2=A0=C2=A0 BdrvDirtyBitmapIter *it;
>>> =C2=A0=C2=A0=C2=A0=C2=A0 bool dirty;
>>>
>>> @@ -1983,23 +1994,25 @@ static unsigned=20
>>> bitmap_to_extents(BdrvDirtyBitmap *bitmap, uint64_t offset,
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0 bdrv_dirty_bitmap_unlock(bitmap);
>>>
>>> +=C2=A0=C2=A0=C2=A0 *length =3D end - begin;
>>
>> hm, it will always be zero, as at the end of the previous loop we=20
>> have "begin =3D end;"
>
> Ah, then it should be end - offset. Thanks for the careful review.
>
> In fact, since ONLY the final extent can be larger than 2G (all=20
> earlier extents were short of the overall_end, and the incoming length=20
> is 32-bit), but the NBD protocol says that at most one extent can go=20
> beyond the original request, we do NOT want to split a >2G extent into=20
> multiple extents, but rather cap it to just shy of 4G at the=20
> granularity offered by the bitmap itself.=C2=A0 At which point=20
> add_extents() never returns more than 1, and can just be inlined.
>
>>
>>> return i;
>>> =C2=A0}
>>>
>>> =C2=A0static int nbd_co_send_bitmap(NBDClient *client, uint64_t handle,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BdrvDirtyBitmap *bitmap, uint64_t=20
>>> offset,
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint64_t length, bool dont_fragment,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint32_t length, bool dont_fragment,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint32_t context_id, Error **errp)
>>> =C2=A0{
>>> =C2=A0=C2=A0=C2=A0=C2=A0 int ret;
>>> -=C2=A0=C2=A0=C2=A0 unsigned nb_extents =3D dont_fragment ? 1 : NBD_MAX=
_BITMAP_EXTENTS;
>>> +=C2=A0=C2=A0=C2=A0 unsigned int nb_extents =3D dont_fragment ? 1 :=20
>>> NBD_MAX_BITMAP_EXTENTS;
>>> =C2=A0=C2=A0=C2=A0=C2=A0 NBDExtent *extents =3D g_new(NBDExtent, nb_ext=
ents);
>>> +=C2=A0=C2=A0=C2=A0 uint64_t final_length =3D length;
>>>
>>> -=C2=A0=C2=A0=C2=A0 nb_extents =3D bitmap_to_extents(bitmap, offset, le=
ngth, extents,=20
>>> nb_extents,
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dont_fragment)=
;
>>> +=C2=A0=C2=A0=C2=A0 nb_extents =3D bitmap_to_extents(bitmap, offset, &f=
inal_length,=20
>>> extents,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nb_extents, do=
nt_fragment);
>>>
>>> -=C2=A0=C2=A0=C2=A0 ret =3D nbd_co_send_extents(client, handle, extents=
, nb_extents,=20
>>> context_id,
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 errp);
>>> +=C2=A0=C2=A0=C2=A0 ret =3D nbd_co_send_extents(client, handle, extents=
, nb_extents,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 final_length, true, context_id, errp);
>>
>> hmm in-out pointer field only to trace final_length? may be just=20
>> trace it in bitmap_to_extents?
>
> No, because base:allocation also benefits from tracing final_length.
>
>>
>> also, it's not trivial, that the function now sends FLAG_DONE. I=20
>> think, worth add a comment, or
>> a parameter like for nbd_co_send_block_status. It will simplify=20
>> introducing new contexts in future.
>
> Do we anticipate adding any in the near future? But adding a parameter=20
> that is always true so that the callsite becomes more obvious on when=20
> to pass the done flag may indeed make future additions easier to spot=20
> in one place.
>
> So here's what else I'll squash in:
>
> diff --git i/nbd/server.c w/nbd/server.c
> index e84aea6cf03..7a96b296839 100644
> --- i/nbd/server.c
> +++ w/nbd/server.c
> @@ -1881,9 +1881,10 @@ static int=20
> blockstatus_to_extent_be(BlockDriverState *bs, uint64_t offset,
>
> =C2=A0/* nbd_co_send_extents
> =C2=A0 *
> - * @last controls whether NBD_REPLY_FLAG_DONE is sent.
> - *
> - * @extents should already be in big-endian format.
> + * @length is only for tracing purposes (and may be smaller or larger
> + * than the client's original request). @last controls whether
> + * NBD_REPLY_FLAG_DONE is sent. @extents should already be in
> + * big-endian format.
> =C2=A0 */
> =C2=A0static int nbd_co_send_extents(NBDClient *client, uint64_t handle,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 NBDExtent *extents, unsigned int=20
> nb_extents,
> @@ -1925,33 +1926,12 @@ static int nbd_co_send_block_status(NBDClient=20
> *client, uint64_t handle,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 context_id, errp);
> =C2=A0}
>
> -/* Set several extents, describing region of given @length with given=20
> @flags.
> - * Do not set more than @nb_extents, return number of set extents.
> +/*
> + * Populate @extents from a dirty bitmap. Unless @dont_fragment, the
> + * final extent may exceed the original @length. Store in @length the
> + * byte length encoded (which may be smaller or larger than the
> + * original), and return the number of extents used.
> =C2=A0 */
> -static unsigned int add_extents(NBDExtent *extents, unsigned nb_extents,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint64_t length, uint32_t flags)
> -{
> -=C2=A0=C2=A0=C2=A0 unsigned int i =3D 0;
> -=C2=A0=C2=A0=C2=A0 uint32_t max_extent =3D 0x80000000U;
> -=C2=A0=C2=A0=C2=A0 uint32_t max_extent_be =3D cpu_to_be32(max_extent);
> -=C2=A0=C2=A0=C2=A0 uint32_t flags_be =3D cpu_to_be32(flags);
> -
> -=C2=A0=C2=A0=C2=A0 for (i =3D 0; i < nb_extents && length > max_extent;
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 i++, length -=3D max_ex=
tent)
> -=C2=A0=C2=A0=C2=A0 {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extents[i].length =3D max_ext=
ent_be;
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extents[i].flags =3D flags_be=
;
> -=C2=A0=C2=A0=C2=A0 }
> -
> -=C2=A0=C2=A0=C2=A0 if (length > 0 && i < nb_extents) {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extents[i].length =3D cpu_to_=
be32(length);
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extents[i].flags =3D flags_be=
;
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 i++;
> -=C2=A0=C2=A0=C2=A0 }
> -
> -=C2=A0=C2=A0=C2=A0 return i;
> -}
> -
> =C2=A0static unsigned int bitmap_to_extents(BdrvDirtyBitmap *bitmap,=20
> uint64_t offset,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 uint64_t *length, NBDExtent=20
> *extents,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 unsigned int nb_extents,
> @@ -1976,16 +1956,18 @@ static unsigned int=20
> bitmap_to_extents(BdrvDirtyBitmap *bitmap, uint64_t offset,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
end =3D bdrv_dirty_iter_next(it);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (end =3D=3D -1) {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 end =
=3D bdrv_dirty_bitmap_size(bitmap);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Ca=
p to an aligned value < 4G beyond begin. */
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 end =
=3D MIN(bdrv_dirty_bitmap_size(bitmap),
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 begin + 0x100000000U=
LL -
> + bdrv_dirty_bitmap_granularity(bitmap));

so, in case of end =3D=3D -1, all ok

> }

but else, it may be near to the whole bitmap, and end - begin may be=20
more and more larger than 4G..
so, you can leave "end =3D bdrv_dirty_bitmap_size(bitmap)" as is, and move=
=20
end =3D MIN after if(){} block.

also and in this case, we may add two extents, and we lose information=20
about the second, but it's not significant.

> if (dont_fragment && end > overall_end) {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* We=
 MUST not exceed requested region if=20
> NBD_CMD_FLAG_REQ_ONE flag
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 * is set */

why drop it?

> end =3D overall_end;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 i +=3D add_extents(extents + =
i, nb_extents - i, end - begin,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 di=
rty ? NBD_STATE_DIRTY : 0);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extents[i].length =3D cpu_to_=
be32(end - begin);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extents[i].flags =3D cpu_to_b=
e32(dirty ? NBD_STATE_DIRTY : 0);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 i++;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 begin =3D end;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dirty =3D !dirty;
> =C2=A0=C2=A0=C2=A0=C2=A0 }
> @@ -1994,13 +1976,13 @@ static unsigned int=20
> bitmap_to_extents(BdrvDirtyBitmap *bitmap, uint64_t offset,
>
> =C2=A0=C2=A0=C2=A0=C2=A0 bdrv_dirty_bitmap_unlock(bitmap);
>
> -=C2=A0=C2=A0=C2=A0 *length =3D end - begin;
> +=C2=A0=C2=A0=C2=A0 *length =3D end - offset;
> =C2=A0=C2=A0=C2=A0=C2=A0 return i;
> =C2=A0}
>
> =C2=A0static int nbd_co_send_bitmap(NBDClient *client, uint64_t handle,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BdrvDirtyBitmap *bitmap, uint64_t offset,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint32_t length, bool dont_fragment,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint32_t length, bool dont_fragment,=20
> bool last,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint32_t context_id, Error **errp)
> =C2=A0{
> =C2=A0=C2=A0=C2=A0=C2=A0 int ret;
> @@ -2012,7 +1994,7 @@ static int nbd_co_send_bitmap(NBDClient *client,=20
> uint64_t handle,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nb_extents,=
 dont_fragment);
>
> =C2=A0=C2=A0=C2=A0=C2=A0 ret =3D nbd_co_send_extents(client, handle, exte=
nts, nb_extents,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 final_length, true, context_id, errp);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 final_length, last, context_id, errp);
>
> =C2=A0=C2=A0=C2=A0=C2=A0 g_free(extents);
>
> @@ -2253,7 +2235,7 @@ static coroutine_fn int=20
> nbd_handle_request(NBDClient *client,
> client->exp->export_bitmap,
> request->from, request->len,
> request->flags & NBD_CMD_FLAG_REQ_ONE,
> - NBD_META_ID_DIRTY_BITMAP, errp);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 true,=20
> NBD_META_ID_DIRTY_BITMAP, errp);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 if (ret < 0) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 }
>
>


--=20
Best regards,
Vladimir
