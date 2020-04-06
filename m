Return-Path: <SRS0=By5p=5W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21B83C2BA19
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 09:57:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFCC7206F5
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 09:57:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N+B8rn2k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFCC7206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57628 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLOVZ-0004Ft-5V
	for qemu-devel@archiver.kernel.org; Mon, 06 Apr 2020 05:57:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46957)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <frasse.iglesias@gmail.com>) id 1jLORL-0006AD-Ry
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 05:53:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <frasse.iglesias@gmail.com>) id 1jLORK-0003kO-Kd
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 05:53:11 -0400
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241]:38176)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <frasse.iglesias@gmail.com>)
 id 1jLORK-0003j2-BC; Mon, 06 Apr 2020 05:53:10 -0400
Received: by mail-lj1-x241.google.com with SMTP id v16so13974956ljg.5;
 Mon, 06 Apr 2020 02:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=zZu81AvTz7XnpfPxkUx7W0nVmjRXqKzPOgYt9ht6Xbg=;
 b=N+B8rn2khK41TbDt3qFaha7FQvtALO0YNnbJS6fRlmK8jipn4fhO6Bl30ZbyxlyWeR
 517UL+gEZAHMhVE/iNSerYY11iJEDxP5LSmzWo2KxYyZk+qJzAMfIcBQ830N0UqChatX
 9WSj0IoGDq1YfodSaOxDR6qdtpJQUbqhLm1w28HHhDM9oZnp8v/xc20cZ4o7Rb7Zo1f5
 i8tiib+8U1m7y8Iw6XKD6J2etCIhnBqJx0ZOZ8/ShHvT88gppeO5oVBjeFN3QH4ODt5j
 LxrklU+EWzPMwifuLNKmeXf2YMgDNSKYlGeOnvNIjy77C0VHU7+rWmHboSta/kLGkTfZ
 ToNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=zZu81AvTz7XnpfPxkUx7W0nVmjRXqKzPOgYt9ht6Xbg=;
 b=rmsXbV7D59Yh5uE46yKusKlREQs7ABY6MrBXpBYSQIcGFKmWbOYiK3kdVztyvgYxW+
 bn30hEcqHOrjtRZjkl/hAmyfln5f6OQuve+WKmpSrQUoP/4GRoLo3DnKShbupFSEJH8b
 w1299ITRmBFpTQ1pP8yj9wjGmXUqPiTIqCuoGSPj1eKP3XNWZQ27KpgQtTJMR5OXeZr1
 NUaV71zOcCbxKioGKR78QiIoytL/86bgZZZBq7yUWv4APNC1cK1T6JfKBl4HUdfAbyxA
 mwL1AIyC/GGpc3hlvp98tDoBogiPoxdQZMIiJqT/GPXxKSOQuTMwa2Yw9cC6OUvEdzwm
 HFjw==
X-Gm-Message-State: AGi0PuZdmrksReGcVnO6v56nrYem2g+zTscczBmZeJCY4IE7YBrSpmo0
 VLsh8dsTkjdJwQnEC6mg6t4=
X-Google-Smtp-Source: APiQypKcgtIshjJvSBFpX7tF8KydMkJZdec/rZ9lLTyX/Eu+B3+TJ46OiWN87CiqUrEYk8yjlwIW0w==
X-Received: by 2002:a2e:9d85:: with SMTP id c5mr11466060ljj.168.1586166788978; 
 Mon, 06 Apr 2020 02:53:08 -0700 (PDT)
Received: from fralle-msi (31-208-27-151.cust.bredband2.com. [31.208.27.151])
 by smtp.gmail.com with ESMTPSA id
 e12sm12070373ljl.36.2020.04.06.02.53.07
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 06 Apr 2020 02:53:08 -0700 (PDT)
Date: Mon, 6 Apr 2020 11:53:06 +0200
From: Francisco Iglesias <frasse.iglesias@gmail.com>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Subject: Re: [PATCH v1 2/2] dma/xlnx-zdma: Fix descriptor loading (REG) wrt
 endianness
Message-ID: <20200406095305.n542oyamddwh4uj7@fralle-msi>
References: <20200404122718.25111-1-edgar.iglesias@gmail.com>
 <20200404122718.25111-3-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200404122718.25111-3-edgar.iglesias@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::241
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
Cc: figlesia@xilinx.com, peter.maydell@linaro.org, sstabellini@kernel.org,
 edgar.iglesias@xilinx.com, sai.pavan.boddu@xilinx.com, alistair@alistair23.me,
 richard.henderson@linaro.org, qemu-devel@nongnu.org,
 frederic.konrad@adacore.com, qemu-arm@nongnu.org, philmd@redhat.com,
 luc.michel@greensocs.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On [2020 Apr 04] Sat 14:27:18, Edgar E. Iglesias wrote:
> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
> 
> Fix descriptor loading from registers wrt host endianness.
> 
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>

Reviewed-by: Francisco Iglesias <frasse.iglesias@gmail.com>

> ---
>  hw/dma/xlnx-zdma.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/dma/xlnx-zdma.c b/hw/dma/xlnx-zdma.c
> index 5f4775f663..4121a1b489 100644
> --- a/hw/dma/xlnx-zdma.c
> +++ b/hw/dma/xlnx-zdma.c
> @@ -299,6 +299,14 @@ static void zdma_put_regaddr64(XlnxZDMA *s, unsigned int basereg, uint64_t addr)
>      s->regs[basereg + 1] = addr >> 32;
>  }
>  
> +static void zdma_load_descriptor_reg(XlnxZDMA *s, unsigned int reg,
> +                                     XlnxZDMADescr *descr)
> +{
> +    descr->addr = zdma_get_regaddr64(s, reg);
> +    descr->size = s->regs[reg + 2];
> +    descr->attr = s->regs[reg + 3];
> +}
> +
>  static bool zdma_load_descriptor(XlnxZDMA *s, uint64_t addr,
>                                   XlnxZDMADescr *descr)
>  {
> @@ -324,8 +332,7 @@ static void zdma_load_src_descriptor(XlnxZDMA *s)
>      unsigned int ptype = ARRAY_FIELD_EX32(s->regs, ZDMA_CH_CTRL0, POINT_TYPE);
>  
>      if (ptype == PT_REG) {
> -        memcpy(&s->dsc_src, &s->regs[R_ZDMA_CH_SRC_DSCR_WORD0],
> -               sizeof(s->dsc_src));
> +        zdma_load_descriptor_reg(s, R_ZDMA_CH_SRC_DSCR_WORD0, &s->dsc_src);
>          return;
>      }
>  
> @@ -360,8 +367,7 @@ static void zdma_load_dst_descriptor(XlnxZDMA *s)
>      bool dst_type;
>  
>      if (ptype == PT_REG) {
> -        memcpy(&s->dsc_dst, &s->regs[R_ZDMA_CH_DST_DSCR_WORD0],
> -               sizeof(s->dsc_dst));
> +        zdma_load_descriptor_reg(s, R_ZDMA_CH_DST_DSCR_WORD0, &s->dsc_dst);
>          return;
>      }
>  
> -- 
> 2.20.1
> 

