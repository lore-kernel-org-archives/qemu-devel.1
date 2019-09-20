Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEEAAC3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 17:15:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D0702086A
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 17:15:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Xt20TEND"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D0702086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33950 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBMUs-0007oG-MN
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 13:15:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34612)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iBMTg-0007DT-RJ
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 13:13:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iBMTf-0005v6-GO
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 13:13:52 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:39196)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iBMTf-0005uq-9Q
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 13:13:51 -0400
Received: by mail-ot1-x343.google.com with SMTP id s22so6808161otr.6
 for <qemu-devel@nongnu.org>; Fri, 20 Sep 2019 10:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=akZy2G337scOZVKyPuAxDiFIaL85vXe8WuizeX52pWw=;
 b=Xt20TEND14dTL83RP0n20or0T9aWtwBA0fe0XsPLIKtKrYoNriqjwBB/IC4OdaUwSu
 5hWmvR1rOuODpbMVwzn3EhvPj3fnDWoIkXTp4M7R0rKPe7j3cD2X/7+UTMKk4LlRs4XP
 553UD9WIhp15iHfY7Su8NdQXqWxufXfFENruC2qn5sZbqOYt6023G8lm8h/BDxA2/CBT
 f/dgKRpsls1XKmpeIjXEBOmM5ckX/3u8/WcH/66uXajwAxCch2Szh/GdLblGFQsjWOGy
 YHdgvj93DT5ep2HC1gjuYpwrSP+sbs203AOh/yQBFUSiT9oMOJnJBBSuTxPnM/CHtXtD
 VCNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=akZy2G337scOZVKyPuAxDiFIaL85vXe8WuizeX52pWw=;
 b=F0Qx2Jca6ZFQ0bt3mhq2jYnnRkxgj8tiPkQnB+/eT2rx3m+LuhHNOnTFTaxBch76xH
 eHwdt6ieWJFysan74pw9eAKVh01T3HeTwYELrvOykvlpNwD0sl8DN92wlM+KNRVdauTf
 ByKyRbulIajuUMll2YlzbTuZ6alVOM8IjxWgjAspi0rDpULGUqRnGdiIl5JekOW8Y00h
 SvOWcZpKL93dPR8CHE9tpI+xQNd/TSDwAm9zd8x2BWGR5zVL9qvqMUOEtZoV301VcUfV
 jgdtG/oe6Pnjz+PNBpMIEJ8TfCgPrJbB67rE7GdL+Fks/b/oFo0ODdUD3OLoMErp73uY
 0w9w==
X-Gm-Message-State: APjAAAXDrGZH8gNpSP1XJ291Qaw0LwRpsHcoPyb9imG0gbdlEf4Y0LJT
 AVqWFLPBO05FQw0MJ3xVZO0xVPNwxmyjavGHU9C0vw==
X-Google-Smtp-Source: APXvYqysG/95Yc/pbxR71k6CQG6JzzT21PaA4X+tKW37BQPhwucS212r8sHDois6aNMfinNOCLGp875pYzuVIDO1C10=
X-Received: by 2002:a9d:4615:: with SMTP id y21mr5072991ote.97.1568999630436; 
 Fri, 20 Sep 2019 10:13:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190920171159.18633-1-philmd@redhat.com>
In-Reply-To: <20190920171159.18633-1-philmd@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 20 Sep 2019 18:13:38 +0100
Message-ID: <CAFEAcA93w21JOF7cA2zW+gKDXet=T920ghFqRw9qk2KQWmoeow@mail.gmail.com>
Subject: Re: [PATCH] roms: Add a 'make help' target alias
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, Laszlo Ersek <lersek@redhat.com>,
 John Snow <jsnow@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 20 Sep 2019 at 18:12, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:
>
> Various C projects provide a 'make help' target. Our root directory
> does so. The roms/ directory lacks a such rule, but already displays
> a help output when the default target is called.
> Add a 'help' target aliased to the default one, to avoid:
>
>   $ make -C roms help
>   make: *** No rule to make target 'help'.  Stop.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  roms/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/roms/Makefile b/roms/Makefile
> index 6cf07d3b44..3ffd13cc7e 100644
> --- a/roms/Makefile
> +++ b/roms/Makefile
> @@ -51,7 +51,7 @@ SEABIOS_EXTRAVERSION=3D"-prebuilt.qemu.org"
>  #
>  EDK2_EFIROM =3D edk2/BaseTools/Source/C/bin/EfiRom
>
> -default:
> +default help:
>         @echo "nothing is build by default"

If you felt like fixing a typo, there's one here: should
be "is built"...

>         @echo "available build targets:"
>         @echo "  bios               -- update bios.bin (seabios)"
> --
> 2.20.1

thanks
-- PMM

