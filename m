Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7BF9C4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 16:46:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C76621D91
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 16:46:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dckT8UZM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C76621D91
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39512 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLUNi-0005ji-FA
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 12:46:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57492)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1kLTke-0002jE-C6
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 12:05:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:57077)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1kLTkc-0003vR-A9
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 12:05:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600963541;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wJrqradJRkoK4uTfcB0Mh5atTSDfbUU1dmDu1yYFJuQ=;
 b=dckT8UZMMzUam3TNAQKkC/zNfvRPJuJniSWi+8SLkEVVh55Rt/roycpzb7vL63OrR2Pl/m
 OauCqmlixdWsxj/e192Z7hXXvuDWfei3ZehdQToiQRyDGQapLhdZ0CfPmNYZDSp3AICi5X
 x7TFK6/V+5rEYZyNkm0Ut8G8GkWNvlY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-358-pF05UGVmMRm_LEOhtMMDhQ-1; Thu, 24 Sep 2020 12:05:36 -0400
X-MC-Unique: pF05UGVmMRm_LEOhtMMDhQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 545E918BA284;
 Thu, 24 Sep 2020 16:05:35 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-114-4.ams2.redhat.com [10.36.114.4])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B732F19C66;
 Thu, 24 Sep 2020 16:05:26 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH PROTOTYPE 4/6] memory: Extend
 ram_block_discard_(require|disable) by two discard types
Date: Thu, 24 Sep 2020 18:04:21 +0200
Message-Id: <20200924160423.106747-5-david@redhat.com>
In-Reply-To: <20200924160423.106747-1-david@redhat.com>
References: <20200924160423.106747-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/24 01:10:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
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
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
 David Hildenbrand <david@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Peter Xu <peterx@redhat.com>,
 Luiz Capitulino <lcapitulino@redhat.com>, Auger Eric <eric.auger@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Wei Yang <richardw.yang@linux.intel.com>, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We want to separate the two cases whereby
- balloning drivers do random discards on random guest memory (e.g.,
  virtio-balloon) - uncoordinated discards
- paravirtualized memory devices do discards in well-known granularity,
  and always know which block is currently accessible or inaccessible by
  a guest. - coordinated discards

This will be required to get virtio_mem + vfio running - vfio still
wants to block random memory ballooning.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Alex Williamson <alex.williamson@redhat.com>
Cc: Wei Yang <richardw.yang@linux.intel.com>
Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Cc: Peter Xu <peterx@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 exec.c                | 109 ++++++++++++++++++++++++++++++++++--------
 include/exec/memory.h |  36 ++++++++++++--
 2 files changed, 121 insertions(+), 24 deletions(-)

diff --git a/exec.c b/exec.c
index e34b602bdf..83098e9230 100644
--- a/exec.c
+++ b/exec.c
@@ -4098,52 +4098,121 @@ void mtree_print_dispatch(AddressSpaceDispatch *d, MemoryRegion *root)
  * If positive, discarding RAM is disabled. If negative, discarding RAM is
  * required to work and cannot be disabled.
  */
-static int ram_block_discard_disabled;
+static int uncoordinated_discard_disabled;
+static int coordinated_discard_disabled;
 
-int ram_block_discard_disable(bool state)
+static int __ram_block_discard_disable(int *counter)
 {
     int old;
 
-    if (!state) {
-        atomic_dec(&ram_block_discard_disabled);
-        return 0;
-    }
-
     do {
-        old = atomic_read(&ram_block_discard_disabled);
+        old = atomic_read(counter);
         if (old < 0) {
             return -EBUSY;
         }
-    } while (atomic_cmpxchg(&ram_block_discard_disabled, old, old + 1) != old);
+    } while (atomic_cmpxchg(counter, old, old + 1) != old);
+
     return 0;
 }
 
-int ram_block_discard_require(bool state)
+int ram_block_discard_type_disable(RamBlockDiscardType type, bool state)
 {
-    int old;
+    int ret;
 
-    if (!state) {
-        atomic_inc(&ram_block_discard_disabled);
-        return 0;
+    if (type & RAM_BLOCK_DISCARD_T_UNCOORDINATED) {
+        if (!state) {
+            atomic_dec(&uncoordinated_discard_disabled);
+        } else {
+            ret = __ram_block_discard_disable(&uncoordinated_discard_disabled);
+            if (ret) {
+                return ret;
+            }
+        }
     }
+    if (type & RAM_BLOCK_DISCARD_T_COORDINATED) {
+        if (!state) {
+            atomic_dec(&coordinated_discard_disabled);
+        } else {
+            ret = __ram_block_discard_disable(&coordinated_discard_disabled);
+            if (ret) {
+                /* Rollback the previous change. */
+                if (type & RAM_BLOCK_DISCARD_T_UNCOORDINATED) {
+                    atomic_dec(&uncoordinated_discard_disabled);
+                }
+                return ret;
+            }
+        }
+    }
+    return 0;
+}
+
+static int __ram_block_discard_require(int *counter)
+{
+    int old;
 
     do {
-        old = atomic_read(&ram_block_discard_disabled);
+        old = atomic_read(counter);
         if (old > 0) {
             return -EBUSY;
         }
-    } while (atomic_cmpxchg(&ram_block_discard_disabled, old, old - 1) != old);
+    } while (atomic_cmpxchg(counter, old, old - 1) != old);
+
+    return 0;
+}
+
+int ram_block_discard_type_require(RamBlockDiscardType type, bool state)
+{
+    int ret;
+
+    if (type & RAM_BLOCK_DISCARD_T_UNCOORDINATED) {
+        if (!state) {
+            atomic_inc(&uncoordinated_discard_disabled);
+        } else {
+            ret = __ram_block_discard_require(&uncoordinated_discard_disabled);
+            if (ret) {
+                return ret;
+            }
+        }
+    }
+    if (type & RAM_BLOCK_DISCARD_T_COORDINATED) {
+        if (!state) {
+            atomic_inc(&coordinated_discard_disabled);
+        } else {
+            ret = __ram_block_discard_require(&coordinated_discard_disabled);
+            if (ret) {
+                /* Rollback the previous change. */
+                if (type & RAM_BLOCK_DISCARD_T_UNCOORDINATED) {
+                    atomic_inc(&uncoordinated_discard_disabled);
+                }
+                return ret;
+            }
+        }
+    }
     return 0;
 }
 
-bool ram_block_discard_is_disabled(void)
+bool ram_block_discard_type_is_disabled(RamBlockDiscardType type)
 {
-    return atomic_read(&ram_block_discard_disabled) > 0;
+    if (type & RAM_BLOCK_DISCARD_T_UNCOORDINATED &&
+        atomic_read(&uncoordinated_discard_disabled) > 0) {
+        return true;
+    } else if (type & RAM_BLOCK_DISCARD_T_COORDINATED &&
+               atomic_read(&coordinated_discard_disabled) > 0) {
+        return true;
+    }
+    return false;
 }
 
-bool ram_block_discard_is_required(void)
+bool ram_block_discard_type_is_required(RamBlockDiscardType type)
 {
-    return atomic_read(&ram_block_discard_disabled) < 0;
+    if (type & RAM_BLOCK_DISCARD_T_UNCOORDINATED &&
+        atomic_read(&uncoordinated_discard_disabled) < 0) {
+        return true;
+    } else if (type & RAM_BLOCK_DISCARD_T_COORDINATED &&
+               atomic_read(&coordinated_discard_disabled) < 0) {
+        return true;
+    }
+    return false;
 }
 
 #endif
diff --git a/include/exec/memory.h b/include/exec/memory.h
index 2931ead730..3169ebc3d9 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -2588,6 +2588,18 @@ static inline MemOp devend_memop(enum device_endian end)
 }
 #endif
 
+typedef enum RamBlockDiscardType {
+    /* Uncorrdinated discards (e.g., virtio-balloon */
+    RAM_BLOCK_DISCARD_T_UNCOORDINATED = 1,
+    /*
+     * Coordinated discards on selected memory regions (e.g., virtio-mem via
+     * SparseRamNotifier).
+     */
+    RAM_BLOCK_DISCARD_T_COORDINATED =   2,
+    /* Any type of discards */
+    RAM_BLOCK_DISCARD_T_ANY =           3,
+} RamBlockDiscardType;
+
 /*
  * Inhibit technologies that require discarding of pages in RAM blocks, e.g.,
  * to manage the actual amount of memory consumed by the VM (then, the memory
@@ -2609,7 +2621,11 @@ static inline MemOp devend_memop(enum device_endian end)
  * Returns 0 if successful. Returns -EBUSY if a technology that relies on
  * discards to work reliably is active.
  */
-int ram_block_discard_disable(bool state);
+int ram_block_discard_type_disable(RamBlockDiscardType type, bool state);
+static inline int ram_block_discard_disable(bool state)
+{
+    return ram_block_discard_type_disable(RAM_BLOCK_DISCARD_T_ANY, state);
+}
 
 /*
  * Inhibit technologies that disable discarding of pages in RAM blocks.
@@ -2617,17 +2633,29 @@ int ram_block_discard_disable(bool state);
  * Returns 0 if successful. Returns -EBUSY if discards are already set to
  * broken.
  */
-int ram_block_discard_require(bool state);
+int ram_block_discard_type_require(RamBlockDiscardType type, bool state);
+static inline int ram_block_discard_require(bool state)
+{
+    return ram_block_discard_type_require(RAM_BLOCK_DISCARD_T_ANY, state);
+}
 
 /*
  * Test if discarding of memory in ram blocks is disabled.
  */
-bool ram_block_discard_is_disabled(void);
+bool ram_block_discard_type_is_disabled(RamBlockDiscardType type);
+static inline bool ram_block_discard_is_disabled(void)
+{
+    return ram_block_discard_type_is_disabled(RAM_BLOCK_DISCARD_T_ANY);
+}
 
 /*
  * Test if discarding of memory in ram blocks is required to work reliably.
  */
-bool ram_block_discard_is_required(void);
+bool ram_block_discard_type_is_required(RamBlockDiscardType type);
+static inline bool ram_block_discard_is_required(void)
+{
+    return ram_block_discard_type_is_required(RAM_BLOCK_DISCARD_T_ANY);
+}
 
 #endif
 
-- 
2.26.2


