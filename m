Return-Path: <SRS0=y3lU=7F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8C6AC433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 23 May 2020 23:24:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 828EB20735
	for <qemu-devel@archiver.kernel.org>; Sat, 23 May 2020 23:24:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZgpdMl01"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 828EB20735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36720 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jcdVX-0006e1-P4
	for qemu-devel@archiver.kernel.org; Sat, 23 May 2020 19:24:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45208)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1jcdRk-00073o-P5
 for qemu-devel@nongnu.org; Sat, 23 May 2020 19:20:52 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39748
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1jcdRj-0000Ph-Mh
 for qemu-devel@nongnu.org; Sat, 23 May 2020 19:20:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590276050;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JgiXqJdocjs6ojtSv1dZyKhTcnEi//h2D85kl65AfV8=;
 b=ZgpdMl01Bs8y07rr8acNNb2vT+aIJd2d5uWgPbJj9IzF47UTKH480e7BGjYPTaZpicK5HF
 ZBEo8QL5YByGjraORilqevpHWpv//LGrdmvDzNP18sg+e/SHT7E6bM8UU1evm1nd/g10Yb
 WolczEW0z4ZTGCayD506tAItHE2z460=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-194-fyjuABdKMWyQHisdTxjjDg-1; Sat, 23 May 2020 19:20:48 -0400
X-MC-Unique: fyjuABdKMWyQHisdTxjjDg-1
Received: by mail-qt1-f197.google.com with SMTP id e43so16095313qtc.3
 for <qemu-devel@nongnu.org>; Sat, 23 May 2020 16:20:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=JgiXqJdocjs6ojtSv1dZyKhTcnEi//h2D85kl65AfV8=;
 b=pOZFjNKqohDhG0dCE7+Cn87oGWbRDLR5oEtrz8n5G70aAP2JKO20RA3juVPzUeWHMY
 ujv0sZnbJOoJ3iKhk4VQWKasvlWrppoaASUvSe0egvgx8EbuOwFLpnuVNAU7odT+ABMw
 WFexF5iaJ/5PS0iu77bZ9ABhC3TNAm801IgHecqpwglFwJLHB8wiVQP74eZsNHvP4dP2
 RT0xTlQVRKYPopiQx7/J9P3EOlv+ybVfcioqezcoaPvEPRaDHuXkEqsxzN6WKklc7X42
 dQsUYjnCb4o8x6NQME4jXCm2pI8WjTLlE5rZzJJZXAIOj0USzTIVX0FSU4SiL3DkZnbs
 oD3g==
X-Gm-Message-State: AOAM533tcvsgGLgBKfUt6yiuLKgm5ygiLX8VqpFVo3OhVMUX4lQztH1B
 jdZR+m91nBPCyK+u9dPnZLCtFmEVjxWGwXywNrorKL9fuYXIv4Y6b1irKwiZRPhHmEuz9ycs6p6
 sB/eGegcGUXKx6oA=
X-Received: by 2002:ac8:2aa6:: with SMTP id b35mr21306280qta.153.1590276048062; 
 Sat, 23 May 2020 16:20:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzs0vg/y6eIbpzQ2fF5thNQhI0PmOP+nagnrTg4EvWSE8CNSGTTC8+7+6T2Tv+Ww5uFF7QRUw==
X-Received: by 2002:ac8:2aa6:: with SMTP id b35mr21306267qta.153.1590276047812; 
 Sat, 23 May 2020 16:20:47 -0700 (PDT)
Received: from xz-x1.hitronhub.home ([2607:9880:19c0:32::2])
 by smtp.gmail.com with ESMTPSA id m33sm11974235qtb.88.2020.05.23.16.20.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 May 2020 16:20:47 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH RFC v3 06/11] KVM: Provide helper to get kvm dirty log
Date: Sat, 23 May 2020 19:20:30 -0400
Message-Id: <20200523232035.1029349-7-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200523232035.1029349-1-peterx@redhat.com>
References: <20200523232035.1029349-1-peterx@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=peterx@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/23 19:07:45
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Provide a helper kvm_slot_get_dirty_log() to make the function
kvm_physical_sync_dirty_bitmap() clearer.  We can even cache the as_id
into KVMSlot when it is created, so that we don't even need to pass it
down every time.

Since at it, remove return value of kvm_physical_sync_dirty_bitmap()
because it should never fail.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 accel/kvm/kvm-all.c      | 42 +++++++++++++++++++++-------------------
 include/sysemu/kvm_int.h |  2 ++
 2 files changed, 24 insertions(+), 20 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 5b626af2a7..5892e5db24 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -566,6 +566,21 @@ static void kvm_slot_init_dirty_bitmap(KVMSlot *mem)
     mem->dirty_bmap = g_malloc0(bitmap_size);
 }
 
+/* Sync dirty bitmap from kernel to KVMSlot.dirty_bmap */
+static void kvm_slot_get_dirty_log(KVMState *s, KVMSlot *slot)
+{
+    struct kvm_dirty_log d = {};
+    int ret;
+
+    d.dirty_bitmap = slot->dirty_bmap;
+    d.slot = slot->slot | (slot->as_id << 16);
+    ret = kvm_vm_ioctl(s, KVM_GET_DIRTY_LOG, &d);
+    if (ret) {
+        error_report_once("%s: KVM_GET_DIRTY_LOG failed with %d",
+                          __func__, ret);
+    }
+}
+
 /**
  * kvm_physical_sync_dirty_bitmap - Sync dirty bitmap from kernel space
  *
@@ -577,15 +592,13 @@ static void kvm_slot_init_dirty_bitmap(KVMSlot *mem)
  * @kml: the KVM memory listener object
  * @section: the memory section to sync the dirty bitmap with
  */
-static int kvm_physical_sync_dirty_bitmap(KVMMemoryListener *kml,
-                                          MemoryRegionSection *section)
+static void kvm_physical_sync_dirty_bitmap(KVMMemoryListener *kml,
+                                           MemoryRegionSection *section)
 {
     KVMState *s = kvm_state;
-    struct kvm_dirty_log d = {};
     KVMSlot *mem;
     hwaddr start_addr, size;
     hwaddr slot_size, slot_offset = 0;
-    int ret = 0;
 
     size = kvm_align_section(section, &start_addr);
     while (size) {
@@ -595,27 +608,19 @@ static int kvm_physical_sync_dirty_bitmap(KVMMemoryListener *kml,
         mem = kvm_lookup_matching_slot(kml, start_addr, slot_size);
         if (!mem) {
             /* We don't have a slot if we want to trap every access. */
-            goto out;
+            return;
         }
 
-        d.dirty_bitmap = mem->dirty_bmap;
-        d.slot = mem->slot | (kml->as_id << 16);
-        if (kvm_vm_ioctl(s, KVM_GET_DIRTY_LOG, &d) == -1) {
-            DPRINTF("ioctl failed %d\n", errno);
-            ret = -1;
-            goto out;
-        }
+        kvm_slot_get_dirty_log(s, mem);
 
         subsection.offset_within_region += slot_offset;
         subsection.size = int128_make64(slot_size);
-        kvm_get_dirty_pages_log_range(&subsection, d.dirty_bitmap);
+        kvm_get_dirty_pages_log_range(&subsection, mem->dirty_bmap);
 
         slot_offset += slot_size;
         start_addr += slot_size;
         size -= slot_size;
     }
-out:
-    return ret;
 }
 
 /* Alignment requirement for KVM_CLEAR_DIRTY_LOG - 64 pages */
@@ -1123,6 +1128,7 @@ static void kvm_set_phys_mem(KVMMemoryListener *kml,
     do {
         slot_size = MIN(kvm_max_slot_size, size);
         mem = kvm_alloc_slot(kml);
+        mem->as_id = kml->as_id;
         mem->memory_size = slot_size;
         mem->start_addr = start_addr;
         mem->ram = ram;
@@ -1165,14 +1171,10 @@ static void kvm_log_sync(MemoryListener *listener,
                          MemoryRegionSection *section)
 {
     KVMMemoryListener *kml = container_of(listener, KVMMemoryListener, listener);
-    int r;
 
     kvm_slots_lock();
-    r = kvm_physical_sync_dirty_bitmap(kml, section);
+    kvm_physical_sync_dirty_bitmap(kml, section);
     kvm_slots_unlock();
-    if (r < 0) {
-        abort();
-    }
 }
 
 static void kvm_log_clear(MemoryListener *listener,
diff --git a/include/sysemu/kvm_int.h b/include/sysemu/kvm_int.h
index f143b28671..1202593c6f 100644
--- a/include/sysemu/kvm_int.h
+++ b/include/sysemu/kvm_int.h
@@ -23,6 +23,8 @@ typedef struct KVMSlot
     int old_flags;
     /* Dirty bitmap cache for the slot */
     unsigned long *dirty_bmap;
+    /* Cache of the address space ID */
+    int as_id;
 } KVMSlot;
 
 typedef struct KVMMemoryListener {
-- 
2.26.2


