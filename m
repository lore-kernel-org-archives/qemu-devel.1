Return-Path: <SRS0=zL9l=BA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8904FC433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 10:20:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53F5E2072E
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 10:20:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A0W6aMGK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53F5E2072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48676 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxpNc-0007wz-Il
	for qemu-devel@archiver.kernel.org; Tue, 21 Jul 2020 06:20:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54256)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jxpMu-0007SL-Qg
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 06:19:28 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:42633
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jxpMr-0001Wu-Ri
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 06:19:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595326764;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=FXup7xXHhVVFHsknqi0ed/hkySOcmjxVCT0BOvRGMwY=;
 b=A0W6aMGKLE09YFV+GEYHvFVLqlXWoGZd0e5WJLXeF4mRFYZJ5n8j3Et++AV02VevXzhoWz
 arP6j+P3nVO3PY1Qb2rb6s/ON48Jx0+XjCpwtancQJMnZvFApYc/rDdg+uzNkGFiyFO9I3
 VwCSBlpiaewzrcROm1fq4j884pHMBTQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-168-bbcPlbbnPRydV08MK3Envg-1; Tue, 21 Jul 2020 06:19:21 -0400
X-MC-Unique: bbcPlbbnPRydV08MK3Envg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E7AD2100A621;
 Tue, 21 Jul 2020 10:19:20 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-68.ams2.redhat.com
 [10.36.113.68])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D879910027AC;
 Tue, 21 Jul 2020 10:19:19 +0000 (UTC)
Subject: Re: [PATCH for-5.1 2/2] iotests: Test sparseness for qemu-img convert
 -n
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
References: <20200720131810.177978-1-kwolf@redhat.com>
 <20200720131810.177978-3-kwolf@redhat.com>
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
Message-ID: <4197f423-6501-b7d4-9214-6c7979d77bd7@redhat.com>
Date: Tue, 21 Jul 2020 12:19:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200720131810.177978-3-kwolf@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="SFJHRlEpSEod2qcKY9bLoUA5xstqrVsUA"
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/21 01:30:29
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
--SFJHRlEpSEod2qcKY9bLoUA5xstqrVsUA
Content-Type: multipart/mixed; boundary="hpy6tNE3xOryjxBx9ryyfF2LjZySDFO2P"

--hpy6tNE3xOryjxBx9ryyfF2LjZySDFO2P
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 20.07.20 15:18, Kevin Wolf wrote:
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  tests/qemu-iotests/122     | 34 ++++++++++++++++++++++++++++++++++
>  tests/qemu-iotests/122.out | 17 +++++++++++++++++
>  2 files changed, 51 insertions(+)
>=20
> diff --git a/tests/qemu-iotests/122 b/tests/qemu-iotests/122
> index dfd1cd05d6..1112fc0730 100755
> --- a/tests/qemu-iotests/122
> +++ b/tests/qemu-iotests/122
> @@ -281,6 +281,40 @@ $QEMU_IMG convert -O $IMGFMT -n "$TEST_IMG" "$TEST_I=
MG".orig
> =20
>  $QEMU_IMG compare "$TEST_IMG" "$TEST_IMG".orig
> =20
> +echo
> +echo '=3D=3D=3D -n to an empty image =3D=3D=3D'
> +echo
> +
> +_make_test_img 64M
> +
> +# Convert with -n, which should not result in a fully allocated image, n=
ot even
> +# with compat=3D0.10 (because the target doesn't have a backing file)
> +TEST_IMG=3D"$TEST_IMG".orig _make_test_img -o compat=3D1.1 64M
> +$QEMU_IMG convert -O $IMGFMT -n "$TEST_IMG" "$TEST_IMG".orig
> +$QEMU_IMG map --output=3Djson "$TEST_IMG".orig
> +
> +TEST_IMG=3D"$TEST_IMG".orig _make_test_img -o compat=3D0.10 64M

It=E2=80=99s a shame that with this, the test will no longer pass with
refcount_bits=3D1.  (Or an external data file.)

But, well.  Maybe we don=E2=80=99t care and then should just put both optio=
ns
into _unsupported_imgopts.

Apart from that, the test looks good to me.

Max

> +$QEMU_IMG convert -O $IMGFMT -n "$TEST_IMG" "$TEST_IMG".orig
> +$QEMU_IMG map --output=3Djson "$TEST_IMG".orig
> +
> +echo
> +echo '=3D=3D=3D -n to an empty image with a backing file =3D=3D=3D'
> +echo
> +
> +_make_test_img 64M
> +TEST_IMG=3D"$TEST_IMG".base _make_test_img 64M
> +
> +# Convert with -n, which should still not result in a fully allocated im=
age for
> +# compat=3D1.1 (because it can use zero clusters), but it should be full=
y
> +# allocated with compat=3D0.10
> +TEST_IMG=3D"$TEST_IMG".orig _make_test_img -b "$TEST_IMG".base -F $IMGFM=
T -o compat=3D1.1 64M
> +$QEMU_IMG convert -O $IMGFMT -n "$TEST_IMG" "$TEST_IMG".orig
> +$QEMU_IMG map --output=3Djson "$TEST_IMG".orig
> +
> +TEST_IMG=3D"$TEST_IMG".orig _make_test_img -b "$TEST_IMG".base -F $IMGFM=
T -o compat=3D0.10 64M
> +$QEMU_IMG convert -O $IMGFMT -n "$TEST_IMG" "$TEST_IMG".orig
> +$QEMU_IMG map --output=3Djson "$TEST_IMG".orig
> +
>  echo
>  echo '=3D=3D=3D -n -B to an image without a backing file =3D=3D=3D'
>  echo
> diff --git a/tests/qemu-iotests/122.out b/tests/qemu-iotests/122.out
> index f1f195ed77..b8028efb1d 100644
> --- a/tests/qemu-iotests/122.out
> +++ b/tests/qemu-iotests/122.out
> @@ -229,6 +229,23 @@ wrote 65536/65536 bytes at offset 0
>  64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>  Images are identical.
> =20
> +=3D=3D=3D -n to an empty image =3D=3D=3D
> +
> +Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864
> +Formatting 'TEST_DIR/t.IMGFMT.orig', fmt=3DIMGFMT size=3D67108864
> +[{ "start": 0, "length": 67108864, "depth": 0, "zero": true, "data": fal=
se}]
> +Formatting 'TEST_DIR/t.IMGFMT.orig', fmt=3DIMGFMT size=3D67108864
> +[{ "start": 0, "length": 67108864, "depth": 0, "zero": true, "data": fal=
se}]
> +
> +=3D=3D=3D -n to an empty image with a backing file =3D=3D=3D
> +
> +Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864
> +Formatting 'TEST_DIR/t.IMGFMT.base', fmt=3DIMGFMT size=3D67108864
> +Formatting 'TEST_DIR/t.IMGFMT.orig', fmt=3DIMGFMT size=3D67108864 backin=
g_file=3DTEST_DIR/t.IMGFMT.base backing_fmt=3DIMGFMT
> +[{ "start": 0, "length": 67108864, "depth": 0, "zero": true, "data": fal=
se}]
> +Formatting 'TEST_DIR/t.IMGFMT.orig', fmt=3DIMGFMT size=3D67108864 backin=
g_file=3DTEST_DIR/t.IMGFMT.base backing_fmt=3DIMGFMT
> +[{ "start": 0, "length": 67108864, "depth": 0, "zero": false, "data": tr=
ue, "offset": 327680}]
> +
>  =3D=3D=3D -n -B to an image without a backing file =3D=3D=3D
> =20
>  Formatting 'TEST_DIR/t.IMGFMT.base', fmt=3DIMGFMT size=3D67108864
>=20



--hpy6tNE3xOryjxBx9ryyfF2LjZySDFO2P--

--SFJHRlEpSEod2qcKY9bLoUA5xstqrVsUA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl8WwSYACgkQ9AfbAGHV
z0Ckzwf+M0aaauPAUf4T2lvc1lF/ONQNb0lzixo13lxAg5MT7T0ivqVMUSPmxh7d
4tbxb1kxKHzTPCYvbJ/o+UW52A5Z/0fqjEKLLYzHzjnxMdFieedphC6NryQ/tIjN
OPu90Ln7hPxSCixKoGZ0ieJ1lITvydEiP90UckDQkOq7cd+V9Lsl0VUYkSwo/hFu
KDVDntn+tNBvfKl5Q1hzHairDaexLnt5IkSmLUYAZhTMxjrmjdJuKnmKs2b5btk8
ROc2SWjMOhekruhD1lROM2acNghBNDvw49CKAaiJNAOYYqS3vhXf7+LZJPg7KdkL
/MmkjlHz1lVD6nZuxNr+RXU4WfOl9w==
=AWqG
-----END PGP SIGNATURE-----

--SFJHRlEpSEod2qcKY9bLoUA5xstqrVsUA--


