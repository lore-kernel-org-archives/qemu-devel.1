Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F130CC33C99
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 10:00:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BACAB20715
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 10:00:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TdC6lSRX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BACAB20715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45592 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iolfK-0000NR-MY
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 05:00:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57988)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iojzl-0000TI-5s
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 03:13:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iojzj-0002Fe-Ka
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 03:13:44 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:39954)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iojzj-0002EU-Ch
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 03:13:43 -0500
Received: by mail-wm1-x343.google.com with SMTP id t14so18262817wmi.5
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 00:13:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=HNIlDDKINL4Q/pKS1kv6ltDhoEkHZDt2zxV4QLbjic4=;
 b=TdC6lSRXvEqcOoCbF4YuJYhs1Sb2eppt7GOFJyVJEE6t5CzLICCUIMdxPaWk+b7sUl
 CKz5d4iONxSpjfHy5UzMyZFhJ4clhoB1JG8Yso8DbUYO4FRA11PD9JhoSxzIRPo1rG/J
 OKvz/SxlagBQ0NWxcHayt61Ctq7ysaJgGFCKx0jTv9fIX9TI/78T2np3oZaYXFve28uC
 plyu33YIEDr3aKptdswFr7sxE75JeA0q/as4M+v31uZI/+4HLaEHdUs35Z2uyzSFiZUQ
 TK66ZPIYYF0OQB9k8nksYodHYkOJTmK5wCRebaZNmcJ++AaUah2yFt3CPhjMoBScqrOP
 +DEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=HNIlDDKINL4Q/pKS1kv6ltDhoEkHZDt2zxV4QLbjic4=;
 b=c9WiFldoFH/i/J+kYgM2oB1SBG0K7E5hIRWH/vKuRC7EaajUirGmNL6fNf8qpIvTtp
 xEgGuEp8pkx9/k1rGwjcsv+8s/sDburmmMIgcLt2PfTdbxAZhqBFsSeppnBoJ8ARHYnu
 lZsyiOqPohrV2LRes/QqDqbDHm+PuMD9o2FFiblbPOsQjDLqNdBtRkNwyILGet48KGHn
 YBD12kMOdYVRlqj/hxE79W3B4vwDHSMucOKuHBKudx/Cef7fXKDmgQr4cL+oV422zVXG
 0uO3HW7A4fQkrbNOrHFJq22PVVw485DSYbp7+xWxwmq0+OcArtKO1KFkohEyj+OlBw0M
 jWqg==
X-Gm-Message-State: APjAAAXmZ/THbO3YBjiLzi+GbpFBsy52Gu8AiEGQKIFY2ikfyG1UU4nF
 bfYv4qGsq+7UifUPaldtnuKoig==
X-Google-Smtp-Source: APXvYqwDTmBjuCTv4t7GKSoAw/TZ/QgV61V+gLjKowd3A0xWTa1BVqmtESQ0nePOr+22UYHuZ/D15A==
X-Received: by 2002:a1c:3187:: with SMTP id x129mr38686737wmx.91.1578384821768; 
 Tue, 07 Jan 2020 00:13:41 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id m126sm25462561wmf.7.2020.01.07.00.13.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2020 00:13:40 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id B29DB1FF87;
 Tue,  7 Jan 2020 08:13:39 +0000 (GMT)
References: <20200106063423.10936-1-richard.henderson@linaro.org>
User-agent: mu4e 1.3.6; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v2] MAINTAINERS: Replace Claudio Fontana for tcg/aarch64
In-reply-to: <20200106063423.10936-1-richard.henderson@linaro.org>
Date: Tue, 07 Jan 2020 08:13:39 +0000
Message-ID: <87eewb65vw.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Claudio Fontana <claudio.fontana@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> Claudio's Huawei address has been defunct for quite a while.  In
>
>   https://lists.gnu.org/archive/html/qemu-devel/2019-05/msg06872.html
>
> he asked for his personal address to be removed as well.
>
> I will take over officially.
>
> Cc: Claudio Fontana <claudio.fontana@gmail.com>
> Cc: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Cc: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  MAINTAINERS | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6f453fc94c..1f5f3ca21b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2384,8 +2384,7 @@ F: plugins/
>  F: tests/plugin
>=20=20
>  AArch64 TCG target
> -M: Claudio Fontana <claudio.fontana@huawei.com>
> -M: Claudio Fontana <claudio.fontana@gmail.com>
> +M: Richard Henderson <richard.henderson@linaro.org>
>  S: Maintained
>  L: qemu-arm@nongnu.org
>  F: tcg/aarch64/


--=20
Alex Benn=C3=A9e

