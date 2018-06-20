Received: from eggs.gnu.org ([2001:4830:134:3::10]:37046)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fVgWo-0000IP-Ui
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 13:04:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fVgWk-0007ih-QR
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 13:04:18 -0400
References: <20180609151758.17343-1-vsementsov@virtuozzo.com>
	<20180609151758.17343-5-vsementsov@virtuozzo.com>
	<899fcefc-84f1-7238-c77b-9c925c9872c5@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <37e9fc1c-9c65-2121-12c9-4b648fea3947@virtuozzo.com>
Date: Wed, 20 Jun 2018 20:04:04 +0300
MIME-Version: 1.0
In-Reply-To: <899fcefc-84f1-7238-c77b-9c925c9872c5@redhat.com>
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

20.06.2018 19:27, Eric Blake wrote:
> On 06/09/2018 10:17 AM, Vladimir Sementsov-Ogievskiy wrote:
>> Handle new NBD meta namespace: "qemu", and corresponding queries:
>> "qemu:dirty-bitmap:<export bitmap name>".
>>
>> With new metadata context negotiated, BLOCK_STATUS query will reply
>> with dirty-bitmap data, converted to extents. New public function
>> nbd_export_bitmap selects bitmap to export. For now, only one bitmap
>> may be exported.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>> =C2=A0 include/block/nbd.h |=C2=A0=C2=A0 6 ++
>> =C2=A0 nbd/server.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 271=20
>> ++++++++++++++++++++++++++++++++++++++++++++++++----
>> =C2=A0 2 files changed, 259 insertions(+), 18 deletions(-)
>
> I'm squashing this in, and adding:
> Reviewed-by: Eric Blake <eblake@redhat.com>
>
> (Grammar fixes, prefer 'unsigned int' over 'unsigned', add 'last' flag=20
> for avoiding separate chunk in reply, shorter variable name to fit 80=20
> columns, tweak 'length' tracking in order to add a trace before=20
> sending a status reply)
>
> diff --git i/include/block/nbd.h w/include/block/nbd.h
> index a653d0fba79..8bb9606c39b 100644
> --- i/include/block/nbd.h
> +++ w/include/block/nbd.h
> @@ -229,13 +229,11 @@ enum {
> =C2=A0#define NBD_REPLY_TYPE_ERROR=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 NBD_REPLY_ERR(1)
> =C2=A0#define NBD_REPLY_TYPE_ERROR_OFFSET=C2=A0 NBD_REPLY_ERR(2)
>
> -/* Flags for extents (NBDExtent.flags) of NBD_REPLY_TYPE_BLOCK_STATUS,
> - * for base:allocation meta context */
> +/* Extent flags for base:allocation in NBD_REPLY_TYPE_BLOCK_STATUS */
> =C2=A0#define NBD_STATE_HOLE (1 << 0)
> =C2=A0#define NBD_STATE_ZERO (1 << 1)
>
> -/* Flags for extents (NBDExtent.flags) of NBD_REPLY_TYPE_BLOCK_STATUS,
> - * for qemu:dirty-bitmap:* meta contexts */
> +/* Extent flags for qemu:dirty-bitmap in NBD_REPLY_TYPE_BLOCK_STATUS */
> =C2=A0#define NBD_STATE_DIRTY (1 << 0)
>
> =C2=A0static inline bool nbd_reply_type_is_error(int type)
> diff --git i/nbd/server.c w/nbd/server.c
> index 6f662bd4c7f..e84aea6cf03 100644
> --- i/nbd/server.c
> +++ w/nbd/server.c
> @@ -25,9 +25,10 @@
> =C2=A0#define NBD_META_ID_BASE_ALLOCATION 0
> =C2=A0#define NBD_META_ID_DIRTY_BITMAP 1
>
> -/* NBD_MAX_BITMAP_EXTENTS: 1 mb of extents data. An empirical=20
> constant. If need
> - * to increase, note that NBD protocol defines 32 mb as a limit,=20
> after which the
> - * reply may be considered as a denial of service attack. */
> +/* NBD_MAX_BITMAP_EXTENTS: 1 mb of extents data. An empirical
> + * constant. If an increase is needed, note that the NBD protocol
> + * recommends no larger than 32 mb, so that the client won't consider
> + * the reply as a denial of service attack. */
> =C2=A0#define NBD_MAX_BITMAP_EXTENTS (0x100000 / 8)
>
> =C2=A0static int system_errno_to_nbd_errno(int err)
> @@ -101,7 +102,7 @@ typedef struct NBDExportMetaContexts {
> =C2=A0=C2=A0=C2=A0=C2=A0 bool valid; /* means that negotiation of the opt=
ion finished without
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 errors */
> =C2=A0=C2=A0=C2=A0=C2=A0 bool base_allocation; /* export base:allocation =
context (block=20
> status) */
> -=C2=A0=C2=A0=C2=A0 bool dirty_bitmap; /* export qemu:dirty-bitmap:<expor=
t bitmap=20
> name> */
> +=C2=A0=C2=A0=C2=A0 bool bitmap; /* export qemu:dirty-bitmap:<export bitm=
ap name> */
> =C2=A0} NBDExportMetaContexts;
>
> =C2=A0struct NBDClient {
> @@ -836,16 +837,17 @@ static int nbd_meta_qemu_query(NBDClient=20
> *client, NBDExportMetaContexts *meta,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint32_t len, Error **errp)
> =C2=A0{
> =C2=A0=C2=A0=C2=A0=C2=A0 bool dirty_bitmap =3D false;
> -=C2=A0=C2=A0=C2=A0 int dirty_bitmap_len =3D strlen("dirty-bitmap:");
> +=C2=A0=C2=A0=C2=A0 size_t dirty_bitmap_len =3D strlen("dirty-bitmap:");
> =C2=A0=C2=A0=C2=A0=C2=A0 int ret;
>
> =C2=A0=C2=A0=C2=A0=C2=A0 if (!meta->exp->export_bitmap) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 trace_nbd_negotiate_meta_quer=
y_skip("no dirty-bitmap exported");
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return nbd_opt_skip(clie=
nt, len, errp);
> =C2=A0=C2=A0=C2=A0=C2=A0 }
>
> =C2=A0=C2=A0=C2=A0=C2=A0 if (len =3D=3D 0) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (client->opt =3D=3D N=
BD_OPT_LIST_META_CONTEXT) {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 meta-=
>dirty_bitmap =3D true;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 meta-=
>bitmap =3D true;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 trace_nbd_negotiate_meta=
_query_parse("empty");
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 1;
> @@ -870,7 +872,7 @@ static int nbd_meta_qemu_query(NBDClient *client,=20
> NBDExportMetaContexts *meta,
>
> =C2=A0=C2=A0=C2=A0=C2=A0 return nbd_meta_empty_or_pattern(
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
client, meta->exp->export_bitmap_context +
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 strle=
n("qemu:dirty_bitmap:"), len, &meta->dirty_bitmap,=20
> errp);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 strle=
n("qemu:dirty_bitmap:"), len, &meta->bitmap, errp);
> =C2=A0}
>
> =C2=A0/* nbd_negotiate_meta_query
> @@ -888,11 +890,14 @@ static int nbd_meta_qemu_query(NBDClient=20
> *client, NBDExportMetaContexts *meta,
> =C2=A0static int nbd_negotiate_meta_query(NBDClient *client,
> NBDExportMetaContexts *meta, Error **errp)
> =C2=A0{
> +=C2=A0=C2=A0=C2=A0 /*
> +=C2=A0=C2=A0=C2=A0=C2=A0 * Both 'qemu' and 'base' namespaces have length=
 =3D 5 including a
> +=C2=A0=C2=A0=C2=A0=C2=A0 * colon. If another length namespace is later i=
ntroduced, this
> +=C2=A0=C2=A0=C2=A0=C2=A0 * should certainly be refactored.
> +=C2=A0=C2=A0=C2=A0=C2=A0 */
> =C2=A0=C2=A0=C2=A0=C2=A0 int ret;
> =C2=A0=C2=A0=C2=A0=C2=A0 size_t ns_len =3D 5;
> -=C2=A0=C2=A0=C2=A0 char ns[5]; /* Both 'qemu' and 'base' namespaces have=
 length =3D 5=20
> including a
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 colon. If it's needed to introduce a n=
amespace of=20
> the other
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 length, this should be certainly refac=
tored. */
> +=C2=A0=C2=A0=C2=A0 char ns[5];
> =C2=A0=C2=A0=C2=A0=C2=A0 uint32_t len;
>
> =C2=A0=C2=A0=C2=A0=C2=A0 ret =3D nbd_opt_read(client, &len, sizeof(len), =
errp);
> @@ -991,7 +996,7 @@ static int nbd_negotiate_meta_queries(NBDClient=20
> *client,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0=C2=A0=C2=A0=C2=A0 }
>
> -=C2=A0=C2=A0=C2=A0 if (meta->dirty_bitmap) {
> +=C2=A0=C2=A0=C2=A0 if (meta->bitmap) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D nbd_negotiate_se=
nd_meta_context(client,
>
> meta->exp->export_bitmap_context,
> NBD_META_ID_DIRTY_BITMAP,
> @@ -1876,11 +1881,13 @@ static int=20
> blockstatus_to_extent_be(BlockDriverState *bs, uint64_t offset,
>
> =C2=A0/* nbd_co_send_extents
> =C2=A0 *
> - * NBD_REPLY_FLAG_DONE is not set, don't forget to send it.
> + * @last controls whether NBD_REPLY_FLAG_DONE is sent.
> =C2=A0 *
> - * @extents should be in big-endian */
> + * @extents should already be in big-endian format.
> + */
> =C2=A0static int nbd_co_send_extents(NBDClient *client, uint64_t handle,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 NBDExtent *extents, unsigned nb_extents,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 NBDExtent *extents, unsigned int=20
> nb_extents,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint64_t length, bool last,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint32_t context_id, Error **errp)
> =C2=A0{
> =C2=A0=C2=A0=C2=A0=C2=A0 NBDStructuredMeta chunk;
> @@ -1890,7 +1897,9 @@ static int nbd_co_send_extents(NBDClient=20
> *client, uint64_t handle,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {.iov_base =3D extents, =
.iov_len =3D nb_extents *=20
> sizeof(extents[0])}
> =C2=A0=C2=A0=C2=A0=C2=A0 };
>
> -=C2=A0=C2=A0=C2=A0 set_be_chunk(&chunk.h, 0, NBD_REPLY_TYPE_BLOCK_STATUS=
,
> +=C2=A0=C2=A0=C2=A0 trace_nbd_co_send_extents(handle, nb_extents, context=
_id, length,=20
> last);

hm, length variable added only to be traced.. Ok, but a bit strange.

> + set_be_chunk(&chunk.h, last ? NBD_REPLY_FLAG_DONE : 0,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 NBD_REPLY_TYPE_BLOCK_STATUS,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 handle, sizeof(chunk) - sizeof(chunk.h) +=20
> iov[1].iov_len);
> =C2=A0=C2=A0=C2=A0=C2=A0 stl_be_p(&chunk.context_id, context_id);
>
> @@ -1900,8 +1909,8 @@ static int nbd_co_send_extents(NBDClient=20
> *client, uint64_t handle,
> =C2=A0/* Get block status from the exported device and send it to the=20
> client */
> =C2=A0static int nbd_co_send_block_status(NBDClient *client, uint64_t han=
dle,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Block=
DriverState *bs, uint64_t=20
> offset,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint64_t le=
ngth, uint32_t=20
> context_id,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Error **err=
p)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint64_t le=
ngth, bool last,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint32_t co=
ntext_id, Error **errp)
> =C2=A0{
> =C2=A0=C2=A0=C2=A0=C2=A0 int ret;
> =C2=A0=C2=A0=C2=A0=C2=A0 NBDExtent extent;
> @@ -1912,17 +1921,18 @@ static int nbd_co_send_block_status(NBDClient=20
> *client, uint64_t handle,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 client, handle, -ret, "can't get block status", er=
rp);
> =C2=A0=C2=A0=C2=A0=C2=A0 }
>
> -=C2=A0=C2=A0=C2=A0 return nbd_co_send_extents(client, handle, &extent, 1=
,=20
> context_id, errp);
> +=C2=A0=C2=A0=C2=A0 return nbd_co_send_extents(client, handle, &extent, 1=
, length, last,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 context_id, errp);
> =C2=A0}
>
> =C2=A0/* Set several extents, describing region of given @length with giv=
en=20
> @flags.
> =C2=A0 * Do not set more than @nb_extents, return number of set extents.
> =C2=A0 */
> -static unsigned add_extents(NBDExtent *extents, unsigned nb_extents,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 uint64_t length, uint32_t flags)
> +static unsigned int add_extents(NBDExtent *extents, unsigned nb_extents,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint64_t length, uint32_t flags)
> =C2=A0{
> -=C2=A0=C2=A0=C2=A0 unsigned i =3D 0;
> -=C2=A0=C2=A0=C2=A0 uint32_t max_extent =3D QEMU_ALIGN_DOWN(INT32_MAX, BD=
RV_SECTOR_SIZE);
> +=C2=A0=C2=A0=C2=A0 unsigned int i =3D 0;
> +=C2=A0=C2=A0=C2=A0 uint32_t max_extent =3D 0x80000000U;

So, you just take the biggest possible granularity, perfect.

> uint32_t max_extent_be =3D cpu_to_be32(max_extent);
> =C2=A0=C2=A0=C2=A0=C2=A0 uint32_t flags_be =3D cpu_to_be32(flags);
>
> @@ -1942,13 +1952,14 @@ static unsigned add_extents(NBDExtent=20
> *extents, unsigned nb_extents,
> =C2=A0=C2=A0=C2=A0=C2=A0 return i;
> =C2=A0}
>
> -static unsigned bitmap_to_extents(BdrvDirtyBitmap *bitmap, uint64_t=20
> offset,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint64_t length, NBDExt=
ent *extents,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned nb_extents, bo=
ol=20
> dont_fragment)
> +static unsigned int bitmap_to_extents(BdrvDirtyBitmap *bitmap,=20
> uint64_t offset,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 uint64_t *length, NBDExtent=20
> *extents,

length - in-out? worth comment?

> + unsigned int nb_extents,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 bool dont_fragment)
> =C2=A0{
> =C2=A0=C2=A0=C2=A0=C2=A0 uint64_t begin =3D offset, end;
> -=C2=A0=C2=A0=C2=A0 uint64_t overall_end =3D offset + length;
> -=C2=A0=C2=A0=C2=A0 unsigned i =3D 0;
> +=C2=A0=C2=A0=C2=A0 uint64_t overall_end =3D offset + *length;
> +=C2=A0=C2=A0=C2=A0 unsigned int i =3D 0;
> =C2=A0=C2=A0=C2=A0=C2=A0 BdrvDirtyBitmapIter *it;
> =C2=A0=C2=A0=C2=A0=C2=A0 bool dirty;
>
> @@ -1983,23 +1994,25 @@ static unsigned=20
> bitmap_to_extents(BdrvDirtyBitmap *bitmap, uint64_t offset,
>
> =C2=A0=C2=A0=C2=A0=C2=A0 bdrv_dirty_bitmap_unlock(bitmap);
>
> +=C2=A0=C2=A0=C2=A0 *length =3D end - begin;

hm, it will always be zero, as at the end of the previous loop we have=20
"begin =3D end;"

> return i;
> =C2=A0}
>
> =C2=A0static int nbd_co_send_bitmap(NBDClient *client, uint64_t handle,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BdrvDirtyBitmap *bitmap, uint64_t offset,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint64_t length, bool dont_fragment,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint32_t length, bool dont_fragment,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint32_t context_id, Error **errp)
> =C2=A0{
> =C2=A0=C2=A0=C2=A0=C2=A0 int ret;
> -=C2=A0=C2=A0=C2=A0 unsigned nb_extents =3D dont_fragment ? 1 : NBD_MAX_B=
ITMAP_EXTENTS;
> +=C2=A0=C2=A0=C2=A0 unsigned int nb_extents =3D dont_fragment ? 1 :=20
> NBD_MAX_BITMAP_EXTENTS;
> =C2=A0=C2=A0=C2=A0=C2=A0 NBDExtent *extents =3D g_new(NBDExtent, nb_exten=
ts);
> +=C2=A0=C2=A0=C2=A0 uint64_t final_length =3D length;
>
> -=C2=A0=C2=A0=C2=A0 nb_extents =3D bitmap_to_extents(bitmap, offset, leng=
th, extents,=20
> nb_extents,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dont_fragment);
> +=C2=A0=C2=A0=C2=A0 nb_extents =3D bitmap_to_extents(bitmap, offset, &fin=
al_length,=20
> extents,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nb_extents, dont_=
fragment);
>
> -=C2=A0=C2=A0=C2=A0 ret =3D nbd_co_send_extents(client, handle, extents, =
nb_extents,=20
> context_id,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 errp);
> +=C2=A0=C2=A0=C2=A0 ret =3D nbd_co_send_extents(client, handle, extents, =
nb_extents,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 final_length, true, context_id, errp);

hmm in-out pointer field only to trace final_length? may be just trace=20
it in bitmap_to_extents?

also, it's not trivial, that the function now sends FLAG_DONE. I think,=20
worth add a comment, or
a parameter like for nbd_co_send_block_status. It will simplify=20
introducing new contexts in future.

>
> =C2=A0=C2=A0=C2=A0=C2=A0 g_free(extents);
>
> @@ -2221,12 +2234,13 @@ static coroutine_fn int=20
> nbd_handle_request(NBDClient *client,
> =C2=A0=C2=A0=C2=A0=C2=A0 case NBD_CMD_BLOCK_STATUS:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (client->export_meta.=
valid &&
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
(client->export_meta.base_allocation ||
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 client->export_meta.dirty_bitmap))
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 client->export_meta.bitmap))
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
if (client->export_meta.base_allocation) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D nbd_co_send_block_status(client, request->=
handle,
> blk_bs(exp->blk), request->from,
> request->len,
> + !client->export_meta.bitmap,
>
> NBD_META_ID_BASE_ALLOCATION,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 errp);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 if (ret < 0) {
> @@ -2234,7 +2248,7 @@ static coroutine_fn int=20
> nbd_handle_request(NBDClient *client,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
}
>
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (c=
lient->export_meta.dirty_bitmap) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (c=
lient->export_meta.bitmap) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D nbd_co_send_bitmap(client, request->handle=
,
> client->exp->export_bitmap,
> request->from, request->len,
> diff --git i/nbd/trace-events w/nbd/trace-events
> index dee081e7758..5e1d4afe8e6 100644
> --- i/nbd/trace-events
> +++ w/nbd/trace-events
> @@ -64,6 +64,7 @@ nbd_co_send_simple_reply(uint64_t handle, uint32_t=20
> error, const char *errname, i
> =C2=A0nbd_co_send_structured_done(uint64_t handle) "Send structured reply=
=20
> done: handle =3D %" PRIu64
> =C2=A0nbd_co_send_structured_read(uint64_t handle, uint64_t offset, void=
=20
> *data, size_t size) "Send structured read data reply: handle =3D %"=20
> PRIu64 ", offset =3D %" PRIu64 ", data =3D %p, len =3D %zu"
> =C2=A0nbd_co_send_structured_read_hole(uint64_t handle, uint64_t offset,=
=20
> size_t size) "Send structured read hole reply: handle =3D %" PRIu64 ",=20
> offset =3D %" PRIu64 ", len =3D %zu"
> +nbd_co_send_extents(uint64_t handle, unsigned int extents, uint32_t=20
> id, uint64_t length, int last) "Send block status reply: handle =3D %"=20
> PRIu64 ", extents =3D %u, context =3D %d (extents cover %" PRIu64 " bytes=
,=20
> last chunk =3D %d)"
> =C2=A0nbd_co_send_structured_error(uint64_t handle, int err, const char=20
> *errname, const char *msg) "Send structured error reply: handle =3D %"=20
> PRIu64 ", error =3D %d (%s), msg =3D '%s'"
> =C2=A0nbd_co_receive_request_decode_type(uint64_t handle, uint16_t type,=
=20
> const char *name) "Decoding type: handle =3D %" PRIu64 ", type =3D %"=20
> PRIu16 " (%s)"
> =C2=A0nbd_co_receive_request_payload_received(uint64_t handle, uint32_t=20
> len) "Payload received: handle =3D %" PRIu64 ", len =3D %" PRIu32
>
>


--=20
Best regards,
Vladimir
