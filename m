Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86234C38A2A
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 17:42:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4300D20735
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 17:42:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VMzWfpUx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4300D20735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44656 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWkXv-0008Mt-7g
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 13:42:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58800)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jWkVy-0005NW-Nc
 for qemu-devel@nongnu.org; Thu, 07 May 2020 13:40:55 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21343
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jWkVv-00025j-VF
 for qemu-devel@nongnu.org; Thu, 07 May 2020 13:40:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588873251;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2wMVmnscOvXdUUKc8eZhTz1l5c5iydmPQgIyf73d85o=;
 b=VMzWfpUxGPGgKvAaHy5Rl3Zb+NT9JGAfv0asxK6uSgggXmeHruvI6mqRVHj+FY6G2Bs/BW
 /KXjnCkUSee3488IO3zjrYDpIng8ftnI1qABfVBb+ltdxwz42nxpTt5m2xba/YUOF6GrWJ
 juLSlcSTqlh22cwSHfzLtojLNchbYrg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-390-Tplu9WkLNQe-NrQ4jZZGwA-1; Thu, 07 May 2020 13:40:49 -0400
X-MC-Unique: Tplu9WkLNQe-NrQ4jZZGwA-1
Received: by mail-wm1-f70.google.com with SMTP id n127so2906780wme.4
 for <qemu-devel@nongnu.org>; Thu, 07 May 2020 10:40:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=EK0YTs2WjJpJ9cKioyfjmY5eFGfI2/p3egFVIS7vlDc=;
 b=jZCAZiks2Gp7ZgeUBaZS/t/PIWVxhXC4tLgJ33iQqHBmS65VR046O1p1I771wfWWhR
 xOMjUqIpJkq4EHxk3nmLT3h2MdQCthez3s+HB9ESJY8Ig9nYoOfhEGlBa0g5sml7+q1i
 1BgjpB56wL73qJ4CmUrcZGe0gBgwCRziubEM+GK5nEiuitYzOtCz1YjzLFGDAeVivYZ5
 Cmb1xo4pA3jb3Te6X8Z/iQS+rQ9/Q8heNJhKIVds9lCp7wGT9Uhxx7XAmbFU2ldi6jT+
 M3esT0BzdVOxxt3Wuhr8UCmphaa4FxQiLAW1NwGXfqm4/xcA2fEEYja2PaTWw9q4qjVA
 vh1w==
X-Gm-Message-State: AGi0Pubeh6CkOAZmePdchsQg1MSJzeZS4zepWV8cHHYEyqstPkLGkMyK
 iy7FW65Tx/tzutxMNrgGuR/W1G6Vj3phoOInSIUiXeBAqoRIc470Au7JUvSEoqvJl4AESoK5Zy9
 5R4Kto7FhACuSE9M=
X-Received: by 2002:a1c:e408:: with SMTP id b8mr11791887wmh.68.1588873247515; 
 Thu, 07 May 2020 10:40:47 -0700 (PDT)
X-Google-Smtp-Source: APiQypJNKCeLscbewHfqirCOlj1I+UwuOJ8UpyEKyRlcaEo8CwdFPVGogykaX35DBFg0PXn7Ag3RFA==
X-Received: by 2002:a1c:e408:: with SMTP id b8mr11791844wmh.68.1588873246946; 
 Thu, 07 May 2020 10:40:46 -0700 (PDT)
Received: from localhost.localdomain (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id m6sm2858835wrq.5.2020.05.07.10.40.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2020 10:40:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Subject: [PATCH 07/10] exec: Move all RAMBlock functions to 'exec/ramblock.h'
Date: Thu,  7 May 2020 19:39:55 +0200
Message-Id: <20200507173958.25894-8-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200507173958.25894-1-philmd@redhat.com>
References: <20200507173958.25894-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/07 03:15:48
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-block@nongnu.org,
 David Hildenbrand <david@redhat.com>, Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 qemu-ppc@nongnu.org, Keith Busch <kbusch@kernel.org>,
 Richard Henderson <rth@twiddle.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The RAMBlock API was dispersed in 3 different headers.
One of these headers, "exec/ram_addr.h", is restricted
to target dependent code. However these functions are
not target specific. Move all functions into a single
place.  Now all these functions can be accessed by
target-agnostic code.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 include/exec/cpu-common.h    |  24 -------
 include/exec/ram_addr.h      | 105 ---------------------------
 include/exec/ramblock.h      | 134 +++++++++++++++++++++++++++++++++++
 migration/migration.h        |   1 +
 accel/tcg/translate-all.c    |   2 -
 hw/block/nvme.c              |   2 +-
 hw/s390x/s390-stattrib-kvm.c |   1 -
 hw/s390x/s390-stattrib.c     |   1 -
 hw/s390x/s390-virtio-ccw.c   |   1 -
 hw/virtio/vhost-user.c       |   1 +
 hw/virtio/vhost.c            |   1 +
 hw/virtio/virtio-balloon.c   |   1 +
 memory.c                     |   1 +
 migration/migration.c        |   1 +
 migration/postcopy-ram.c     |   1 +
 migration/savevm.c           |   1 +
 stubs/ram-block.c            |   2 +-
 target/ppc/kvm.c             |   1 -
 target/s390x/kvm.c           |   1 -
 util/vfio-helpers.c          |   2 +-
 20 files changed, 145 insertions(+), 139 deletions(-)

diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index b47e5630e7..347ceb603b 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -49,25 +49,6 @@ typedef uint32_t CPUReadMemoryFunc(void *opaque, hwaddr =
addr);
 void qemu_ram_remap(ram_addr_t addr, ram_addr_t length);
 /* This should not be used by devices.  */
 ram_addr_t qemu_ram_addr_from_host(void *ptr);
-RAMBlock *qemu_ram_block_by_name(const char *name);
-RAMBlock *qemu_ram_block_from_host(void *ptr, bool round_offset,
-                                   ram_addr_t *offset);
-ram_addr_t qemu_ram_block_host_offset(RAMBlock *rb, void *host);
-void qemu_ram_set_idstr(RAMBlock *block, const char *name, DeviceState *de=
v);
-void qemu_ram_unset_idstr(RAMBlock *block);
-const char *qemu_ram_get_idstr(RAMBlock *rb);
-void *qemu_ram_get_host_addr(RAMBlock *rb);
-ram_addr_t qemu_ram_get_offset(RAMBlock *rb);
-ram_addr_t qemu_ram_get_used_length(RAMBlock *rb);
-bool qemu_ram_is_shared(RAMBlock *rb);
-bool qemu_ram_is_uf_zeroable(RAMBlock *rb);
-void qemu_ram_set_uf_zeroable(RAMBlock *rb);
-bool qemu_ram_is_migratable(RAMBlock *rb);
-void qemu_ram_set_migratable(RAMBlock *rb);
-void qemu_ram_unset_migratable(RAMBlock *rb);
-
-size_t qemu_ram_pagesize(RAMBlock *block);
-size_t qemu_ram_pagesize_largest(void);
=20
 void cpu_physical_memory_rw(hwaddr addr, void *buf,
                             hwaddr len, bool is_write);
@@ -100,11 +81,6 @@ void qemu_flush_coalesced_mmio_buffer(void);
=20
 void cpu_flush_icache_range(hwaddr start, hwaddr len);
=20
-typedef int (RAMBlockIterFunc)(RAMBlock *rb, void *opaque);
-
-int qemu_ram_foreach_block(RAMBlockIterFunc func, void *opaque);
-int ram_block_discard_range(RAMBlock *rb, uint64_t start, size_t length);
-
 #endif
=20
 #endif /* CPU_COMMON_H */
diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
index c61d5188f7..0deffad66f 100644
--- a/include/exec/ram_addr.h
+++ b/include/exec/ram_addr.h
@@ -26,112 +26,7 @@
 #include "exec/ramlist.h"
 #include "exec/ramblock.h"
=20
-/**
- * clear_bmap_size: calculate clear bitmap size
- *
- * @pages: number of guest pages
- * @shift: guest page number shift
- *
- * Returns: number of bits for the clear bitmap
- */
-static inline long clear_bmap_size(uint64_t pages, uint8_t shift)
-{
-    return DIV_ROUND_UP(pages, 1UL << shift);
-}
=20
-/**
- * clear_bmap_set: set clear bitmap for the page range
- *
- * @rb: the ramblock to operate on
- * @start: the start page number
- * @size: number of pages to set in the bitmap
- *
- * Returns: None
- */
-static inline void clear_bmap_set(RAMBlock *rb, uint64_t start,
-                                  uint64_t npages)
-{
-    uint8_t shift =3D rb->clear_bmap_shift;
-
-    bitmap_set_atomic(rb->clear_bmap, start >> shift,
-                      clear_bmap_size(npages, shift));
-}
-
-/**
- * clear_bmap_test_and_clear: test clear bitmap for the page, clear if set
- *
- * @rb: the ramblock to operate on
- * @page: the page number to check
- *
- * Returns: true if the bit was set, false otherwise
- */
-static inline bool clear_bmap_test_and_clear(RAMBlock *rb, uint64_t page)
-{
-    uint8_t shift =3D rb->clear_bmap_shift;
-
-    return bitmap_test_and_clear_atomic(rb->clear_bmap, page >> shift, 1);
-}
-
-static inline bool offset_in_ramblock(RAMBlock *b, ram_addr_t offset)
-{
-    return (b && b->host && offset < b->used_length) ? true : false;
-}
-
-static inline void *ramblock_ptr(RAMBlock *block, ram_addr_t offset)
-{
-    assert(offset_in_ramblock(block, offset));
-    return (char *)block->host + offset;
-}
-
-bool ramblock_is_pmem(RAMBlock *rb);
-
-/**
- * qemu_ram_alloc_from_file,
- * qemu_ram_alloc_from_fd:  Allocate a ram block from the specified backin=
g
- *                          file or device
- *
- * Parameters:
- *  @size: the size in bytes of the ram block
- *  @mr: the memory region where the ram block is
- *  @ram_flags: specify the properties of the ram block, which can be one
- *              or bit-or of following values
- *              - RAM_SHARED: mmap the backing file or device with MAP_SHA=
RED
- *              - RAM_PMEM: the backend @mem_path or @fd is persistent mem=
ory
- *              Other bits are ignored.
- *  @mem_path or @fd: specify the backing file or device
- *  @errp: pointer to Error*, to store an error if it happens
- *
- * Return:
- *  On success, return a pointer to the ram block.
- *  On failure, return NULL.
- */
-RAMBlock *qemu_ram_alloc_from_file(ram_addr_t size, MemoryRegion *mr,
-                                   uint32_t ram_flags, const char *mem_pat=
h,
-                                   Error **errp);
-RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, MemoryRegion *mr,
-                                 uint32_t ram_flags, int fd,
-                                 Error **errp);
-
-RAMBlock *qemu_ram_alloc_from_ptr(ram_addr_t size, void *host,
-                                  MemoryRegion *mr, Error **errp);
-RAMBlock *qemu_ram_alloc(ram_addr_t size, bool share, MemoryRegion *mr,
-                         Error **errp);
-RAMBlock *qemu_ram_alloc_resizeable(ram_addr_t size, ram_addr_t max_size,
-                                    void (*resized)(const char*,
-                                                    uint64_t length,
-                                                    void *host),
-                                    MemoryRegion *mr, Error **errp);
-void qemu_ram_free(RAMBlock *block);
-
-int qemu_ram_resize(RAMBlock *block, ram_addr_t newsize, Error **errp);
-
-void qemu_ram_msync(RAMBlock *block, ram_addr_t start, ram_addr_t length);
-
-/* Clear whole block of mem */
-static inline void qemu_ram_block_writeback(RAMBlock *block)
-{
-    qemu_ram_msync(block, 0, block->used_length);
-}
=20
 #define DIRTY_CLIENTS_ALL     ((1 << DIRTY_MEMORY_NUM) - 1)
 #define DIRTY_CLIENTS_NOCODE  (DIRTY_CLIENTS_ALL & ~(1 << DIRTY_MEMORY_COD=
E))
diff --git a/include/exec/ramblock.h b/include/exec/ramblock.h
index 6ac0aa7a89..b6b34141fc 100644
--- a/include/exec/ramblock.h
+++ b/include/exec/ramblock.h
@@ -22,6 +22,7 @@
 #ifndef CONFIG_USER_ONLY
 #include "cpu-common.h"
 #include "qemu/rcu.h"
+#include "qemu/bitmap.h"
=20
 struct RAMBlock {
     struct rcu_head rcu;
@@ -61,5 +62,138 @@ struct RAMBlock {
     unsigned long *clear_bmap;
     uint8_t clear_bmap_shift;
 };
+
+RAMBlock *qemu_ram_block_by_name(const char *name);
+RAMBlock *qemu_ram_block_from_host(void *ptr, bool round_offset,
+                                   ram_addr_t *offset);
+ram_addr_t qemu_ram_block_host_offset(RAMBlock *rb, void *host);
+void qemu_ram_set_idstr(RAMBlock *block, const char *name, DeviceState *de=
v);
+void qemu_ram_unset_idstr(RAMBlock *block);
+const char *qemu_ram_get_idstr(RAMBlock *rb);
+void *qemu_ram_get_host_addr(RAMBlock *rb);
+ram_addr_t qemu_ram_get_offset(RAMBlock *rb);
+ram_addr_t qemu_ram_get_used_length(RAMBlock *rb);
+bool qemu_ram_is_shared(RAMBlock *rb);
+bool qemu_ram_is_uf_zeroable(RAMBlock *rb);
+void qemu_ram_set_uf_zeroable(RAMBlock *rb);
+bool qemu_ram_is_migratable(RAMBlock *rb);
+void qemu_ram_set_migratable(RAMBlock *rb);
+void qemu_ram_unset_migratable(RAMBlock *rb);
+
+size_t qemu_ram_pagesize(RAMBlock *block);
+size_t qemu_ram_pagesize_largest(void);
+
+/**
+ * clear_bmap_size: calculate clear bitmap size
+ *
+ * @pages: number of guest pages
+ * @shift: guest page number shift
+ *
+ * Returns: number of bits for the clear bitmap
+ */
+static inline long clear_bmap_size(uint64_t pages, uint8_t shift)
+{
+    return DIV_ROUND_UP(pages, 1UL << shift);
+}
+
+/**
+ * clear_bmap_set: set clear bitmap for the page range
+ *
+ * @rb: the ramblock to operate on
+ * @start: the start page number
+ * @size: number of pages to set in the bitmap
+ *
+ * Returns: None
+ */
+static inline void clear_bmap_set(RAMBlock *rb, uint64_t start,
+                                  uint64_t npages)
+{
+    uint8_t shift =3D rb->clear_bmap_shift;
+
+    bitmap_set_atomic(rb->clear_bmap, start >> shift,
+                      clear_bmap_size(npages, shift));
+}
+
+/**
+ * clear_bmap_test_and_clear: test clear bitmap for the page, clear if set
+ *
+ * @rb: the ramblock to operate on
+ * @page: the page number to check
+ *
+ * Returns: true if the bit was set, false otherwise
+ */
+static inline bool clear_bmap_test_and_clear(RAMBlock *rb, uint64_t page)
+{
+    uint8_t shift =3D rb->clear_bmap_shift;
+
+    return bitmap_test_and_clear_atomic(rb->clear_bmap, page >> shift, 1);
+}
+
+static inline bool offset_in_ramblock(RAMBlock *b, ram_addr_t offset)
+{
+    return (b && b->host && offset < b->used_length) ? true : false;
+}
+
+static inline void *ramblock_ptr(RAMBlock *block, ram_addr_t offset)
+{
+    assert(offset_in_ramblock(block, offset));
+    return (char *)block->host + offset;
+}
+
+bool ramblock_is_pmem(RAMBlock *rb);
+
+/**
+ * qemu_ram_alloc_from_file,
+ * qemu_ram_alloc_from_fd:  Allocate a ram block from the specified backin=
g
+ *                          file or device
+ *
+ * Parameters:
+ *  @size: the size in bytes of the ram block
+ *  @mr: the memory region where the ram block is
+ *  @ram_flags: specify the properties of the ram block, which can be one
+ *              or bit-or of following values
+ *              - RAM_SHARED: mmap the backing file or device with MAP_SHA=
RED
+ *              - RAM_PMEM: the backend @mem_path or @fd is persistent mem=
ory
+ *              Other bits are ignored.
+ *  @mem_path or @fd: specify the backing file or device
+ *  @errp: pointer to Error*, to store an error if it happens
+ *
+ * Return:
+ *  On success, return a pointer to the ram block.
+ *  On failure, return NULL.
+ */
+RAMBlock *qemu_ram_alloc_from_file(ram_addr_t size, MemoryRegion *mr,
+                                   uint32_t ram_flags, const char *mem_pat=
h,
+                                   Error **errp);
+RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, MemoryRegion *mr,
+                                 uint32_t ram_flags, int fd,
+                                 Error **errp);
+
+RAMBlock *qemu_ram_alloc_from_ptr(ram_addr_t size, void *host,
+                                  MemoryRegion *mr, Error **errp);
+RAMBlock *qemu_ram_alloc(ram_addr_t size, bool share, MemoryRegion *mr,
+                         Error **errp);
+RAMBlock *qemu_ram_alloc_resizeable(ram_addr_t size, ram_addr_t max_size,
+                                    void (*resized)(const char*,
+                                                    uint64_t length,
+                                                    void *host),
+                                    MemoryRegion *mr, Error **errp);
+void qemu_ram_free(RAMBlock *block);
+
+int qemu_ram_resize(RAMBlock *block, ram_addr_t newsize, Error **errp);
+
+void qemu_ram_msync(RAMBlock *block, ram_addr_t start, ram_addr_t length);
+
+/* Clear whole block of mem */
+static inline void qemu_ram_block_writeback(RAMBlock *block)
+{
+    qemu_ram_msync(block, 0, block->used_length);
+}
+
+typedef int (RAMBlockIterFunc)(RAMBlock *rb, void *opaque);
+
+int qemu_ram_foreach_block(RAMBlockIterFunc func, void *opaque);
+int ram_block_discard_range(RAMBlock *rb, uint64_t start, size_t length);
+
 #endif
 #endif
diff --git a/migration/migration.h b/migration/migration.h
index 507284e563..73eb210ef5 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -21,6 +21,7 @@
 #include "qemu/coroutine_int.h"
 #include "io/channel.h"
 #include "net/announce.h"
+#include "exec/ramblock.h"
=20
 struct PostcopyBlocktimeContext;
=20
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 9924e66d1f..15c8ee9110 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -43,8 +43,6 @@
 #include <libutil.h>
 #endif
 #endif
-#else
-#include "exec/ram_addr.h"
 #endif
=20
 #include "exec/cputlb.h"
diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 21a199e53b..8d8dd7ce80 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -46,7 +46,7 @@
 #include "qapi/visitor.h"
 #include "sysemu/hostmem.h"
 #include "sysemu/block-backend.h"
-#include "exec/ram_addr.h"
+#include "exec/ramblock.h"
=20
 #include "qemu/log.h"
 #include "qemu/module.h"
diff --git a/hw/s390x/s390-stattrib-kvm.c b/hw/s390x/s390-stattrib-kvm.c
index f89d8d9d16..46ca7e7d1f 100644
--- a/hw/s390x/s390-stattrib-kvm.c
+++ b/hw/s390x/s390-stattrib-kvm.c
@@ -15,7 +15,6 @@
 #include "hw/s390x/storage-attributes.h"
 #include "qemu/error-report.h"
 #include "sysemu/kvm.h"
-#include "exec/ram_addr.h"
 #include "cpu.h"
 #include "kvm_s390x.h"
=20
diff --git a/hw/s390x/s390-stattrib.c b/hw/s390x/s390-stattrib.c
index 58121b9f68..9785d51577 100644
--- a/hw/s390x/s390-stattrib.c
+++ b/hw/s390x/s390-stattrib.c
@@ -16,7 +16,6 @@
 #include "migration/register.h"
 #include "hw/s390x/storage-attributes.h"
 #include "qemu/error-report.h"
-#include "exec/ram_addr.h"
 #include "qapi/error.h"
 #include "qapi/qmp/qdict.h"
=20
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index c009384505..ade36eda5e 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -17,7 +17,6 @@
 #include "cpu.h"
 #include "hw/boards.h"
 #include "exec/address-spaces.h"
-#include "exec/ram_addr.h"
 #include "hw/s390x/s390-virtio-hcall.h"
 #include "hw/s390x/sclp.h"
 #include "hw/s390x/s390_flic.h"
diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index ec21e8fbe8..12764d6254 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -23,6 +23,7 @@
 #include "sysemu/cryptodev.h"
 #include "migration/migration.h"
 #include "migration/postcopy-ram.h"
+#include "exec/ramblock.h"
 #include "trace.h"
=20
 #include <sys/ioctl.h>
diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index aff98a0ede..7da8d95a43 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -22,6 +22,7 @@
 #include "qemu/memfd.h"
 #include "standard-headers/linux/vhost_types.h"
 #include "exec/address-spaces.h"
+#include "exec/ramblock.h"
 #include "hw/virtio/virtio-bus.h"
 #include "hw/virtio/virtio-access.h"
 #include "migration/blocker.h"
diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index a4729f7fc9..ea112e9403 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -23,6 +23,7 @@
 #include "sysemu/balloon.h"
 #include "hw/virtio/virtio-balloon.h"
 #include "exec/address-spaces.h"
+#include "exec/ramblock.h"
 #include "qapi/error.h"
 #include "qapi/qapi-events-misc.h"
 #include "qapi/visitor.h"
diff --git a/memory.c b/memory.c
index 3e65e33ac4..e8e7bcd6c7 100644
--- a/memory.c
+++ b/memory.c
@@ -28,6 +28,7 @@
=20
 #include "exec/memory-internal.h"
 #include "exec/ram_addr.h"
+#include "exec/ramblock.h"
 #include "sysemu/kvm.h"
 #include "sysemu/runstate.h"
 #include "sysemu/tcg.h"
diff --git a/migration/migration.c b/migration/migration.c
index 177cce9e95..8c7ed8cc79 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -46,6 +46,7 @@
 #include "qemu/thread.h"
 #include "trace.h"
 #include "exec/target_page.h"
+#include "exec/ramblock.h"
 #include "io/channel-buffer.h"
 #include "migration/colo.h"
 #include "hw/boards.h"
diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index a36402722b..78646abf7a 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -18,6 +18,7 @@
=20
 #include "qemu/osdep.h"
 #include "exec/target_page.h"
+#include "exec/ramblock.h"
 #include "migration.h"
 #include "qemu-file.h"
 #include "savevm.h"
diff --git a/migration/savevm.c b/migration/savevm.c
index b979ea6e7f..714b5b4591 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -48,6 +48,7 @@
 #include "sysemu/cpus.h"
 #include "exec/memory.h"
 #include "exec/target_page.h"
+#include "exec/ramblock.h"
 #include "trace.h"
 #include "qemu/iov.h"
 #include "qemu/main-loop.h"
diff --git a/stubs/ram-block.c b/stubs/ram-block.c
index 73c0a3ee08..9e73543598 100644
--- a/stubs/ram-block.c
+++ b/stubs/ram-block.c
@@ -1,6 +1,6 @@
 #include "qemu/osdep.h"
 #include "exec/ramlist.h"
-#include "exec/cpu-common.h"
+#include "exec/ramblock.h"
=20
 void *qemu_ram_get_host_addr(RAMBlock *rb)
 {
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 2692f76130..1f3db517db 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -43,7 +43,6 @@
 #include "trace.h"
 #include "exec/gdbstub.h"
 #include "exec/memattrs.h"
-#include "exec/ram_addr.h"
 #include "sysemu/hostmem.h"
 #include "qemu/cutils.h"
 #include "qemu/main-loop.h"
diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index 69881a0da0..42657bc0a5 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -41,7 +41,6 @@
 #include "sysemu/runstate.h"
 #include "sysemu/device_tree.h"
 #include "exec/gdbstub.h"
-#include "exec/ram_addr.h"
 #include "trace.h"
 #include "hw/s390x/s390-pci-inst.h"
 #include "hw/s390x/s390-pci-bus.h"
diff --git a/util/vfio-helpers.c b/util/vfio-helpers.c
index e399e330e2..2ee169da58 100644
--- a/util/vfio-helpers.c
+++ b/util/vfio-helpers.c
@@ -15,7 +15,7 @@
 #include <linux/vfio.h>
 #include "qapi/error.h"
 #include "exec/ramlist.h"
-#include "exec/cpu-common.h"
+#include "exec/ramblock.h"
 #include "trace.h"
 #include "qemu/error-report.h"
 #include "standard-headers/linux/pci_regs.h"
--=20
2.21.3


