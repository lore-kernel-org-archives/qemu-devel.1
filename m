Return-Path: <SRS0=r3/N=VJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DEA4C742BD
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 13:49:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B6EF20863
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 13:49:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kHKs3Mip"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B6EF20863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49612 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlvvf-0008KA-8I
	for qemu-devel@archiver.kernel.org; Fri, 12 Jul 2019 09:49:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60070)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hlvvS-0007pK-Nr
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 09:49:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hlvvR-0006Jr-Kd
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 09:49:26 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:32946)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hlvvR-0006J4-BH
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 09:49:25 -0400
Received: by mail-ot1-x341.google.com with SMTP id q20so9500957otl.0
 for <qemu-devel@nongnu.org>; Fri, 12 Jul 2019 06:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=fbn8G26cboF8xKkdv/2z9l8bJWzPj2pB0FAG8zPAuFI=;
 b=kHKs3Mip0gaKLAzeh2UcQE8CI0xxl9oJ8U2xJ3aLe2elG3j7PaqIaDT/bFZLu8ek43
 ASdKUk7ChGwrUYGME7GCC7/00CmXeZSl14cLiPwri2HzIAnGYkuOkevazMu/vvbC1hXV
 g7r88diYq1kpKfznZ4mlYqrUGeXI8yeANp+K2vWxgpcTaOVBu5o4LKujW7E9C08gOjtx
 duAsJlMcmI2yWSx1yKAb/E4jCcnkPC+CJX+/6MQ1NaD8igZJ2xmLO1K8fMpgEWIYcoLk
 cGAlcCEhrnUBlqV1gv74oeSVQz1eiNn5gG+Yg3X1isdMMJS7MB4uLILnIBf9HpFGAWnf
 XfsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=fbn8G26cboF8xKkdv/2z9l8bJWzPj2pB0FAG8zPAuFI=;
 b=PAhnhIJrsXmb1rezrONQ9JdgFXzQ1RqDbg0LNvhtAeH2G0KltwK/nVCBk+mabwZseq
 ASYVexlItc+QBJeEIXaBY0lCTwSjzgB3Ml6zHq1CvYA1rxULTLQPi8+kqyPmLXEXmQY0
 dKP0KPLFQvHYzx8Sd+A73ItbjEkzJ99Acq2hVQaYUU55wM4IJwyoKmaywEtF6CB4W/7k
 JLz4+TCGzKXsWTl9N0JGuUYzsbSA7eveJNRUWdaCUw35v/OGyApRCQ9C2+Uh5dqYDHqi
 rsaGC3n+Qub6cAcRCjaHY/icKUhk54kHOWKxS+4ZCuQZjite65L/JFpwPJy/2cEaqNUz
 E+3g==
X-Gm-Message-State: APjAAAX683NexjGqFc4Id1zusD4BBYjkdhCCbLbNOBu8xvRsotQgTP5U
 MZjp/+tQ3TbJ3i7d/UM313HyMB4PvqfERwY9WV4IyQ==
X-Google-Smtp-Source: APXvYqzVWktfX1KGrg7ytq3LSTNc2k97oEPP3jpBHpZSemibQbTQ2heQkbPlHq6OPkpz1/nsJ0jblXDZZjdt3PlsV7Q=
X-Received: by 2002:a9d:6a0f:: with SMTP id g15mr3377614otn.135.1562939364395; 
 Fri, 12 Jul 2019 06:49:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190712134307.31112-1-sw@weilnetz.de>
In-Reply-To: <20190712134307.31112-1-sw@weilnetz.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 12 Jul 2019 14:49:13 +0100
Message-ID: <CAFEAcA9M_jPad==BzrbXJmHD5xf6EJZF+Eq2ohJ_R78BmRdvDw@mail.gmail.com>
To: Stefan Weil <sw@weilnetz.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
Subject: Re: [Qemu-devel] [PATCH v2] Remove old global variables max_cpus
 and smp_cpus
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, Laurent Vivier <laurent@vivier.eu>,
 QEMU Developers <qemu-devel@nongnu.org>, Like Xu <like.xu@linux.intel.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 12 Jul 2019 at 14:43, Stefan Weil <sw@weilnetz.de> wrote:
>
> Signed-off-by: Stefan Weil <sw@weilnetz.de>
> ---
> v2: Remove also max_cpus (merci =C3=A0 Laurent Vivier <laurent@vivier.eu>=
)
>
>  include/sysemu/sysemu.h | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
> index 984c439ac9..e70edf7c1c 100644
> --- a/include/sysemu/sysemu.h
> +++ b/include/sysemu/sysemu.h
> @@ -103,8 +103,6 @@ extern const char *keyboard_layout;
>  extern int win2k_install_hack;
>  extern int alt_grab;
>  extern int ctrl_grab;
> -extern int smp_cpus;
> -extern unsigned int max_cpus;
>  extern int cursor_hide;
>  extern int graphic_rotate;
>  extern int no_quit;

Hi -- this looks like an inadvertent duplicate of Alex's
patch from yesterday:

https://patchew.org/QEMU/20190711130546.18578-1-alex.bennee@linaro.org/

thanks
-- PMM

