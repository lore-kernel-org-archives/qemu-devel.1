Return-Path: <SRS0=QD06=ZF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18EFBC43331
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 12:31:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7AF02084E
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 12:31:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cp5czC2B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7AF02084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43578 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUroU-0007f5-2t
	for qemu-devel@archiver.kernel.org; Wed, 13 Nov 2019 07:31:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36184)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iUrnP-000768-Bv
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 07:30:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iUrnG-000776-0l
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 07:30:49 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:38692)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iUrnC-00073l-5w
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 07:30:40 -0500
Received: by mail-wm1-x343.google.com with SMTP id z19so1811158wmk.3
 for <qemu-devel@nongnu.org>; Wed, 13 Nov 2019 04:30:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=kFiqa2wHPZWY7xGMxv0sq2nRT4qyLXew9IFI8JS5LOc=;
 b=cp5czC2BvAuwJXdne8vhjucC/0jM2uXAjvGUvjxqg0hx0Qke5NH/jzMPJx4xjrnegz
 dBrsQaqfoKXcSMvU6gx7brzn+rA4uSdGtBCgGG6F+7CvpT4u/ULXIRbw1amjkNzMs/VW
 SPBYvNq/m3hl1tbvrg58Y0rqqaGArbugadV5aQS704NmnbAiNTBCbGY4Nqxe9M30/2gT
 V1NQ2dvKmzyUHB+cXC3GLOu+Uzjq1rCZF1lURJ2qMauxXk9b1LUXzq0Lex2bQbGFSToG
 LL7UPMZfJu0o8AIvOYxFV+joabiuAQvz9m/q/EGACXXRqAFJsMDxuJRugSf/38K/nwOi
 7Ltg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=kFiqa2wHPZWY7xGMxv0sq2nRT4qyLXew9IFI8JS5LOc=;
 b=OjHhSVA1Ol6hwzBj8C4a0vzBtJBf1zQhFE2MGh97w/NsLQMPm+tHcJiZR/Xx0xtHZp
 wLDRgXIh2gUunNHJehcePufus0U5gKVN2jECYG1+G1an18DFQ0ZV5rv0O4ZexnuOYNh1
 y62XI2wjL7g3brqruPnv+dWJLZNKVgqQU2PYMf+i9WoHHksg/YnjaeTsLj5v9TULsyd4
 3Grjv8ZwM/urqeBDjK4LErCF1EMEfF63UhFdh4sYA1Lv1gIYj5zUtULM4eQ+EvZFdCBI
 PZF+64pAoANy2kLokxDGfZOMbiF6dpVDT13Rg7hS5LC6CY3VJjc10/A0Yqd8dzBfTx0p
 GGcw==
X-Gm-Message-State: APjAAAXfpbiXhmKoqMZu+vJs+LkMGi5DAEhJdeJRyQ2f7DJmlqtEYCK5
 9dZSVg6yrWqAbN4xmBUq93TkXw==
X-Google-Smtp-Source: APXvYqzyZSUJVvzun3LQ4xhllLQTeOtwcD3/I/VuTRT57r9+2XTU28QJ9wgd4FB59tObH+4VyWxbfQ==
X-Received: by 2002:a1c:9804:: with SMTP id a4mr2484019wme.57.1573648236140;
 Wed, 13 Nov 2019 04:30:36 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id g184sm2323052wma.8.2019.11.13.04.30.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Nov 2019 04:30:35 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 9BBEA1FF87;
 Wed, 13 Nov 2019 12:30:34 +0000 (GMT)
References: <20191113005201.19005-1-joel@jms.id.au>
 <20191113005201.19005-3-joel@jms.id.au>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-arm@nongnu.org
Subject: Re: [PATCH v2 2/4] aspeed/scu: Fix W1C behavior
In-reply-to: <20191113005201.19005-3-joel@jms.id.au>
Date: Wed, 13 Nov 2019 12:30:34 +0000
Message-ID: <877e447yc5.fsf@linaro.org>
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
Cc: Andrew Jeffery <andrew@aj.id.au>, Peter Maydell <peter.maydell@linaro.org>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Joel Stanley <joel@jms.id.au> writes:

> This models the clock write one to clear registers, and fixes up some
> incorrect behavior in all of the write to clear registers.
>
> There was also a typo in one of the register definitions.
>
> Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
>  hw/misc/aspeed_scu.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/hw/misc/aspeed_scu.c b/hw/misc/aspeed_scu.c
> index 717509bc5460..aac4645f8c3c 100644
> --- a/hw/misc/aspeed_scu.c
> +++ b/hw/misc/aspeed_scu.c
> @@ -98,7 +98,7 @@
>  #define AST2600_CLK_STOP_CTRL     TO_REG(0x80)
>  #define AST2600_CLK_STOP_CTRL_CLR TO_REG(0x84)
>  #define AST2600_CLK_STOP_CTRL2     TO_REG(0x90)
> -#define AST2600_CLK_STOP_CTR2L_CLR TO_REG(0x94)
> +#define AST2600_CLK_STOP_CTRL2_CLR TO_REG(0x94)
>  #define AST2600_SDRAM_HANDSHAKE   TO_REG(0x100)
>  #define AST2600_HPLL_PARAM        TO_REG(0x200)
>  #define AST2600_HPLL_EXT          TO_REG(0x204)
> @@ -532,11 +532,12 @@ static uint64_t aspeed_ast2600_scu_read(void *opaqu=
e, hwaddr offset,
>      return s->regs[reg];
>  }
>
> -static void aspeed_ast2600_scu_write(void *opaque, hwaddr offset, uint64=
_t data,
> +static void aspeed_ast2600_scu_write(void *opaque, hwaddr offset, uint64=
_t data64,
>                                       unsigned size)
>  {
>      AspeedSCUState *s =3D ASPEED_SCU(opaque);
>      int reg =3D TO_REG(offset);
> +    uint32_t data =3D data64;

Does it make much difference silently truncating to 32 bit here vs in
the actual set further down? AFAICT most _write functions just deal with
it at the final set.

>
>      if (reg >=3D ASPEED_AST2600_SCU_NR_REGS) {
>          qemu_log_mask(LOG_GUEST_ERROR,
> @@ -563,15 +564,19 @@ static void aspeed_ast2600_scu_write(void *opaque, =
hwaddr offset, uint64_t data,
>          /* fall through */
>      case AST2600_SYS_RST_CTRL:
>      case AST2600_SYS_RST_CTRL2:
> +    case AST2600_CLK_STOP_CTRL:
> +    case AST2600_CLK_STOP_CTRL2:
>          /* W1S (Write 1 to set) registers */
>          s->regs[reg] |=3D data;
>          return;
>      case AST2600_SYS_RST_CTRL_CLR:
>      case AST2600_SYS_RST_CTRL2_CLR:
> +    case AST2600_CLK_STOP_CTRL_CLR:
> +    case AST2600_CLK_STOP_CTRL2_CLR:
>      case AST2600_HW_STRAP1_CLR:
>      case AST2600_HW_STRAP2_CLR:
>          /* W1C (Write 1 to clear) registers */
> -        s->regs[reg] &=3D ~data;
> +        s->regs[reg - 1] &=3D ~data;

It might be worth expanding the W1C comment just to mention the
alignment of _CLR vs _CTRL registers.

Otherwise:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>


>          return;
>
>      case AST2600_RNG_DATA:


--
Alex Benn=C3=A9e

