Return-Path: <SRS0=VSQP=S3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53FE1C43219
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 18:08:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D930220685
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 18:08:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D930220685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33402 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJinO-0000Nm-Ds
	for qemu-devel@archiver.kernel.org; Thu, 25 Apr 2019 14:08:30 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41511)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hJici-0000Xo-V4
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 13:57:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hJicb-00059S-9y
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 13:57:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38532)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hJicZ-00056i-9i
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 13:57:20 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 18EDA792B3;
	Thu, 25 Apr 2019 17:57:18 +0000 (UTC)
Received: from localhost (ovpn-116-9.gru2.redhat.com [10.97.116.9])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A2D785D9C6;
	Thu, 25 Apr 2019 17:57:17 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
	Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Date: Thu, 25 Apr 2019 14:56:56 -0300
Message-Id: <20190425175659.24876-9-ehabkost@redhat.com>
In-Reply-To: <20190425175659.24876-1-ehabkost@redhat.com>
References: <20190425175659.24876-1-ehabkost@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.39]);
	Thu, 25 Apr 2019 17:57:18 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 08/11] util/mmap-alloc: Add a 'is_pmem'
 parameter to qemu_ram_mmap
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
Cc: Zhang Yi <yi.z.zhang@linux.intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190425175656.yYjDLPo2RAtHHy7GiT33RDSOtvMmLH4MsLyi_5TH7Uc@z>

From: Zhang Yi <yi.z.zhang@linux.intel.com>

besides the existing 'shared' flags, we are going to add
'is_pmem' to qemu_ram_mmap(), which indicated the memory backend
file is a persist memory.

Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
Signed-off-by: Zhang Yi <yi.z.zhang@linux.intel.com>
Reviewed-by: Pankaj Gupta <pagupta@redhat.com>
Message-Id: <786c46862cfeb253ee0ea2f44d62ffe76edb7fa4.1549555521.git.yi.z.zhang@linux.intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Pankaj Gupta <pagupta@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/qemu/mmap-alloc.h | 21 ++++++++++++++++++++-
 exec.c                    |  2 +-
 util/mmap-alloc.c         |  6 +++++-
 util/oslib-posix.c        |  2 +-
 4 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/include/qemu/mmap-alloc.h b/include/qemu/mmap-alloc.h
index ef04f0ed5b..eec98d82c1 100644
--- a/include/qemu/mmap-alloc.h
+++ b/include/qemu/mmap-alloc.h
@@ -7,7 +7,26 @@ size_t qemu_fd_getpagesize(int fd);
 
 size_t qemu_mempath_getpagesize(const char *mem_path);
 
-void *qemu_ram_mmap(int fd, size_t size, size_t align, bool shared);
+/**
+ * qemu_ram_mmap: mmap the specified file or device.
+ *
+ * Parameters:
+ *  @fd: the file or the device to mmap
+ *  @size: the number of bytes to be mmaped
+ *  @align: if not zero, specify the alignment of the starting mapping address;
+ *          otherwise, the alignment in use will be determined by QEMU.
+ *  @shared: map has RAM_SHARED flag.
+ *  @is_pmem: map has RAM_PMEM flag.
+ *
+ * Return:
+ *  On success, return a pointer to the mapped area.
+ *  On failure, return MAP_FAILED.
+ */
+void *qemu_ram_mmap(int fd,
+                    size_t size,
+                    size_t align,
+                    bool shared,
+                    bool is_pmem);
 
 void qemu_ram_munmap(int fd, void *ptr, size_t size);
 
diff --git a/exec.c b/exec.c
index f7f3cdbf4a..aa07432929 100644
--- a/exec.c
+++ b/exec.c
@@ -1883,7 +1883,7 @@ static void *file_ram_alloc(RAMBlock *block,
     }
 
     area = qemu_ram_mmap(fd, memory, block->mr->align,
-                         block->flags & RAM_SHARED);
+                         block->flags & RAM_SHARED, block->flags & RAM_PMEM);
     if (area == MAP_FAILED) {
         error_setg_errno(errp, errno,
                          "unable to map backing store for guest RAM");
diff --git a/util/mmap-alloc.c b/util/mmap-alloc.c
index 8565885420..9713f4b960 100644
--- a/util/mmap-alloc.c
+++ b/util/mmap-alloc.c
@@ -75,7 +75,11 @@ size_t qemu_mempath_getpagesize(const char *mem_path)
     return getpagesize();
 }
 
-void *qemu_ram_mmap(int fd, size_t size, size_t align, bool shared)
+void *qemu_ram_mmap(int fd,
+                    size_t size,
+                    size_t align,
+                    bool shared,
+                    bool is_pmem)
 {
     int flags;
     int guardfd;
diff --git a/util/oslib-posix.c b/util/oslib-posix.c
index 88dda9cd39..d97b1717d5 100644
--- a/util/oslib-posix.c
+++ b/util/oslib-posix.c
@@ -203,7 +203,7 @@ void *qemu_memalign(size_t alignment, size_t size)
 void *qemu_anon_ram_alloc(size_t size, uint64_t *alignment, bool shared)
 {
     size_t align = QEMU_VMALLOC_ALIGN;
-    void *ptr = qemu_ram_mmap(-1, size, align, shared);
+    void *ptr = qemu_ram_mmap(-1, size, align, shared, false);
 
     if (ptr == MAP_FAILED) {
         return NULL;
-- 
2.18.0.rc1.1.g3f1ff2140


