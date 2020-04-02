Return-Path: <SRS0=DsKm=5S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F296C43331
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 17:07:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1B83206F6
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 17:07:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e0cM11So"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1B83206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44888 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jK3J4-0008Am-Tp
	for qemu-devel@archiver.kernel.org; Thu, 02 Apr 2020 13:07:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42710)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1jK3I1-0007LM-3C
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 13:06:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1jK3I0-0003PV-0x
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 13:06:00 -0400
Received: from mail-vs1-xe44.google.com ([2607:f8b0:4864:20::e44]:38285)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1jK3Hz-0003P2-R5; Thu, 02 Apr 2020 13:05:59 -0400
Received: by mail-vs1-xe44.google.com with SMTP id x206so2869243vsx.5;
 Thu, 02 Apr 2020 10:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=TbYWU2Jlqfbeqyj2fl2VXxgfCuBG4GtNYBQeDD+Vx/A=;
 b=e0cM11SorEKbqSLmbzZ7DEWcUik3F1Rfxu8McKj9IOdp0SbK4nw3SBO3Bo881u6Jsx
 LQLrhgJW29WV3vzu6mvARz+CPnpyyDCxinj8nyf5gZ8jMYsw4ONbW73dXnrROVQv3g+a
 Mdhd8pZRF2Jf3VH11cMfLnlcv1fD/6UWPFBLU1nHEe+PiOpWtbUq1zOxbDvWfMKzwolW
 bR2HoitgaIObMOkfWC4EI0kjhqfmh46KVEmMxjx7BxP2xFaPlgA/Nj4nJ8yc4DtNogyt
 qvnVA0rpoBYPRSBVUprURTSJhV7DL7xQPuGdYLWh9E3td3L/JK6mjNDYH8UxErFz+/wN
 v2DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=TbYWU2Jlqfbeqyj2fl2VXxgfCuBG4GtNYBQeDD+Vx/A=;
 b=BHhMjE/ro+qhSlouqSTA33KcDCHLQrUYhZ37JDTEYcD355gpAq7NmnJU8+jyaJlLKP
 HASCergjFq3TzxSLW1bUAlzF7zbqWir/lMKWz0loRawOs9feMMQ+54JjdOVlOg8Ez6KK
 TH3nPlsZQvPa+OUTyVK/8xEbNXhC9oYanUJCtkgDe7Zh4J8YoiZNQF9eBIDd6FtsxLlK
 8lBLs6CHOlWdRvmzA7g7SFckd8EqW/YYcFFM+1sWD8zz96w/xD2lf9qn6Aqye1LSVFH2
 r2cnYgRLS4QX4Zr6LX8c/Z/jPGqsYNuhtZrKU9rFZgdBIDGass8FsNQHu2edyNm4aK7L
 yGfw==
X-Gm-Message-State: AGi0PubB9Iy6ZmZdyJwDYZSbDFIN0kPL90n4yJQIYh7HMotNeGFnRgxn
 By44gjvoT08+AeG2R6mHrQGxOSnuYYMJlitgZjw=
X-Google-Smtp-Source: APiQypKjMREhrqxH4TqlXYVeiOeu5bjXXN4xUFaXASHUQaTAtK+b+nrd+UHSmMt352o5dEQThAcIjXeTrtMSNC0FgLw=
X-Received: by 2002:a05:6102:730:: with SMTP id
 u16mr2889551vsg.70.1585847158764; 
 Thu, 02 Apr 2020 10:05:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200402134721.27863-1-edgar.iglesias@gmail.com>
 <20200402134721.27863-2-edgar.iglesias@gmail.com>
In-Reply-To: <20200402134721.27863-2-edgar.iglesias@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 2 Apr 2020 09:57:46 -0700
Message-ID: <CAKmqyKMUesgAAvU+e1gbiv3bK9QxpJHtM-GzbXxLfLiEF8eRKg@mail.gmail.com>
Subject: Re: [PATCH v1 1/5] dma/xlnx-zdma: Remove comment
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::e44
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
Cc: figlesia@xilinx.com, Peter Maydell <peter.maydell@linaro.org>,
 Edgar Iglesias <edgar.iglesias@xilinx.com>,
 Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>,
 Francisco Iglesias <frasse.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Richard Henderson <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 Stefano Stabellini <sstabellini@kernel.org>, qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Luc Michel <luc.michel@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Apr 2, 2020 at 6:49 AM Edgar E. Iglesias
<edgar.iglesias@gmail.com> wrote:
>
> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
>
> Remove comment.
>
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/dma/xlnx-zdma.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/hw/dma/xlnx-zdma.c b/hw/dma/xlnx-zdma.c
> index 2d9c0a0d5e..a6c5b2304a 100644
> --- a/hw/dma/xlnx-zdma.c
> +++ b/hw/dma/xlnx-zdma.c
> @@ -511,7 +511,6 @@ static void zdma_process_descr(XlnxZDMA *s)
>          zdma_src_done(s);
>      }
>
> -    /* Load next descriptor.  */
>      if (ptype == PT_REG || src_cmd == CMD_STOP) {
>          ARRAY_FIELD_DP32(s->regs, ZDMA_CH_CTRL2, EN, 0);
>          zdma_set_state(s, DISABLED);
> --
> 2.20.1
>
>

