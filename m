Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00448C83008
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 06:41:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C01A2206A5
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 06:41:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ObusQYDS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C01A2206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43548 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTJwH-0007Jw-O5
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 02:41:53 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36648)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jTJrS-0002C4-5e
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 02:40:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jTJpl-0001qb-Mm
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 02:36:53 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:22240
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jTJpl-0001pW-0x
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 02:35:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588055706;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=+nSQbbskV7DNFupQmBuY2FhjMyAlKMppJSzD23Xl+1Q=;
 b=ObusQYDSSqhryvDBmNNK/7eo3Ge9hXGycIKi/yVGQnd3Qu3zKHFi4Dt1fmP4MVQtshKmg4
 X34nHJswwwqnue0VMZwcmAWGdg9/WvPLc3ThqJ2HxWh8My0cw2fTKpr3fl54ZgHwUI5JMZ
 9xUjoLkHDKevTOK6+rQ/9xs/vB6Cm74=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-200-nn2KIq0NMpWN600KKwgwMA-1; Tue, 28 Apr 2020 02:35:02 -0400
X-MC-Unique: nn2KIq0NMpWN600KKwgwMA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DD6F11009442;
 Tue, 28 Apr 2020 06:35:00 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 910EB5F7FD;
 Tue, 28 Apr 2020 06:34:52 +0000 (UTC)
Subject: Re: [PATCH v3 1/3] block: Add blk_new_with_bs() helper
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20200424190903.522087-1-eblake@redhat.com>
 <20200424190903.522087-2-eblake@redhat.com>
 <ba31b83c-538a-0f3f-9bab-7aadb2f99ea9@redhat.com>
 <5d70074f-ef06-31f6-f694-ef4c4517472c@redhat.com>
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
Message-ID: <59352c54-2d9c-5bde-9f5b-541f2ae5cccc@redhat.com>
Date: Tue, 28 Apr 2020 08:34:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <5d70074f-ef06-31f6-f694-ef4c4517472c@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="iGMFusVHO0deybt4uKnqZqHEZ19EDMb1z"
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/28 02:06:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 "open list:Sheepdog" <sheepdog@lists.wpkg.org>, qemu-block@nongnu.org,
 Jeff Cody <codyprime@gmail.com>, Stefan Weil <sw@weilnetz.de>,
 Markus Armbruster <armbru@redhat.com>, stefanha@redhat.com,
 Liu Yuan <namei.unix@gmail.com>, "Denis V. Lunev" <den@openvz.org>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--iGMFusVHO0deybt4uKnqZqHEZ19EDMb1z
Content-Type: multipart/mixed; boundary="XnA8rzA95pnCFTs5Dp7Tiuw0EEyTFfSCg"

--XnA8rzA95pnCFTs5Dp7Tiuw0EEyTFfSCg
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 27.04.20 16:03, Eric Blake wrote:
> On 4/27/20 5:00 AM, Max Reitz wrote:
>> On 24.04.20 21:09, Eric Blake wrote:
>>> There are several callers that need to create a new block backend from
>>> an existing BDS; make the task slightly easier with a common helper
>>> routine.
>>>
>>> Suggested-by: Max Reitz <mreitz@redhat.com>
>>> Signed-off-by: Eric Blake <eblake@redhat.com>
>>> ---
>=20
>>> +++ b/block/crypto.c
>>> @@ -256,16 +256,14 @@ static int
>>> block_crypto_co_create_generic(BlockDriverState *bs,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 PreallocMode prealloc,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Error **errp)
>>> =C2=A0 {
>>> -=C2=A0=C2=A0=C2=A0 int ret;
>>> +=C2=A0=C2=A0=C2=A0 int ret =3D -EPERM;
>>
>> I=E2=80=99m not sure I=E2=80=99m a fan of this, because I feel like it m=
akes the code
>> harder to read, due to having to look in three places (here, around the
>> blk_new_with_bs() call, and under the cleanup label) instead of in two
>> (not here) to verify that the error handling code is correct.
>>
>> There=E2=80=99s also the fact that this is not really a default return v=
alue,
>> but one very specific error code for if one very specific function call
>> fails.
>>
>> I suppose it comes down to whether one considers LoC a complexity
>> problem.=C2=A0 (I don=E2=80=99t, necessarily.)
>>
>> (Also I realize it seems rather common in the kernel to set error return
>> variables before the function call, but I think the more common pattern
>> in qemu is to set it in the error path.)
>=20
> I'm fine with either style.=C2=A0 Setting it up front is handy if that
> particular error makes a good default, but in many of the functions I
> touched, we were returning a variety of errors (-EIO, -EINVAL, -EPERM,
> etc) such that there was no good default, and thus no reason to set a
> default up front.=C2=A0 Is this something that would go through your tree=
,
> and if so, are you okay making that tweak, or do I need to send v4?

I suppose I can do that, this is what I=E2=80=99d squash in, OK?

Max

diff --git a/block/crypto.c b/block/crypto.c
index a4d77f07fe..d09b364134 100644
--- a/block/crypto.c
+++ b/block/crypto.c
@@ -256,7 +256,7 @@ static int
block_crypto_co_create_generic(BlockDriverState *bs,
                                           PreallocMode prealloc,
                                           Error **errp)
 {
-    int ret =3D -EPERM;
+    int ret;
     BlockBackend *blk;
     QCryptoBlock *crypto =3D NULL;
     struct BlockCryptoCreateData data;
@@ -264,6 +264,7 @@ static int
block_crypto_co_create_generic(BlockDriverState *bs,
     blk =3D blk_new_with_bs(bs, BLK_PERM_WRITE | BLK_PERM_RESIZE,
BLK_PERM_ALL,
                           errp);
     if (!blk) {
+        ret =3D -EPERM;
         goto cleanup;
     }

diff --git a/block/qed.c b/block/qed.c
index 7a31495d29..671742511e 100644
--- a/block/qed.c
+++ b/block/qed.c
@@ -610,7 +610,7 @@ static int coroutine_fn
bdrv_qed_co_create(BlockdevCreateOptions *opts,
     QEDHeader le_header;
     uint8_t *l1_table =3D NULL;
     size_t l1_size;
-    int ret =3D -EPERM;
+    int ret =3D 0;

     assert(opts->driver =3D=3D BLOCKDEV_DRIVER_QED);
     qed_opts =3D &opts->u.qed;
@@ -654,6 +654,7 @@ static int coroutine_fn
bdrv_qed_co_create(BlockdevCreateOptions *opts,
     blk =3D blk_new_with_bs(bs, BLK_PERM_WRITE | BLK_PERM_RESIZE,
BLK_PERM_ALL,
                           errp);
     if (!blk) {
+        ret =3D -EPERM;
         goto out;
     }
     blk_set_allow_write_beyond_eof(blk, true);
diff --git a/block/sheepdog.c b/block/sheepdog.c
index 2b53cd950d..8baf9e66bb 100644
--- a/block/sheepdog.c
+++ b/block/sheepdog.c
@@ -1801,13 +1801,14 @@ static int sd_prealloc(BlockDriverState *bs,
int64_t old_size, int64_t new_size,
     uint32_t idx, max_idx;
     uint32_t object_size;
     void *buf =3D NULL;
-    int ret =3D -EPERM;
+    int ret;

     blk =3D blk_new_with_bs(bs,
                           BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE |
BLK_PERM_RESIZE,
                           BLK_PERM_ALL, errp);

     if (!blk) {
+        ret =3D -EPERM;
         goto out_with_err_set;
     }

diff --git a/block/vhdx.c b/block/vhdx.c
index bdf5d05cc0..8ca6976b59 100644
--- a/block/vhdx.c
+++ b/block/vhdx.c
@@ -1891,7 +1891,7 @@ static int coroutine_fn
vhdx_co_create(BlockdevCreateOptions *opts,
     BlockBackend *blk =3D NULL;
     BlockDriverState *bs =3D NULL;

-    int ret =3D -EPERM;
+    int ret =3D 0;
     uint64_t image_size;
     uint32_t log_size;
     uint32_t block_size;
@@ -1987,6 +1987,7 @@ static int coroutine_fn
vhdx_co_create(BlockdevCreateOptions *opts,
     blk =3D blk_new_with_bs(bs, BLK_PERM_WRITE | BLK_PERM_RESIZE,
BLK_PERM_ALL,
                           errp);
     if (!blk) {
+        ret =3D -EPERM;
         goto delete_and_exit;
     }
     blk_set_allow_write_beyond_eof(blk, true);


--XnA8rzA95pnCFTs5Dp7Tiuw0EEyTFfSCg--

--iGMFusVHO0deybt4uKnqZqHEZ19EDMb1z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl6nzosACgkQ9AfbAGHV
z0B4Swf9H3jAThDKf044xz+rand/xkJ6VUavMi4ACTRtBD4EzhFfMlQT+1a6I0j1
j1+ieNOoro2Q4V9yGqH/9kOF3Lh7e6XrMxzh2EjT5ZdDJBIFohrqm7pu6BoReEPX
hm6xt8BaPiHjBt/AT0T3yTAAp6lPr/mCssHzgo+sc0nMPRJYWWHsnuV0HLb+zRkq
Z066sGQpXYQIpA1lFFEbN6oXqIOyRQnm842ojv479wgrFNvns7X4IBpwKEaIYiNO
+9ZFG0GlTI9IM4XjcEvVqH4lJOqH5e5ibRTkHGNqLvPud4Qterz/1I4IT+oWMQ91
Zv/2ZZSJKf9Sn3ZxtKOC3qQXgMpxbQ==
=04l/
-----END PGP SIGNATURE-----

--iGMFusVHO0deybt4uKnqZqHEZ19EDMb1z--


