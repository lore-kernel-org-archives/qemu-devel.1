Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35A39C433E8
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 11:53:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4CDD20738
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 11:53:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LmG73E83"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4CDD20738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55624 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jux1n-0001F3-77
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 07:53:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51262)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jux0u-0000bx-Cn
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 07:52:52 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:45003
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jux0r-00045z-RP
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 07:52:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594641168;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=BpfBiXg9VJ+uUM2hIrwkONnCVTKe0GYBhSCo1btAlOU=;
 b=LmG73E83NDxquU//6GDpcWz7i+uOG6HXAiDBa6dQqzdPiCmKA3JANqLLdayQaAOW2i4Tir
 Edddw9XjD0p3Zi7e6Mq1IcBEW45vHCBV2/tbD8FYagIuXvow4YesA9/RicxlqAPqcIEvIp
 GsDJzB2QPPZXZqgE2JAECR1wRglX4yM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-156-Ni0S3eb-OV6YTFAhMxMf8Q-1; Mon, 13 Jul 2020 07:52:45 -0400
X-MC-Unique: Ni0S3eb-OV6YTFAhMxMf8Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4AD841902EA0;
 Mon, 13 Jul 2020 11:52:44 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-8.ams2.redhat.com
 [10.36.113.8])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 18EB619C66;
 Mon, 13 Jul 2020 11:52:42 +0000 (UTC)
Subject: Re: [PATCH for-5.1 1/2] block: Require aligned image size to avoid
 assertion failure
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
References: <20200710142149.40962-1-kwolf@redhat.com>
 <20200710142149.40962-2-kwolf@redhat.com>
 <e608699f-b2c2-d7a0-cb59-703832ae732a@redhat.com>
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
Message-ID: <a8f4fcbc-1b31-d4ae-03df-1b5b6351c35e@redhat.com>
Date: Mon, 13 Jul 2020 13:52:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <e608699f-b2c2-d7a0-cb59-703832ae732a@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="D64I87dHdRQPV5aK8SJCBlZYUF3nxT8mu"
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 03:20:22
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: nsoffer@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--D64I87dHdRQPV5aK8SJCBlZYUF3nxT8mu
Content-Type: multipart/mixed; boundary="2robvpGC5GrEOTAdhUdr9RLVOoFH3MptO"

--2robvpGC5GrEOTAdhUdr9RLVOoFH3MptO
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 13.07.20 13:19, Max Reitz wrote:
> On 10.07.20 16:21, Kevin Wolf wrote:
>> Unaligned requests will automatically be aligned to bl.request_alignment
>> and we don't want to extend requests to access space beyond the end of
>> the image, so it's required that the image size is aligned.
>>
>> With write requests, this could cause assertion failures like this if
>> RESIZE permissions weren't requested:
>>
>> qemu-img: block/io.c:1910: bdrv_co_write_req_prepare: Assertion `end_sec=
tor <=3D bs->total_sectors || child->perm & BLK_PERM_RESIZE' failed.
>>
>> This was e.g. triggered by qemu-img converting to a target image with 4k
>> request alignment when the image was only aligned to 512 bytes, but not
>> to 4k.
>>
>> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
>> ---
>>  block.c | 10 ++++++++++
>>  1 file changed, 10 insertions(+)
>=20
> (I think we had some proposal like this before, but I can=E2=80=99t find =
it,
> unfortunately...)

(Ah, here it is:

https://lists.nongnu.org/archive/html/qemu-devel/2020-03/msg03077.html

(Which interestingly teases yet another mysterious =E2=80=9Cwe had a discus=
sion
on this before=E2=80=9D...))

> I can=E2=80=99t see how with this patch you could create qcow2 images and=
 then
> use them with direct I/O, because AFAICS, qemu-img create doesn=E2=80=99t=
 allow
> specifying caching options, so AFAIU you=E2=80=99re stuck with:
>=20
> $ ./qemu-img create -f qcow2 /mnt/tmp/foo.qcow2 1M
> Formatting '/mnt/tmp/foo.qcow2', fmt=3Dqcow2 cluster_size=3D65536
> compression_type=3Dzlib size=3D1048576 lazy_refcounts=3Doff refcount_bits=
=3D16
>=20
> $ sudo ./qemu-io -t none /mnt/tmp/foo.qcow2
> qemu-io: can't open device /mnt/tmp/foo.qcow2: Image size is not a
> multiple of request alignment
>=20
> (/mnt/tmp is a filesystem on a =E2=80=9Closetup -b 4096=E2=80=9D device.)
>=20
> Or you use blockdev-create, that seems to work (because of course you
> can set the cache mode on the protocol node when you open it for
> formatting).  But, well, I think there should be a working qemu-img
> create case.
>=20
> Also, I=E2=80=99m afraid of breaking existing use cases with this patch (=
just
> qemu-img create + using the image with cache=3Dnone).
>=20
> Max
>=20



--2robvpGC5GrEOTAdhUdr9RLVOoFH3MptO--

--D64I87dHdRQPV5aK8SJCBlZYUF3nxT8mu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl8MSwkACgkQ9AfbAGHV
z0AL7AgAiz4nr+5liEdufT6VbD+wS5hE5/qC2HsyNlgdvdy0XO0VHByEabd1wdGV
aDGhunroFd5LhY8hkfZOSFDc633ZUtJMoQRtV47UABs4QmOuqNAl1PWBTP4wht7q
+vS4KDOXQOqSyZOX974/NL67ig5/mL+w8AGvJ72LgQ4YPTbRq2ThyanJgS7Cg6wF
Y5s3ey8n5pGZ6bAxCMHqLQCp5DEFZSKhF532I0KYkfpuIFBisI/tztkFWJo2QFp3
bLEqoKorWl2HGoxdKUk/RlR1GuCSgMQVpMqDo8O3zSGKXE0EblZB5i7wUsLHqJDb
skFDwWlyHZmsEzfLIjBrzsorHZtaVw==
=yDJy
-----END PGP SIGNATURE-----

--D64I87dHdRQPV5aK8SJCBlZYUF3nxT8mu--


