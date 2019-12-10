Return-Path: <SRS0=2P1T=2A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BCF3C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 13:15:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F33A220652
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 13:15:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PWt16cmX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F33A220652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56752 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iefLx-0004zo-6s
	for qemu-devel@archiver.kernel.org; Tue, 10 Dec 2019 08:15:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60352)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iefKX-0003te-U6
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 08:13:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iefKW-0002HU-Sa
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 08:13:33 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:33525)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iefKW-0002H5-Me
 for qemu-devel@nongnu.org; Tue, 10 Dec 2019 08:13:32 -0500
Received: by mail-wr1-x443.google.com with SMTP id b6so20075227wrq.0
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2019 05:13:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=4vipvUXKpe7sihNqgun/ZBxgpa94ZneCt+y7/lO3700=;
 b=PWt16cmXMraJPVSBODkAnyR1X9FouTsWTW87us3IIOxUOWZQDvTY2CPqrGyedRu6+X
 gbxoPt3aBP+w5WL3zPN3i0NeaWjFcQNaJLBOtD8ZY3cpjshxCIaK54Xz+fd9MsqYAx+F
 MaN0DvXFntF7rwb79KkTg7ynwXvxCOLB3x0fAQw43HsjH8FtVZYoD21+oppL9kD8gY7G
 bw87NlGCxB9QdYQoZhmY8YmYNmSare8NOt98HvLu02bUzpKIKbhrCzkl+36tFU3ldke0
 hEw6RrmdlqfAzimIuIadm1efFwgjk13AWGlyIDtl/DGyhIonrGaQySTdd9Uwttls5MVt
 D0Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=4vipvUXKpe7sihNqgun/ZBxgpa94ZneCt+y7/lO3700=;
 b=DeccabBc+aq9yIuYaH570Xl0ts7XaXsIG6KebfrpJC3HtNdcyoiEytDd5DB80LQqbJ
 plV9fmyEez81x1mTUh8tnuJD0kI+4xKgTrgmTlUdz9DhobDHid6cAlZTsU6bRmW7vNot
 /TkgedxtUSczUHzQf8TDa5HDwHx/7PPXPEtNLxi3iHCD/20nDBiKnGKewux8AsUY6Pcs
 d4YBcOdnuBldhVZnud8UoF+AQBejOGQWh8BkuHwKraEhsnlTOUAhaaVL12+t/aiFxco0
 o3Py6kPngWLdpyn3yLMhtZ+QXU5wbVDlUVRcZVBfRYQccwjpVRwMtztA3bJ/BYAcxiYb
 OhbA==
X-Gm-Message-State: APjAAAVCPhgSmYDo/MyRLxthe6dY7qp9RYMVL5ZGwj99psTaxbw5Ujew
 reuTrq0qS3CKzSzBM0tVlgI=
X-Google-Smtp-Source: APXvYqxRJx16oKr+FgtBJwnFz0QzHDkNXWWv7exIL6tvyy6bywk62EUnQQISaZoeFyh+BQ2ek8HuUg==
X-Received: by 2002:adf:814c:: with SMTP id 70mr3113808wrm.157.1575983611798; 
 Tue, 10 Dec 2019 05:13:31 -0800 (PST)
Received: from [192.168.1.35] (182.red-88-21-103.staticip.rima-tde.net.
 [88.21.103.182])
 by smtp.gmail.com with ESMTPSA id d186sm3076374wmf.7.2019.12.10.05.13.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Dec 2019 05:13:31 -0800 (PST)
Subject: Re: [PATCH v3 4/5] MAINTAINERS: Add three files to Malta section
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org
References: <1575982519-29852-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1575982519-29852-5-git-send-email-aleksandar.markovic@rt-rk.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Autocrypt: addr=f4bug@amsat.org; keydata=
 mQINBDU8rLoBEADb5b5dyglKgWF9uDbIjFXU4gDtcwiga9wJ/wX6xdhBqU8tlQ4BroH7AeRl
 u4zXP0QnBDAG7EetxlQzcfYbPmxFISWjckDBFvDbFsojrZmwF2/LkFSzlvKiN5KLghzzJhLO
 HhjGlF8deEZz/d/G8qzO9mIw8GIBS8uuWh6SIcG/qq7+y+2+aifaj92EdwU79apZepT/U3vN
 YrfcAuo1Ycy7/u0hJ7rlaFUn2Fu5KIgV2O++hHYtCCQfdPBg/+ujTL+U+sCDawCyq+9M5+LJ
 ojCzP9rViLZDd/gS6jX8T48hhidtbtsFRj/e9QpdZgDZfowRMVsRx+TB9yzjFdMO0YaYybXp
 dg/wCUepX5xmDBrle6cZ8VEe00+UQCAU1TY5Hs7QFfBbjgR3k9pgJzVXNUKcJ9DYQP0OBH9P
 ZbZvM0Ut2Bk6bLBO5iCVDOco0alrPkX7iJul2QWBy3Iy9j02GnA5jZ1Xtjr9kpCqQT+sRXso
 Vpm5TPGWaWljIeLWy/qL8drX1eyJzwTB3A36Ck4r3YmjMjfmvltSZB1uAdo1elHTlFEULpU/
 HiwvvqXQ9koB15U154VCuguvx/Qnboz8GFb9Uw8VyawzVxYVNME7xw7CQF8FYxzj6eI7rBf2
 Dj/II6wxWPgDEy3oUzuNOxTB7sT3b/Ym76yOJzWX5BylXQIJ5wARAQABtDFQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoRjRCVUcpIDxmNGJ1Z0BhbXNhdC5vcmc+iQJVBBMBCAA/AhsPBgsJ
 CAcDAgYVCAIJCgsEFgIDAQIeAQIXgBYhBPqr514SkXIh3P1rsuPjLCzercDeBQJd660aBQks
 klzgAAoJEOPjLCzercDe2iMP+gMG2dUf+qHz2uG8nTBGMjgK0aEJrKVPodFA+iedQ5Kp3BMo
 jrTg3/DG1HMYdcvQu/NFLYwamUfUasyor1k+3dB23hY09O4xOsYJBWdilkBGsJTKErUmkUO2
 3J/kawosvYtJJSHUpw3N6mwz/iWnjkT8BPp7fFXSujV63aZWZINueTbK7Y8skFHI0zpype9s
 loU8xc4JBrieGccy3n4E/kogGrTG5jcMTNHZ106DsQkhFnjhWETp6g9xOKrzZQbETeRBOe4P
 sRsY9YSG2Sj+ZqmZePvO8LyzGRjYU7T6Z80S1xV0lH6KTMvq7vvz5rd92f3pL4YrXq+e//HZ
 JsiLen8LH/FRhTsWRgBtNYkOsd5F9NvfJtSM0qbX32cSXMAStDVnS4U+H2vCVCWnfNug2TdY
 7v4NtdpaCi4CBBa3ZtqYVOU05IoLnlx0miKTBMqmI05kpgX98pi2QUPJBYi/+yNu3fjjcuS9
 K5WmpNFTNi6yiBbNjJA5E2qUKbIT/RwQFQvhrxBUcRCuK4x/5uOZrysjFvhtR8YGm08h+8vS
 n0JCnJD5aBhiVdkohEFAz7e5YNrAg6kOA5IVRHB44lTBOatLqz7ntwdGD0rteKuHaUuXpTYy
 CRqCVAKqFJtxhvJvaX0vLS1Z2dwtDwhjfIdgPiKEGOgCNGH7R8l+aaM4OPOd
Message-ID: <3a6890ad-2660-6f0b-df7a-8c961cbfb3aa@amsat.org>
Date: Tue, 10 Dec 2019 14:13:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1575982519-29852-5-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Cc: peter.maydell@linaro.org, philmd@redhat.com, aurelien@aurel32.net,
 Aleksandar Markovic <amarkovic@wavecomp.com>, hpoussin@reactos.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/10/19 1:55 PM, Aleksandar Markovic wrote:
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
> 
> Add two files that were recently introduced in a refactoring,
> that Malta emulation relies on. They are added by this patch
> to Malta section, but they are not added to the general MIPS
> section, since they are really not MIPS-specific, and there
> may be some non-MIPS hardware using them in future.
> 
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>

Acked-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  MAINTAINERS | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7803fe7..2af7313 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -959,8 +959,11 @@ M: Aleksandar Markovic <amarkovic@wavecomp.com>
>  M: Philippe Mathieu-Daudé <f4bug@amsat.org>
>  R: Aurelien Jarno <aurelien@aurel32.net>
>  S: Maintained
> +F: hw/isa/piix4.c
> +F: hw/acpi/piix4.c
>  F: hw/mips/mips_malta.c
>  F: hw/mips/gt64xxx_pci.c
> +F: include/hw/southbridge/piix.h
>  F: tests/acceptance/linux_ssh_mips_malta.py
>  
>  Mipssim
> 

