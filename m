Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3694DC433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 13:58:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4FB8206DB
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 13:58:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VXiMmY37"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4FB8206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42928 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIuQF-0005Un-OK
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 09:58:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34362)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kIuM7-0008Ob-9b
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 09:53:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60308)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kIuM1-00083A-CX
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 09:53:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600350820;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TuItMlpz3oyY7fQG4iAnhQ4/Ntvos+fF0mHSveJa+/8=;
 b=VXiMmY379d7v+s1Os1GIlc+RVcihS+3AuV41t+eIoz0o38zkRQxE+XS1ALNaVrWRrL83/B
 vgSjD+GcQ3YA2wH7cpx8zghCDAcvitiqpegmVqF4nQzUUEsi4zyFXvWuDrGxNNMbxHr1y5
 C5af9A2fuhgKolvjwgQkWlSK1YMfRWA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-535-VzL6VocAOQu_KwBBNLCW8A-1; Thu, 17 Sep 2020 09:53:38 -0400
X-MC-Unique: VzL6VocAOQu_KwBBNLCW8A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DB7AA100747E;
 Thu, 17 Sep 2020 13:53:36 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-85.ams2.redhat.com
 [10.36.112.85])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7EB475576A;
 Thu, 17 Sep 2020 13:53:35 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id DA1F11FCEE; Thu, 17 Sep 2020 15:53:23 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 07/21] microvm: make virtio irq base runtime configurable
Date: Thu, 17 Sep 2020 15:53:09 +0200
Message-Id: <20200917135323.18022-8-kraxel@redhat.com>
In-Reply-To: <20200917135323.18022-1-kraxel@redhat.com>
References: <20200917135323.18022-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/17 02:01:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.997,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Sergio Lopez <slp@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Message-id: 20200915120909.20838-8-kraxel@redhat.com
---
 include/hw/i386/microvm.h |  2 +-
 hw/i386/microvm.c         | 11 +++++++----
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/include/hw/i386/microvm.h b/include/hw/i386/microvm.h
index 36dbcdd12351..87593694eb0e 100644
--- a/include/hw/i386/microvm.h
+++ b/include/hw/i386/microvm.h
@@ -28,7 +28,6 @@
 
 /* Platform virtio definitions */
 #define VIRTIO_MMIO_BASE      0xfeb00000
-#define VIRTIO_IRQ_BASE       5
 #define VIRTIO_NUM_TRANSPORTS 8
 #define VIRTIO_CMDLINE_MAXLEN 64
 
@@ -59,6 +58,7 @@ struct MicrovmMachineState {
     bool auto_kernel_cmdline;
 
     /* Machine state */
+    uint32_t virtio_irq_base;
     bool kernel_cmdline_fixed;
 };
 typedef struct MicrovmMachineState MicrovmMachineState;
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


