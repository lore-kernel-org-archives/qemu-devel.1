Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02C2EC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 09:48:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC0452070A
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 09:48:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VMVnzXM8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC0452070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39510 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdWBw-0004fn-0v
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 05:48:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56950)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1jdWBF-0003pR-J0; Tue, 26 May 2020 05:47:29 -0400
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:34052)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1jdWBE-0006TQ-4M; Tue, 26 May 2020 05:47:29 -0400
Received: by mail-lj1-x242.google.com with SMTP id b6so23718292ljj.1;
 Tue, 26 May 2020 02:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=7eFtz95esepZNYhw5VvO90A3LK9OZU7VSR8Qv+XAU8Y=;
 b=VMVnzXM8MpjkIvaSsl1+NTIo7vseViToyjRMdAtW1BOsZAtARZu4rdPykGcu78l9cC
 PZhy1RjlHoVepzqKEQj7QyU/OTZ7ZG07qjwooILxU4LxwKFCWq67yQJMTX3mWxTq0ULW
 ypzgHeBmweSmcNQYJOmTZsEuKUT1vu34/yFZ/f2jW1GaDuj4DWUY1r8B+OZ+U1qaWnRV
 LtfrwgDJFtQB0HznTOKvdTacaFPOsxWLziN2vENwS7TEbHyfMXyqQ1fBoykoNZulHDCu
 GRVpdQfRz+XmJMHcYnETMsC1HTk4kup8r8zXEBc5KqHV4kHTEsu/Hd8IOGqXdQxDPe7k
 M9dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=7eFtz95esepZNYhw5VvO90A3LK9OZU7VSR8Qv+XAU8Y=;
 b=W0/XTq67DDZK0FxVO1yrXgBqDU2gwbqF7MyAg7hMcydRIxPYHXmKnJSztA+yp9OtVQ
 XZAKVPjyGoT++FNLyn7MXDOXyoU/YHCD4P7iKUuYVAS1PXd3lif/qGXOWCwiRqqLAIJp
 qX83coF8L5FMPre/SM4lEg/72f1eXwA3GbGY4Fs+OPOmAFuvUti2Sj9/TycJ3fPZOqEG
 DJxXnSsMHh6I+Pf7P7w9I1uprf/epv/NJlhncUFFM1wmre2/AEA6XnekzjBGpv/mqgWv
 KzdOSRuWE8C4WzeeatndH4hQsD6N2dJjkSJYabJ3pNbY7iHdbA4iCV5Ub2yJdZdxN+p9
 FDxw==
X-Gm-Message-State: AOAM531ig2uI76vAO1gYz7iqnct5An4CXuRXWSaH/clVW0bdr15Fgr4O
 VIXCUtxrkkmayA9D5Q3Uh9A=
X-Google-Smtp-Source: ABdhPJweSBuoImXkURyiORu593uF8kwzX3OaSGRtBARFx9ByiLB/AUlNNAViN3ySjOOv8ni4RiKs0Q==
X-Received: by 2002:a05:651c:3c5:: with SMTP id
 f5mr191078ljp.448.1590486445311; 
 Tue, 26 May 2020 02:47:25 -0700 (PDT)
Received: from localhost (81-231-232-130-no39.tbcn.telia.com. [81.231.232.130])
 by smtp.gmail.com with ESMTPSA id f12sm5852838lfp.8.2020.05.26.02.47.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2020 02:47:24 -0700 (PDT)
Date: Tue, 26 May 2020 11:47:19 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Subject: Re: [PATCH 09/14] hw/display/xlnx_dp: Replace disabled DPRINTF() by
 error_report()
Message-ID: <20200526094719.GB8957@toto>
References: <20200526062252.19852-1-f4bug@amsat.org>
 <20200526062252.19852-10-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200526062252.19852-10-f4bug@amsat.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Received-SPF: pass client-ip=2a00:1450:4864:20::242;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lj1-x242.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-trivial@nongnu.org,
 Alistair Francis <alistair@alistair23.me>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, qemu-arm@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, May 26, 2020 at 08:22:47AM +0200, Philippe Mathieu-Daudé wrote:
> DPRINTF() calls are disabled by default, so when unexpected
> data is used, the whole process abort without information.
> 
> Display a bit of information with error_report() before crashing.

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>



> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  hw/display/xlnx_dp.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/display/xlnx_dp.c b/hw/display/xlnx_dp.c
> index 3e5fb44e06..8d940cd8d1 100644
> --- a/hw/display/xlnx_dp.c
> +++ b/hw/display/xlnx_dp.c
> @@ -1,5 +1,5 @@
>  /*
> - * xlnx_dp.c
> + * Xilinx Display Port
>   *
>   *  Copyright (C) 2015 : GreenSocs Ltd
>   *      http://www.greensocs.com/ , email: info@greensocs.com
> @@ -24,6 +24,7 @@
>  
>  #include "qemu/osdep.h"
>  #include "qapi/error.h"
> +#include "qemu/error-report.h"
>  #include "qemu/log.h"
>  #include "qemu/module.h"
>  #include "hw/display/xlnx_dp.h"
> @@ -465,7 +466,7 @@ static uint8_t xlnx_dp_aux_pop_tx_fifo(XlnxDPState *s)
>      uint8_t ret;
>  
>      if (fifo8_is_empty(&s->tx_fifo)) {
> -        DPRINTF("tx_fifo underflow..\n");
> +        error_report("%s: TX_FIFO underflow", __func__);
>          abort();
>      }
>      ret = fifo8_pop(&s->tx_fifo);
> @@ -525,6 +526,7 @@ static void xlnx_dp_aux_set_command(XlnxDPState *s, uint32_t value)
>          qemu_log_mask(LOG_UNIMP, "xlnx_dp: Write i2c status not implemented\n");
>          break;
>      default:
> +        error_report("%s: invalid command: %u", __func__, cmd);
>          abort();
>      }
>  
> @@ -631,8 +633,8 @@ static void xlnx_dp_change_graphic_fmt(XlnxDPState *s)
>          s->g_plane.format = PIXMAN_b8g8r8;
>          break;
>      default:
> -        DPRINTF("error: unsupported graphic format %u.\n",
> -                s->avbufm_registers[AV_BUF_FORMAT] & DP_GRAPHIC_MASK);
> +        error_report("%s: unsupported graphic format %u", __func__,
> +                     s->avbufm_registers[AV_BUF_FORMAT] & DP_GRAPHIC_MASK);
>          abort();
>      }
>  
> @@ -647,8 +649,8 @@ static void xlnx_dp_change_graphic_fmt(XlnxDPState *s)
>          s->v_plane.format = PIXMAN_x8b8g8r8;
>          break;
>      default:
> -        DPRINTF("error: unsupported video format %u.\n",
> -                s->avbufm_registers[AV_BUF_FORMAT] & DP_NL_VID_FMT_MASK);
> +        error_report("%s: unsupported video format %u", __func__,
> +                     s->avbufm_registers[AV_BUF_FORMAT] & DP_NL_VID_FMT_MASK);
>          abort();
>      }
>  
> -- 
> 2.21.3
> 

