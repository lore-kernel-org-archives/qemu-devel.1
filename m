Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBC55C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 20:07:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86FBA207E8
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 20:07:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FpeUe5dH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86FBA207E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58548 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jm0oP-0002DX-G4
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 16:07:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50880)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jm0nX-0001CV-02
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 16:06:07 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:55673
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jm0nR-0000Oc-Ud
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 16:06:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592510759;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ty7YaDb7XACV6JfsNRapkXbwCWJpwDHLVTaOgvshZsk=;
 b=FpeUe5dHV9MOitpkymeBdzJftVqRIAgo6dsGeTaa576xFLDVYOMsr/Gp7d1lItlaPXHA/w
 iTREg1pLA0Xyy+e/3CJTdFG7/4Z634PIMZCZRH8EL0OVxgxW8yZuS9b5Ho/GJaCbc9CK3p
 ouQfmOPsNd1cq/SgKERRzEc6U0Gk0uM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-81-dm6qiZpyO1GP7Wh6p4UWwA-1; Thu, 18 Jun 2020 16:05:58 -0400
X-MC-Unique: dm6qiZpyO1GP7Wh6p4UWwA-1
Received: by mail-wr1-f69.google.com with SMTP id e1so3234731wrm.3
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2020 13:05:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=EJsXGkmU02iG7Tf6cwzh9nVCmtRMk4zqQ6/VQaQDqfI=;
 b=bv7YtHCJ58v6MHalWyltIZgsDmh9DKjClnHjer+8KM7kWjwx3SgT9nS2Z2UNylHzh/
 sU+1+fX+/flh5YBU32sLbjJTZ1AEGg/NbRfZtXhIOOfolRzl0cvLB7US2/+rO/gJpe9l
 wk/QCHPceJQv9m3M8pDwMi4mEVREI1nfCRJz/v4ZQISeeRgFHEn05WRn/RQoyCNiUkKz
 5YyUE6uuhNqWZ8hebrXmfoYXEnWnv6qRmbcTYU99xwY65oQJ+bon1bu675xJ5RxX9xEe
 Fq4KdvfF/bL9B1lmccsypTjpfGgtrkUqnpbvzxfX0cOLKeaNoq1IAv1d2eXJ4DrGEDVS
 zWdw==
X-Gm-Message-State: AOAM533/nUDNHi6BfG0VTIx76kV0XxLQQoGxCiyNPRm7bxAx5tgPyiv/
 pHGbHmFggzpjIJwHLUOr7ZFzXkSnM4YIMYvclyPjjuP7m+cBTzQtTAxh+9IkoQYHkv+eHcTb1An
 bgdFpsRtrqxIcgbM=
X-Received: by 2002:a05:600c:24c:: with SMTP id 12mr52083wmj.28.1592510756963; 
 Thu, 18 Jun 2020 13:05:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwao3Hges787eiI4rZsV6LHjzV/V/0ffkvilShm0F4R8rdrn9GHRngecuo/pBEyozMV/u7aOQ==
X-Received: by 2002:a05:600c:24c:: with SMTP id 12mr52060wmj.28.1592510756733; 
 Thu, 18 Jun 2020 13:05:56 -0700 (PDT)
Received: from redhat.com (bzq-79-178-18-124.red.bezeqint.net. [79.178.18.124])
 by smtp.gmail.com with ESMTPSA id j6sm3898948wmb.3.2020.06.18.13.05.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jun 2020 13:05:56 -0700 (PDT)
Date: Thu, 18 Jun 2020 16:05:53 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v9 05/10] acpi: move aml builder code for i8042
 (kbd+mouse) device
Message-ID: <20200618160506-mutt-send-email-mst@kernel.org>
References: <20200617071138.11159-1-kraxel@redhat.com>
 <20200617071138.11159-6-kraxel@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200617071138.11159-6-kraxel@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/18 00:57:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 John Snow <jsnow@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jun 17, 2020 at 09:11:33AM +0200, Gerd Hoffmann wrote:
> DSDT change: isa device order changes in case MI1 (ipmi) is present.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> ---
>  hw/i386/acpi-build.c            |  39 --------------------------------
>  hw/input/pckbd.c                |  31 +++++++++++++++++++++++++
>  tests/data/acpi/pc/DSDT.ipmikcs | Bin 5086 -> 5086 bytes
>  tests/data/acpi/q35/DSDT.ipmibt | Bin 7827 -> 7827 bytes
>  4 files changed, 31 insertions(+), 39 deletions(-)

Please don't add binary file diffs together with source changes.
Pls follow the process outlined in tests/qtest/bios-tables-test.c.

> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 45297d9a90e7..13113e83dfe2 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -938,42 +938,6 @@ static void build_hpet_aml(Aml *table)
>      aml_append(table, scope);
>  }
>  
> -static Aml *build_kbd_device_aml(void)
> -{
> -    Aml *dev;
> -    Aml *crs;
> -
> -    dev = aml_device("KBD");
> -    aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0303")));
> -
> -    aml_append(dev, aml_name_decl("_STA", aml_int(0xf)));
> -
> -    crs = aml_resource_template();
> -    aml_append(crs, aml_io(AML_DECODE16, 0x0060, 0x0060, 0x01, 0x01));
> -    aml_append(crs, aml_io(AML_DECODE16, 0x0064, 0x0064, 0x01, 0x01));
> -    aml_append(crs, aml_irq_no_flags(1));
> -    aml_append(dev, aml_name_decl("_CRS", crs));
> -
> -    return dev;
> -}
> -
> -static Aml *build_mouse_device_aml(void)
> -{
> -    Aml *dev;
> -    Aml *crs;
> -
> -    dev = aml_device("MOU");
> -    aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0F13")));
> -
> -    aml_append(dev, aml_name_decl("_STA", aml_int(0xf)));
> -
> -    crs = aml_resource_template();
> -    aml_append(crs, aml_irq_no_flags(12));
> -    aml_append(dev, aml_name_decl("_CRS", crs));
> -
> -    return dev;
> -}
> -
>  static Aml *build_vmbus_device_aml(VMBusBridge *vmbus_bridge)
>  {
>      Aml *dev;
> @@ -1019,9 +983,6 @@ static void build_isa_devices_aml(Aml *table)
>      Aml *scope = aml_scope("_SB.PCI0.ISA");
>      Object *obj = object_resolve_path_type("", TYPE_ISA_BUS, &ambiguous);
>  
> -    aml_append(scope, build_kbd_device_aml());
> -    aml_append(scope, build_mouse_device_aml());
> -
>      if (ambiguous) {
>          error_report("Multiple ISA busses, unable to define IPMI ACPI data");
>      } else if (!obj) {
> diff --git a/hw/input/pckbd.c b/hw/input/pckbd.c
> index 60a41303203a..29d633ca9478 100644
> --- a/hw/input/pckbd.c
> +++ b/hw/input/pckbd.c
> @@ -26,6 +26,7 @@
>  #include "qemu/log.h"
>  #include "hw/isa/isa.h"
>  #include "migration/vmstate.h"
> +#include "hw/acpi/aml-build.h"
>  #include "hw/input/ps2.h"
>  #include "hw/irq.h"
>  #include "hw/input/i8042.h"
> @@ -561,12 +562,42 @@ static void i8042_realizefn(DeviceState *dev, Error **errp)
>      qemu_register_reset(kbd_reset, s);
>  }
>  
> +static void i8042_build_aml(ISADevice *isadev, Aml *scope)
> +{
> +    Aml *kbd;
> +    Aml *mou;
> +    Aml *crs;
> +
> +    crs = aml_resource_template();
> +    aml_append(crs, aml_io(AML_DECODE16, 0x0060, 0x0060, 0x01, 0x01));
> +    aml_append(crs, aml_io(AML_DECODE16, 0x0064, 0x0064, 0x01, 0x01));
> +    aml_append(crs, aml_irq_no_flags(1));
> +
> +    kbd = aml_device("KBD");
> +    aml_append(kbd, aml_name_decl("_HID", aml_eisaid("PNP0303")));
> +    aml_append(kbd, aml_name_decl("_STA", aml_int(0xf)));
> +    aml_append(kbd, aml_name_decl("_CRS", crs));
> +
> +    crs = aml_resource_template();
> +    aml_append(crs, aml_irq_no_flags(12));
> +
> +    mou = aml_device("MOU");
> +    aml_append(mou, aml_name_decl("_HID", aml_eisaid("PNP0F13")));
> +    aml_append(mou, aml_name_decl("_STA", aml_int(0xf)));
> +    aml_append(mou, aml_name_decl("_CRS", crs));
> +
> +    aml_append(scope, kbd);
> +    aml_append(scope, mou);
> +}
> +
>  static void i8042_class_initfn(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(klass);
> +    ISADeviceClass *isa = ISA_DEVICE_CLASS(klass);
>  
>      dc->realize = i8042_realizefn;
>      dc->vmsd = &vmstate_kbd_isa;
> +    isa->build_aml = i8042_build_aml;
>      set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
>  }
>  
> diff --git a/tests/data/acpi/pc/DSDT.ipmikcs b/tests/data/acpi/pc/DSDT.ipmikcs
> index c285651131dc2ab8b0f32de750d7ac02a8b09936..1c19e2f354d022279d7e1343fa7212396d8c25a0 100644
> GIT binary patch
> delta 20
> ccmcboeouYFO2)~oOdgY0GRAE7Wtu1m09c?0ga7~l
> 
> delta 20
> ccmcboeouYFO2)|_8Dl1|Wc1kV%QR6C0AuwCZvX%Q
> 
> diff --git a/tests/data/acpi/q35/DSDT.ipmibt b/tests/data/acpi/q35/DSDT.ipmibt
> index 38723daef80421ea528b2ad2d411e7357df43956..0173c3668a6cdef80127de7880a19cb5c5ea7dc0 100644
> GIT binary patch
> delta 20
> ccmbPiJK1)F4%6fgChy5QOfj1;GaZly08TOoX8-^I
> 
> delta 20
> ccmbPiJK1)F4%6gvrkKe(Ox~L>GaZly08Od~RsaA1
> 
> -- 
> 2.18.4


