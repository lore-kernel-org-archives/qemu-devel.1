Return-Path: <SRS0=LOIU=A4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4A16C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 13:47:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 696612076D
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 13:47:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aa9h+m6c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 696612076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43486 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwQhY-00020m-N4
	for qemu-devel@archiver.kernel.org; Fri, 17 Jul 2020 09:47:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38636)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jwQgd-0001Im-QN
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 09:46:03 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:60892
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jwQgc-00014Z-3N
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 09:46:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594993561;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=MScvuX8/XxG4xemulmgmgqaL0b/rE1PsIiFJ4qsQVS0=;
 b=aa9h+m6cmVc70HmgTW8jBpEIZxoCEmYeOEOR3ne0Re3Qu/dscs4m3kJHbN/+/nvrJ2D/Bq
 V+n8cO+suAvIWf5VaUrjxBq9+vXPkYzBy6us9mPmi8E2e/kJFn+pHyilsAd5bi+bS8vVlR
 15z/zVZOhJXXeeyxqP5rb7sXpQeTtjo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-112-D4VE-tcsP5GO2ZXef8M_0w-1; Fri, 17 Jul 2020 09:45:57 -0400
X-MC-Unique: D4VE-tcsP5GO2ZXef8M_0w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2458A801E6A;
 Fri, 17 Jul 2020 13:45:56 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-123.ams2.redhat.com
 [10.36.113.123])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BDE0010013C0;
 Fri, 17 Jul 2020 13:45:53 +0000 (UTC)
Subject: Re: [PATCH v2 04/20] block/block-copy: More explicit call_state
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20200601181118.579-1-vsementsov@virtuozzo.com>
 <20200601181118.579-5-vsementsov@virtuozzo.com>
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
Message-ID: <e0e8a810-814d-eb1c-21a7-4469451311e2@redhat.com>
Date: Fri, 17 Jul 2020 15:45:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200601181118.579-5-vsementsov@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="BWcBR5tAtlqJh3E0agxh3OnF6MPdoeZCt"
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/17 01:33:03
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
--BWcBR5tAtlqJh3E0agxh3OnF6MPdoeZCt
Content-Type: multipart/mixed; boundary="LW9HEINQEuVMyiSCWuoOZmhSDSv80ZoxK"

--LW9HEINQEuVMyiSCWuoOZmhSDSv80ZoxK
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 01.06.20 20:11, Vladimir Sementsov-Ogievskiy wrote:
> Refactor common path to use BlockCopyCallState pointer as parameter, to
> prepare it for use in asynchronous block-copy (at least, we'll need to
> run block-copy in a coroutine, passing the whole parameters as one
> pointer).
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/block-copy.c | 51 ++++++++++++++++++++++++++++++++++------------
>  1 file changed, 38 insertions(+), 13 deletions(-)
>=20
> diff --git a/block/block-copy.c b/block/block-copy.c
> index 43a018d190..75882a094c 100644
> --- a/block/block-copy.c
> +++ b/block/block-copy.c

[...]

> @@ -646,16 +653,16 @@ out:
>   * it means that some I/O operation failed in context of _this_ block_co=
py call,
>   * not some parallel operation.
>   */
> -int coroutine_fn block_copy(BlockCopyState *s, int64_t offset, int64_t b=
ytes,
> -                            bool *error_is_read)
> +static int coroutine_fn block_copy_common(BlockCopyCallState *call_state=
)
>  {
>      int ret;
> =20
>      do {
> -        ret =3D block_copy_dirty_clusters(s, offset, bytes, error_is_rea=
d);
> +        ret =3D block_copy_dirty_clusters(call_state);

It=E2=80=99s possible that much of this code will change in a future patch =
of
this series, but as it is, it might be nice to make
block_copy_dirty_clusters=E2=80=99s argument a const pointer so it=E2=80=99=
s clear that
the call to block_copy_wait_one() below will use the original @offset
and @bytes values.

*shrug*

Reviewed-by: Max Reitz <mreitz@redhat.com>

> =20
>          if (ret =3D=3D 0) {
> -            ret =3D block_copy_wait_one(s, offset, bytes);
> +            ret =3D block_copy_wait_one(call_state->s, call_state->offse=
t,
> +                                      call_state->bytes);
>          }
> =20
>          /*


--LW9HEINQEuVMyiSCWuoOZmhSDSv80ZoxK--

--BWcBR5tAtlqJh3E0agxh3OnF6MPdoeZCt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl8Rq5AACgkQ9AfbAGHV
z0Cl6AgAwFLpvvib1DY4MCXfJw6SN1dyJvJXrMImkWlPT4+6Goi67m+RbbKXtivb
z3cK6LJgxyZ8KPRw5a/H6Kx6BT9CFS3EC4+JWFKGRQ6BbOHlE2UkYwJkOGIDNQHT
LbLqNYtO6Ag7L8ipk6o8c2yUn5q+MPL1No68qsNRokwMwj5Hq6hqAEGHioi8QF36
CFCvYyF3JOkSCxDJArbcA4NC8lnplGyLJNM0m4K+GWiI8jwycBoeomD4O5IPZoqJ
KpYQvuUEvxj6oUiyUi9nlGBykaUWT9HcdHwR/CERzQbLvLdP7mSOmQoRBA0wpTL4
rjMQzRBC3mq7IbpF1KIL6i2MXlrc0A==
=Sg00
-----END PGP SIGNATURE-----

--BWcBR5tAtlqJh3E0agxh3OnF6MPdoeZCt--


