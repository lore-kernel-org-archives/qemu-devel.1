Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D87B6C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 08:25:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2B2D206A1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 08:25:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PxRgkqm7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2B2D206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57244 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtRrv-0002fH-TR
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 04:25:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53452)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jtRrM-0002A3-Ho
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 04:24:48 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:47153
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jtRrJ-0007OE-MC
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 04:24:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594283085;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=xJs22n6nBvbDAhlh7YOjxdMebZQRH57ci+85DxTHC1A=;
 b=PxRgkqm7YOCR8iaRTu3WA6pFQFtOFYCYyGxy/VgItLgWhY90yLJHYYxt7L0K9RSHi4rQp6
 HmNGDYe+dDhNm6qIAblOXS3hE4HYdx1V7T9TppepYv5IzJmBlFEnIgKhgP72mIQ8xDoaHf
 ew1lSIVGZZKIYQz1bvXyIUa3V61rAfU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-190-_Men2jVmMqyWXggbciibzA-1; Thu, 09 Jul 2020 04:24:42 -0400
X-MC-Unique: _Men2jVmMqyWXggbciibzA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D4E1318FF660;
 Thu,  9 Jul 2020 08:24:41 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-127.ams2.redhat.com
 [10.36.113.127])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 79EB21A7CA;
 Thu,  9 Jul 2020 08:24:40 +0000 (UTC)
Subject: Re: [PATCH v7 02/47] block: Add chain helper functions
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-block@nongnu.org
References: <20200625152215.941773-1-mreitz@redhat.com>
 <20200625152215.941773-3-mreitz@redhat.com>
 <5c2a81c7-851c-aeb4-84b7-3bd61417495e@virtuozzo.com>
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
Message-ID: <7244733b-3092-a1f1-55f1-35a964a7c791@redhat.com>
Date: Thu, 9 Jul 2020 10:24:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <5c2a81c7-851c-aeb4-84b7-3bd61417495e@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="H006wDWmRSfeXG8UiXiRW4DyMbSEjOUqT"
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/09 04:20:09
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--H006wDWmRSfeXG8UiXiRW4DyMbSEjOUqT
Content-Type: multipart/mixed; boundary="rLKlzxse3QKS5YskAmqTt5mtvjMvowVKf"

--rLKlzxse3QKS5YskAmqTt5mtvjMvowVKf
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 08.07.20 19:20, Andrey Shinkevich wrote:
> On 25.06.2020 18:21, Max Reitz wrote:
>> Add some helper functions for skipping filters in a chain of block
>> nodes.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>> =C2=A0 include/block/block_int.h |=C2=A0 3 +++
>> =C2=A0 block.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 55 ++++++++++++++++++=
+++++++++++++++++++++
>> =C2=A0 2 files changed, 58 insertions(+)
>>
>> diff --git a/include/block/block_int.h b/include/block/block_int.h
>> index bb3457c5e8..5da793bfc3 100644
>> --- a/include/block/block_int.h
>> +++ b/include/block/block_int.h
>> @@ -1382,6 +1382,9 @@ BdrvChild *bdrv_cow_child(BlockDriverState *bs);
>> =C2=A0 BdrvChild *bdrv_filter_child(BlockDriverState *bs);
>> =C2=A0 BdrvChild *bdrv_filter_or_cow_child(BlockDriverState *bs);
>> =C2=A0 BdrvChild *bdrv_primary_child(BlockDriverState *bs);
>> +BlockDriverState *bdrv_skip_implicit_filters(BlockDriverState *bs);
>> +BlockDriverState *bdrv_skip_filters(BlockDriverState *bs);
>> +BlockDriverState *bdrv_backing_chain_next(BlockDriverState *bs);
>> =C2=A0 =C2=A0 static inline BlockDriverState *child_bs(BdrvChild *child)
>> =C2=A0 {
>> diff --git a/block.c b/block.c
>> index 5a42ef49fd..0a0b855261 100644
>> --- a/block.c
>> +++ b/block.c
>> @@ -7008,3 +7008,58 @@ BdrvChild *bdrv_primary_child(BlockDriverState
>> *bs)
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return NULL;
>> =C2=A0 }
>> +
>> +static BlockDriverState *bdrv_do_skip_filters(BlockDriverState *bs,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool
>> stop_on_explicit_filter)
>> +{
>> +=C2=A0=C2=A0=C2=A0 BdrvChild *c;
>> +
>> +=C2=A0=C2=A0=C2=A0 if (!bs) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return NULL;
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 while (!(stop_on_explicit_filter && !bs->implicit)) =
{
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 c =3D bdrv_filter_child(bs);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!c) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 brea=
k;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bs =3D c->bs;
>=20
> Could it be child_bs(bs) ?

Well, in a sense, but not really.  We need to check whether there is a
child before overwriting @bs (because @bs must stay a non-NULL pointer),
so we wouldn=E2=80=99t have fewer lines of code if we replaced =E2=80=9CBdr=
vChild *c=E2=80=9D by
=E2=80=9CBlockDriverState *child_bs=E2=80=9D, and then used bdrv_child() to=
 set child_bs.

(And because we have to check whether @c is NULL anyway, there is no
real reason to use child_bs(c) instead of c->bs afterwards.)

>> +=C2=A0=C2=A0=C2=A0 }
> Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>

Thanks a lot for reviewing!


--rLKlzxse3QKS5YskAmqTt5mtvjMvowVKf--

--H006wDWmRSfeXG8UiXiRW4DyMbSEjOUqT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl8G1EYACgkQ9AfbAGHV
z0C+5wf9HE9Hz1AtZSaRjGxPf5PAPgBXy5X3+FZoqlAwaN3ac82C5pU226LKISp8
kOZ+y6VTgub7ijXvS2HGrMChkyF24J/XwLiJ2XcjKZu1jJyLH7IshqjM5XJiSSxB
ZF5EoABKtmNwla6aXkfVyNs4Atn2B9i9EbpqKFSnR0RgC/2deiT4ESaGyGHHfSw9
Mg4b16dCTvcpXtakLjjIxivtKTMg5OAWdOrJ184c1tfsFSFA5AXo5QULseG22sGw
hj6riNFrlv968wr/cIC4Jzd+dezxWDYU8jeaYm9X1rFwA8OVm90ucJs8d8ElVnuj
7y3vl2++qf+KQ92OQ7y+SpxdF/NKgw==
=zDhQ
-----END PGP SIGNATURE-----

--H006wDWmRSfeXG8UiXiRW4DyMbSEjOUqT--


