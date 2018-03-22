Received: from eggs.gnu.org ([2001:4830:134:3::10]:60689)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1ez2DB-0003ec-AG
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 11:33:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1ez2D6-0001UG-Gm
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 11:33:05 -0400
References: <20180321121940.39426-1-vsementsov@virtuozzo.com>
	<20180321121940.39426-4-vsementsov@virtuozzo.com>
	<e21af76d-977d-cadf-0a27-14a2d2aa228a@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <20c96aa9-8c47-e99a-8c89-1e23aa64eb4b@virtuozzo.com>
Date: Thu, 22 Mar 2018 18:32:45 +0300
MIME-Version: 1.0
In-Reply-To: <e21af76d-977d-cadf-0a27-14a2d2aa228a@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH 3/4] nbd/server: implement dirty bitmap
 export
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: armbru@redhat.com, mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org

21.03.2018 19:57, Eric Blake wrote:
> On 03/21/2018 07:19 AM, Vladimir Sementsov-Ogievskiy wrote:
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>

[...]

>
>> +
>> +#define NBD_STATE_DIRTY 1
>
> Does this belong better in nbd.h, alongside NBD_STATE_HOLE?=C2=A0 (And=20
> defining it as (1 << 0) might be nicer, too).

It's not used anywhere else, but it may be worth moving, for consistency=20
and for future users. Ok, I'll move.


[...]

>> =C2=A0 +/* nbd_meta_bitmap_query
>> + *
>> + * Handle query to 'qemu-dirty-bitmap' namespace.
>> + * 'len' is the amount of text remaining to be read from the current=20
>> name, after
>> + * the 'qemu-dirty-bitmap:' portion has been stripped.
>> + *
>> + * Return -errno on I/O error, 0 if option was completely handled by
>> + * sending a reply about inconsistent lengths, or 1 on success. */
>> +static int nbd_meta_bitmap_query(NBDClient *client,=20
>> NBDExportMetaContexts *meta,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint32_t len, Error **errp=
)
>> +{
>> +=C2=A0=C2=A0=C2=A0 if (!client->exp->export_bitmap) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return nbd_opt_skip(client, =
len, errp);
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 return nbd_meta_single_query(client,=20
>> client->exp->export_bitmap_name, len,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &meta->dirty_bitmap, errp)=
;
>
> So if I'm reading this right, a client can do _LIST_=20
> 'qemu-dirty-bitmap:' (or 'qemu:dirty-bitmap:' if we choose a shorter=20
> initial namespace) and get back the exported bitmap name; or the user=20
> already knows the bitmap name and both _LIST_ and _SET_=20
> 'qemu-dirty-bitmap:name' return the one supported bitmap for that NBD=20
> server.

yes

>
>
>> =C2=A0 /* nbd_co_send_extents
>> + *
>> + * NBD_REPLY_FLAG_DONE is not set, don't forget to send it.
>> + *
>> =C2=A0=C2=A0 * @extents should be in big-endian */
>> =C2=A0 static int nbd_co_send_extents(NBDClient *client, uint64_t handle=
,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 NBDExtent *extents, unsigned=
=20
>> nb_extents,
>
> Worth a bool flag that the caller can inform this function whether to=20
> include FLAG_DONE?

It was simpler to just send it separately, after all BLOCK_STATUS=20
replies. So, I didn't need it.

>> +
>> +static int nbd_co_send_bitmap(NBDClient *client, uint64_t handle,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BdrvDirtyBitmap *bitmap, uint64_t offset,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint64_t length, uint32_t context_id,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Error **errp)
>> +{
>> +=C2=A0=C2=A0=C2=A0 int ret;
>> +=C2=A0=C2=A0=C2=A0 unsigned nb_extents;
>> +=C2=A0=C2=A0=C2=A0 NBDExtent *extents =3D g_new(NBDExtent, NBD_MAX_BITM=
AP_EXTENTS);
>
> Is this correct even when the client used NBD_CMD_FLAG_REQ_ONE?
>

Oops, looks like a bug.

--=20
Best regards,
Vladimir
