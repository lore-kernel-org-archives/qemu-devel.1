Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E60CC352A1
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 13:32:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D957217BA
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 13:32:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="sweoQXvg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D957217BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47054 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izKnL-0004CO-ID
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 08:32:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36807)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <i.kotrasinsk@partner.samsung.com>)
 id 1izKjZ-0007kO-S0
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 08:28:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <i.kotrasinsk@partner.samsung.com>)
 id 1izKjX-0004qb-4H
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 08:28:49 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:50239)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <i.kotrasinsk@partner.samsung.com>)
 id 1izKjW-0004gd-RN
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 08:28:47 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20200205132844euoutp02116d1f150751f6d3ebfecc9992de7f0b~whKeZuFVE0896308963euoutp02U
 for <qemu-devel@nongnu.org>; Wed,  5 Feb 2020 13:28:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20200205132844euoutp02116d1f150751f6d3ebfecc9992de7f0b~whKeZuFVE0896308963euoutp02U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1580909324;
 bh=5R4nrCcLd2rZPxuKYcgQNp55I3lWJgCy5Tih85uN1Ug=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=sweoQXvgJqpUrGgJJ63/L74+MWxD6em4HZhiINj/FRy3qt8xUEsqOlgMDdBrtlvdV
 WTdI1978YLSW3ISfDVttEowxIL+ZEoBsBtpfplyg95XrXhuGHvXcQAD+M4duwO/ZpP
 ypjysTtmik8XRqugfqNMkm7YcgDsnQrKcRFIZM7E=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20200205132844eucas1p2d9932432436700319f96c83ed4f1a2ca~whKeOuWMf0081500815eucas1p2S;
 Wed,  5 Feb 2020 13:28:44 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges3new.samsung.com (EUCPMTA) with SMTP id 0B.9F.60698.C03CA3E5; Wed,  5
 Feb 2020 13:28:44 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20200205132843eucas1p2b706b812ee59a3ff37c9413179cde938~whKdwwoMv0490104901eucas1p2B;
 Wed,  5 Feb 2020 13:28:43 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20200205132843eusmtrp2e8398cbd8ac7d1dc8cef7b2528f8a628~whKdhuLZk2992629926eusmtrp2j;
 Wed,  5 Feb 2020 13:28:43 +0000 (GMT)
X-AuditID: cbfec7f5-a29ff7000001ed1a-23-5e3ac30c2bd4
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id C1.00.08375.B03CA3E5; Wed,  5
 Feb 2020 13:28:43 +0000 (GMT)
Received: from AMDC3304.digital.local (unknown [106.120.51.21]) by
 eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20200205132843eusmtip27c63528900359f12c6f9e1001ca689b6~whKdLqoQ83135731357eusmtip2X;
 Wed,  5 Feb 2020 13:28:43 +0000 (GMT)
From: i.kotrasinsk@partner.samsung.com
To: qemu-devel@nongnu.org
Subject: [RFC PATCH v3 2/9] memory: Support mmap offset for fd-backed memory
 regions
Date: Wed,  5 Feb 2020 14:28:30 +0100
Message-Id: <1580909317-23884-3-git-send-email-i.kotrasinsk@partner.samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1580909317-23884-1-git-send-email-i.kotrasinsk@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrEIsWRmVeSWpSXmKPExsWy7djP87o8h63iDJY0cFrsufCYzeLezZvM
 Fvu3/WO1mHPmAYvF8d4dLA6sHneu7WHzeHJtM5PHwXd7mDze77vK5rH95CSmANYoLpuU1JzM
 stQifbsEroylC08yFcz1qLh08TVTA+M7/S5GTg4JAROJXY9fs3UxcnEICaxglFj0dz4rSEJI
 4AujxOLleRCJz4wSDy8dYYTp+PhhCitEYjmjxJ+LX9khHKCOb6sfsIBUsQmoSew88hmsQ0RA
 UuJ312lmkCJmgQZGiUfXz4IlhAXCJJpu32IDsVkEVCUWHZkDZvMKBEgs7zzPDLFOTuLmuU4w
 m1MgUOLysymsEPHnbBIXH8VA2C4SHQd2skHYwhKvjm9hh7BlJP7vnM8EYddLtNzZwQRyhIRA
 B6NE38rpUA3WEl82LAW6mgPoOk2J9bugAeMosXPVKzaQsIQAn8SNt4IgYWYgc9K26cwQYV6J
 jjYhiGo9ie4nN5lgti5rfMQCYXtI/Lz6kAkSPksYJT5s7GabwCg/C2HZAkbGVYziqaXFuemp
 xcZ5qeV6xYm5xaV56XrJ+bmbGIEp4fS/4193MO77k3SIUYCDUYmHN2CCZZwQa2JZcWXuIUYJ
 DmYlEd7z+kAh3pTEyqrUovz4otKc1OJDjNIcLErivMaLXsYKCaQnlqRmp6YWpBbBZJk4OKUa
 GG9z37qgOu2DU1FUdMDEY/kesor+L6p27b5a78JzxO0Y4/X0I7VJ4k/Ps7Zwr2izir76M+Dh
 zaXL55lG6pdEzZ942PLQ12VTWmoNBCZcn9jel2cR0jfj7qsDYXemq7OVtzocFJx7pdf+T1UJ
 4/1iiRcBm6f9e3qhWKqeg+V7/oODOyaurp7M+FyJpTgj0VCLuag4EQCCfqgZBQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKLMWRmVeSWpSXmKPExsVy+t/xe7rch63iDO6eVrHYc+Exm8W9mzeZ
 LfZv+8dqMefMAxaL4707WBxYPe5c28Pm8eTaZiaPg+/2MHm833eVzWP7yUlMAaxRejZF+aUl
 qQoZ+cUltkrRhhZGeoaWFnpGJpZ6hsbmsVZGpkr6djYpqTmZZalF+nYJehlLF55kKpjrUXHp
 4mumBsZ3+l2MnBwSAiYSHz9MYe1i5OIQEljKKHGx4RgLREJG4sfpNWwQtrDEn2tdbBBFnxgl
 Ps1pZAdJsAmoSew88pkRxBYRkJT43XWaGaSIWaCFUeLZk3YmkISwQIjE1IkPwCaxCKhKLDoy
 B8zmFQiQWN55nhlig5zEzXOdYDanQKDE5WcgJ3ECbQuQeD3xCvMERr4FjAyrGEVSS4tz03OL
 DfWKE3OLS/PS9ZLzczcxAoN027Gfm3cwXtoYfIhRgINRiYd3xSTLOCHWxLLiytxDjBIczEoi
 vOf1gUK8KYmVValF+fFFpTmpxYcYTYGOmsgsJZqcD4ygvJJ4Q1NDcwtLQ3Njc2MzCyVx3g6B
 gzFCAumJJanZqakFqUUwfUwcnFINjIwSf2PMRFcvkPfU+nzxwpNVss/+7T/7cZHpN5Z5D/4H
 ucSXprxLbKvf9cWWpUB3UfADkQNLty9LVeWxvXA5VWGG7M/0tzu4r82VMYx8n3Hz/APei4UX
 2BcILxfvqrH6cuIvT1jJvrWWMy418FwxUthwPWTp4oVlCpu9X6iuDz6oz96xYZLfSlUlluKM
 REMt5qLiRADg/K16aAIAAA==
X-CMS-MailID: 20200205132843eucas1p2b706b812ee59a3ff37c9413179cde938
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200205132843eucas1p2b706b812ee59a3ff37c9413179cde938
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200205132843eucas1p2b706b812ee59a3ff37c9413179cde938
References: <1580909317-23884-1-git-send-email-i.kotrasinsk@partner.samsung.com>
 <CGME20200205132843eucas1p2b706b812ee59a3ff37c9413179cde938@eucas1p2.samsung.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 210.118.77.12
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
Cc: peter.maydell@linaro.org,
 Igor Kotrasinski <i.kotrasinsk@partner.samsung.com>, jan.kiszka@siemens.com,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Igor Kotrasinski <i.kotrasinsk@partner.samsung.com>

The memexpose device will receive shared memory from another VM and map
parts of it as memory regions. For that, we need to be able to mmap the
region at an offset from shared memory's start.

Signed-off-by: Igor Kotrasinski <i.kotrasinsk@partner.samsung.com>
---
 backends/hostmem-memfd.c  |  2 +-
 exec.c                    | 10 ++++++----
 hw/misc/ivshmem.c         |  3 ++-
 include/exec/memory.h     |  2 ++
 include/exec/ram_addr.h   |  2 +-
 include/qemu/mmap-alloc.h |  1 +
 memory.c                  |  3 ++-
 util/mmap-alloc.c         |  7 ++++---
 util/oslib-posix.c        |  2 +-
 9 files changed, 20 insertions(+), 12 deletions(-)

diff --git a/backends/hostmem-memfd.c b/backends/hostmem-memfd.c
index 26070b4..7cd6c53 100644
--- a/backends/hostmem-memfd.c
+++ b/backends/hostmem-memfd.c
@@ -56,7 +56,7 @@ memfd_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
 
     name = host_memory_backend_get_name(backend);
     memory_region_init_ram_from_fd(&backend->mr, OBJECT(backend),
-                                   name, backend->size,
+                                   name, backend->size, 0,
                                    backend->share, fd, errp);
     g_free(name);
 }
diff --git a/exec.c b/exec.c
index 67e520d..afcb3c9 100644
--- a/exec.c
+++ b/exec.c
@@ -1839,6 +1839,7 @@ static int file_ram_open(const char *path,
 
 static void *file_ram_alloc(RAMBlock *block,
                             ram_addr_t memory,
+                            size_t mmap_offset,
                             int fd,
                             bool truncate,
                             Error **errp)
@@ -1892,7 +1893,7 @@ static void *file_ram_alloc(RAMBlock *block,
         perror("ftruncate");
     }
 
-    area = qemu_ram_mmap(fd, memory, block->mr->align,
+    area = qemu_ram_mmap(fd, memory, mmap_offset, block->mr->align,
                          block->flags & RAM_SHARED, block->flags & RAM_PMEM);
     if (area == MAP_FAILED) {
         error_setg_errno(errp, errno,
@@ -2314,7 +2315,7 @@ static void ram_block_add(RAMBlock *new_block, Error **errp, bool shared)
 
 #ifdef CONFIG_POSIX
 RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, MemoryRegion *mr,
-                                 uint32_t ram_flags, int fd,
+                                 uint32_t ram_flags, int fd, size_t mmap_offset,
                                  Error **errp)
 {
     RAMBlock *new_block;
@@ -2360,7 +2361,8 @@ RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, MemoryRegion *mr,
     new_block->used_length = size;
     new_block->max_length = size;
     new_block->flags = ram_flags;
-    new_block->host = file_ram_alloc(new_block, size, fd, !file_size, errp);
+    new_block->host = file_ram_alloc(new_block, size, mmap_offset, fd,
+                                     !file_size, errp);
     if (!new_block->host) {
         g_free(new_block);
         return NULL;
@@ -2390,7 +2392,7 @@ RAMBlock *qemu_ram_alloc_from_file(ram_addr_t size, MemoryRegion *mr,
         return NULL;
     }
 
-    block = qemu_ram_alloc_from_fd(size, mr, ram_flags, fd, errp);
+    block = qemu_ram_alloc_from_fd(size, mr, ram_flags, fd, 0, errp);
     if (!block) {
         if (created) {
             unlink(mem_path);
diff --git a/hw/misc/ivshmem.c b/hw/misc/ivshmem.c
index 1a0fad7..4967d4f 100644
--- a/hw/misc/ivshmem.c
+++ b/hw/misc/ivshmem.c
@@ -492,7 +492,8 @@ static void process_msg_shmem(IVShmemState *s, int fd, Error **errp)
 
     /* mmap the region and map into the BAR2 */
     memory_region_init_ram_from_fd(&s->server_bar2, OBJECT(s),
-                                   "ivshmem.bar2", size, true, fd, &local_err);
+                                   "ivshmem.bar2", size, 0, true, fd,
+                                   &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         return;
diff --git a/include/exec/memory.h b/include/exec/memory.h
index ac09221..c5554cc 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -906,6 +906,7 @@ void memory_region_init_ram_from_file(MemoryRegion *mr,
  * @owner: the object that tracks the region's reference count
  * @name: the name of the region.
  * @size: size of the region.
+ * @mmap_offset: offset at which the fd is to be mapped.
  * @share: %true if memory must be mmaped with the MAP_SHARED flag
  * @fd: the fd to mmap.
  * @errp: pointer to Error*, to store an error if it happens.
@@ -917,6 +918,7 @@ void memory_region_init_ram_from_fd(MemoryRegion *mr,
                                     struct Object *owner,
                                     const char *name,
                                     uint64_t size,
+                                    uint64_t mmap_offset,
                                     bool share,
                                     int fd,
                                     Error **errp);
diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
index 5e59a3d..1e85362 100644
--- a/include/exec/ram_addr.h
+++ b/include/exec/ram_addr.h
@@ -120,7 +120,7 @@ RAMBlock *qemu_ram_alloc_from_file(ram_addr_t size, MemoryRegion *mr,
                                    uint32_t ram_flags, const char *mem_path,
                                    Error **errp);
 RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, MemoryRegion *mr,
-                                 uint32_t ram_flags, int fd,
+                                 uint32_t ram_flags, int fd, size_t mmap_offset,
                                  Error **errp);
 
 RAMBlock *qemu_ram_alloc_from_ptr(ram_addr_t size, void *host,
diff --git a/include/qemu/mmap-alloc.h b/include/qemu/mmap-alloc.h
index e786266..bd95504 100644
--- a/include/qemu/mmap-alloc.h
+++ b/include/qemu/mmap-alloc.h
@@ -23,6 +23,7 @@ size_t qemu_mempath_getpagesize(const char *mem_path);
  */
 void *qemu_ram_mmap(int fd,
                     size_t size,
+                    size_t mmap_offset,
                     size_t align,
                     bool shared,
                     bool is_pmem);
diff --git a/memory.c b/memory.c
index 0973c44..93c2cd1 100644
--- a/memory.c
+++ b/memory.c
@@ -1584,6 +1584,7 @@ void memory_region_init_ram_from_fd(MemoryRegion *mr,
                                     struct Object *owner,
                                     const char *name,
                                     uint64_t size,
+                                    uint64_t mmap_offset,
                                     bool share,
                                     int fd,
                                     Error **errp)
@@ -1595,7 +1596,7 @@ void memory_region_init_ram_from_fd(MemoryRegion *mr,
     mr->destructor = memory_region_destructor_ram;
     mr->ram_block = qemu_ram_alloc_from_fd(size, mr,
                                            share ? RAM_SHARED : 0,
-                                           fd, &err);
+                                           fd, mmap_offset, &err);
     mr->dirty_log_mask = tcg_enabled() ? (1 << DIRTY_MEMORY_CODE) : 0;
     if (err) {
         mr->size = int128_zero();
diff --git a/util/mmap-alloc.c b/util/mmap-alloc.c
index 27dcccd..191db45 100644
--- a/util/mmap-alloc.c
+++ b/util/mmap-alloc.c
@@ -84,6 +84,7 @@ size_t qemu_mempath_getpagesize(const char *mem_path)
 
 void *qemu_ram_mmap(int fd,
                     size_t size,
+                    size_t mmap_offset,
                     size_t align,
                     bool shared,
                     bool is_pmem)
@@ -127,7 +128,7 @@ void *qemu_ram_mmap(int fd,
     flags = MAP_PRIVATE | MAP_ANONYMOUS;
 #endif
 
-    guardptr = mmap(0, total, PROT_NONE, flags, guardfd, 0);
+    guardptr = mmap(0, total, PROT_NONE, flags, guardfd, mmap_offset);
 
     if (guardptr == MAP_FAILED) {
         return MAP_FAILED;
@@ -147,7 +148,7 @@ void *qemu_ram_mmap(int fd,
     offset = QEMU_ALIGN_UP((uintptr_t)guardptr, align) - (uintptr_t)guardptr;
 
     ptr = mmap(guardptr + offset, size, PROT_READ | PROT_WRITE,
-               flags | map_sync_flags, fd, 0);
+               flags | map_sync_flags, fd, mmap_offset);
 
     if (ptr == MAP_FAILED && map_sync_flags) {
         if (errno == ENOTSUP) {
@@ -172,7 +173,7 @@ void *qemu_ram_mmap(int fd,
          * we will remove these flags to handle compatibility.
          */
         ptr = mmap(guardptr + offset, size, PROT_READ | PROT_WRITE,
-                   flags, fd, 0);
+                   flags, fd, mmap_offset);
     }
 
     if (ptr == MAP_FAILED) {
diff --git a/util/oslib-posix.c b/util/oslib-posix.c
index 5a291cc..e4ffdc1 100644
--- a/util/oslib-posix.c
+++ b/util/oslib-posix.c
@@ -205,7 +205,7 @@ void *qemu_memalign(size_t alignment, size_t size)
 void *qemu_anon_ram_alloc(size_t size, uint64_t *alignment, bool shared)
 {
     size_t align = QEMU_VMALLOC_ALIGN;
-    void *ptr = qemu_ram_mmap(-1, size, align, shared, false);
+    void *ptr = qemu_ram_mmap(-1, size, 0, align, shared, false);
 
     if (ptr == MAP_FAILED) {
         return NULL;
-- 
2.7.4


