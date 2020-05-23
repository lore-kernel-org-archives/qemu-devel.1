Return-Path: <SRS0=y3lU=7F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0A91C433E0
	for <qemu-devel@archiver.kernel.org>; Sat, 23 May 2020 23:23:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C8BB20735
	for <qemu-devel@archiver.kernel.org>; Sat, 23 May 2020 23:23:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U+Q3lfgg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C8BB20735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57398 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jcdU6-0003X7-LP
	for qemu-devel@archiver.kernel.org; Sat, 23 May 2020 19:23:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45218)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1jcdRo-0007EE-S0
 for qemu-devel@nongnu.org; Sat, 23 May 2020 19:20:56 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26510
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1jcdRn-0000T0-GO
 for qemu-devel@nongnu.org; Sat, 23 May 2020 19:20:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590276054;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q7lpYJgfXHjUejHCMRc3Hs6VZqb4ZQYOtRCAVzuAg1M=;
 b=U+Q3lfggw8+gSTklv2XecVrZM3kyEzCqGX6dvSmPDEnV6tQZiaiI54VZyDmfW7K8QqGf5z
 6egGQgH8rW8FU8PgOi4vz1/AdMmWz3fO6x4xem4MDJu6wPu6er4cLCNA/1JrGmW7oAmBr8
 MQJs2RoeWlDBvLXHiQ7UxBgdEWNArug=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-212-jpiwamIHNImv7VczGuQASg-1; Sat, 23 May 2020 19:20:50 -0400
X-MC-Unique: jpiwamIHNImv7VczGuQASg-1
Received: by mail-qv1-f71.google.com with SMTP id q10so14159348qvs.16
 for <qemu-devel@nongnu.org>; Sat, 23 May 2020 16:20:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Q7lpYJgfXHjUejHCMRc3Hs6VZqb4ZQYOtRCAVzuAg1M=;
 b=N/XSHLtEyrbEcEvbYYe2iUq0psaWX3xBpn+KuaEry1vmpSOuW+T6FeWQGeKOBmmDnt
 WR4KQZoAc/m0uo/cEcBkEK3W+OL98R2Guiz4IQwgw/549OR04o2+WTyrkcRBmaS0SVk4
 fKNYfkOl99jUijx0oSlIk+w/zvZIyFjpjJw6YTfyNkCFYSRfaZY6/Fb24dS4eyJW+gMZ
 q5/9S+E6/u2e2npWQFOWf5IYXqPn2ZL56n3f77D+96YgRGIMopk7izSkh7epyw0Jq49M
 YR5K766PijiR3oi98MHtTbqmIB8Tzr7bzyLo3qd/34kv3lBgwz+YK6lCCRUNbB4gkI9R
 t24g==
X-Gm-Message-State: AOAM532KjJOAJQW1aLOXiyDAnnxWmgs5p2Gf0GP7gzYLbD4O1IKrJ7cu
 yapLX4P5xdfSXiwQbPo3QSJv9LglsG2JHzqOzrC9cNI+mwYnclb/roCLc8KQlw5tuzOkAEZ+sg7
 gq/QgN5U/zmJ//To=
X-Received: by 2002:a37:270a:: with SMTP id n10mr20640739qkn.288.1590276049940; 
 Sat, 23 May 2020 16:20:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwglEXiOFQrCU0NTiOYvGdAvbtIQBrn5Rgi+z3Cl2PSrQn0jhZpDjOJfZhdCXga8QOUVCBodQ==
X-Received: by 2002:a37:270a:: with SMTP id n10mr20640707qkn.288.1590276049419; 
 Sat, 23 May 2020 16:20:49 -0700 (PDT)
Received: from xz-x1.hitronhub.home ([2607:9880:19c0:32::2])
 by smtp.gmail.com with ESMTPSA id m33sm11974235qtb.88.2020.05.23.16.20.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 May 2020 16:20:48 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH RFC v3 07/11] KVM: Provide helper to sync dirty bitmap from
 slot to ramblock
Date: Sat, 23 May 2020 19:20:31 -0400
Message-Id: <20200523232035.1029349-8-peterx@redhat.com>
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

kvm_physical_sync_dirty_bitmap() calculates the ramblock offset in an
awkward way from the MemoryRegionSection that passed in from the
caller.  The truth is for each KVMSlot the ramblock offset never
change for the lifecycle.  Cache the ramblock offset for each KVMSlot
into the structure when the KVMSlot is created.

With that, we can further simplify kvm_physical_sync_dirty_bitmap()
with a helper to sync KVMSlot dirty bitmap to the ramblock dirty
bitmap of a specific KVMSlot.

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 accel/kvm/kvm-all.c      | 37 +++++++++++++++++--------------------
 include/sysemu/kvm_int.h |  2 ++
 2 files changed, 19 insertions(+), 20 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 5892e5db24..016bad1089 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -528,15 +528,12 @@ static void kvm_log_stop(MemoryListener *listener,
 }
 
 /* get kvm's dirty pages bitmap and update qemu's */
-static int kvm_get_dirty_pages_log_range(MemoryRegionSection *section,
-                                         unsigned long *bitmap)
+static void kvm_slot_sync_dirty_pages(KVMSlot *slot)
 {
-    ram_addr_t start = section->offset_within_region +
-                       memory_region_get_ram_addr(section->mr);
-    ram_addr_t pages = int128_get64(section->size) / qemu_real_host_page_size;
+    ram_addr_t start = slot->ram_start_offset;
+    ram_addr_t pages = slot->memory_size / qemu_real_host_page_size;
 
-    cpu_physical_memory_set_dirty_lebitmap(bitmap, start, pages);
-    return 0;
+    cpu_physical_memory_set_dirty_lebitmap(slot->dirty_bmap, start, pages);
 }
 
 #define ALIGN(x, y)  (((x)+(y)-1) & ~((y)-1))
@@ -598,12 +595,10 @@ static void kvm_physical_sync_dirty_bitmap(KVMMemoryListener *kml,
     KVMState *s = kvm_state;
     KVMSlot *mem;
     hwaddr start_addr, size;
-    hwaddr slot_size, slot_offset = 0;
+    hwaddr slot_size;
 
     size = kvm_align_section(section, &start_addr);
     while (size) {
-        MemoryRegionSection subsection = *section;
-
         slot_size = MIN(kvm_max_slot_size, size);
         mem = kvm_lookup_matching_slot(kml, start_addr, slot_size);
         if (!mem) {
@@ -612,12 +607,7 @@ static void kvm_physical_sync_dirty_bitmap(KVMMemoryListener *kml,
         }
 
         kvm_slot_get_dirty_log(s, mem);
-
-        subsection.offset_within_region += slot_offset;
-        subsection.size = int128_make64(slot_size);
-        kvm_get_dirty_pages_log_range(&subsection, mem->dirty_bmap);
-
-        slot_offset += slot_size;
+        kvm_slot_sync_dirty_pages(mem);
         start_addr += slot_size;
         size -= slot_size;
     }
@@ -1072,7 +1062,8 @@ static void kvm_set_phys_mem(KVMMemoryListener *kml,
     int err;
     MemoryRegion *mr = section->mr;
     bool writeable = !mr->readonly && !mr->rom_device;
-    hwaddr start_addr, size, slot_size;
+    hwaddr start_addr, size, slot_size, mr_offset;
+    ram_addr_t ram_start_offset;
     void *ram;
 
     if (!memory_region_is_ram(mr)) {
@@ -1090,9 +1081,13 @@ static void kvm_set_phys_mem(KVMMemoryListener *kml,
         return;
     }
 
-    /* use aligned delta to align the ram address */
-    ram = memory_region_get_ram_ptr(mr) + section->offset_within_region +
-          (start_addr - section->offset_within_address_space);
+    /* The offset of the kvmslot within the memory region */
+    mr_offset = section->offset_within_region + start_addr -
+        section->offset_within_address_space;
+
+    /* use aligned delta to align the ram address and offset */
+    ram = memory_region_get_ram_ptr(mr) + mr_offset;
+    ram_start_offset = memory_region_get_ram_addr(mr) + mr_offset;
 
     kvm_slots_lock();
 
@@ -1131,6 +1126,7 @@ static void kvm_set_phys_mem(KVMMemoryListener *kml,
         mem->as_id = kml->as_id;
         mem->memory_size = slot_size;
         mem->start_addr = start_addr;
+        mem->ram_start_offset = ram_start_offset;
         mem->ram = ram;
         mem->flags = kvm_mem_flags(mr);
         kvm_slot_init_dirty_bitmap(mem);
@@ -1141,6 +1137,7 @@ static void kvm_set_phys_mem(KVMMemoryListener *kml,
             abort();
         }
         start_addr += slot_size;
+        ram_start_offset += slot_size;
         ram += slot_size;
         size -= slot_size;
     } while (size);
diff --git a/include/sysemu/kvm_int.h b/include/sysemu/kvm_int.h
index 1202593c6f..4a35d04478 100644
--- a/include/sysemu/kvm_int.h
+++ b/include/sysemu/kvm_int.h
@@ -25,6 +25,8 @@ typedef struct KVMSlot
     unsigned long *dirty_bmap;
     /* Cache of the address space ID */
     int as_id;
+    /* Cache of the offset in ram address space */
+    ram_addr_t ram_start_offset;
 } KVMSlot;
 
 typedef struct KVMMemoryListener {
-- 
2.26.2


