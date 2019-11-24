Return-Path: <SRS0=aI0a=ZQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DD8CC432C0
	for <qemu-devel@archiver.kernel.org>; Sun, 24 Nov 2019 20:11:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52AFB207DD
	for <qemu-devel@archiver.kernel.org>; Sun, 24 Nov 2019 20:11:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=apple.com header.i=@apple.com header.b="jeBGhlrG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52AFB207DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38576 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iYyE2-0005U1-H7
	for qemu-devel@archiver.kernel.org; Sun, 24 Nov 2019 15:11:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43997)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dirty@apple.com>) id 1iYy8S-0006rr-Vz
 for qemu-devel@nongnu.org; Sun, 24 Nov 2019 15:05:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dirty@apple.com>) id 1iYy8R-0007vI-L7
 for qemu-devel@nongnu.org; Sun, 24 Nov 2019 15:05:32 -0500
Received: from ma1-aaemail-dr-lapp02.apple.com ([17.171.2.68]:53909)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dirty@apple.com>) id 1iYy8R-0007ua-F1
 for qemu-devel@nongnu.org; Sun, 24 Nov 2019 15:05:31 -0500
Received: from pps.filterd (ma1-aaemail-dr-lapp02.apple.com [127.0.0.1])
 by ma1-aaemail-dr-lapp02.apple.com (8.16.0.27/8.16.0.27) with SMTP id
 xAOK1tPU034870; Sun, 24 Nov 2019 12:05:30 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=apple.com;
 h=sender : from : to :
 cc : subject : date : message-id : in-reply-to : references : mime-version
 : content-transfer-encoding; s=20180706;
 bh=190VOV5d/wVUGjW4hRluqOG2h2O9F6SznXz4SwcJ7rA=;
 b=jeBGhlrGWttwvi1oKkPi4rl1d57cviDfNYwUyo0Szh6zMDiGtILjIlepgTQnLLRLQqWN
 hClGlVy3CxFGuTRwRwMzoQ7kdtcsG35fZfez22tZjyAQAGGDcFEuaskWiEFzaSHNIYnB
 keCpN+qN+zbEvKCeYexmDWZBmfmk7/6svOEit7M8BaZSFIvHVxust08rRhhaipmU3urn
 MiCCkVD8RkxgA6IDWDmvKMGpAEYNjAVhDA15AQtUByZZiMVMwT/jJ4ik1SIr34pHlhW5
 ySi5DJy7elzTyr4NC+3Y+Bg/1one5I10XaHCZU3wVyqYdRPzyy9nff8OzFvmL2nq0HpN vg== 
Received: from mr2-mtap-s03.rno.apple.com (mr2-mtap-s03.rno.apple.com
 [17.179.226.135])
 by ma1-aaemail-dr-lapp02.apple.com with ESMTP id 2wf2aw5bw0-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
 Sun, 24 Nov 2019 12:05:29 -0800
Received: from nwk-mmpp-sz10.apple.com
 (nwk-mmpp-sz10.apple.com [17.128.115.122]) by mr2-mtap-s03.rno.apple.com
 (Oracle Communications Messaging Server 8.0.2.4.20190507 64bit (built May  7
 2019)) with ESMTPS id <0Q1H0042UP55WU20@mr2-mtap-s03.rno.apple.com>; Sun,
 24 Nov 2019 12:05:29 -0800 (PST)
Received: from process_milters-daemon.nwk-mmpp-sz10.apple.com by
 nwk-mmpp-sz10.apple.com
 (Oracle Communications Messaging Server 8.0.2.4.20190507 64bit (built May  7
 2019)) id <0Q1H00F00P3BWT00@nwk-mmpp-sz10.apple.com>; Sun,
 24 Nov 2019 12:05:29 -0800 (PST)
X-Va-A: 
X-Va-T-CD: 
X-Va-E-CD: 
X-Va-R-CD: 
X-Va-CD: 0
X-Va-ID: 45e2f30e-f302-4fb1-921c-e7f47da90177
X-V-A: 
X-V-T-CD: c56cc4374afe9162bf6a337f3d661529
X-V-E-CD: b8ea6ba6ea75089f272611baa8314f7c
X-V-R-CD: 0cffc2e7e4b9540a483226a3303f2f95
X-V-CD: 0
X-V-ID: ab0c7aad-429d-46e4-9d0a-ec6e2f1dcbf7
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,,
 definitions=2019-11-24_02:,, signatures=0
Received: from pontoon.com (unknown [17.234.36.164]) by nwk-mmpp-sz10.apple.com
 (Oracle Communications Messaging Server 8.0.2.4.20190507 64bit (built May  7
 2019)) with ESMTPSA id <0Q1H000C0P54NN30@nwk-mmpp-sz10.apple.com>; Sun,
 24 Nov 2019 12:05:29 -0800 (PST)
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
Subject: [PATCH v2 1/5] hvf: non-RAM, non-ROMD memory ranges are now correctly
 mapped in
Date: Sun, 24 Nov 2019 12:05:23 -0800
Message-id: <1d8476c8f86959273fbdf23c86f8b4b611f5e2e1.1574625592.git.dirty@apple.com>
X-Mailer: git-send-email 2.24.0
In-reply-to: <cover.1574625592.git.dirty@apple.com>
References: <cover.1574625592.git.dirty@apple.com>
MIME-version: 1.0
Content-transfer-encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-11-24_02:, , signatures=0
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 17.171.2.68
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Reply-to: Cameron Esfahani <dirty@apple.com>
From: Cameron Esfahani via <qemu-devel@nongnu.org>

If an area is non-RAM and non-ROMD, then remove mappings so accesses
will trap and can be emulated.  Change hvf_find_overlap_slot() to take
a size instead of an end address: it wouldn't return a slot because
callers would pass the same address for start and end.  Don't always
map area as read/write/execute, respect area flags.

Signed-off-by: Cameron Esfahani <dirty@apple.com>
---
 target/i386/hvf/hvf.c | 50 ++++++++++++++++++++++++++++++-------------
 1 file changed, 35 insertions(+), 15 deletions(-)

diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index 231732aaf7..0b50cfcbc6 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -107,14 +107,14 @@ static void assert_hvf_ok(hv_return_t ret)
 }
 
 /* Memory slots */
-hvf_slot *hvf_find_overlap_slot(uint64_t start, uint64_t end)
+hvf_slot *hvf_find_overlap_slot(uint64_t start, uint64_t size)
 {
     hvf_slot *slot;
     int x;
     for (x = 0; x < hvf_state->num_slots; ++x) {
         slot = &hvf_state->slots[x];
         if (slot->size && start < (slot->start + slot->size) &&
-            end > slot->start) {
+            (start + size) > slot->start) {
             return slot;
         }
     }
@@ -129,12 +129,10 @@ struct mac_slot {
 };
 
 struct mac_slot mac_slots[32];
-#define ALIGN(x, y)  (((x) + (y) - 1) & ~((y) - 1))
 
-static int do_hvf_set_memory(hvf_slot *slot)
+static int do_hvf_set_memory(hvf_slot *slot, hv_memory_flags_t flags)
 {
     struct mac_slot *macslot;
-    hv_memory_flags_t flags;
     hv_return_t ret;
 
     macslot = &mac_slots[slot->slot_id];
@@ -151,8 +149,6 @@ static int do_hvf_set_memory(hvf_slot *slot)
         return 0;
     }
 
-    flags = HV_MEMORY_READ | HV_MEMORY_WRITE | HV_MEMORY_EXEC;
-
     macslot->present = 1;
     macslot->gpa_start = slot->start;
     macslot->size = slot->size;
@@ -165,14 +161,24 @@ void hvf_set_phys_mem(MemoryRegionSection *section, bool add)
 {
     hvf_slot *mem;
     MemoryRegion *area = section->mr;
+    bool writeable = !area->readonly && !area->rom_device;
+    hv_memory_flags_t flags;
 
     if (!memory_region_is_ram(area)) {
-        return;
+        if (writeable) {
+            return;
+        } else if (!memory_region_is_romd(area)) {
+            /*
+             * If the memory device is not in romd_mode, then we actually want
+             * to remove the hvf memory slot so all accesses will trap.
+             */
+             add = false;
+        }
     }
 
     mem = hvf_find_overlap_slot(
             section->offset_within_address_space,
-            section->offset_within_address_space + int128_get64(section->size));
+            int128_get64(section->size));
 
     if (mem && add) {
         if (mem->size == int128_get64(section->size) &&
@@ -186,7 +192,7 @@ void hvf_set_phys_mem(MemoryRegionSection *section, bool add)
     /* Region needs to be reset. set the size to 0 and remap it. */
     if (mem) {
         mem->size = 0;
-        if (do_hvf_set_memory(mem)) {
+        if (do_hvf_set_memory(mem, 0)) {
             error_report("Failed to reset overlapping slot");
             abort();
         }
@@ -196,6 +202,13 @@ void hvf_set_phys_mem(MemoryRegionSection *section, bool add)
         return;
     }
 
+    if (area->readonly ||
+        (!memory_region_is_ram(area) && memory_region_is_romd(area))) {
+        flags = HV_MEMORY_READ | HV_MEMORY_EXEC;
+    } else {
+        flags = HV_MEMORY_READ | HV_MEMORY_WRITE | HV_MEMORY_EXEC;
+    }
+
     /* Now make a new slot. */
     int x;
 
@@ -216,7 +229,7 @@ void hvf_set_phys_mem(MemoryRegionSection *section, bool add)
     mem->start = section->offset_within_address_space;
     mem->region = area;
 
-    if (do_hvf_set_memory(mem)) {
+    if (do_hvf_set_memory(mem, flags)) {
         error_report("Error registering new memory slot");
         abort();
     }
@@ -345,7 +358,14 @@ static bool ept_emulation_fault(hvf_slot *slot, uint64_t gpa, uint64_t ept_qual)
         return false;
     }
 
-    return !slot;
+    if (!slot) {
+        return true;
+    }
+    if (!memory_region_is_ram(slot->region) &&
+        !(read && memory_region_is_romd(slot->region))) {
+        return true;
+    }
+    return false;
 }
 
 static void hvf_set_dirty_tracking(MemoryRegionSection *section, bool on)
@@ -354,7 +374,7 @@ static void hvf_set_dirty_tracking(MemoryRegionSection *section, bool on)
 
     slot = hvf_find_overlap_slot(
             section->offset_within_address_space,
-            section->offset_within_address_space + int128_get64(section->size));
+            int128_get64(section->size));
 
     /* protect region against writes; begin tracking it */
     if (on) {
@@ -720,7 +740,7 @@ int hvf_vcpu_exec(CPUState *cpu)
             ret = EXCP_INTERRUPT;
             break;
         }
-            /* Need to check if MMIO or unmmaped fault */
+        /* Need to check if MMIO or unmapped fault */
         case EXIT_REASON_EPT_FAULT:
         {
             hvf_slot *slot;
@@ -731,7 +751,7 @@ int hvf_vcpu_exec(CPUState *cpu)
                 vmx_set_nmi_blocking(cpu);
             }
 
-            slot = hvf_find_overlap_slot(gpa, gpa);
+            slot = hvf_find_overlap_slot(gpa, 1);
             /* mmio */
             if (ept_emulation_fault(slot, gpa, exit_qual)) {
                 struct x86_decode decode;
-- 
2.24.0


