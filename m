Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFDEFC83001
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 06:41:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9667820784
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 06:41:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fPgT0UNa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9667820784
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60992 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU2si-0002Sn-Pc
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 02:41:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58276)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jU2rT-000173-Az
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 02:39:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jU2rS-0006i2-S6
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 02:39:55 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34230
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jU2rS-0006hl-FX
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 02:39:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588228793;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qLYX/q3PAOAeH06WaWYT8pWOSKetbH/SLNKq+96UU4Y=;
 b=fPgT0UNay4ZLl26u/q0O+nLE1hJOL8QkGxJSi49tSVnq9gA9bTpIXwMjw6WeGM/+I0liMf
 HlrUrS5sRbifaPN0guMSCR0e8qmOUP+J5ndLUnRlh5MxAG69YtBPpj14LXWycn62NQH88g
 PQRKFG/SdMf6QvdOgZTHlt7HIYoiEEE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-8-qeio-M8mPZaxLuGqdoYwIg-1; Thu, 30 Apr 2020 02:39:49 -0400
X-MC-Unique: qeio-M8mPZaxLuGqdoYwIg-1
Received: by mail-wr1-f71.google.com with SMTP id p16so3353017wro.16
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2020 23:39:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=qLYX/q3PAOAeH06WaWYT8pWOSKetbH/SLNKq+96UU4Y=;
 b=XB8dHDFz/oE9DTPO5WRYhd/D72B+Son2N59JmFE7psJii5dmWpDFu5/XBqZFbN02SJ
 DCpt8/zCly0R7dbUjruiTnoRskahnCMVNl9wiL758AvFE6JX/W4ouCk1r8mpeef3cvrn
 QiMAyHQBSifSWUYB35ev9gAFKGLmFmEfpoBt0ZgsdlL+1SOvg6EhPQnIUDgeSVenajOE
 lWqtuW3xuA+ZBenf4Pnj+HyOMlD33GT5E8c6jUNQNdPmj1EMBKpSzYC/JWHYCuOTBxdI
 8LMnVG4vRRfa37XAweD4lm6psS8hd8jltLBLIK5DkkxAmUNuNqm/eDtgu+WSMxTVBqGK
 7AqQ==
X-Gm-Message-State: AGi0PuZLyDmw0Xqvznfp8ff8UpKbb3LTamwqrJcG1UO6Fi80J5ZS9Tcc
 sr9PKroLWZOuhrL8H67RBOsReq6EfEScIgjSKDEGSfgaXU16m2qOwnBWZ31v0FwNH7oaJ1mu0iQ
 DSCdU61heVI88E4U=
X-Received: by 2002:adf:a543:: with SMTP id j3mr2238233wrb.34.1588228787961;
 Wed, 29 Apr 2020 23:39:47 -0700 (PDT)
X-Google-Smtp-Source: APiQypLFM9teLsFWz0NSsymPZ1dThFehJ1Jm+G3aq046OEAObteqBZaVirZyad3I4Boleq0lKxImbg==
X-Received: by 2002:adf:a543:: with SMTP id j3mr2238206wrb.34.1588228787741;
 Wed, 29 Apr 2020 23:39:47 -0700 (PDT)
Received: from [192.168.1.39] (137.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.137])
 by smtp.gmail.com with ESMTPSA id c20sm11457364wmd.36.2020.04.29.23.39.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Apr 2020 23:39:47 -0700 (PDT)
Subject: Re: [PATCH v3 08/15] acpi: serial: don't use _STA method
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
References: <20200429140003.7336-1-kraxel@redhat.com>
 <20200429140003.7336-9-kraxel@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <f79d7f70-7377-3740-69c9-687641565fce@redhat.com>
Date: Thu, 30 Apr 2020 08:39:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200429140003.7336-9-kraxel@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/30 01:24:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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

Hi Gerd,

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
>   hw/i386/acpi-build.c | 32 ++++++++------------------------
>   1 file changed, 8 insertions(+), 24 deletions(-)
> 
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index f79e5eaf170d..a99e5bbd1156 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -1202,50 +1202,34 @@ static Aml *build_lpt_device_aml(void)
>       return dev;
>   }
>   
> -static Aml *build_com_device_aml(uint8_t uid)
> +static void build_com_device_aml(Aml *scope, uint8_t uid)
>   {
>       Aml *dev;
>       Aml *crs;
> -    Aml *method;
> -    Aml *if_ctx;
> -    Aml *else_ctx;
> -    Aml *zero = aml_int(0);
> -    Aml *is_present = aml_local(0);
> -    const char *enabled_field = "CAEN";
>       uint8_t irq = 4;
>       uint16_t io_port = 0x03F8;
>   
>       assert(uid == 1 || uid == 2);
>       if (uid == 2) {
> -        enabled_field = "CBEN";
>           irq = 3;
>           io_port = 0x02F8;
>       }
> +    if (!memory_region_present(get_system_io(), io_port)) {
> +        return;
> +    }

The patch looks OK, but an you split this check into a separate 
(previous?) patch please?

>   
>       dev = aml_device("COM%d", uid);
>       aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0501")));
>       aml_append(dev, aml_name_decl("_UID", aml_int(uid)));
>   
> -    method = aml_method("_STA", 0, AML_NOTSERIALIZED);
> -    aml_append(method, aml_store(aml_name("%s", enabled_field), is_present));
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
>       aml_append(crs, aml_io(AML_DECODE16, io_port, io_port, 0x00, 0x08));
>       aml_append(crs, aml_irq_no_flags(irq));
>       aml_append(dev, aml_name_decl("_CRS", crs));
>   
> -    return dev;
> +    aml_append(scope, dev);
>   }
>   
>   static void build_isa_devices_aml(Aml *table)
> @@ -1262,8 +1246,8 @@ static void build_isa_devices_aml(Aml *table)
>           aml_append(scope, build_fdc_device_aml(fdc));
>       }
>       aml_append(scope, build_lpt_device_aml());
> -    aml_append(scope, build_com_device_aml(1));
> -    aml_append(scope, build_com_device_aml(2));
> +    build_com_device_aml(scope, 1);
> +    build_com_device_aml(scope, 2);
>   
>       if (ambiguous) {
>           error_report("Multiple ISA busses, unable to define IPMI ACPI data");
> 


