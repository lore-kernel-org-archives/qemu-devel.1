Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B989EC433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 11:28:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73C8E207BB
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 11:28:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aXAFcC4h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73C8E207BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50494 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8ikE-0000E9-My
	for qemu-devel@archiver.kernel.org; Thu, 20 Aug 2020 07:28:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60956)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1k8ijc-0008A9-G7
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 07:27:56 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39178
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1k8ijZ-0002PP-1A
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 07:27:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597922871;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=o3zKn/Z3Y3biHcffQnGwKJiQeRJA/o3vMTK10U8STHc=;
 b=aXAFcC4hLrRD4HIkPB7FS5A1JcDK9W/ZS3ZSDOZiXad2+Q9isA5oQrLaU97KEbBt5BHdAd
 Apcuk8PyPXmUn21dqgW9l0adrBRwJT2QAbOKB5jDd1sClN10cnzXzm8NXQ5uuWpi+g91K5
 8fF5YQycTME0kGIka8fnm4AH5dV3+kM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-440-6e80s9yWMZiw9VfJXYy_IA-1; Thu, 20 Aug 2020 07:27:47 -0400
X-MC-Unique: 6e80s9yWMZiw9VfJXYy_IA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D8883427C0;
 Thu, 20 Aug 2020 11:27:46 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-133.ams2.redhat.com
 [10.36.113.133])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E2C382B3AE;
 Thu, 20 Aug 2020 11:27:43 +0000 (UTC)
Subject: Re: [PATCH v7 35/47] commit: Deal with filters
To: Kevin Wolf <kwolf@redhat.com>
References: <20200625152215.941773-1-mreitz@redhat.com>
 <20200625152215.941773-36-mreitz@redhat.com>
 <20200819175106.GI10272@linux.fritz.box>
From: Max Reitz <mreitz@redhat.com>
Autocrypt: addr=mreitz@redhat.com; prefer-encrypt=mutual; keydata=
 mQENBFXOJlcBCADEyyhOTsoa/2ujoTRAJj4MKA21dkxxELVj3cuILpLTmtachWj7QW+TVG8U
 /PsMCFbpwsQR7oEy8eHHZwuGQsNpEtNC2G/L8Yka0BIBzv7dEgrPzIu+W3anZXQW4702+uES
 U29G8TP/NGfXRRHGlbBIH9KNUnOSUD2vRtpOLXkWsV5CN6vQFYgQfFvmp5ZpPeUe6xNplu8V
 mcTw8OSEDW/ZnxJc8TekCKZSpdzYoxfzjm7xGmZqB18VFwgJZlIibt1HE0EB4w5GsD7x5ekh
 awIe3RwoZgZDLQMdOitJ1tUc8aqaxvgA4tz6J6st8D8pS//m1gAoYJWGwwIVj1DjTYLtABEB
 AAG0HU1heCBSZWl0eiA8bXJlaXR6QHJlZGhhdC5jb20+iQFTBBMBCAA9AhsDBQkSzAMABQsJ
 CAcCBhUICQoLAgQWAgMBAh4BAheABQJVzie5FRhoa3A6Ly9rZXlzLmdudXBnLm5ldAAKCRD0
 B9sAYdXPQDcIB/9uNkbYEex1rHKz3mr12uxYMwLOOFY9fstP5aoVJQ1nWQVB6m2cfKGdcRe1
 2/nFaHSNAzT0NnKz2MjhZVmcrpyd2Gp2QyISCfb1FbT82GMtXFj1wiHmPb3CixYmWGQUUh+I
 AvUqsevLA+WihgBUyaJq/vuDVM1/K9Un+w+Tz5vpeMidlIsTYhcsMhn0L9wlCjoucljvbDy/
 8C9L2DUdgi3XTa0ORKeflUhdL4gucWoAMrKX2nmPjBMKLgU7WLBc8AtV+84b9OWFML6NEyo4
 4cP7cM/07VlJK53pqNg5cHtnWwjHcbpGkQvx6RUx6F1My3y52vM24rNUA3+ligVEgPYBuQEN
 BFXOJlcBCADAmcVUNTWT6yLWQHvxZ0o47KCP8OcLqD+67T0RCe6d0LP8GsWtrJdeDIQk+T+F
 xO7DolQPS6iQ6Ak2/lJaPX8L0BkEAiMuLCKFU6Bn3lFOkrQeKp3u05wCSV1iKnhg0UPji9V2
 W5eNfy8F4ZQHpeGUGy+liGXlxqkeRVhLyevUqfU0WgNqAJpfhHSGpBgihUupmyUg7lfUPeRM
 DzAN1pIqoFuxnN+BRHdAecpsLcbR8sQddXmDg9BpSKozO/JyBmaS1RlquI8HERQoe6EynJhd
 64aICHDfj61rp+/0jTIcevxIIAzW70IadoS/y3DVIkuhncgDBvGbF3aBtjrJVP+5ABEBAAGJ
 ASUEGAEIAA8FAlXOJlcCGwwFCRLMAwAACgkQ9AfbAGHVz0CbFwf9F/PXxQR9i4N0iipISYjU
 sxVdjJOM2TMut+ZZcQ6NSMvhZ0ogQxJ+iEQ5OjnIputKvPVd5U7WRh+4lF1lB/NQGrGZQ1ic
 alkj6ocscQyFwfib+xIe9w8TG1CVGkII7+TbS5pXHRxZH1niaRpoi/hYtgzkuOPp35jJyqT/
 /ELbqQTDAWcqtJhzxKLE/ugcOMK520dJDeb6x2xVES+S5LXby0D4juZlvUj+1fwZu+7Io5+B
 bkhSVPb/QdOVTpnz7zWNyNw+OONo1aBUKkhq2UIByYXgORPFnbfMY7QWHcjpBVw9MgC4tGeF
 R4bv+1nAMMxKmb5VvQCExr0eFhJUAHAhVg==
Message-ID: <fe136446-ac29-67de-faf4-125145970fd1@redhat.com>
Date: Thu, 20 Aug 2020 13:27:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200819175106.GI10272@linux.fritz.box>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="u4MXeACpouXnAasSCTtyu5NgE1qFiALGj"
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/20 03:03:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--u4MXeACpouXnAasSCTtyu5NgE1qFiALGj
Content-Type: multipart/mixed; boundary="I1IcYJnqFtqpIbYtvasdGRfy5PrPBAva9"

--I1IcYJnqFtqpIbYtvasdGRfy5PrPBAva9
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 19.08.20 19:58, Kevin Wolf wrote:
> Am 25.06.2020 um 17:22 hat Max Reitz geschrieben:
>> This includes some permission limiting (for example, we only need to
>> take the RESIZE permission if the base is smaller than the top).
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>  block/block-backend.c          |  9 +++-
>>  block/commit.c                 | 96 +++++++++++++++++++++++++---------
>>  block/monitor/block-hmp-cmds.c |  2 +-
>>  blockdev.c                     |  4 +-
>>  4 files changed, 81 insertions(+), 30 deletions(-)
>>
>> diff --git a/block/block-backend.c b/block/block-backend.c
>> index 6936b25c83..7f2c7dbccc 100644
>> --- a/block/block-backend.c
>> +++ b/block/block-backend.c
>> @@ -2271,8 +2271,13 @@ int blk_commit_all(void)
>>          AioContext *aio_context =3D blk_get_aio_context(blk);
>> =20
>>          aio_context_acquire(aio_context);
>> -        if (blk_is_inserted(blk) && blk->root->bs->backing) {
>> -            int ret =3D bdrv_commit(blk->root->bs);
>=20
> The old code didn't try to commit nodes that don't have a backing file.
>=20
>> +        if (blk_is_inserted(blk)) {
>> +            BlockDriverState *non_filter;
>> +            int ret;
>> +
>> +            /* Legacy function, so skip implicit filters */
>> +            non_filter =3D bdrv_skip_implicit_filters(blk->root->bs);
>> +            ret =3D bdrv_commit(non_filter);
>=20
> The new one tries unconditionally. For nodes without a backing file,
> bdrv_commit() will return -ENOTSUP, so the whole function fails.

:(

Hm.  Should I fix it by checking for
bdrv_cow_bs(bdrv_skip_implicit_filters())?  Or bdrv_backing_chain_next()
and change the bdrv_skip_implicit_filters() to a bdrv_skip_filters()?  I
feel like that would make even more sense.

> (First real bug at patch 35. I almost thought I wouldn't find any!)

:)

>>              if (ret < 0) {
>>                  aio_context_release(aio_context);
>>                  return ret;
>> diff --git a/block/commit.c b/block/commit.c
>> index 7732d02dfe..4122b6736d 100644
>> --- a/block/commit.c
>> +++ b/block/commit.c
>> @@ -37,6 +37,7 @@ typedef struct CommitBlockJob {
>>      BlockBackend *top;
>>      BlockBackend *base;
>>      BlockDriverState *base_bs;
>> +    BlockDriverState *base_overlay;
>>      BlockdevOnError on_error;
>>      bool base_read_only;
>>      bool chain_frozen;
>=20
> Hm, again this mysterious base_overlay. I know that stream introduced it
> to avoid freezing the link to base, but commit doesn't seem to do that.
>=20
> Is it to avoid using the block status of filter drivers between
> base_overlay and base?

Yes.

> If so, I guess that goes back to the question I
> raised earlier in this series: What is the block status supposed to tell
> for filter nodes?

Honestly, I would really like to get away without having to answer that
question in this series.  Intuitively, I feel like falling through to
the next data-bearing layer is not something most callers want.  But I=E2=
=80=99d
rather investigate that question separately from this series (even
though that likely means we=E2=80=99ll never do it), and just treat it as i=
t is
in this series.

> But anyway, in contrast to mirror, commit actually freezes the chain
> between commit_top_bs and base, so it should be safe at least.
>=20
>> @@ -89,7 +90,7 @@ static void commit_abort(Job *job)
>>       * XXX Can (or should) we somehow keep 'consistent read' blocked ev=
en
>>       * after the failed/cancelled commit job is gone? If we already wro=
te
>>       * something to base, the intermediate images aren't valid any more=
. */
>> -    bdrv_replace_node(s->commit_top_bs, backing_bs(s->commit_top_bs),
>> +    bdrv_replace_node(s->commit_top_bs, s->commit_top_bs->backing->bs,
>>                        &error_abort);
>> =20
>>      bdrv_unref(s->commit_top_bs);
>> @@ -153,7 +154,7 @@ static int coroutine_fn commit_run(Job *job, Error *=
*errp)
>>              break;
>>          }
>>          /* Copy if allocated above the base */
>> -        ret =3D bdrv_is_allocated_above(blk_bs(s->top), blk_bs(s->base)=
, false,
>> +        ret =3D bdrv_is_allocated_above(blk_bs(s->top), s->base_overlay=
, true,
>>                                        offset, COMMIT_BUFFER_SIZE, &n);
>>          copy =3D (ret =3D=3D 1);
>>          trace_commit_one_iteration(s, offset, n, ret);
>> @@ -253,15 +254,35 @@ void commit_start(const char *job_id, BlockDriverS=
tate *bs,
>>      CommitBlockJob *s;
>>      BlockDriverState *iter;
>>      BlockDriverState *commit_top_bs =3D NULL;
>> +    BlockDriverState *filtered_base;
>>      Error *local_err =3D NULL;
>> +    int64_t base_size, top_size;
>> +    uint64_t perms, iter_shared_perms;
>>      int ret;
>> =20
>>      assert(top !=3D bs);
>> -    if (top =3D=3D base) {
>> +    if (bdrv_skip_filters(top) =3D=3D bdrv_skip_filters(base)) {
>>          error_setg(errp, "Invalid files for merge: top and base are the=
 same");
>>          return;
>>      }
>> =20
>> +    base_size =3D bdrv_getlength(base);
>> +    if (base_size < 0) {
>> +        error_setg_errno(errp, -base_size, "Could not inquire base imag=
e size");
>> +        return;
>> +    }
>> +
>> +    top_size =3D bdrv_getlength(top);
>> +    if (top_size < 0) {
>> +        error_setg_errno(errp, -top_size, "Could not inquire top image =
size");
>> +        return;
>> +    }
>> +
>> +    perms =3D BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE;
>> +    if (base_size < top_size) {
>> +        perms |=3D BLK_PERM_RESIZE;
>> +    }
>=20
> base_perms would indicate which permissions these are (particularly
> because it's not the next thing that requires permissions, but only used
> further down the function).

%s/\<perms\>/base_perms/?  Sure.

>>      s =3D block_job_create(job_id, &commit_job_driver, NULL, bs, 0, BLK=
_PERM_ALL,
>>                           speed, creation_flags, NULL, NULL, errp);
>>      if (!s) {
>> @@ -301,17 +322,43 @@ void commit_start(const char *job_id, BlockDriverS=
tate *bs,
>> =20
>>      s->commit_top_bs =3D commit_top_bs;
>> =20
>> -    /* Block all nodes between top and base, because they will
>> -     * disappear from the chain after this operation. */
>> -    assert(bdrv_chain_contains(top, base));
>> -    for (iter =3D top; iter !=3D base; iter =3D backing_bs(iter)) {
>> -        /* XXX BLK_PERM_WRITE needs to be allowed so we don't block our=
selves
>> -         * at s->base (if writes are blocked for a node, they are also =
blocked
>> -         * for its backing file). The other options would be a second f=
ilter
>> -         * driver above s->base. */
>> +    /*
>> +     * Block all nodes between top and base, because they will
>> +     * disappear from the chain after this operation.
>> +     * Note that this assumes that the user is fine with removing all
>> +     * nodes (including R/W filters) between top and base.  Assuring
>> +     * this is the responsibility of the interface (i.e. whoever calls
>> +     * commit_start()).
>> +     */
>> +    s->base_overlay =3D bdrv_find_overlay(top, base);
>> +    assert(s->base_overlay);
>> +
>> +    /*
>> +     * The topmost node with
>> +     * bdrv_skip_filters(filtered_base) =3D=3D bdrv_skip_filters(base)
>> +     */
>> +    filtered_base =3D bdrv_cow_bs(s->base_overlay);
>> +    assert(bdrv_skip_filters(filtered_base) =3D=3D bdrv_skip_filters(ba=
se));
>> +
>> +    /*
>> +     * XXX BLK_PERM_WRITE needs to be allowed so we don't block ourselv=
es
>> +     * at s->base (if writes are blocked for a node, they are also bloc=
ked
>> +     * for its backing file). The other options would be a second filte=
r
>> +     * driver above s->base.
>> +     */
>> +    iter_shared_perms =3D BLK_PERM_WRITE_UNCHANGED | BLK_PERM_WRITE;
>> +
>> +    for (iter =3D top; iter !=3D base; iter =3D bdrv_filter_or_cow_bs(i=
ter)) {
>> +        if (iter =3D=3D filtered_base) {
>> +            /*
>> +             * From here on, all nodes are filters on the base.  This
>> +             * allows us to share BLK_PERM_CONSISTENT_READ.
>> +             */
>> +            iter_shared_perms |=3D BLK_PERM_CONSISTENT_READ;
>> +        }
>> +
>>          ret =3D block_job_add_bdrv(&s->common, "intermediate node", ite=
r, 0,
>> -                                 BLK_PERM_WRITE_UNCHANGED | BLK_PERM_WR=
ITE,
>> -                                 errp);
>> +                                 iter_shared_perms, errp);
>>          if (ret < 0) {
>>              goto fail;
>>          }
>> @@ -328,9 +375,7 @@ void commit_start(const char *job_id, BlockDriverSta=
te *bs,
>>      }
>> =20
>>      s->base =3D blk_new(s->common.job.aio_context,
>> -                      BLK_PERM_CONSISTENT_READ
>> -                      | BLK_PERM_WRITE
>> -                      | BLK_PERM_RESIZE,
>> +                      perms,
>>                        BLK_PERM_CONSISTENT_READ
>>                        | BLK_PERM_GRAPH_MOD
>>                        | BLK_PERM_WRITE_UNCHANGED);
>> @@ -398,19 +443,22 @@ int bdrv_commit(BlockDriverState *bs)
>>      if (!drv)
>>          return -ENOMEDIUM;
>> =20
>> -    if (!bs->backing) {
>> +    backing_file_bs =3D bdrv_cow_bs(bs);
>> +
>> +    if (!backing_file_bs) {
>>          return -ENOTSUP;
>>      }
>> =20
>>      if (bdrv_op_is_blocked(bs, BLOCK_OP_TYPE_COMMIT_SOURCE, NULL) ||
>> -        bdrv_op_is_blocked(bs->backing->bs, BLOCK_OP_TYPE_COMMIT_TARGET=
, NULL)) {
>> +        bdrv_op_is_blocked(backing_file_bs, BLOCK_OP_TYPE_COMMIT_TARGET=
, NULL))
>> +    {
>>          return -EBUSY;
>>      }
>> =20
>> -    ro =3D bs->backing->bs->read_only;
>> +    ro =3D backing_file_bs->read_only;
>> =20
>>      if (ro) {
>> -        if (bdrv_reopen_set_read_only(bs->backing->bs, false, NULL)) {
>> +        if (bdrv_reopen_set_read_only(backing_file_bs, false, NULL)) {
>>              return -EACCES;
>>          }
>>      }
>> @@ -428,8 +476,6 @@ int bdrv_commit(BlockDriverState *bs)
>>      }
>> =20
>>      /* Insert commit_top block node above backing, so we can write to i=
t */
>> -    backing_file_bs =3D backing_bs(bs);
>> -
>>      commit_top_bs =3D bdrv_new_open_driver(&bdrv_commit_top, NULL, BDRV=
_O_RDWR,
>>                                           &local_err);
>>      if (commit_top_bs =3D=3D NULL) {
>> @@ -515,15 +561,13 @@ ro_cleanup:
>>      qemu_vfree(buf);
>> =20
>>      blk_unref(backing);
>> -    if (backing_file_bs) {
>> -        bdrv_set_backing_hd(bs, backing_file_bs, &error_abort);
>> -    }
>> +    bdrv_set_backing_hd(bs, backing_file_bs, &error_abort);
>=20
> This means that bdrv_set_backing_hd() is now called to undo a change
> that hasn't even been made yet. This fails (with &error_abort) if the
> backing chain is frozen.
>=20
> On the other hand, the other bdrv_set_backing_hd() calls in the same
> function would fail the same way.

True. :)

Still, maybe there=E2=80=99s an op blocker from a concurrent job, so we go =
to
the failure path and then we=E2=80=99d abort here.  So better to guard it b=
y
checking whether bdrv_cow_bs(bs) !=3D backing_file_bs.

Max


--I1IcYJnqFtqpIbYtvasdGRfy5PrPBAva9--

--u4MXeACpouXnAasSCTtyu5NgE1qFiALGj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl8+Xi4ACgkQ9AfbAGHV
z0AdbQgAh58/Nup3mT67CqYFfo2jT2sRm4uis1hzYsw1jYcddKFEUWeOVTZ66TDV
meay0QbyIiDAWgyRCSrqAXAPlP3uboVGRYlWlVtm4T926vW3vI2Wy3sI1w5Ragy5
yon2AghiJfmfMvp9zWslPKHnhw6K+wvHscJ5GPBTxux/ztFoQPpHuGpMH+rl75L3
Uhp4G/wCx6ZpvYnMZ01YQE+9rxmT7aa41Z1WqfjXNnUZGNcB1AbcJU2eK02WVDSJ
4IzGdT0R8pLHbdUm3EGzB7ESIrZN54YJD8iuGhzA+KzEDBHMWwHg0oh524QhLqNj
KhLJOPoSlVEq+h7T2LcoJBN8Wr8mhQ==
=8XvR
-----END PGP SIGNATURE-----

--u4MXeACpouXnAasSCTtyu5NgE1qFiALGj--


