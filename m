Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3416CA9EA1
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 12:48:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6EC5222BD
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 12:48:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QPGGbPrJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6EC5222BD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39500 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLRg2-0003MB-D7
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 08:48:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43823)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <frasse.iglesias@gmail.com>) id 1iLRex-0002ql-S0
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 08:47:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <frasse.iglesias@gmail.com>) id 1iLRew-00080J-DO
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 08:47:11 -0400
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:37380)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <frasse.iglesias@gmail.com>)
 id 1iLRew-000803-5p
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 08:47:10 -0400
Received: by mail-lj1-x242.google.com with SMTP id l21so6104559lje.4
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2019 05:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=77uvUpvlPstBDGc7dh63/pCPdxV07cEuIztOHB45Z7Y=;
 b=QPGGbPrJVvVhNsvFLI77YI+EgOR4M6OrMIuDkv1+V8Kf+R62x8o1CD8coNBNmNI5ut
 ApDqRCNErEMe4ovIm4u39XZMRGqfj03ZFVK/HF7vEqtRlYoVAEUeSt/RTRmsjwuIS43u
 RCFIWGmtNgOWvvXfTuQEK+6nVXDHnL4r/C3teLnwlh6zEPFUvfahx8dNMZ2B4uqRm97d
 ZkHgypiKViDDkqunJ/9eSvnrPJbUQbDCIZ3bbyY2jpnvLPAWh1QMJEkSIH7mVQzoQS3W
 b/+fzKYnYw7YjWNzGOQvajTqRGtvwA1tf5dbXrTMTkFDYC5qMm+OS57eUVLL1vJ7KN4Y
 N9nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=77uvUpvlPstBDGc7dh63/pCPdxV07cEuIztOHB45Z7Y=;
 b=BaTozgOkEm6p6eGqFf04c6E9a8sQ6JhI/5Erh7gBp0VBYxm257xEFKrazTVuB8pJnW
 S16d3Kjug73cHNNVc6ECRzK9dtrQAx4mkquTvDrfBCHZTipjPE2MEHlQBu1KQTyEehEB
 8NyKS2T00UZr+Lr9L1KIuWxM3JK59iCu4BCNx/fMdzVto9jFydJsNqrRDdxnyBeJ+nLZ
 gi7qQztAJ4rYkfcYl2DjDWc2AmnzC6w7Fx9II98IkWMZBjM7pTTQ08Bi+bMo/DUT7ZN2
 J4mG2saWCYslOhgfH1gWpfgDwGE5SOui+BPWhFLst+m30rkgh2l1KKSIiWqUtQJB5BIb
 2Xjw==
X-Gm-Message-State: APjAAAUvZCLGZCMFZ64QyOW+qYKauGg7C12inXkG68sem+E0ibyXsWec
 m8Tstd1tQuMairXG4IFHjLo=
X-Google-Smtp-Source: APXvYqzG0bjbmoxBpWwgFVvQmx/SMWb/Fd43dLh3yv4Ur+xRRreEWjxDvDsdommRgdniry5hBuE2Mw==
X-Received: by 2002:a2e:7003:: with SMTP id l3mr6149876ljc.158.1571402828433; 
 Fri, 18 Oct 2019 05:47:08 -0700 (PDT)
Received: from fralle-msi (31-208-27-151.cust.bredband2.com. [31.208.27.151])
 by smtp.gmail.com with ESMTPSA id
 d26sm2204586ljc.64.2019.10.18.05.47.07
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 18 Oct 2019 05:47:07 -0700 (PDT)
Date: Fri, 18 Oct 2019 14:47:06 +0200
From: Francisco Iglesias <frasse.iglesias@gmail.com>
To: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
Subject: Re: [PATCH v3] ssi: xilinx_spips: Skip spi bus update for few
 register writes
Message-ID: <20191018124704.2boixwkftrea42ib@fralle-msi>
References: <1571389744-11740-1-git-send-email-sai.pavan.boddu@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1571389744-11740-1-git-send-email-sai.pavan.boddu@xilinx.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::242
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

Hi Sai,

On [2019 Oct 18] Fri 14:39:04, Sai Pavan Boddu wrote:
> Few of the register writes need not update the spi bus state, so just
> return after reg write. Added few more dummy register offsets which need
> the same behaviour.
> 
> Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
> ---
> Changes for V2:
> 	Just skip update of spips cs and fifos
> 	Update commit message accordingly
> Changes for V3:
> 	Avoid checking for zynqmp qspi
> 	Skip spi bus update for few of the registers
> 
>  hw/ssi/xilinx_spips.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/hw/ssi/xilinx_spips.c b/hw/ssi/xilinx_spips.c
> index a309c71..c23de47 100644
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
> @@ -1022,6 +1025,15 @@ static void xilinx_spips_write(void *opaque, hwaddr addr,
>      }
>      s->regs[addr] = (s->regs[addr] & ~mask) | (value & mask);
>  no_reg_update:
> +    /* Skip SPI bus update for below registers writes */
> +    switch (addr) {
> +    case R_GPIO:
> +    case R_LPBK_DLY_ADJ:
> +    case R_IOU_TAPDLY_BYPASS:
> +    case R_DUMMY_CYCLE_EN:
> +    case R_ECO:

Would it be ok for you to move above cases into the switch case above in
this same function instead? (And add a reg write before returning) This
way all registers are handled at the same place (switch case).

Best regards,
Francisco Iglesias

> +        return;
> +    }
>      xilinx_spips_update_cs_lines(s);
>      xilinx_spips_check_flush(s);
>      xilinx_spips_update_cs_lines(s);
> -- 
> 2.7.4
> 

