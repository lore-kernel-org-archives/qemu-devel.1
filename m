Received: from eggs.gnu.org ([2001:4830:134:3::10]:59469)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fb6xZ-00045Y-Po
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 12:18:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fb6xY-0003NI-D5
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 12:18:21 -0400
References: <20180704112302.471456-1-vsementsov@virtuozzo.com>
	<20180704112302.471456-3-vsementsov@virtuozzo.com>
	<68016e9d-eefe-adb0-2dee-3935ee0aa549@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <3049d97f-9d99-6f87-bb90-107c1b69f71a@virtuozzo.com>
Date: Thu, 5 Jul 2018 19:18:05 +0300
MIME-Version: 1.0
In-Reply-To: <68016e9d-eefe-adb0-2dee-3935ee0aa549@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH 2/2] nbd/server: send more than one extent
 of base:allocation context
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: pbonzini@redhat.com, den@openvz.org

05.07.2018 18:59, Eric Blake wrote:
> On 07/04/2018 06:23 AM, Vladimir Sementsov-Ogievskiy wrote:
>> This is necessary for efficient block-status export, for clients which
>> support it.
>
> qemu as client doesn't currently process additional information when=20
> querying block status.=C2=A0 Should it?
>
> Are there other clients which DO make use of the additional information?

Actually, we have one in development. block status export is used for=20
external full backups, like bitmap export - for external incremental=20
backups.

>
> This is a feature, so it is indeed 3.1 material.
>
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>> =C2=A0 nbd/server.c | 77=20
>> +++++++++++++++++++++++++++++++++++++++++++++---------------
>> =C2=A0 1 file changed, 58 insertions(+), 19 deletions(-)
>>
>> diff --git a/nbd/server.c b/nbd/server.c
>> index ea5fe0eb33..a6d013aec4 100644
>> --- a/nbd/server.c
>> +++ b/nbd/server.c
>> @@ -1844,11 +1844,22 @@ static int coroutine_fn=20
>> nbd_co_send_sparse_read(NBDClient *client,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>> =C2=A0 }
>> =C2=A0 -static int blockstatus_to_extent_be(BlockDriverState *bs, uint64=
_t=20
>> offset,
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint64_t=
 bytes, NBDExtent *extent)
>> +/*
>> + * Populate @extents from block status. Store in @bytes the byte=20
>> length encoded
>> + * (which may be smaller but (unlike bitmap_to_extents) _never_=20
>> larger than the
>> + * original), and store in @nb_extents the number of extents used.
>
> I don't think the comparison to bitmap_to_extents in a nested=20
> parenthetical buys us anything; the shorter:
>
> (which may be smaller than the original)
>
> would do just fine for the function contract.
>
>> + *
>> + * Returns zero on success and -errno on bdrv_block_status_above=20
>> failure.
>
> Is it worth returning a positive value for one less pointer parameter=20
> used for output?

I think, that if we have one such parameter anyway, let's use same path=20
for very similar thing, for consistency.

>
>> + */
>> +static int blockstatus_to_extents(BlockDriverState *bs, uint64_t=20
>> offset,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint64_t *bytes, NBD=
Extent *extents,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int *nb_ext=
ents)
>> =C2=A0 {
>> -=C2=A0=C2=A0=C2=A0 uint64_t remaining_bytes =3D bytes;
>> +=C2=A0=C2=A0=C2=A0 uint64_t remaining_bytes =3D *bytes;
>> +=C2=A0=C2=A0=C2=A0 NBDExtent *extent =3D extents, *extents_end =3D exte=
nts + *nb_extents;
>
> So both bytes and nb_extents are in-out.
>
>
>> @@ -1910,21 +1940,29 @@ static int nbd_co_send_extents(NBDClient=20
>> *client, uint64_t handle,
>> =C2=A0 /* Get block status from the exported device and send it to the=20
>> client */
>> =C2=A0 static int nbd_co_send_block_status(NBDClient *client, uint64_t=20
>> handle,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 BlockDriverState *bs, uint64_t=20
>> offset,
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint32_t=
 length, bool last,
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint32_t=
 context_id, Error **errp)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint32_t=
 length, bool=20
>> dont_fragment,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool las=
t, uint32_t context_id,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Error **=
errp)
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int ret;
>> -=C2=A0=C2=A0=C2=A0 NBDExtent extent;
>> +=C2=A0=C2=A0=C2=A0 unsigned int nb_extents =3D dont_fragment ? 1 :=20
>> NBD_MAX_BITMAP_EXTENTS;
>> +=C2=A0=C2=A0=C2=A0 NBDExtent *extents =3D g_new(NBDExtent, nb_extents);
>> +=C2=A0=C2=A0=C2=A0 uint64_t final_length =3D length;
>> =C2=A0 -=C2=A0=C2=A0=C2=A0 ret =3D blockstatus_to_extent_be(bs, offset, =
length, &extent);
>> +=C2=A0=C2=A0=C2=A0 ret =3D blockstatus_to_extents(bs, offset, &final_le=
ngth, extents,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &nb_extents);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret < 0) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_free(extents);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return nbd_co_sen=
d_structured_error(
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 client, handle, -ret, "can't get block statu=
s", errp);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0 -=C2=A0=C2=A0=C2=A0 return nbd_co_send_extents(client, handle, &e=
xtent, 1,
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 be32_to_cpu(extent.length), last,
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 context_id, errp);
>> +=C2=A0=C2=A0=C2=A0 ret =3D nbd_co_send_extents(client, handle, extents,=
 nb_extents,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 final_length, last, context_id, errp);
>> +
>> +=C2=A0=C2=A0=C2=A0 g_free(extents);
>> +
>
> At any rate, this conversion looks sane.
>
>> +=C2=A0=C2=A0=C2=A0 return ret;
>> =C2=A0 }
>> =C2=A0 =C2=A0 /*
>> @@ -2228,10 +2266,11 @@ static coroutine_fn int=20
>> nbd_handle_request(NBDClient *client,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 (client->export_meta.base_allocation ||
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 client->export_meta.bitmap))
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool=
 dont_fragment =3D request->flags & NBD_CMD_FLAG_REQ_ONE;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 if (client->export_meta.base_allocation) {
>
> Blank lines between declarations and statements can aid in legibility;=20
> I can add when queuing.
>
> Reviewed-by: Eric Blake <eblake@redhat.com>
>

Ok, thank you!

--=20
Best regards,
Vladimir
