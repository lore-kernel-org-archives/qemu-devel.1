Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED712C34047
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 13:04:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B987124656
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 13:04:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LE4bmOm/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B987124656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52268 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4P24-0000Nn-UX
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 08:04:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34572)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1j4P1F-00089P-B8
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 08:04:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1j4P1E-0005uo-AZ
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 08:04:01 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45654
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1j4P1E-0005tt-4t
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 08:04:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582117439;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=L5woXtXlNGIUu/nyp+d/LzDfEyXlMGujZTBKIjwlUeM=;
 b=LE4bmOm/ZA9wixPscM1VyByqZ8gU0UaOejb+ISU3q2Uf4c1b/5d59ohjx6tneHhOS168jd
 LLfWNwnPXB3R8/YqKiQ45RV8i/hmepnyMwBMHeUd2COZHqldgYOpJXTGgzPIAL5h3GIvCk
 nIfIruKmNm8Zm5reIF0UNzROOw1COIM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-217-yavPsP_LOoOVEkZ2hlaiOQ-1; Wed, 19 Feb 2020 08:03:57 -0500
X-MC-Unique: yavPsP_LOoOVEkZ2hlaiOQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0448E800D53;
 Wed, 19 Feb 2020 13:03:56 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-116-152.ams2.redhat.com
 [10.36.116.152])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4E5F35C219;
 Wed, 19 Feb 2020 13:03:52 +0000 (UTC)
Subject: Re: [PATCH v3 1/4] luks: extract
 qcrypto_block_calculate_payload_offset()
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
References: <20200211160318.453650-1-stefanha@redhat.com>
 <20200211160318.453650-2-stefanha@redhat.com>
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
Message-ID: <80432d24-cd1e-5321-0e7a-be998b3886fc@redhat.com>
Date: Wed, 19 Feb 2020 14:03:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200211160318.453650-2-stefanha@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="kIAp1MbgRdNrX2W12yskW04MzkfnOr1de"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--kIAp1MbgRdNrX2W12yskW04MzkfnOr1de
Content-Type: multipart/mixed; boundary="DVzj1QpK8e32TQ7rJhr2S0OZLXWge9XdB"

--DVzj1QpK8e32TQ7rJhr2S0OZLXWge9XdB
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 11.02.20 17:03, Stefan Hajnoczi wrote:
> The qcow2 .bdrv_measure() code calculates the crypto payload offset.
> This logic really belongs in crypto/block.c where it can be reused by
> other image formats.
>=20
> The "luks" block driver will need this same logic in order to implement
> .bdrv_measure(), so extract the qcrypto_block_calculate_payload_offset()
> function now.
>=20
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  block/qcow2.c          | 74 +++++++++++-------------------------------
>  crypto/block.c         | 40 +++++++++++++++++++++++
>  include/crypto/block.h | 22 +++++++++++++
>  3 files changed, 81 insertions(+), 55 deletions(-)

[...]

> diff --git a/crypto/block.c b/crypto/block.c
> index 325752871c..a9e1b8cc36 100644
> --- a/crypto/block.c
> +++ b/crypto/block.c
> @@ -115,6 +115,46 @@ QCryptoBlock *qcrypto_block_create(QCryptoBlockCreat=
eOptions *options,

[...]

> +bool
> +qcrypto_block_calculate_payload_offset(QCryptoBlockCreateOptions *create=
_opts,
> +                                       const char *optprefix,
> +                                       size_t *len,
> +                                       Error **errp)
> +{
> +    QCryptoBlock *crypto;
> +    bool ok;
> +
> +    /* Fake LUKS creation in order to determine the payload size */
> +    crypto =3D qcrypto_block_create(create_opts, optprefix,
> +                                  qcrypto_block_headerlen_hdr_init_func,
> +                                  qcrypto_block_headerlen_hdr_write_func=
,
> +                                  len, errp);
> +    ok =3D crypto !=3D NULL;
> +    qcrypto_block_free(crypto);
> +    return ok;

Speaking of g_autoptr...  Would g_autoptr(QCryptoBlock) crypto; suffice
to contract these three lines into =E2=80=9Creturn crypto !=3D NULL;=E2=80=
=9D?

Either way:

Reviewed-by: Max Reitz <mreitz@redhat.com>


--DVzj1QpK8e32TQ7rJhr2S0OZLXWge9XdB--

--kIAp1MbgRdNrX2W12yskW04MzkfnOr1de
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl5NMjYACgkQ9AfbAGHV
z0COxQf+LCI0TnEKlHlv63oiL0Hx9Xh+U5bvOIyVO+fuO/zocLp4AeRr4URJq0rF
wuEgx3M2gJZMYmLw3we1O+FCyZupvBcQwCOIhs01M05lCw1agdy1ZeM5KHO/Bsqa
PmfHpk5tOx2btY+WUkd6tgnFsRnkMn1Zzqn9uxRG46AAlNcZ8zC6jWSCbAomxn+8
hFAvX+DSrEcV8F7KXwFQGuzwrrJJhILXi6x0y6Rq3IkVK0tNvRplAhO6iCS+d9eQ
DvpUnTUzu6eTOBYF0RoO5Id3gJK6RvfqzTqLrjQuehAAjPeOyTnkypaE1oD5SeBZ
4CGvgKnS9FD3lE72EGC70cbFOaRuqw==
=A6ES
-----END PGP SIGNATURE-----

--kIAp1MbgRdNrX2W12yskW04MzkfnOr1de--


