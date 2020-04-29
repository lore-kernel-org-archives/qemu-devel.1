Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B98FC83003
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 12:00:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FD662083B
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 12:00:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NXq/7ZID"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FD662083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42394 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTlOB-00015t-8M
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 08:00:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51480)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jTlKh-0005HB-CQ
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 07:56:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jTlKg-0004FK-NB
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 07:56:55 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:33451
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jTlKg-0004FD-9E
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 07:56:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588161413;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=il7bRSL0ZmjCLl39OJc1FAVf8D8/TFCXIYTbJI3H3HU=;
 b=NXq/7ZIDLDp+TNpqG9GEHeO8FZyWbQwhSnMfEdJiJCZnaahj6Xee2uj3C2YUblEQCKCgkz
 PThXpLvh8AT/NpZBujqE71a1LFg/C3ZkdGbVcT1YFq8l6zrjLvVnYUAm3YRE+BCpa6kmqI
 Sdx4xlWN49tUoY/lMZmT9DH8pMt3djE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-351-LS8Z3fboPOGq65eAu1ZrAA-1; Wed, 29 Apr 2020 07:56:51 -0400
X-MC-Unique: LS8Z3fboPOGq65eAu1ZrAA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 15FDC18957EA;
 Wed, 29 Apr 2020 11:56:50 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-19.ams2.redhat.com
 [10.36.113.19])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CEA3F5D9C9;
 Wed, 29 Apr 2020 11:56:48 +0000 (UTC)
Subject: Re: [PATCH v3 4/5] block/block-copy: refactor task creation
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20200429061039.12687-1-vsementsov@virtuozzo.com>
 <20200429061039.12687-5-vsementsov@virtuozzo.com>
 <affc8770-2b70-c3e4-af1b-ca620119c2d5@redhat.com>
 <92dd552d-b181-5b39-c796-e228c4d33379@virtuozzo.com>
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
Message-ID: <0f14b02d-884a-9581-f1c7-7133e6d36557@redhat.com>
Date: Wed, 29 Apr 2020 13:56:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <92dd552d-b181-5b39-c796-e228c4d33379@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ppfvitIFueypwC7zjHFrG9q2WiSCMP3Az"
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 01:28:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: kwolf@redhat.com, den@openvz.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ppfvitIFueypwC7zjHFrG9q2WiSCMP3Az
Content-Type: multipart/mixed; boundary="lmiUEGV7HGegee5zpI1GHaB4U3ZOs4ErJ"

--lmiUEGV7HGegee5zpI1GHaB4U3ZOs4ErJ
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 29.04.20 13:54, Vladimir Sementsov-Ogievskiy wrote:
> 29.04.2020 14:38, Max Reitz wrote:
>> On 29.04.20 08:10, Vladimir Sementsov-Ogievskiy wrote:
>>> Instead of just relying on the comment "Called only on full-dirty
>>> region" in block_copy_task_create() let's move initial dirty area
>>> search directly to block_copy_task_create(). Let's also use effective
>>> bdrv_dirty_bitmap_next_dirty_area instead of looping through all
>>> non-dirty clusters.
>>>
>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>> ---
>>> =A0 block/block-copy.c | 78 ++++++++++++++++++++++++++-----------------=
---
>>> =A0 1 file changed, 44 insertions(+), 34 deletions(-)
>>>
>>> diff --git a/block/block-copy.c b/block/block-copy.c
>>> index 35ff9cc3ef..5cf032c4d8 100644
>>> --- a/block/block-copy.c
>>> +++ b/block/block-copy.c
>>
>> [...]
>>
>>> @@ -106,17 +111,27 @@ static bool coroutine_fn
>>> block_copy_wait_one(BlockCopyState *s, int64_t offset,
>>> =A0=A0=A0=A0=A0 return true;
>>> =A0 }
>>> =A0 -/* Called only on full-dirty region */
>>> +/*
>>> + * Search for the first dirty area in offset/bytes range and create
>>> task at
>>> + * the beginning of it.
>>
>> Oh, that=92s even better.
>>
>>> + */
>>> =A0 static BlockCopyTask *block_copy_task_create(BlockCopyState *s,
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 int64=
_t offset,
>>> int64_t bytes)
>>> =A0 {
>>> -=A0=A0=A0 BlockCopyTask *task =3D g_new(BlockCopyTask, 1);
>>> +=A0=A0=A0 if (!bdrv_dirty_bitmap_next_dirty_area(s->copy_bitmap,
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 offset, offset + =
bytes,
>>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 s->copy_size, &of=
fset,
>>> &bytes))
>>> +=A0=A0=A0 {
>>> +=A0=A0=A0=A0=A0=A0=A0 return NULL;
>>> +=A0=A0=A0 }
>>> =A0 +=A0=A0=A0 /* region is dirty, so no existent tasks possible in it =
*/
>>> =A0=A0=A0=A0=A0 assert(!find_conflicting_task(s, offset, bytes));
>>> =A0 =A0=A0=A0=A0=A0 bdrv_reset_dirty_bitmap(s->copy_bitmap, offset, byt=
es);
>>> =A0=A0=A0=A0=A0 s->in_flight_bytes +=3D bytes;
>>> =A0 +=A0=A0=A0 BlockCopyTask *task =3D g_new(BlockCopyTask, 1);
>>
>> This should be declared at the top of the function.
>>
>=20
> I just thought, why not to try another style? Are you against?
> Requirement to declare variables at start of block is obsolete, isn't it?

Oh, it absolutely is and personally I=92m absolutely not against it, but
CODING_STYLE says:

> Mixed declarations (interleaving statements and declarations within
> blocks) are generally not allowed; declarations should be at the beginnin=
g                                                                          =
                                                                           =
             =20
> of blocks.

Max

>> Reviewed-by: Max Reitz <mreitz@redhat.com>
>>
>>> =A0=A0=A0=A0=A0 *task =3D (BlockCopyTask) {
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 .s =3D s,
>>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 .offset =3D offset,
>>
>=20
>=20



--lmiUEGV7HGegee5zpI1GHaB4U3ZOs4ErJ--

--ppfvitIFueypwC7zjHFrG9q2WiSCMP3Az
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl6pa38ACgkQ9AfbAGHV
z0BSaAf+LeR893RGiZRPy1fJ6kKDf1jMHnZLwfqfWUtrcWAt7DULq7li4XzC2f7q
chEVcR+QglrF3ra3UwDufIIb5I/5LfWsownK2qYwxwd1FPhsO/Ngm210QoX4HBEX
gE3UK3KtbpLv2+NdXnUXXRZ/m5OyYIF/zTYO5JD/PSgBuD2mtLNipvy1Ev93WtBM
aj4A7eAgJFCygdESrUSKFrPdWfSl+cpPlkb2C65KFrz8TBGWvUIemsIyNDB4Hx3h
dHsOwCRomA0DepmBgxoFR+2I9wgKZRC4/iZpr5L5zvvhSadaSXsHmQicxmsIFaJj
KewvABE9km+xJb3rgj2q1omkETVhZw==
=RwEF
-----END PGP SIGNATURE-----

--ppfvitIFueypwC7zjHFrG9q2WiSCMP3Az--


