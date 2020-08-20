Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80398C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 00:26:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4027F207DA
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 00:26:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L9r7TOfS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4027F207DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39024 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8YPc-00043V-Ds
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 20:26:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49794)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1k8YDm-0007tu-6f
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 20:14:22 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:58155
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1k8YDj-0002UD-Vi
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 20:14:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597882459;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7EkdIlxETPfIAzHkOFinRG+mYgIs7T56rbnwrgrdbzk=;
 b=L9r7TOfSa7U0D/tivPefChBdu2DFSo6+gohnUZjsweNmlqXfE/9HIrBSnsGcykgEIzg5xM
 knlYuObxOY5+qK43V+8UW0E1CRWagHbmMRhbiaNbH3a33754LzQig0zE7/Jqx6zb1XC4Gm
 u3xscLURMDVVa0KoqP8q5scC7Gi3a30=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-251-P48DF9CMNx281CAIqhZFHA-1; Wed, 19 Aug 2020 20:14:17 -0400
X-MC-Unique: P48DF9CMNx281CAIqhZFHA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ADC0B8030A4;
 Thu, 20 Aug 2020 00:14:16 +0000 (UTC)
Received: from localhost (ovpn-117-244.rdu2.redhat.com [10.10.117.244])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7549C757C0;
 Thu, 20 Aug 2020 00:14:16 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 41/58] kvm: Move QOM macros to kvm.h
Date: Wed, 19 Aug 2020 20:12:19 -0400
Message-Id: <20200820001236.1284548-42-ehabkost@redhat.com>
In-Reply-To: <20200820001236.1284548-1-ehabkost@redhat.com>
References: <20200820001236.1284548-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Received-SPF: pass client-ip=207.211.31.81; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/19 20:12:44
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 "Daniel P. Berrange" <berrange@redhat.com>, kvm@vger.kernel.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Move QOM macros close to the KVMState typedef.

This will make future conversion to OBJECT_DECLARE* easier.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Changes series v1 -> v2: new patch in series v2

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org
Cc: qemu-devel@nongnu.org
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


