Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5758C433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 08:32:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 314EB206F4
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 08:32:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="esn4PEJH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 314EB206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42266 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGeTZ-0000XC-Rz
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 04:32:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60384)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kGeSv-0008SD-KL
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 04:31:29 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:37507
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kGeSt-00018A-Gd
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 04:31:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599813085;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=0bVxKIUYAv+Rcx3MbhxI432bqgJWWZnG/6CREdHSjTQ=;
 b=esn4PEJH6PhaFgwz+Sg8tjNNpi8BtH7Da9ULCAv9ycC72WQ6ITWLjaQXXrqjWYQZBMmGLo
 s95EF8tYekjpyEB8gj64DnHEQUQajO1SNgymNePBUW2ASnbwDBuPPgPnKwkUlcCbEr7457
 /mRNIA1nxEfYqu5+IA772oCjiD0WiDQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-142-OGUuFWvmPU2saa9hWEVvPw-1; Fri, 11 Sep 2020 04:31:23 -0400
X-MC-Unique: OGUuFWvmPU2saa9hWEVvPw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9F32D10BBECE;
 Fri, 11 Sep 2020 08:31:22 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-148.ams2.redhat.com
 [10.36.113.148])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4EBEE60BFA;
 Fri, 11 Sep 2020 08:31:21 +0000 (UTC)
Subject: Re: [PATCH] qemu-img: Support bitmap --merge into backing image
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20200909123358.1244744-1-eblake@redhat.com>
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
Message-ID: <32a96bcc-78de-a13e-c090-ad00c3b4c4ad@redhat.com>
Date: Fri, 11 Sep 2020 10:31:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200909123358.1244744-1-eblake@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="aqqpdLzvAcAdfFU0AVaJ5i5d26uki6wPc"
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/11 03:40:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -56
X-Spam_score: -5.7
X-Spam_bar: -----
X-Spam_report: (-5.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-3.576, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Eyal Shenitzky <eshenitz@redhat.com>,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--aqqpdLzvAcAdfFU0AVaJ5i5d26uki6wPc
Content-Type: multipart/mixed; boundary="gV7FH1UhGR1z1zDqNt72qOyUtnsP4LBX1"

--gV7FH1UhGR1z1zDqNt72qOyUtnsP4LBX1
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 09.09.20 14:33, Eric Blake wrote:
> If you have the chain 'base.qcow2 <- top.qcow2' and want to merge a
> bitmap from top into base, qemu-img was failing with:
>=20
> qemu-img: Could not open 'top.qcow2': Could not open backing file: Failed=
 to get shared "write" lock
> Is another process using the image [base.qcow2]?
>=20
> The easiest fix is to not open the entire backing chain of the source
> image, so that we aren't worrying about competing BDS visiting the
> backing image as both a read-only backing of the source and the
> writeable destination.
>=20
> Fixes: http://bugzilla.redhat.com/1877209
> Reported-by: Eyal Shenitzky <eshenitz@redhat.com>
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  qemu-img.c                 |  3 +-
>  tests/qemu-iotests/291     | 12 ++++++++
>  tests/qemu-iotests/291.out | 56 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 70 insertions(+), 1 deletion(-)
>=20
> diff --git a/qemu-img.c b/qemu-img.c
> index eb2fc1f86243..b15098a2f9b3 100644
> --- a/qemu-img.c
> +++ b/qemu-img.c
> @@ -4755,7 +4755,8 @@ static int img_bitmap(int argc, char **argv)
>      }
>      bs =3D blk_bs(blk);
>      if (src_filename) {
> -        src =3D img_open(false, src_filename, src_fmt, 0, false, false, =
false);
> +        src =3D img_open(false, src_filename, src_fmt, BDRV_O_NO_BACKING=
,
> +                       false, false, false);

Why not do the same for the destination BB?

>          if (!src) {
>              goto out;
>          }
> diff --git a/tests/qemu-iotests/291 b/tests/qemu-iotests/291
> index 1e0bb76959bb..4f837b205655 100755
> --- a/tests/qemu-iotests/291
> +++ b/tests/qemu-iotests/291

[...]

> @@ -107,6 +116,9 @@ $QEMU_IMG map --output=3Djson --image-opts \
>  nbd_server_start_unix_socket -r -f qcow2 -B b2 "$TEST_IMG"
>  $QEMU_IMG map --output=3Djson --image-opts \
>      "$IMG,x-dirty-bitmap=3Dqemu:dirty-bitmap:b2" | _filter_qemu_img_map
> +nbd_server_start_unix_socket -r -f qcow2 -B b3 "$TEST_IMG"

Why not look into $TEST_IMG.base to see specifically whether the bitmap
is there?

(I also am quite surprised that it=E2=80=99s even possible to export bitmap=
s
from backing nodes, but, well.)

Max


--gV7FH1UhGR1z1zDqNt72qOyUtnsP4LBX1--

--aqqpdLzvAcAdfFU0AVaJ5i5d26uki6wPc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl9bNdcACgkQ9AfbAGHV
z0AvRQf+JBSuUlqxdRTLCAKVX1SKBAiCCvShsDCKEUJPQmqHo9LuC8xY0NOkey8w
K8O4wq9B97lYqi6PCtSqg3sNk1v/RGtdOUsstSKMrSBdgn61IBrou+4h090RUOxp
Z3p2Bm2Ugg/zJAv8At+ZKrHBOZm1Sfni3kNvTLYHHc6OsBIwPYy3pE9zMZt1rooC
tqbR5skzQKzw8XsSWLLqBlpxxGw8kRi/owAfMY7TZnd8LEP/c3sTGAQgWy9Tn99u
raMoemfcyJ82PLvk5GC/RNUk2UGYJgu4V9qO+yaI0g84TY+7v8n1D+hQtE9pRKeX
JLIVbLp0KNDzzFS3PhDR5F4bKnb/kg==
=ny26
-----END PGP SIGNATURE-----

--aqqpdLzvAcAdfFU0AVaJ5i5d26uki6wPc--


