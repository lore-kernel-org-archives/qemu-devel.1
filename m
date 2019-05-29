Return-Path: <SRS0=DspQ=T5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2ED8C04AB3
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 04:50:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 924E621734
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 04:50:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oXsZ+hgD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 924E621734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47134 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVqY0-0004wg-Ql
	for qemu-devel@archiver.kernel.org; Wed, 29 May 2019 00:50:44 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49435)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1hVqVW-0003HC-8C
	for qemu-devel@nongnu.org; Wed, 29 May 2019 00:48:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1hVqVV-0001h1-2Y
	for qemu-devel@nongnu.org; Wed, 29 May 2019 00:48:10 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:54949)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1hVqVU-0001fC-PA
	for qemu-devel@nongnu.org; Wed, 29 May 2019 00:48:09 -0400
Received: by mail-wm1-x341.google.com with SMTP id i3so558182wml.4
	for <qemu-devel@nongnu.org>; Tue, 28 May 2019 21:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=subject:to:cc:references:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-transfer-encoding:content-language;
	bh=9T11or+pv9YYvXUaWxLfG3904fBhAVHhrqyBz0z/U2M=;
	b=oXsZ+hgDXIx7Xip9VoSxM30Ka0VD+wqQ4PR6DOIPxnOOnqrQSIBIE/787NVN0ri0FH
	FxdXGE5odniT2+cPkLMsiuJBDdfxLFQPbvKX7k16NeAGNXtaH1nhtWBszJLDXqd8yHJM
	yZ0etOLGI58F9xxRy3Ts+vFWz4mfGDnZ1LxfZU2dLThmNORGWRkIktkDQa/MAkTPrZUv
	4hdYI3QC+myA2rjfUKuWrtFTqm7XNZbiOVdZtdRyOYgzjN20TzmCMv2WJAVPMKwXn1Mm
	QEeQYU623c2fFdXFpkxDBUMrAeK4CYODan8y8Oo/lfhS3VUMyHhP//d4jOAamMM41XCm
	o7Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:message-id:date
	:user-agent:mime-version:in-reply-to:content-transfer-encoding
	:content-language;
	bh=9T11or+pv9YYvXUaWxLfG3904fBhAVHhrqyBz0z/U2M=;
	b=KAXNGiC6ShZYpzZMYkrZa42ydxsH7WHyPiyQWgeBWNUUrMmxAfyUIgYp0DmzDv7Vmt
	/idAQhrteyxts8QZvqaJTQTKTrie+BkDe/F9zBLOCosEUC1bPiLVIT1t1itCtCbrXO5q
	Ydxc7OSGngp1ibUOQ99UWi/NGIINEAzlelkyrm4lOsQC5l0yMHShY7nNXoJd96P9XNwg
	dA5EXDFQSj0uAOb0uUC5EtOucM5IWHHryI8HSgL/wiV1s0GvF0qhnv/YLdInDVUiG0+d
	2H7gzYAYU/SBkONxh4IOU2UKJzUQamntu3TD4vEGC3MkDZ55wr8fOcRYMjV2EUtT+pUS
	YvKw==
X-Gm-Message-State: APjAAAVkdPWElK4sJ4nxszzUQFKnvl4SQRc3b7RmWHZn72y+5xXgZy+h
	THmzHF4pzoKN3juvyXJ1ORU=
X-Google-Smtp-Source: APXvYqz+Kq1Cg+X2MGE7tG5xhQUiN+MdREtfngF4W4f/e4W8zRBQdVzA1cYvDZK45jw+WLlv5o4pdg==
X-Received: by 2002:a1c:228b:: with SMTP id i133mr4378303wmi.140.1559105286592;
	Tue, 28 May 2019 21:48:06 -0700 (PDT)
Received: from localhost.localdomain ([37.142.144.27])
	by smtp.gmail.com with ESMTPSA id z3sm526559wml.28.2019.05.28.21.48.05
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Tue, 28 May 2019 21:48:06 -0700 (PDT)
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
References: <20190528204331.5280-1-kraxel@redhat.com>
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-ID: <016bde36-9476-91c3-0a06-5cd13d317083@gmail.com>
Date: Wed, 29 May 2019 07:48:03 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190528204331.5280-1-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: Re: [Qemu-devel] [PATCH] q35: fix mmconfig and PCI0._CRS
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Eduardo Habkost <ehabkost@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
	Igor Mammedov <imammedo@redhat.com>,
	=?UTF-8?B?TMOhc3psw7Mgw4lyc2Vr?= <lersek@redhat.com>,
	Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Gerd,

On 5/28/19 11:43 PM, Gerd Hoffmann wrote:
> This patch changes the handling of the mmconfig area.  Thanks to the
> pci(e) expander devices we already have the logic to exclude address
> ranges from PCI0._CRS.  We can simply add the mmconfig address range
> to the list get it excluded as well.
>
> With that in place we can go with a fixed pci hole which covers the
> whole area from the end of (low) ram to the ioapic.
>
> This will make the whole logic alot less fragile.  No matter where the
> firmware places the mmconfig xbar, things should work correctly.  The
> guest also gets a bit more PCI address space (seabios boot):
>
>      # cat /proc/iomem
>      [ ... ]
>      7ffdd000-7fffffff : reserved
>      80000000-afffffff : PCI Bus 0000:00            <<-- this is new
>      b0000000-bfffffff : PCI MMCONFIG 0000 [bus 00-ff]
>        b0000000-bfffffff : reserved
>      c0000000-febfffff : PCI Bus 0000:00
>        f8000000-fbffffff : 0000:00:01.0
>      [ ... ]
>
> So this is a guest visible change.

Looks good to me, but shouldn't we use some compat
property to not affect previous machine versions?


Thanks,
Marcel

> Cc: László Érsek <lersek@redhat.com>
> Cc: Igor Mammedov <imammedo@redhat.com>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>   hw/i386/acpi-build.c | 14 ++++++++++++++
>   hw/pci-host/q35.c    | 31 ++++++++-----------------------
>   2 files changed, 22 insertions(+), 23 deletions(-)
>
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 0d78d738948c..abb0e0ce9f27 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -122,6 +122,8 @@ typedef struct FwCfgTPMConfig {
>       uint8_t tpmppi_version;
>   } QEMU_PACKED FwCfgTPMConfig;
>   
> +static bool acpi_get_mcfg(AcpiMcfgInfo *mcfg);
> +
>   static void init_common_fadt_data(Object *o, AcpiFadtData *data)
>   {
>       uint32_t io = object_property_get_uint(o, ACPI_PM_PROP_PM_IO_BASE, NULL);
> @@ -1807,6 +1809,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>       CrsRangeSet crs_range_set;
>       PCMachineState *pcms = PC_MACHINE(machine);
>       PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(machine);
> +    AcpiMcfgInfo mcfg;
>       uint32_t nr_mem = machine->ram_slots;
>       int root_bus_limit = 0xFF;
>       PCIBus *bus = NULL;
> @@ -1921,6 +1924,17 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>           }
>       }
>   
> +    /*
> +     * At this point crs_range_set has all the ranges used by pci
> +     * busses *other* than PCI0.  These ranges will be excluded from
> +     * the PCI0._CRS.  Add mmconfig to the set so it will be excluded
> +     * too.
> +     */
> +    if (acpi_get_mcfg(&mcfg)) {
> +        crs_range_insert(crs_range_set.mem_ranges,
> +                         mcfg.base, mcfg.base + mcfg.size - 1);
> +    }
> +
>       scope = aml_scope("\\_SB.PCI0");
>       /* build PCI0._CRS */
>       crs = aml_resource_template();
> diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
> index 960939f5ed3e..72093320befe 100644
> --- a/hw/pci-host/q35.c
> +++ b/hw/pci-host/q35.c
> @@ -258,15 +258,6 @@ static void q35_host_initfn(Object *obj)
>       object_property_add_link(obj, MCH_HOST_PROP_IO_MEM, TYPE_MEMORY_REGION,
>                                (Object **) &s->mch.address_space_io,
>                                qdev_prop_allow_set_link_before_realize, 0, NULL);
> -
> -    /* Leave enough space for the biggest MCFG BAR */
> -    /* TODO: this matches current bios behaviour, but
> -     * it's not a power of two, which means an MTRR
> -     * can't cover it exactly.
> -     */
> -    range_set_bounds(&s->mch.pci_hole,
> -            MCH_HOST_BRIDGE_PCIEXBAR_DEFAULT + MCH_HOST_BRIDGE_PCIEXBAR_MAX,
> -            IO_APIC_DEFAULT_ADDRESS - 1);
>   }
>   
>   static const TypeInfo q35_host_info = {
> @@ -338,20 +329,6 @@ static void mch_update_pciexbar(MCHPCIState *mch)
>       }
>       addr = pciexbar & addr_mask;
>       pcie_host_mmcfg_update(pehb, enable, addr, length);
> -    /* Leave enough space for the MCFG BAR */
> -    /*
> -     * TODO: this matches current bios behaviour, but it's not a power of two,
> -     * which means an MTRR can't cover it exactly.
> -     */
> -    if (enable) {
> -        range_set_bounds(&mch->pci_hole,
> -                         addr + length,
> -                         IO_APIC_DEFAULT_ADDRESS - 1);
> -    } else {
> -        range_set_bounds(&mch->pci_hole,
> -                         MCH_HOST_BRIDGE_PCIEXBAR_DEFAULT,
> -                         IO_APIC_DEFAULT_ADDRESS - 1);
> -    }
>   }
>   
>   /* PAM */
> @@ -484,6 +461,14 @@ static void mch_update(MCHPCIState *mch)
>       mch_update_pam(mch);
>       mch_update_smram(mch);
>       mch_update_ext_tseg_mbytes(mch);
> +
> +    /*
> +     * pci hole goes from end-of-low-ram to io-apic.
> +     * mmconfig will be excluded by the dsdt builder.
> +     */
> +    range_set_bounds(&mch->pci_hole,
> +                     mch->below_4g_mem_size,
> +                     IO_APIC_DEFAULT_ADDRESS - 1);
>   }
>   
>   static int mch_post_load(void *opaque, int version_id)


