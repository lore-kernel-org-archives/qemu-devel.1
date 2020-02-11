Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AA84C352A3
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 08:26:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16C1E20714
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 08:26:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YcXhRm5d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16C1E20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45000 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1Qse-0006VT-9K
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 03:26:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47359)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j1Qqy-00054C-AW
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 03:25:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j1Qqw-0002ui-EF
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 03:25:07 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:54560
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j1Qqw-0002rk-9c
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 03:25:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581409505;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ytI3yd4D1otRPJZTQqqVtGkMqVXwOgxULV2gcfdJ1R4=;
 b=YcXhRm5d4zxK22P4b1vOMrYSGYIi3DnoRJSDNo85+2Yzj/BGRs+jdKxJK+Bcez8i0zAU6V
 LT2c9N0HTXOTd8TV0jc7Xrlzj4TyNyY650g/4+EcbzWEQEbBb3Wq1yov4tAsoC7rSvcc0G
 urZAvCK1T3AbRQHTv0L8KeRvYrZKDIY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-377-0sxycUshP5G0iukGj-TIoQ-1; Tue, 11 Feb 2020 03:25:04 -0500
Received: by mail-wr1-f70.google.com with SMTP id w6so6501518wrm.16
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2020 00:25:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ytI3yd4D1otRPJZTQqqVtGkMqVXwOgxULV2gcfdJ1R4=;
 b=K1I4I9qdk8KAu+T8FZ3oR/ZFiKYI88F2jUfGa3jDptP1YrV5KV0AAScn3B9eNhWkqo
 mPaQCJqlzaxG4si3AxPnlXVUIUFFjrjfSzQdyeVRz8DzQcy8FiyFTVIOKX+sO0uwYNld
 w3g8GuWboUmih5ksSgtdt6tksBiFTJtzeH3FkV6uicM4TNfzDxGtCUxdocmsHmxn9cL9
 hyJpeyk9iL/g6PDHl23c5cq6je0GGjp6ObGmc05k8HMETIdvucsKWBq5laHHapsS1ohQ
 83G8TyGqbDAuDplB0qlku9EoOjrC8b7eg351LU6l5lZCDwoSTN35eqJ5KakUQiZNcOLl
 fHGQ==
X-Gm-Message-State: APjAAAXPp4Ig28jekdWdG5aZKnoV5mrm0LY7EyoAkCsS/0ecuFvsXtb+
 4tbTVw2KfYA52h791C3X/UfbRvNn+pwdxbvTQX6zE7AHFJ2IVutHHbhI+duCMapnw5zUxa+EEfV
 ZE6kzyoMrGzId5V0=
X-Received: by 2002:adf:f504:: with SMTP id q4mr6897648wro.28.1581409502870;
 Tue, 11 Feb 2020 00:25:02 -0800 (PST)
X-Google-Smtp-Source: APXvYqxoS8fLhqxt1bj17zqKYvpulUq2KCxoG25EBS5Y57HeZmsgnQvGbnlsHWkjTrV90xYQFmOKPw==
X-Received: by 2002:adf:f504:: with SMTP id q4mr6897610wro.28.1581409502502;
 Tue, 11 Feb 2020 00:25:02 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id g15sm4341097wro.65.2020.02.11.00.25.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Feb 2020 00:25:01 -0800 (PST)
Subject: Re: [RFC 1/2] tpm: Let the TPM TIS device be usable on ARM
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 stefanb@linux.ibm.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 peter.maydell@linaro.org
References: <20200210131523.27540-1-eric.auger@redhat.com>
 <20200210131523.27540-2-eric.auger@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <5cbd1960-6138-f4d0-948f-1983cb0f93b0@redhat.com>
Date: Tue, 11 Feb 2020 09:25:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200210131523.27540-2-eric.auger@redhat.com>
Content-Language: en-US
X-MC-Unique: 0sxycUshP5G0iukGj-TIoQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: marcandre.lureau@redhat.com, lersek@redhat.com, ardb@kernel.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/10/20 2:15 PM, Eric Auger wrote:
> Implement support for TPM on aarch64 by using the
> TPM TIS MMIO frontend. Instead of being an ISA device,
> the TPM TIS device becomes a sysbus device on ARM. It is
> bound to be dynamically instantiated.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> 
> ---
> 
> I am aware such kind of #ifde'fy is frown upon but this is just
> for starting the discussion

I doubt this can be accepted upstream, because a target has to choose 
between using sysbus OR isa devices, not both.

> ---
>   hw/tpm/Kconfig   |  2 +-
>   hw/tpm/tpm_tis.c | 16 ++++++++++++++++
>   2 files changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/tpm/Kconfig b/hw/tpm/Kconfig
> index 9e67d990e8..326c89e6df 100644
> --- a/hw/tpm/Kconfig
> +++ b/hw/tpm/Kconfig
> @@ -4,7 +4,7 @@ config TPMDEV
>   
>   config TPM_TIS
>       bool
> -    depends on TPM && ISA_BUS
> +    depends on TPM
>       select TPMDEV
>   
>   config TPM_CRB
> diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
> index 31facb896d..cfc840942f 100644
> --- a/hw/tpm/tpm_tis.c
> +++ b/hw/tpm/tpm_tis.c
> @@ -30,6 +30,7 @@
>   
>   #include "hw/acpi/tpm.h"
>   #include "hw/pci/pci_ids.h"
> +#include "hw/sysbus.h"
>   #include "hw/qdev-properties.h"
>   #include "migration/vmstate.h"
>   #include "sysemu/tpm_backend.h"
> @@ -65,7 +66,11 @@ typedef struct TPMLocality {
>   } TPMLocality;
>   
>   typedef struct TPMState {
> +#ifdef CONFIG_ISA_BUS
>       ISADevice busdev;
> +#else
> +    SysBusDevice busdev;
> +#endif
>       MemoryRegion mmio;
>   
>       unsigned char buffer[TPM_TIS_BUFFER_MAX];
> @@ -967,6 +972,7 @@ static void tpm_tis_realizefn(DeviceState *dev, Error **errp)
>           error_setg(errp, "'tpmdev' property is required");
>           return;
>       }
> +#ifdef CONFIG_ISA_BUS
>       if (s->irq_num > 15) {
>           error_setg(errp, "IRQ %d is outside valid range of 0 to 15",
>                      s->irq_num);
> @@ -982,6 +988,7 @@ static void tpm_tis_realizefn(DeviceState *dev, Error **errp)
>           tpm_ppi_init(&s->ppi, isa_address_space(ISA_DEVICE(dev)),
>                        TPM_PPI_ADDR_BASE, OBJECT(s));
>       }
> +#endif
>   }
>   
>   static void tpm_tis_initfn(Object *obj)
> @@ -991,6 +998,10 @@ static void tpm_tis_initfn(Object *obj)
>       memory_region_init_io(&s->mmio, OBJECT(s), &tpm_tis_memory_ops,
>                             s, "tpm-tis-mmio",
>                             TPM_TIS_NUM_LOCALITIES << TPM_TIS_LOCALITY_SHIFT);
> +#ifndef CONFIG_ISA_BUS
> +    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
> +    sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->irq);
> +#endif
>   }
>   
>   static void tpm_tis_class_init(ObjectClass *klass, void *data)
> @@ -1002,6 +1013,7 @@ static void tpm_tis_class_init(ObjectClass *klass, void *data)
>       device_class_set_props(dc, tpm_tis_properties);
>       dc->reset = tpm_tis_reset;
>       dc->vmsd  = &vmstate_tpm_tis;

With your #ifde'fy in mind, you probably need to restrict this to sysbus:

   #ifndef CONFIG_ISA_BUS

> +    dc->user_creatable = true;

   #endif

>       tc->model = TPM_MODEL_TPM_TIS;
>       tc->get_version = tpm_tis_get_tpm_version;
>       tc->request_completed = tpm_tis_request_completed;
> @@ -1009,7 +1021,11 @@ static void tpm_tis_class_init(ObjectClass *klass, void *data)
>   
>   static const TypeInfo tpm_tis_info = {
>       .name = TYPE_TPM_TIS,
> +#ifdef CONFIG_ISA_BUS
>       .parent = TYPE_ISA_DEVICE,
> +#else
> +    .parent = TYPE_SYS_BUS_DEVICE,
> +#endif
>       .instance_size = sizeof(TPMState),
>       .instance_init = tpm_tis_initfn,
>       .class_init  = tpm_tis_class_init,
> 

 From the sysbus device PoV the patch looks OK.

You don't need much to remove the RFC tag:

- rename TYPE_TPM_TIS as TYPE_TPM_TIS_ISA
- rename TPMState as TPMCommonState, add an abstract TYPE_TPM_TIS 
parent, let TYPE_TPM_TIS_ISA be a child
- add TYPE_TPM_TIS_SYSBUS also child.


