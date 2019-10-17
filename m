Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45E9EECE58E
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 14:18:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07B6F2089C
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 14:18:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mHw2TDzP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07B6F2089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49086 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL6cD-0006dR-Jd
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 10:18:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37454)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <frasse.iglesias@gmail.com>) id 1iL5vz-0005qb-V0
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:35:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <frasse.iglesias@gmail.com>) id 1iL5vy-0004Oh-VC
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:35:19 -0400
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141]:34524)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <frasse.iglesias@gmail.com>)
 id 1iL5vy-0004OI-M3
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:35:18 -0400
Received: by mail-lf1-x141.google.com with SMTP id r22so1929730lfm.1
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 06:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=IzhQdkcQs9Zcql1/wearVJz6DaXb8ZwMx/iDls1V7Bw=;
 b=mHw2TDzP+e1DFSKiDffLDlSOR+HJCTvfpCTLkdIaQZPdSWrJppV5oOYKiaMYYqiaV8
 0S3WWOodXqG0jTYnw4LnGIhZ9nG+7q2ZYT2jA7AjxVbKB6twS8gkJDdLiwtcnPNjbquu
 KYJF1yL7jnGcjY37F+VTmnS4w1IKSRCEhoQSu8LyaJfF37rRKtoFVyQ0ApMK8bNSOH1U
 vLQ8RGp2gmJV4NoI5bf08X5Tgz7jTcYRaHm6Jfgb7dQfaVKowwjMYKisf/x4zvD9F6rz
 d9+Pe+iyuKfj+Rbv92r76V83NqrUQn1qBFHOK/apDlv7C6jaED25r+SqPsOlRslCXNvb
 ReaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=IzhQdkcQs9Zcql1/wearVJz6DaXb8ZwMx/iDls1V7Bw=;
 b=cXZyPviD2acDzQc8++rPRUMkMB7aZRoFWVkkQY2ZJDzO89KycxqTszf6kJxldfu3hR
 o3zz41V5wdHlt9IMJSfdrgPEqUsp37g/fI5mR9/rlU2IkU6SzU2HPqUoskTpQFaxpxPu
 waMlZ/66FUFxeFfX6U6VIp3Lm6LmjiO7L5dnL/ft0OK/aTT8e+nyax6+b8N8K8dVPTsb
 wg0bk0Tlj5J/J0h/1qm2/vVcIs9GaxioYBfpQA1HpSQIOyH/elmcZvsdk+dwA/9nXWH5
 QwgR9tqqg5W2CReKuO9v5hGj1bRlxMKO7vop9AfApEx5tTssTK8VkF81qVIl5/b0fc02
 NsoA==
X-Gm-Message-State: APjAAAXQIcN/hDZoPtS/9WKwCSCAe8G9JanInHEorhowff3lHBgceU0L
 6qax8e9NhIRcIYOZFyaORRg=
X-Google-Smtp-Source: APXvYqx4yCY2wdCqge4LIdEsSTazNUBEp7eKZ5ZWRMMl7QjtnZza/qG5DhVbK7ksH03fbNJJBfh8Fw==
X-Received: by 2002:ac2:53b9:: with SMTP id j25mr2401828lfh.151.1571319316996; 
 Thu, 17 Oct 2019 06:35:16 -0700 (PDT)
Received: from fralle-msi (31-208-27-151.cust.bredband2.com. [31.208.27.151])
 by smtp.gmail.com with ESMTPSA id
 a8sm1207945ljf.47.2019.10.17.06.35.16
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 17 Oct 2019 06:35:16 -0700 (PDT)
Date: Thu, 17 Oct 2019 15:35:14 +0200
From: Francisco Iglesias <frasse.iglesias@gmail.com>
To: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
Subject: Re: [QEMU][PATCH v2] ssi: xilinx_spips: Skip update of cs and fifo
 releated to spips in gqspi
Message-ID: <20191017133513.ul436a65y5m2vvrm@fralle-msi>
References: <1571307474-16222-1-git-send-email-sai.pavan.boddu@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1571307474-16222-1-git-send-email-sai.pavan.boddu@xilinx.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::141
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

On [2019 Oct 17] Thu 15:47:54, Sai Pavan Boddu wrote:
> GQSPI handles chip selects and fifos in a different way compared to
> spips. So skip update of cs and fifos related to spips in gqspi mode.
> 
> Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>
> ---
> Changes for V2:
>     Just skip update of spips cs and fifos
>     Update commit message accordingly
> 
>  hw/ssi/xilinx_spips.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/hw/ssi/xilinx_spips.c b/hw/ssi/xilinx_spips.c
> index a309c71..27154b0 100644
> --- a/hw/ssi/xilinx_spips.c
> +++ b/hw/ssi/xilinx_spips.c
> @@ -1022,6 +1022,13 @@ static void xilinx_spips_write(void *opaque, hwaddr addr,
>      }
>      s->regs[addr] = (s->regs[addr] & ~mask) | (value & mask);
>  no_reg_update:
> +    /* In GQSPI mode skip update of CS and fifo's related to spips */
> +    if (object_dynamic_cast(OBJECT(s), TYPE_XLNX_ZYNQMP_QSPIPS)) {
> +        XlnxZynqMPQSPIPS *ss = XLNX_ZYNQMP_QSPIPS(s);
> +        if (ARRAY_FIELD_EX32(ss->regs, GQSPI_SELECT, GENERIC_QSPI_EN)) {
> +            return;
> +        }
> +    }

Above corrects the issue for the zynqmp but not for the other two models
(below functions shouldn't be called when writing the mentioned config
regs for them either), would it be ok for you to expand to the switch
cases you had in v1 (into the switch in this function and return after
updating the reg values)? (the correction will then spawn all three
models)

Best regards,
Francisco Iglesias

>      xilinx_spips_update_cs_lines(s);
>      xilinx_spips_check_flush(s);
>      xilinx_spips_update_cs_lines(s);
> -- 
> 2.7.4
> 
> 

