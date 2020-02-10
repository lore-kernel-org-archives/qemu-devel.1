Return-Path: <SRS0=Q7uJ=36=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E865C352A5
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 13:22:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F24D22080C
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2020 13:22:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YPCqj7Pf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F24D22080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33558 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j190w-0001Rj-7s
	for qemu-devel@archiver.kernel.org; Mon, 10 Feb 2020 08:22:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46804)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j1906-0000sB-AA
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 08:21:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j1904-0001WS-DD
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 08:21:21 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60268
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j1904-0001W6-9D
 for qemu-devel@nongnu.org; Mon, 10 Feb 2020 08:21:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581340879;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+8OW1EFn61CO27BhjMM/IS2SeGaQnZzx15yEHVpS3l8=;
 b=YPCqj7Pf3FHYZ8+a0W9ZsmcEWJkBz9e0YNkEfYe5sVrOoG2s3mKhjqc7aTOVaYzF48ECM2
 FwW8S+apz7iZVAoQ/XY6ricVXwkGQzPNhsFFCY7zu1Lznqov1B0TIqhL6E9iAuJ/Xbe1F5
 83fRHABidqaAMeonUKOJDFBPGXeFnXc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-229-avfUp4F4NH-QJzjERiE3bg-1; Mon, 10 Feb 2020 08:21:15 -0500
Received: by mail-wr1-f72.google.com with SMTP id t3so4940581wrm.23
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2020 05:21:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=+8OW1EFn61CO27BhjMM/IS2SeGaQnZzx15yEHVpS3l8=;
 b=LDfgTRyFzUVFNhMcQmNc+FyZDUH53sgNnhCM6tA0lVv0uMqTGvF7mNhXUIW01udM51
 idtvFFV22g8nGxU2SUqTF+RfcyIRmNilC89aJb67PoKnU8K5xgo8ZSzoQUMPOy3JrImT
 xW6jhFkLjR/W8qcnQ9uPioTWnMRyGO0taYY8WOwq9Gsry3ue2YnVd4r6b1uF/xa+4Rnz
 apgQNysSQFdasiAZzYZn16qXbDephbp7BugUG066lgQIqMS98aPVTv+xRdZ/XHjaWhkv
 us2ld9vSJF6XmbPR2YgZCktqwuxebjDw5J7Audq1+yctJ0cICwTzwlorD4DbeunknqX4
 3nPA==
X-Gm-Message-State: APjAAAX0whbvz6edHfHvsTJYlG9MdIJqFo09EfGkQiq4ZxCWaX4YTA9O
 JCSa11HMs5eZ1sSUrphNQCqKZ5M5SL+rr7la9VAKelXnQUU+WQKeeequ9ztd01h6usOYUgtDcsg
 t6ttP4J/NQ1Ub8WM=
X-Received: by 2002:adf:d4ca:: with SMTP id w10mr2110482wrk.53.1581340874521; 
 Mon, 10 Feb 2020 05:21:14 -0800 (PST)
X-Google-Smtp-Source: APXvYqwx0mH3hXWEqgLcEbE8oyqP88Wedhks/4AbfkVwVP3jNjn/0f4o4g6JnPVHH8a2KfwlHCtPbA==
X-Received: by 2002:adf:d4ca:: with SMTP id w10mr2110469wrk.53.1581340874315; 
 Mon, 10 Feb 2020 05:21:14 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id c9sm542442wme.41.2020.02.10.05.21.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Feb 2020 05:21:13 -0800 (PST)
Subject: Re: [RFC 2/2] hw/arm/virt: vTPM support
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 stefanb@linux.ibm.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 peter.maydell@linaro.org
References: <20200210131523.27540-1-eric.auger@redhat.com>
 <20200210131523.27540-3-eric.auger@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <3085a956-8a2e-4f0a-35a9-68878274d852@redhat.com>
Date: Mon, 10 Feb 2020 14:21:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200210131523.27540-3-eric.auger@redhat.com>
Content-Language: en-US
X-MC-Unique: avfUp4F4NH-QJzjERiE3bg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: marcandre.lureau@redhat.com, lersek@redhat.com, ardb@kernel.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/10/20 2:15 PM, Eric Auger wrote:
> Let the TPM TIS device be dynamically instantiable in ARM virt.
> A device tree node is dynamically created (TPM via MMIO).
> 
> The TPM Physical Presence interface (PPI) is not supported.
> 
> To run with the swtmp TPM emulator, the qemu command line must
> be augmented with:
> 
>          -chardev socket,id=chrtpm,path=swtpm-sock \
>          -tpmdev emulator,id=tpm0,chardev=chrtpm \
>          -device tpm-tis,tpmdev=tpm0 \
> 
> swtpm/libtpms command line example:
> 
> swtpm socket --tpm2 -t -d --tpmstate dir=/tmp/tpm \
> --ctrl type=unixio,path=swtpm-sock
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>   hw/arm/Kconfig      |  1 +
>   hw/arm/sysbus-fdt.c | 36 ++++++++++++++++++++++++++++++++++++
>   hw/arm/virt.c       |  7 +++++++
>   3 files changed, 44 insertions(+)
> 
> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> index 3d86691ae0..ce0852f148 100644
> --- a/hw/arm/Kconfig
> +++ b/hw/arm/Kconfig
> @@ -5,6 +5,7 @@ config ARM_VIRT
>       imply VFIO_AMD_XGBE
>       imply VFIO_PLATFORM
>       imply VFIO_XGMAC
> +    imply TPM_TIS
>       select A15MPCORE
>       select ACPI
>       select ARM_SMMUV3
> diff --git a/hw/arm/sysbus-fdt.c b/hw/arm/sysbus-fdt.c
> index 022fc97ecd..d723fad6ba 100644
> --- a/hw/arm/sysbus-fdt.c
> +++ b/hw/arm/sysbus-fdt.c
> @@ -30,6 +30,7 @@
>   #include "hw/arm/sysbus-fdt.h"
>   #include "qemu/error-report.h"
>   #include "sysemu/device_tree.h"
> +#include "sysemu/tpm.h"
>   #include "hw/platform-bus.h"
>   #include "hw/vfio/vfio-platform.h"
>   #include "hw/vfio/vfio-calxeda-xgmac.h"
> @@ -434,6 +435,40 @@ static bool vfio_platform_match(SysBusDevice *sbdev,
>   #define VFIO_PLATFORM_BINDING(compat, add_fn) \
>       {TYPE_VFIO_PLATFORM, (compat), (add_fn), vfio_platform_match}
>   
> +/*
> + * add_tpm_tis_fdt_node: Create a DT node for TPM TIS
> + *
> + * See kernel documentation:
> + * Documentation/devicetree/bindings/security/tpm/tpm_tis_mmio.txt
> + * Optional interrupt for command completion is not exposed
> + */
> +static int add_tpm_tis_fdt_node(SysBusDevice *sbdev, void *opaque)
> +{
> +    PlatformBusFDTData *data = opaque;
> +    PlatformBusDevice *pbus = data->pbus;
> +    void *fdt = data->fdt;
> +    const char *parent_node = data->pbus_node_name;
> +    int compat_str_len;
> +    char *nodename;
> +    uint32_t reg_attr[2];
> +    uint64_t mmio_base;
> +
> +    mmio_base = platform_bus_get_mmio_addr(pbus, sbdev, 0);
> +    nodename = g_strdup_printf("%s/tpm_tis@%" PRIx64, parent_node, mmio_base);
> +    qemu_fdt_add_subnode(fdt, nodename);
> +
> +    compat_str_len = strlen("tcg,tpm-tis-mmio") + 1;
> +    qemu_fdt_setprop(fdt, nodename, "compatible", "tcg,tpm-tis-mmio",
> +                     compat_str_len);
> +
> +    reg_attr[0] = cpu_to_be32(mmio_base);
> +    reg_attr[1] = cpu_to_be32(0x5000);
> +    qemu_fdt_setprop(fdt, nodename, "reg", reg_attr, 2 * sizeof(uint32_t));
> +
> +    g_free(nodename);
> +    return 0;
> +}

I don't know well the policy with virt and fdt_node, but this patch LGTM.

> +
>   #endif /* CONFIG_LINUX */
>   
>   static int no_fdt_node(SysBusDevice *sbdev, void *opaque)
> @@ -455,6 +490,7 @@ static const BindingEntry bindings[] = {
>       TYPE_BINDING(TYPE_VFIO_CALXEDA_XGMAC, add_calxeda_midway_xgmac_fdt_node),
>       TYPE_BINDING(TYPE_VFIO_AMD_XGBE, add_amd_xgbe_fdt_node),
>       VFIO_PLATFORM_BINDING("amd,xgbe-seattle-v1a", add_amd_xgbe_fdt_node),
> +    TYPE_BINDING(TYPE_TPM_TIS, add_tpm_tis_fdt_node),
>   #endif
>       TYPE_BINDING(TYPE_RAMFB_DEVICE, no_fdt_node),
>       TYPE_BINDING("", NULL), /* last element */
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index f788fe27d6..1bb34dfa0b 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -47,6 +47,7 @@
>   #include "sysemu/numa.h"
>   #include "sysemu/runstate.h"
>   #include "sysemu/sysemu.h"
> +#include "sysemu/tpm.h"
>   #include "sysemu/kvm.h"
>   #include "hw/loader.h"
>   #include "exec/address-spaces.h"
> @@ -2041,6 +2042,7 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
>       machine_class_allow_dynamic_sysbus_dev(mc, TYPE_VFIO_AMD_XGBE);
>       machine_class_allow_dynamic_sysbus_dev(mc, TYPE_RAMFB_DEVICE);
>       machine_class_allow_dynamic_sysbus_dev(mc, TYPE_VFIO_PLATFORM);
> +    machine_class_allow_dynamic_sysbus_dev(mc, TYPE_TPM_TIS);
>       mc->block_default_type = IF_VIRTIO;
>       mc->no_cdrom = 1;
>       mc->pci_allow_0_address = true;
> @@ -2153,6 +2155,11 @@ type_init(machvirt_machine_init);
>   
>   static void virt_machine_5_0_options(MachineClass *mc)
>   {
> +    static GlobalProperty compat[] = {
> +        { TYPE_TPM_TIS, "ppi", "false" },
> +    };
> +
> +    compat_props_add(mc->compat_props, compat, G_N_ELEMENTS(compat));
>   }
>   DEFINE_VIRT_MACHINE_AS_LATEST(5, 0)
>   
> 


