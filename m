Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4E65C47254
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 13:54:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AD54206A5
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 13:54:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MZRqGkwW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AD54206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52146 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVy25-0002fy-F6
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 09:54:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52280)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jVy18-0001Wt-TJ
 for qemu-devel@nongnu.org; Tue, 05 May 2020 09:53:50 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:55075
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jVy17-0006P9-Sy
 for qemu-devel@nongnu.org; Tue, 05 May 2020 09:53:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588686829;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oRKQNoymqyeMLRPHV9Rl9KLM6lbODu/nGz3zPL9H8pE=;
 b=MZRqGkwWJgzfGoD25AMLI9rbDvBPZ+mY4Pu2xud7UZOjgTz8Csyn6rD37JsO0q0ODVlVNH
 HFCi76vy1ncN7ra0Rw4GqSG8UV/CYMDC119L4rMV/IcdmdDuYseUxwrMzMIzDB3x4+Z8tq
 05U5GoXyU9/qrtg2HQ9MU0SZ0o41UdY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-183-BnoYPkupOoSj3vZyybHkvw-1; Tue, 05 May 2020 09:53:47 -0400
X-MC-Unique: BnoYPkupOoSj3vZyybHkvw-1
Received: by mail-wm1-f72.google.com with SMTP id t62so1098136wma.0
 for <qemu-devel@nongnu.org>; Tue, 05 May 2020 06:53:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=oRKQNoymqyeMLRPHV9Rl9KLM6lbODu/nGz3zPL9H8pE=;
 b=L3Ef3g4NeFBUKz0XqHfrXt5aXdGwikc7HvhDZdf8zJ27yWjoeEvoSY0YjEe7uMUkcB
 cfwUKr0IugACz1ZT9vEUv1owC2PZr7i2jKZXwgTCO06/QaY5fNF3O7E8l8xzZbXyIAAZ
 +NBjDVxIHm136YfWraQ7pDjkVorEMw7pv0bdQD8SDxwHYkwaMpp5Mqu8M1VX5P1LcXVw
 +SZylwV7fNbuflfviaCzIDW/77ecsqTb+cJwUq/JoHn7ffdFNmLjw9QSzxX8BZNlCyt2
 DXSr+DTSlDgCWss0lQxLMiItvlGp9ld9mHuDeY+M5ekHQ4BourtWVsiSeNXG/lzlHANw
 FahA==
X-Gm-Message-State: AGi0PubN83kD1ZnhwM7UdaFJzQ5KMmkRqkqPVOzRSYyPMGeZZTq31JZH
 eLELbPSBaWoCBvbt8rFAHd9gkQCM5ljZkLDBsH5nnGf6oG7ebb79A4rXQDkHcBVDc4dMKa0k9sK
 x7coWMDANzXmHXas=
X-Received: by 2002:adf:f1ca:: with SMTP id z10mr3933260wro.121.1588686825715; 
 Tue, 05 May 2020 06:53:45 -0700 (PDT)
X-Google-Smtp-Source: APiQypKAAdkTJOM6ioBnpu/ikTlhZKqagKuS+C+yKanrGEILBzpzvIY9ccgn5Vk8H6oCbQGbO/yNLQ==
X-Received: by 2002:adf:f1ca:: with SMTP id z10mr3933230wro.121.1588686825461; 
 Tue, 05 May 2020 06:53:45 -0700 (PDT)
Received: from [192.168.1.38] (26.red-88-21-207.staticip.rima-tde.net.
 [88.21.207.26])
 by smtp.gmail.com with ESMTPSA id w11sm3808499wmi.32.2020.05.05.06.53.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 May 2020 06:53:44 -0700 (PDT)
Subject: Re: [PATCH v2 06/13] acpi: move acpi_align_size to acpi-common.h
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
References: <20200505134305.22666-1-kraxel@redhat.com>
 <20200505134305.22666-7-kraxel@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <44e3f7e9-f82e-ee4c-49b9-8fa8349b7168@redhat.com>
Date: Tue, 5 May 2020 15:53:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200505134305.22666-7-kraxel@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/05 00:37:19
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Sergio Lopez <slp@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Gerd,

On 5/5/20 3:42 PM, Gerd Hoffmann wrote:
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>   hw/i386/acpi-common.h | 19 +++++++++++++++++++
>   hw/i386/acpi-build.c  | 18 ------------------
>   2 files changed, 19 insertions(+), 18 deletions(-)
> 
> diff --git a/hw/i386/acpi-common.h b/hw/i386/acpi-common.h
> index 5788a13da9ca..f837bb17163b 100644
> --- a/hw/i386/acpi-common.h
> +++ b/hw/i386/acpi-common.h
> @@ -3,12 +3,31 @@
>   
>   #include "include/hw/acpi/acpi-defs.h"
>   #include "include/hw/acpi/acpi_dev_interface.h"
> +#include "include/hw/acpi/aml-build.h"
>   #include "include/hw/acpi/bios-linker-loader.h"
>   #include "include/hw/i386/x86.h"
>   
> +/* These are used to size the ACPI tables for -M pc-i440fx-1.7 and
> + * -M pc-i440fx-2.0.  Even if the actual amount of AML generated grows
> + * a little bit, there should be plenty of free space since the DSDT
> + * shrunk by ~1.5k between QEMU 2.0 and QEMU 2.1.
> + */
> +#define ACPI_BUILD_LEGACY_CPU_AML_SIZE    97
> +#define ACPI_BUILD_ALIGN_SIZE             0x1000
> +
> +#define ACPI_BUILD_TABLE_SIZE             0x20000
> +
>   /* Default IOAPIC ID */
>   #define ACPI_BUILD_IOAPIC_ID 0x0
>   
> +static inline void acpi_align_size(GArray *blob, unsigned align)
> +{
> +    /* Align size to multiple of given size. This reduces the chance
> +     * we need to change size in the future (breaking cross version migration).
> +     */
> +    g_array_set_size(blob, ROUND_UP(acpi_data_len(blob), align));
> +}
> +
>   void acpi_build_madt(GArray *table_data, BIOSLinker *linker,
>                        X86MachineState *x86ms, AcpiDeviceIf *adev,
>                        bool has_pci);
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index d1f14394734e..dc3b62468439 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -72,16 +72,6 @@
>   #include "hw/acpi/ipmi.h"
>   #include "hw/acpi/hmat.h"
>   
> -/* These are used to size the ACPI tables for -M pc-i440fx-1.7 and
> - * -M pc-i440fx-2.0.  Even if the actual amount of AML generated grows
> - * a little bit, there should be plenty of free space since the DSDT
> - * shrunk by ~1.5k between QEMU 2.0 and QEMU 2.1.
> - */
> -#define ACPI_BUILD_LEGACY_CPU_AML_SIZE    97

Can we keep the ACPI_BUILD_LEGACY_CPU_AML_SIZE definition in this file?
The rest of the patch is OK.

> -#define ACPI_BUILD_ALIGN_SIZE             0x1000
> -
> -#define ACPI_BUILD_TABLE_SIZE             0x20000
> -
>   /* #define DEBUG_ACPI_BUILD */
>   #ifdef DEBUG_ACPI_BUILD
>   #define ACPI_BUILD_DPRINTF(fmt, ...)        \
> @@ -267,14 +257,6 @@ static void acpi_get_pci_holes(Range *hole, Range *hole64)
>                                                  NULL));
>   }
>   
> -static void acpi_align_size(GArray *blob, unsigned align)
> -{
> -    /* Align size to multiple of given size. This reduces the chance
> -     * we need to change size in the future (breaking cross version migration).
> -     */
> -    g_array_set_size(blob, ROUND_UP(acpi_data_len(blob), align));
> -}
> -
>   static void build_append_pcihp_notify_entry(Aml *method, int slot)
>   {
>       Aml *if_ctx;
> 


