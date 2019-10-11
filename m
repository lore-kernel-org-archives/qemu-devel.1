Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0F44C47404
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 09:43:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDDB521A4A
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 09:43:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="CxOYQxpy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDDB521A4A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47944 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIrRu-0004xb-V1
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 05:43:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56762)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wrfsh@yandex-team.ru>) id 1iIrR7-0004WX-Hf
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 05:42:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wrfsh@yandex-team.ru>) id 1iIrR2-0004bU-Oz
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 05:42:10 -0400
Received: from forwardcorp1j.mail.yandex.net ([5.45.199.163]:55702)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wrfsh@yandex-team.ru>)
 id 1iIrR1-0004XV-DX
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 05:42:08 -0400
Received: from mxbackcorp2j.mail.yandex.net (mxbackcorp2j.mail.yandex.net
 [IPv6:2a02:6b8:0:1619::119])
 by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id CFB452E152C;
 Fri, 11 Oct 2019 12:42:02 +0300 (MSK)
Received: from iva4-c987840161f8.qloud-c.yandex.net
 (iva4-c987840161f8.qloud-c.yandex.net [2a02:6b8:c0c:3da5:0:640:c987:8401])
 by mxbackcorp2j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id
 k0KrCIfsq3-fxNqNpw6; Fri, 11 Oct 2019 12:42:02 +0300
Precedence: bulk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1570786922; bh=gl4dACh8Ysa9/QQlnDAb4qkbAU/LWiPqFovYBf+OgOE=;
 h=Message-Id:Date:Subject:To:From:Cc;
 b=CxOYQxpylB0VENqzVXF1kDbdB4VigtgZSY6UFmqFeBVSqgX0Ow8lZxxJIzTph3443
 Ksj9HVM3QvcNrR/U7KGTqhXZ5f34wTyGgoczXOuh80LMlir8q349kcAje4fbSw7MgN
 Q9UcrPBQDUSKTvFTQ7GvDd13BSdOle/XI4m3VKLA=
Authentication-Results: mxbackcorp2j.mail.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net
 [2a02:6b8:0:40c:f68c:50ff:fee9:44bd])
 by iva4-c987840161f8.qloud-c.yandex.net (nwsmtp/Yandex) with ESMTPSA id
 pr0gtVuHzw-fxIekYpm; Fri, 11 Oct 2019 12:41:59 +0300
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (Client certificate not present)
From: Evgeny Yakovlev <wrfsh@yandex-team.ru>
To: pbonzini@redhat.com
Subject: [RFC PATCH] accel/kvm: respect section RO flag when mapping phys mem
Date: Fri, 11 Oct 2019 12:41:42 +0300
Message-Id: <1570786902-28681-1-git-send-email-wrfsh@yandex-team.ru>
X-Mailer: git-send-email 2.7.4
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 5.45.199.163
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-devel@nongnu.org, yc-core@yandex-team.ru
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Currently kvm_set_phys_mem looks at section's underlying memory region
to determine whether mapping is going to be RW or RO. This seems wrong.
For example, when x86 firmware attempts to reprogram q35 PAM registers
to mark bios shadow copy in RAM as RO. In that case we see section->mr
to be writable (pc.ram), but overriding section to be readonly.

This change enforces section's RO to be a priority if underlying memory
region is writable but specific section is not. But not the other way
around, elevating access rights through RW section over RO region
should not be allowed.

Signed-off-by: Evgeny Yakovlev <wrfsh@yandex-team.ru>
---
 accel/kvm/kvm-all.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index d2d96d7..6f9ed24 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -407,9 +407,16 @@ err:
  * dirty pages logging control
  */
 
-static int kvm_mem_flags(MemoryRegion *mr)
+static inline bool kvm_is_mem_readonly(MemoryRegionSection *section)
 {
-    bool readonly = mr->readonly || memory_region_is_romd(mr);
+    MemoryRegion *mr = section->mr;
+    return mr->readonly || memory_region_is_romd(mr) || section->readonly;
+}
+
+static int kvm_mem_flags(MemoryRegionSection *section)
+{
+    MemoryRegion *mr = section->mr;
+    bool readonly = kvm_is_mem_readonly(section);
     int flags = 0;
 
     if (memory_region_get_dirty_log_mask(mr) != 0) {
@@ -423,9 +430,9 @@ static int kvm_mem_flags(MemoryRegion *mr)
 
 /* Called with KVMMemoryListener.slots_lock held */
 static int kvm_slot_update_flags(KVMMemoryListener *kml, KVMSlot *mem,
-                                 MemoryRegion *mr)
+                                 MemoryRegionSection *section)
 {
-    mem->flags = kvm_mem_flags(mr);
+    mem->flags = kvm_mem_flags(section);
 
     /* If nothing changed effectively, no need to issue ioctl */
     if (mem->flags == mem->old_flags) {
@@ -457,7 +464,7 @@ static int kvm_section_update_flags(KVMMemoryListener *kml,
             goto out;
         }
 
-        ret = kvm_slot_update_flags(kml, mem, section->mr);
+        ret = kvm_slot_update_flags(kml, mem, section);
         start_addr += slot_size;
         size -= slot_size;
     }
@@ -1002,7 +1009,7 @@ static void kvm_set_phys_mem(KVMMemoryListener *kml,
     KVMSlot *mem;
     int err;
     MemoryRegion *mr = section->mr;
-    bool writeable = !mr->readonly && !mr->rom_device;
+    bool writeable = !kvm_is_mem_readonly(section);
     hwaddr start_addr, size, slot_size;
     void *ram;
 
@@ -1062,7 +1069,7 @@ static void kvm_set_phys_mem(KVMMemoryListener *kml,
         mem->memory_size = slot_size;
         mem->start_addr = start_addr;
         mem->ram = ram;
-        mem->flags = kvm_mem_flags(mr);
+        mem->flags = kvm_mem_flags(section);
 
         err = kvm_set_user_memory_region(kml, mem, true);
         if (err) {
-- 
2.7.4


