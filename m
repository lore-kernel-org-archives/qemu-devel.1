Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49A23C3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 07:33:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DC5D2341F
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 07:33:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QKFNqeWO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DC5D2341F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52378 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i144G-000200-3W
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 03:33:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34786)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1i143Y-0001b3-Lu
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 03:32:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1i143X-000829-QM
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 03:32:20 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:37016)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1i143X-00080u-Ih
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 03:32:19 -0400
Received: by mail-wr1-x444.google.com with SMTP id z11so7688529wrt.4
 for <qemu-devel@nongnu.org>; Fri, 23 Aug 2019 00:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=OVmcS2iWJPWre1PgJxzaoCyFR9w05XeQp5u5FYyiCXA=;
 b=QKFNqeWOvIe1992gLL9flB/o3Q/U5LMqpKB/nlj/7eq/nEtXaB42giyU3+mD2XnU7B
 i9v4tA2n4MYeN1uT8ui1NNYwEhYg+B6WCz4XYL2aE8T+V9tRY2T78S2LnA9fvlmQ+YSy
 dvUPIGJW87CVM5ouhKrY9vtHViQEsuFfJ+28n5iiUnQ4M3Ob7xIgZOHvJvRqxKLBM4Pj
 +BjtZoktUc1rXfUnFwu/kQFw449YVV7y8VuAKrZwHppdt8lXsTXpxDvi3jXHTWZRb2jr
 7l8xMvzbM5ezmzG6cdxc4MCo2SV4rdKNqxQU5B/fZA80B5jOiAo+8wvIqnlPFckp6ciZ
 1l9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=OVmcS2iWJPWre1PgJxzaoCyFR9w05XeQp5u5FYyiCXA=;
 b=qd8/89Fqa9zMylI2At5EIc5cQZPWIF5/5roZZtHXUQgpLGu0G+tDFCk8s3pJZ26iEK
 xoI2atkTOdfHvyv9y5OlJZubqW1tGFTWJLALZMSVvJfYDJ8uh3Lm9aToWY3HNrjMhvxo
 tO3xbWQXJllKzgijArAu+LMc0c2V9BhvG9l7bP1FVMpKa8W4zujiEEJsTCH/BZODECo2
 VKiilenmPJnpyLyzJfN0po+zSP8pRp62uvzDcaeBLbt0X1IQhQzuCf2sYxcYd2y7TDRg
 x74Sw9T2aCKyZX/xqAA/m8cRJ0QKNpeX6dIk1VB+00Vf3uXJp3FWBIWkC70EMZ3aPbQZ
 gIpg==
X-Gm-Message-State: APjAAAVhjfB9J+6dhj9ZY8kJFgUF4F0U4QNYz2OFxXXC8BDB2baT9J1e
 glFy/spEzYZOHPHceO+DlUGmxRx0oML+cXpAGPU=
X-Google-Smtp-Source: APXvYqxwprnqR6TIoCZus+8b1idAsbGtJZ5LVcUpdComNBb80UHncmVePqtVBOjyxAbvguGhH9WvmJWZT0F6sGlhh6c=
X-Received: by 2002:adf:f404:: with SMTP id g4mr3224714wro.290.1566545538305; 
 Fri, 23 Aug 2019 00:32:18 -0700 (PDT)
MIME-Version: 1.0
References: <1566495734-23297-2-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1566495734-23297-2-git-send-email-pbonzini@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 23 Aug 2019 11:32:06 +0400
Message-ID: <CAJ+F1CKx_B9nFAaAdNbWAdsim7LUvSEY06mR-b_Ngya79iwoSg@mail.gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Aug 22, 2019 at 9:43 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> $(call land, $(CONFIG_SPICE), $(CONFIG_GIO)) will never return "m" so
> ui-spice-app is always linked into QEMU.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

I would rather build the module:
-common-obj-$(call land,$(CONFIG_SPICE),$(CONFIG_GIO)) +=3D spice-app.mo
+ifeq ($(CONFIG_GIO)$(CONFIG_SPICE),yy)
+common-obj-$(if $(CONFIG_MODULES),m,y) +=3D spice-app.mo
+endif



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
>
> --
> 1.8.3.1
>
>


--=20
Marc-Andr=C3=A9 Lureau

