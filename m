Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 787ECC433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 10:59:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43C13206EB
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 10:59:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZpHSXqlS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43C13206EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58702 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAt9g-00023G-GC
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 06:59:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44302)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kAt3R-00067F-Tc
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 06:53:21 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:45796
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kAt3I-0001XK-1x
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 06:53:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598439191;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D0CLt/3qbQGa3OLGHSm59bu9R9OdOsddLi5YJZ1paKU=;
 b=ZpHSXqlS+TjtyLenrqXG8+Am3WNj9dpjZrt1iYpMvdRTJxGkkZBgD2G1wZwnquyeSyBOJa
 QTMMquj+FkkwuhGtDJ/WdyLKuBLPQ4ob0836EzD3XMNKuvtgHut/SlPNBNn/hSLSWT/1uj
 WQcnp+7Faq2QxnlZe+5zGVvLoXWSCH8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-445-J7aNMXXANnqeUbtGONTs7g-1; Wed, 26 Aug 2020 06:53:07 -0400
X-MC-Unique: J7aNMXXANnqeUbtGONTs7g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6B61F81F025;
 Wed, 26 Aug 2020 10:53:06 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-54.ams2.redhat.com
 [10.36.112.54])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BEBD35D9EF;
 Wed, 26 Aug 2020 10:53:05 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 664701FCF6; Wed, 26 Aug 2020 12:52:54 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 07/20] microvm: make virtio irq base runtime configurable
Date: Wed, 26 Aug 2020 12:52:41 +0200
Message-Id: <20200826105254.28496-8-kraxel@redhat.com>
In-Reply-To: <20200826105254.28496-1-kraxel@redhat.com>
References: <20200826105254.28496-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/26 03:16:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.958,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Sergio Lopez <slp@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Shannon Zhao <shannon.zhaosl@gmail.com>,
 qemu-arm@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Sergio Lopez <slp@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
---
 include/hw/i386/microvm.h |  2 +-
 hw/i386/microvm.c         | 11 +++++++----
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/include/hw/i386/microvm.h b/include/hw/i386/microvm.h
index fd34b78e0d2a..03e735723726 100644
--- a/include/hw/i386/microvm.h
+++ b/include/hw/i386/microvm.h
@@ -27,7 +27,6 @@
 
 /* Platform virtio definitions */
 #define VIRTIO_MMIO_BASE      0xfeb00000
-#define VIRTIO_IRQ_BASE       5
 #define VIRTIO_NUM_TRANSPORTS 8
 #define VIRTIO_CMDLINE_MAXLEN 64
 
@@ -57,6 +56,7 @@ typedef struct {
     bool auto_kernel_cmdline;
 
     /* Machine state */
+    uint32_t virtio_irq_base;
     bool kernel_cmdline_fixed;
 } MicrovmMachineState;
 
diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
index b1dc7e49c159..e4501f2cdfbd 100644
--- a/hw/i386/microvm.c
+++ b/hw/i386/microvm.c
@@ -121,10 +121,11 @@ static void microvm_devices_init(MicrovmMachineState *mms)
 
     kvmclock_create();
 
+    mms->virtio_irq_base = 5;
     for (i = 0; i < VIRTIO_NUM_TRANSPORTS; i++) {
         sysbus_create_simple("virtio-mmio",
                              VIRTIO_MMIO_BASE + i * 512,
-                             x86ms->gsi[VIRTIO_IRQ_BASE + i]);
+                             x86ms->gsi[mms->virtio_irq_base + i]);
     }
 
     /* Optional and legacy devices */
@@ -227,7 +228,7 @@ static void microvm_memory_init(MicrovmMachineState *mms)
     x86ms->ioapic_as = &address_space_memory;
 }
 
-static gchar *microvm_get_mmio_cmdline(gchar *name)
+static gchar *microvm_get_mmio_cmdline(gchar *name, uint32_t virtio_irq_base)
 {
     gchar *cmdline;
     gchar *separator;
@@ -247,7 +248,7 @@ static gchar *microvm_get_mmio_cmdline(gchar *name)
     ret = g_snprintf(cmdline, VIRTIO_CMDLINE_MAXLEN,
                      " virtio_mmio.device=512@0x%lx:%ld",
                      VIRTIO_MMIO_BASE + index * 512,
-                     VIRTIO_IRQ_BASE + index);
+                     virtio_irq_base + index);
     if (ret < 0 || ret >= VIRTIO_CMDLINE_MAXLEN) {
         g_free(cmdline);
         return NULL;
@@ -259,6 +260,7 @@ static gchar *microvm_get_mmio_cmdline(gchar *name)
 static void microvm_fix_kernel_cmdline(MachineState *machine)
 {
     X86MachineState *x86ms = X86_MACHINE(machine);
+    MicrovmMachineState *mms = MICROVM_MACHINE(machine);
     BusState *bus;
     BusChild *kid;
     char *cmdline;
@@ -282,7 +284,8 @@ static void microvm_fix_kernel_cmdline(MachineState *machine)
             BusState *mmio_bus = &mmio_virtio_bus->parent_obj;
 
             if (!QTAILQ_EMPTY(&mmio_bus->children)) {
-                gchar *mmio_cmdline = microvm_get_mmio_cmdline(mmio_bus->name);
+                gchar *mmio_cmdline = microvm_get_mmio_cmdline
+                    (mmio_bus->name, mms->virtio_irq_base);
                 if (mmio_cmdline) {
                     char *newcmd = g_strjoin(NULL, cmdline, mmio_cmdline, NULL);
                     g_free(mmio_cmdline);
-- 
2.27.0


