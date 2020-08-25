Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0506FC433E3
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 19:44:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CED072075E
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 19:44:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SqqsyYW7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CED072075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59582 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAerU-0003dI-1I
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 15:44:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40178)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kAeWg-0000h5-5Q
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 15:22:34 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:22013
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kAeWe-0006FF-68
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 15:22:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598383351;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8wJ36udvm6pu4Eewx9JqnGIjQ112NfsHFCYV+ACUzTA=;
 b=SqqsyYW78uTGF8dISj4xz8n7X3Y74kDsjz1bAuto1VClzni0Al6Nx/RfAUCDI+GZMTisXD
 tu0PYOVizl2sV+SjJjpzB2ApRQbcpPdEpTjxd5FpdzyVvae1XcBo82eXrYeiHbhJIOYDXM
 U6NHuQJC7ahJU7AuSUV/KcYFl8e9q+c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-227-25yC3YjKNrOUeCs0kUeAaw-1; Tue, 25 Aug 2020 15:22:29 -0400
X-MC-Unique: 25yC3YjKNrOUeCs0kUeAaw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A23B681F01D
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2020 19:22:28 +0000 (UTC)
Received: from localhost (unknown [10.10.67.254])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 68A01709C4;
 Tue, 25 Aug 2020 19:22:28 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 34/74] vmbus: Move QOM macros to vmbus.h
Date: Tue, 25 Aug 2020 15:20:30 -0400
Message-Id: <20200825192110.3528606-35-ehabkost@redhat.com>
In-Reply-To: <20200825192110.3528606-1-ehabkost@redhat.com>
References: <20200825192110.3528606-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/25 15:21:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.958,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
 "Daniel P. Berrange" <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Move all declarations related to TYPE_VMBUS to the same place in
vmbus.h.

This will make future conversion to OBJECT_DECLARE* easier.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Changes v2 -> v3: none

Changes series v1 -> v2: new patch in series v2

Cc: qemu-devel@nongnu.org
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


