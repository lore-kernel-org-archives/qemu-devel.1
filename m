Return-Path: <SRS0=pQgJ=ZH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACF83C432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 19:31:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 761C1206D9
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 19:31:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lyAnnFGr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 761C1206D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44458 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVhJG-0008O9-Ht
	for qemu-devel@archiver.kernel.org; Fri, 15 Nov 2019 14:31:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59433)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1iVhIL-0007nc-HC
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 14:30:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1iVhIK-0001Ep-AA
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 14:30:13 -0500
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144]:41717)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1iVhIH-00018l-Mh; Fri, 15 Nov 2019 14:30:09 -0500
Received: by mail-lf1-x144.google.com with SMTP id j14so8821461lfb.8;
 Fri, 15 Nov 2019 11:30:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=h/apNc2lpH2/OD74Mr2EXYiB0PVupSrPYk7ZBbbZdVg=;
 b=lyAnnFGrURVgEBTYUKTRlPT5WT/Cu50lwaj53sEXMWpq7pW++DIaVpr7HdS+BeikSj
 55o6u1On5OrJGrQjRSSPZs6loWbqpl2u5qbs0mZpl18YqUuLh8kTGEvb5hhdqMXYJe/c
 pqlXDDFgH76WW5srzNDG27kUIFpuGiGmDxij7JMIbCJxLz5EMvSzMSo05dm93cfCBIqR
 pFNttY90I20PFSMmCWjj9rNvDWOHBD9HsKmpivbnV514vzIrMFXPes0MnDe9N0BWwmBO
 0dcDfdt7clxNuaHUQelOphiOb/ZaKlvLKzuXP7nlxXThQjTpNXIhmyXNN/eOeSo/je2N
 blww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=h/apNc2lpH2/OD74Mr2EXYiB0PVupSrPYk7ZBbbZdVg=;
 b=WgdyFqlPKzY5QjHiZK/EcjBS2LiWj3lVvaOAX+DpH89jODUDse2Idl8LAGeOCv6kHI
 2mFRMyTGU/oj3CuLZXrZxvMBdArnsIKGYGoZQaW5+ysuN2vQ7nBTknq2ppDC0BzSQxma
 mmm6F9jnAF1t8XPpbqNT8IV9v1B93Ne871J885jNW3dgDwtsLfvcv7pxPN8/fsRJwnGs
 HwBMERpa1+SKB6dU0tjEhcwN8wJMeV6V0y0W5mEX8JA0KMgeizag3h6YOtuYIyfpN6G8
 DpZhtLbHqRRVLtoaCggg50+tw/A+hJZHAbLXTBWAxmLPlv7JCDvVizcG7PxDB2j2PWa4
 BYag==
X-Gm-Message-State: APjAAAU81hr+3H4ANc01goGbcwnoEFx/x6DyxVCgj7pWwn8SRVk/Al6c
 oeks4dy4ZPl5AoyIQEVeWf2ISVZA4VY5bKuyngo=
X-Google-Smtp-Source: APXvYqx36krAKBGNZiNsjHQYt9WH5SjUmXRkb0JbKQgzo7cPd+ZQq3dnNBiPvrj6HOMuDTWmn+sJdYl+tWgDb9Cvmjg=
X-Received: by 2002:ac2:4a8f:: with SMTP id l15mr12227636lfp.5.1573846208263; 
 Fri, 15 Nov 2019 11:30:08 -0800 (PST)
MIME-Version: 1.0
References: <1573833408-2388-1-git-send-email-sai.pavan.boddu@xilinx.com>
In-Reply-To: <1573833408-2388-1-git-send-email-sai.pavan.boddu@xilinx.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 15 Nov 2019 14:29:41 -0500
Message-ID: <CAKmqyKNJf1Hin=tRV7nZ0TaUYD1NacK4FBJqvfxxnbUdoo_BNg@mail.gmail.com>
Subject: Re: [PATCH] display: xlnx_dp: Provide sufficient bytes for silent
 audio channel
To: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::144
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
 Alistair Francis <alistair@alistair23.me>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 qemu-arm <qemu-arm@nongnu.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 KONRAD Frederic <fred.konrad@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Nov 15, 2019 at 10:59 AM Sai Pavan Boddu
<sai.pavan.boddu@xilinx.com> wrote:
>
> Fill the audio channel with required number of bytes to cover the
> elapsed time. This prevents rate control reset, and avoids debug prints
> like below
>
> log:
>         Resetting rate control (65692 samples)
>         ...
>         Resetting rate control (65721 samples)
>         ...
>
> Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/display/xlnx_dp.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/hw/display/xlnx_dp.c b/hw/display/xlnx_dp.c
> index fde3b21..7058443 100644
> --- a/hw/display/xlnx_dp.c
> +++ b/hw/display/xlnx_dp.c
> @@ -394,13 +394,18 @@ static void xlnx_dp_audio_callback(void *opaque, int avail)
>              written = AUD_write(s->amixer_output_stream,
>                                  &s->out_buffer[s->data_ptr], s->byte_left);
>          } else {
> +             int len_to_copy;
>              /*
>               * There is nothing to play.. We don't have any data! Fill the
>               * buffer with zero's and send it.
>               */
>              written = 0;
> -            memset(s->out_buffer, 0, 1024);
> -            AUD_write(s->amixer_output_stream, s->out_buffer, 1024);
> +            while (avail) {
> +                len_to_copy = MIN(AUD_CHBUF_MAX_DEPTH, avail);
> +                memset(s->out_buffer, 0, len_to_copy);
> +                avail -= AUD_write(s->amixer_output_stream, s->out_buffer,
> +                                   len_to_copy);
> +            }
>          }
>      } else {
>          written = AUD_write(s->amixer_output_stream,
> --
> 2.7.4
>
>

