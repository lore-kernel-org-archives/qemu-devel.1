Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86565C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 19:51:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 515352080C
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 19:51:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jDxas//h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 515352080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53346 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBNvr-0001jv-Il
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 15:51:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34428)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kBNTw-0007gT-MF
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 15:22:45 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:57070
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kBNTr-0000V2-6j
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 15:22:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598556157;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P847TqoNJFzJB2K8e6REplRN3E3O2/fiCQfD92kksM8=;
 b=jDxas//h14yYIOnhZu+nLVrKqa2M4liE+ao3+tLo4vltWUhYHoz4WFp3YkNw/fAJq1iUiD
 fdV660fhWUoJc1jVy3xXJda0GMwZ+h1v4y0wPNf81IjR6BlaXi8Pru7jo1+3H/gHa1R96O
 GAgOE/E/zHMQAQNOfZXGWZIEjuZrD9Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-390-ISvVBzAMMo-NrwHLB6XuSA-1; Thu, 27 Aug 2020 15:22:35 -0400
X-MC-Unique: ISvVBzAMMo-NrwHLB6XuSA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 04F81189E616;
 Thu, 27 Aug 2020 19:22:34 +0000 (UTC)
Received: from localhost (unknown [10.10.67.254])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B7BAA19D61;
 Thu, 27 Aug 2020 19:22:33 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 33/53] vmbus: Move QOM macros to vmbus.h
Date: Thu, 27 Aug 2020 15:21:02 -0400
Message-Id: <20200827192122.658035-34-ehabkost@redhat.com>
In-Reply-To: <20200827192122.658035-1-ehabkost@redhat.com>
References: <20200827192122.658035-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
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

Move all declarations related to TYPE_VMBUS to the same place in
vmbus.h.

This will make future conversion to OBJECT_DECLARE* easier.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Tested-By: Roman Bolshakov <r.bolshakov@yadro.com>
Message-Id: <20200825192110.3528606-35-ehabkost@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/hw/hyperv/vmbus-bridge.h | 3 +--
 include/hw/hyperv/vmbus.h        | 4 ++++
 hw/hyperv/vmbus.c                | 3 ---
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/hw/hyperv/vmbus-bridge.h b/include/hw/hyperv/vmbus-bridge.h
index 33f93de64d..fe90bda01b 100644
--- a/include/hw/hyperv/vmbus-bridge.h
+++ b/include/hw/hyperv/vmbus-bridge.h
@@ -11,11 +11,10 @@
 #define HW_HYPERV_VMBUS_BRIDGE_H
 
 #include "hw/sysbus.h"
+#include "hw/hyperv/vmbus.h"
 
 #define TYPE_VMBUS_BRIDGE "vmbus-bridge"
 
-typedef struct VMBus VMBus;
-
 typedef struct VMBusBridge {
     SysBusDevice parent_obj;
 
diff --git a/include/hw/hyperv/vmbus.h b/include/hw/hyperv/vmbus.h
index 40e8417eec..cd98ec24e7 100644
--- a/include/hw/hyperv/vmbus.h
+++ b/include/hw/hyperv/vmbus.h
@@ -26,6 +26,10 @@
 #define VMBUS_DEVICE_GET_CLASS(obj) \
     OBJECT_GET_CLASS(VMBusDeviceClass, (obj), TYPE_VMBUS_DEVICE)
 
+#define TYPE_VMBUS "vmbus"
+typedef struct VMBus VMBus;
+#define VMBUS(obj) OBJECT_CHECK(VMBus, (obj), TYPE_VMBUS)
+
 /*
  * Object wrapping a GPADL -- GPA Descriptor List -- an array of guest physical
  * pages, to be used for various buffers shared between the host and the guest.
diff --git a/hw/hyperv/vmbus.c b/hw/hyperv/vmbus.c
index 34392e892a..75af6b83dd 100644
--- a/hw/hyperv/vmbus.c
+++ b/hw/hyperv/vmbus.c
@@ -20,9 +20,6 @@
 #include "cpu.h"
 #include "trace.h"
 
-#define TYPE_VMBUS "vmbus"
-#define VMBUS(obj) OBJECT_CHECK(VMBus, (obj), TYPE_VMBUS)
-
 enum {
     VMGPADL_INIT,
     VMGPADL_ALIVE,
-- 
2.26.2


