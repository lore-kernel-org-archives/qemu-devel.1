Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B832FC10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 10:59:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D9E724683
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 10:59:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VV/3M7AE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D9E724683
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57570 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBcbJ-0008Nx-Lc
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 06:59:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45094)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jBcaX-0007UA-U5
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 06:58:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1jBcaW-0003FX-UG
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 06:58:17 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50530
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1jBcaW-0003Ep-PB
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 06:58:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583837896;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=DEyJBOrb+cai9D4GAS3KKMomFZM2Tg1+XNHYdYdahwg=;
 b=VV/3M7AEIRhAZBbzmoeCuzThjoK5+kZbaCK+T27MBnidHvkQk79ap0qaG1cbZ1vkYBAmEE
 0NPY7MUe5PpKcCBJREtcpJPPQnWXIaYuQYZ3rJwnP/aWX66BIE7kQRm1rjCpynqCZPqdZG
 /+OP7l3tsBR27SutdphBSW0GKuBlGhs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-312-9nsUccUTOEueVviSsYOhqw-1; Tue, 10 Mar 2020 06:58:14 -0400
X-MC-Unique: 9nsUccUTOEueVviSsYOhqw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4ED6D10115F9;
 Tue, 10 Mar 2020 10:58:13 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.36.118.149])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C0364909FA;
 Tue, 10 Mar 2020 10:58:03 +0000 (UTC)
Subject: Re: [PATCH v2 02/14] qcrypto/luks: implement encryption key management
To: Maxim Levitsky <mlevitsk@redhat.com>, qemu-devel@nongnu.org
References: <20200308151903.25941-1-mlevitsk@redhat.com>
 <20200308151903.25941-3-mlevitsk@redhat.com>
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
Message-ID: <704e841b-a5e1-2bea-0a1f-1b6fe1058a17@redhat.com>
Date: Tue, 10 Mar 2020 11:58:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200308151903.25941-3-mlevitsk@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="yH4xbau4Gst5kdmZlvhEq6Wuk8NLpyi0k"
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--yH4xbau4Gst5kdmZlvhEq6Wuk8NLpyi0k
Content-Type: multipart/mixed; boundary="Bcg8d40f1OHoJtyWmF7spzGYUo1uYZlDy"

--Bcg8d40f1OHoJtyWmF7spzGYUo1uYZlDy
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 08.03.20 16:18, Maxim Levitsky wrote:
> Next few patches will expose that functionality
> to the user.
>=20
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> ---
>  crypto/block-luks.c | 398 +++++++++++++++++++++++++++++++++++++++++++-
>  qapi/crypto.json    |  61 ++++++-
>  2 files changed, 455 insertions(+), 4 deletions(-)

[...]

> +##
> +# @QCryptoBlockAmendOptionsLUKS:
> +#
> +# This struct defines the update parameters that activate/de-activate se=
t
> +# of keyslots
> +#
> +# @state: the desired state of the keyslots
> +#
> +# @new-secret:    The ID of a QCryptoSecret object providing the passwor=
d to be
> +#                 written into added active keyslots
> +#
> +# @old-secret:    Optional (for deactivation only)
> +#                 If given will deactive all keyslots that
> +#                 match password located in QCryptoSecret with this ID
> +#
> +# @iter-time:     Optional (for activation only)
> +#                 Number of milliseconds to spend in
> +#                 PBKDF passphrase processing for the newly activated ke=
yslot.
> +#                 Currently defaults to 2000.
> +#
> +# @keyslot:       Optional. ID of the keyslot to activate/deactivate.
> +#                 For keyslot activation, keyslot should not be active a=
lready
> +#                 (this is unsafe to update an active keyslot),
> +#                 but possible if 'force' parameter is given.
> +#                 If keyslot is not given, first free keyslot will be wr=
itten.
> +#
> +#                 For keyslot deactivation, this parameter specifies the=
 exact
> +#                 keyslot to deactivate
> +#
> +# @unlock-secret: Optional. The ID of a QCryptoSecret object providing t=
he
> +#                 password to use to retrive current master key.
> +#                 Defaults to the same secret that was used to open the =
image

So this matches Markus=E2=80=99 proposal except everything is flattened (be=
cause
we don=E2=80=99t support nested unions, AFAIU).  Sounds OK to me.  The only
difference is @unlock-secret, which did not appear in his proposal.  Why
do we need it again?

Max


--Bcg8d40f1OHoJtyWmF7spzGYUo1uYZlDy--

--yH4xbau4Gst5kdmZlvhEq6Wuk8NLpyi0k
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl5ncrkACgkQ9AfbAGHV
z0Cs2ggAngwy5bTpD7n5eJGEados6puQupwP9CR6SOOBVHAQPMdpDDcbj3tLlNpk
AcEEqO+R3Kf65xR3PcbFsTLeeI0uQXjW8zTbEDVRkG/s/jZNa421BqltnmFg4gRL
iLrTLJigxBkliqHirl1745oW93/6CaoePIe9utsAOuAX9RWP4DeVsMiZtoQx8SCb
/c+xAzZeqKxkUPv6mT4MufvFgkA7mXx3fssunuSKVRPGROyShYV3DLCC64mKwv/B
NuqGIhZ4nqAoVLpmVuZRJRBzFYPk3GqcL87HUgC1Hlwtos8oq3FfbzESR3k1LCi5
+ME6VGS/MXY+Te2K8SnxPLs81uB62Q==
=AXpq
-----END PGP SIGNATURE-----

--yH4xbau4Gst5kdmZlvhEq6Wuk8NLpyi0k--


