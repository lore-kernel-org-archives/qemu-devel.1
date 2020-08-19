Return-Path: <SRS0=bVMU=B5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F486C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 03:22:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BAFE207BB
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 03:22:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JVbDfaGp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BAFE207BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48574 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8Eg5-0006eI-Dv
	for qemu-devel@archiver.kernel.org; Tue, 18 Aug 2020 23:22:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53738)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k8EfX-0006E0-Eq
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 23:21:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45501)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k8EfV-0005Vn-DL
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 23:21:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597807300;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=WCqdB9Qnkr42hKUfWl+4Tmh5xtv9ATMtBSs4WdMM8uk=;
 b=JVbDfaGpUHyfllPDH0Vt3ngGZMP3yJWJj+zs9tKPsBTjm07fQFZ71kuMFy0XLmdEdcap5O
 EKQH5YeVoDl4ApUfEURFfLUsmQM1ohNxVKDt/WyIeJPdZPJF3QbG5hapTMGqmOPJz4yIg5
 wBkrIQnzx3rI5oGXVNj2qcYcaRMlXDw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-409-BwBP_tAWMgSGZ4F7GSb4lw-1; Tue, 18 Aug 2020 23:21:38 -0400
X-MC-Unique: BwBP_tAWMgSGZ4F7GSb4lw-1
Received: by mail-wm1-f69.google.com with SMTP id h7so401930wmm.7
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2020 20:21:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=WCqdB9Qnkr42hKUfWl+4Tmh5xtv9ATMtBSs4WdMM8uk=;
 b=o2yOjMaZcNl5IYNkOrwOjJeN9N6+YFd/Eoow2Yax/fvrhDL+VNWth61xfZn4Qh+GWk
 ftPZx50ZcvCL/aynWZxPwPNf80iJUi+tuwINOlLXv9wiPwNoP7qcEkWzKGWoH4DOEhmc
 aUW0ek4k5lRCRlGbkIi+id5730cEi3WyXqnE2hRtPPYBeph+FATmnuEBAVfs7iJM30AP
 u+qNe9iVYgfLiZ9AJ+p0am5fFnQd9SwkMsSJn6Q8mTrb89mbhdubXotMJF8VqAOJmLNN
 Wa137uwsvP+K6EdA5JCaw06J1zVJPW4QuUDTA8T7VKB6rBDgCRg0dR4r1oy6SB1ZS5hg
 E76Q==
X-Gm-Message-State: AOAM531fOHYVKWz1jAy45sEeBx/QhlJcWUYoPU7gI8YuZKd4YEfCrrEi
 mKxGUkg0tfbuZRCGkY7t6MvkSoNWYc8t6YsJuDtLaE3OLVAdSpTQGVqRkaTbB8c1Z9nHNjQVXIS
 WGaYYQ0NUkcQ80sc=
X-Received: by 2002:a7b:c941:: with SMTP id i1mr2662706wml.73.1597807297191;
 Tue, 18 Aug 2020 20:21:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwdEK9b1J9GAilb7xbFKCVZhBEO83hVaLSwyg84DzW15pcLMA3dxSFxExyScI5dSZlP26QbsQ==
X-Received: by 2002:a7b:c941:: with SMTP id i1mr2662692wml.73.1597807296909;
 Tue, 18 Aug 2020 20:21:36 -0700 (PDT)
Received: from [192.168.1.36] (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id g70sm3182291wmg.24.2020.08.18.20.21.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Aug 2020 20:21:36 -0700 (PDT)
Subject: Re: [RFC PATCH v2 2/4] hw/i386/acpi-build: Add ACPI PCI hot-plug
 methods to q35
To: Julia Suvorova <jusual@redhat.com>, qemu-devel@nongnu.org
References: <20200818215227.181654-1-jusual@redhat.com>
 <20200818215227.181654-3-jusual@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Autocrypt: addr=philmd@redhat.com; keydata=
 mQINBDXML8YBEADXCtUkDBKQvNsQA7sDpw6YLE/1tKHwm24A1au9Hfy/OFmkpzo+MD+dYc+7
 bvnqWAeGweq2SDq8zbzFZ1gJBd6+e5v1a/UrTxvwBk51yEkadrpRbi+r2bDpTJwXc/uEtYAB
 GvsTZMtiQVA4kRID1KCdgLa3zztPLCj5H1VZhqZsiGvXa/nMIlhvacRXdbgllPPJ72cLUkXf
 z1Zu4AkEKpccZaJspmLWGSzGu6UTZ7UfVeR2Hcc2KI9oZB1qthmZ1+PZyGZ/Dy+z+zklC0xl
 XIpQPmnfy9+/1hj1LzJ+pe3HzEodtlVA+rdttSvA6nmHKIt8Ul6b/h1DFTmUT1lN1WbAGxmg
 CH1O26cz5nTrzdjoqC/b8PpZiT0kO5MKKgiu5S4PRIxW2+RA4H9nq7nztNZ1Y39bDpzwE5Sp
 bDHzd5owmLxMLZAINtCtQuRbSOcMjZlg4zohA9TQP9krGIk+qTR+H4CV22sWldSkVtsoTaA2
 qNeSJhfHQY0TyQvFbqRsSNIe2gTDzzEQ8itsmdHHE/yzhcCVvlUzXhAT6pIN0OT+cdsTTfif
 MIcDboys92auTuJ7U+4jWF1+WUaJ8gDL69ThAsu7mGDBbm80P3vvUZ4fQM14NkxOnuGRrJxO
 qjWNJ2ZUxgyHAh5TCxMLKWZoL5hpnvx3dF3Ti9HW2dsUUWICSQARAQABtDJQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoUGhpbCkgPHBoaWxtZEByZWRoYXQuY29tPokCVQQTAQgAPwIbDwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4AWIQSJweePYB7obIZ0lcuio/1u3q3A3gUCXsfWwAUJ
 KtymWgAKCRCio/1u3q3A3ircD/9Vjh3aFNJ3uF3hddeoFg1H038wZr/xi8/rX27M1Vj2j9VH
 0B8Olp4KUQw/hyO6kUxqkoojmzRpmzvlpZ0cUiZJo2bQIWnvScyHxFCv33kHe+YEIqoJlaQc
 JfKYlbCoubz+02E2A6bFD9+BvCY0LBbEj5POwyKGiDMjHKCGuzSuDRbCn0Mz4kCa7nFMF5Jv
 piC+JemRdiBd6102ThqgIsyGEBXuf1sy0QIVyXgaqr9O2b/0VoXpQId7yY7OJuYYxs7kQoXI
 6WzSMpmuXGkmfxOgbc/L6YbzB0JOriX0iRClxu4dEUg8Bs2pNnr6huY2Ft+qb41RzCJvvMyu
 gS32LfN0bTZ6Qm2A8ayMtUQgnwZDSO23OKgQWZVglGliY3ezHZ6lVwC24Vjkmq/2yBSLakZE
 6DZUjZzCW1nvtRK05ebyK6tofRsx8xB8pL/kcBb9nCuh70aLR+5cmE41X4O+MVJbwfP5s/RW
 9BFSL3qgXuXso/3XuWTQjJJGgKhB6xXjMmb1J4q/h5IuVV4juv1Fem9sfmyrh+Wi5V1IzKI7
 RPJ3KVb937eBgSENk53P0gUorwzUcO+ASEo3Z1cBKkJSPigDbeEjVfXQMzNt0oDRzpQqH2vp
 apo2jHnidWt8BsckuWZpxcZ9+/9obQ55DyVQHGiTN39hkETy3Emdnz1JVHTU0Q==
Message-ID: <7f29d89e-8cdc-8067-acff-2817183f20f0@redhat.com>
Date: Wed, 19 Aug 2020 05:21:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200818215227.181654-3-jusual@redhat.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/18 23:05:17
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Igor Mammedov <imammedo@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Julia,

On 8/18/20 11:52 PM, Julia Suvorova wrote:
> Implement notifications and gpe to support q35 ACPI PCI hot-plug.
> Use 0xcc4 - 0xcd7 range for 'acpi-pci-hotplug' io ports.
> 
> Signed-off-by: Julia Suvorova <jusual@redhat.com>
> ---
>  include/hw/acpi/pcihp.h |  3 ++-
>  hw/acpi/pcihp.c         | 10 ++++++----
>  hw/acpi/piix4.c         |  2 +-
>  hw/i386/acpi-build.c    | 25 ++++++++++++++-----------
>  4 files changed, 23 insertions(+), 17 deletions(-)
> 
> diff --git a/include/hw/acpi/pcihp.h b/include/hw/acpi/pcihp.h
> index 8bc4a4c01d..1e9d246f57 100644
> --- a/include/hw/acpi/pcihp.h
> +++ b/include/hw/acpi/pcihp.h
> @@ -54,7 +54,8 @@ typedef struct AcpiPciHpState {
>  } AcpiPciHpState;
>  
>  void acpi_pcihp_init(Object *owner, AcpiPciHpState *, PCIBus *root,
> -                     MemoryRegion *address_space_io, bool bridges_enabled);
> +                     MemoryRegion *address_space_io, bool bridges_enabled,
> +                     bool is_piix4);
>  
>  void acpi_pcihp_device_pre_plug_cb(HotplugHandler *hotplug_dev,
>                                     DeviceState *dev, Error **errp);
> diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c
> index 9e31ab2da4..9a35ed6c83 100644
> --- a/hw/acpi/pcihp.c
> +++ b/hw/acpi/pcihp.c
> @@ -38,7 +38,8 @@
>  #include "qom/qom-qobject.h"
>  #include "trace.h"
>  
> -#define ACPI_PCIHP_ADDR 0xae00
> +#define ACPI_PCIHP_ADDR_PIIX4 0xae00
> +#define ACPI_PCIHP_ADDR_Q35 0x0cc4
>  #define ACPI_PCIHP_SIZE 0x0014
>  #define PCI_UP_BASE 0x0000
>  #define PCI_DOWN_BASE 0x0004
> @@ -359,12 +360,13 @@ static const MemoryRegionOps acpi_pcihp_io_ops = {
>  };
>  
>  void acpi_pcihp_init(Object *owner, AcpiPciHpState *s, PCIBus *root_bus,
> -                     MemoryRegion *address_space_io, bool bridges_enabled)
> +                     MemoryRegion *address_space_io, bool bridges_enabled,
> +                     bool is_piix4)

Instead of adding implementation knowledge to this generic function, can
you instead pass it a 'io_base' argument (or 'pcihp_addr')?

>  {
>      s->io_len = ACPI_PCIHP_SIZE;
> -    s->io_base = ACPI_PCIHP_ADDR;
> +    s->io_base = is_piix4 ? ACPI_PCIHP_ADDR_PIIX4 : ACPI_PCIHP_ADDR_Q35;
>  
> -    s->root= root_bus;
> +    s->root = root_bus;
>      s->legacy_piix = !bridges_enabled;
>  
>      memory_region_init_io(&s->io, owner, &acpi_pcihp_io_ops, s,
> diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
> index cdfa0e2998..1f27bfbd06 100644
> --- a/hw/acpi/piix4.c
> +++ b/hw/acpi/piix4.c
> @@ -596,7 +596,7 @@ static void piix4_acpi_system_hot_add_init(MemoryRegion *parent,
>      memory_region_add_subregion(parent, GPE_BASE, &s->io_gpe);
>  
>      acpi_pcihp_init(OBJECT(s), &s->acpi_pci_hotplug, bus, parent,
> -                    s->use_acpi_hotplug_bridge);
> +                    s->use_acpi_hotplug_bridge, true);
>  
>      s->cpu_hotplug_legacy = true;
>      object_property_add_bool(OBJECT(s), "cpu-hotplug-legacy",
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index b7bcbbbb2a..f3cd52bd06 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -201,10 +201,6 @@ static void acpi_get_pm_info(MachineState *machine, AcpiPmInfo *pm)
>          /* w2k requires FADT(rev1) or it won't boot, keep PC compatible */
>          pm->fadt.rev = 1;
>          pm->cpu_hp_io_base = PIIX4_CPU_HOTPLUG_IO_BASE;
> -        pm->pcihp_io_base =
> -            object_property_get_uint(obj, ACPI_PCIHP_IO_BASE_PROP, NULL);
> -        pm->pcihp_io_len =
> -            object_property_get_uint(obj, ACPI_PCIHP_IO_LEN_PROP, NULL);
>      }
>      if (lpc) {
>          struct AcpiGenericAddress r = { .space_id = AML_AS_SYSTEM_IO,
> @@ -214,6 +210,10 @@ static void acpi_get_pm_info(MachineState *machine, AcpiPmInfo *pm)
>          pm->fadt.flags |= 1 << ACPI_FADT_F_RESET_REG_SUP;
>          pm->cpu_hp_io_base = ICH9_CPU_HOTPLUG_IO_BASE;
>      }
> +    pm->pcihp_io_base =
> +        object_property_get_uint(obj, ACPI_PCIHP_IO_BASE_PROP, NULL);
> +    pm->pcihp_io_len =
> +        object_property_get_uint(obj, ACPI_PCIHP_IO_LEN_PROP, NULL);
>  
>      /* The above need not be conditional on machine type because the reset port
>       * happens to be the same on PIIX (pc) and ICH9 (q35). */
> @@ -472,7 +472,7 @@ static void build_append_pci_bus_devices(Aml *parent_scope, PCIBus *bus,
>          QLIST_FOREACH(sec, &bus->child, sibling) {
>              int32_t devfn = sec->parent_dev->devfn;
>  
> -            if (pci_bus_is_root(sec) || pci_bus_is_express(sec)) {
> +            if (pci_bus_is_root(sec)) {

Different patch?

>                  continue;
>              }
>  
> @@ -1368,7 +1368,7 @@ static void build_piix4_isa_bridge(Aml *table)
>      aml_append(table, scope);
>  }
>  
> -static void build_piix4_pci_hotplug(Aml *table)
> +static void build_i386_pci_hotplug(Aml *table, uint64_t pcihp_addr)

Being common to 32/64-bit, I'd name that build_x86_pci_hotplug().

>  {
>      Aml *scope;
>      Aml *field;
> @@ -1377,20 +1377,22 @@ static void build_piix4_pci_hotplug(Aml *table)
>      scope =  aml_scope("_SB.PCI0");
>  
>      aml_append(scope,
> -        aml_operation_region("PCST", AML_SYSTEM_IO, aml_int(0xae00), 0x08));
> +        aml_operation_region("PCST", AML_SYSTEM_IO, aml_int(pcihp_addr), 0x08));
>      field = aml_field("PCST", AML_DWORD_ACC, AML_NOLOCK, AML_WRITE_AS_ZEROS);
>      aml_append(field, aml_named_field("PCIU", 32));
>      aml_append(field, aml_named_field("PCID", 32));
>      aml_append(scope, field);
>  
>      aml_append(scope,
> -        aml_operation_region("SEJ", AML_SYSTEM_IO, aml_int(0xae08), 0x04));
> +    aml_operation_region("SEJ", AML_SYSTEM_IO,
> +                         aml_int(pcihp_addr + 0x08), 0x04));
>      field = aml_field("SEJ", AML_DWORD_ACC, AML_NOLOCK, AML_WRITE_AS_ZEROS);
>      aml_append(field, aml_named_field("B0EJ", 32));
>      aml_append(scope, field);
>  
>      aml_append(scope,
> -        aml_operation_region("BNMR", AML_SYSTEM_IO, aml_int(0xae10), 0x04));
> +        aml_operation_region("BNMR", AML_SYSTEM_IO,
> +                             aml_int(pcihp_addr + 0x10), 0x04));
>      field = aml_field("BNMR", AML_DWORD_ACC, AML_NOLOCK, AML_WRITE_AS_ZEROS);
>      aml_append(field, aml_named_field("BNUM", 32));
>      aml_append(scope, field);
> @@ -1504,7 +1506,6 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>          build_hpet_aml(dsdt);
>          build_piix4_isa_bridge(dsdt);
>          build_isa_devices_aml(dsdt);
> -        build_piix4_pci_hotplug(dsdt);
>          build_piix4_pci0_int(dsdt);
>      } else {
>          sb_scope = aml_scope("_SB");
> @@ -1526,6 +1527,8 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>          }
>      }
>  
> +    build_i386_pci_hotplug(dsdt, pm->pcihp_io_base);
> +
>      if (pcmc->legacy_cpu_hotplug) {
>          build_legacy_cpu_hotplug_aml(dsdt, machine, pm->cpu_hp_io_base);
>      } else {
> @@ -1546,7 +1549,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>      {
>          aml_append(scope, aml_name_decl("_HID", aml_string("ACPI0006")));
>  
> -        if (misc->is_piix4) {
> +        if (misc->is_piix4 || pm->pcihp_bridge_en) {

Why not directly check 'if (pm->pcihp_bridge_en) {'?

>              method = aml_method("_E01", 0, AML_NOTSERIALIZED);
>              aml_append(method,
>                  aml_acquire(aml_name("\\_SB.PCI0.BLCK"), 0xFFFF));
> 

Regards,

Phil.


