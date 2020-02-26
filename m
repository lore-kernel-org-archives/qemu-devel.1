Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 137F1C4BA0E
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 10:16:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3BEF20838
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 10:16:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ToWe7ZvM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3BEF20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41858 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6tjv-0008Gy-1p
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 05:16:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45487)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1j6thv-0005yD-F7
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 05:14:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1j6thu-0007VE-BG
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 05:14:23 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37842
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1j6thu-0007TE-5P
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 05:14:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582712061;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=O9CebRtqHonPW9g/FtF1Ms2u9w6SQvAyblztqQcRiM4=;
 b=ToWe7ZvMU/dvGcNHO0jmhoAYeyoChmVzdTdWrBacYv9X1B/2eEisgDIOSG0BHLX9Y35Lnd
 84tlLBBYPFHqBv00ua0bkeUZGioDlGsIZ/Yp3Z/4dHIeN9gWwhC9VEO9dH7ytOr5Q8joYG
 cXtuyyMzynewCYvZ8VKBrsELONie320=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-210-tUdtw0hCPXqfCCRj9WAf2Q-1; Wed, 26 Feb 2020 05:14:17 -0500
X-MC-Unique: tUdtw0hCPXqfCCRj9WAf2Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DEFE4800D53;
 Wed, 26 Feb 2020 10:14:15 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.36.118.45])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 448AF90514;
 Wed, 26 Feb 2020 10:14:13 +0000 (UTC)
Subject: Re: [PATCH 1/2] block/qcow2: do free crypto_opts in qcow2_close()
To: Pan Nengyuan <pannengyuan@huawei.com>, kwolf@redhat.com
References: <20200226033037.18253-1-pannengyuan@huawei.com>
 <20200226033037.18253-2-pannengyuan@huawei.com>
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
Message-ID: <7e632a12-ca13-0443-2ad0-0b86ed8cc869@redhat.com>
Date: Wed, 26 Feb 2020 11:14:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200226033037.18253-2-pannengyuan@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="96q27koI5Gn4Ib7JZxxU9SuLzAm8ApbXa"
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
Cc: euler.robot@huawei.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 zhang.zhanghailiang@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--96q27koI5Gn4Ib7JZxxU9SuLzAm8ApbXa
Content-Type: multipart/mixed; boundary="NdoOGijVSLPetRJ41XruvHYmV9wtAthq4"

--NdoOGijVSLPetRJ41XruvHYmV9wtAthq4
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 26.02.20 04:30, Pan Nengyuan wrote:
> 'crypto_opts' forgot to free in qcow2_close(), this patch fix the bellow =
leak stack:
>=20
> Direct leak of 24 byte(s) in 1 object(s) allocated from:
>     #0 0x7f0edd81f970 in __interceptor_calloc (/lib64/libasan.so.5+0xef97=
0)
>     #1 0x7f0edc6d149d in g_malloc0 (/lib64/libglib-2.0.so.0+0x5249d)
>     #2 0x55d7eaede63d in qobject_input_start_struct /mnt/sdb/qemu-new/qem=
u_test/qemu/qapi/qobject-input-visitor.c:295
>     #3 0x55d7eaed78b8 in visit_start_struct /mnt/sdb/qemu-new/qemu_test/q=
emu/qapi/qapi-visit-core.c:49
>     #4 0x55d7eaf5140b in visit_type_QCryptoBlockOpenOptions qapi/qapi-vis=
it-crypto.c:290
>     #5 0x55d7eae43af3 in block_crypto_open_opts_init /mnt/sdb/qemu-new/qe=
mu_test/qemu/block/crypto.c:163
>     #6 0x55d7eacd2924 in qcow2_update_options_prepare /mnt/sdb/qemu-new/q=
emu_test/qemu/block/qcow2.c:1148
>     #7 0x55d7eacd33f7 in qcow2_update_options /mnt/sdb/qemu-new/qemu_test=
/qemu/block/qcow2.c:1232
>     #8 0x55d7eacd9680 in qcow2_do_open /mnt/sdb/qemu-new/qemu_test/qemu/b=
lock/qcow2.c:1512
>     #9 0x55d7eacdc55e in qcow2_open_entry /mnt/sdb/qemu-new/qemu_test/qem=
u/block/qcow2.c:1792
>     #10 0x55d7eacdc8fe in qcow2_open /mnt/sdb/qemu-new/qemu_test/qemu/blo=
ck/qcow2.c:1819
>     #11 0x55d7eac3742d in bdrv_open_driver /mnt/sdb/qemu-new/qemu_test/qe=
mu/block.c:1317
>     #12 0x55d7eac3e990 in bdrv_open_common /mnt/sdb/qemu-new/qemu_test/qe=
mu/block.c:1575
>     #13 0x55d7eac4442c in bdrv_open_inherit /mnt/sdb/qemu-new/qemu_test/q=
emu/block.c:3126
>     #14 0x55d7eac45c3f in bdrv_open /mnt/sdb/qemu-new/qemu_test/qemu/bloc=
k.c:3219
>     #15 0x55d7ead8e8a4 in blk_new_open /mnt/sdb/qemu-new/qemu_test/qemu/b=
lock/block-backend.c:397
>     #16 0x55d7eacde74c in qcow2_co_create /mnt/sdb/qemu-new/qemu_test/qem=
u/block/qcow2.c:3534
>     #17 0x55d7eacdfa6d in qcow2_co_create_opts /mnt/sdb/qemu-new/qemu_tes=
t/qemu/block/qcow2.c:3668
>     #18 0x55d7eac1c678 in bdrv_create_co_entry /mnt/sdb/qemu-new/qemu_tes=
t/qemu/block.c:485
>     #19 0x55d7eb0024d2 in coroutine_trampoline /mnt/sdb/qemu-new/qemu_tes=
t/qemu/util/coroutine-ucontext.c:115
>=20
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
> ---
>  block/qcow2.c | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--NdoOGijVSLPetRJ41XruvHYmV9wtAthq4--

--96q27koI5Gn4Ib7JZxxU9SuLzAm8ApbXa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl5WRPQACgkQ9AfbAGHV
z0AVaQf+Jv6bbtphkHyJwwcTFLmK81gaU1PcyihHAyzBNKQmV45aPPTaKkfT9j8C
pKhOUOBF7qoJ6M2FSCdCNK1t2nXHUeeYRGfM0OZrJ+7g0egw9DmjPy5TBSmUt0fV
dZpBV1XhBbE0hkCT1Sy+OzdmCq0cAZNc/Mi7jlcbx1Uy0Jr5wa9A8/EhJDJHvepR
N/RftDW6WCBiY5V989wLaD67HHMoT20mGM0S2fAndF6KebOVVGXkVeePKdAzQkni
dDIhZ6OPwaMxSJRCMf1o/KR1+BblJXyJ857CRPX78rB2l4qjhenKO9K+LEzC7eZZ
iqxEX+rwp0YQ2cTbKgoXK7VkbPk33w==
=bmnm
-----END PGP SIGNATURE-----

--96q27koI5Gn4Ib7JZxxU9SuLzAm8ApbXa--


