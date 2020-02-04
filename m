Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FF08C3524D
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 11:34:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F1462166E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 11:34:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="sgWYqNNl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F1462166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56714 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iywT1-0004bk-IO
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 06:34:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53724)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <i.kotrasinsk@partner.samsung.com>)
 id 1iywQD-0008K2-Jj
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 06:31:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <i.kotrasinsk@partner.samsung.com>)
 id 1iywQB-00008W-E3
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 06:31:13 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:51722)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <i.kotrasinsk@partner.samsung.com>)
 id 1iywQA-0008Nr-Ne
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 06:31:10 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20200204113106euoutp024561a316f730dccbca7557c9dee47b89~wL6eWgl152964429644euoutp02h
 for <qemu-devel@nongnu.org>; Tue,  4 Feb 2020 11:31:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20200204113106euoutp024561a316f730dccbca7557c9dee47b89~wL6eWgl152964429644euoutp02h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1580815866;
 bh=G4wTiFmR0fBUdAn0Bzqm0G1Fin1w2mJXa+zDn8QifTo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=sgWYqNNlRMRiMLmo+wjBqdgsv2W9c9pP9+bzUFL5CHjVh055y9ORpBFkcEJ5Zun2r
 sUsHIYBMDLNfgjVDWlivS2W+BJIW8iqrSWEoF/diX50ektI6EpH/mgXPvtkOtetDmW
 UfUstrMQfWNJwPMxtNLCTbaIIgF4V929SYKsqyrs=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20200204113105eucas1p232efd275ab3e17e3486b55c40f29a5b8~wL6eNI-w20485604856eucas1p27;
 Tue,  4 Feb 2020 11:31:05 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges1new.samsung.com (EUCPMTA) with SMTP id 6D.FE.61286.9F5593E5; Tue,  4
 Feb 2020 11:31:05 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20200204113105eucas1p2981e8d1e49ca9621255a4aedf8f1ec6e~wL6d5MFVt0485604856eucas1p26;
 Tue,  4 Feb 2020 11:31:05 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20200204113105eusmtrp1ec77f69912c3b23fd4cee12359ae0010~wL6d4oIDv2134721347eusmtrp1K;
 Tue,  4 Feb 2020 11:31:05 +0000 (GMT)
X-AuditID: cbfec7f2-ef1ff7000001ef66-86-5e3955f94df9
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id 36.AC.08375.9F5593E5; Tue,  4
 Feb 2020 11:31:05 +0000 (GMT)
Received: from AMDC3304.digital.local (unknown [106.120.51.21]) by
 eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20200204113105eusmtip2143bbf7c37fbc0780dbb857de0c5d40c~wL6djWhKg1398913989eusmtip2L;
 Tue,  4 Feb 2020 11:31:05 +0000 (GMT)
From: i.kotrasinsk@partner.samsung.com
To: qemu-devel@nongnu.org
Subject: [RFC 2/9] memory: Support mmap offset for fd-backed memory regions
Date: Tue,  4 Feb 2020 12:30:44 +0100
Message-Id: <1580815851-28887-3-git-send-email-i.kotrasinsk@partner.samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1580815851-28887-1-git-send-email-i.kotrasinsk@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGIsWRmVeSWpSXmKPExsWy7djP87o/Qy3jDK4sNbbYc+Exm8X+bf9Y
 LeacecBicbx3B4sDi8eda3vYPJ5c28zkcfDdHiaP9/uusgWwRHHZpKTmZJalFunbJXBlzL2m
 UvDBpWL/hAWsDYxzdbsYOTkkBEwk+h/9ZgGxhQRWMEo0XVfrYuQCsr8wSvzoW8sK4XxmlDj5
 dxsbTMexhk9QieWMEvf6/rDCtVz+fxKsik1ATWLnkc+MILaIgKTE767TzCA2s0CGxPNZ3WC2
 sIC3xNwXX1hBbBYBVYmmOxA1vAIBEg/7drFCbJOTuHmuEyzOKRAo8X7PJCaQZRICZ9gkPi8/
 zARR5CIx6cAWZghbWOLV8S3sELaMxOnJPSwQdr1Ey50dUM0djBJ9K6dD/WMt8WXDUqAiDqDr
 NCXW79IHMSUEHCUefC2GMPkkbrwVhDifT2LStunMEGFeiY42IYgZehLdT24ywSxd1vgIaqmH
 RPvjNiZI8CxhlJi4bwfzBEb5WQi7FjAyrmIUTy0tzk1PLTbMSy3XK07MLS7NS9dLzs/dxAiM
 /dP/jn/awfj1UtIhRgEORiUe3gt2FnFCrIllxZW5hxglOJiVRHjP61vGCfGmJFZWpRblxxeV
 5qQWH2KU5mBREuc1XvQyVkggPbEkNTs1tSC1CCbLxMEp1cB4YE+eUvjiL6/W1ZnqsPvunBF/
 uijDZc09lwB9qR7vlo1GnHlXpZ9y+QT3Np1tL5nyee5Jhr0BV87/8wtjM3yTota31Htd7YeV
 C7V9FmhIpBq/krVb6DK/3vbJjS0Tfj5xb10sue2GdgKTgFlezu96HZWIxjULYz/8OKG47bnu
 24mBF9gyVCcosRRnJBpqMRcVJwIA9HgH0PkCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJLMWRmVeSWpSXmKPExsVy+t/xe7o/Qy3jDBYel7HYc+Exm8X+bf9Y
 LeacecBicbx3B4sDi8eda3vYPJ5c28zkcfDdHiaP9/uusgWwROnZFOWXlqQqZOQXl9gqRRta
 GOkZWlroGZlY6hkam8daGZkq6dvZpKTmZJalFunbJehlzL2mUvDBpWL/hAWsDYxzdbsYOTkk
 BEwkjjV8Yu1i5OIQEljKKDH94AlWiISMxI/Ta9ggbGGJP9e62CCKPjFKvF+3lBEkwSagJrHz
 yGcwW0RAUuJ312lmEJtZIEti5+z7TCC2sIC3xNwXX8CGsgioSjTdgajhFQiQeNi3C2qZnMTN
 c51gcU6BQIn3eyaB9QoB1VzYNYt9AiPfAkaGVYwiqaXFuem5xYZ6xYm5xaV56XrJ+bmbGIHB
 uO3Yz807GC9tDD7EKMDBqMTDe8HOIk6INbGsuDL3EKMEB7OSCO95fcs4Id6UxMqq1KL8+KLS
 nNTiQ4ymQEdNZJYSTc4HRkpeSbyhqaG5haWhubG5sZmFkjhvh8DBGCGB9MSS1OzU1ILUIpg+
 Jg5OqQbGKgueu6Y1F93L7t009Pvx/mSWX+a79YfThc/uteZR2Ruef4ArKU6B6VjvomKXR6J2
 mnNdgtkFGGbe11Vnyfs6OydDy1J+wbIF3SwCxj+DM6YpXBOW3ua9/n6I59nwmm03eCO2BuYv
 jmH/Ojn7/ZF0rQvNTtIzTjL92lh95FaNC8tS09YZx8yUWIozEg21mIuKEwE3to20XAIAAA==
X-CMS-MailID: 20200204113105eucas1p2981e8d1e49ca9621255a4aedf8f1ec6e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200204113105eucas1p2981e8d1e49ca9621255a4aedf8f1ec6e
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200204113105eucas1p2981e8d1e49ca9621255a4aedf8f1ec6e
References: <1580815851-28887-1-git-send-email-i.kotrasinsk@partner.samsung.com>
 <CGME20200204113105eucas1p2981e8d1e49ca9621255a4aedf8f1ec6e@eucas1p2.samsung.com>
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
 Igor Kotrasinski <i.kotrasinsk@partner.samsung.com>, pbonzini@redhat.com
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
 include/exec/memory.h     |  1 +
 include/exec/ram_addr.h   |  2 +-
 include/qemu/mmap-alloc.h |  1 +
 memory.c                  |  3 ++-
 util/mmap-alloc.c         |  7 ++++---
 util/oslib-posix.c        |  2 +-
 9 files changed, 19 insertions(+), 12 deletions(-)

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
index 6092528..28cb2e9 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -917,6 +917,7 @@ void memory_region_init_ram_from_fd(MemoryRegion *mr,
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
index e9f37e7..65dd165 100644
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


