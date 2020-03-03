Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DBBAC3F2D1
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 21:50:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2444720728
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 21:50:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NPrxcTvW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2444720728
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54058 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9FQN-0001rf-2n
	for qemu-devel@archiver.kernel.org; Tue, 03 Mar 2020 16:49:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36417)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsnow@redhat.com>) id 1j9FPL-0001KC-Qe
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 16:48:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1j9FPI-0001fc-W5
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 16:48:54 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:45328
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1j9FPI-0001eX-Qq
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 16:48:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583272131;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=/T5XdfiE2KrIUzEPWhkkHuqfn/x3tAiDuH0dGRLznac=;
 b=NPrxcTvWHTrxc1MKeJwpD55zVQM4tazj+CSiJl70rFVqTbvpP1Ng6CX6Ww8DPUgaIC5j4o
 X9exK/ufZIn+dRmcspLa0f7FcfDubLe/7y/uXhSLKVYcsmeJGC8SFux+rJe1ry4/OPPvaL
 XCeSq0b7p/tU4sYJqkymiBO/B9gzpfE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-428-aP4_x3-yM2qKGYoaxKh4Lw-1; Tue, 03 Mar 2020 16:48:50 -0500
X-MC-Unique: aP4_x3-yM2qKGYoaxKh4Lw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E0F841084458;
 Tue,  3 Mar 2020 21:48:48 +0000 (UTC)
Received: from [10.10.120.212] (ovpn-120-212.rdu2.redhat.com [10.10.120.212])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 69B1C8477C;
 Tue,  3 Mar 2020 21:48:37 +0000 (UTC)
Subject: Re: [PATCH 2/6] qmp: expose block-dirty-bitmap-populate
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
References: <20200225005641.5478-1-jsnow@redhat.com>
 <20200225005641.5478-3-jsnow@redhat.com>
 <f64989f8-555d-6e52-87f0-f387bb21d3eb@virtuozzo.com>
From: John Snow <jsnow@redhat.com>
Autocrypt: addr=jsnow@redhat.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <b7d44832-363d-cf89-fe55-efef68e11f00@redhat.com>
Date: Tue, 3 Mar 2020 16:48:36 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <f64989f8-555d-6e52-87f0-f387bb21d3eb@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>, pkrempa@redhat.com,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 2/27/20 5:44 AM, Vladimir Sementsov-Ogievskiy wrote:
> 25.02.2020 3:56, John Snow wrote:
>> This is a new job-creating command.
>>
>> Signed-off-by: John Snow <jsnow@redhat.com>
>> ---
>> =C2=A0 qapi/block-core.json=C2=A0 | 18 ++++++++++
>> =C2=A0 qapi/transaction.json |=C2=A0 2 ++
>> =C2=A0 blockdev.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 78 +++++++++++++++++++++++++++++++++++++++++++
>> =C2=A0 3 files changed, 98 insertions(+)
>>
>> diff --git a/qapi/block-core.json b/qapi/block-core.json
>> index df1797681a..a8be1fb36b 100644
>> --- a/qapi/block-core.json
>> +++ b/qapi/block-core.json
>> @@ -2293,6 +2293,24 @@
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 '*auto-finalize': 'bool',
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 '*auto-dismiss': 'bool' } }
>> =C2=A0 +##
>> +# @block-dirty-bitmap-populate:
>> +#
>> +# Creates a new job that writes a pattern into a dirty bitmap.
>> +#
>> +# Since: 5.0
>> +#
>> +# Example:
>> +#
>> +# -> { "execute": "block-dirty-bitmap-populate",
>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "arguments": { "node": "drive0", "targe=
t": "bitmap0",
>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "job-id": "job0", "patt=
ern": "allocate-top" } }
>> +# <- { "return": {} }
>> +#
>> +##
>> +{ 'command': 'block-dirty-bitmap-populate', 'boxed': true,
>> +=C2=A0 'data': 'BlockDirtyBitmapPopulate' }
>> +
>> =C2=A0 ##
>> =C2=A0 # @BlockDirtyBitmapSha256:
>> =C2=A0 #
>> diff --git a/qapi/transaction.json b/qapi/transaction.json
>> index 04301f1be7..28521d5c7f 100644
>> --- a/qapi/transaction.json
>> +++ b/qapi/transaction.json
>> @@ -50,6 +50,7 @@
>> =C2=A0 # - @block-dirty-bitmap-enable: since 4.0
>> =C2=A0 # - @block-dirty-bitmap-disable: since 4.0
>> =C2=A0 # - @block-dirty-bitmap-merge: since 4.0
>> +# - @block-dirty-bitmap-populate: since 5.0
>> =C2=A0 # - @blockdev-backup: since 2.3
>> =C2=A0 # - @blockdev-snapshot: since 2.5
>> =C2=A0 # - @blockdev-snapshot-internal-sync: since 1.7
>> @@ -67,6 +68,7 @@
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'block-dirty-bitmap-ena=
ble': 'BlockDirtyBitmap',
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'block-dirty-bitmap-dis=
able': 'BlockDirtyBitmap',
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'block-dirty-bitmap-mer=
ge': 'BlockDirtyBitmapMerge',
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'block-dirty-bitmap-populate': 'Bl=
ockDirtyBitmapPopulate',
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'blockdev-backup': 'Blo=
ckdevBackup',
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'blockdev-snapshot': 'B=
lockdevSnapshot',
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'blockdev-snapshot-inte=
rnal-sync': 'BlockdevSnapshotInternal',
>> diff --git a/blockdev.c b/blockdev.c
>> index 011dcfec27..33c0e35399 100644
>> --- a/blockdev.c
>> +++ b/blockdev.c
>> @@ -2314,6 +2314,67 @@ static void
>> block_dirty_bitmap_remove_commit(BlkActionState *common)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bdrv_release_dirty_bitmap(state->bitmap);
>> =C2=A0 }
>> =C2=A0 +static void block_dirty_bitmap_populate_prepare(BlkActionState
>> *common, Error **errp)
>=20
> over80 line (not the only)
>=20

OK, will fix all instances.

>> +{
>> +=C2=A0=C2=A0=C2=A0 BlockdevBackupState *state =3D DO_UPCAST(BlockdevBac=
kupState,
>> common, common);
>=20
> At first glance using *Backup* looks like a mistake. May be rename it,
> or at least add a comment.
>=20

You're right, it's tricky. A rename would be helpful.

>> +=C2=A0=C2=A0=C2=A0 BlockDirtyBitmapPopulate *bitpop;
>> +=C2=A0=C2=A0=C2=A0 BlockDriverState *bs;
>> +=C2=A0=C2=A0=C2=A0 AioContext *aio_context;
>> +=C2=A0=C2=A0=C2=A0 BdrvDirtyBitmap *bmap =3D NULL;
>> +=C2=A0=C2=A0=C2=A0 int job_flags =3D JOB_DEFAULT;
>> +
>> +=C2=A0=C2=A0=C2=A0 assert(common->action->type =3D=3D
>> TRANSACTION_ACTION_KIND_BLOCK_DIRTY_BITMAP_POPULATE);
>> +=C2=A0=C2=A0=C2=A0 bitpop =3D common->action->u.block_dirty_bitmap_popu=
late.data;
>> +
>> +=C2=A0=C2=A0=C2=A0 bs =3D bdrv_lookup_bs(bitpop->node, bitpop->node, er=
rp);
>> +=C2=A0=C2=A0=C2=A0 if (!bs) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 aio_context =3D bdrv_get_aio_context(bs);
>> +=C2=A0=C2=A0=C2=A0 aio_context_acquire(aio_context);
>> +=C2=A0=C2=A0=C2=A0 state->bs =3D bs;
>> +
>> +=C2=A0=C2=A0=C2=A0 bmap =3D bdrv_find_dirty_bitmap(bs, bitpop->name);
>=20
> Could we use block_dirty_bitmap_lookup ?
>=20

Yes.

>> +=C2=A0=C2=A0=C2=A0 if (!bmap) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_setg(errp, "Bitmap '%s=
' could not be found",
>> bitpop->name);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>=20
> aio context lock leaked
>=20

Good spot.

>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 /* Paired with .clean() */
>> +=C2=A0=C2=A0=C2=A0 bdrv_drained_begin(state->bs);
>> +
>> +=C2=A0=C2=A0=C2=A0 if (!bitpop->has_on_error) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bitpop->on_error =3D BLOCKDE=
V_ON_ERROR_REPORT;
>> +=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0 if (!bitpop->has_auto_finalize) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bitpop->auto_finalize =3D tr=
ue;
>> +=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0 if (!bitpop->has_auto_dismiss) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bitpop->auto_dismiss =3D tru=
e;
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 if (!bitpop->auto_finalize) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 job_flags |=3D JOB_MANUAL_FI=
NALIZE;
>> +=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0 if (!bitpop->auto_dismiss) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 job_flags |=3D JOB_MANUAL_DI=
SMISS;
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 state->job =3D bitpop_job_create(
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bitpop->job_id,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bs,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bmap,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bitpop->pattern,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bitpop->on_error,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 job_flags,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 NULL, NULL,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 common->block_job_txn,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 errp);
>> +
>> +=C2=A0=C2=A0=C2=A0 aio_context_release(aio_context);
>> +}
>> +
>> =C2=A0 static void abort_prepare(BlkActionState *common, Error **errp)
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_setg(errp, "Transaction aborted usi=
ng Abort action");
>> @@ -2397,6 +2458,13 @@ static const BlkActionOps actions[] =3D {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .commit =3D block=
_dirty_bitmap_remove_commit,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .abort =3D block_=
dirty_bitmap_remove_abort,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 },
>> +=C2=A0=C2=A0=C2=A0 [TRANSACTION_ACTION_KIND_BLOCK_DIRTY_BITMAP_POPULATE=
] =3D {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .instance_size =3D sizeof(Bl=
ockdevBackupState),
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .prepare =3D block_dirty_bit=
map_populate_prepare,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .commit =3D blockdev_backup_=
commit,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .abort =3D blockdev_backup_a=
bort,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .clean =3D blockdev_backup_c=
lean,
>> +=C2=A0=C2=A0=C2=A0 },
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Where are transactions for MIRROR, COM=
MIT and STREAM?
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Although these blockjobs use tran=
saction callbacks like the
>> backup job,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * these jobs do not necessarily adh=
ere to transaction semantics.
>> @@ -3225,6 +3293,16 @@ void qmp_block_dirty_bitmap_merge(const char
>> *node, const char *target,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 do_block_dirty_bitmap_merge(node, target,=
 bitmaps, NULL, errp);
>> =C2=A0 }
>> =C2=A0 +void qmp_block_dirty_bitmap_populate(BlockDirtyBitmapPopulate *b=
itpop,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Er=
ror **errp)
>> +{
>> +=C2=A0=C2=A0=C2=A0 TransactionAction action =3D {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .type =3D TRANSACTION_ACTION=
_KIND_BLOCK_DIRTY_BITMAP_POPULATE,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .u.block_dirty_bitmap_popula=
te.data =3D bitpop,
>> +=C2=A0=C2=A0=C2=A0 };
>> +=C2=A0=C2=A0=C2=A0 blockdev_do_action(&action, errp);
>> +}
>> +
>> =C2=A0 BlockDirtyBitmapSha256 *qmp_x_debug_block_dirty_bitmap_sha256(con=
st
>> char *node,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 const
>> char *name,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 Error
>> **errp)
>>
>=20
>=20

--=20
=E2=80=94js


