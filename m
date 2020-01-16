Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 886DBC33CB1
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 12:21:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57BAB207FF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 12:21:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iau89rHh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57BAB207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40810 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1is48y-00076J-Bo
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 07:21:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33022)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1is47q-0006DF-NS
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 07:19:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1is47p-0004zg-D6
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 07:19:50 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:26310
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1is47p-0004zI-8u
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 07:19:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579177188;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=v7z88CQx5KZUqnHeCpMFUUOvqarAVu0gAlSCF7hMOUI=;
 b=iau89rHhBJOZ1wgxo1JeX8gAQUTCE070AxjypNH5HK8/FdgdnR/t2RZqWbQOyRT//vy9/G
 sV6nFcXKSKNc9OIS5Z0J5XL+PG09+jxbc5fuwtahGq4G4Yerra0t+gTKF33dzl2pNGjtVv
 jrvjdaC7+RN8wAqkMI3pexMyKN164hk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-130-t0PRHmgFMleR5p2ZsunmTg-1; Thu, 16 Jan 2020 07:19:41 -0500
X-MC-Unique: t0PRHmgFMleR5p2ZsunmTg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 833F31800D48;
 Thu, 16 Jan 2020 12:19:40 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-185.ams2.redhat.com
 [10.36.117.185])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1182980890;
 Thu, 16 Jan 2020 12:19:35 +0000 (UTC)
Subject: Re: [PATCH v2] qcow2: Use a GString in report_unsupported_feature()
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
References: <20200115135626.19442-1-berto@igalia.com>
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
Message-ID: <7dc5a8bf-bb1d-aeec-ef3e-6e60597bbcb8@redhat.com>
Date: Thu, 16 Jan 2020 13:19:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200115135626.19442-1-berto@igalia.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="9Lppwuk5zBQWei7egBfiU2HYALZp2f52p"
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9Lppwuk5zBQWei7egBfiU2HYALZp2f52p
Content-Type: multipart/mixed; boundary="NFi3sdbdFXdEKT8OZgWLwQ5eEWiETX1Tz"

--NFi3sdbdFXdEKT8OZgWLwQ5eEWiETX1Tz
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 15.01.20 14:56, Alberto Garcia wrote:
> This is a bit more efficient than having to allocate and free memory
> for each item.
>=20
> The default size (60) is enough for all the existing incompatible
> features or the "Unknown incompatible feature" message.

That doesn=E2=80=99t make sense to me.  The existing incompatible features =
are
known to qemu, and as such will never be printed here.

But just because it doesn=E2=80=99t make sense doesn=E2=80=99t make it wron=
g.  I suppose
we can assume that if new features are added, they will have a similar
length like the ones we have now.

(Well, it does make =E2=80=9C60=E2=80=9D a weirdly specific number, but wha=
tever.)

((I=E2=80=99d just have created an empty string.  Considering this is part =
of
the explanation for a fatal error, nobody cares whether this function
takes a couple of microseconds more.  Or maybe a length of 47, so it can
definitely hold exactly one incompatible feature name.))

> Suggested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  block/qcow2.c | 23 +++++++++++------------
>  1 file changed, 11 insertions(+), 12 deletions(-)

Thanks, applied to my block branch:

https://git.xanclic.moe/XanClic/qemu/commits/branch/block

> diff --git a/block/qcow2.c b/block/qcow2.c
> index cef9d72b3a..e29fc07068 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c

[...]

> @@ -470,14 +469,14 @@ static void report_unsupported_feature(Error **errp=
, Qcow2Feature *table,
>      }
> =20
>      if (mask) {
> -        old =3D features;
> -        features =3D g_strdup_printf("%s%sUnknown incompatible feature: =
%" PRIx64,
> -                                   old, *old ? ", " : "", mask);
> -        g_free(old);
> +        if (features->len > 0) {
> +            g_string_append(features, ", ");
> +        }
> +        g_string_append_printf(features,
> +                               "Unknown incompatible feature: %" PRIx64,=
 mask);

Existing problem: This can lead to stuff like

=E2=80=9CUnsupported qcow2 feature(s): feat1, feat2, Unknown incompatible
feature: 0xec0=E2=80=9D

(i.e., singular =E2=80=9Cfeature=E2=80=9D when there are multiple unknown f=
eatures, and
capitalization of =E2=80=9CUnknown=E2=80=9D)

O:-)

But whatever.  It=E2=80=99s unlikely there=E2=80=99s going to be more than =
one
incompatible feature, and it=E2=80=99s extremely unlikely it won=E2=80=99t =
have a string
description.

Max


--NFi3sdbdFXdEKT8OZgWLwQ5eEWiETX1Tz--

--9Lppwuk5zBQWei7egBfiU2HYALZp2f52p
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl4gVNYACgkQ9AfbAGHV
z0AtHQf/Xr7FuwsKB5CpUPNZhoPQyzeLsoPfqBu1j5jnYP6+QWfhmHDPd1O7jJSb
lASgIli9OheUe7BXqjdDBKGaWhSo5Tc7RgpS1YgZOFbH6BLMZ2Xmi9PGYheslxWP
SKbufcpBzZT0wOlwiH/DccIgHB25hT9uTQ8nGqdg8H5VR7OICpTSel+wX5/UtWJQ
JHQZu3auKiM+rL56PbzJy5l7f/3TvqIzrLeq4ZXcEjf7sKroI6Tj9lY7DK67LQ1X
WTbN75DAsdVjdHf1EHBg6oboo5S1Kzx+igOjr3pPo7VpNOx5DxIHLgOb2ZzQUMW/
HelC2zF6Jy8g7YavOOAlmhlnrgNezw==
=LzxC
-----END PGP SIGNATURE-----

--9Lppwuk5zBQWei7egBfiU2HYALZp2f52p--


