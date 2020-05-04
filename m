Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28F41C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 15:41:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E45A9206D7
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 15:41:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h6ZwUffm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E45A9206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48488 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVdDw-0007wO-1d
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 11:41:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60482)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frasse.iglesias@gmail.com>)
 id 1jVd3R-0005lL-JB; Mon, 04 May 2020 11:30:49 -0400
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141]:40562)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frasse.iglesias@gmail.com>)
 id 1jVd3Q-0004sp-Bp; Mon, 04 May 2020 11:30:49 -0400
Received: by mail-lf1-x141.google.com with SMTP id b24so10131764lfp.7;
 Mon, 04 May 2020 08:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=v/tLV43XAkbPw06s/JzWD0xbSwDNJIVWjPBzJvNcTbs=;
 b=h6ZwUffm8NxuJQws8BxHmb1TazA+v8a403gbvb3VnkMVZLzYbSyk4SCfCNe4hBVn2y
 8zh/sf1cy4o3oP2Y7PB5xAdeQB+RbHbluPsCcpS4xBEqJ+FnWL4ml7jWmEANw75Gd1ji
 ijM7aVt9r42PULVY8zoHdADHfv3/fR5L1I612ZIkXPRQ5zHxDKnr7Vvggd8BqWp+Cixn
 Y+TQ0bJ0ufzshDg5x2CCgmJyKkEjG971Iql/TIv6qn91Gyn0U8tBIp880Li9Vu2hbdlY
 3+sDSWnxqgB+lNij6OAknI44kF2VncZvB3+8aM3yC7Xj6pTpKXm4r1PXYzanEr26ZJBh
 JRAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=v/tLV43XAkbPw06s/JzWD0xbSwDNJIVWjPBzJvNcTbs=;
 b=XjWIxMQ87wARE5W+HBfQFUkM8a0fmqVR86D80oJPSpAbyTGi+qy6RaFmef11mpBVqO
 HxWrgFkUANID39i4AWZfBm7r7r43tulRq1fKLoo5DuiDRZ+oYlEE6QLAa5bwhYupi1lu
 A8X2udu0yZSw2fgkwDaS6yiYQB5pEOBrMQFmQH+Yr4Zqe/ArDIsBl6FeB5hJsyWjQIZ/
 qcp2fy9kKCmU0n5OwyKvRjsRb6I1u9I9BMj7yIRj0mv1NLcTmtRQsmw/ln4HKD7TZ8/u
 h2xQo0x0WQt8RkyvTjGeXbJjCb03bNQr4p2zuaWvogDSwEoj+ZHrPOuB4g2q8Ac7KQ+A
 5mrQ==
X-Gm-Message-State: AGi0Pua/WQ1Ei0dHMosqggbG8EZ/l+sjs+ps+3IJrosOzhmSH9IxRHGH
 coubMv28OqHi77gTrJ6o9PM=
X-Google-Smtp-Source: APiQypKzdKD2C3gzHjEh3yos+28ZYnhyeHbBN1f8W0AH2nT6EhQLnEqs5u3+JCUYohf9Zw+ur+TfPw==
X-Received: by 2002:ac2:5ccf:: with SMTP id f15mr11939579lfq.216.1588606246020; 
 Mon, 04 May 2020 08:30:46 -0700 (PDT)
Received: from fralle-msi (31-208-27-151.cust.bredband2.com. [31.208.27.151])
 by smtp.gmail.com with ESMTPSA id
 4sm8427778ljf.79.2020.05.04.08.30.44
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 04 May 2020 08:30:45 -0700 (PDT)
Date: Mon, 4 May 2020 17:30:43 +0200
From: Francisco Iglesias <frasse.iglesias@gmail.com>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Subject: Re: [PATCH v1 4/9] hw/dma/xilinx_axidma: Add DMA memory-region
 property
Message-ID: <20200504153042.unp2o6lkybmku2oe@fralle-msi>
References: <20200430162439.2659-1-edgar.iglesias@gmail.com>
 <20200430162439.2659-5-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200430162439.2659-5-edgar.iglesias@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Received-SPF: pass client-ip=2a00:1450:4864:20::141;
 envelope-from=frasse.iglesias@gmail.com; helo=mail-lf1-x141.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -1020
X-Spam_score: -102.1
X-Spam_bar: ---------------------------------------------------
X-Spam_report: (-102.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001,
 USER_IN_WHITELIST=-100 autolearn=_AUTOLEARN
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
Cc: damien.hedde@greensocs.com, peter.maydell@linaro.org,
 sstabellini@kernel.org, edgar.iglesias@xilinx.com, sai.pavan.boddu@xilinx.com,
 jasowang@redhat.com, alistair@alistair23.me, qemu-devel@nongnu.org,
 frederic.konrad@adacore.com, qemu-arm@nongnu.org, philmd@redhat.com,
 luc.michel@greensocs.com, figlesia@xilinx.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On [2020 Apr 30] Thu 18:24:34, Edgar E. Iglesias wrote:
> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
> 
> Add DMA memory-region property to externally control what
> address-space this DMA operates on.
> 
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>

Reviewed-by: Francisco Iglesias <frasse.iglesias@gmail.com>

> ---
>  hw/dma/xilinx_axidma.c | 30 +++++++++++++++++++++++-------
>  1 file changed, 23 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/dma/xilinx_axidma.c b/hw/dma/xilinx_axidma.c
> index 018f36991b..4540051448 100644
> --- a/hw/dma/xilinx_axidma.c
> +++ b/hw/dma/xilinx_axidma.c
> @@ -33,6 +33,7 @@
>  #include "qemu/log.h"
>  #include "qemu/module.h"
>  
> +#include "sysemu/dma.h"
>  #include "hw/stream.h"
>  
>  #define D(x)
> @@ -103,6 +104,7 @@ enum {
>  };
>  
>  struct Stream {
> +    struct XilinxAXIDMA *dma;
>      ptimer_state *ptimer;
>      qemu_irq irq;
>  
> @@ -125,6 +127,9 @@ struct XilinxAXIDMAStreamSlave {
>  struct XilinxAXIDMA {
>      SysBusDevice busdev;
>      MemoryRegion iomem;
> +    MemoryRegion *dma_mr;
> +    AddressSpace as;
> +
>      uint32_t freqhz;
>      StreamSlave *tx_data_dev;
>      StreamSlave *tx_control_dev;
> @@ -186,7 +191,7 @@ static void stream_desc_load(struct Stream *s, hwaddr addr)
>  {
>      struct SDesc *d = &s->desc;
>  
> -    cpu_physical_memory_read(addr, d, sizeof *d);
> +    address_space_read(&s->dma->as, addr, MEMTXATTRS_UNSPECIFIED, d, sizeof *d);
>  
>      /* Convert from LE into host endianness.  */
>      d->buffer_address = le64_to_cpu(d->buffer_address);
> @@ -204,7 +209,8 @@ static void stream_desc_store(struct Stream *s, hwaddr addr)
>      d->nxtdesc = cpu_to_le64(d->nxtdesc);
>      d->control = cpu_to_le32(d->control);
>      d->status = cpu_to_le32(d->status);
> -    cpu_physical_memory_write(addr, d, sizeof *d);
> +    address_space_write(&s->dma->as, addr, MEMTXATTRS_UNSPECIFIED,
> +                        d, sizeof *d);
>  }
>  
>  static void stream_update_irq(struct Stream *s)
> @@ -286,8 +292,9 @@ static void stream_process_mem2s(struct Stream *s, StreamSlave *tx_data_dev,
>                       txlen + s->pos);
>          }
>  
> -        cpu_physical_memory_read(s->desc.buffer_address,
> -                                 s->txbuf + s->pos, txlen);
> +        address_space_read(&s->dma->as, s->desc.buffer_address,
> +                           MEMTXATTRS_UNSPECIFIED,
> +                           s->txbuf + s->pos, txlen);
>          s->pos += txlen;
>  
>          if (stream_desc_eof(&s->desc)) {
> @@ -336,7 +343,8 @@ static size_t stream_process_s2mem(struct Stream *s, unsigned char *buf,
>              rxlen = len;
>          }
>  
> -        cpu_physical_memory_write(s->desc.buffer_address, buf + pos, rxlen);
> +        address_space_write(&s->dma->as, s->desc.buffer_address,
> +                            MEMTXATTRS_UNSPECIFIED, buf + pos, rxlen);
>          len -= rxlen;
>          pos += rxlen;
>  
> @@ -525,6 +533,7 @@ static void xilinx_axidma_realize(DeviceState *dev, Error **errp)
>      XilinxAXIDMAStreamSlave *cs = XILINX_AXI_DMA_CONTROL_STREAM(
>                                                              &s->rx_control_dev);
>      Error *local_err = NULL;
> +    int i;
>  
>      object_property_add_link(OBJECT(ds), "dma", TYPE_XILINX_AXI_DMA,
>                               (Object **)&ds->dma,
> @@ -545,17 +554,19 @@ static void xilinx_axidma_realize(DeviceState *dev, Error **errp)
>          goto xilinx_axidma_realize_fail;
>      }
>  
> -    int i;
> -
>      for (i = 0; i < 2; i++) {
>          struct Stream *st = &s->streams[i];
>  
> +        st->dma = s;
>          st->nr = i;
>          st->ptimer = ptimer_init(timer_hit, st, PTIMER_POLICY_DEFAULT);
>          ptimer_transaction_begin(st->ptimer);
>          ptimer_set_freq(st->ptimer, s->freqhz);
>          ptimer_transaction_commit(st->ptimer);
>      }
> +
> +    address_space_init(&s->as,
> +                       s->dma_mr ? s->dma_mr : get_system_memory(), "dma");
>      return;
>  
>  xilinx_axidma_realize_fail:
> @@ -575,6 +586,11 @@ static void xilinx_axidma_init(Object *obj)
>                              &s->rx_control_dev, sizeof(s->rx_control_dev),
>                              TYPE_XILINX_AXI_DMA_CONTROL_STREAM, &error_abort,
>                              NULL);
> +    object_property_add_link(obj, "dma", TYPE_MEMORY_REGION,
> +                             (Object **)&s->dma_mr,
> +                             qdev_prop_allow_set_link_before_realize,
> +                             OBJ_PROP_LINK_STRONG,
> +                             &error_abort);
>  
>      sysbus_init_irq(sbd, &s->streams[0].irq);
>      sysbus_init_irq(sbd, &s->streams[1].irq);
> -- 
> 2.20.1
> 

