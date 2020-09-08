Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2010C43461
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 14:05:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3ADCB2064B
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 14:05:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IlxgZgXP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3ADCB2064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34090 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFeFv-0001R0-DB
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 10:05:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60364)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kFeFM-0000vo-9M
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 10:05:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:27186)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kFeFJ-0003qM-4T
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 10:05:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599573915;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Xk2XbBNSxUbcV7qo86r4M1Cy4a9QXSbATDzhKi1JYG8=;
 b=IlxgZgXPF/7a5XIcT4Q2PxDpcQSsKs15u3MthsFb/yg4QmWulQpGIypF9CbguPBJfCx+VG
 c4rQcEfWc7ueqeN7KhkjokXIqjgC+xk/XXnS0y9LtDVMYJip2LofD55b1D/s/pHr6P6uwy
 /7QEQI3H3dRPEMt0RsT6mAiMpYCsvvk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-104-2LwYOiWON96yZMq95pOkBQ-1; Tue, 08 Sep 2020 10:04:56 -0400
X-MC-Unique: 2LwYOiWON96yZMq95pOkBQ-1
Received: by mail-wm1-f71.google.com with SMTP id b14so3523892wmj.3
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2020 07:04:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Xk2XbBNSxUbcV7qo86r4M1Cy4a9QXSbATDzhKi1JYG8=;
 b=uIgFCHJtXS8l4NgK+DgWZytWuud0qZ9uqk/7W/lKt8taIMdo41nWoy6EYrOjJARAef
 DVQ3z5T7QsAPbyR8bd09m3+2BcVqcFJxPlC5FfoLArT708rvE+E3PYdioouhlUaQ9NE0
 0a2ObxIlC4PwGAI2BN/tEpqyHAsT8pjopTQ5QDXwk8GbJCRLauy86QB+QJEMSqa2gRVt
 QaRQdupreZbSnWsVkiykXzNd8mOQ8dHsNPCour/YWQ8lAAV49a674zNkP1X50w2b3snZ
 iKyzxtaNL6Q6azOKxrsz6X4wwSI9gDFCE/jQC5MGNOQ7eCtKqJpFDesbIaxQCeLYZZ+F
 66zw==
X-Gm-Message-State: AOAM532PJBIkdYpF1z0pkM9EpmwrfAvzljPALKNXlEt1LL1JXZFG+wCF
 BvGrBXIZgv1JX6RdyDfdyg9Ty9ya2/X74fZxuR12EAph1iRlGYn3N98sKzzDEHCa5ZeHaUSwMVg
 al0uMv08OZrXeuGU=
X-Received: by 2002:adf:8b1d:: with SMTP id n29mr25952854wra.383.1599573895222; 
 Tue, 08 Sep 2020 07:04:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyZPj1pSjcl/Viw0dgqh79dOnYr06m2N5fUeIZgI+DqPpdEv9Xj9YeJzIhkgsihaSxEWH7ooQ==
X-Received: by 2002:adf:8b1d:: with SMTP id n29mr25952828wra.383.1599573895025; 
 Tue, 08 Sep 2020 07:04:55 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-218-236.inter.net.il. [80.230.218.236])
 by smtp.gmail.com with ESMTPSA id
 z83sm26452302wmb.4.2020.09.08.07.04.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2020 07:04:53 -0700 (PDT)
Date: Tue, 8 Sep 2020 10:04:47 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Ani Sinha <ani@anisinha.ca>
Subject: Re: [PATCH] piix4: don't reserve hw resources when hotplug is off
 globally
Message-ID: <20200908100429-mutt-send-email-mst@kernel.org>
References: <20200901094922.25514-1-ani@anisinha.ca>
 <20200901094922.25514-2-ani@anisinha.ca>
MIME-Version: 1.0
In-Reply-To: <20200901094922.25514-2-ani@anisinha.ca>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/08 02:11:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, jusual@redhat.com,
 qemu-devel@nongnu.org, Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Sep 01, 2020 at 03:19:22PM +0530, Ani Sinha wrote:
> When acpi hotplug is turned off for both root pci bus as well as for pci
> bridges, we should not generate the related amls for DSDT table or initialize
> related hw ports or reserve hw resources. This change makes sure all those
> operations are turned off in the case acpi pci hotplug is off globally.
> 
> Signed-off-by: Ani Sinha <ani@anisinha.ca>

Queued. in the future pls do not reply to patch with a new version.

Thanks!

> ---
>  hw/acpi/piix4.c      |  6 ++++--
>  hw/i386/acpi-build.c | 10 ++++++++--
>  2 files changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
> index e6163bb6ce..b70b1f98af 100644
> --- a/hw/acpi/piix4.c
> +++ b/hw/acpi/piix4.c
> @@ -596,8 +596,10 @@ static void piix4_acpi_system_hot_add_init(MemoryRegion *parent,
>                            "acpi-gpe0", GPE_LEN);
>      memory_region_add_subregion(parent, GPE_BASE, &s->io_gpe);
>  
> -    acpi_pcihp_init(OBJECT(s), &s->acpi_pci_hotplug, bus, parent,
> -                    s->use_acpi_hotplug_bridge);
> +    if (s->use_acpi_hotplug_bridge || s->use_acpi_root_pci_hotplug) {
> +        acpi_pcihp_init(OBJECT(s), &s->acpi_pci_hotplug, bus, parent,
> +                        s->use_acpi_hotplug_bridge);
> +    }
>  
>      s->cpu_hotplug_legacy = true;
>      object_property_add_bool(OBJECT(s), "cpu-hotplug-legacy",
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index b7bcbbbb2a..5365b3d290 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -95,6 +95,7 @@ typedef struct AcpiPmInfo {
>      bool s3_disabled;
>      bool s4_disabled;
>      bool pcihp_bridge_en;
> +    bool pcihp_root_en;
>      uint8_t s4_val;
>      AcpiFadtData fadt;
>      uint16_t cpu_hp_io_base;
> @@ -245,6 +246,9 @@ static void acpi_get_pm_info(MachineState *machine, AcpiPmInfo *pm)
>      pm->pcihp_bridge_en =
>          object_property_get_bool(obj, "acpi-pci-hotplug-with-bridge-support",
>                                   NULL);
> +    pm->pcihp_root_en =
> +        object_property_get_bool(obj, "acpi-root-pci-hotplug",
> +                                 NULL);
>  }
>  
>  static void acpi_get_misc_info(AcpiMiscInfo *info)
> @@ -1504,7 +1508,9 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>          build_hpet_aml(dsdt);
>          build_piix4_isa_bridge(dsdt);
>          build_isa_devices_aml(dsdt);
> -        build_piix4_pci_hotplug(dsdt);
> +        if (pm->pcihp_bridge_en || pm->pcihp_root_en) {
> +            build_piix4_pci_hotplug(dsdt);
> +        }
>          build_piix4_pci0_int(dsdt);
>      } else {
>          sb_scope = aml_scope("_SB");
> @@ -1698,7 +1704,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>      crs_range_set_free(&crs_range_set);
>  
>      /* reserve PCIHP resources */
> -    if (pm->pcihp_io_len) {
> +    if (pm->pcihp_io_len && (pm->pcihp_bridge_en || pm->pcihp_root_en)) {
>          dev = aml_device("PHPR");
>          aml_append(dev, aml_name_decl("_HID", aml_string("PNP0A06")));
>          aml_append(dev,
> -- 
> 2.17.1


