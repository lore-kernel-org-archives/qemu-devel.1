Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2FC0C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 13:37:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3A1C207D8
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 13:37:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XSm3FzJD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3A1C207D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44786 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbOuK-0002Tb-Tf
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 09:37:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49530)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jbOpU-0000tN-71
 for qemu-devel@nongnu.org; Wed, 20 May 2020 09:32:16 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:53464
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jbOpT-0002aw-C5
 for qemu-devel@nongnu.org; Wed, 20 May 2020 09:32:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589981534;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fCyAzxAOvggDxdNU7q6XGwmnRFKgfQxhx2IQxbS8bgw=;
 b=XSm3FzJD7D99uqR/Xe+zEW7Nv+/J7xtbxWQGOwY2y3tcMWkDX8HOfrVZ3y7lndjH7CWm8U
 PROoczw6bKaDYGdYaort46TmPJJ7c9WzY6uSRWo97ZG6PHDpAEwlb0yjW5sdtC/8jaQVwW
 BmPZdeXYzQY5+CPcL/PcCqYXM9fyCqo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-82-qS4XuGgaNLaalJ2h6o2Tmg-1; Wed, 20 May 2020 09:32:13 -0400
X-MC-Unique: qS4XuGgaNLaalJ2h6o2Tmg-1
Received: by mail-wm1-f70.google.com with SMTP id o8so30402wmd.0
 for <qemu-devel@nongnu.org>; Wed, 20 May 2020 06:32:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=fCyAzxAOvggDxdNU7q6XGwmnRFKgfQxhx2IQxbS8bgw=;
 b=ZfU7TINrbklEeDPc3T6dHS4qorfvUpPNAvG1JdJ7kN8xC3gtTXbl7/MS7lxtzGSQ70
 MkagE8hjOo3cvNlpwxXjUnvHXHFcsCqn7a96gNR5pXrTgIGfQaIzM81f2rij+YC9NHzW
 ncKHfWtwdhlIre5Efp3P8AwQlOHnefWj2Hu+cEeNFLoqr0/Lu7IapnGLO2RBLy2NT0Vp
 WxwZh3T/0SmitHNhNXQXhWoBbz2sBKp9eBXrk6IRwBGuvHMMJ1Fh93TyyU4VltEkbuVv
 lFv+HI6k8C/7705rASkZbehtcEhFEdg80xMMbwTgBSxg00fNzwRNHur7A1SReIwyfqqK
 6JZg==
X-Gm-Message-State: AOAM531zuU6pfgSTC3XsSi0Hca7A/4AM69zZzCY8Sj/5Z2sAJkbBZe6B
 DtsxaUDZPVRsJIXUOtxLaOwQtlFr4J9OL6aK/ajZlVC939iao7/03huSRdacnzDNNFu8iSOXyhF
 4or1UH+j8pQuu38k=
X-Received: by 2002:adf:8403:: with SMTP id 3mr4046967wrf.186.1589981530853;
 Wed, 20 May 2020 06:32:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJykOZWz6wkdIfogemCZrf0HzDRVmJhENyA8IK0qGjFaFdqzRNTO/qEx5SQM4rJ1zKKl3Dbd2g==
X-Received: by 2002:adf:8403:: with SMTP id 3mr4046948wrf.186.1589981530614;
 Wed, 20 May 2020 06:32:10 -0700 (PDT)
Received: from [192.168.1.38] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id d6sm3207283wra.63.2020.05.20.06.32.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 May 2020 06:32:09 -0700 (PDT)
Subject: Re: [PATCH v3 12/22] acpi: move acpi_dsdt_add_power_button() to ged
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
References: <20200520132003.9492-1-kraxel@redhat.com>
 <20200520132003.9492-13-kraxel@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <93396c96-32a1-b10c-be24-64b79466b420@redhat.com>
Date: Wed, 20 May 2020 15:32:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200520132003.9492-13-kraxel@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/20 02:22:41
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Sergio Lopez <slp@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Shannon Zhao <shannon.zhaosl@gmail.com>,
 qemu-arm@nongnu.org, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/20/20 3:19 PM, Gerd Hoffmann wrote:
> Allow reuse for microvm.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>   include/hw/acpi/generic_event_device.h | 1 +
>   hw/acpi/generic_event_device.c         | 8 ++++++++
>   hw/arm/virt-acpi-build.c               | 8 --------
>   3 files changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/include/hw/acpi/generic_event_device.h b/include/hw/acpi/generic_event_device.h
> index 9687cb524258..ebed1ffe4231 100644
> --- a/include/hw/acpi/generic_event_device.h
> +++ b/include/hw/acpi/generic_event_device.h
> @@ -113,5 +113,6 @@ typedef struct AcpiGedState {
>   
>   void build_ged_aml(Aml *table, const char* name, HotplugHandler *hotplug_dev,
>                      uint32_t ged_irq, AmlRegionSpace rs, hwaddr ged_base);
> +void acpi_dsdt_add_power_button(Aml *scope);
>   
>   #endif
> diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
> index 3072fb4ab32b..cde50da5b3ca 100644
> --- a/hw/acpi/generic_event_device.c
> +++ b/hw/acpi/generic_event_device.c
> @@ -142,6 +142,14 @@ void build_ged_aml(Aml *table, const char *name, HotplugHandler *hotplug_dev,
>       aml_append(table, dev);
>   }
>   
> +void acpi_dsdt_add_power_button(Aml *scope)
> +{
> +    Aml *dev = aml_device(ACPI_POWER_BUTTON_DEVICE);
> +    aml_append(dev, aml_name_decl("_HID", aml_string("PNP0C0C")));
> +    aml_append(dev, aml_name_decl("_UID", aml_int(0)));
> +    aml_append(scope, dev);
> +}
> +
>   /* Memory read by the GED _EVT AML dynamic method */
>   static uint64_t ged_evt_read(void *opaque, hwaddr addr, unsigned size)
>   {
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index 1b0a584c7b62..49eacc622219 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -354,14 +354,6 @@ static void acpi_dsdt_add_gpio(Aml *scope, const MemMapEntry *gpio_memmap,
>       aml_append(scope, dev);
>   }
>   
> -static void acpi_dsdt_add_power_button(Aml *scope)
> -{
> -    Aml *dev = aml_device(ACPI_POWER_BUTTON_DEVICE);
> -    aml_append(dev, aml_name_decl("_HID", aml_string("PNP0C0C")));
> -    aml_append(dev, aml_name_decl("_UID", aml_int(0)));
> -    aml_append(scope, dev);
> -}
> -
>   static void
>   build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>   {
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>


