Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B71AC34022
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 13:39:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 461DF2070B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 13:39:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X1qJfoEa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 461DF2070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45682 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3gc2-0000Z7-DK
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 08:39:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55697)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1j3gbR-00005A-Sf
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 08:38:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1j3gbP-0006V6-NP
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 08:38:25 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58492
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1j3gbP-0006Un-Fo
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 08:38:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581946703;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=9F6OiM6MSA8BSRBdB37uL5itdELeiaYrEHveuBvWbkk=;
 b=X1qJfoEaUhtvFMJ0SHsUPt6besyu5Jk//fqVGAddF88S7cPIm5rlFTMZlmON2AryegSFwp
 p6Isxh3o4ND8DQjnW2nSsWg1FfvhhHz5AD0HnJhWw0Rhq88nIwYYajtXX8yPz/+e0EkCzY
 t0B1Yzn7BXig9Xwxv+3ImyWWoYmp+lU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-380-1FS2y8FzPSmGFQF9bih8_g-1; Mon, 17 Feb 2020 08:38:20 -0500
X-MC-Unique: 1FS2y8FzPSmGFQF9bih8_g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 63FED190D342;
 Mon, 17 Feb 2020 13:38:19 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-191.ams2.redhat.com
 [10.36.117.191])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DDB2690F46;
 Mon, 17 Feb 2020 13:38:16 +0000 (UTC)
Subject: Re: [PATCH v2 6/7] block/block-copy: reduce intersecting request lock
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20191127180840.11937-1-vsementsov@virtuozzo.com>
 <20191127180840.11937-7-vsementsov@virtuozzo.com>
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
Message-ID: <1ae71183-4732-fbe6-62d5-58252f01d2d6@redhat.com>
Date: Mon, 17 Feb 2020 14:38:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20191127180840.11937-7-vsementsov@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Pig3rD2Fwdlgjmma0N3m5fxiMEufkT1HU"
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
Cc: kwolf@redhat.com, den@openvz.org, jsnow@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Pig3rD2Fwdlgjmma0N3m5fxiMEufkT1HU
Content-Type: multipart/mixed; boundary="lauBJQGzbz3VkGgJaAgO8Dois5TQRdw5x"

--lauBJQGzbz3VkGgJaAgO8Dois5TQRdw5x
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 27.11.19 19:08, Vladimir Sementsov-Ogievskiy wrote:
> Currently, block_copy operation lock the whole requested region. But
> there is no reason to lock clusters, which are already copied, it will
> disturb other parallel block_copy requests for no reason.
>=20
> Let's instead do the following:
>=20
> Lock only sub-region, which we are going to operate on. Then, after
> copying all dirty sub-regions, we should wait for intersecting
> requests block-copy, if they failed, we should retry these new dirty
> clusters.

Just a thought spoken aloud:

I would expect the number of intersecting CBW requests to be low in
general, so I don=92t know how useful this change is in practice.  OTOH,
it makes block_copy call the existing implementation in a loop, which
seems just worse.

But then again, in the common case, block_copy_dirty_clusters() won=92t
copy anything because it=92s all been copied already, so there is no
change; and even if something is copied, the second call will just
re-check the dirty bitmap to see that the area=92s clean (which will be
quick compared to the copy operation).  So there=92s probably nothing to
worry about.

> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/block-copy.c | 116 +++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 95 insertions(+), 21 deletions(-)
>=20
> diff --git a/block/block-copy.c b/block/block-copy.c
> index 20068cd699..aca44b13fb 100644
> --- a/block/block-copy.c
> +++ b/block/block-copy.c
> @@ -39,29 +39,62 @@ static BlockCopyInFlightReq *block_copy_find_inflight=
_req(BlockCopyState *s,
>      return NULL;
>  }
> =20
> -static void coroutine_fn block_copy_wait_inflight_reqs(BlockCopyState *s=
,
> -                                                       int64_t offset,
> -                                                       int64_t bytes)
> +/*
> + * If there are no intersecting requests return false. Otherwise, wait f=
or the
> + * first found intersecting request to finish and return true.
> + */
> +static bool coroutine_fn block_copy_wait_one(BlockCopyState *s, int64_t =
start,
> +                                             int64_t end)

s/end/bytes/?

(And maybe s/start/offset/, too)

>  {
> -    BlockCopyInFlightReq *req;
> +    BlockCopyInFlightReq *req =3D block_copy_find_inflight_req(s, start,=
 end);
> =20
> -    while ((req =3D block_copy_find_inflight_req(s, offset, bytes))) {
> -        qemu_co_queue_wait(&req->wait_queue, NULL);
> +    if (!req) {
> +        return false;
>      }
> +
> +    qemu_co_queue_wait(&req->wait_queue, NULL);
> +
> +    return true;
>  }
> =20
> +/* Called only on full-dirty region */
>  static void block_copy_inflight_req_begin(BlockCopyState *s,
>                                            BlockCopyInFlightReq *req,
>                                            int64_t offset, int64_t bytes)
>  {
> +    assert(!block_copy_find_inflight_req(s, offset, bytes));
> +
> +    bdrv_reset_dirty_bitmap(s->copy_bitmap, offset, bytes);
> +
>      req->offset =3D offset;
>      req->bytes =3D bytes;
>      qemu_co_queue_init(&req->wait_queue);
>      QLIST_INSERT_HEAD(&s->inflight_reqs, req, list);
>  }
> =20
> -static void coroutine_fn block_copy_inflight_req_end(BlockCopyInFlightRe=
q *req)
> +static void coroutine_fn block_copy_inflight_req_shrink(BlockCopyState *=
s,
> +        BlockCopyInFlightReq *req, int64_t new_bytes)

It took me a while to understand that this is operation drops the tail
of the request.  I think there should be a comment on this.

(I thought it would successively drop the head after each copy, and so I
was wondering why the code didn=92t match that.)

>  {
> +    if (new_bytes =3D=3D req->bytes) {
> +        return;
> +    }
> +
> +    assert(new_bytes > 0 && new_bytes < req->bytes);
> +
> +    bdrv_set_dirty_bitmap(s->copy_bitmap,
> +                          req->offset + new_bytes, req->bytes - new_byte=
s);> +
> +    req->bytes =3D new_bytes;
> +    qemu_co_queue_restart_all(&req->wait_queue);
> +}
> +
> +static void coroutine_fn block_copy_inflight_req_end(BlockCopyState *s,
> +                                                     BlockCopyInFlightRe=
q *req,
> +                                                     int ret)
> +{
> +    if (ret < 0) {
> +        bdrv_set_dirty_bitmap(s->copy_bitmap, req->offset, req->bytes);
> +    }
>      QLIST_REMOVE(req, list);
>      qemu_co_queue_restart_all(&req->wait_queue);
>  }
> @@ -344,12 +377,19 @@ int64_t block_copy_reset_unallocated(BlockCopyState=
 *s,
>      return ret;
>  }
> =20
> -int coroutine_fn block_copy(BlockCopyState *s,
> -                            int64_t offset, uint64_t bytes,
> -                            bool *error_is_read)
> +/*
> + * block_copy_dirty_clusters
> + *
> + * Copy dirty clusters in @start/@bytes range.
> + * Returns 1 if dirty clusters found and successfully copied, 0 if no di=
rty
> + * clusters found and -errno on failure.
> + */
> +static int coroutine_fn block_copy_dirty_clusters(BlockCopyState *s,
> +                                                  int64_t offset, int64_=
t bytes,
> +                                                  bool *error_is_read)
>  {
>      int ret =3D 0;
> -    BlockCopyInFlightReq req;
> +    bool found_dirty =3D false;
> =20
>      /*
>       * block_copy() user is responsible for keeping source and target in=
 same
> @@ -361,10 +401,8 @@ int coroutine_fn block_copy(BlockCopyState *s,
>      assert(QEMU_IS_ALIGNED(offset, s->cluster_size));
>      assert(QEMU_IS_ALIGNED(bytes, s->cluster_size));
> =20
> -    block_copy_wait_inflight_reqs(s, offset, bytes);
> -    block_copy_inflight_req_begin(s, &req, offset, bytes);
> -
>      while (bytes) {
> +        BlockCopyInFlightReq req;
>          int64_t next_zero, cur_bytes, status_bytes;
> =20
>          if (!bdrv_dirty_bitmap_get(s->copy_bitmap, offset)) {
> @@ -374,6 +412,8 @@ int coroutine_fn block_copy(BlockCopyState *s,
>              continue; /* already copied */
>          }
> =20
> +        found_dirty =3D true;
> +
>          cur_bytes =3D MIN(bytes, s->copy_size);
> =20
>          next_zero =3D bdrv_dirty_bitmap_next_zero(s->copy_bitmap, offset=
,
> @@ -383,10 +423,12 @@ int coroutine_fn block_copy(BlockCopyState *s,
>              assert(next_zero < offset + cur_bytes); /* no need to do MIN=
() */
>              cur_bytes =3D next_zero - offset;
>          }
> +        block_copy_inflight_req_begin(s, &req, offset, cur_bytes);
> =20
>          ret =3D block_copy_block_status(s, offset, cur_bytes, &status_by=
tes);
> +        block_copy_inflight_req_shrink(s, &req, status_bytes);

block_copy_inflight_req_shrink() asserts that status_bytes <=3D cur_bytes.
 That isn=92t necessarily correct, as block_copy_block_status() rounds up
on the last cluster.  So this should use the same MIN() as for the
cur_bytes update after the next block.

Would it make sense to move the block_copy_inflight_req_shrink() there
and pass the updated cur_bytes to it?

>          if (s->skip_unallocated && !(ret & BDRV_BLOCK_ALLOCATED)) {
> -            bdrv_reset_dirty_bitmap(s->copy_bitmap, offset, status_bytes=
);
> +            block_copy_inflight_req_end(s, &req, 0);
>              s->progress_reset_callback(s->progress_opaque);
>              trace_block_copy_skip_range(s, offset, status_bytes);
>              offset +=3D status_bytes;
> @@ -398,15 +440,13 @@ int coroutine_fn block_copy(BlockCopyState *s,
> =20
>          trace_block_copy_process(s, offset);
> =20
> -        bdrv_reset_dirty_bitmap(s->copy_bitmap, offset, cur_bytes);
> -
>          co_get_from_shres(s->mem, cur_bytes);
>          ret =3D block_copy_do_copy(s, offset, cur_bytes, ret & BDRV_BLOC=
K_ZERO,
>                                   error_is_read);
>          co_put_to_shres(s->mem, cur_bytes);
> +        block_copy_inflight_req_end(s, &req, ret);
>          if (ret < 0) {
> -            bdrv_set_dirty_bitmap(s->copy_bitmap, offset, cur_bytes);
> -            break;
> +            return ret;
>          }
> =20
>          s->progress_bytes_callback(cur_bytes, s->progress_opaque);
> @@ -414,7 +454,41 @@ int coroutine_fn block_copy(BlockCopyState *s,
>          bytes -=3D cur_bytes;
>      }
> =20
> -    block_copy_inflight_req_end(&req);
> +    return found_dirty;
> +}
> =20
> -    return ret;
> +int coroutine_fn block_copy(BlockCopyState *s, int64_t start, uint64_t b=
ytes,
> +                            bool *error_is_read)
> +{
> +    while (true) {
> +        int ret =3D block_copy_dirty_clusters(s, start, bytes, error_is_=
read);
> +
> +        if (ret < 0) {
> +            /*
> +             * IO operation failed, which means the whole block_copy req=
uest
> +             * failed.
> +             */
> +            return ret;
> +        }
> +        if (ret) {
> +            /*
> +             * Something was copied, which means that there were yield p=
oints
> +             * and some new dirty bits may appered (due to failed parall=
el

s/appered/have appeared/

> +             * block-copy requests).
> +             */
> +            continue;
> +        }
> +
> +        /*
> +         * Here ret =3D=3D 0, which means that there is no dirty cluster=
s in
> +         * requested region.
> +         */
> +
> +        if (!block_copy_wait_one(s, start, bytes)) {
> +            /* No dirty bits and nothing to wait: the whole request is d=
one */

Wouldn=92t it make more sense to keep block_copy_wait_one() a loop (i.e.,
keep it as block_copy_wait_inflight_reqs()) that returns whether it
waited or not?  Because I suppose if we had to wait for anything, we
might as well wait for everything in the range.

> +            break;
> +        }
> +    }

Continuing my loud thought from the beginning, I would have written this
as a tail-recursive function to stress that this isn=92t really a
(potentially expensive) loop but more of a re-check to be sure.

(i.e.

int ret =3D block_copy_dirty...();
if (ret < 0) {
    return ret;
}

if (ret || block_copy_wait_one()) {
    /* Something might have changed, re-check */
    return block_copy();
}

/* Done */
return 0;
)

But who cares.

Max

> +
> +    return 0;
>  }
>=20



--lauBJQGzbz3VkGgJaAgO8Dois5TQRdw5x--

--Pig3rD2Fwdlgjmma0N3m5fxiMEufkT1HU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl5Kl0YACgkQ9AfbAGHV
z0D2zwf8DcT+HwTztmLR7FQ8KZM/6GCIKnyHDjg4bLQgbBxty9YeBrLG0B7/Cw4k
E3q/0zpvAXhXkEL3NMXHh7favrgK+Ou7D+BNRSp+f8NOsFB/AcsKNCEKtoIqmAKW
0/xRzSXQD6YiadfFCOiedlDyO1pi6Kp4PATqisheWOgeKOhdwtdGFjS/lPXdeGOr
LSfCwucGErvh/wvItt/8K+rSLZC1Xjqf0qBYrIRM8/NfooBBiLgRvqNilzCXTUTR
NaqmlbmTVQXOf9Uk7HPimgifQWqz7qbf0I2+wCqoI0CnsQBibovFf/3hR47NQHEO
cmOrTfhAom1E2/0tN5RtEGpZy9QyWQ==
=/SCl
-----END PGP SIGNATURE-----

--Pig3rD2Fwdlgjmma0N3m5fxiMEufkT1HU--


