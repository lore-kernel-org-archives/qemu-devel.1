Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A24B3C4CECD
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 16:03:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DFD3214AF
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 16:03:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YkWrqxdk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DFD3214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47772 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAFwy-0000Y2-R6
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 12:03:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39032)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1iAFs3-00071L-Tv
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 11:58:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1iAFs2-0003pu-Bf
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 11:58:27 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:51225)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1iAFs2-0003pK-41
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 11:58:26 -0400
Received: by mail-wm1-x341.google.com with SMTP id 7so4154162wme.1
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2019 08:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=xn8v6Z41cptxmZuuN3Eu45B8ZTLUhDsBuUifbp2nOLw=;
 b=YkWrqxdk3kgTR2+lsZHI6B1ByYOTKntHQeb+oN+Ip3NlrxeLojq9oUVqCmfuOo/nyP
 o6spp9joDBiT9lqf/KtM7iwkksxvc/MK3kNIttR+vhGHDRSqJ/aJ0kU6NB8GhhwPLLty
 2HWD3AbV6OR+cfQYr3vkeahcnisDXqnCpRfCcj5yqKrG0X6K+ocuf8eKpvqgJ+WlgL0a
 ikSTQBx2KjrrVyIVpSOACtCKfEGv6YYCgJZnmyGV8EpvxfNu6V2FxSeVLBELBfv8EoG0
 zRk3z6YdtluUtW+yTo7ORLIj+aY9gaOz+r7URBb2JnuI2dSl2OvraWCvLjACbgOJGbbK
 HXKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=xn8v6Z41cptxmZuuN3Eu45B8ZTLUhDsBuUifbp2nOLw=;
 b=Da9IxS/I5LAxIseLI8iscpBUEKc8JFZyPwkH8jheBg3ElRgU43fYqjfdtTrmkLbnRu
 8i95TFPKQQoYKFTxCi2PCpQdQQKdEL5a/pRQlLF6JpgFWIyS/5GQhMIYTIML857MEFPx
 kmdKMmu8wGYX4nqQOY7MqlM1/lha/Pj1OZoB5GHpqIXEwiJY0e1vZIQxbtsdNeSslbwf
 sVzpJwoEPV+9A2dXeywu75YTNmfnsHmkUoO6Z7VM84aUxE9jrugjl3EoVc3CG1Fpbhqg
 3r75A7eMYKmNSX4pH/y2wLCBcL2xVTu8j2I+zIjOye9waGQTKAYjNyZEuE9MFmowXe6X
 7piA==
X-Gm-Message-State: APjAAAVOkjmmamE/wAClgF+guAISlVDAU3nhvOYV8xec7CfFPH7/rwBG
 fmIFdYSoBmbx9WVvHX7SZq4=
X-Google-Smtp-Source: APXvYqyhccfJgZfBO2oCl31wAjJlgQHErWac0evZNFKgRtT6NC/O9hRIW3MtxPnD9kwXbp3kuQtCAw==
X-Received: by 2002:a1c:9ec9:: with SMTP id h192mr4306512wme.105.1568735904071; 
 Tue, 17 Sep 2019 08:58:24 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id q15sm4019599wrg.65.2019.09.17.08.58.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Sep 2019 08:58:23 -0700 (PDT)
Date: Tue, 17 Sep 2019 16:58:22 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190917155822.GC18705@stefanha-x1.localdomain>
References: <20190911145818.18962-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="hOcCNbCCxyk/YU74"
Content-Disposition: inline
In-Reply-To: <20190911145818.18962-1-stefanha@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: Re: [Qemu-devel] [PATCH 0/2] audio: -audiodev documentation tweaks
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
Cc: =?utf-8?B?Wm9sdMOhbiBLxZF2w6Fnw7M=?= <DirtY.iCE.hu@gmail.com>,
 qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--hOcCNbCCxyk/YU74
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 11, 2019 at 04:58:16PM +0200, Stefan Hajnoczi wrote:
> Small fixes to the -audiodev documentation.
>=20
> Stefan Hajnoczi (2):
>   audio: fix buffer-length typo in documentation
>   audio: add -audiodev pa,in|out.latency=3D to documentation
>=20
>  qemu-options.hx | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)

Ping

Stefan

--hOcCNbCCxyk/YU74
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl2BAp0ACgkQnKSrs4Gr
c8gEzwgAvz+28QrNe90m3+ZWMTOLhueRP00jBvtqywsXkfIN4563+u2edMuYnjK8
U3PWsiYAHI7HutkUvWjBqbaFVsSajDia7oT1RKtEu5f52AVTjekzs+x1bwCe7A7Q
0FDsJHxV/KIN1VgyCd3lj1v9V+4Fc9NE1/VuK4Rwsf4saqlBhYLhlUVe4N5JBRxF
aeFgAWNfg7ngs3ABYq4g3ua2uWkM+pKzloIDFKOeEuSEp6l/QDn83YawxOGazTpc
umVzn7MsSfIAPit7d/k74neaDDOrRPIQF+YIC1AIwnmgL77yxxRXrkkeW4GD6Ah7
yFSEKVBeWyVdxMiUy7sDz3zkCYsGPQ==
=Gx8T
-----END PGP SIGNATURE-----

--hOcCNbCCxyk/YU74--

