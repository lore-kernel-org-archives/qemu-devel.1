Return-Path: <SRS0=9ZvH=C5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E75E1C43466
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Sep 2020 10:52:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63E8820874
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Sep 2020 10:52:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d3tIXbth"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63E8820874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45630 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJwxl-00024i-Bd
	for qemu-devel@archiver.kernel.org; Sun, 20 Sep 2020 06:52:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37850)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kJwtP-0000ch-1k; Sun, 20 Sep 2020 06:48:27 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:32934)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kJwtN-0002MR-Ab; Sun, 20 Sep 2020 06:48:26 -0400
Received: by mail-wr1-x444.google.com with SMTP id m6so9847987wrn.0;
 Sun, 20 Sep 2020 03:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=yys9LmrffjERv+PdDoRMUkO8YlKAJ2k9n6MhKLFCSNg=;
 b=d3tIXbthPlsWV80aUXTPZuCfvb2B+FdEZFSMnh3r1u7wr6/nzsUsotkHUfnl+A7m/W
 a/mY0D9MY2++RZZjTgtWuVPVDeLcRjQU7JtYctDdwEhwMg6Ini7Lx8p+OmRJDSyiBfIt
 Dy7+BjDlcD4vWDcl2W/xiNWpKU1jT1FZlSkS8atq/3N5wVGBV1qdF8czbD5JZ2FYKyEA
 aRa1DLB5eqlk8wtT1mu9mWk5qzCPZaf91sT3XCVvxkFDelv+NPz/9b2DQBALwDH/fKpw
 HjA87G336i0J8oQSkl8L9mzNpAWFRuov+0UON3gcBtwQ0BQJsN8KCfncdiQUtMVF9L7m
 cxtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=yys9LmrffjERv+PdDoRMUkO8YlKAJ2k9n6MhKLFCSNg=;
 b=tSTcRvlGvFD6wgPeTSdbGXN5iH3HfL2gNZG3bYxrkqtQwIhnPOgJvbXf1EQKcfi7Ys
 s3YFxJbVAeCf2vuSNmoWJWXJOq4yGJBZ8UeIzNUPxPJXLtQSxeFFv1KJ8aP1U/9qt/sN
 kbaZzTTSLdRE2PjmHbLHBQ/iQ0VZZHSIowcQO9vk815iZWZ3XLZONwPshxRtoDvAwZxV
 8B5hWnvZgl9eZpySAerx0hg0pABAb5aAr1774Xhb7o/zMeSQgNppxH537LN7pobfQSAT
 z1JoFb1Qc1D96N5d2BbcR1UkCWxfsXOKDCIXoR/Nrt+Or0ml3+P5fdMhDsjMgLaYGh9x
 L6iA==
X-Gm-Message-State: AOAM531UyZLnjX3AXWqFpHuGVQ2CJrP5Vl7zrsl7XpaqzYDVSxrh9tUL
 35Pb2Wx/o5MPdLIZaDRsNnOZt/RR0W0=
X-Google-Smtp-Source: ABdhPJwNRxLmvZ2uXAbGyzpL3HT63b0lLvTErAztpvEcMPYV1cYMt1oBb8KPPnlEuPejlRmFDEzscg==
X-Received: by 2002:a5d:40cd:: with SMTP id b13mr47233991wrq.297.1600598902676; 
 Sun, 20 Sep 2020 03:48:22 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id n2sm15543796wma.29.2020.09.20.03.48.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 20 Sep 2020 03:48:21 -0700 (PDT)
Subject: Re: [PATCH 6/6] sabre: don't call sysbus_mmio_map() in sabre_realize()
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, armbru@redhat.com,
 david@gibson.dropbear.id.au, atar4qemu@gmail.com, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
References: <20200920082018.16135-1-mark.cave-ayland@ilande.co.uk>
 <20200920082018.16135-7-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <530678af-dbc7-e6db-72ef-7931c3e9609a@amsat.org>
Date: Sun, 20 Sep 2020 12:48:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200920082018.16135-7-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.248, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/20/20 10:20 AM, Mark Cave-Ayland wrote:
> The device should not map itself but instead should be mapped to sysbus by the
> sun4u machine.

Yeah good cleanup.

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  hw/pci-host/sabre.c | 8 --------
>  hw/sparc64/sun4u.c  | 7 +++++++
>  2 files changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/pci-host/sabre.c b/hw/pci-host/sabre.c
> index 5ac6283623..5394ad5cd0 100644
> --- a/hw/pci-host/sabre.c
> +++ b/hw/pci-host/sabre.c
> @@ -378,16 +378,8 @@ static void sabre_realize(DeviceState *dev, Error **errp)
>  {
>      SabreState *s = SABRE(dev);
>      PCIHostState *phb = PCI_HOST_BRIDGE(dev);
> -    SysBusDevice *sbd = SYS_BUS_DEVICE(s);
>      PCIDevice *pci_dev;
>  
> -    /* sabre_config */
> -    sysbus_mmio_map(sbd, 0, s->special_base);
> -    /* PCI configuration space */
> -    sysbus_mmio_map(sbd, 1, s->special_base + 0x1000000ULL);
> -    /* pci_ioport */
> -    sysbus_mmio_map(sbd, 2, s->special_base + 0x2000000ULL);
> -
>      memory_region_init(&s->pci_mmio, OBJECT(s), "pci-mmio", 0x100000000ULL);
>      memory_region_add_subregion(get_system_memory(), s->mem_base,
>                                  &s->pci_mmio);
> diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
> index b4aabfc076..f80ddde5dc 100644
> --- a/hw/sparc64/sun4u.c
> +++ b/hw/sparc64/sun4u.c
> @@ -592,6 +592,13 @@ static void sun4uv_init(MemoryRegion *address_space_mem,
>                               &error_abort);
>      sysbus_realize_and_unref(SYS_BUS_DEVICE(sabre), &error_fatal);
>  
> +    /* sabre_config */
> +    sysbus_mmio_map(SYS_BUS_DEVICE(sabre), 0, PBM_SPECIAL_BASE);
> +    /* PCI configuration space */
> +    sysbus_mmio_map(SYS_BUS_DEVICE(sabre), 1, PBM_SPECIAL_BASE + 0x1000000ULL);
> +    /* pci_ioport */
> +    sysbus_mmio_map(SYS_BUS_DEVICE(sabre), 2, PBM_SPECIAL_BASE + 0x2000000ULL);
> +
>      /* Wire up PCI interrupts to CPU */
>      for (i = 0; i < IVEC_MAX; i++) {
>          qdev_connect_gpio_out_named(DEVICE(sabre), "ivec-irq", i,
> 


