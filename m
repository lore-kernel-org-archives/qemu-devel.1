Received: from eggs.gnu.org ([2001:4830:134:3::10]:38004)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fVdjK-0004Uf-86
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 10:05:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fVdjH-0003mM-10
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 10:05:02 -0400
References: <20180609151758.17343-1-vsementsov@virtuozzo.com>
	<20180609151758.17343-5-vsementsov@virtuozzo.com>
	<4ab9dd4e-1c79-fbe2-8e4b-6563e3775366@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <800061c3-2a9a-a384-a1ab-a92ddd885eac@virtuozzo.com>
Date: Wed, 20 Jun 2018 17:04:49 +0300
MIME-Version: 1.0
In-Reply-To: <4ab9dd4e-1c79-fbe2-8e4b-6563e3775366@redhat.com>
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

20.06.2018 14:24, Eric Blake wrote:
> On 06/09/2018 10:17 AM, Vladimir Sementsov-Ogievskiy wrote:
>> Handle new NBD meta namespace: "qemu", and corresponding queries:
>
> s/new/a new/
>
>> "qemu:dirty-bitmap:<export bitmap name>".
>>
>> With new metadata context negotiated, BLOCK_STATUS query will reply
>
> s/new/the new/
>
>> with dirty-bitmap data, converted to extents. New public function
>
> s/New/The new/
>
>> nbd_export_bitmap selects bitmap to export. For now, only one bitmap
>
> s/bitmap/which bitmap/
>
>> may be exported.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>> =C2=A0 include/block/nbd.h |=C2=A0=C2=A0 6 ++
>> =C2=A0 nbd/server.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 271=20
>> ++++++++++++++++++++++++++++++++++++++++++++++++----
>> =C2=A0 2 files changed, 259 insertions(+), 18 deletions(-)
>>
>> diff --git a/include/block/nbd.h b/include/block/nbd.h
>> index fcdcd54502..a653d0fba7 100644
>> --- a/include/block/nbd.h
>> +++ b/include/block/nbd.h
>> @@ -234,6 +234,10 @@ enum {
>> =C2=A0 #define NBD_STATE_HOLE (1 << 0)
>> =C2=A0 #define NBD_STATE_ZERO (1 << 1)
>> =C2=A0 +/* Flags for extents (NBDExtent.flags) of=20
>> NBD_REPLY_TYPE_BLOCK_STATUS,
>> + * for qemu:dirty-bitmap:* meta contexts */
>
> Comment tail.
>
>> +#define NBD_STATE_DIRTY (1 << 0)
>> +
>> =C2=A0 static inline bool nbd_reply_type_is_error(int type)
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return type & (1 << 15);
>> @@ -315,6 +319,8 @@ void nbd_client_put(NBDClient *client);
>> =C2=A0 void nbd_server_start(SocketAddress *addr, const char *tls_creds,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Error **=
errp);
>> =C2=A0 +void nbd_export_bitmap(NBDExport *exp, const char *bitmap,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const char =
*bitmap_export_name, Error **errp);
>> =C2=A0 =C2=A0 /* nbd_read
>> =C2=A0=C2=A0 * Reads @size bytes from @ioc. Returns 0 on success.
>> diff --git a/nbd/server.c b/nbd/server.c
>> index 2d762d7289..569e068fc2 100644
>> --- a/nbd/server.c
>> +++ b/nbd/server.c
>> @@ -23,6 +23,12 @@
>> =C2=A0 #include "nbd-internal.h"
>> =C2=A0 =C2=A0 #define NBD_META_ID_BASE_ALLOCATION 0
>> +#define NBD_META_ID_DIRTY_BITMAP 1
>> +
>> +/* NBD_MAX_BITMAP_EXTENTS: 1 mb of extents data. An empirical=20
>> constant. If need
>> + * to increase, note that NBD protocol defines 32 mb as a limit,=20
>> after which the
>
> s/need to increase/an increase is needed/
>
>> + * reply may be considered as a denial of service attack. */
>> +#define NBD_MAX_BITMAP_EXTENTS (0x100000 / 8)
>> =C2=A0 =C2=A0 static int system_errno_to_nbd_errno(int err)
>> =C2=A0 {
>> @@ -80,6 +86,9 @@ struct NBDExport {
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BlockBackend *eject_notifier_blk;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Notifier eject_notifier;
>> +
>> +=C2=A0=C2=A0=C2=A0 BdrvDirtyBitmap *export_bitmap;
>> +=C2=A0=C2=A0=C2=A0 char *export_bitmap_context;
>> =C2=A0 };
>> =C2=A0 =C2=A0 static QTAILQ_HEAD(, NBDExport) exports =3D=20
>> QTAILQ_HEAD_INITIALIZER(exports);
>> @@ -92,6 +101,7 @@ typedef struct NBDExportMetaContexts {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool valid; /* means that negotiation of =
the option finished=20
>> without
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 errors */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool base_allocation; /* export base:allo=
cation context (block=20
>> status) */
>> +=C2=A0=C2=A0=C2=A0 bool dirty_bitmap; /* export qemu:dirty-bitmap:<expo=
rt bitmap=20
>> name> */
>> =C2=A0 } NBDExportMetaContexts;
>> =C2=A0 =C2=A0 struct NBDClient {
>> @@ -810,6 +820,55 @@ static int nbd_meta_base_query(NBDClient=20
>> *client, NBDExportMetaContexts *meta,
>> &meta->base_allocation, errp);
>> =C2=A0 }
>> =C2=A0 +/* nbd_meta_bitmap_query
>> + *
>> + * Handle query to 'qemu:' namespace.
>> + * @len is the amount of text remaining to be read from the current=20
>> name, after
>> + * the 'qemu:' portion has been stripped.
>> + *
>> + * Return -errno on I/O error, 0 if option was completely handled by
>> + * sending a reply about inconsistent lengths, or 1 on success. */
>> +static int nbd_meta_qemu_query(NBDClient *client,=20
>> NBDExportMetaContexts *meta,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint32_t len, Error **errp)
>> +{
>> +=C2=A0=C2=A0=C2=A0 bool dirty_bitmap =3D false;
>> +=C2=A0=C2=A0=C2=A0 int dirty_bitmap_len =3D strlen("dirty-bitmap:");
>
> size_t is better for strlen() values.
>
>> +=C2=A0=C2=A0=C2=A0 int ret;
>> +
>> +=C2=A0=C2=A0=C2=A0 if (!meta->exp->export_bitmap) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return nbd_opt_skip(client, =
len, errp);
>> +=C2=A0=C2=A0=C2=A0 }
>
> Worth a trace?...
>
>> +
>> +=C2=A0=C2=A0=C2=A0 if (len =3D=3D 0) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (client->opt =3D=3D NBD_O=
PT_LIST_META_CONTEXT) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 meta=
->dirty_bitmap =3D true;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 trace_nbd_negotiate_meta_que=
ry_parse("empty");
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 1;
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 if (len < dirty_bitmap_len) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 trace_nbd_negotiate_meta_que=
ry_skip("not dirty-bitmap:");
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return nbd_opt_skip(client, =
len, errp);
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>
> ...especially since other returns have traced the result.
>
> I'm strongly thinking of adding a patch to QMP to add an x-context=20
> parameter when creating an NBD client, in order to at least make=20
> testing client/server interactions easier than just code inspection.=C2=
=A0=20
> Does not have to be part of this series.
>
>> +=C2=A0=C2=A0=C2=A0 len -=3D dirty_bitmap_len;
>> +=C2=A0=C2=A0=C2=A0 ret =3D nbd_meta_pattern(client, "dirty-bitmap:", &d=
irty_bitmap,=20
>> errp);
>> +=C2=A0=C2=A0=C2=A0 if (ret <=3D 0) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>> +=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0 if (!dirty_bitmap) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 trace_nbd_negotiate_meta_que=
ry_skip("not dirty-bitmap:");
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return nbd_opt_skip(client, =
len, errp);
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 trace_nbd_negotiate_meta_query_parse("dirty-bitmap:"=
);
>> +
>> +=C2=A0=C2=A0=C2=A0 return nbd_meta_empty_or_pattern(
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clie=
nt, meta->exp->export_bitmap_context +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 strl=
en("qemu:dirty_bitmap:"), len, &meta->dirty_bitmap,=20
>> errp);
>> +}
>> +
>> =C2=A0 /* nbd_negotiate_meta_query
>> =C2=A0=C2=A0 *
>> =C2=A0=C2=A0 * Parse namespace name and call corresponding function to p=
arse=20
>> body of the
>> @@ -826,8 +885,10 @@ static int nbd_negotiate_meta_query(NBDClient=20
>> *client,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 NBDExportMetaContexts *meta,=20
>> Error **errp)
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int ret;
>> -=C2=A0=C2=A0=C2=A0 char query[sizeof("base:") - 1];
>> -=C2=A0=C2=A0=C2=A0 size_t baselen =3D strlen("base:");
>> +=C2=A0=C2=A0=C2=A0 size_t ns_len =3D 5;
>> +=C2=A0=C2=A0=C2=A0 char ns[5]; /* Both 'qemu' and 'base' namespaces hav=
e length =3D 5=20
>> including a
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 colon. If it's needed to introduce =
a namespace of=20
>> the other
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 length, this should be certainly re=
factored. */
>
> s/be certainly/certainly be/
>
> ...
>
>> @@ -1793,6 +1871,9 @@ static int=20
>> blockstatus_to_extent_be(BlockDriverState *bs, uint64_t offset,
>> =C2=A0 }
>> =C2=A0 =C2=A0 /* nbd_co_send_extents
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
>> @@ -1805,7 +1886,7 @@ static int nbd_co_send_extents(NBDClient=20
>> *client, uint64_t handle,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {.iov_base =3D ex=
tents, .iov_len =3D nb_extents *=20
>> sizeof(extents[0])}
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
>> =C2=A0 -=C2=A0=C2=A0=C2=A0 set_be_chunk(&chunk.h, NBD_REPLY_FLAG_DONE,=20
>> NBD_REPLY_TYPE_BLOCK_STATUS,
>> +=C2=A0=C2=A0=C2=A0 set_be_chunk(&chunk.h, 0, NBD_REPLY_TYPE_BLOCK_STATU=
S,
>
> Worth a bool parameter to send the flag automatically on the last=20
> context?
>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 handle, sizeof(chunk) - sizeof(chunk.h=
) +=20
>> iov[1].iov_len);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 stl_be_p(&chunk.context_id, context_id);
>> =C2=A0 @@ -1830,6 +1911,97 @@ static int=20
>> nbd_co_send_block_status(NBDClient *client, uint64_t handle,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return nbd_co_send_extents(client, handle=
, &extent, 1,=20
>> context_id, errp);
>> =C2=A0 }
>> =C2=A0 +/* Set several extents, describing region of given @length with=
=20
>> given @flags.
>> + * Do not set more than @nb_extents, return number of set extents.
>> + */
>> +static unsigned add_extents(NBDExtent *extents, unsigned nb_extents,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 uint64_t length, uint32_t flags)
>> +{
>> +=C2=A0=C2=A0=C2=A0 unsigned i =3D 0;
>> +=C2=A0=C2=A0=C2=A0 uint32_t max_extent =3D QEMU_ALIGN_DOWN(INT32_MAX, B=
DRV_SECTOR_SIZE);
>
> This is too small of a granularity wrong when the server advertised 4k=20
> alignment during NBD_OPT_GO; it should probably refer to=20
> bs->bl.request_alignment.
>
>> +=C2=A0=C2=A0=C2=A0 uint32_t max_extent_be =3D cpu_to_be32(max_extent);
>> +=C2=A0=C2=A0=C2=A0 uint32_t flags_be =3D cpu_to_be32(flags);
>> +
>> +=C2=A0=C2=A0=C2=A0 for (i =3D 0; i < nb_extents && length > max_extent;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 i++, length -=3D max_e=
xtent)
>> +=C2=A0=C2=A0=C2=A0 {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extents[i].length =3D max_ex=
tent_be;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extents[i].flags =3D flags_b=
e;
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 if (length > 0 && i < nb_extents) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extents[i].length =3D cpu_to=
_be32(length);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 extents[i].flags =3D flags_b=
e;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 i++;
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 return i;
>> +}
>> +
>> +static unsigned bitmap_to_extents(BdrvDirtyBitmap *bitmap, uint64_t=20
>> offset,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint64_t length, NBD=
Extent *extents,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned nb_extents,=
 bool=20
>> dont_fragment)
>> +{
>> +=C2=A0=C2=A0=C2=A0 uint64_t begin =3D offset, end;
>> +=C2=A0=C2=A0=C2=A0 uint64_t overall_end =3D offset + length;
>> +=C2=A0=C2=A0=C2=A0 unsigned i =3D 0;
>> +=C2=A0=C2=A0=C2=A0 BdrvDirtyBitmapIter *it;
>> +=C2=A0=C2=A0=C2=A0 bool dirty;
>> +
>> +=C2=A0=C2=A0=C2=A0 bdrv_dirty_bitmap_lock(bitmap);
>> +
>> +=C2=A0=C2=A0=C2=A0 it =3D bdrv_dirty_iter_new(bitmap);
>> +=C2=A0=C2=A0=C2=A0 dirty =3D bdrv_get_dirty_locked(NULL, bitmap, offset=
);
>> +
>> +=C2=A0=C2=A0=C2=A0 while (begin < overall_end && i < nb_extents) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (dirty) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 end =
=3D bdrv_dirty_bitmap_next_zero(bitmap, begin);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bdrv=
_set_dirty_iter(it, begin);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 end =
=3D bdrv_dirty_iter_next(it);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (end =3D=3D -1) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 end =
=3D bdrv_dirty_bitmap_size(bitmap);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (dont_fragment && end > o=
verall_end) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* W=
e MUST not exceed requested region if=20
>> NBD_CMD_FLAG_REQ_ONE flag
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 * is set */
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 end =
=3D overall_end;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 i +=3D add_extents(extents +=
 i, nb_extents - i, end - begin,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 dirty ? NBD_STATE_DIRTY : 0);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 begin =3D end;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dirty =3D !dirty;
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 bdrv_dirty_iter_free(it);
>> +
>> +=C2=A0=C2=A0=C2=A0 bdrv_dirty_bitmap_unlock(bitmap);
>> +
>> +=C2=A0=C2=A0=C2=A0 return i;
>> +}
>> +
>> +static int nbd_co_send_bitmap(NBDClient *client, uint64_t handle,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BdrvDirtyBitmap *bitmap, uint64_t offset,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint64_t length, bool dont_fragment,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint32_t context_id, Error **errp)
>> +{
>> +=C2=A0=C2=A0=C2=A0 int ret;
>> +=C2=A0=C2=A0=C2=A0 unsigned nb_extents =3D dont_fragment ? 1 : NBD_MAX_=
BITMAP_EXTENTS;
>> +=C2=A0=C2=A0=C2=A0 NBDExtent *extents =3D g_new(NBDExtent, nb_extents);
>> +
>> +=C2=A0=C2=A0=C2=A0 nb_extents =3D bitmap_to_extents(bitmap, offset, len=
gth, extents,=20
>> nb_extents,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dont_fragment)=
;
>> +
>> +=C2=A0=C2=A0=C2=A0 ret =3D nbd_co_send_extents(client, handle, extents,=
 nb_extents,=20
>> context_id,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 errp);
>
> Worth a trace when extents are sent?
>
>> +
>> +=C2=A0=C2=A0=C2=A0 g_free(extents);
>> +
>> +=C2=A0=C2=A0=C2=A0 return ret;
>> +}
>> +
>> =C2=A0 /* nbd_co_receive_request
>> =C2=A0=C2=A0 * Collect a client request. Return 0 if request looks valid=
, -EIO=20
>> to drop
>> =C2=A0=C2=A0 * connection right away, and any other negative value to re=
port an=20
>> error to
>> @@ -2043,11 +2215,33 @@ static coroutine_fn int=20
>> nbd_handle_request(NBDClient *client,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 "discard failed", errp);
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case NBD_CMD_BLOCK_STATUS:
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (client->export_meta.vali=
d &&=20
>> client->export_meta.base_allocation) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 retu=
rn nbd_co_send_block_status(client, request->handle,
>> - blk_bs(exp->blk), request->from,
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 request->len,
>> - NBD_META_ID_BASE_ALLOCATION, errp);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (client->export_meta.vali=
d &&
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (cli=
ent->export_meta.base_allocation ||
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 client->export_meta.dirty_bitmap))
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (=
client->export_meta.base_allocation) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 ret =3D nbd_co_send_block_status(client, request->han=
dle,
>> + blk_bs(exp->blk), request->from,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 request->len,
>> + NBD_META_ID_BASE_ALLOCATION,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 errp);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 if (ret < 0) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (=
client->export_meta.dirty_bitmap) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 ret =3D nbd_co_send_bitmap(client, request->handle,
>> + client->exp->export_bitmap,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 request->from, request->len,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 request->flags &=20
>> NBD_CMD_FLAG_REQ_ONE,
>> + NBD_META_ID_DIRTY_BITMAP, errp);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 if (ret < 0) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 retu=
rn nbd_co_send_structured_done(client,=20
>> request->handle, errp);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 return nbd_send_generic_reply(client, request->handle,=20
>> -EINVAL,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "CMD_BLOCK_STATUS not=20
>> negotiated",
>> @@ -2199,3 +2393,44 @@ void nbd_client_new(NBDExport *exp,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 co =3D qemu_coroutine_create(nbd_co_clien=
t_start, client);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_coroutine_enter(co);
>> =C2=A0 }
>> +
>> +void nbd_export_bitmap(NBDExport *exp, const char *bitmap,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const char =
*bitmap_export_name, Error **errp)
>> +{
>> +=C2=A0=C2=A0=C2=A0 BdrvDirtyBitmap *bm =3D NULL;
>> +=C2=A0=C2=A0=C2=A0 BlockDriverState *bs =3D blk_bs(exp->blk);
>> +
>> +=C2=A0=C2=A0=C2=A0 if (exp->export_bitmap) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_setg(errp, "Export bit=
map is already set");
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 while (true) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bm =3D bdrv_find_dirty_bitma=
p(bs, bitmap);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (bm !=3D NULL || bs->back=
ing =3D=3D NULL) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 brea=
k;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bs =3D bs->backing->bs;
>> +=C2=A0=C2=A0=C2=A0 }
>
> Is searching for the dirty bitmap in the backing chain always the=20
> wisest thing to do?=C2=A0 I guess it works, but it seems a bit odd on fir=
st=20
> glance.

I'm not sure about "always", but external backup with fleecing related=20
filter node (nodes) don't work without this search.. May be, we should=20
specify node name in the command, and check here that specified node is=20
in backing chain.

>
>> +
>> +=C2=A0=C2=A0=C2=A0 if (bm =3D=3D NULL) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_setg(errp, "Bitmap '%s=
' is not found", bitmap);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 if (bdrv_dirty_bitmap_enabled(bm)) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_setg(errp, "Bitmap '%s=
' is enabled", bitmap);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 if (bdrv_dirty_bitmap_qmp_locked(bm)) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_setg(errp, "Bitmap '%s=
' is locked", bitmap);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 bdrv_dirty_bitmap_set_qmp_locked(bm, true);
>> +=C2=A0=C2=A0=C2=A0 exp->export_bitmap =3D bm;
>> +=C2=A0=C2=A0=C2=A0 exp->export_bitmap_context =3D
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_st=
rdup_printf("qemu:dirty-bitmap:%s",=20
>> bitmap_export_name);
>> +}
>>
>


--=20
Best regards,
Vladimir
