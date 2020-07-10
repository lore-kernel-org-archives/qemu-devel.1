Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBBE0C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 19:10:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F8412075D
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 19:10:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pm4wmWnd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F8412075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49646 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtyPP-0000ic-UI
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 15:10:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53470)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jtyOi-0008IO-O1
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 15:09:24 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:58128
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jtyOh-0002R2-5H
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 15:09:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594408162;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XHLR1yB7ustT4uJz6nGHU0Q9xGFRnS/i48uJ5yK5HFQ=;
 b=Pm4wmWndUuKb61XwdCo1Vuilb1W/op0RIRwl0rPgUmMj1U2r6ylNEJufYBlZ8MFly+bb77
 gJG1vPVRDmBj98fLFlg8icB8pwtLhQp7bQDJi7C+G2ilTM75458g1UGzZMUmeorLeYNeSn
 su/RjbWbqb4V6XJSMXA3SCmntHBS4hk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-137-adKm0jWFM-2KSmKbbo4D8A-1; Fri, 10 Jul 2020 15:09:20 -0400
X-MC-Unique: adKm0jWFM-2KSmKbbo4D8A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8060880183C;
 Fri, 10 Jul 2020 19:09:19 +0000 (UTC)
Received: from localhost (unknown [10.40.208.5])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 06DE974F4B;
 Fri, 10 Jul 2020 19:09:05 +0000 (UTC)
Date: Fri, 10 Jul 2020 21:09:04 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v5 07/20] microvm: make virtio irq base runtime
 configurable
Message-ID: <20200710210904.0a57d01d@redhat.com>
In-Reply-To: <20200707125356.32450-8-kraxel@redhat.com>
References: <20200707125356.32450-1-kraxel@redhat.com>
 <20200707125356.32450-8-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=imammedo@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/10 15:08:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Sergio Lopez <slp@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue,  7 Jul 2020 14:53:43 +0200
Gerd Hoffmann <kraxel@redhat.com> wrote:

> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> Reviewed-by: Sergio Lopez <slp@redhat.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>


> ---
>  include/hw/i386/microvm.h |  2 +-
>  hw/i386/microvm.c         | 11 +++++++----
>  2 files changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/include/hw/i386/microvm.h b/include/hw/i386/microvm.h
> index fd34b78e0d2a..03e735723726 100644
> --- a/include/hw/i386/microvm.h
> +++ b/include/hw/i386/microvm.h
> @@ -27,7 +27,6 @@
>  
>  /* Platform virtio definitions */
>  #define VIRTIO_MMIO_BASE      0xfeb00000
> -#define VIRTIO_IRQ_BASE       5
>  #define VIRTIO_NUM_TRANSPORTS 8
>  #define VIRTIO_CMDLINE_MAXLEN 64
>  
> @@ -57,6 +56,7 @@ typedef struct {
>      bool auto_kernel_cmdline;
>  
>      /* Machine state */
> +    uint32_t virtio_irq_base;
>      bool kernel_cmdline_fixed;
>  } MicrovmMachineState;
>  
> diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
> index 1300c396947b..ab6ee6c67b1a 100644
> --- a/hw/i386/microvm.c
> +++ b/hw/i386/microvm.c
> @@ -121,10 +121,11 @@ static void microvm_devices_init(MicrovmMachineState *mms)
>  
>      kvmclock_create();
>  
> +    mms->virtio_irq_base = 5;
>      for (i = 0; i < VIRTIO_NUM_TRANSPORTS; i++) {
>          sysbus_create_simple("virtio-mmio",
>                               VIRTIO_MMIO_BASE + i * 512,
> -                             x86ms->gsi[VIRTIO_IRQ_BASE + i]);
> +                             x86ms->gsi[mms->virtio_irq_base + i]);
>      }
>  
>      /* Optional and legacy devices */
> @@ -227,7 +228,7 @@ static void microvm_memory_init(MicrovmMachineState *mms)
>      x86ms->ioapic_as = &address_space_memory;
>  }
>  
> -static gchar *microvm_get_mmio_cmdline(gchar *name)
> +static gchar *microvm_get_mmio_cmdline(gchar *name, uint32_t virtio_irq_base)
>  {
>      gchar *cmdline;
>      gchar *separator;
> @@ -247,7 +248,7 @@ static gchar *microvm_get_mmio_cmdline(gchar *name)
>      ret = g_snprintf(cmdline, VIRTIO_CMDLINE_MAXLEN,
>                       " virtio_mmio.device=512@0x%lx:%ld",
>                       VIRTIO_MMIO_BASE + index * 512,
> -                     VIRTIO_IRQ_BASE + index);
> +                     virtio_irq_base + index);
>      if (ret < 0 || ret >= VIRTIO_CMDLINE_MAXLEN) {
>          g_free(cmdline);
>          return NULL;
> @@ -259,6 +260,7 @@ static gchar *microvm_get_mmio_cmdline(gchar *name)
>  static void microvm_fix_kernel_cmdline(MachineState *machine)
>  {
>      X86MachineState *x86ms = X86_MACHINE(machine);
> +    MicrovmMachineState *mms = MICROVM_MACHINE(machine);
>      BusState *bus;
>      BusChild *kid;
>      char *cmdline;
> @@ -282,7 +284,8 @@ static void microvm_fix_kernel_cmdline(MachineState *machine)
>              BusState *mmio_bus = &mmio_virtio_bus->parent_obj;
>  
>              if (!QTAILQ_EMPTY(&mmio_bus->children)) {
> -                gchar *mmio_cmdline = microvm_get_mmio_cmdline(mmio_bus->name);
> +                gchar *mmio_cmdline = microvm_get_mmio_cmdline
> +                    (mmio_bus->name, mms->virtio_irq_base);
>                  if (mmio_cmdline) {
>                      char *newcmd = g_strjoin(NULL, cmdline, mmio_cmdline, NULL);
>                      g_free(mmio_cmdline);


