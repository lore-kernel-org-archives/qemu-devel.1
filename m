Return-Path: <SRS0=LOIU=A4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10C1AC433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 14:01:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB63122CA0
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 14:01:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Noo+bZTD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB63122CA0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33994 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwQvf-0002Sh-0U
	for qemu-devel@archiver.kernel.org; Fri, 17 Jul 2020 10:01:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43678)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jwQub-0001q2-96
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 10:00:29 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59608
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jwQuZ-000433-NA
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 10:00:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594994426;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=8sj+n3v+dgJ0qiRHpdzmC25k5qn+hKhmyiopiT1jk8E=;
 b=Noo+bZTDNaGJSBrwFocISaZnOISLIc5mYSSbeokQHwQ4c8H4IJB3CfPIs8kV5eFOy+sC0C
 bx3smUBx6/IQ35a2BS71a2xcFz52V+kAcXc0Pfct1iDDS59bWG+IOYyCTZIbjf7E14oyRw
 g3HfwMEg42XCbx2lJ03/mCHDfMVj4po=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-208-b4etkOE_P6Kj5oBbbNYxdA-1; Fri, 17 Jul 2020 10:00:22 -0400
X-MC-Unique: b4etkOE_P6Kj5oBbbNYxdA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ED1F7100CCC0;
 Fri, 17 Jul 2020 14:00:20 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-123.ams2.redhat.com
 [10.36.113.123])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 645F970104;
 Fri, 17 Jul 2020 14:00:05 +0000 (UTC)
Subject: Re: [PATCH v2 05/20] block/block-copy: implement block_copy_async
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20200601181118.579-1-vsementsov@virtuozzo.com>
 <20200601181118.579-6-vsementsov@virtuozzo.com>
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
Message-ID: <90825bab-19d1-466f-4fd4-adf76f1010b1@redhat.com>
Date: Fri, 17 Jul 2020 16:00:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200601181118.579-6-vsementsov@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="rdT7P8Pb9hpmtcNNQ4AI1DdaxG0suCZey"
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/16 23:13:19
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
Cc: kwolf@redhat.com, wencongyang2@huawei.com, xiechanglong.d@gmail.com,
 armbru@redhat.com, qemu-devel@nongnu.org, den@openvz.org, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--rdT7P8Pb9hpmtcNNQ4AI1DdaxG0suCZey
Content-Type: multipart/mixed; boundary="8C90YjtfxresFvYBoeNPQY6ws9RidQ1wK"

--8C90YjtfxresFvYBoeNPQY6ws9RidQ1wK
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 01.06.20 20:11, Vladimir Sementsov-Ogievskiy wrote:
> We'll need async block-copy invocation to use in backup directly.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  include/block/block-copy.h | 13 +++++++++++++
>  block/block-copy.c         | 40 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 53 insertions(+)
>=20
> diff --git a/include/block/block-copy.h b/include/block/block-copy.h
> index 6397505f30..ada0d99566 100644
> --- a/include/block/block-copy.h
> +++ b/include/block/block-copy.h
> @@ -19,7 +19,10 @@
>  #include "qemu/co-shared-resource.h"
> =20
>  typedef void (*ProgressBytesCallbackFunc)(int64_t bytes, void *opaque);
> +typedef void (*BlockCopyAsyncCallbackFunc)(int ret, bool error_is_read,
> +                                           void *opaque);
>  typedef struct BlockCopyState BlockCopyState;
> +typedef struct BlockCopyCallState BlockCopyCallState;
> =20
>  BlockCopyState *block_copy_state_new(BdrvChild *source, BdrvChild *targe=
t,
>                                       int64_t cluster_size, bool use_copy=
_range,
> @@ -41,6 +44,16 @@ int64_t block_copy_reset_unallocated(BlockCopyState *s=
,
>  int coroutine_fn block_copy(BlockCopyState *s, int64_t offset, int64_t b=
ytes,
>                              bool *error_is_read);
> =20
> +/*
> + * Run block-copy in a coroutine, return state pointer. If finished earl=
y
> + * returns NULL (@cb is called anyway).

Any special reason for doing so?  Seems like the code would be a tad
simpler if we just returned it either way.  (And off the top of my head
I=E2=80=99d guess it=E2=80=99d be easier for the caller if the returned val=
ue was always
non-NULL, too.)

> + */
> +BlockCopyCallState *block_copy_async(BlockCopyState *s,
> +                                     int64_t offset, int64_t bytes,
> +                                     bool ratelimit, int max_workers,
> +                                     int64_t max_chunk,
> +                                     BlockCopyAsyncCallbackFunc cb);
> +
>  BdrvDirtyBitmap *block_copy_dirty_bitmap(BlockCopyState *s);
>  void block_copy_set_skip_unallocated(BlockCopyState *s, bool skip);
> =20
> diff --git a/block/block-copy.c b/block/block-copy.c
> index 75882a094c..a0477d90f3 100644
> --- a/block/block-copy.c
> +++ b/block/block-copy.c
> @@ -34,9 +34,11 @@ typedef struct BlockCopyCallState {
>      BlockCopyState *s;
>      int64_t offset;
>      int64_t bytes;
> +    BlockCopyAsyncCallbackFunc cb;
> =20
>      /* State */
>      bool failed;
> +    bool finished;
> =20
>      /* OUT parameters */
>      bool error_is_read;
> @@ -676,6 +678,13 @@ static int coroutine_fn block_copy_common(BlockCopyC=
allState *call_state)
>           */
>      } while (ret > 0);
> =20
> +    if (call_state->cb) {
> +        call_state->cb(ret, call_state->error_is_read,
> +                       call_state->s->progress_opaque);

I find it weird to pass progress_opaque here.  Shouldn=E2=80=99t we just ha=
ve a
dedicated opaque object for this CB?

> +    }
> +
> +    call_state->finished =3D true;
> +
>      return ret;
>  }
> =20
> @@ -697,6 +706,37 @@ int coroutine_fn block_copy(BlockCopyState *s, int64=
_t start, int64_t bytes,
>      return ret;
>  }
> =20
> +static void coroutine_fn block_copy_async_co_entry(void *opaque)
> +{
> +    block_copy_common(opaque);
> +}
> +
> +BlockCopyCallState *block_copy_async(BlockCopyState *s,
> +                                     int64_t offset, int64_t bytes,
> +                                     bool ratelimit, int max_workers,
> +                                     int64_t max_chunk,
> +                                     BlockCopyAsyncCallbackFunc cb)
> +{
> +    BlockCopyCallState *call_state =3D g_new(BlockCopyCallState, 1);
> +    Coroutine *co =3D qemu_coroutine_create(block_copy_async_co_entry,
> +                                          call_state);
> +
> +    *call_state =3D (BlockCopyCallState) {
> +        .s =3D s,
> +        .offset =3D offset,
> +        .bytes =3D bytes,
> +        .cb =3D cb,
> +    };
> +
> +    qemu_coroutine_enter(co);

Do we need/want any already-in-coroutine shenanigans here?

Max

> +
> +    if (call_state->finished) {
> +        g_free(call_state);
> +        return NULL;
> +    }
> +
> +    return call_state;
> +}
>  BdrvDirtyBitmap *block_copy_dirty_bitmap(BlockCopyState *s)
>  {
>      return s->copy_bitmap;
>=20



--8C90YjtfxresFvYBoeNPQY6ws9RidQ1wK--

--rdT7P8Pb9hpmtcNNQ4AI1DdaxG0suCZey
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl8RruMACgkQ9AfbAGHV
z0DNdQf/WWPI82HTPnhmluCXwE52rpuD2HdN5Tk9/2gLWjDnMRjZ/EFKp99u+ClN
Sbv5F8oWhCw4EPeFSyIIKfmZz5oaakPYKf7Gp1MGtgs3rXjO5Z6OnT7IIBloXJWf
tTeyQwWjL3EMqgwFqCdT793yp/s4e5ZGMOqourYblYyCPNgXKnygou28kUK1Eybu
J7kjBnE1CY0qMTmfpNpWw5v1CtU4bRmfrwBEjg1Rq4O5pqaKw5nyBSjs7s5asTDE
iasyPwNDSzyB7umIsTbiZ+QG5drV6FEC8IUmVNi0xYUARR7I8mcVNqnhd/TvDXxf
NVunG2sjXEhQi5rwf2wMpm/L12nDiA==
=lYU0
-----END PGP SIGNATURE-----

--rdT7P8Pb9hpmtcNNQ4AI1DdaxG0suCZey--


