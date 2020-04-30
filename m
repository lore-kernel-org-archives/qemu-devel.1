Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD67CC47247
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 13:59:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A8D420873
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 13:59:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f7DGR4Xq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A8D420873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53812 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU9j0-0003Fh-It
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 09:59:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50610)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1jU9Vq-0005FQ-N3
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 09:49:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1jU9UG-0004CL-L2
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 09:46:02 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:55119
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jU9UG-00047s-65
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 09:44:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588254263;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PB8PGZNazuzWv04eGiBbEFj5KKQho95FLI+pXJuyqu8=;
 b=f7DGR4Xq0Kf/zOyJN7urF2OrSbn32JUmZvXUkfFwXclgPY3nBJUZ9MQI6gYgt1/tusaTS3
 pOr/D4uA228O0+fxRTpqX4DI8ZT9sjTBmUtSxJB7rL7UkEhSDu8c4y9rz8UYmK4GR20ylK
 27QfNgO5zZR7an3Aqjn9tovaXnYz2lk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-438-IM70VVzSOquj42vhfJLMkQ-1; Thu, 30 Apr 2020 09:44:19 -0400
X-MC-Unique: IM70VVzSOquj42vhfJLMkQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D06DA107ACCA;
 Thu, 30 Apr 2020 13:44:18 +0000 (UTC)
Received: from localhost (unknown [10.40.208.71])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 876095C1B0;
 Thu, 30 Apr 2020 13:43:59 +0000 (UTC)
Date: Thu, 30 Apr 2020 15:43:58 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v3 11/15] acpi: move aml builder code for parallel device
Message-ID: <20200430154358.3e7f9468@redhat.com>
In-Reply-To: <20200429140003.7336-12-kraxel@redhat.com>
References: <20200429140003.7336-1-kraxel@redhat.com>
 <20200429140003.7336-12-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/30 01:04:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Kevin Wolf <kwolf@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRy?= =?UTF-8?B?w6k=?= Lureau <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 29 Apr 2020 15:59:59 +0200
Gerd Hoffmann <kraxel@redhat.com> wrote:

> Also adds support for multiple LPT devices.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/char/parallel.c   | 32 ++++++++++++++++++++++++++++++++
>  hw/i386/acpi-build.c | 23 -----------------------
>  2 files changed, 32 insertions(+), 23 deletions(-)
> 
> diff --git a/hw/char/parallel.c b/hw/char/parallel.c
> index 8dd67d13759b..bc6b55b3b910 100644
> --- a/hw/char/parallel.c
> +++ b/hw/char/parallel.c
> @@ -28,6 +28,7 @@
>  #include "qemu/module.h"
>  #include "chardev/char-parallel.h"
>  #include "chardev/char-fe.h"
> +#include "hw/acpi/aml-build.h"
>  #include "hw/irq.h"
>  #include "hw/isa/isa.h"
>  #include "hw/qdev-properties.h"
> @@ -568,6 +569,35 @@ static void parallel_isa_realizefn(DeviceState *dev, Error **errp)
>                               s, "parallel");
>  }
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
>  /* Memory mapped interface */
>  static uint64_t parallel_mm_readfn(void *opaque, hwaddr addr, unsigned size)
>  {
> @@ -624,9 +654,11 @@ static Property parallel_isa_properties[] = {
>  static void parallel_isa_class_initfn(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(klass);
> +    ISADeviceClass *isa = ISA_DEVICE_CLASS(klass);
>  
>      dc->realize = parallel_isa_realizefn;
>      dc->vmsd = &vmstate_parallel_isa;
> +    isa->build_aml = parallel_isa_build_aml;
>      device_class_set_props(dc, parallel_isa_properties);
>      set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
>  }
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index e01afbd011d9..12a017e1f45b 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -1167,28 +1167,6 @@ static Aml *build_mouse_device_aml(void)
>      return dev;
>  }
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
>  static void build_isa_devices_aml(Aml *table)
>  {
>      ISADevice *fdc = pc_find_fdc0();
> @@ -1202,7 +1180,6 @@ static void build_isa_devices_aml(Aml *table)
>      if (fdc) {
>          aml_append(scope, build_fdc_device_aml(fdc));
>      }
> -    build_lpt_device_aml(scope);
>  
>      if (ambiguous) {
>          error_report("Multiple ISA busses, unable to define IPMI ACPI data");


