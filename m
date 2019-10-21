Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2C6CCA9EAF
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 17:00:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B558D2064B
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 17:00:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lJLCHvGI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B558D2064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45566 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMb2t-0006Nm-SO
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 13:00:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41494)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <frasse.iglesias@gmail.com>) id 1iMb1z-0005Za-RU
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 12:59:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <frasse.iglesias@gmail.com>) id 1iMb1y-00028j-PO
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 12:59:43 -0400
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:34258)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <frasse.iglesias@gmail.com>)
 id 1iMb1y-000283-Hv
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 12:59:42 -0400
Received: by mail-lj1-x243.google.com with SMTP id j19so14150685lja.1
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2019 09:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=LXIQ1zI7Y6ORw5gbsVQKzQ4a6IZwcqXm/KknLZRKdoo=;
 b=lJLCHvGIln6mQF8LUoQluw1+zLJYCNHZ81yDHUJ040dsseBE7JA5XZ79WLVilAxqnC
 7VWHBt1yjK706gbJWfLSm9pg6ca7Uy0fKAr/C9U1smdv7xbmLvrF6qm6Tkl121PsgQiL
 rfMVdBIx2EEgRrhSVJYP/qaJ8CtLAha5Sk41XI9x6dC+Dw8RPqZeBPwSz5SEpV31VOXK
 Kz4B6M+ggh7VJc8mySBPXmpGpdC3bOfLgl2slBFwXQiiV8D/IDINdL/5oKCjJBBBQydT
 wS/GCzjl9HQUfjLPWdXkEBgDWe8WqnVbeRwycZaSeK74KrUllexP9tZMR0kBy3XsoAe9
 D31w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=LXIQ1zI7Y6ORw5gbsVQKzQ4a6IZwcqXm/KknLZRKdoo=;
 b=G1vKfxmq/GzKKXCEB48mLN7uknS50XzpHIUje78lMYrHB2n7qU0CxTPFP3PPpOcYUT
 sySyq0GgExMj2IZflRGNjTx0fU/h3K8ZZds/8pd2I+7oyO1IGvd3EF6+O0F6RT28XgVk
 PikwRAcj+SnWwIZunXHcfEZetIIRLW1ioilb3fpWTHglmRbuE/w8lsWtfFhfDTbtHSdp
 PfSVqrNVijkqYNpTV1+YP0r4AwsUpZ7V8jpx6f91OCQQjcvYUBzhLsJiNHksNIuJIKpZ
 Ak6Q5qJwBVVaZ2/tNSITCjZl4OFqoWCxZDVInBvgOGXBjjHkxoEGUiRyU2YD/Bw7+Wbm
 mrnQ==
X-Gm-Message-State: APjAAAWvlTDw6qJ4AHruIys2V3a2pG9TQsX9C0/WxeLChjolZzSAPc6i
 BAOV6s2LKpB5Vebzv69E960=
X-Google-Smtp-Source: APXvYqx+WS2pohYIqV+NXTp4LnAmGSUgylFIPIwULqrxc1VRyfwqX1X1TfTq5P8Sn+EJmn9SNv3f0Q==
X-Received: by 2002:a2e:858d:: with SMTP id b13mr14036767lji.71.1571677180549; 
 Mon, 21 Oct 2019 09:59:40 -0700 (PDT)
Received: from fralle-msi (31-208-27-151.cust.bredband2.com. [31.208.27.151])
 by smtp.gmail.com with ESMTPSA id
 v7sm6700766lfd.55.2019.10.21.09.59.39
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 21 Oct 2019 09:59:39 -0700 (PDT)
Date: Mon, 21 Oct 2019 18:59:38 +0200
From: Francisco Iglesias <frasse.iglesias@gmail.com>
To: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
Subject: Re: [QEMU][PATCH v4] ssi: xilinx_spips: Skip spi bus update for a
 few register writes
Message-ID: <20191021165936.coy75eovrsqzyw76@fralle-msi>
References: <1571668911-8312-1-git-send-email-sai.pavan.boddu@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1571668911-8312-1-git-send-email-sai.pavan.boddu@xilinx.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::243
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
Cc: edgar.iglesias@xilinx.com, Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On [2019 Oct 21] Mon 20:11:51, Sai Pavan Boddu wrote:
Hi Sai,

> A few of the register writes need not update the spi bus state, so just

s/of the/configuration/

> return after reg write. Added few more dummy register offsets which need

s/reg/register/

> the same behaviour.

I apologize but I forgot to mention that below are not dummy registers
(they are configuration registers). Would it be ok for you to remove the
last (second) sentence above? 

The patch looks ok to me after that! (Also tested it!)

Best regards,
Francisco Iglesias

> 
> Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
> ---
> Changes for V2:
> 	Just skip update of spips cs and fifos
> 	Update commit message accordingly
> Changes for V3:
> 	Avoid checking for zynqmp qspi
> 	Skip spi bus update for few of the registers
> Changes for V4:
> 	Move the register list to existing switch case above.
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

