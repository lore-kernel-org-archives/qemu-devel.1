Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0F0BC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 15:09:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC0412073E
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 15:09:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f8OgLdta"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC0412073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50320 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnkYC-0007Dy-12
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 11:09:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60188)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jnkCp-00082o-6l
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 10:47:23 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:27565
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jnkCm-00053V-VN
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 10:47:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592923639;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KfTV00r4zwY1bMonb5TaDC87hCBsUPGzujh6IisZV2w=;
 b=f8OgLdtaKdfQr2CEvfSJY+lxR/t46K6d49b9G34SRNAmtXJYAGLvYrM2eUzJEJp38YLGkz
 dNsBusXL+gEoB1iHeJskbC1TPTS11PuN9Xm9Ztab4qcfdd5kKqlAnO4FfAFC/3IbWAZOGx
 YQfUn3+QUzN11dLOEVwhntuGonJ4eRM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-98-LqKd-_w8MRqZhn05pCoR9g-1; Tue, 23 Jun 2020 10:47:17 -0400
X-MC-Unique: LqKd-_w8MRqZhn05pCoR9g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5E509108BD09;
 Tue, 23 Jun 2020 14:47:16 +0000 (UTC)
Received: from localhost (unknown [10.40.208.11])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DDFFF60CD3;
 Tue, 23 Jun 2020 14:47:13 +0000 (UTC)
Date: Tue, 23 Jun 2020 16:47:10 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Jon Doron <arilou@gmail.com>
Subject: Re: [PATCH v2 1/3] hyperv: vmbus: Remove the 2nd IRQ
Message-ID: <20200623164710.395f408e@redhat.com>
In-Reply-To: <20200617160904.681845-2-arilou@gmail.com>
References: <20200617160904.681845-1-arilou@gmail.com>
 <20200617160904.681845-2-arilou@gmail.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=imammedo@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/23 01:55:08
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: rvkagan@yandex-team.ru, pbonzini@redhat.com, mail@maciej.szmigiero.name,
 qemu-devel@nongnu.org, vkuznets@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 17 Jun 2020 19:09:02 +0300
Jon Doron <arilou@gmail.com> wrote:

> It seems like Windows does not really require 2 IRQs to have a
> functioning VMBus.
> 
> Signed-off-by: Jon Doron <arilou@gmail.com>
> ---
>  dtc                              | 2 +-
>  hw/hyperv/vmbus.c                | 3 +--
>  hw/i386/acpi-build.c             | 4 +---
>  include/hw/hyperv/vmbus-bridge.h | 3 +--
>  4 files changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/dtc b/dtc
> index 85e5d83984..88f18909db 160000
> --- a/dtc
> +++ b/dtc
> @@ -1 +1 @@
> -Subproject commit 85e5d839847af54efab170f2b1331b2a6421e647
> +Subproject commit 88f18909db731a627456f26d779445f84e449536
> diff --git a/hw/hyperv/vmbus.c b/hw/hyperv/vmbus.c
> index f371240176..a8bcb41026 100644
> --- a/hw/hyperv/vmbus.c
> +++ b/hw/hyperv/vmbus.c
> @@ -2741,8 +2741,7 @@ static const VMStateDescription vmstate_vmbus_bridge = {
>  };
>  
>  static Property vmbus_bridge_props[] = {
> -    DEFINE_PROP_UINT8("irq0", VMBusBridge, irq0, 7),
> -    DEFINE_PROP_UINT8("irq1", VMBusBridge, irq1, 13),

good riddance,
I've just seen that TPM would use this IRQ for Windows sake

> +    DEFINE_PROP_UINT8("irq", VMBusBridge, irq, 7),
>      DEFINE_PROP_END_OF_LIST()
>  };
>  
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 900f786d08..91af0d2d0d 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -1082,9 +1082,7 @@ static Aml *build_vmbus_device_aml(VMBusBridge *vmbus_bridge)
>      aml_append(dev, aml_name_decl("_PS3", aml_int(0x0)));
>  
>      crs = aml_resource_template();
> -    aml_append(crs, aml_irq_no_flags(vmbus_bridge->irq0));
> -    /* FIXME: newer HyperV gets by with only one IRQ */
> -    aml_append(crs, aml_irq_no_flags(vmbus_bridge->irq1));
> +    aml_append(crs, aml_irq_no_flags(vmbus_bridge->irq));
>      aml_append(dev, aml_name_decl("_CRS", crs));
>  
>      return dev;
> diff --git a/include/hw/hyperv/vmbus-bridge.h b/include/hw/hyperv/vmbus-bridge.h
> index c0a06d832c..33f93de64d 100644
> --- a/include/hw/hyperv/vmbus-bridge.h
> +++ b/include/hw/hyperv/vmbus-bridge.h
> @@ -19,8 +19,7 @@ typedef struct VMBus VMBus;
>  typedef struct VMBusBridge {
>      SysBusDevice parent_obj;
>  
> -    uint8_t irq0;
> -    uint8_t irq1;
> +    uint8_t irq;
>  
>      VMBus *bus;
>  } VMBusBridge;


