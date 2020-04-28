Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EDBDC83009
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 17:29:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 701EE2137B
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 17:29:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sjUkOCFV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 701EE2137B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41334 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTU3E-00065M-KF
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 13:29:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41712)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jTU25-0004lK-I5
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 13:28:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jTU1N-0007eV-94
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 13:28:33 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:52074)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jTU0n-00071g-Lv; Tue, 28 Apr 2020 13:27:13 -0400
Received: by mail-wm1-x341.google.com with SMTP id x4so3735388wmj.1;
 Tue, 28 Apr 2020 10:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=pqKrXOEtrxnP496YhTxf3HJMjQqHOadMZsTWVWntBL0=;
 b=sjUkOCFVSKo/9ZEDfLABxfTfnh/Y084rvTB8qqqnBVGrtZMrreiTVKbJJF2TAnW2L1
 D3HJEgtEg3wqrMh+0ww12LoM63XSj2JkQ5J8Obf/cFmljgSNP6zDFVbTUy2ka3IBcWgl
 AT7Ijanp3yvFZL+ZB2m0hSGP77PhOXdKEO31mttp/g/MHNsuc900hlGJ6dJT3eRDoOia
 b4KHFcwqbRx1GgRPDCG12JXqLIKW3IEbZlA7zxYYvf87ifFX5bMZr0Z9voexQiijPPIx
 KaShqpBJsodjPnNvkXPZLu+w8+oy4fbRMCqn44JoOeXjlidxCdBEF/tL43PpCt3Jt5sg
 pIzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=pqKrXOEtrxnP496YhTxf3HJMjQqHOadMZsTWVWntBL0=;
 b=lEuyxfoWygnYVTBkmL66YLPKnLtxrzay8X3Sl4W5Qw81u3MtyaHe8K9ecQBmVhoHo4
 3SLHeb7NMeC/9mJV3YxrgeriGoeZJIpEOoeNcCBNEVm+1hH9wsPDhUkwN/AC0VbAeUXF
 Y4o+hBIQfTk1xtqCGXwjItKDrImNfMhFeEd5YWhvLTf21dnEkRcR5+Cw2qnW8CtNT6Qw
 g9HB9rHx2Uamk+ZO7qLnoADNUXJWJTaqZFdfLZrKUpPz5bqn5oOLwHQpqVC+EWnsQLFd
 FWwwyqvFuLQlgGWf4TuaCpTK1GKNOJLoQNqgJoO9dMiuWCzoVgPXH5V6trIagKkzA7sh
 oc3w==
X-Gm-Message-State: AGi0Pub/SGeleFLSJOJyD1ew0eu+FuiZo+WWkWqbbGIySpxHSHXtP00+
 oMYwXLHRpOceAC8BLriZxwjdN9KKAr4=
X-Google-Smtp-Source: APiQypJwAZ/OilwvL3caTUHo5t7XYxsT6n/WJZQCEoQLLcpA8pzTRVN8pX6KcPZkmh17f1H8cG4EUg==
X-Received: by 2002:a1c:7ed7:: with SMTP id z206mr5308336wmc.64.1588094831609; 
 Tue, 28 Apr 2020 10:27:11 -0700 (PDT)
Received: from [192.168.1.39] (137.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.137])
 by smtp.gmail.com with ESMTPSA id g6sm26515968wrw.34.2020.04.28.10.27.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Apr 2020 10:27:10 -0700 (PDT)
Subject: Re: [PATCH 11/17] hw/arm/bcm2835: Drop futile attempts at
 QOM-adopting memory
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200428163419.4483-1-armbru@redhat.com>
 <20200428163419.4483-12-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <518e7614-f783-65c5-0b00-e0fca429a820@amsat.org>
Date: Tue, 28 Apr 2020 19:27:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200428163419.4483-12-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::341
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
Cc: Peter Maydell <peter.maydell@linaro.org>, berrange@redhat.com,
 ehabkost@redhat.com, Andrew Baumann <Andrew.Baumann@microsoft.com>,
 qemu-arm@nongnu.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/28/20 6:34 PM, Markus Armbruster wrote:
> The "bcm2835-peripherals" device's .instance_init() method
> bcm2835_peripherals_init() attempts to make two memory regions QOM
> children of the device.  This is futile, because memory_region_init()
> already did.  The errors are ignored (a later commit will change
> that).  Drop the useless calls.
> 
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: Andrew Baumann <Andrew.Baumann@microsoft.com>
> Cc: "Philippe Mathieu-Daudé" <philmd@redhat.com>
> Cc: qemu-arm@nongnu.org
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   hw/arm/bcm2835_peripherals.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/hw/arm/bcm2835_peripherals.c b/hw/arm/bcm2835_peripherals.c
> index edcaa4916d..8b399d67ff 100644
> --- a/hw/arm/bcm2835_peripherals.c
> +++ b/hw/arm/bcm2835_peripherals.c
> @@ -43,12 +43,10 @@ static void bcm2835_peripherals_init(Object *obj)
>   
>       /* Memory region for peripheral devices, which we export to our parent */
>       memory_region_init(&s->peri_mr, obj,"bcm2835-peripherals", 0x1000000);
> -    object_property_add_child(obj, "peripheral-io", OBJECT(&s->peri_mr), NULL);
>       sysbus_init_mmio(SYS_BUS_DEVICE(s), &s->peri_mr);
>   
>       /* Internal memory region for peripheral bus addresses (not exported) */
>       memory_region_init(&s->gpu_bus_mr, obj, "bcm2835-gpu", (uint64_t)1 << 32);
> -    object_property_add_child(obj, "gpu-bus", OBJECT(&s->gpu_bus_mr), NULL);
>   
>       /* Internal memory region for request/response communication with
>        * mailbox-addressable peripherals (not exported)
> 

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

