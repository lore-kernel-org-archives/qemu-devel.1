Return-Path: <SRS0=1g4J=U5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52E7BC5B57E
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Jun 2019 09:53:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15B582054F
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Jun 2019 09:53:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jNwKd+0S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15B582054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43698 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhWWr-0005qN-BS
	for qemu-devel@archiver.kernel.org; Sun, 30 Jun 2019 05:53:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42508)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1hhWVl-0005H3-Jn
 for qemu-devel@nongnu.org; Sun, 30 Jun 2019 05:52:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1hhWVk-0001FR-I8
 for qemu-devel@nongnu.org; Sun, 30 Jun 2019 05:52:41 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:38143)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1hhWVk-0001Da-6x
 for qemu-devel@nongnu.org; Sun, 30 Jun 2019 05:52:40 -0400
Received: by mail-oi1-x243.google.com with SMTP id v186so7623318oie.5
 for <qemu-devel@nongnu.org>; Sun, 30 Jun 2019 02:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=2WniCLmKWBIOePpI8AX4ouFPIwvtN6n1KVvLuO0x7Ns=;
 b=jNwKd+0SW1HtLe9TFxQHqphuDa1yCLee59X6XGoUD5Yhw12JCaRDUzECxDAZUMr4yH
 oQngAoeH+CrPmiO4ansXrEdXR8/rPGo9zqWtQVpHtpK5202E6JXJGjSFCUCE3m7dREKe
 YWss3q0m+s+5aSVdieH8C0/ZgS18BvSoFJFDjWGnCZ8Rg4aCy5e4cwmgMgkMIRiZmdZg
 yal7GQzHzxt8C+PNDVsThIKjmICYe/a8Wke4jY7fHGzI442d3nKQgOraa5GuIkJmCIFE
 mf0S1UwoWsiiMnpxxEsdH5u2/lT9KJcLSMI33f/8VlJmYfQcGc5rbZlFQjT/AyBq+0gs
 sZkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=2WniCLmKWBIOePpI8AX4ouFPIwvtN6n1KVvLuO0x7Ns=;
 b=sw0CSdBa9+kJaZtvHSX1QpjecrmL5FO52IhcymFCsUYs9eZBXxWqK8kPiPsZKy89Kz
 ZuWpXiVMTaPKWM4JkRnur3/3YMELEpfz1EDIdKcszASRbAyLOQHx/9r5WEeh0mheqRFf
 pRIt360hiYfrCU689pm1C6IHj/AOXp34DJZtmG9xH+tepbPFr8Uekc/t+NaAVWW/T/bQ
 kqh5/sWVkwgL1DfphmvSl71/llKiLcXKbt3zdMds3iiAAr6+0KH9M8sIp+qbDtWhY841
 S1lHwBbLfiOK0UTuD2Kedd/4EAT1IhuIiXGLxxcWbym9OvrqffOERtYqkr2ONHC+M/cx
 jQ1w==
X-Gm-Message-State: APjAAAUI31ujOPJxL1a9hXZxLDWQF3kLWctIcV0UswWMwqzt+Udnfph1
 rndHjKBSwrST/ktWtgBdKnHn+n3cZz32MggrTmE=
X-Google-Smtp-Source: APXvYqy0L8YDrUI3cx2Me2xhWJEO37dxRTurQ9NL3wSGosH7KAhP4STUJz9wkIrJhgv9KLEOew/Zat5UDrKSI3y3LaI=
X-Received: by 2002:aca:b254:: with SMTP id b81mr3643344oif.53.1561888359320; 
 Sun, 30 Jun 2019 02:52:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:4798:0:0:0:0:0 with HTTP; Sun, 30 Jun 2019 02:52:39
 -0700 (PDT)
In-Reply-To: <20190629130017.2973-10-richard.henderson@linaro.org>
References: <20190629130017.2973-1-richard.henderson@linaro.org>
 <20190629130017.2973-10-richard.henderson@linaro.org>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Sun, 30 Jun 2019 11:52:39 +0200
Message-ID: <CAL1e-=hwJmYvYbbdWoQjEcFqNginiTY8xDsgDwDY5t8GF6qBWg@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH v6 09/16] tcg/ppc: Prepare case for vector
 multiply
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
Cc: "mark.cave-ayland@ilande.co.uk" <mark.cave-ayland@ilande.co.uk>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "amarkovic@wavecomp.com" <amarkovic@wavecomp.com>,
 "hsp.cat7@gmail.com" <hsp.cat7@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Saturday, June 29, 2019, Richard Henderson <richard.henderson@linaro.org>
wrote:

> This line is just preparation for full vector multiply support
> in some of subsequent patches.
>
>
This patch should be aquashed into the patch on implementing multiply.



> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> ---
>  tcg/ppc/tcg-target.inc.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tcg/ppc/tcg-target.inc.c b/tcg/ppc/tcg-target.inc.c
> index 307e809fad..e19400609c 100644
> --- a/tcg/ppc/tcg-target.inc.c
> +++ b/tcg/ppc/tcg-target.inc.c
> @@ -3306,6 +3306,7 @@ static const TCGTargetOpDef
> *tcg_target_op_def(TCGOpcode op)
>
>      case INDEX_op_add_vec:
>      case INDEX_op_sub_vec:
> +    case INDEX_op_mul_vec:
>      case INDEX_op_and_vec:
>      case INDEX_op_or_vec:
>      case INDEX_op_xor_vec:
> --
> 2.17.1
>
>
>
