Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58845C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 16:25:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23A3F206DC
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 16:25:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ItApGjCZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23A3F206DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45264 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgsgm-00058E-FC
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 12:25:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51644)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jgseB-00023c-Jf
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 12:23:15 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:26721
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jgseA-0007hi-Hz
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 12:23:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591287793;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B9O2XRCyHbxIKDpgPXguyD8DdCt9q+W4Q9datrk8x4s=;
 b=ItApGjCZH0NMikyQeVk5tCc3wuXuo4QXBNvsyGVc16gRrax8ByWAo3hH+x+uVm93EfH254
 2cwv0ZRACG8tylIwwAKlc0B04J5fz884Jh2AT8+dbOjzDna1K+IJRl1fCNGdpcrE9ww9wg
 heTUoQoDaVFhrM700z4yiXkEypo7B1o=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-477-JD2cD8bFNEyy8FigLon6LA-1; Thu, 04 Jun 2020 12:23:11 -0400
X-MC-Unique: JD2cD8bFNEyy8FigLon6LA-1
Received: by mail-wr1-f70.google.com with SMTP id o1so2608079wrm.17
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2020 09:23:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=B9O2XRCyHbxIKDpgPXguyD8DdCt9q+W4Q9datrk8x4s=;
 b=JMmEZN79HxB4wx+ilGIbZeavYBv+uxU5SfPWu8476jeRgMzxBLXLcuEy0pMn+g3XGU
 OSh3+kMv4skiFi1yxGPhvy3NRfjab7zzHRand/IFEdIbUJ2ThVUdddKo3oG3SgHzHHYR
 xZNEILM1QBfjsT/4VFHM1laQh5Ugx5QuKiEclJqbc9e4jGx49Z4/5PU/koIyI3J4O9tn
 /sYnALsNuuNVlJPyc3dmtlnpdEABiF5ZeVpRpa1TtF++FsROMzlQDANq6H6KaVY32940
 2rBFrb98OphXv6MTAS/Jrs8PziOIo7kCYOvUyoCSP65FLu+vG+zmaJdfkcJ3fIirOH1M
 LYWA==
X-Gm-Message-State: AOAM531UKNQX93uQfGs4A3Oq/8P2fRxVh6qLHLuRzMyXaA957NdMylxL
 +bY/oXB6uHCOD557fLyftpKyxqxchk36dk6gQIt3lujes9I6FCgCqzxYnNCmWqf+65PgwPXrjEp
 4d+Pgeb6LaQCgrzg=
X-Received: by 2002:a1c:a906:: with SMTP id s6mr4990768wme.171.1591287790592; 
 Thu, 04 Jun 2020 09:23:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJycKqtmToIFUJXoVJkBh8yjxsCrh0nHVi0wwyICMooJNi/z+/a+wLrtUjUmghlHzqr7a90aQA==
X-Received: by 2002:a1c:a906:: with SMTP id s6mr4990745wme.171.1591287790313; 
 Thu, 04 Jun 2020 09:23:10 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:a0c0:5d2e:1d35:17bb?
 ([2001:b07:6468:f312:a0c0:5d2e:1d35:17bb])
 by smtp.gmail.com with ESMTPSA id p1sm8323048wrx.44.2020.06.04.09.23.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Jun 2020 09:23:09 -0700 (PDT)
Subject: Re: [PATCH v4] xen: fix build without pci passthrough
To: Anthony PERARD <anthony.perard@citrix.com>, qemu-devel@nongnu.org
References: <159120627656.23398.3742621530752770397@45ef0f9c86ae>
 <20200604133042.3380585-1-anthony.perard@citrix.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b822be29-66ce-fb68-849b-af0a8e1e7174@redhat.com>
Date: Thu, 4 Jun 2020 18:23:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200604133042.3380585-1-anthony.perard@citrix.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/04 01:31:23
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Paul Durrant <paul@xen.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, xen-devel@lists.xenproject.org,
 =?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 04/06/20 15:30, Anthony PERARD wrote:
>     - fix build when Xen headers aren't available.
>       By building stubs/xen-pt.c only when CONFIG_XEN=y
>       (The alternative would be to move the prototypes used by the stub into
>       xen.h, which doesn't depends on xen headers.)

Good catch.  I think we can also drop the whole hw/xen/ directory when
CONFIG_XEN=n, and move stubs/xen-pt.c there.  I'll send a v5 myself.

Paolo

>     Changes in v3:
>     - reworked to use stubs instead of #ifdef CONFIG_XEN_PCI_PASSTHROUGH
>       CONFIG_XEN_PCI_PASSTHROUGH isn't available in xen-common.c
>     
>       moving CONFIG_XEN_PCI_PASSTHROUGH to be in config_host_mak isn't
>       really possible, or at least I didn't managed to make that work.
> 
>  hw/i386/pc_piix.c   |  2 +-
>  hw/xen/xen-common.c |  4 ++--
>  hw/xen/xen_pt.c     | 12 +++++++++++-
>  hw/xen/xen_pt.h     |  6 ++++--
>  stubs/Makefile.objs |  1 +
>  stubs/xen-pt.c      | 22 ++++++++++++++++++++++
>  6 files changed, 41 insertions(+), 6 deletions(-)
>  create mode 100644 stubs/xen-pt.c
> 
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index f66e1d73ce0b..347fb8c6c807 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -375,7 +375,7 @@ static void pc_init_isa(MachineState *machine)
>  #ifdef CONFIG_XEN
>  static void pc_xen_hvm_init_pci(MachineState *machine)
>  {
> -    const char *pci_type = has_igd_gfx_passthru ?
> +    const char *pci_type = xen_igd_gfx_pt_enabled() ?
>                  TYPE_IGD_PASSTHROUGH_I440FX_PCI_DEVICE : TYPE_I440FX_PCI_DEVICE;
>  
>      pc_init1(machine,
> diff --git a/hw/xen/xen-common.c b/hw/xen/xen-common.c
> index 70564cc952d5..dd2c22cc4c0b 100644
> --- a/hw/xen/xen-common.c
> +++ b/hw/xen/xen-common.c
> @@ -129,12 +129,12 @@ static void xen_change_state_handler(void *opaque, int running,
>  
>  static bool xen_get_igd_gfx_passthru(Object *obj, Error **errp)
>  {
> -    return has_igd_gfx_passthru;
> +    return xen_igd_gfx_pt_enabled();
>  }
>  
>  static void xen_set_igd_gfx_passthru(Object *obj, bool value, Error **errp)
>  {
> -    has_igd_gfx_passthru = value;
> +    xen_igd_gfx_pt_set(value, errp);
>  }
>  
>  static void xen_setup_post(MachineState *ms, AccelState *accel)
> diff --git a/hw/xen/xen_pt.c b/hw/xen/xen_pt.c
> index 81d5ad8da7f0..ab84443d5ec8 100644
> --- a/hw/xen/xen_pt.c
> +++ b/hw/xen/xen_pt.c
> @@ -65,7 +65,17 @@
>  #include "qemu/range.h"
>  #include "exec/address-spaces.h"
>  
> -bool has_igd_gfx_passthru;
> +static bool has_igd_gfx_passthru;
> +
> +bool xen_igd_gfx_pt_enabled(void)
> +{
> +    return has_igd_gfx_passthru;
> +}
> +
> +void xen_igd_gfx_pt_set(bool value, Error **errp)
> +{
> +    has_igd_gfx_passthru = value;
> +}
>  
>  #define XEN_PT_NR_IRQS (256)
>  static uint8_t xen_pt_mapped_machine_irq[XEN_PT_NR_IRQS] = {0};
> diff --git a/hw/xen/xen_pt.h b/hw/xen/xen_pt.h
> index 179775db7b22..6e9cec95f3b7 100644
> --- a/hw/xen/xen_pt.h
> +++ b/hw/xen/xen_pt.h
> @@ -5,6 +5,9 @@
>  #include "hw/pci/pci.h"
>  #include "xen-host-pci-device.h"
>  
> +bool xen_igd_gfx_pt_enabled(void);
> +void xen_igd_gfx_pt_set(bool value, Error **errp);
> +
>  void xen_pt_log(const PCIDevice *d, const char *f, ...) GCC_FMT_ATTR(2, 3);
>  
>  #define XEN_PT_ERR(d, _f, _a...) xen_pt_log(d, "%s: Error: "_f, __func__, ##_a)
> @@ -322,10 +325,9 @@ extern void *pci_assign_dev_load_option_rom(PCIDevice *dev,
>                                              unsigned int domain,
>                                              unsigned int bus, unsigned int slot,
>                                              unsigned int function);
> -extern bool has_igd_gfx_passthru;
>  static inline bool is_igd_vga_passthrough(XenHostPCIDevice *dev)
>  {
> -    return (has_igd_gfx_passthru
> +    return (xen_igd_gfx_pt_enabled()
>              && ((dev->class_code >> 0x8) == PCI_CLASS_DISPLAY_VGA));
>  }
>  int xen_pt_register_vga_regions(XenHostPCIDevice *dev);
> diff --git a/stubs/Makefile.objs b/stubs/Makefile.objs
> index 6a9e3135e8f9..e0427158132f 100644
> --- a/stubs/Makefile.objs
> +++ b/stubs/Makefile.objs
> @@ -40,6 +40,7 @@ stub-obj-y += target-get-monitor-def.o
>  stub-obj-y += vmgenid.o
>  stub-obj-y += xen-common.o
>  stub-obj-y += xen-hvm.o
> +stub-obj-$(CONFIG_XEN) += xen-pt.o
>  stub-obj-y += pci-host-piix.o
>  stub-obj-y += ram-block.o
>  stub-obj-y += ramfb.o
> diff --git a/stubs/xen-pt.c b/stubs/xen-pt.c
> new file mode 100644
> index 000000000000..2d8cac8d54b9
> --- /dev/null
> +++ b/stubs/xen-pt.c
> @@ -0,0 +1,22 @@
> +/*
> + * Copyright (C) 2020       Citrix Systems UK Ltd.
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "hw/xen/xen_pt.h"
> +#include "qapi/error.h"
> +
> +bool xen_igd_gfx_pt_enabled(void)
> +{
> +    return false;
> +}
> +
> +void xen_igd_gfx_pt_set(bool value, Error **errp)
> +{
> +    if (value) {
> +        error_setg(errp, "Xen PCI passthrough support not built in");
> +    }
> +}
> 


