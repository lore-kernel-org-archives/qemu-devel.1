Return-Path: <SRS0=Szrt=YV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED44ECA9EC0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 11:23:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5C522086D
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 11:23:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IF/ZU75z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5C522086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52618 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iP375-00027v-8a
	for qemu-devel@archiver.kernel.org; Mon, 28 Oct 2019 07:23:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44424)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iP34n-0007Vt-OL
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 07:20:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iP2vS-0001SH-8C
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 07:11:07 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:52431
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iP2vS-0001S6-3O
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 07:11:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572261065;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=EA4nX+LBSUW3Lb9wcm5Kmt7VZ+aZCtsp8pm8VNRzm/E=;
 b=IF/ZU75znIB1ZeBUR5HsS5gICrL60Mdjab0c++XwFYSDhi3ZSyW6jQOCuvJchNoqUGVIsI
 LYIsFDGewoIu4KGsX60iKoWjM9oIsRATsxLW9jU3lKehOom/YUhFp4tyMyXBrYk5vHg2ii
 Wz8x3W6hm6E5BIGm+Kyma9cJg2sQo84=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-124-K7Ju_c0VMIOZehv6dJWADw-1; Mon, 28 Oct 2019 07:11:01 -0400
X-MC-Unique: K7Ju_c0VMIOZehv6dJWADw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ECDF9800D5F;
 Mon, 28 Oct 2019 11:10:59 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-83.ams2.redhat.com
 [10.36.117.83])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EC26667600;
 Mon, 28 Oct 2019 11:10:55 +0000 (UTC)
Subject: Re: [PATCH 0/8] block: Add @exact parameter to bdrv_co_truncate()
To: qemu-block@nongnu.org
References: <20190918095144.955-1-mreitz@redhat.com>
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
Message-ID: <0dbdc19b-c740-92e1-4ee7-294d3d7581e1@redhat.com>
Date: Mon, 28 Oct 2019 12:10:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20190918095144.955-1-mreitz@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="yBBtTOcrqWgaU6ApJEKiI8nbLj6PMeLkJ"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
 qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Maxim Levitsky <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--yBBtTOcrqWgaU6ApJEKiI8nbLj6PMeLkJ
Content-Type: multipart/mixed; boundary="DfuUGou6JQGaPermJIjMsnzC1fxRzDwT5"

--DfuUGou6JQGaPermJIjMsnzC1fxRzDwT5
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 18.09.19 11:51, Max Reitz wrote:
> Hi,
>=20
> This series is supposed to pull out some of the problems from my
> =E2=80=9CGeneric file creation fallback=E2=80=9D series.
>=20
> The blk_truncate_for_formatting() function added there was buggy, as
> Maxim noted, in that it did not check whether blk_truncate() actually
> resized the block node to the target offset.  One way to fix this is to
> add a parameter to it that forces the block driver to do so, and that is
> done by this series.
>=20
> I think this is generally useful (you can see the diff stat saldo is
> only +23 lines), because it allows us to drop a special check in
> qemu-img resize, and it fixes a bug in qed (which has relied on this
> behavior for over 8 years, but unfortunately bdrv_truncate()=E2=80=99s be=
havior
> changed quite exactly 8 years ago).
>=20
> However, in the process I noticed we actually don=E2=80=99t need
> blk_truncate_for_formatting(): The underlying problem is that some
> format drivers truncate their underlying file node to 0 before
> formatting it to drop all data.  So they should pass exact=3Dtrue, but
> they cannot, because this would break creation on block devices.  Hence
> blk_truncate_for_formatting().
>=20
> It turns out, though, that three of the four drivers in question don=E2=
=80=99t
> need to truncate their file node at all.  The remaining one is qed which
> simply really should pass exact=3Dtrue (it=E2=80=99s a bug fix).
>=20
> (I do drop those blk_truncate() invocations in this series, because
> otherwise I feel like it is impossible to decide whether they should get
> exact=3Dfalse or exact=3Dtrue.  Either way is wrong.)

Thanks for the review, I=E2=80=99ve applied the series to my block branch a=
nd
changed the comment in qed.c as requested and suggested by Maxim on patch 7=
:

https://git.xanclic.moe/XanClic/qemu/commits/branch/block

Max


--DfuUGou6JQGaPermJIjMsnzC1fxRzDwT5--

--yBBtTOcrqWgaU6ApJEKiI8nbLj6PMeLkJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl22zL4ACgkQ9AfbAGHV
z0BFvAgAoRgG5m6J/MnfL+xDj0uBA6vDUlwZ3srH0V/6O1/2hgnv47nr0HD/NvQp
bQc8AmR68r0NWhFq57Y6hi3Vjgoz1tFRJRFEAM1y9mzJX2848eh2QFnKtecGNOTe
J5eiv2B3DzeyykCZ/PNsMizhRwkSLJ+pH9H9IMDElaaxw/JVRRBOEhNfyhPZ9OVD
RLYnirHhES73TjNo9Xyni2nQ5JhP3hj/Jf1lFFKqCp8oS2GOR2wX5xzrFY0dLAOm
GkFU6uKWq27UPk2uW5iEM19dGIYC8aD7+2+6Moe1CGrClf4Gt5WxUPSnTPcNQU9z
sqa+BNmiMvSjL8JYQOqkbyUtJkIDJg==
=2dKI
-----END PGP SIGNATURE-----

--yBBtTOcrqWgaU6ApJEKiI8nbLj6PMeLkJ--


