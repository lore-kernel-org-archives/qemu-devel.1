Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ED43CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 13:29:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 380AC21D71
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 13:29:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q/93RtM6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 380AC21D71
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59966 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNzej-0001hZ-R5
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 09:29:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60021)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <frasse.iglesias@gmail.com>) id 1iNzT0-0003jX-Nx
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 09:17:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <frasse.iglesias@gmail.com>) id 1iNzSx-0002Tg-Kg
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 09:17:22 -0400
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244]:42881)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <frasse.iglesias@gmail.com>)
 id 1iNzSx-0002Rk-Ak
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 09:17:19 -0400
Received: by mail-lj1-x244.google.com with SMTP id a21so2662130ljh.9
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2019 06:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=gwIJMoe1nqIE2c1gEvEPYH9oqyxsexG6v4l+/euLXsg=;
 b=q/93RtM6hFXIGLoi1dtU1zprSeiCGCpTQWKvALNkbawYv/lusFCCc9sE7gJeGyXoA1
 uUgN+fYmvhYJyG2Ko3CpNnwgCrmPfyoUmL+3THh9PoHSeb/3TA8qjlzKlEMygDezrKZa
 aQ744jwXocQxawFML4LkZp0Ne43aP1Sowfb+2iA907vlyvderzZ5S6Fp4hJBPbCTCVeW
 1GWEh79Kfvi6JcUDPZzczTqnXW+gIs0w8eK11nNaIrzNIkQzntWUy3GBPpBdyulDZ6TV
 wvw8OccZDpJ4TDvGNUWsLGQ19HJoN69uiHYyjz00p21lqANC4ooyLDy05Pq0rJsI1F8p
 G0/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=gwIJMoe1nqIE2c1gEvEPYH9oqyxsexG6v4l+/euLXsg=;
 b=KUJt7Tcha5cA2ETIY5p8zEChfwaKZl04G3AtAB9jc19VvQI2WNHt8Ti7wfsUFFvweP
 iKKcbVDS5XJuHFe12yjFF5B209CMe7KyfnFMFnmTmuZxszT2yBpqsY2e4u/3NdNn2fgB
 W3jjehLIWAr7yoC/hIMpphcuql1lC2BUlF60KiQFqHxKB0naVhh+2veucEI5mpk9e9EY
 LubLm4ioSXGXKo461jBMJl7nxNgVX/5uz0VjvY+W8RDF4Is9q/McELiZel/dLmZvO+fY
 axEOz0AXJbG38uKMLfwLXwZRSAmtTEB1HwLgzoZEF3Ybf3O4Yrw9C0LU2sd1BigZx3NY
 19Xg==
X-Gm-Message-State: APjAAAX159Lgeb4DjVPz1mcK95G/5ZOsLinlWUA0CyyjPMdvl4nbv8M9
 m859Z7PNDKe+Vv7Th7ztIYw=
X-Google-Smtp-Source: APXvYqxK7Yty1QZTsChhXVzK4EX9/0EPcS2zNTyMZdkMPxeYTxMeoYIAsXEcyptLaSPnMtIKPLm6mQ==
X-Received: by 2002:a2e:908d:: with SMTP id l13mr2328718ljg.165.1572009437413; 
 Fri, 25 Oct 2019 06:17:17 -0700 (PDT)
Received: from fralle-msi (31-208-27-151.cust.bredband2.com. [31.208.27.151])
 by smtp.gmail.com with ESMTPSA id
 i190sm1487662lfi.45.2019.10.25.06.17.16
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 25 Oct 2019 06:17:16 -0700 (PDT)
Date: Fri, 25 Oct 2019 15:17:15 +0200
From: Francisco Iglesias <frasse.iglesias@gmail.com>
To: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
Subject: Re: [PATCH v5] ssi: xilinx_spips: Skip spi bus update for a few
 register writes
Message-ID: <20191025131713.pthu3ihbuhllzszd@fralle-msi>
References: <1571981531-27498-1-git-send-email-sai.pavan.boddu@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1571981531-27498-1-git-send-email-sai.pavan.boddu@xilinx.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::244
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
 Edgar Iglesias <edgari@xilinx.com>, Alistair Francis <alistair@alistair23.me>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Sai,

On [2019 Oct 25] Fri 11:02:11, Sai Pavan Boddu wrote:
> A few configuration register writes need not update the spi bus state, so just
> return after register write.

s/register write/the register write/

> 
> Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>

After above change:

Reviewed-by: Francisco Iglesias <frasse.iglesias@gmail.com>
Tested-by: Francisco Iglesias <frasse.iglesias@gmail.com>

Best regards,
Francisco Iglesias

> ---
> 
> Changes for V2:
> 	Just skip update of spips cs and fifos
> 	Update commit message accordingly
> Changes for V4:
> 	Avoid checking for zynqmp qspi
> 	Skip spi bus update for few of the registers Changes for V4:
> 	Move the register list to existing switch case above.
> Change for V5:
> 	Fixed Commit message.
> 
>  hw/ssi/xilinx_spips.c | 22 ++++++++++++++++++----
>  1 file changed, 18 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/ssi/xilinx_spips.c b/hw/ssi/xilinx_spips.c
> index a309c71..0d6c2e1 100644
> --- a/hw/ssi/xilinx_spips.c
> +++ b/hw/ssi/xilinx_spips.c
> @@ -109,6 +109,7 @@
>  #define R_GPIO              (0x30 / 4)
>  #define R_LPBK_DLY_ADJ      (0x38 / 4)
>  #define R_LPBK_DLY_ADJ_RESET (0x33)
> +#define R_IOU_TAPDLY_BYPASS (0x3C / 4)
>  #define R_TXD1              (0x80 / 4)
>  #define R_TXD2              (0x84 / 4)
>  #define R_TXD3              (0x88 / 4)
> @@ -139,6 +140,8 @@
>  #define R_LQSPI_STS         (0xA4 / 4)
>  #define LQSPI_STS_WR_RECVD      (1 << 1)
>  
> +#define R_DUMMY_CYCLE_EN    (0xC8 / 4)
> +#define R_ECO               (0xF8 / 4)
>  #define R_MOD_ID            (0xFC / 4)
>  
>  #define R_GQSPI_SELECT          (0x144 / 4)
> @@ -970,6 +973,7 @@ static void xilinx_spips_write(void *opaque, hwaddr addr,
>  {
>      int mask = ~0;
>      XilinxSPIPS *s = opaque;
> +    bool try_flush = true;
>  
>      DB_PRINT_L(0, "addr=" TARGET_FMT_plx " = %x\n", addr, (unsigned)value);
>      addr >>= 2;
> @@ -1019,13 +1023,23 @@ static void xilinx_spips_write(void *opaque, hwaddr addr,
>          tx_data_bytes(&s->tx_fifo, (uint32_t)value, 3,
>                        s->regs[R_CONFIG] & R_CONFIG_ENDIAN);
>          goto no_reg_update;
> +    /* Skip SPI bus update for below registers writes */
> +    case R_GPIO:
> +    case R_LPBK_DLY_ADJ:
> +    case R_IOU_TAPDLY_BYPASS:
> +    case R_DUMMY_CYCLE_EN:
> +    case R_ECO:
> +        try_flush = false;
> +        break;
>      }
>      s->regs[addr] = (s->regs[addr] & ~mask) | (value & mask);
>  no_reg_update:
> -    xilinx_spips_update_cs_lines(s);
> -    xilinx_spips_check_flush(s);
> -    xilinx_spips_update_cs_lines(s);
> -    xilinx_spips_update_ixr(s);
> +    if (try_flush) {
> +        xilinx_spips_update_cs_lines(s);
> +        xilinx_spips_check_flush(s);
> +        xilinx_spips_update_cs_lines(s);
> +        xilinx_spips_update_ixr(s);
> +    }
>  }
>  
>  static const MemoryRegionOps spips_ops = {
> -- 
> 2.7.4
> 

