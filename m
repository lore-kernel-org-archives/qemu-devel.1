Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A294C04AB4
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 03:18:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EBFD2081C
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 03:18:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EBFD2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57091 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSYoV-0000un-K8
	for qemu-devel@archiver.kernel.org; Sun, 19 May 2019 23:18:11 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49216)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1hSYft-00028h-W9
	for qemu-devel@nongnu.org; Sun, 19 May 2019 23:09:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1hSYfs-0001lc-UI
	for qemu-devel@nongnu.org; Sun, 19 May 2019 23:09:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52752)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1hSYfs-0001lM-Lj
	for qemu-devel@nongnu.org; Sun, 19 May 2019 23:09:16 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 006AFF74A6
	for <qemu-devel@nongnu.org>; Mon, 20 May 2019 03:09:16 +0000 (UTC)
Received: from xz-x1.nay.redhat.com (dhcp-15-205.nay.redhat.com [10.66.15.205])
	by smtp.corp.redhat.com (Postfix) with ESMTP id D368E100200A;
	Mon, 20 May 2019 03:09:13 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon, 20 May 2019 11:08:34 +0800
Message-Id: <20190520030839.6795-11-peterx@redhat.com>
In-Reply-To: <20190520030839.6795-1-peterx@redhat.com>
References: <20190520030839.6795-1-peterx@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.38]);
	Mon, 20 May 2019 03:09:16 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 10/15] kvm: Persistent per kvmslot dirty
 bitmap
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
	"Dr . David Alan Gilbert" <dgilbert@redhat.com>,
	peterx@redhat.com, Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When synchronizing dirty bitmap from kernel KVM we do it in a
per-kvmslot fashion and we allocate the userspace bitmap for each of
the ioctl.  This patch instead make the bitmap cache be persistent
then we don't need to g_malloc0() every time.

More importantly, the cached per-kvmslot dirty bitmap will be further
used when we want to add support for the KVM_CLEAR_DIRTY_LOG and this
cached bitmap will be used to guarantee we won't clear any unknown
dirty bits otherwise that can be a severe data loss issue for
migration code.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 accel/kvm/kvm-all.c      | 39 +++++++++++++++++++++------------------
 include/sysemu/kvm_int.h |  2 ++
 2 files changed, 23 insertions(+), 18 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index b686531586..334c610918 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -497,31 +497,14 @@ static int kvm_physical_sync_dirty_bitmap(KVMMemoryListener *kml,
             return 0;
         }
 
-        /* XXX bad kernel interface alert
-         * For dirty bitmap, kernel allocates array of size aligned to
-         * bits-per-long.  But for case when the kernel is 64bits and
-         * the userspace is 32bits, userspace can't align to the same
-         * bits-per-long, since sizeof(long) is different between kernel
-         * and user space.  This way, userspace will provide buffer which
-         * may be 4 bytes less than the kernel will use, resulting in
-         * userspace memory corruption (which is not detectable by valgrind
-         * too, in most cases).
-         * So for now, let's align to 64 instead of HOST_LONG_BITS here, in
-         * a hope that sizeof(long) won't become >8 any time soon.
-         */
-        size = ALIGN(((mem->memory_size) >> TARGET_PAGE_BITS),
-                     /*HOST_LONG_BITS*/ 64) / 8;
-        d.dirty_bitmap = g_malloc0(size);
-
+        d.dirty_bitmap = mem->dirty_bmap;
         d.slot = mem->slot | (kml->as_id << 16);
         if (kvm_vm_ioctl(s, KVM_GET_DIRTY_LOG, &d) == -1) {
             DPRINTF("ioctl failed %d\n", errno);
-            g_free(d.dirty_bitmap);
             return -1;
         }
 
         kvm_get_dirty_pages_log_range(section, d.dirty_bitmap);
-        g_free(d.dirty_bitmap);
     }
 
     return 0;
@@ -765,6 +748,7 @@ static void kvm_set_phys_mem(KVMMemoryListener *kml,
     MemoryRegion *mr = section->mr;
     bool writeable = !mr->readonly && !mr->rom_device;
     hwaddr start_addr, size;
+    unsigned long bmap_size;
     void *ram;
 
     if (!memory_region_is_ram(mr)) {
@@ -796,6 +780,8 @@ static void kvm_set_phys_mem(KVMMemoryListener *kml,
         }
 
         /* unregister the slot */
+        g_free(mem->dirty_bmap);
+        mem->dirty_bmap = NULL;
         mem->memory_size = 0;
         mem->flags = 0;
         err = kvm_set_user_memory_region(kml, mem, false);
@@ -807,12 +793,29 @@ static void kvm_set_phys_mem(KVMMemoryListener *kml,
         return;
     }
 
+    /*
+     * XXX bad kernel interface alert For dirty bitmap, kernel
+     * allocates array of size aligned to bits-per-long.  But for case
+     * when the kernel is 64bits and the userspace is 32bits,
+     * userspace can't align to the same bits-per-long, since
+     * sizeof(long) is different between kernel and user space.  This
+     * way, userspace will provide buffer which may be 4 bytes less
+     * than the kernel will use, resulting in userspace memory
+     * corruption (which is not detectable by valgrind too, in most
+     * cases).  So for now, let's align to 64 instead of
+     * HOST_LONG_BITS here, in a hope that sizeof(long) won't become
+     * >8 any time soon.
+     */
+    bmap_size = ALIGN((size >> TARGET_PAGE_BITS),
+                      /*HOST_LONG_BITS*/ 64) / 8;
+
     /* register the new slot */
     mem = kvm_alloc_slot(kml);
     mem->memory_size = size;
     mem->start_addr = start_addr;
     mem->ram = ram;
     mem->flags = kvm_mem_flags(mr);
+    mem->dirty_bmap = g_malloc0(bmap_size);
 
     err = kvm_set_user_memory_region(kml, mem, true);
     if (err) {
diff --git a/include/sysemu/kvm_int.h b/include/sysemu/kvm_int.h
index f838412491..687a2ee423 100644
--- a/include/sysemu/kvm_int.h
+++ b/include/sysemu/kvm_int.h
@@ -21,6 +21,8 @@ typedef struct KVMSlot
     int slot;
     int flags;
     int old_flags;
+    /* Dirty bitmap cache for the slot */
+    unsigned long *dirty_bmap;
 } KVMSlot;
 
 typedef struct KVMMemoryListener {
-- 
2.17.1


