Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D08E7C47254
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 13:36:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AF06206A5
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 13:36:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b2UZ715w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AF06206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46510 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVxkS-0000Yb-Qy
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 09:36:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48098)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jVxjj-00085u-Q9
 for qemu-devel@nongnu.org; Tue, 05 May 2020 09:35:51 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47354
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jVxjh-0007jq-Pz
 for qemu-devel@nongnu.org; Tue, 05 May 2020 09:35:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588685748;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Brbl/pONNTPMqG5HzVWfa1oZmgTX6EypZh34q9IhqfI=;
 b=b2UZ715wTnfNteligALSq77+W3lPBEe4HrxZA3RI0WYt9wPPZSFfMJf5fO4l7cO9EGRqof
 gRaGFcwPZxlYVNScX4WSwiC/jIHGEgrpXhp2tbI8JKOxNmfUx2IWPWqJZu31OPtGwBQYZB
 yxeykfZeDkwBxgVomNJEzGpAU2cWKFc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-249-oTIbYMCvPuCWttHNzR0RFg-1; Tue, 05 May 2020 09:35:47 -0400
X-MC-Unique: oTIbYMCvPuCWttHNzR0RFg-1
Received: by mail-wm1-f71.google.com with SMTP id 14so808387wmo.9
 for <qemu-devel@nongnu.org>; Tue, 05 May 2020 06:35:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Brbl/pONNTPMqG5HzVWfa1oZmgTX6EypZh34q9IhqfI=;
 b=LxC9icaEtEAlHqUUL++LfjQcqqmYFXUB8pbJZk2RE+6ThtcPg9KQJ6DLthmLz+flrS
 rLmRNB06LOBXS74FPuFkdCbDTL7e6QY4kHiq2kXQxQTQfLS1qmsaJw6FMyOLGXrCe75t
 w/jn4P37hZI/p3iqRhnrC+rY9+pvo2MmPAIZus33toBV2LOEqWHnj8FilTgOFhWdrADP
 eBLPBQmXryGjzlxOn1unBETAhP/GFv5JVeZf5M8RQftrXbzmhetSAIp+lTyfv7evni4H
 tMNlceP0iiJHnULwHas3iVk3fwVWJPUSZrviw4XFgyXsdNepa3JpL9p1rKxMJjoD4O6A
 U5sA==
X-Gm-Message-State: AGi0PuZ349lmE7G77fOIRMPtqRHsqeOGyQmGP11VDecGZOvXP63b8e/4
 FVBYGJy9FqOHAzaKpldyAushmGUfTcAsN+1E2MHSN3DhnzTwqwWQ4OzlUa/AqDdilWd/mbe1iT7
 fiiP4ud94vY3TcQM=
X-Received: by 2002:adf:ea83:: with SMTP id s3mr3808049wrm.264.1588685745917; 
 Tue, 05 May 2020 06:35:45 -0700 (PDT)
X-Google-Smtp-Source: APiQypL4u1Wx2eQw7jCu8HAC0dHnA83ohnR4uxkK+bIWTVKSxjz1YyXnyc+tvDk5v4SucNdN37dGqA==
X-Received: by 2002:adf:ea83:: with SMTP id s3mr3808012wrm.264.1588685745686; 
 Tue, 05 May 2020 06:35:45 -0700 (PDT)
Received: from [192.168.1.38] (26.red-88-21-207.staticip.rima-tde.net.
 [88.21.207.26])
 by smtp.gmail.com with ESMTPSA id 89sm3501681wrj.37.2020.05.05.06.35.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 May 2020 06:35:44 -0700 (PDT)
Subject: Re: [PATCH v4 07/13] acpi: move aml builder code for parallel device
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
References: <20200505113843.22012-1-kraxel@redhat.com>
 <20200505113843.22012-8-kraxel@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <97cd8a76-c6b8-92b6-86ae-b29d05635751@redhat.com>
Date: Tue, 5 May 2020 15:35:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200505113843.22012-8-kraxel@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/05 00:37:38
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Laurent Vivier <lvivier@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Gerd,

On 5/5/20 1:38 PM, Gerd Hoffmann wrote:
> Also adds support for multiple LPT devices.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> ---
>   hw/char/parallel.c   | 32 ++++++++++++++++++++++++++++++++
>   hw/i386/acpi-build.c | 23 -----------------------
>   2 files changed, 32 insertions(+), 23 deletions(-)
> 
> diff --git a/hw/char/parallel.c b/hw/char/parallel.c
> index 8dd67d13759b..bc6b55b3b910 100644
> --- a/hw/char/parallel.c
> +++ b/hw/char/parallel.c
> @@ -28,6 +28,7 @@
>   #include "qemu/module.h"
>   #include "chardev/char-parallel.h"
>   #include "chardev/char-fe.h"
> +#include "hw/acpi/aml-build.h"
>   #include "hw/irq.h"
>   #include "hw/isa/isa.h"
>   #include "hw/qdev-properties.h"
> @@ -568,6 +569,35 @@ static void parallel_isa_realizefn(DeviceState *dev, Error **errp)
>                                s, "parallel");
>   }
>   
> +static void parallel_isa_build_aml(ISADevice *isadev, Aml *scope)
> +{
> +    ISAParallelState *isa = ISA_PARALLEL(isadev);
> +    int i, uid = 0;
> +    Aml *dev;
> +    Aml *crs;
> +
> +    for (i = 0; i < ARRAY_SIZE(isa_parallel_io); i++) {
> +        if (isa->iobase == isa_parallel_io[i]) {
> +            uid = i + 1;

I'm not sure about this check, as we can create a ISA device setting 
manually index & iobase. What about using simply "uid = isa->index + 1" 
instead?

> +        }
> +    }
> +    if (!uid) {
> +        return;
> +    }
> +
> +    crs = aml_resource_template();
> +    aml_append(crs, aml_io(AML_DECODE16, isa->iobase, isa->iobase, 0x08, 0x08));
> +    aml_append(crs, aml_irq_no_flags(isa->isairq));
> +
> +    dev = aml_device("LPT%d", uid);
> +    aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0400")));
> +    aml_append(dev, aml_name_decl("_UID", aml_int(uid)));
> +    aml_append(dev, aml_name_decl("_STA", aml_int(0xf)));
> +    aml_append(dev, aml_name_decl("_CRS", crs));
> +
> +    aml_append(scope, dev);
> +}
> +
>   /* Memory mapped interface */
>   static uint64_t parallel_mm_readfn(void *opaque, hwaddr addr, unsigned size)
>   {
> @@ -624,9 +654,11 @@ static Property parallel_isa_properties[] = {
>   static void parallel_isa_class_initfn(ObjectClass *klass, void *data)
>   {
>       DeviceClass *dc = DEVICE_CLASS(klass);
> +    ISADeviceClass *isa = ISA_DEVICE_CLASS(klass);
>   
>       dc->realize = parallel_isa_realizefn;
>       dc->vmsd = &vmstate_parallel_isa;
> +    isa->build_aml = parallel_isa_build_aml;
>       device_class_set_props(dc, parallel_isa_properties);
>       set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
>   }
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 2188a2b99d18..443db94deb5b 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -1173,28 +1173,6 @@ static Aml *build_mouse_device_aml(void)
>       return dev;
>   }
>   
> -static void build_lpt_device_aml(Aml *scope)
> -{
> -    Aml *dev;
> -    Aml *crs;
> -
> -    if (!memory_region_present(get_system_io(), 0x0378)) {
> -        return;
> -    }
> -
> -    dev = aml_device("LPT");
> -    aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0400")));
> -
> -    aml_append(dev, aml_name_decl("_STA", aml_int(0xf)));
> -
> -    crs = aml_resource_template();
> -    aml_append(crs, aml_io(AML_DECODE16, 0x0378, 0x0378, 0x08, 0x08));
> -    aml_append(crs, aml_irq_no_flags(7));
> -    aml_append(dev, aml_name_decl("_CRS", crs));
> -
> -    aml_append(scope, dev);
> -}
> -
>   static void build_isa_devices_aml(Aml *table)
>   {
>       ISADevice *fdc = pc_find_fdc0();
> @@ -1208,7 +1186,6 @@ static void build_isa_devices_aml(Aml *table)
>       if (fdc) {
>           aml_append(scope, build_fdc_device_aml(fdc));
>       }
> -    build_lpt_device_aml(scope);
>   
>       if (ambiguous) {
>           error_report("Multiple ISA busses, unable to define IPMI ACPI data");
> 


