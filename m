Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F09D0C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 09:01:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A51FE2070A
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 09:01:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QL5peD1Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A51FE2070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37906 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jabee-0003tp-SE
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 05:01:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48792)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jabcR-0001yF-Rh
 for qemu-devel@nongnu.org; Mon, 18 May 2020 04:59:31 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:54120
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jabcQ-0004hu-V5
 for qemu-devel@nongnu.org; Mon, 18 May 2020 04:59:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589792370;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=18Nn2L7KeNdR7pUF8ThLH87ysKnYlHjmLXXTCm8+4g8=;
 b=QL5peD1Zs85eG79cp4xhyJnyFYzOWcu9JomeFnVb2+y7sGFEN0E2seJ/pNiQDbIrVafoHw
 Mw5KgSlsfVNiMTfLHWQEhf1IrVB1r0djTYOsRDKaN8v5iCtqZmP41YlW2s5slNysGpmAFY
 GKJqDG+lFmpTCzVgUB5th6kXwKRfQRI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-218-88OEcaO3MvOKd9Cw7KXBvg-1; Mon, 18 May 2020 04:59:28 -0400
X-MC-Unique: 88OEcaO3MvOKd9Cw7KXBvg-1
Received: by mail-wr1-f69.google.com with SMTP id 90so5331125wrg.23
 for <qemu-devel@nongnu.org>; Mon, 18 May 2020 01:59:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=18Nn2L7KeNdR7pUF8ThLH87ysKnYlHjmLXXTCm8+4g8=;
 b=hr2lFenShPrnRG3x2uq2rDc0u4Iu7NmPUCNRIIPNh+/lPaK06TShgo9t6EAmmBGLGv
 VCFPn6DnInXsQzGZubBF+oN9OAqpXBH9fPIz71j49MrzXb+dHjtVxElBHEHY43UJjLm1
 SnYgBJmGFIYsZ33d59qinkC5Et7aLF05QufH2HmXKvo/hZYxMouCS8w3uqk8NzEovOaL
 IHlPh+TmTcocoexh8MHBGh7lCnnF7Idaxb7GvRh704pQEFXGQ/Z21XK5BxB57+n/utef
 YQiuGFxRQ8Z7b3mxznJmMnNuOW3fi+ySnb5lq8a/bc/t5ABaCZETr6xMuxzG4//fIDqO
 D8Iw==
X-Gm-Message-State: AOAM531FVgqp/nr+uCke/Kmfad2DHhpzmn8D6C7Axz1bP8DhfT4F9HdG
 LbpvlxarSZn/XeYn/nyz7NOe4Eob0SFzmRGbKtPV0lg7bu+jePkzp4iEugtN68SHG2EaGTiT7fd
 s4oL/ihKaoKhDL+0=
X-Received: by 2002:a1c:4b0e:: with SMTP id y14mr18815213wma.170.1589792367437; 
 Mon, 18 May 2020 01:59:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwp0busE0HpJIRZyFQhmJ4Wlc7bCCStM/ARaShuO3dHIhZDztac/jHye60ftyyrSm6x8zdBCg==
X-Received: by 2002:a1c:4b0e:: with SMTP id y14mr18815195wma.170.1589792367207; 
 Mon, 18 May 2020 01:59:27 -0700 (PDT)
Received: from [192.168.1.38] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id v11sm15581079wrv.53.2020.05.18.01.59.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 May 2020 01:59:26 -0700 (PDT)
Subject: Re: [PATCH 21/24] sparc/leon3: Fix to put grlib,* devices on sysbus
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200518050408.4579-1-armbru@redhat.com>
 <20200518050408.4579-22-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <266d9033-9fd9-876e-c977-dbf3f03fb68b@redhat.com>
Date: Mon, 18 May 2020 10:59:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200518050408.4579-22-armbru@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/17 23:32:08
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
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

On 5/18/20 7:04 AM, Markus Armbruster wrote:
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


