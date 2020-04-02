Return-Path: <SRS0=DsKm=5S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7CC1C43331
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 17:24:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9962F20757
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 17:24:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tW3RDJCH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9962F20757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45168 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jK3aK-0007rX-RD
	for qemu-devel@archiver.kernel.org; Thu, 02 Apr 2020 13:24:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46421)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1jK3Za-0006lU-76
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 13:24:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1jK3ZZ-0001pV-9J
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 13:24:10 -0400
Received: from mail-vk1-xa41.google.com ([2607:f8b0:4864:20::a41]:34191)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1jK3ZZ-0001pI-5m; Thu, 02 Apr 2020 13:24:09 -0400
Received: by mail-vk1-xa41.google.com with SMTP id p123so1154908vkg.1;
 Thu, 02 Apr 2020 10:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=dbAYIMSchJGpMWKqvejXOWtcSWVyoR+mTLe6byftqeY=;
 b=tW3RDJCHWookHb3ZcWLSYXHBPZZEDJlUikDZQT5mO/v/lj1biKBnZWIMz15kX6zq5Y
 PifwBBjtjjwH0G/y9BGuT+ITIOKxHKyNcsMOmGmxCLuhUgcyRrZcGpEekY6eVr+HyfoP
 IJZAclRku/OqgTyhHxXW59cH84Hpcm2HLIZuOAmFghj7fVzYtZdRGs+KKooKBDBPDeyp
 2S7joBe9Kpl2WpaT0/eDIKGmw0jvDcRCyyOhtlYQu9IXfNfXW5kxFhMO33hGTA8HwYr2
 /Wz7Z1Ou5WLWjLBBKvRc49LytKCBf5jcrZtzTaBw++xQ6XbY1IDFbyf6GiwqWN8MDo0B
 xnBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=dbAYIMSchJGpMWKqvejXOWtcSWVyoR+mTLe6byftqeY=;
 b=B8mkRQwzgLTvnfghwxpCY23Pd8JXOMig9F3N1Ao4x3Lx48vNSg11Iu+0VOFhA5AubY
 v/l7+0UMkjgz6VvKNMk3BbNin5oxHxAH/C75i9QaNVGINflBreeNze66tO9m1lLMtHHp
 FkPp5VB300AQ3NqamLK9U0hmMYkVG1rR2KHx2rFfxatEaWUQLqzmQ2PuGM4nNUp+c1nM
 DBacfRappJ7lU8o5MzfW2HUIE+DDr+3Wlc77j/hLQLZs2WQ8BpDeVcZK4HaTJdRY3nqT
 Ein9TdcnYoxH9Y1Sjs3U7c6cAIIioktjOmYsRTzV7/HTQoWgcCCqicOhb4u+mtYahWXX
 0lpA==
X-Gm-Message-State: AGi0PuYJWdMxLCoPx2oCWtdGL6Hpzc0owskrz7dPB99juvbS3roLAtZP
 cB8LW1v2huT1fPn6JdOkBbZYt90IsWHFcxBCXMBg6gDI
X-Google-Smtp-Source: APiQypJqlkYpmP3NKaSAbfvMeUusyh7f2+p+3OCw4dPtLPZJs2riMRN9RQj9USdpqnc+VZZ5JH9uW8bdGKmteDclBrw=
X-Received: by 2002:a1f:a2d0:: with SMTP id l199mr3118706vke.77.1585848248617; 
 Thu, 02 Apr 2020 10:24:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200402134721.27863-1-edgar.iglesias@gmail.com>
 <20200402134721.27863-4-edgar.iglesias@gmail.com>
In-Reply-To: <20200402134721.27863-4-edgar.iglesias@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 2 Apr 2020 10:15:56 -0700
Message-ID: <CAKmqyKMKiDXHcPP0+WxmoN_6cQvTcxC-cYpkDfT7YYur+0N8NQ@mail.gmail.com>
Subject: Re: [PATCH v1 3/5] dma/xlnx-zdma: Clear DMA_DONE when halting
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::a41
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

On Thu, Apr 2, 2020 at 6:50 AM Edgar E. Iglesias
<edgar.iglesias@gmail.com> wrote:
>
> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
>
> Clear DMA_DONE when halting the DMA channel.
>
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/dma/xlnx-zdma.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/hw/dma/xlnx-zdma.c b/hw/dma/xlnx-zdma.c
> index 6a4699757a..dd893bc420 100644
> --- a/hw/dma/xlnx-zdma.c
> +++ b/hw/dma/xlnx-zdma.c
> @@ -520,6 +520,7 @@ static void zdma_process_descr(XlnxZDMA *s)
>      if (src_cmd == CMD_HALT) {
>          zdma_set_state(s, PAUSED);
>          ARRAY_FIELD_DP32(s->regs, ZDMA_CH_ISR, DMA_PAUSE, 1);
> +        ARRAY_FIELD_DP32(s->regs, ZDMA_CH_ISR, DMA_DONE, false);
>          zdma_ch_imr_update_irq(s);
>          return;
>      }
> --
> 2.20.1
>
>

