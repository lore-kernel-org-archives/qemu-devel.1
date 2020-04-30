Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 103B3C83001
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 06:44:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCCCC214D8
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 06:44:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DUiOaCzX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCCCC214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38102 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU2vx-00051n-1f
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 02:44:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58660)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jU2uu-0004Q8-9w
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 02:43:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jU2ut-0007ry-MB
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 02:43:28 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34342
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jU2ut-0007rS-7d
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 02:43:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588229006;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kOqu4sY2dsMHSmzOyiWP1F1FB4sCqGZaOY61/Bkr9yY=;
 b=DUiOaCzXS7c4lfMLNwRlr9ZHZ/B9juQ612m4u2foYKQpmkxfkw/NzNUMJfLZey/ZnmCv6Y
 qEKDcXz64FiAsq721MAafyHskbP11HC3ydtJpJZGFpreup50XVHJDcXSl0tpqmdzS5+3ZQ
 Hk4UaNmTqYbvpQhCRjMheL271SBBATQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-309-4OLWS0siMDe_cJGGe6qz5w-1; Thu, 30 Apr 2020 02:43:24 -0400
X-MC-Unique: 4OLWS0siMDe_cJGGe6qz5w-1
Received: by mail-wm1-f72.google.com with SMTP id w2so373080wmc.3
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2020 23:43:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=kOqu4sY2dsMHSmzOyiWP1F1FB4sCqGZaOY61/Bkr9yY=;
 b=Az8NF//TGpA3wmZZZ7FPca+cabyUmW3zAV2GiMG7P7NG6mlDXBr1UqYjdqnMn4jNZl
 JL+H7voSZdvNMDNZOm4yHpNyXbWLXommHt24P2mCIcdDBIKTBZwN9wFHdj3YcnKP2wqE
 i4Ji22xi0WkFLegHNUhEC2akml3fhcV8JCk2sVF7IPRG/q/BP6IOfZkP2OMhLI4ESb0M
 fYckLFlXZdE/Q/iDfahaF9wGiGj/ZIajKX6Thod4jVane2GMiZ16VPDur3Cpq8+Zcvpm
 bOXDCoWS6izLQ4/rSQA+1dsrDbYaw38S3Tmg9B64kaaGwFnBMPsIqWjNZJitvOD0+g4d
 OJOg==
X-Gm-Message-State: AGi0PuYuc8ZvKI89ibev69a6U5zRukfImsGqfIR6YlJSZuuQhriIdYVK
 sjhOaMT4SDYXomE+7+Lcs0Bwe1/5wVEXVYCF9NymcY0RXO3k7XDkkf0wWysNb11wBL2xR1xzMWH
 rB1EeASJWpsBtjIU=
X-Received: by 2002:a05:600c:14d4:: with SMTP id
 i20mr1265869wmh.118.1588229003648; 
 Wed, 29 Apr 2020 23:43:23 -0700 (PDT)
X-Google-Smtp-Source: APiQypKM9sEfeKFwCnRq+r5Rehj2hrFqHwj+imuff7IltHgc4LQBrjSClI90FQXu/g67yJbzyaDzLQ==
X-Received: by 2002:a05:600c:14d4:: with SMTP id
 i20mr1265840wmh.118.1588229003417; 
 Wed, 29 Apr 2020 23:43:23 -0700 (PDT)
Received: from [192.168.1.39] (137.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.137])
 by smtp.gmail.com with ESMTPSA id b22sm11294858wmj.1.2020.04.29.23.43.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Apr 2020 23:43:22 -0700 (PDT)
Subject: Re: [PATCH v3 10/15] acpi: parallel: don't use _STA method
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
References: <20200429140003.7336-1-kraxel@redhat.com>
 <20200429140003.7336-11-kraxel@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <8b586c32-611d-330c-5d3e-fa595c37eae5@redhat.com>
Date: Thu, 30 Apr 2020 08:43:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200429140003.7336-11-kraxel@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 23:34:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Kevin Wolf <kwolf@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/29/20 3:59 PM, Gerd Hoffmann wrote:
> The _STA method dates back to the days where we had a static DSDT.  The
> device is listed in the DSDT table unconditionally and the _STA method
> checks a bit in the isa bridge pci config space to figure whenever a
> given is isa device is present or not, then evaluates to 0x0f (present)
> or 0x00 (absent).
> 
> These days the DSDT is generated by qemu anyway, so if a device is not
> present we can simply drop it from the DSDT instead.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> ---
>   hw/i386/acpi-build.c | 29 ++++++++---------------------
>   1 file changed, 8 insertions(+), 21 deletions(-)
> 
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index fea83352e6ab..e01afbd011d9 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -1167,39 +1167,26 @@ static Aml *build_mouse_device_aml(void)
>       return dev;
>   }
>   
> -static Aml *build_lpt_device_aml(void)
> +static void build_lpt_device_aml(Aml *scope)
>   {
>       Aml *dev;
>       Aml *crs;
> -    Aml *method;
> -    Aml *if_ctx;
> -    Aml *else_ctx;
> -    Aml *zero = aml_int(0);
> -    Aml *is_present = aml_local(0);
> +
> +    if (!memory_region_present(get_system_io(), 0x0378)) {
> +        return;
> +    }

Please move this check in a separate patch.

Also, it may be worth a ISA_PARALLEL_IOBASE 0x378 definition cleanup 
like you did with the RTC.

>   
>       dev = aml_device("LPT");
>       aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0400")));
>   
> -    method = aml_method("_STA", 0, AML_NOTSERIALIZED);
> -    aml_append(method, aml_store(aml_name("LPEN"), is_present));
> -    if_ctx = aml_if(aml_equal(is_present, zero));
> -    {
> -        aml_append(if_ctx, aml_return(aml_int(0x00)));
> -    }
> -    aml_append(method, if_ctx);
> -    else_ctx = aml_else();
> -    {
> -        aml_append(else_ctx, aml_return(aml_int(0x0f)));
> -    }
> -    aml_append(method, else_ctx);
> -    aml_append(dev, method);
> +    aml_append(dev, aml_name_decl("_STA", aml_int(0xf)));
>   
>       crs = aml_resource_template();
>       aml_append(crs, aml_io(AML_DECODE16, 0x0378, 0x0378, 0x08, 0x08));
>       aml_append(crs, aml_irq_no_flags(7));
>       aml_append(dev, aml_name_decl("_CRS", crs));
>   
> -    return dev;
> +    aml_append(scope, dev);
>   }
>   
>   static void build_isa_devices_aml(Aml *table)
> @@ -1215,7 +1202,7 @@ static void build_isa_devices_aml(Aml *table)
>       if (fdc) {
>           aml_append(scope, build_fdc_device_aml(fdc));
>       }
> -    aml_append(scope, build_lpt_device_aml());
> +    build_lpt_device_aml(scope);
>   
>       if (ambiguous) {
>           error_report("Multiple ISA busses, unable to define IPMI ACPI data");
> 


