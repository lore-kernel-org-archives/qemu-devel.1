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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86385C73C7C
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 09:23:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EBA620838
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 09:23:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sqs6lW5Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EBA620838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59276 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hl8pH-0007sN-7y
	for qemu-devel@archiver.kernel.org; Wed, 10 Jul 2019 05:23:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47015)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1hl8oV-0007R8-SE
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 05:23:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1hl8oU-0006EC-SD
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 05:22:59 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:45961)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1hl8oU-0006E0-N7
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 05:22:58 -0400
Received: by mail-ot1-x344.google.com with SMTP id x21so1422643otq.12
 for <qemu-devel@nongnu.org>; Wed, 10 Jul 2019 02:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=ZiCnGRn1LBCqCnEEfeb3hf2tdCM5hQ/OudTcMeir80A=;
 b=sqs6lW5ZJS6/ddHzMVtCL3AqWL1VZUXWnWoFd7wEFCmowemxeZvN1Kj4kygeMoG1da
 O1woIfAeav/Wj9Qk1HlyZvwux+a9TpH1eql73JE95fcCEzyLDwjyGL1V/zk0IxaTnNdQ
 a2vg+3dy0iX/M7+JBvWMJADmGOJ5dMCueaNzoGdkPQMGGLUXJOXyIFOnzumWEGxSXJcv
 gAc/gLWiGpO2OYUc0RXEZiSxtp0JMstFhbhva9xaKMf+GWf3ultSxc+Ef65VaOeF5V3c
 cWItHL14yQ2Trh/RXjJkOLKABcJSSlhsdbDOepGj6jrYQZKobam4mzm2/MR6aAIbfP1y
 lvwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=ZiCnGRn1LBCqCnEEfeb3hf2tdCM5hQ/OudTcMeir80A=;
 b=p5wA9FSq18PUls8HYlB0/9EEXJ1Ui8wMk73al42L8L8icFgQv+nJjM+sMGUCUlGeqi
 9XIUhgQAASFyKaSbSFL5q8rUgUpjhG31mFWLeXfpfOhV/8ce8tQibRuXfpp3YH1xfR8I
 SH3axJLg2BQZzV1Duj6u3MDBt00KiCk1OBBDw0wpD/yNRDyIXZldUTQW+Pfzgq/4S2ea
 a8bwOflm4/4FurKdYNXw4atsbVuDFS5uzA+ZN9VLaGLGCToOPASXkksheQJRrF0ZNPwk
 WdBZS32pw9U4jkb7WIULxMZRTXov+Y+RCZJOnjVeRF9RSjRtGIWW9NroHWJbhhddSzPI
 hyZA==
X-Gm-Message-State: APjAAAV2uYEyitQM6wqpGh0CeSFtu6h7pbeXIrKCnKoLsAyeNvCjRNqd
 aI4JjzGMZB50IJv7uok7FojgYHu/U3B2HPmwvso=
X-Google-Smtp-Source: APXvYqy5lwT/llQWOjxrjGU6wEovpeC5PexYStFSNG8T6niVxRVvckQlNMU5u/ylyDlxslTEpA2b4nSdaTAlu0uypCE=
X-Received: by 2002:a9d:6ad7:: with SMTP id m23mr22614236otq.306.1562750577934; 
 Wed, 10 Jul 2019 02:22:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:4798:0:0:0:0:0 with HTTP; Wed, 10 Jul 2019 02:22:57
 -0700 (PDT)
Received: by 2002:a9d:4798:0:0:0:0:0 with HTTP; Wed, 10 Jul 2019 02:22:57
 -0700 (PDT)
In-Reply-To: <20190709184823.4135-1-richard.henderson@linaro.org>
References: <20190709184823.4135-1-richard.henderson@linaro.org>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Wed, 10 Jul 2019 11:22:57 +0200
Message-ID: <CAL1e-=i7Paug3G4xFCVRpH=NadNti1oG9y8n7geUJeGDoizc4w@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
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
Cc: peter.maydell@linaro.org, beata.michalska@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Jul 9, 2019 8:56 PM, "Richard Henderson" <richard.henderson@linaro.org>
wrote:
>
> The aarch64 argument ordering for the operands is big-endian,
> whereas the tcg argument ordering is little-endian.  Use REG0
> so that we honor the rZ constraints.
>
> Fixes: 464c2969d5d
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

The commit message looks more like a list of some random items than logical
explanation of the code change. Improve it.

Regards,
Aleksandar

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
