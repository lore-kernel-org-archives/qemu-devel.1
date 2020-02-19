Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8CDDC34047
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 15:47:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B142D2464E
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 15:47:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b9dGjgiz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B142D2464E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54862 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4RZp-0001jX-UN
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 10:47:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33754)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1j4RYm-0000k2-Od
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 10:46:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1j4RYl-00071j-Rn
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 10:46:48 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:41975
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1j4RYl-00071H-NX
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 10:46:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582127207;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=iuW1eRYykCV9rY8diD3DLr0DKd9UeOEkWaD0fH9/1nY=;
 b=b9dGjgizbU9R5lJUUJoDX30z76CbwcKMHO/gWF09AcWoZDh8LWZFVZ5Bc5AX7IgeEFUM6T
 b/aOCaduCRWyFSOdMVXEudp20eFB0b1L7l9ynvrgZbbs4HuPTZDZQB4X0CEZ3i1En8kf92
 07eLbIu5nti8c2lD4U0/tXm6yfkntww=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-240-izPdwloTMnaFa6LhGZEGVA-1; Wed, 19 Feb 2020 10:46:42 -0500
X-MC-Unique: izPdwloTMnaFa6LhGZEGVA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 57C0D1800D42;
 Wed, 19 Feb 2020 15:46:41 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-32.ams2.redhat.com
 [10.36.117.32])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1E4B048;
 Wed, 19 Feb 2020 15:46:36 +0000 (UTC)
Subject: Re: [PATCH v3 2/4] luks: implement .bdrv_measure()
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
References: <20200211160318.453650-1-stefanha@redhat.com>
 <20200211160318.453650-3-stefanha@redhat.com>
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
Message-ID: <f93c484a-39e6-2745-e493-a9c2ed0a83c2@redhat.com>
Date: Wed, 19 Feb 2020 16:46:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200211160318.453650-3-stefanha@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="OMaAqtHwpc2FMw1UZlW3GMsOZhWDr7R59"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--OMaAqtHwpc2FMw1UZlW3GMsOZhWDr7R59
Content-Type: multipart/mixed; boundary="OBe5wfg7Lu8yKir6IWi2CBjMiREw2sqMz"

--OBe5wfg7Lu8yKir6IWi2CBjMiREw2sqMz
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 11.02.20 17:03, Stefan Hajnoczi wrote:
> Add qemu-img measure support in the "luks" block driver.
>=20
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  block/crypto.c | 62 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 62 insertions(+)
>=20
> diff --git a/block/crypto.c b/block/crypto.c
> index 24823835c1..453119875e 100644
> --- a/block/crypto.c
> +++ b/block/crypto.c
> @@ -484,6 +484,67 @@ static int64_t block_crypto_getlength(BlockDriverSta=
te *bs)

[...]

> +    cryptoopts =3D qemu_opts_to_qdict_filtered(opts, NULL,
> +            &block_crypto_create_opts_luks, true);
> +    qdict_put_str(cryptoopts, "format", "luks");
> +    create_opts =3D block_crypto_create_opts_init(cryptoopts, errp);

It looks a bit weird to me to use errp here...

> +    qobject_unref(cryptoopts);
> +    if (!create_opts) {
> +        goto err;
> +    }
> +
> +    if (!qcrypto_block_calculate_payload_offset(create_opts, NULL,
> +                                                &luks_payload_size,
> +                                                &local_err)) {

...and local_err here.  Either works, but consistent style would be a
bit nicer.

But not more correct, so:

Reviewed-by: Max Reitz <mreitz@redhat.com>

> +        goto err;
> +    }

[...]

> +err:
> +    error_propagate(errp, local_err);
> +    return NULL;
> +}


--OBe5wfg7Lu8yKir6IWi2CBjMiREw2sqMz--

--OMaAqtHwpc2FMw1UZlW3GMsOZhWDr7R59
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl5NWFoACgkQ9AfbAGHV
z0Ao9ggAoU/Bdl96JH2O/EFjEHHdr8XophDO0IfVSKSyKAVBr8Y3/FsQtEsRrBjr
4Om4Eeyyelm4NjNh6w/kjQHtcn78wOT1NrTe7Uuca2uIQNuq9ap3uqyJUj62m/97
/xCaf4PLvyt//SWdmqiK8/hHdMgdmc/jGuv9Tit10BnYY+zS96F1hemc3MAjzWgd
J2JY4tZ2ZZUEF0f4kyOaie62qpsifGUN6SvJvSLWgRWyi4Cef1g97fFi9sMaAvvx
TDMc4vYt54II+A03B7QS+iQObD4jusix5rb7hYszCyMEvRp2F0+9Glbtewm/69pF
UiSF8XsSFZCJA4oo5R4dZfgQotPdfw==
=vj/X
-----END PGP SIGNATURE-----

--OMaAqtHwpc2FMw1UZlW3GMsOZhWDr7R59--


