Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03FC8C43461
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 09:09:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 510462065E
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 09:09:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AyTEjfkY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 510462065E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40282 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGIaW-0001V1-9W
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 05:09:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36596)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kGIZd-0008SO-F6
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 05:08:57 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52185
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kGIZZ-0002RZ-02
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 05:08:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599728931;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mVa0T5osyyqVvof03O1uIvNYi/AqP9rH2A9BlQ3d+sw=;
 b=AyTEjfkYYUYdcpiIVsU9eGP2U5NNEBefa+467pegjErvSAlvMM+CABtkoKRhAR7pHLyjq1
 0Cc1TdhnEBtaUwcuGI12K5eRv7MEuHPz3cIkGrCXGqvOsHrHR4pt2lSUeJX54LnvktzZet
 KBZInXPVhCfiM+dDRa8Yr/YueFcsR7w=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-90-MBQMWSOJOoeLK-iTnF2VAA-1; Thu, 10 Sep 2020 05:08:44 -0400
X-MC-Unique: MBQMWSOJOoeLK-iTnF2VAA-1
Received: by mail-ed1-f69.google.com with SMTP id n4so2164570edo.20
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2020 02:08:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=mVa0T5osyyqVvof03O1uIvNYi/AqP9rH2A9BlQ3d+sw=;
 b=bBPU6qGi9XK/B7fMyjV/ZEXeffeaozY7pSSPuLyC5rXm2II5DmaqTOQxBVTXbkElr7
 O0XOlS9Dv+nSuj922ENtfrVpwG6y0VmmOJKV0MdJIGW1dBs6OKEERNd0anu5fXmXhWR4
 zKjkmaUd7gsq759s4LtY4ELOuDP5RJIu5ToH1TXDmN7KsRUGhShYIF1OjfUB6i2OMvGC
 CqHM631heqyX8NDLT1QP406N+sXjUvViWJ5u+a63AknkbZ3ac7At3n5fQFhQZR9aORaE
 qojmEcjkOmP3/vmghAuuUS27BMxqkE4rqSjSz+QWmpYCU3LIaJVClP94wMIpkyV/NG3N
 V80A==
X-Gm-Message-State: AOAM530XLHyn7NS5F5W/G6vEl2dThT3Hyx9NCTj8XX+pXM5/NiqBKxnk
 y5eq/EFHng5qFn8UzpNWK38E9bCo+lKzCNK+gOLWpWTyZFchu2Jl3f+n/gbnkfd6Y29hvTyjTih
 rjKhYxpYmX5uqXPo=
X-Received: by 2002:a50:e79c:: with SMTP id b28mr8408106edn.371.1599728922798; 
 Thu, 10 Sep 2020 02:08:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz9eOqrlCECRH6MG50KfAmNafiSMb7Yc+/HffHf28/7mAj1OyLe6oMQieOzo6YU+ROlMiNXbA==
X-Received: by 2002:a50:e79c:: with SMTP id b28mr8408080edn.371.1599728922550; 
 Thu, 10 Sep 2020 02:08:42 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:2744:1c91:fa55:fa01?
 ([2001:b07:6468:f312:2744:1c91:fa55:fa01])
 by smtp.gmail.com with ESMTPSA id m16sm6120969ejl.69.2020.09.10.02.08.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Sep 2020 02:08:42 -0700 (PDT)
Subject: Re: [PATCH 1/6] hw/ssi/aspeed_smc: Rename max_slaves as max_devices
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200910070131.435543-1-philmd@redhat.com>
 <20200910070131.435543-2-philmd@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <34760c71-c6da-4730-2b1a-5c5be0b7ff9f@redhat.com>
Date: Thu, 10 Sep 2020 11:08:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200910070131.435543-2-philmd@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.003
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/10 01:23:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -56
X-Spam_score: -5.7
X-Spam_bar: -----
X-Spam_report: (-5.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-3.576, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Andrew Jeffery <andrew@aj.id.au>,
 Jason Wang <jasowang@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Joel Stanley <joel@jms.id.au>, qemu-trivial@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/09/20 09:01, Philippe Mathieu-Daudé wrote:
> In order to use inclusive terminology, rename max_slaves
> as max_devices.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>

I think we should consider a wholesale replacement of SSISlave with
SSIPeripheral according to the proposal at
https://www.oshwa.org/a-resolution-to-redefine-spi-signal-names/.

Paolo

> ---
>  include/hw/ssi/aspeed_smc.h |  2 +-
>  hw/ssi/aspeed_smc.c         | 40 ++++++++++++++++++-------------------
>  2 files changed, 21 insertions(+), 21 deletions(-)
> 
> diff --git a/include/hw/ssi/aspeed_smc.h b/include/hw/ssi/aspeed_smc.h
> index 6fbbb238f15..52ae34e38d1 100644
> --- a/include/hw/ssi/aspeed_smc.h
> +++ b/include/hw/ssi/aspeed_smc.h
> @@ -42,7 +42,7 @@ typedef struct AspeedSMCController {
>      uint8_t r_timings;
>      uint8_t nregs_timings;
>      uint8_t conf_enable_w0;
> -    uint8_t max_slaves;
> +    uint8_t max_devices;
>      const AspeedSegments *segments;
>      hwaddr flash_window_base;
>      uint32_t flash_window_size;
> diff --git a/hw/ssi/aspeed_smc.c b/hw/ssi/aspeed_smc.c
> index 795784e5f36..8219272016c 100644
> --- a/hw/ssi/aspeed_smc.c
> +++ b/hw/ssi/aspeed_smc.c
> @@ -259,7 +259,7 @@ static const AspeedSMCController controllers[] = {
>          .r_timings         = R_TIMINGS,
>          .nregs_timings     = 1,
>          .conf_enable_w0    = CONF_ENABLE_W0,
> -        .max_slaves        = 1,
> +        .max_devices       = 1,
>          .segments          = aspeed_segments_legacy,
>          .flash_window_base = ASPEED_SOC_SMC_FLASH_BASE,
>          .flash_window_size = 0x6000000,
> @@ -275,7 +275,7 @@ static const AspeedSMCController controllers[] = {
>          .r_timings         = R_TIMINGS,
>          .nregs_timings     = 1,
>          .conf_enable_w0    = CONF_ENABLE_W0,
> -        .max_slaves        = 5,
> +        .max_devices       = 5,
>          .segments          = aspeed_segments_fmc,
>          .flash_window_base = ASPEED_SOC_FMC_FLASH_BASE,
>          .flash_window_size = 0x10000000,
> @@ -293,7 +293,7 @@ static const AspeedSMCController controllers[] = {
>          .r_timings         = R_SPI_TIMINGS,
>          .nregs_timings     = 1,
>          .conf_enable_w0    = SPI_CONF_ENABLE_W0,
> -        .max_slaves        = 1,
> +        .max_devices       = 1,
>          .segments          = aspeed_segments_spi,
>          .flash_window_base = ASPEED_SOC_SPI_FLASH_BASE,
>          .flash_window_size = 0x10000000,
> @@ -309,7 +309,7 @@ static const AspeedSMCController controllers[] = {
>          .r_timings         = R_TIMINGS,
>          .nregs_timings     = 1,
>          .conf_enable_w0    = CONF_ENABLE_W0,
> -        .max_slaves        = 3,
> +        .max_devices       = 3,
>          .segments          = aspeed_segments_ast2500_fmc,
>          .flash_window_base = ASPEED_SOC_FMC_FLASH_BASE,
>          .flash_window_size = 0x10000000,
> @@ -327,7 +327,7 @@ static const AspeedSMCController controllers[] = {
>          .r_timings         = R_TIMINGS,
>          .nregs_timings     = 1,
>          .conf_enable_w0    = CONF_ENABLE_W0,
> -        .max_slaves        = 2,
> +        .max_devices       = 2,
>          .segments          = aspeed_segments_ast2500_spi1,
>          .flash_window_base = ASPEED_SOC_SPI_FLASH_BASE,
>          .flash_window_size = 0x8000000,
> @@ -343,7 +343,7 @@ static const AspeedSMCController controllers[] = {
>          .r_timings         = R_TIMINGS,
>          .nregs_timings     = 1,
>          .conf_enable_w0    = CONF_ENABLE_W0,
> -        .max_slaves        = 2,
> +        .max_devices       = 2,
>          .segments          = aspeed_segments_ast2500_spi2,
>          .flash_window_base = ASPEED_SOC_SPI2_FLASH_BASE,
>          .flash_window_size = 0x8000000,
> @@ -359,7 +359,7 @@ static const AspeedSMCController controllers[] = {
>          .r_timings         = R_TIMINGS,
>          .nregs_timings     = 1,
>          .conf_enable_w0    = CONF_ENABLE_W0,
> -        .max_slaves        = 3,
> +        .max_devices       = 3,
>          .segments          = aspeed_segments_ast2600_fmc,
>          .flash_window_base = ASPEED26_SOC_FMC_FLASH_BASE,
>          .flash_window_size = 0x10000000,
> @@ -377,7 +377,7 @@ static const AspeedSMCController controllers[] = {
>          .r_timings         = R_TIMINGS,
>          .nregs_timings     = 2,
>          .conf_enable_w0    = CONF_ENABLE_W0,
> -        .max_slaves        = 2,
> +        .max_devices       = 2,
>          .segments          = aspeed_segments_ast2600_spi1,
>          .flash_window_base = ASPEED26_SOC_SPI_FLASH_BASE,
>          .flash_window_size = 0x10000000,
> @@ -395,7 +395,7 @@ static const AspeedSMCController controllers[] = {
>          .r_timings         = R_TIMINGS,
>          .nregs_timings     = 3,
>          .conf_enable_w0    = CONF_ENABLE_W0,
> -        .max_slaves        = 3,
> +        .max_devices       = 3,
>          .segments          = aspeed_segments_ast2600_spi2,
>          .flash_window_base = ASPEED26_SOC_SPI2_FLASH_BASE,
>          .flash_window_size = 0x10000000,
> @@ -476,7 +476,7 @@ static bool aspeed_smc_flash_overlap(const AspeedSMCState *s,
>      AspeedSegments seg;
>      int i;
>  
> -    for (i = 0; i < s->ctrl->max_slaves; i++) {
> +    for (i = 0; i < s->ctrl->max_devices; i++) {
>          if (i == cs) {
>              continue;
>          }
> @@ -537,7 +537,7 @@ static void aspeed_smc_flash_set_segment(AspeedSMCState *s, int cs,
>       */
>      if ((s->ctrl->segments == aspeed_segments_ast2500_spi1 ||
>           s->ctrl->segments == aspeed_segments_ast2500_spi2) &&
> -        cs == s->ctrl->max_slaves &&
> +        cs == s->ctrl->max_devices &&
>          seg.addr + seg.size != s->ctrl->segments[cs].addr +
>          s->ctrl->segments[cs].size) {
>          qemu_log_mask(LOG_GUEST_ERROR,
> @@ -948,7 +948,7 @@ static void aspeed_smc_reset(DeviceState *d)
>      }
>  
>      /* setup the default segment register values and regions for all */
> -    for (i = 0; i < s->ctrl->max_slaves; ++i) {
> +    for (i = 0; i < s->ctrl->max_devices; ++i) {
>          aspeed_smc_flash_set_segment_region(s, i,
>                      s->ctrl->segment_to_reg(s, &s->ctrl->segments[i]));
>      }
> @@ -995,8 +995,8 @@ static uint64_t aspeed_smc_read(void *opaque, hwaddr addr, unsigned int size)
>          (s->ctrl->has_dma && addr == R_DMA_DRAM_ADDR) ||
>          (s->ctrl->has_dma && addr == R_DMA_LEN) ||
>          (s->ctrl->has_dma && addr == R_DMA_CHECKSUM) ||
> -        (addr >= R_SEG_ADDR0 && addr < R_SEG_ADDR0 + s->ctrl->max_slaves) ||
> -        (addr >= s->r_ctrl0 && addr < s->r_ctrl0 + s->ctrl->max_slaves)) {
> +        (addr >= R_SEG_ADDR0 && addr < R_SEG_ADDR0 + s->ctrl->max_devices) ||
> +        (addr >= s->r_ctrl0 && addr < s->r_ctrl0 + s->ctrl->max_devices)) {
>  
>          trace_aspeed_smc_read(addr, size, s->regs[addr]);
>  
> @@ -1270,7 +1270,7 @@ static void aspeed_smc_write(void *opaque, hwaddr addr, uint64_t data,
>          int cs = addr - s->r_ctrl0;
>          aspeed_smc_flash_update_ctrl(&s->flashes[cs], value);
>      } else if (addr >= R_SEG_ADDR0 &&
> -               addr < R_SEG_ADDR0 + s->ctrl->max_slaves) {
> +               addr < R_SEG_ADDR0 + s->ctrl->max_devices) {
>          int cs = addr - R_SEG_ADDR0;
>  
>          if (value != s->regs[R_SEG_ADDR0 + cs]) {
> @@ -1341,10 +1341,10 @@ static void aspeed_smc_realize(DeviceState *dev, Error **errp)
>      s->conf_enable_w0 = s->ctrl->conf_enable_w0;
>  
>      /* Enforce some real HW limits */
> -    if (s->num_cs > s->ctrl->max_slaves) {
> +    if (s->num_cs > s->ctrl->max_devices) {
>          qemu_log_mask(LOG_GUEST_ERROR, "%s: num_cs cannot exceed: %d\n",
> -                      __func__, s->ctrl->max_slaves);
> -        s->num_cs = s->ctrl->max_slaves;
> +                      __func__, s->ctrl->max_devices);
> +        s->num_cs = s->ctrl->max_devices;
>      }
>  
>      /* DMA irq. Keep it first for the initialization in the SoC */
> @@ -1376,7 +1376,7 @@ static void aspeed_smc_realize(DeviceState *dev, Error **errp)
>                            s->ctrl->flash_window_size);
>      sysbus_init_mmio(sbd, &s->mmio_flash);
>  
> -    s->flashes = g_new0(AspeedSMCFlash, s->ctrl->max_slaves);
> +    s->flashes = g_new0(AspeedSMCFlash, s->ctrl->max_devices);
>  
>      /*
>       * Let's create a sub memory region for each possible slave. All
> @@ -1385,7 +1385,7 @@ static void aspeed_smc_realize(DeviceState *dev, Error **errp)
>       * module behind to handle the memory accesses. This depends on
>       * the board configuration.
>       */
> -    for (i = 0; i < s->ctrl->max_slaves; ++i) {
> +    for (i = 0; i < s->ctrl->max_devices; ++i) {
>          AspeedSMCFlash *fl = &s->flashes[i];
>  
>          snprintf(name, sizeof(name), "%s.%d", s->ctrl->name, i);
> 


