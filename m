Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2C2BC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 09:52:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6994920714
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 09:52:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EAPX/yp5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6994920714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59986 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyBQB-0008Mg-KW
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 05:52:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59232)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jyBDn-0000zD-I0
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 05:39:31 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27214
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jyBDl-0000In-HV
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 05:39:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595410768;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=AX8zRKCi4pKNwzNVqYofsECCyUfuuSYKa6NsErayM9w=;
 b=EAPX/yp5Rvh14GR1cii4x+svzUkXYsuiEG1gdWxlDNmNrSxe/F/7ixAt13Logu+LRTMC+t
 V/NI+7tv1iSSBdTaoYse19vxzDW+lYs9ksMyEiSH5VZ0QZXcxyB81iUuQig/1mMufP/VdC
 6nTg30awIhcoBN6RpRvAyibN5vNoNCM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-277-kerY-8oWOTSPPPmrBk6Qsg-1; Wed, 22 Jul 2020 05:39:25 -0400
X-MC-Unique: kerY-8oWOTSPPPmrBk6Qsg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 26FBFE918;
 Wed, 22 Jul 2020 09:39:24 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-86.ams2.redhat.com
 [10.36.113.86])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E501774F58;
 Wed, 22 Jul 2020 09:39:21 +0000 (UTC)
Subject: Re: [PATCH v2 06/20] block/block-copy: add max_chunk and max_workers
 parameters
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20200601181118.579-1-vsementsov@virtuozzo.com>
 <20200601181118.579-7-vsementsov@virtuozzo.com>
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
Message-ID: <fa0c148f-5200-8624-b3a1-9f4ec77691f0@redhat.com>
Date: Wed, 22 Jul 2020 11:39:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200601181118.579-7-vsementsov@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="L6iObLm0kQJOB49LN7tZs6tDurGEQ85t8"
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
--L6iObLm0kQJOB49LN7tZs6tDurGEQ85t8
Content-Type: multipart/mixed; boundary="UWdXdBiGKCJSupEmI72www5gVaw3aEcU6"

--UWdXdBiGKCJSupEmI72www5gVaw3aEcU6
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 01.06.20 20:11, Vladimir Sementsov-Ogievskiy wrote:
> They will be used for backup.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  include/block/block-copy.h |  5 +++++
>  block/block-copy.c         | 10 ++++++++--
>  2 files changed, 13 insertions(+), 2 deletions(-)
>=20
> diff --git a/include/block/block-copy.h b/include/block/block-copy.h
> index ada0d99566..600984c733 100644
> --- a/include/block/block-copy.h
> +++ b/include/block/block-copy.h
> @@ -47,6 +47,11 @@ int coroutine_fn block_copy(BlockCopyState *s, int64_t=
 offset, int64_t bytes,
>  /*
>   * Run block-copy in a coroutine, return state pointer. If finished earl=
y
>   * returns NULL (@cb is called anyway).
> + *
> + * @max_workers means maximum of parallel coroutines to execute sub-requ=
ests,
> + * must be > 0.
> + *
> + * @max_chunk means maximum length for one IO operation. Zero means unli=
mited.
>   */
>  BlockCopyCallState *block_copy_async(BlockCopyState *s,
>                                       int64_t offset, int64_t bytes,

I only just now notice that @max_workers and @max_chunk were already
added in the previous patch, even though they aren=E2=80=99t used there.  S=
hould
we defer adding them until this patch?

> diff --git a/block/block-copy.c b/block/block-copy.c
> index a0477d90f3..4114d1fd25 100644
> --- a/block/block-copy.c
> +++ b/block/block-copy.c
> @@ -34,6 +34,8 @@ typedef struct BlockCopyCallState {
>      BlockCopyState *s;
>      int64_t offset;
>      int64_t bytes;
> +    int max_workers;
> +    int64_t max_chunk;
>      BlockCopyAsyncCallbackFunc cb;
> =20
>      /* State */
> @@ -144,10 +146,11 @@ static BlockCopyTask *block_copy_task_create(BlockC=
opyState *s,
>                                               int64_t offset, int64_t byt=
es)
>  {
>      BlockCopyTask *task;
> +    int64_t max_chunk =3D MIN_NON_ZERO(s->copy_size, call_state->max_chu=
nk);
> =20
>      if (!bdrv_dirty_bitmap_next_dirty_area(s->copy_bitmap,
>                                             offset, offset + bytes,
> -                                           s->copy_size, &offset, &bytes=
))
> +                                           max_chunk, &offset, &bytes))
>      {
>          return NULL;
>      }
> @@ -616,7 +619,7 @@ block_copy_dirty_clusters(BlockCopyCallState *call_st=
ate)
>          bytes =3D end - offset;
> =20
>          if (!aio && bytes) {
> -            aio =3D aio_task_pool_new(BLOCK_COPY_MAX_WORKERS);
> +            aio =3D aio_task_pool_new(call_state->max_workers);
>          }
> =20
>          ret =3D block_copy_task_run(aio, task);
> @@ -695,6 +698,7 @@ int coroutine_fn block_copy(BlockCopyState *s, int64_=
t start, int64_t bytes,
>          .s =3D s,
>          .offset =3D start,
>          .bytes =3D bytes,
> +        .max_workers =3D BLOCK_COPY_MAX_WORKERS,
>      };
> =20
>      int ret =3D block_copy_common(&call_state);
> @@ -726,6 +730,8 @@ BlockCopyCallState *block_copy_async(BlockCopyState *=
s,
>          .offset =3D offset,
>          .bytes =3D bytes,
>          .cb =3D cb,
> +        .max_workers =3D max_workers ?: BLOCK_COPY_MAX_WORKERS,

I thought this must be > 0?

> +        .max_chunk =3D max_chunk,
>      };
> =20
>      qemu_coroutine_enter(co);
>=20

And I now notice that there=E2=80=99s no newline after block_copy_async().
(Doesn=E2=80=99t concern this patch, of course, but the previous one.)

Max


--UWdXdBiGKCJSupEmI72www5gVaw3aEcU6--

--L6iObLm0kQJOB49LN7tZs6tDurGEQ85t8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl8YCUgACgkQ9AfbAGHV
z0Bd9wf/W4D1Nt5Mt1EI9fbvY5Vv051czX0qTStIbliw5KvOUPMV50J53TO9FtMY
5IELWIBt5KnQ5LYAiqV6PkrNqI40nc0fVVyhi+Ujfkrli4s5BfnqbYrnGgdF4eTC
ayox9yDCVbIz0vNvc3vVLsnTAQ+KobpOluxyo+3OCWp327IWWyNpzQOtnTYb1fLU
dQiO/MTM1chltuZpodx+HEgcj/l0QXk9tVX3KvvMoipW2gSacTJLzV0DeYMJlPeL
kITNeelacTBNq4Qs3s6WIWavbU2J40Od3hKy8N1CIKjS0KaJ3Q7BGT29gSzBlYtQ
Obb4IvbjdcTNSxltsgJjoWNdW9pKhw==
=WWDX
-----END PGP SIGNATURE-----

--L6iObLm0kQJOB49LN7tZs6tDurGEQ85t8--


