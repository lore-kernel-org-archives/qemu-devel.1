Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA149C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 19:47:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89541207DF
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 19:47:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KbI7MOKU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89541207DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37212 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBNrP-0003bx-Pw
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 15:46:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34538)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kBNUA-0008Ca-BA
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 15:22:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:20847)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kBNU7-0000Wg-JN
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 15:22:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598556174;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6Pmz/c9uWc17RBm2lA6dRWI3j5A0TV/v7Ga7jvXfr+I=;
 b=KbI7MOKUeR+cqNGK4arv8VdGVTP8RY4lT1V4mlmpxo9kRqO1y/oq1piNQlS2+Is7DklP1f
 ev0yfD14ZToGx8ofRc/FvzJWDK54TQTUclHTFxP6WLjSiLPTmRLDhbjECrZ+xUWYERhZh8
 3/rIDZ2lKcm6/3S8oR/LJhEE5tW/o/c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-490-AXZNcYXmOuygEFDeDLJA9Q-1; Thu, 27 Aug 2020 15:22:51 -0400
X-MC-Unique: AXZNcYXmOuygEFDeDLJA9Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4D2A618A2240;
 Thu, 27 Aug 2020 19:22:50 +0000 (UTC)
Received: from localhost (unknown [10.10.67.254])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0CDAD60FC2;
 Thu, 27 Aug 2020 19:22:49 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 40/53] kvm: Move QOM macros to kvm.h
Date: Thu, 27 Aug 2020 15:21:09 -0400
Message-Id: <20200827192122.658035-41-ehabkost@redhat.com>
In-Reply-To: <20200827192122.658035-1-ehabkost@redhat.com>
References: <20200827192122.658035-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/27 02:54:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Roman Bolshakov <r.bolshakov@yadro.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Move QOM macros close to the KVMState typedef.

This will make future conversion to OBJECT_DECLARE* easier.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Tested-By: Roman Bolshakov <r.bolshakov@yadro.com>
Message-Id: <20200825192110.3528606-42-ehabkost@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/sysemu/kvm.h     | 6 ++++++
 include/sysemu/kvm_int.h | 5 -----
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
index b4174d941c..8445a88db1 100644
--- a/include/sysemu/kvm.h
+++ b/include/sysemu/kvm.h
@@ -17,6 +17,7 @@
 #include "qemu/queue.h"
 #include "hw/core/cpu.h"
 #include "exec/memattrs.h"
+#include "sysemu/accel.h"
 
 #ifdef NEED_CPU_H
 # ifdef CONFIG_KVM
@@ -199,7 +200,12 @@ typedef struct KVMCapabilityInfo {
 #define KVM_CAP_LAST_INFO { NULL, 0 }
 
 struct KVMState;
+
+#define TYPE_KVM_ACCEL ACCEL_CLASS_NAME("kvm")
 typedef struct KVMState KVMState;
+#define KVM_STATE(obj) \
+    OBJECT_CHECK(KVMState, (obj), TYPE_KVM_ACCEL)
+
 extern KVMState *kvm_state;
 typedef struct Notifier Notifier;
 
diff --git a/include/sysemu/kvm_int.h b/include/sysemu/kvm_int.h
index c660a70c51..65740806da 100644
--- a/include/sysemu/kvm_int.h
+++ b/include/sysemu/kvm_int.h
@@ -33,11 +33,6 @@ typedef struct KVMMemoryListener {
     int as_id;
 } KVMMemoryListener;
 
-#define TYPE_KVM_ACCEL ACCEL_CLASS_NAME("kvm")
-
-#define KVM_STATE(obj) \
-    OBJECT_CHECK(KVMState, (obj), TYPE_KVM_ACCEL)
-
 void kvm_memory_listener_register(KVMState *s, KVMMemoryListener *kml,
                                   AddressSpace *as, int as_id);
 
-- 
2.26.2


