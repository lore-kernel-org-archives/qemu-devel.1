Return-Path: <SRS0=axyf=VH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86C0CC74A36
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 18:14:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52985208C4
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 18:14:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L7I5mnpL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52985208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35952 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlH6W-0004Lq-Ek
	for qemu-devel@archiver.kernel.org; Wed, 10 Jul 2019 14:14:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37337)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1hlH5S-0003kM-Pg
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 14:13:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1hlH5M-0003vT-Fz
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 14:13:01 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:44188)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1hlH5G-0003py-Ob
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 14:12:52 -0400
Received: by mail-ot1-x341.google.com with SMTP id b7so3059469otl.11
 for <qemu-devel@nongnu.org>; Wed, 10 Jul 2019 11:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Tpz/YQPEPZHVw8PsUqqUhyGc6pUmo43LSxWvPFFKygc=;
 b=L7I5mnpLELh0t3RQn6pLWOXeHnMwe5jL1tVWmsxjRpIBfgXcBBNIMxz1h7bQPfpqQU
 NRHxAqHUSc/il1CTyYbm7MwSI2XPXvDGxRI1fU82w/r4JHcC5toBnMDt3S0d+PcyUB2W
 AYTKZh/al2aw6QguwSLCw3Kl/4HecGNJGzszMzy2Txx8OTqDXgPPzsVVm44IkVQ8dmSz
 DEwYPmncruZNc38+zZUJvT2DLBjqsUdxORjL5tLVZQ6z8z9L4ezjTMJjPWF5Gm4RuxNS
 kYLPQurzQnre9AW4Rwy7xmJjLtZxu0zbSm6iwSm52nvuhAmm8nbpeGRrFvTunBAenAf1
 gEVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Tpz/YQPEPZHVw8PsUqqUhyGc6pUmo43LSxWvPFFKygc=;
 b=JNPReHFzhgZ3fReiTFG8rX2uhLnGBljd9/LFw6lxKclntcbr98C17rUMGNJugPQ44B
 nt8rNpgSt0davgUYlerCbtxTnmhrCQgTvueA3cZL0eC8Z7vLeHtisLQOHoBNVnYNyLuq
 nk/EeaSXlvbR9s4+yO9P+8D1/kSK+e1EDlzygZwNciqgk8E1qSNjgUt0PAAEmZOlxELB
 pdTO/QJ0iOS3mO6hKZ2JeJGN0F2xGrVik9fQFJ4pRHVeAfFvwF5YD6LtggPckl+Qojjq
 SNUEYKEuOrhDZ+mcXFcvkBV28upmkXaMjff3IZPzrCEjyw0kUT1avRxRNeQFlxw9ajGS
 FUfg==
X-Gm-Message-State: APjAAAWBJizwIP86kiMUy6XLSwtivpRLQbY1haLu2hlRqBX/2tyxoXaA
 Ag9Bd2N3BUhqTdoAztsagocKE6m+AFK6evHdeHk=
X-Google-Smtp-Source: APXvYqxvmUHJX3hm6v4XuodbkkrbAo9hEzuFQktZ9RZBdGH9g1Wj1kFLdxR0q58OTR+7xCCkByw9bKO8PEcDyog74/Y=
X-Received: by 2002:a9d:6ad7:: with SMTP id m23mr24492758otq.306.1562782368321; 
 Wed, 10 Jul 2019 11:12:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190709184823.4135-1-richard.henderson@linaro.org>
In-Reply-To: <20190709184823.4135-1-richard.henderson@linaro.org>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Wed, 10 Jul 2019 20:12:37 +0200
Message-ID: <CAL1e-=j8J0WLUjhaOvecSU3VtRf5W+zP-Ydi_kZth4BYV_cXtg@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
Subject: Re: [Qemu-devel] [PATCH] tcg/aarch64: Fix output of extract2 opcodes
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Beata Michalska <beata.michalska@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jul 9, 2019 at 8:56 PM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> The aarch64 argument ordering for the operands is big-endian,
> whereas the tcg argument ordering is little-endian.  Use REG0
> so that we honor the rZ constraints.

Hello, Richard.

If endian and rZ constraints are unrelated problems, then I think the
commit message
should be:

"This patch fixes two problem:

- endianness: the aarch64 argument ordering for the operands is
big-endian, whereas the tcg argument ordering is little-endian.

- rZ constrains: REG0() macro should be applied to the affected
arguments."

One could argue that in this case the patch this should be actually two patches.
This is better because of bisectability. The number of line in the
patch doesn't matter.

If, on the other hand, endian and rZ constraints are related problems, then you
should explain how in the commit message.

In general, your commit messages appear too terse, and it is hard to establish
logical sense of the changes in question.

Would you be so kind to consider my opinion?

Regards,
Aleksandar

>
> Fixes: 464c2969d5d
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  tcg/aarch64/tcg-target.inc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tcg/aarch64/tcg-target.inc.c b/tcg/aarch64/tcg-target.inc.c
> index b0f8106642..0713448bf5 100644
> --- a/tcg/aarch64/tcg-target.inc.c
> +++ b/tcg/aarch64/tcg-target.inc.c
> @@ -2226,7 +2226,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
>
>      case INDEX_op_extract2_i64:
>      case INDEX_op_extract2_i32:
> -        tcg_out_extr(s, ext, a0, a1, a2, args[3]);
> +        tcg_out_extr(s, ext, a0, REG0(2), REG0(1), args[3]);
>          break;
>
>      case INDEX_op_add2_i32:
> --
> 2.17.1
>
>

