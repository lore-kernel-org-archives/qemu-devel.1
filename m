Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68F8FC5DF60
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 10:59:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 334E1218AE
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 10:59:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J8Qf+yD6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 334E1218AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52296 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iT1yl-0003CZ-DA
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 05:58:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55866)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iT1xB-0001NF-Va
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 05:57:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iT1x8-0001ln-6y
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 05:57:21 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:38794)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iT1wJ-0001Kw-Az
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 05:57:18 -0500
Received: by mail-oi1-x244.google.com with SMTP id a14so4864358oid.5
 for <qemu-devel@nongnu.org>; Fri, 08 Nov 2019 02:56:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=QSA741uBEPaIbz8uP/VPthR9NV6kG9kvrfc3BOD9kf4=;
 b=J8Qf+yD6XAYhQPCnBo+1qv1A+QVOR93mwqr2RJy0jxDyn7O+rQuF7xf/Wsm/wfm3G4
 sNGqjpt7fa/jw1q0Md68VwwCvcNRRGwuiIVDFk82ELzWirYQcgvl/Mzqs5YbMU7uUcbJ
 0aAisW2z3Q74ileuhu1YlcCzE/xkR8ruF/CAGror/JI0ZHtdxzYQeFqz9rbNVAJc9bBL
 uj8s84C9+UQP2I2YKo4l6wAzNYy9amUpuuLGyVdiXdz4575ErvThO5vEqcYhP6LXhBQx
 +hDjfCl+EoicsGG4qdAaO97SLOzSM8FvPthziozWubQKFFAN9qdUrRbbkI/S3VXQQOIr
 zYvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=QSA741uBEPaIbz8uP/VPthR9NV6kG9kvrfc3BOD9kf4=;
 b=NPcSLBaDQQYPu4rrPNXKAtt1j4cn7Z5NMFXFLazemmMFCWp4z7Z6xIm1FZ70XXyjaw
 qZblwhB56wVOIzQyCIb2/gf3K+mIWdDpZQ7WoF7DuG9R7ltx9k02Q3Yg6B0rw2fdXlZd
 yKO2jep0Dw9SeAqYMT7hG2HlelTSQrWhddDWu0imzoN/yMgNAj+Mb2juAM4GGrMSSXzu
 9KonuPdye7LtLTjxfuj2IPaak40aYoihUhtD7RDOVN5oYRYHAVys3eJU7tx6VuL1ecVo
 xm32O/QG1uCen6fT4h3THwEcc3UeJDRTE+nY8Rgrr107hFXpqATpw6OGTFvqbTcKLn22
 Xwzw==
X-Gm-Message-State: APjAAAXbY7X5bsbq+oFHHxJMcjYbbxKLkkJ7t1sukPQZJ65TA1GX9+/Q
 EorBz6ayBTcjVV3kvlbohz8t4kf47rIO8QZGcU8ksg==
X-Google-Smtp-Source: APXvYqzAO5QRUWeoxU6W2cEVuuM73q9fek5lxJvaRDFX9SIvlhoFeR84hanADamSWC3icEpM9DAZuKBWnqktNPdp+oA=
X-Received: by 2002:aca:451:: with SMTP id 78mr9054755oie.170.1573210586355;
 Fri, 08 Nov 2019 02:56:26 -0800 (PST)
MIME-Version: 1.0
References: <20191108095942.401225-1-stefanha@redhat.com>
 <20191108095942.401225-4-stefanha@redhat.com>
In-Reply-To: <20191108095942.401225-4-stefanha@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 8 Nov 2019 10:56:15 +0000
Message-ID: <CAFEAcA8GS52-a9_LxhOD4xM5dqX++=T8-BNVvjD0hrFTUhm-MQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] docs: install CSS and Javascript files for HTML docs
To: Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
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
Cc: Daniel Berrange <berrange@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 8 Nov 2019 at 10:00, Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> Install the sphinx CSS/Javascript support files needed by the HTML
> documentation.  The documentation looks ugly without this.
>
> The previous patch switched to only invoking sphinx once so there is
> only one _static/ directory that needs to be installed across all manual
> sections.
>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  Makefile | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Makefile b/Makefile
> index 9487a06bed..dd60787d4c 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -813,6 +813,7 @@ endef
>  # for QEMU developers, and not interesting to our users.
>  .PHONY: install-sphinxdocs
>  install-sphinxdocs: sphinxdocs
> +       $(call install-manual,_static)
>         $(call install-manual,interop)
>         $(call install-manual,specs)
>         $(INSTALL_DATA) "$(MANUAL_BUILDDIR)/index.html" "$(DESTDIR)$(qemu_docdir)/index.html"

'install-manual' does some complicated stuff to
(a) handle subdirectories and (b) skip things we don't
want to install. It's intended for installing manual
directories (specs, interop, etc). _static is just
a simple single directory with no underlying files,
and it's not a manual, so it seems a bit odd to use
install-manual for it.

Also, this is only needed because we're now building
the docs in a single run (with the 'build manuals
one at a time' approach you get a separate specs/_static,
interop/_static, etc, which are installed by the
relevant install-manual calls for each manual). So
it seems like it ought to be squashed into the commit
that switches to doing the docs build in one run of
sphinx.

thanks
-- PMM

