Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDA8DC3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 14:15:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B08212173E
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 14:15:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XsS3xe66"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B08212173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56558 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1ALz-0000aI-Mu
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 10:15:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47103)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i1AK7-0007sA-G2
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 10:13:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i1AK5-0005Os-PP
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 10:13:50 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:33660)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i1AK5-0005M9-3N
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 10:13:49 -0400
Received: by mail-ot1-x341.google.com with SMTP id p23so4698904oto.0
 for <qemu-devel@nongnu.org>; Fri, 23 Aug 2019 07:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=LfzmYBvikkY9e4oBHFdresfOtrU7qfZBe1fhkTFWtQI=;
 b=XsS3xe66Rhh9PXAPYg9YAePYVOLNFuOW3Flck32bNYOk7Nfaqk7gmA1ZnMk6GckiiN
 gqQbdabwfhZXM0CYkjB6Pj9ZtzCpIn1DAr+JBJnKIUyb7yAgDxPr9c113yVyoM+74F0e
 /iOCX3k5CscI49q+uecDKpeOQXjb/1PA6IRqaDiBaGwdfAQeFFFDloUAMgV4snaDmRnw
 8CAprQc0vhsQ/uwxQlSovsd6VJspuGPN1XbV+f3mXB5hIiIROFL9DsVQ9+giFZ3Tmsxy
 oqD3w7Jf25gGPpktFXz3ZT11EbdH5Jgdo9zyO0XAc1OXxdIKrUR+QTtQhCWyDKzUDHz5
 aM7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=LfzmYBvikkY9e4oBHFdresfOtrU7qfZBe1fhkTFWtQI=;
 b=ErtYf3CTdvBqxoY9zL7+GY9//Lm81O2366EbV8stvdsXtmWaJih9BccMR1guMQ4EMP
 Ruy3HnaqNJ8FjTCp27TpMgquhHbHC2PE43edgsaW5/BmKnPkC9yDSIgGMaT1R7UFuueZ
 5twxBvyqoakOa7/zcE5cTFhsdJ6RPSlaqFsyl/cskKTDAeN1fMwYe49Z0XB53qmlZG2o
 Mzj0gPLiUigIphTrwKrx50oYfmlxQardtq5HeeD5Xs8AYjc10OO1HXd497pPJP2M0PHD
 UmURFxPcScKJx7+oJ1S3qJUm55G98VEevErGNA2oeTlX5MYyMfBKadrCecvfnAiqSwkW
 s9VQ==
X-Gm-Message-State: APjAAAWoSm2tF4Tk9uLGe0CS/g/nq/KOJSDrmbke2Z1lH4s3eZqbL55T
 b4SmK8yLmTKZEgvtYM24qpamghFISf5nz3m0SH3m8g==
X-Google-Smtp-Source: APXvYqzShNpKdiftJYHJ2O+jtCTzdNifAomoBD0OAhU42kx78LPeIhU5KiFXjuP+E1u974R+nlNbVSVSD95YhXEQotI=
X-Received: by 2002:a05:6830:1015:: with SMTP id
 a21mr4508966otp.232.1566569627414; 
 Fri, 23 Aug 2019 07:13:47 -0700 (PDT)
MIME-Version: 1.0
References: <1566495734-23297-2-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1566495734-23297-2-git-send-email-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Aug 2019 15:13:36 +0100
Message-ID: <CAFEAcA_N18GHqQ9Hxy6Cy5L8iBPa9O9T0xD0JM=K_HW+M93T_A@mail.gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
Subject: Re: [Qemu-devel] [PATCH] modules-test: ui-spice-app is not built as
 module
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
Cc: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 22 Aug 2019 at 18:42, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> $(call land, $(CONFIG_SPICE), $(CONFIG_GIO)) will never return "m" so
> ui-spice-app is always linked into QEMU.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  tests/modules-test.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/tests/modules-test.c b/tests/modules-test.c
> index a8118e9..f9de3af 100644
> --- a/tests/modules-test.c
> +++ b/tests/modules-test.c
> @@ -53,9 +53,6 @@ int main(int argc, char *argv[])
>  #ifdef CONFIG_SDL
>          "ui-", "sdl",
>  #endif
> -#if defined(CONFIG_SPICE) && defined(CONFIG_GIO)
> -        "ui-", "spice-app",
> -#endif
>      };
>      int i;

I've applied this to master as a build fix for the moment, thanks.
We can properly build the module and revert this bit as the
longer-term fix.

thanks
-- PMM

