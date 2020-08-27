Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C830C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 19:37:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B5462087E
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 19:37:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cYd6m+Hk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B5462087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49380 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBNho-0002Pd-IO
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 15:37:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34338)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kBNTo-0007Zi-Qt
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 15:22:36 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:34737
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kBNTh-0000RE-0M
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 15:22:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598556142;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UDAB9lmlWJRibKtreg8TJ47DL+Yfto/OwhiERIuiAAc=;
 b=cYd6m+Hk0kJP8mSN52Yyn/0xlYnbIbFVaSGDJQAEuAI6dWG/zJuz+DTngYJevKPaIMktMA
 vxIjMnRCQbyz0r5j17Fl3tMXkZHeh35m3ig1FJrwIPvYFVSOfMAeleAwNl4kENEj7JeXMO
 nc7W8gi5Aynf8Le30eGG6ofdZ5aFIy4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-114-Wtdeo2QeNKu9WKP08wxvfA-1; Thu, 27 Aug 2020 15:22:19 -0400
X-MC-Unique: Wtdeo2QeNKu9WKP08wxvfA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9E474189E616;
 Thu, 27 Aug 2020 19:22:18 +0000 (UTC)
Received: from localhost (unknown [10.10.67.254])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 64B887849B;
 Thu, 27 Aug 2020 19:22:18 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 24/53] armsse: Rename QOM macros to avoid conflicts
Date: Thu, 27 Aug 2020 15:20:53 -0400
Message-Id: <20200827192122.658035-25-ehabkost@redhat.com>
In-Reply-To: <20200827192122.658035-1-ehabkost@redhat.com>
References: <20200827192122.658035-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/27 07:16:16
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Roman Bolshakov <r.bolshakov@yadro.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Rename TYPE_ARMSSE to TYPE_ARM_SSE, and ARMSSE*() type checking
macros to ARM_SSE*().

This will avoid a future conflict between an ARM_SSE() type
checking macro and the ARMSSE typedef name.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Tested-By: Roman Bolshakov <r.bolshakov@yadro.com>
Message-Id: <20200825192110.3528606-26-ehabkost@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/hw/arm/armsse.h | 12 ++++++------
 hw/arm/armsse.c         | 24 ++++++++++++------------
 2 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/include/hw/arm/armsse.h b/include/hw/arm/armsse.h
index 84080c2299..529816286d 100644
--- a/include/hw/arm/armsse.h
+++ b/include/hw/arm/armsse.h
@@ -106,8 +106,8 @@
 #include "hw/core/split-irq.h"
 #include "hw/cpu/cluster.h"
 
-#define TYPE_ARMSSE "arm-sse"
-#define ARMSSE(obj) OBJECT_CHECK(ARMSSE, (obj), TYPE_ARMSSE)
+#define TYPE_ARM_SSE "arm-sse"
+#define ARM_SSE(obj) OBJECT_CHECK(ARMSSE, (obj), TYPE_ARM_SSE)
 
 /*
  * These type names are for specific IoTKit subsystems; other than
@@ -224,9 +224,9 @@ typedef struct ARMSSEClass {
     const ARMSSEInfo *info;
 } ARMSSEClass;
 
-#define ARMSSE_CLASS(klass) \
-    OBJECT_CLASS_CHECK(ARMSSEClass, (klass), TYPE_ARMSSE)
-#define ARMSSE_GET_CLASS(obj) \
-    OBJECT_GET_CLASS(ARMSSEClass, (obj), TYPE_ARMSSE)
+#define ARM_SSE_CLASS(klass) \
+    OBJECT_CLASS_CHECK(ARMSSEClass, (klass), TYPE_ARM_SSE)
+#define ARM_SSE_GET_CLASS(obj) \
+    OBJECT_GET_CLASS(ARMSSEClass, (obj), TYPE_ARM_SSE)
 
 #endif
diff --git a/hw/arm/armsse.c b/hw/arm/armsse.c
index dcbff9bd8f..6264eab16b 100644
--- a/hw/arm/armsse.c
+++ b/hw/arm/armsse.c
@@ -167,7 +167,7 @@ static void irq_status_forwarder(void *opaque, int n, int level)
 
 static void nsccfg_handler(void *opaque, int n, int level)
 {
-    ARMSSE *s = ARMSSE(opaque);
+    ARMSSE *s = ARM_SSE(opaque);
 
     s->nsccfg = level;
 }
@@ -233,8 +233,8 @@ static void armsse_forward_sec_resp_cfg(ARMSSE *s)
 
 static void armsse_init(Object *obj)
 {
-    ARMSSE *s = ARMSSE(obj);
-    ARMSSEClass *asc = ARMSSE_GET_CLASS(obj);
+    ARMSSE *s = ARM_SSE(obj);
+    ARMSSEClass *asc = ARM_SSE_GET_CLASS(obj);
     const ARMSSEInfo *info = asc->info;
     int i;
 
@@ -391,7 +391,7 @@ static void armsse_exp_irq(void *opaque, int n, int level)
 
 static void armsse_mpcexp_status(void *opaque, int n, int level)
 {
-    ARMSSE *s = ARMSSE(opaque);
+    ARMSSE *s = ARM_SSE(opaque);
     qemu_set_irq(s->mpcexp_status_in[n], level);
 }
 
@@ -401,7 +401,7 @@ static qemu_irq armsse_get_common_irq_in(ARMSSE *s, int irqno)
      * Return a qemu_irq which can be used to signal IRQ n to
      * all CPUs in the SSE.
      */
-    ARMSSEClass *asc = ARMSSE_GET_CLASS(s);
+    ARMSSEClass *asc = ARM_SSE_GET_CLASS(s);
     const ARMSSEInfo *info = asc->info;
 
     assert(irq_is_common[irqno]);
@@ -428,8 +428,8 @@ static void map_ppu(ARMSSE *s, int ppuidx, const char *name, hwaddr addr)
 
 static void armsse_realize(DeviceState *dev, Error **errp)
 {
-    ARMSSE *s = ARMSSE(dev);
-    ARMSSEClass *asc = ARMSSE_GET_CLASS(dev);
+    ARMSSE *s = ARM_SSE(dev);
+    ARMSSEClass *asc = ARM_SSE_GET_CLASS(dev);
     const ARMSSEInfo *info = asc->info;
     int i;
     MemoryRegion *mr;
@@ -1114,7 +1114,7 @@ static void armsse_idau_check(IDAUInterface *ii, uint32_t address,
      * of the address bits. The NSC attribute is guest-adjustable via the
      * NSCCFG register in the security controller.
      */
-    ARMSSE *s = ARMSSE(ii);
+    ARMSSE *s = ARM_SSE(ii);
     int region = extract32(address, 28, 4);
 
     *ns = !(region & 1);
@@ -1136,7 +1136,7 @@ static const VMStateDescription armsse_vmstate = {
 
 static void armsse_reset(DeviceState *dev)
 {
-    ARMSSE *s = ARMSSE(dev);
+    ARMSSE *s = ARM_SSE(dev);
 
     s->nsccfg = 0;
 }
@@ -1145,7 +1145,7 @@ static void armsse_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     IDAUInterfaceClass *iic = IDAU_INTERFACE_CLASS(klass);
-    ARMSSEClass *asc = ARMSSE_CLASS(klass);
+    ARMSSEClass *asc = ARM_SSE_CLASS(klass);
     const ARMSSEInfo *info = data;
 
     dc->realize = armsse_realize;
@@ -1157,7 +1157,7 @@ static void armsse_class_init(ObjectClass *klass, void *data)
 }
 
 static const TypeInfo armsse_info = {
-    .name = TYPE_ARMSSE,
+    .name = TYPE_ARM_SSE,
     .parent = TYPE_SYS_BUS_DEVICE,
     .instance_size = sizeof(ARMSSE),
     .instance_init = armsse_init,
@@ -1177,7 +1177,7 @@ static void armsse_register_types(void)
     for (i = 0; i < ARRAY_SIZE(armsse_variants); i++) {
         TypeInfo ti = {
             .name = armsse_variants[i].name,
-            .parent = TYPE_ARMSSE,
+            .parent = TYPE_ARM_SSE,
             .class_init = armsse_class_init,
             .class_data = (void *)&armsse_variants[i],
         };
-- 
2.26.2


