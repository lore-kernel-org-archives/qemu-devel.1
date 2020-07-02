Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CD4AC433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 11:53:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B0382070C
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 11:53:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FqCNNYS8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B0382070C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39642 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqxmd-0004E2-FA
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 07:53:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35522)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jqxk7-0007Pr-L3
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 07:51:03 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52812
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jqxk4-0007Lg-NH
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 07:51:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593690659;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=/XIjG5c3khxH1hP8r0HZDMB8iYmrs6jUUZPjgl6JOMU=;
 b=FqCNNYS8Z2DSvwwO2LkE0KDOxiNyxA7nhPZX6hZZB2MLIvIKNO7jaK5H5vRWVgYSfAqG+J
 hlFVGdcezIKd6foqq5W6EkDCf2qhOHP7gQO6tEumSWHXRc28EcuViuTh1XjwgOZDYzoR7W
 Y3iomIC9mEQMt5xv9AK/S6SDQiTFauk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-58-IglBbmRhNWWaTE98DV2XpQ-1; Thu, 02 Jul 2020 07:50:55 -0400
X-MC-Unique: IglBbmRhNWWaTE98DV2XpQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A09D161261;
 Thu,  2 Jul 2020 11:50:54 +0000 (UTC)
Received: from thuth.com (ovpn-113-212.ams2.redhat.com [10.36.113.212])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 31C4E60CD3;
 Thu,  2 Jul 2020 11:50:52 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PULL SUBSYSTEM s390x 03/11] pc-bios: s390x: Move sleep and yield to
 helper.h
Date: Thu,  2 Jul 2020 13:50:37 +0200
Message-Id: <20200702115045.6171-4-thuth@redhat.com>
In-Reply-To: <20200702115045.6171-1-thuth@redhat.com>
References: <20200702115045.6171-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=205.139.110.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/02 04:00:43
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
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Janosch Frank <frankja@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Janosch Frank <frankja@linux.ibm.com>

They are definitely helper functions.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Message-Id: <20200624075226.92728-4-frankja@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 pc-bios/s390-ccw/helper.h      | 17 +++++++++++++++++
 pc-bios/s390-ccw/s390-ccw.h    | 18 ------------------
 pc-bios/s390-ccw/virtio-net.c  |  1 +
 pc-bios/s390-ccw/virtio-scsi.c |  1 +
 4 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/pc-bios/s390-ccw/helper.h b/pc-bios/s390-ccw/helper.h
index 78d5bc7442..32a453b634 100644
--- a/pc-bios/s390-ccw/helper.h
+++ b/pc-bios/s390-ccw/helper.h
@@ -14,6 +14,7 @@
 #define S390_CCW_HELPER_H
 
 #include "s390-ccw.h"
+#include "s390-time.h"
 
 /* Avoids compiler warnings when casting a pointer to a u32 */
 static inline uint32_t ptr2u32(void *ptr)
@@ -28,4 +29,20 @@ static inline void *u32toptr(uint32_t n)
     return (void *)(uint64_t)n;
 }
 
+static inline void yield(void)
+{
+    asm volatile ("diag 0,0,0x44"
+                  : :
+                  : "memory", "cc");
+}
+
+static inline void sleep(unsigned int seconds)
+{
+    ulong target = get_time_seconds() + seconds;
+
+    while (get_time_seconds() < target) {
+        yield();
+    }
+}
+
 #endif
diff --git a/pc-bios/s390-ccw/s390-ccw.h b/pc-bios/s390-ccw/s390-ccw.h
index fae1de363f..c5820e43ae 100644
--- a/pc-bios/s390-ccw/s390-ccw.h
+++ b/pc-bios/s390-ccw/s390-ccw.h
@@ -142,26 +142,8 @@ static inline void debug_print_addr(const char *desc, void *p)
 #define KVM_S390_VIRTIO_SET_STATUS      2
 #define KVM_S390_VIRTIO_CCW_NOTIFY      3
 
-static inline void yield(void)
-{
-    asm volatile ("diag 0,0,0x44"
-                  : :
-                  : "memory", "cc");
-}
-
 #define MAX_SECTOR_SIZE 4096
 
-#include "s390-time.h"
-
-static inline void sleep(unsigned int seconds)
-{
-    ulong target = get_time_seconds() + seconds;
-
-    while (get_time_seconds() < target) {
-        yield();
-    }
-}
-
 static inline void IPL_assert(bool term, const char *message)
 {
     if (!term) {
diff --git a/pc-bios/s390-ccw/virtio-net.c b/pc-bios/s390-ccw/virtio-net.c
index a13f3b6fb9..2fcb0a58c5 100644
--- a/pc-bios/s390-ccw/virtio-net.c
+++ b/pc-bios/s390-ccw/virtio-net.c
@@ -20,6 +20,7 @@
 #include "s390-ccw.h"
 #include "virtio.h"
 #include "s390-time.h"
+#include "helper.h"
 
 #ifndef DEBUG_VIRTIO_NET
 #define DEBUG_VIRTIO_NET 0
diff --git a/pc-bios/s390-ccw/virtio-scsi.c b/pc-bios/s390-ccw/virtio-scsi.c
index 7bf0be4ffa..eddfb8a7ad 100644
--- a/pc-bios/s390-ccw/virtio-scsi.c
+++ b/pc-bios/s390-ccw/virtio-scsi.c
@@ -15,6 +15,7 @@
 #include "scsi.h"
 #include "virtio-scsi.h"
 #include "s390-time.h"
+#include "helper.h"
 
 static ScsiDevice default_scsi_device;
 static VirtioScsiCmdReq req;
-- 
2.18.1


