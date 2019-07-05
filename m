Return-Path: <SRS0=wUMn=VC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87FCFC46499
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 16:01:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48ADF21670
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 16:01:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EuoBLSQB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48ADF21670
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54384 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjQee-0008Pe-Cm
	for qemu-devel@archiver.kernel.org; Fri, 05 Jul 2019 12:01:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38085)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <frasse.iglesias@gmail.com>) id 1hjQWy-0002Hn-9m
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 11:53:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <frasse.iglesias@gmail.com>) id 1hjQWt-0001Fz-RQ
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 11:53:45 -0400
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141]:39017)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <frasse.iglesias@gmail.com>)
 id 1hjQWt-00018U-Gp; Fri, 05 Jul 2019 11:53:43 -0400
Received: by mail-lf1-x141.google.com with SMTP id v85so3685253lfa.6;
 Fri, 05 Jul 2019 08:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=DxV8NTKupXbAcWb3Te7hxHrXuZ/GwgZPELxBXkrpsZ0=;
 b=EuoBLSQBboSYN6JN5VTDQfikpbR8lbMX+3tOdum+BdMtEolS5zIucJd0stXs+KydZr
 OHz3Yym+HfUH2AJM8Blf3fTglhexMPXmxwd7ty3Xo8be38/Vt3izZry5YAaU7qWwsirv
 UHXwAySE8y4RnCWPKEQiaR0LWGnJJ+5L1vQooZ5mJoWU2CuuBLYJooBlh6PLN5vcLYAk
 RaRRm7eJciuEJnxmo3uqEQbwDJwjF/CneryMQv1d0fTvh6C6kPPM0twvyuSwFmiFFXbr
 vy43CMSEudtRBV0uYML4OYKsJ/cRgKnx44YZuBbjKAizHxYpxtbWg48HuuU+9TcsTlpN
 on9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=DxV8NTKupXbAcWb3Te7hxHrXuZ/GwgZPELxBXkrpsZ0=;
 b=uFITR/4in/3wMtZbKpl0EXXfHx1/+ajvx9gJ8SjLqfykkO56m2DBRmen6t5SwGyaGC
 feRoxk/dwdn18DbCVdWaPlEOykwko1aMvJxTAZn0gQn+jDO0aY5avSxlQXpu90Ng83b8
 e6sKzGcT2u9UjAz4khzNHQrIoeN82z4yiSOSgkRBduE0OuQk2U2MVFvHonrHGOAXD4WQ
 mqf970DP9rnEONSY74Gx96bDvSzDx7s4ECQI9ESXil6nN60pwj0FfFsYYyYB3oUoX+nX
 ARICG3RIBujkNPRRZIm4pnQzh70JgelVHfVXc5P9K1C/9ElOMXw/ymCsBPnLtbvUl6cb
 380A==
X-Gm-Message-State: APjAAAX4hh9ZVnZNsZT5UAcGBIfao5GGutZxu4Xkr1wnF5jf2Rz2Vvp7
 1EB4JppU9qrWSKDzhvtceP0=
X-Google-Smtp-Source: APXvYqzxP4iIUDPXJkM8rsW1kDrQOcu6aXd1x8AJNHbEuk9mwgjhxt36SG0fAo4zK4DABWbwwZ2SZw==
X-Received: by 2002:ac2:4565:: with SMTP id k5mr2373865lfm.170.1562342021475; 
 Fri, 05 Jul 2019 08:53:41 -0700 (PDT)
Received: from fralle-msi (31-208-27-151.cust.bredband2.com. [31.208.27.151])
 by smtp.gmail.com with ESMTPSA id
 p13sm1842592ljc.39.2019.07.05.08.53.40
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 05 Jul 2019 08:53:40 -0700 (PDT)
Date: Fri, 5 Jul 2019 17:53:39 +0200
From: Francisco Iglesias <frasse.iglesias@gmail.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Message-ID: <20190705155338.duhw5hw4tnaixyp4@fralle-msi>
References: <20190705150850.4967-1-philmd@redhat.com>
 <20190705150850.4967-2-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190705150850.4967-2-philmd@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::141
Subject: Re: [Qemu-devel] [PATCH v3 1/2] hw/ssi/xilinx_spips: Convert
 lqspi_read() to read_with_attrs
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
 Alistair Francis <alistair@alistair23.me>, qemu-devel@nongnu.org,
 Prasad J Pandit <ppandit@redhat.com>, Lei Sun <slei.casper@gmail.com>,
 qemu-arm@nongnu.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Philippe,

On [2019 Jul 05] Fri 17:08:49, Philippe Mathieu-Daudé wrote:
> In the next commit we will implement the write_with_attrs()
> handler. To avoid using different APIs, convert the read()
> handler first.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  hw/ssi/xilinx_spips.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/hw/ssi/xilinx_spips.c b/hw/ssi/xilinx_spips.c
> index 8115bb6d46..e80619aece 100644
> --- a/hw/ssi/xilinx_spips.c
> +++ b/hw/ssi/xilinx_spips.c
> @@ -1202,27 +1202,27 @@ static void lqspi_load_cache(void *opaque, hwaddr addr)
>      }
>  }
>  
> -static uint64_t
> -lqspi_read(void *opaque, hwaddr addr, unsigned int size)
> +static MemTxResult lqspi_read(void *opaque, hwaddr addr, uint64_t *value,
> +                              unsigned size, MemTxAttrs attrs)
>  {
> -    XilinxQSPIPS *q = opaque;
> -    uint32_t ret;
> +    XilinxQSPIPS *q = XILINX_QSPIPS(opaque);
>  
>      if (addr >= q->lqspi_cached_addr &&
>              addr <= q->lqspi_cached_addr + LQSPI_CACHE_SIZE - 4) {
>          uint8_t *retp = &q->lqspi_buf[addr - q->lqspi_cached_addr];
> -        ret = cpu_to_le32(*(uint32_t *)retp);
> -        DB_PRINT_L(1, "addr: %08x, data: %08x\n", (unsigned)addr,
> -                   (unsigned)ret);
> -        return ret;
> +        *value = cpu_to_le32(*(uint32_t *)retp);
> +        DB_PRINT_L(1, "addr: %08" HWADDR_PRIx ", data: %08" PRIx64 "\n",
> +                   addr, *value);
>      } else {
>          lqspi_load_cache(opaque, addr);
> -        return lqspi_read(opaque, addr, size);
> +        lqspi_read(opaque, addr, value, size, attrs);

If you don't want to leave the return value floating you can always keep the
'return' (I'm unsure if coverity will complain about that).

Either way:

Reviewed-by: Francisco Iglesias <frasse.iglesias@gmail.com>


>      }
> +
> +    return MEMTX_OK;
>  }
>  
>  static const MemoryRegionOps lqspi_ops = {
> -    .read = lqspi_read,
> +    .read_with_attrs = lqspi_read,
>      .endianness = DEVICE_NATIVE_ENDIAN,
>      .valid = {
>          .min_access_size = 1,
> -- 
> 2.20.1
> 

