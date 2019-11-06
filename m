Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 936B1C5DF63
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 15:18:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E7992166E
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 15:18:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sId4Q3zu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E7992166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59996 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSN4q-0005tT-Gm
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 10:18:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41567)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1iSN3U-00051f-8L
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 10:17:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1iSN3T-0002ef-2C
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 10:17:08 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:55112)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1iSN3S-0002eG-RS
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 10:17:07 -0500
Received: by mail-wm1-x343.google.com with SMTP id z26so3902311wmi.4
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2019 07:17:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=6TGU49T+wNy3gSir3Z36XbHmNhzZ0baPhchg70jUj9Q=;
 b=sId4Q3zuoO0JWo11jICRjBuqiwTM00b9QwTmGXPdciqm6Y4uhZo0P+WX2ugfQ3zOGp
 jM0JExvma2s+e7e2UQxJZO8X9TW9/B+Cp4780wmu434FZs2fmzOUIwRVO8ycTtpDYI0/
 5pmJ0gPi2Ec1XZ2SpVu84vF/mJM27EMJMhWdlYfUEUdoj++um0zmfVPHIKQlCuElF4qe
 nEfMdVJhPq3g49MOfm+AwmjiAtinTsZ2Jblg2wEJtj3meSxQl4yUVzZ/UI9mVFx+hH+3
 u/J5lgvSBF4sYO1P4ooL/x4JUpCeGopFV48Y1nkG2grWiNbw+WDJqQrve6hOAGeb5NZU
 aJEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=6TGU49T+wNy3gSir3Z36XbHmNhzZ0baPhchg70jUj9Q=;
 b=Z9ApP2H2ISmQPr5biGjU5vZo2GFNhZbEDqPOm0vT3yqmgpNoFy2ZyRsm80ahg66B8V
 UgWsANUdBsyKBy/FjBp3E2r1eCoRAo0ZIbW9b0v20y/MjoLWla2dWXxDHbnoKEo7W8ZU
 +/YrtqjAUrMKKG2ld4UfngO9TDsuh8Il8u9tnxRVSCvQIvxZ8iqBg57jF+kHYI3KYkhR
 O9eh6TtJqjdorDkp7zNRyRec7AYcv4WzvCkPnd3pwYad/1eefS22Ju1MZkmO55crlSo5
 6vePsOTbsBdCwW3Qq4qYG0FKnPXeULttKKsZhwcu9faf21SJ/snUtUr5mwYXDlM8qFUy
 SfpQ==
X-Gm-Message-State: APjAAAVTMxZobrVQ4+kLai5i0W3xCLff5oZgIq3fKvexUvjhdktgnJFn
 KOT0pu2fCyahqj4YiQGxS8E=
X-Google-Smtp-Source: APXvYqyTVfrZHsMHjYDlchemSFiwKh/ABV8bD9z5GlIOlyrTM+ovj1llrShm5kcHes5q/OQFB29zEw==
X-Received: by 2002:a1c:10a:: with SMTP id 10mr3010803wmb.17.1573053425813;
 Wed, 06 Nov 2019 07:17:05 -0800 (PST)
Received: from localhost (178.165.129.116.wireless.dyn.drei.com.
 [178.165.129.116])
 by smtp.gmail.com with ESMTPSA id l4sm2847629wme.4.2019.11.06.07.17.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Nov 2019 07:17:04 -0800 (PST)
Date: Wed, 6 Nov 2019 16:17:03 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: "Oleinik, Alexander" <alxndr@bu.edu>
Subject: Re: [PATCH v4 02/20] libqos: Rename i2c_send and i2c_recv
Message-ID: <20191106151703.GB340561@stefanha-x1.localdomain>
References: <20191030144926.11873-1-alxndr@bu.edu>
 <20191030144926.11873-3-alxndr@bu.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="uQr8t48UFsdbeI+V"
Content-Disposition: inline
In-Reply-To: <20191030144926.11873-3-alxndr@bu.edu>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--uQr8t48UFsdbeI+V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 30, 2019 at 02:49:49PM +0000, Oleinik, Alexander wrote:
> diff --git a/tests/libqos/i2c-imx.c b/tests/libqos/i2c-imx.c
> index f33ece55a3..42ebf8ba3a 100644
> --- a/tests/libqos/i2c-imx.c
> +++ b/tests/libqos/i2c-imx.c
> @@ -37,7 +37,7 @@ static void imx_i2c_set_slave_addr(IMXI2C *s, uint8_t a=
ddr,
>                   (addr << 1) | (direction =3D=3D IMX_I2C_READ ? 1 : 0));
>  }
> =20
> -static void imx_i2c_send(I2CAdapter *i2c, uint8_t addr,
> +static void qimx_i2c_send(I2CAdapter *i2c, uint8_t addr,
>                           const uint8_t *buf, uint16_t len)
>  {
>      IMXI2C *s =3D container_of(i2c, IMXI2C, parent);
> @@ -97,7 +97,7 @@ static void imx_i2c_send(I2CAdapter *i2c, uint8_t addr,
>      g_assert((status & I2SR_IBB) =3D=3D 0);
>  }
> =20
> -static void imx_i2c_recv(I2CAdapter *i2c, uint8_t addr,
> +static void qimx_i2c_recv(I2CAdapter *i2c, uint8_t addr,
>                           uint8_t *buf, uint16_t len)
>  {
>      IMXI2C *s =3D container_of(i2c, IMXI2C, parent);
> @@ -202,8 +202,8 @@ void imx_i2c_init(IMXI2C *s, QTestState *qts, uint64_=
t addr)
> =20
>      s->obj.get_driver =3D imx_i2c_get_driver;
> =20
> -    s->parent.send =3D imx_i2c_send;
> -    s->parent.recv =3D imx_i2c_recv;
> +    s->parent.send =3D qimx_i2c_send;
> +    s->parent.recv =3D qimx_i2c_recv;

Why do the imx static functions need to be renamed?  Is this by
accident, maybe an aggressive sed command that touched all files?

>      s->parent.qts =3D qts;
>  }
> =20
> diff --git a/tests/libqos/i2c-omap.c b/tests/libqos/i2c-omap.c
> index 9ae8214fa8..5f4d79f87c 100644
> --- a/tests/libqos/i2c-omap.c
> +++ b/tests/libqos/i2c-omap.c
> @@ -50,7 +50,7 @@ static void omap_i2c_set_slave_addr(OMAPI2C *s, uint8_t=
 addr)
>      g_assert_cmphex(data, =3D=3D, addr);
>  }
> =20
> -static void omap_i2c_send(I2CAdapter *i2c, uint8_t addr,
> +static void qomap_i2c_send(I2CAdapter *i2c, uint8_t addr,
>                            const uint8_t *buf, uint16_t len)
>  {
>      OMAPI2C *s =3D container_of(i2c, OMAPI2C, parent);
> @@ -94,7 +94,7 @@ static void omap_i2c_send(I2CAdapter *i2c, uint8_t addr,
>      g_assert((data & OMAP_I2C_CON_STP) =3D=3D 0);
>  }
> =20
> -static void omap_i2c_recv(I2CAdapter *i2c, uint8_t addr,
> +static void qomap_i2c_recv(I2CAdapter *i2c, uint8_t addr,
>                            uint8_t *buf, uint16_t len)
>  {
>      OMAPI2C *s =3D container_of(i2c, OMAPI2C, parent);
> @@ -182,8 +182,8 @@ void omap_i2c_init(OMAPI2C *s, QTestState *qts, uint6=
4_t addr)
>      s->obj.get_driver =3D omap_i2c_get_driver;
>      s->obj.start_hw =3D omap_i2c_start_hw;
> =20
> -    s->parent.send =3D omap_i2c_send;
> -    s->parent.recv =3D omap_i2c_recv;
> +    s->parent.send =3D qomap_i2c_send;
> +    s->parent.recv =3D qomap_i2c_recv;

Same here.

Otherwise:

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--uQr8t48UFsdbeI+V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl3C4+4ACgkQnKSrs4Gr
c8hZnAf8Dqk28g1VBk7LpSLBuHVyfs912qR5ooRPy0/Yj8D6yVelgkDAYtUt4YG8
IcDDnZVEflkaVINra3kwpu7kdOcitNY0DU/O8BZO+x0GsbhyRe4LR40EH8PWqa9n
5SMIIjzvPxi4XD+xDIcHxtcXj/mJI+OxjZsdMc8iBh5vOrJ6Oh9GoFPbVj33BY0j
uHSZZm5DZyMAxtyneXdexHzpr6R9T5f5zeIlhsoIvToldo0Ih/l89RBPE98Zat3y
GjTJDGlZwlavyuyRMXVoaJhFgcKHjOUu9fFPdj12kbjZl1KxsBnw0LgRgUSg2Cwu
1Wcn3qye0nd0BResDYVqNXlYnLi8Lw==
=CcF7
-----END PGP SIGNATURE-----

--uQr8t48UFsdbeI+V--

