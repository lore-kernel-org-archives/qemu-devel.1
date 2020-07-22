Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7E2EC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 11:07:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EE09207CD
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 11:07:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XXz0n5OS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EE09207CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46174 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyCaZ-0008Pw-PD
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 07:07:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56206)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jyCZn-0007YZ-Vh
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 07:06:19 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47696
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jyCZm-0005Rs-2d
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 07:06:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595415977;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=31GXQnWg+IOdOnXk+lIfah+I/uDHm38l5UtMeQfgqHQ=;
 b=XXz0n5OSjOjY6Bm3IrrAF6AXKq2gew7qdWJUNVuu5ldjGHigA/UPAzK8pCIgkH0lo8KQpC
 z2AtxQNPb2H5+znJV40etumnTh1mxAoeeX8CH6Pe6ixyBAmxPqzfkOLkeaX57A+4KymDvr
 zVyAOWDgXqUeZJ+AtwVYAIROBdFPMnw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-21-Vl-193fHNkK0cn0yTUvA5w-1; Wed, 22 Jul 2020 07:06:13 -0400
X-MC-Unique: Vl-193fHNkK0cn0yTUvA5w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0E3DA94016;
 Wed, 22 Jul 2020 11:06:01 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-86.ams2.redhat.com
 [10.36.113.86])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EDED65DA69;
 Wed, 22 Jul 2020 11:05:58 +0000 (UTC)
Subject: Re: [PATCH v2 07/20] block/block-copy: add ratelimit to block-copy
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20200601181118.579-1-vsementsov@virtuozzo.com>
 <20200601181118.579-8-vsementsov@virtuozzo.com>
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
Message-ID: <dc4fa418-a054-a78a-6160-57109ab27669@redhat.com>
Date: Wed, 22 Jul 2020 13:05:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200601181118.579-8-vsementsov@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="8DkamnUeKWm0YafoS2UGMzcX6kKOteu5Y"
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/22 00:40:35
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: kwolf@redhat.com, wencongyang2@huawei.com, xiechanglong.d@gmail.com,
 armbru@redhat.com, qemu-devel@nongnu.org, den@openvz.org, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8DkamnUeKWm0YafoS2UGMzcX6kKOteu5Y
Content-Type: multipart/mixed; boundary="sGyrDeEypglkSli0pUY0caBeaqpvT8WZ7"

--sGyrDeEypglkSli0pUY0caBeaqpvT8WZ7
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 01.06.20 20:11, Vladimir Sementsov-Ogievskiy wrote:
> We are going to directly use one async block-copy operation for backup
> job, so we need rate limitator.

%s/limitator/limiter/g, I think.

> We want to maintain current backup behavior: only background copying is
> limited and copy-before-write operations only participate in limit
> calculation. Therefore we need one rate limitator for block-copy state
> and boolean flag for block-copy call state for actual limitation.
>=20
> Note, that we can't just calculate each chunk in limitator after
> successful copying: it will not save us from starting a lot of async
> sub-requests which will exceed limit too much. Instead let's use the
> following scheme on sub-request creation:
> 1. If at the moment limit is not exceeded, create the request and
> account it immediately.
> 2. If at the moment limit is already exceeded, drop create sub-request
> and handle limit instead (by sleep).
> With this approach we'll never exceed the limit more than by one
> sub-request (which pretty much matches current backup behavior).

Sounds reasonable.

> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  include/block/block-copy.h |  8 +++++++
>  block/block-copy.c         | 44 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 52 insertions(+)
>=20
> diff --git a/include/block/block-copy.h b/include/block/block-copy.h
> index 600984c733..d40e691123 100644
> --- a/include/block/block-copy.h
> +++ b/include/block/block-copy.h
> @@ -59,6 +59,14 @@ BlockCopyCallState *block_copy_async(BlockCopyState *s=
,
>                                       int64_t max_chunk,
>                                       BlockCopyAsyncCallbackFunc cb);
> =20
> +/*
> + * Set speed limit for block-copy instance. All block-copy operations re=
lated to
> + * this BlockCopyState will participate in speed calculation, but only
> + * block_copy_async calls with @ratelimit=3Dtrue will be actually limite=
d.
> + */
> +void block_copy_set_speed(BlockCopyState *s, BlockCopyCallState *call_st=
ate,
> +                          uint64_t speed);
> +
>  BdrvDirtyBitmap *block_copy_dirty_bitmap(BlockCopyState *s);
>  void block_copy_set_skip_unallocated(BlockCopyState *s, bool skip);
> =20
> diff --git a/block/block-copy.c b/block/block-copy.c
> index 4114d1fd25..851d9c8aaf 100644
> --- a/block/block-copy.c
> +++ b/block/block-copy.c
> @@ -26,6 +26,7 @@
>  #define BLOCK_COPY_MAX_BUFFER (1 * MiB)
>  #define BLOCK_COPY_MAX_MEM (128 * MiB)
>  #define BLOCK_COPY_MAX_WORKERS 64
> +#define BLOCK_COPY_SLICE_TIME 100000000ULL /* ns */
> =20
>  static coroutine_fn int block_copy_task_entry(AioTask *task);
> =20
> @@ -36,11 +37,13 @@ typedef struct BlockCopyCallState {
>      int64_t bytes;
>      int max_workers;
>      int64_t max_chunk;
> +    bool ratelimit;
>      BlockCopyAsyncCallbackFunc cb;
> =20
>      /* State */
>      bool failed;
>      bool finished;
> +    QemuCoSleepState *sleep_state;
> =20
>      /* OUT parameters */
>      bool error_is_read;
> @@ -103,6 +106,9 @@ typedef struct BlockCopyState {
>      void *progress_opaque;
> =20
>      SharedResource *mem;
> +
> +    uint64_t speed;
> +    RateLimit rate_limit;
>  } BlockCopyState;
> =20
>  static BlockCopyTask *find_conflicting_task(BlockCopyState *s,
> @@ -611,6 +617,21 @@ block_copy_dirty_clusters(BlockCopyCallState *call_s=
tate)
>          }
>          task->zeroes =3D ret & BDRV_BLOCK_ZERO;
> =20
> +        if (s->speed) {
> +            if (call_state->ratelimit) {
> +                uint64_t ns =3D ratelimit_calculate_delay(&s->rate_limit=
, 0);
> +                if (ns > 0) {
> +                    block_copy_task_end(task, -EAGAIN);
> +                    g_free(task);
> +                    qemu_co_sleep_ns_wakeable(QEMU_CLOCK_REALTIME, ns,
> +                                              &call_state->sleep_state);
> +                    continue;
> +                }
> +            }
> +
> +            ratelimit_calculate_delay(&s->rate_limit, task->bytes);
> +        }
> +

Looks good.

>          trace_block_copy_process(s, task->offset);
> =20
>          co_get_from_shres(s->mem, task->bytes);
> @@ -649,6 +670,13 @@ out:
>      return ret < 0 ? ret : found_dirty;
>  }
> =20
> +static void block_copy_kick(BlockCopyCallState *call_state)
> +{
> +    if (call_state->sleep_state) {
> +        qemu_co_sleep_wake(call_state->sleep_state);
> +    }
> +}
> +
>  /*
>   * block_copy_common
>   *
> @@ -729,6 +757,7 @@ BlockCopyCallState *block_copy_async(BlockCopyState *=
s,
>          .s =3D s,
>          .offset =3D offset,
>          .bytes =3D bytes,
> +        .ratelimit =3D ratelimit,

Hm, same problem/question as in patch 6: Should the @ratelimit parameter
really be added in patch 5 if it=E2=80=99s used only now?

>          .cb =3D cb,
>          .max_workers =3D max_workers ?: BLOCK_COPY_MAX_WORKERS,
>          .max_chunk =3D max_chunk,
> @@ -752,3 +781,18 @@ void block_copy_set_skip_unallocated(BlockCopyState =
*s, bool skip)
>  {
>      s->skip_unallocated =3D skip;
>  }
> +
> +void block_copy_set_speed(BlockCopyState *s, BlockCopyCallState *call_st=
ate,
> +                          uint64_t speed)
> +{
> +    uint64_t old_speed =3D s->speed;
> +
> +    s->speed =3D speed;
> +    if (speed > 0) {
> +        ratelimit_set_speed(&s->rate_limit, speed, BLOCK_COPY_SLICE_TIME=
);
> +    }
> +
> +    if (call_state && old_speed && (speed > old_speed || speed =3D=3D 0)=
) {
> +        block_copy_kick(call_state);
> +    }
> +}

Hm.  I=E2=80=99m interested in seeing how this is going to be used, i.e. wh=
at
callers will pass for @call_state.  I suppose it=E2=80=99s going to be the
background operation for the whole device, but I wonder whether it
actually makes sense to pass it.  I mean, the caller could just call
block_copy_kick() itself (unconditionally, because it=E2=80=99ll never hurt=
, I
think).


--sGyrDeEypglkSli0pUY0caBeaqpvT8WZ7--

--8DkamnUeKWm0YafoS2UGMzcX6kKOteu5Y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl8YHZUACgkQ9AfbAGHV
z0CHzQgAuBI7100gjFT6O0TYGTqf2HT+EEU/9eB7W/nyICsDjpNA4rdXbbrHJDRn
iVEO6vZ9ftyG2Fi90VU7qLgy7Eh7FDQaSC2o8tCgXRtdu6004WMZNNugwg7bwG6L
z+WTNVnxfR/FLP9qRN/0Q6JOGlpyK4bhckUny2H1Ig7O4v6q/wA2uwgk9rlbGmjj
qIyhLPEOhnmqP0ObqJfzOztZAgF3XKb4rwm0esgaPHU95MFVHwERXaZ3jbvv3Id7
L89Z38sA2TlqYHYFCkPATv7L19gMzyK2GlUTbbBrlCKkOODx2XO6oYFKBvq3fyuM
ZZUjrimPhxBa71HaA1Zxgo/5UuXULw==
=9Y7J
-----END PGP SIGNATURE-----

--8DkamnUeKWm0YafoS2UGMzcX6kKOteu5Y--


