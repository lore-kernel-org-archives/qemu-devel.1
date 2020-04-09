Return-Path: <SRS0=qpXq=5Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2864C2BA2B
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 10:28:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A42A520771
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 10:28:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T9irebrR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A42A520771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47508 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMUQ8-00025g-Sp
	for qemu-devel@archiver.kernel.org; Thu, 09 Apr 2020 06:28:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38542)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jMUPV-0001cC-Q1
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 06:27:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1jMUPU-0006ER-2J
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 06:27:49 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:45537
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1jMUPT-0006EJ-Te
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 06:27:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586428067;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=c4ovUuOvHpmyVygIIq1kRDNxA9avNYLyEMX7a5gMqDk=;
 b=T9irebrRYPnpe6NecvIMoajW5bhs3QfMws5H1huYGNnaBS0viPcoTifS8UqU0cbn04rmuL
 mv6QoRSpBVT5AhUFad7bfEhi4tFA44gAXcI84l0zsM/hKpxM2gmah/S/QQy2XedqdpMlJf
 WgYocVF8eD4cpDUTJFobOrUFLM1Hds8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-44-JekozS_cPJiaJIzMpQnPGg-1; Thu, 09 Apr 2020 06:27:45 -0400
X-MC-Unique: JekozS_cPJiaJIzMpQnPGg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A30158017F3;
 Thu,  9 Apr 2020 10:27:43 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-114-98.ams2.redhat.com
 [10.36.114.98])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DE28E5DA7C;
 Thu,  9 Apr 2020 10:27:38 +0000 (UTC)
Subject: Re: [PATCH v4 27/30] qcow2: Assert that expand_zero_clusters_in_l1()
 does not support subclusters
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
References: <cover.1584468723.git.berto@igalia.com>
 <5cc70489bfeb7d2f8f6c8a113dc530cab504db9e.1584468723.git.berto@igalia.com>
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
Message-ID: <45fe195e-4635-de14-39af-1f44a155c102@redhat.com>
Date: Thu, 9 Apr 2020 12:27:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <5cc70489bfeb7d2f8f6c8a113dc530cab504db9e.1584468723.git.berto@igalia.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="cXouK6MyzKmbi79LVluiLG4rnr04oN8P6"
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
Cc: Kevin Wolf <kwolf@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>,
 qemu-block@nongnu.org, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "Denis V . Lunev" <den@openvz.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--cXouK6MyzKmbi79LVluiLG4rnr04oN8P6
Content-Type: multipart/mixed; boundary="q5nEhnTOOd3DMVGahhnnQ3CMRSskxLCdf"

--q5nEhnTOOd3DMVGahhnnQ3CMRSskxLCdf
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 17.03.20 19:16, Alberto Garcia wrote:
> This function is only used by qcow2_expand_zero_clusters() to
> downgrade a qcow2 image to a previous version. It is however not
> possible to downgrade an image with extended L2 entries because older
> versions of qcow2 do not have this feature.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  block/qcow2-cluster.c      | 8 +++++++-
>  tests/qemu-iotests/061     | 6 ++++++
>  tests/qemu-iotests/061.out | 5 +++++
>  3 files changed, 18 insertions(+), 1 deletion(-)

[...]

> diff --git a/tests/qemu-iotests/061 b/tests/qemu-iotests/061
> index 36b040491f..66bfd23179 100755
> --- a/tests/qemu-iotests/061
> +++ b/tests/qemu-iotests/061
> @@ -266,6 +266,12 @@ $QEMU_IMG amend -o "compat=3D0.10" "$TEST_IMG"
>  _img_info --format-specific
>  _check_test_img
> =20
> +echo
> +echo "=3D=3D=3D Testing version downgrade with extended L2 entries =3D=
=3D=3D"
> +echo
> +_make_test_img -o "compat=3D1.1,extended_l2=3Don" 64M
> +$QEMU_IMG amend -o "compat=3D0.10" "$TEST_IMG"
> +
>  echo
>  echo "=3D=3D=3D Try changing the external data file =3D=3D=3D"
>  echo
> diff --git a/tests/qemu-iotests/061.out b/tests/qemu-iotests/061.out
> index 8b3091a412..5d009867a2 100644
> --- a/tests/qemu-iotests/061.out
> +++ b/tests/qemu-iotests/061.out
> @@ -498,6 +498,11 @@ Format specific information:
>      corrupt: false
>  No errors were found on the image.
> =20
> +=3D=3D=3D Testing version downgrade with extended L2 entries =3D=3D=3D
> +
> +Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864
> +qemu-img: Cannot downgrade an image with incompatible features 0x10 set

This test fails in this commit, because extended_l2 is only available
after the next commit.  The code changes and the test itself look good
to me, though.

Max


--q5nEhnTOOd3DMVGahhnnQ3CMRSskxLCdf--

--cXouK6MyzKmbi79LVluiLG4rnr04oN8P6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl6O+JgACgkQ9AfbAGHV
z0D2nQgAk4UKAj2+Jbs2Ofqeif4yeboysoqxTCLT22erZ00whnf/vjz3rZkNM04y
BU9+NiOy9PJDUYI5quJu9SDb8txAXDkefbqvoSdEeUWSkLG+cEjG43STblz1yHE/
vGdSWeA0mj8gcg7d6HX4lHIPKKTs2xueLa5nQQ8VXYiN6a3c3GeBgZM/eaSwUm5v
jY5ZGcfrHihUirz5Vmp1T6spYfO4t1OS/rFFeixXH2i34BmYNEnHsReGl2EavXqj
RZTS8XH+2F/ixBbxkBjZpOBYkXh5uhMYf4u2O3bzeSN34dKKXlKnUQU7e9fKi4y+
/2jWMqbHd7xV5zUgV6aCW3HnkgPJMw==
=MWL4
-----END PGP SIGNATURE-----

--cXouK6MyzKmbi79LVluiLG4rnr04oN8P6--


