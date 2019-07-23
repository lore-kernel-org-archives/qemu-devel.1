Return-Path: <SRS0=3Ld+=VU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C221DC7618B
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 13:03:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F4F1218BE
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 13:03:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U7oCP6Mq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F4F1218BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpuSD-0001uy-SG
	for qemu-devel@archiver.kernel.org; Tue, 23 Jul 2019 09:03:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51187)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <stefanha@gmail.com>) id 1hpuS2-0001Vh-7U
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 09:03:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1hpuS1-00083S-4s
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 09:03:30 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:41020)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1hpuS0-000834-Ug
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 09:03:29 -0400
Received: by mail-wr1-x441.google.com with SMTP id c2so39894600wrm.8
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2019 06:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=zcgzrQUKJ44V4zY+Zg8tOwUxFanlQ5Fy3bW3copKjyQ=;
 b=U7oCP6Mq1qmoMz65XHPp878ZvbK8VrzIl+a2hiaAqOFzOiiZWD99wpQniaqzmEN+6o
 3RZ7F/qbxvfOklPYF/cO1k6I8uN5FH5LwUR4YRIpF8EIC+McANirKzY9MV56BmY1lvAg
 pxQB4ZkvEyF648PsxdjUauXftWTMpGVf2bY9CHWU5EyRwXZ2Dh9NY1BhUobTdQ6zZ0QQ
 mhphh41PZO/QEsrYeJhL5yVPQw16+cUPXEixfPXyuGjgXzzmh5vVYNMAbKavcFVwCTJ7
 dptoivLX3jBwv4uibxBWWKCLT8PMuCYQYZbGrNrigQK/XuOXjfMSDeV7Z+Ph/0ws/F73
 i+Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=zcgzrQUKJ44V4zY+Zg8tOwUxFanlQ5Fy3bW3copKjyQ=;
 b=clOKj5AdnJJp5DuYhNi37P1N7AJhbEtQn63MJ+fi3VmHtC2Ul4xW0oQBYGT31DB8ud
 jpBSm8AYTSLLlsUs+NDfLc6Wem4DD0zbHDFQStaM6olT3PXAlojVyj+TAmesgjSQUYzD
 CE+7siFiullhDURd1FEO5vGR9R0g37XdB5D28SQR+UN3YvIjYGp4oRJ9ic41ORAvpKik
 3tEHxr6gSr1w8IlZP3Mry1CNyW6FkwC9Bf9ridFIjM6ee/+S/PiCraAqvrxJBRu54ehK
 /qAFhy/fRvcBKSy3imVcLjyKSinb7g5Ag34R01pFUcv9cwe1ePChnZwWThFMDDsNgP2o
 WSdw==
X-Gm-Message-State: APjAAAWHileT/rme3aAcezO6NAQ39ofDjR3tHdaveJuf1Lo2yCv93ko/
 qL0F+8+2z/IU7L/cXsnjGRo=
X-Google-Smtp-Source: APXvYqyrIlBUY2jchMrbS73TDXv+U3prGI9XWp8E/74WAPjkRjQp1VIHJCnTxNbv/hpuKcAyh1cUHg==
X-Received: by 2002:adf:fa42:: with SMTP id y2mr61749315wrr.170.1563887008085; 
 Tue, 23 Jul 2019 06:03:28 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id o7sm37140691wmc.36.2019.07.23.06.03.27
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 23 Jul 2019 06:03:27 -0700 (PDT)
Date: Tue, 23 Jul 2019 14:03:26 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: P J P <ppandit@redhat.com>
Message-ID: <20190723130326.GC5445@stefanha-x1.localdomain>
References: <20190723104754.29324-1-ppandit@redhat.com>
 <20190723104754.29324-4-ppandit@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="KDt/GgjP6HVcx58l"
Content-Disposition: inline
In-Reply-To: <20190723104754.29324-4-ppandit@redhat.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: Re: [Qemu-devel] [PATCH v4 3/3] net: tap: replace snprintf with
 g_strdup_printf calls
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
Cc: Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Li Qiang <liq3ea@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Prasad J Pandit <pjp@fedoraproject.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--KDt/GgjP6HVcx58l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 23, 2019 at 04:17:54PM +0530, P J P wrote:
> -            snprintf(helper_cmd, sizeof(helper_cmd), "%s %s %s %s",
> -                     helper, "--use-vnet", fd_buf, br_buf);
> +            helper_cmd = g_strdup_printf("%s %s %s %s", helper,
> +                            "--use-vnet", fd_buf, br_buf ? br_buf : "");

The change to the br_buf argument isn't covered in the commit
description.  Why did you change this, was it a bug, etc?


--KDt/GgjP6HVcx58l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl03BZ0ACgkQnKSrs4Gr
c8iIogf/UNYMEPTdTv9/qmiLMbuX25hSwU1uoLjZqakgWU32/wHhAZgIn2pn1GYc
UQojr2EM3i2Plzof1tn+0Z74FYdsxU2iipeupbkrrHB5y/dKhLB/pQFnCxS6l1hR
8UZjAzBnmZq7mQ951iNUp+5QDxWMRVOMcOzH1/UcCjS9GD8TZ2qcUGaSdvNClWbf
BamsJEKzSTNDnenbkgAJoGd0zoW9yaCdbPQlghOKLWJmOBBRHV/vwudjd06nOzuw
wFzUFezUdMsBBpQUs3eqBmo+WC6FBBANmUTf4u8hS+kNtEcOpwbfIlksqbfFVPJV
XNcsc75xJEY8tBGJQKeTSkJuJs+Jvw==
=FIw4
-----END PGP SIGNATURE-----

--KDt/GgjP6HVcx58l--

