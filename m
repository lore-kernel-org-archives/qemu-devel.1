Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3CACC4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 17:00:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04DF5206DB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 17:00:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W+KyX0dS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04DF5206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40832 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLUbp-00024I-Nv
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 13:00:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41046)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kLUSK-0002hD-Ps
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 12:50:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22721)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kLUSH-0002k7-M5
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 12:50:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600966249;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=aHAeNq8Poam9plvCuzA+ab0cgRzUcPHUM0WQF7Fc2m4=;
 b=W+KyX0dSWiQnUBM3saixyBMr49+7KQPNL/IBnIqtfq1yJ5R+mTMlrgdXnEUMY+tdn48PvD
 2seznPBjyXia0OY0oBPJCgAiQT+x1XZA5ogzUmBPBzLss1CE1Gw4R5pMhgi42jQaQ9x4Up
 SmuAhEV1NDpWGKMseoj3FGboRLnV0oM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-355-67IiZF44PWKnwDhVDjfDnw-1; Thu, 24 Sep 2020 12:50:46 -0400
X-MC-Unique: 67IiZF44PWKnwDhVDjfDnw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 62978101874F;
 Thu, 24 Sep 2020 16:50:45 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-114-153.ams2.redhat.com
 [10.36.114.153])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8513D6115F;
 Thu, 24 Sep 2020 16:50:40 +0000 (UTC)
Subject: Re: [PATCH v6 08/15] block: introduce preallocate filter
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20200918181951.21752-1-vsementsov@virtuozzo.com>
 <20200918181951.21752-9-vsementsov@virtuozzo.com>
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
Message-ID: <73b1b0eb-5ca3-a436-5783-695d62fe337e@redhat.com>
Date: Thu, 24 Sep 2020 18:50:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200918181951.21752-9-vsementsov@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="HoVPGF5l3ULu6BLkKUavWxrLh6XPgD9w1"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 23:02:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.214, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: fam@euphon.net, kwolf@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com,
 stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--HoVPGF5l3ULu6BLkKUavWxrLh6XPgD9w1
Content-Type: multipart/mixed; boundary="LXSGjkm4MaBJ7DYDH2DRe0ZajQRNyAILp"

--LXSGjkm4MaBJ7DYDH2DRe0ZajQRNyAILp
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 18.09.20 20:19, Vladimir Sementsov-Ogievskiy wrote:
> It's intended to be inserted between format and protocol nodes to
> preallocate additional space (expanding protocol file) on writes
> crossing EOF. It improves performance for file-systems with slow
> allocation.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  docs/system/qemu-block-drivers.rst.inc |  26 ++
>  qapi/block-core.json                   |  20 +-
>  block/preallocate.c                    | 556 +++++++++++++++++++++++++
>  block/meson.build                      |   1 +
>  4 files changed, 602 insertions(+), 1 deletion(-)
>  create mode 100644 block/preallocate.c

Looks good to me in general.

[...]

> diff --git a/block/preallocate.c b/block/preallocate.c
> new file mode 100644
> index 0000000000..6510ad0149
> --- /dev/null
> +++ b/block/preallocate.c

[...]

> +/*
> + * Handle reopen.
> + *
> + * We must implement reopen handlers, otherwise reopen just don't work. =
Handle
> + * new options and don't care about preallocation state, as it is handle=
d in
> + * set/check permission handlers.
> + */
> +
> +static int preallocate_reopen_prepare(BDRVReopenState *reopen_state,
> +                                      BlockReopenQueue *queue, Error **e=
rrp)
> +{
> +    PreallocateOpts *opts =3D g_new0(PreallocateOpts, 1);
> +
> +    if (!preallocate_absorb_opts(opts, reopen_state->options,
> +                                 reopen_state->bs->file->bs, errp)) {

I tried to find out whether this refers to the old file child, or the
post-reopen one.  As far as I could find out, there is no generic
implementation for changing the file child as part of x-blockdev-reopen:

{"error": {"class": "GenericError", "desc": "Cannot change the option
'file'"}}

Now that=E2=80=99s a shame.  That means you can=E2=80=99t reasonably integr=
ate a
preallocate filter into an existing node graph unless the format driver
checks for the respective child option and issues a replace_node on
commit or something, right?  I suppose any driver who=E2=80=99d want to
implement child replacement would need to attach the new node in
prepare() as some pseudo-child, and then drop the old one and rename the
new one in commit().  I don=E2=80=99t think any driver does that yet, so I
suppose no format driver allows replacement of children yet (except for
quorum...).

Does anyone know what the status on that is?  Are there any plans for
implementing child replacement in reopen, or did I just miss something?

(It looks like the backing child can be replaced, but that=E2=80=99s probab=
ly
not a child where the preallocate filter would be placed on top...).

> +        g_free(opts);
> +        return -EINVAL;
> +    }
> +
> +    reopen_state->opaque =3D opts;
> +
> +    return 0;
> +}

[...]

> +/*
> + * Call on each write. Returns true if @want_merge_zero is true and the =
region
> + * [offset, offset + bytes) is zeroed (as a result of this call or earli=
er
> + * preallocation).
> + *
> + * want_merge_zero is used to merge write-zero request with preallocatio=
n in
> + * one bdrv_co_pwrite_zeroes() call.
> + */
> +static bool coroutine_fn handle_write(BlockDriverState *bs, int64_t offs=
et,
> +                                      int64_t bytes, bool want_merge_zer=
o)
> +{
> +    BDRVPreallocateState *s =3D bs->opaque;
> +    int64_t end =3D offset + bytes;
> +    int64_t prealloc_start, prealloc_end;
> +    int ret;
> +
> +    if (!has_prealloc_perms(bs)) {

Took me a bit to figure out, because it takes a trip to
preallocate_child_perm() to figure out exactly when we=E2=80=99re going to =
have
the necessary permissions for this to pass.

Then it turns out that this is going to be the case exactly when the
parents collectively have the same permissions (WRITE+RESIZE) on the
preallocate node.

Then I had to wonder whether it=E2=80=99s appropriate not to preallocate if
WRITE is taken, but RESIZE isn=E2=80=99t.  But that seems entirely correct,=
 yes.
 If noone is going to grow the file, then there is no need for
preallocation.  (Vice versa, if noone is going to write, but only
resize, then there is no need for preallocation either.)

So this seems correct, yes.

(It could be argued that if one parent has WRITE, and another has RESIZE
(but neither has both), then we probably don=E2=80=99t need preallocation
either.  But in such an arcane case (which is impossible to figure out
in .bdrv_child_perm() anyway), we might as well just do preallocation.
Won=E2=80=99t hurt.)

> +        /* We don't have state neither should try to recover it */
> +        return false;
> +    }
> +
> +    if (s->data_end < 0) {
> +        s->data_end =3D bdrv_getlength(bs->file->bs);
> +        if (s->data_end < 0) {
> +            return false;
> +        }
> +
> +        if (s->file_end < 0) {
> +            s->file_end =3D s->data_end;
> +        }
> +    }
> +
> +    if (end <=3D s->data_end) {
> +        return false;
> +    }
> +
> +    /* We have valid s->data_end, and request writes beyond it. */
> +
> +    s->data_end =3D end;
> +    if (s->zero_start < 0 || !want_merge_zero) {
> +        s->zero_start =3D end;

Skipping this on want_merge_zero =3D=3D true means that zero writes can be
cached; if you repeatedly perform zero writes into the preallocated
area, then none of those will actually be executed.  I legitimately
don=E2=80=99t know whether that=E2=80=99s OK.

I suppose until someone tells me it isn=E2=80=99t OK, I=E2=80=99ll believe =
it is.

> +    }
> +
> +    if (s->file_end < 0) {
> +        s->file_end =3D bdrv_getlength(bs->file->bs);
> +        if (s->file_end < 0) {
> +            return false;
> +        }
> +    }
> +
> +    /* Now s->data_end, s->zero_start and s->file_end are valid. */
> +
> +    if (end <=3D s->file_end) {
> +        /* No preallocation needed. */
> +        return want_merge_zero && offset >=3D s->zero_start;
> +    }
> +
> +    /* Now we want new preallocation, as request writes beyond s->data_e=
nd. */

s/data_end/file_end/

> +
> +    prealloc_start =3D want_merge_zero ? MIN(offset, s->file_end) : s->f=
ile_end;

I suppose you intentionally use s->file_end here instead of @end, even
if offset <=3D s->file_end.  I just mention it because I wonder whether
it=E2=80=99s really better to effectively write twice to the same area in s=
uch
cases (once zeroes for preallocation, then immediately the data) instead
of only writing the data and then preallocating past it.

(Though if it were the same code just with @end instead of s->file_end
for offset <=3D s->file_end, then the order would be to preallocate past
@end, and then to write the data.  Which might be suboptimal in terms of
how the blocks are then ordered in the filesystem.)

> +    prealloc_end =3D QEMU_ALIGN_UP(offset + bytes + s->opts.prealloc_siz=
e,

s/offset + bytes/end/?

> +                                 s->opts.prealloc_align);
> +    s->file_end =3D end;

Why is this set here, when it=E2=80=99s always overwritten after
bdrv_co_pwrite_zeroes() anyway?

(It also seems a bit wrong, because at this point we don=E2=80=99t know yet
whether the data write is going to succeed, so we don=E2=80=99t know for su=
re
whether the file end is really going to be @end without the preallocation.)

> +
> +    ret =3D bdrv_co_pwrite_zeroes(
> +            bs->file, prealloc_start, prealloc_end - prealloc_start,
> +            BDRV_REQ_NO_FALLBACK | BDRV_REQ_SERIALISING | BDRV_REQ_NO_WA=
IT);
> +    if (ret < 0) {
> +        s->file_end =3D ret;
> +        return false;
> +    }
> +
> +    s->file_end =3D prealloc_end;
> +    return want_merge_zero;
> +}
> +
> +static int coroutine_fn preallocate_co_pwrite_zeroes(BlockDriverState *b=
s,
> +        int64_t offset, int bytes, BdrvRequestFlags flags)
> +{
> +    bool want_merge_zero =3D
> +        (flags & (BDRV_REQ_ZERO_WRITE | BDRV_REQ_NO_FALLBACK)) =3D=3D fl=
ags;

Isn=E2=80=99t this the same as !(flags & ~(ZERO_WRITE | NO_FALLBACK))?  (Ma=
ybe
only I would find that simpler to understand, though.)

> +    if (handle_write(bs, offset, bytes, want_merge_zero)) {
> +        return 0;
> +    }
> +
> +    return bdrv_co_pwrite_zeroes(bs->file, offset, bytes, flags);
> +}

[...]

> +static int coroutine_fn
> +preallocate_co_truncate(BlockDriverState *bs, int64_t offset,
> +                        bool exact, PreallocMode prealloc,
> +                        BdrvRequestFlags flags, Error **errp)
> +{
> +    ERRP_GUARD();
> +    BDRVPreallocateState *s =3D bs->opaque;
> +    int ret;
> +
> +    if (s->data_end >=3D 0 && offset > s->data_end) {
> +        if (s->file_end < 0) {
> +            s->file_end =3D bdrv_getlength(bs->file->bs);
> +            if (s->file_end < 0) {
> +                error_setg(errp, "failed to get file length");
> +                return s->file_end;
> +            }
> +        }
> +
> +        if (prealloc =3D=3D PREALLOC_MODE_FALLOC) {
> +            /*
> +             * If offset <=3D s->file_end, the task is already done, jus=
t
> +             * update s->file_end, to move part of "filter preallocation=
"

s/file_end/data_end/

> +             * to "preallocation requested by user".
> +             * Otherwise just proceed to preallocate missing part.
> +             */
> +            if (offset <=3D s->file_end) {
> +                s->data_end =3D offset;
> +                return 0;
> +            }

[...]

> +static int preallocate_check_perm(BlockDriverState *bs,
> +                                  uint64_t perm, uint64_t shared, Error =
**errp)
> +{
> +    BDRVPreallocateState *s =3D bs->opaque;
> +
> +    if (s->data_end >=3D 0 && !can_write_resize(perm)) {
> +        /*
> +         * Loose permissions.

*Lose

(I assume)

> +         * We should truncate in check_perm, as in set_perm bs->file->pe=
rm will
> +         * be already changed, and we should not violate it.
> +         */
> +        if (s->file_end < 0) {
> +            s->file_end =3D bdrv_getlength(bs->file->bs);
> +            if (s->file_end < 0) {
> +                error_setg(errp, "Failed to get file length");
> +                return s->file_end;
> +            }
> +        }
> +
> +        if (s->data_end < s->file_end) {
> +            int ret =3D bdrv_truncate(bs->file, s->data_end, true,
> +                                    PREALLOC_MODE_OFF, 0, NULL);
> +            if (ret < 0) {
> +                error_setg(errp, "Failed to drop preallocation");
> +                s->file_end =3D ret;
> +                return ret;
> +            }
> +        }
> +        /*
> +         * We will drop our permissions, as well as allow shared
> +         * permissions, anyone will be able to change the child, so mark
> +         * all states invalid. We'll regain control if get good permissi=
ons
> +         * back.
> +         */
> +        s->data_end =3D s->file_end =3D s->zero_start =3D -EINVAL;

Shouldn=E2=80=99t we clear these variables whenever !can_write_resize(perm)=
, not
just if also s->data_end >=3D 0?

> +    }
> +
> +    return 0;
> +}

Max


--LXSGjkm4MaBJ7DYDH2DRe0ZajQRNyAILp--

--HoVPGF5l3ULu6BLkKUavWxrLh6XPgD9w1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl9szl8ACgkQ9AfbAGHV
z0Btmwf/b7a5E1kpkF1boKdLyWXcsgDnKjsWupNIfqxPn1PYuKzubFsqAjK3tHJe
lOJVsUc1GQX16ljBHiX/cgkj4DAuaJSwKB8zlwGidTOExzdODWzqTHGeckQzBxat
vZoKcDI4ocr6M/6rHDeJIPw5dvl5iYQ0F5Tnv02x7zUYPeDLNoXHOqVgUjF213jL
HRFsBAcTekQ4CTP89FO2j9huIoAZm008tJtbf2vjbZxDln2SwjWGkWXyX5IFREps
Iq7aZmlb9O5ihyjfP3yXrlJalLaZf8peIYRxkKaTLtZ0Jr1rTq3DO0Ndwxr750rK
F/+BfCLLAXok7Z8Gq7XqMNmDl4Fxhg==
=BSYK
-----END PGP SIGNATURE-----

--HoVPGF5l3ULu6BLkKUavWxrLh6XPgD9w1--


