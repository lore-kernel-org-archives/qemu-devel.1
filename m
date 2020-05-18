Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA5A7C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 08:10:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E0E6207D4
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 08:10:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=adacore-com.20150623.gappssmtp.com header.i=@adacore-com.20150623.gappssmtp.com header.b="qSN1at90"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E0E6207D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=adacore.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42094 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jaarH-0008S8-HB
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 04:10:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43986)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <konrad@adacore.com>)
 id 1jaaqc-0007zq-Pv
 for qemu-devel@nongnu.org; Mon, 18 May 2020 04:10:06 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:44548)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <konrad@adacore.com>)
 id 1jaaqb-00086z-Jq
 for qemu-devel@nongnu.org; Mon, 18 May 2020 04:10:06 -0400
Received: by mail-wr1-x442.google.com with SMTP id 50so10617581wrc.11
 for <qemu-devel@nongnu.org>; Mon, 18 May 2020 01:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=adacore-com.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=ZNyb+dguNOMxY24/maASO8tIdV71stYKYtoOe8VB3RQ=;
 b=qSN1at90+TSKlv6Hc1Ga81mc2vec5PoJG+6l0S7xJFGVeqpeoK2z+/tv8pZ5hJxX1P
 iNxZYKSmfefYSrKVgcc5ixfly7/94Ywn6w4Jom/O3/xDmWovvlAZp/6VZVE3PQXLREw2
 QEpmVk4BjtlIpnscgtsqrecUa8gPx873YLJ1DOSIeSAzAWeCxrrno1gGGuH3l+48d8Zy
 0wxla+G5j52trD0PiLM/FXOqLXycqn6d9lVbL/wxnSEAcEa3NnrKV+cVLAbN03iieWoH
 4rz9mrz2MAu68WF/yr7oWrqKwCIW14nLbVnHRuq+GcL6Xt/M5JMpj4hr9zR9+baU3WMq
 Zscw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ZNyb+dguNOMxY24/maASO8tIdV71stYKYtoOe8VB3RQ=;
 b=XJVB1+LgsJhhe0G8WIrRFyoMJDO/jubTZdTA9IULkJlzDBOE7fqJK7AMRImakPqyAn
 FRKhtdpV2EcsMiPFVEMsC89t9gZ3aVq6gKyRAHdSKEf9XGBCeP3anp//pS+iJDYUWEb/
 0y4GO99lvw82FO6DXxCRGdcr/whJ8R1O/s0G46lMAdYIFZ6g3859CFkYRaBI+rX60rRW
 IiG5NYWoxfaL2w1D4bdoJEBEwvlN1Dc9Jl6oDxDR1hZdwnYkEWhi0U1HCmaOjJ/JYVGX
 pmZJISTygkA9aIhqezMV0v7VUFKJ716GgeNWeKr4yCVrDd791FOLaNDQKHQyOZsRA4Xa
 D5Nw==
X-Gm-Message-State: AOAM532x2DGWW8aqdxfL0HyL4OtnGxp1ICyUG4XO3FDAIOWTHgm8zYnb
 4gFtUjyxqS04G7nDR8PABqtbzQ==
X-Google-Smtp-Source: ABdhPJwRgYajHnF5mx3YLB/MFsprkJHbkAeXrhYA7M0MjhwSAPRTBm16YonvCF4FbC17nvB9PMJADg==
X-Received: by 2002:a5d:526f:: with SMTP id l15mr18134088wrc.367.1589789403382; 
 Mon, 18 May 2020 01:10:03 -0700 (PDT)
Received: from linux.home ([2a01:cb19:867e:2100:7eef:23e0:9210:3e8])
 by smtp.gmail.com with ESMTPSA id q9sm15012711wmb.34.2020.05.18.01.09.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 May 2020 01:10:00 -0700 (PDT)
Subject: Re: [PATCH 21/24] sparc/leon3: Fix to put grlib,* devices on sysbus
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200518050408.4579-1-armbru@redhat.com>
 <20200518050408.4579-22-armbru@redhat.com>
From: Fred Konrad <konrad@adacore.com>
Message-ID: <3481fdff-e2e2-df1c-78df-bc290962d818@adacore.com>
Date: Mon, 18 May 2020 10:09:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200518050408.4579-22-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=konrad@adacore.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
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
Cc: berrange@redhat.com, ehabkost@redhat.com,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Fabien Chouteau <chouteau@adacore.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>, pbonzini@redhat.com,
 Artyom Tarasenko <atar4qemu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



Le 5/18/20 à 7:04 AM, Markus Armbruster a écrit :
> leon3_generic_hw_init() creates a "grlib,ahbpnp" and a "grlib,apbpnp"
> sysbus device in a way that leaves them unplugged.
> 
> Create them the common way that puts them into the main system bus.
> Affects machine leon3_generic.  Visible in "info qtree":
> 
>       bus: main-system-bus
>         type System
>      +  dev: grlib,ahbpnp, id ""
>      +    mmio 00000000fffff000/0000000000001000
>      +  dev: grlib,apbpnp, id ""
>      +    mmio 00000000800ff000/0000000000001000
>         dev: grlib,irqmp, id ""
> 
> Cc: Fabien Chouteau <chouteau@adacore.com>
> Cc: KONRAD Frederic <frederic.konrad@adacore.com>
> Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Cc: Artyom Tarasenko <atar4qemu@gmail.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   hw/sparc/leon3.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/sparc/leon3.c b/hw/sparc/leon3.c
> index 8f024dab7b..3facb8c2ae 100644
> --- a/hw/sparc/leon3.c
> +++ b/hw/sparc/leon3.c
> @@ -213,14 +213,14 @@ static void leon3_generic_hw_init(MachineState *machine)
>       reset_info->sp    = LEON3_RAM_OFFSET + ram_size;
>       qemu_register_reset(main_cpu_reset, reset_info);
>   
> -    ahb_pnp = GRLIB_AHB_PNP(object_new(TYPE_GRLIB_AHB_PNP));
> +    ahb_pnp = GRLIB_AHB_PNP(qdev_create(NULL, TYPE_GRLIB_AHB_PNP));
>       object_property_set_bool(OBJECT(ahb_pnp), true, "realized", &error_fatal);
>       sysbus_mmio_map(SYS_BUS_DEVICE(ahb_pnp), 0, LEON3_AHB_PNP_OFFSET);
>       grlib_ahb_pnp_add_entry(ahb_pnp, 0, 0, GRLIB_VENDOR_GAISLER,
>                               GRLIB_LEON3_DEV, GRLIB_AHB_MASTER,
>                               GRLIB_CPU_AREA);
>   
> -    apb_pnp = GRLIB_APB_PNP(object_new(TYPE_GRLIB_APB_PNP));
> +    apb_pnp = GRLIB_APB_PNP(qdev_create(NULL, TYPE_GRLIB_APB_PNP));
>       object_property_set_bool(OBJECT(apb_pnp), true, "realized", &error_fatal);
>       sysbus_mmio_map(SYS_BUS_DEVICE(apb_pnp), 0, LEON3_APB_PNP_OFFSET);
>       grlib_ahb_pnp_add_entry(ahb_pnp, LEON3_APB_PNP_OFFSET, 0xFFF,
> 

Reviewed-by: KONRAD Frederic <frederic.konrad@adacore.com>

