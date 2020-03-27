Return-Path: <SRS0=t76e=5M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B348C43331
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 14:36:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAF05206F2
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 14:36:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R2t7Pfbc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAF05206F2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42536 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHq6A-00025Z-4d
	for qemu-devel@archiver.kernel.org; Fri, 27 Mar 2020 10:36:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37821)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1jHq5K-0001L1-9q
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 10:35:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1jHq5I-0006aK-U7
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 10:35:46 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:28253)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1jHq5I-0006Yc-Oz
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 10:35:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585319744;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SpJVvIRAWqF+pe/qwRYbEUr6Biz8HFPFMdPJ5p1Tgo4=;
 b=R2t7Pfbcd6zwSL1E73PPtXTS1qW5upzOb626pQm0deC1JsSlizd2sWzetGO4T9/Rr4iVV3
 m/tCTsRgCuJqwvb8hhaX9A+xdOsCBLM9or8YttgJoAahEfVvhzPxFx+ZzlnWrllgHDsiAv
 0ugEWr7BcW7LCvGO9yG56JBW8pvo6IQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-464-tAPWfe7oPF-8IuKuPE-kKQ-1; Fri, 27 Mar 2020 10:35:42 -0400
X-MC-Unique: tAPWfe7oPF-8IuKuPE-kKQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A6B421937FC0;
 Fri, 27 Mar 2020 14:35:41 +0000 (UTC)
Received: from localhost (unknown [10.40.208.76])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8B88E1001920;
 Fri, 27 Mar 2020 14:35:33 +0000 (UTC)
Date: Fri, 27 Mar 2020 15:35:31 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH 6/6] acpi: parallel: don't use _STA method
Message-ID: <20200327153531.0e5a19d2@redhat.com>
In-Reply-To: <20200327121111.1530-7-kraxel@redhat.com>
References: <20200327121111.1530-1-kraxel@redhat.com>
 <20200327121111.1530-7-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 27 Mar 2020 13:11:11 +0100
Gerd Hoffmann <kraxel@redhat.com> wrote:

> The _STA method dates back to the days where we had a static DSDT.  The
> device is listed in the DSDT table unconditionally and the _STA method
> checks a bit in the isa bridge pci config space to figure whenever a
> given is isa device is present or not, then evaluates to 0x0f (present)
> or 0x00 (absent).
> 
> These days the DSDT is generated by qemu anyway, so if a device is not
> present we can simply drop it from the DSDT instead.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  hw/i386/acpi-build-pc.c | 29 ++++++++---------------------
>  1 file changed, 8 insertions(+), 21 deletions(-)
> 
> diff --git a/hw/i386/acpi-build-pc.c b/hw/i386/acpi-build-pc.c
> index 97af5eac3d79..8bab105d5e44 100644
> --- a/hw/i386/acpi-build-pc.c
> +++ b/hw/i386/acpi-build-pc.c
> @@ -1169,39 +1169,26 @@ static Aml *build_mouse_device_aml(void)
>      return dev;
>  }
>  
> -static Aml *build_lpt_device_aml(void)
> +static void build_lpt_device_aml(Aml *scope)
>  {
>      Aml *dev;
>      Aml *crs;
> -    Aml *method;
> -    Aml *if_ctx;
> -    Aml *else_ctx;
> -    Aml *zero = aml_int(0);
> -    Aml *is_present = aml_local(0);
> +
> +    if (!memory_region_present(get_system_io(), 0x0378)) {
same comment as in 5/6 applies here

> +        return;
> +    }
>  
>      dev = aml_device("LPT");
>      aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0400")));
>  
> -    method = aml_method("_STA", 0, AML_NOTSERIALIZED);
> -    aml_append(method, aml_store(aml_name("LPEN"), is_present));
> -    if_ctx = aml_if(aml_equal(is_present, zero));
> -    {
> -        aml_append(if_ctx, aml_return(aml_int(0x00)));
> -    }
> -    aml_append(method, if_ctx);
> -    else_ctx = aml_else();
> -    {
> -        aml_append(else_ctx, aml_return(aml_int(0x0f)));
> -    }
> -    aml_append(method, else_ctx);
> -    aml_append(dev, method);
> +    aml_append(dev, aml_name_decl("_STA", aml_int(0xf)));
>  
>      crs = aml_resource_template();
>      aml_append(crs, aml_io(AML_DECODE16, 0x0378, 0x0378, 0x08, 0x08));
>      aml_append(crs, aml_irq_no_flags(7));
>      aml_append(dev, aml_name_decl("_CRS", crs));
>  
> -    return dev;
> +    aml_append(scope, dev);
>  }
>  
>  static void build_com_device_aml(Aml *scope, uint8_t uid)
> @@ -1248,7 +1235,7 @@ static void build_isa_devices_aml(Aml *table)
>      if (fdc) {
>          aml_append(scope, build_fdc_device_aml(fdc));
>      }
> -    aml_append(scope, build_lpt_device_aml());
> +    build_lpt_device_aml(scope);
>      build_com_device_aml(scope, 1);
>      build_com_device_aml(scope, 2);
>  


