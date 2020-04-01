Return-Path: <SRS0=uFRu=5R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 897F6C43331
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 03:18:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 562A020678
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 03:18:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 562A020678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46458 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJTts-0004jI-H6
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 23:18:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36471)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jingqi.liu@intel.com>) id 1jJTsz-00040K-Q8
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 23:17:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jingqi.liu@intel.com>) id 1jJTsy-0000Jf-2s
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 23:17:49 -0400
Received: from mga06.intel.com ([134.134.136.31]:50506)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jingqi.liu@intel.com>)
 id 1jJTsx-0008Ne-Qe
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 23:17:48 -0400
IronPort-SDR: i8VvI+NbUy4CaUMq6wZU5Glanqnk1IMbKFOpGK4fC7/HAGfdDrsCLY8oivid7lf+PwoZB7m/Ce
 i4fFXXfikyKg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Mar 2020 20:17:42 -0700
IronPort-SDR: +oaTlhXYm2c1Ekhk104vd7EENYZ9C5YNd3ixfDIjjDl07qKb88kMr8ti4bosBrGJf39WwCUZYp
 AnfS/+gYXh6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,330,1580803200"; d="scan'208";a="395798143"
Received: from dazhang1-mobile.sh.intel.com ([10.239.48.70])
 by orsmga004.jf.intel.com with ESMTP; 31 Mar 2020 20:17:39 -0700
From: Jingqi Liu <jingqi.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Richard Henderson <rth@twiddle.net>
Subject: [PATCH] exec: fetch the alignment of Linux devdax pmem character
 device nodes
Date: Wed,  1 Apr 2020 11:13:14 +0800
Message-Id: <20200401031314.11592-1-jingqi.liu@intel.com>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 134.134.136.31
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
Cc: Jingqi Liu <jingqi.liu@intel.com>, Dan Williams <dan.j.williams@intel.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If the backend file is devdax pmem character device, the alignment
specified by the option 'align=NUM' in the '-object memory-backend-file'
needs to match the alignment requirement of the devdax pmem character device.

This patch fetches the devdax pmem file 'align', so that we can compare
it with the NUM of 'align=NUM'.
The NUM needs to be larger than or equal to the devdax pmem file 'align'.

It also fixes the problem that mmap() returns failure in qemu_ram_mmap()
when the NUM of 'align=NUM' is less than the devdax pmem file 'align'.

Cc: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Jingqi Liu <jingqi.liu@intel.com>
---
 exec.c | 46 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 45 insertions(+), 1 deletion(-)

diff --git a/exec.c b/exec.c
index de9d949902..8221abffec 100644
--- a/exec.c
+++ b/exec.c
@@ -1736,6 +1736,42 @@ static int64_t get_file_size(int fd)
     return size;
 }
 
+static int64_t get_file_align(int fd)
+{
+    int64_t align = -1;
+#if defined(__linux__)
+    struct stat st;
+
+    if (fstat(fd, &st) < 0) {
+        return -errno;
+    }
+
+    /* Special handling for devdax character devices */
+    if (S_ISCHR(st.st_mode)) {
+        g_autofree char *subsystem_path = NULL;
+        g_autofree char *subsystem = NULL;
+
+        subsystem_path = g_strdup_printf("/sys/dev/char/%d:%d/subsystem",
+                                         major(st.st_rdev), minor(st.st_rdev));
+        subsystem = g_file_read_link(subsystem_path, NULL);
+
+        if (subsystem && g_str_has_suffix(subsystem, "/dax")) {
+            g_autofree char *align_path = NULL;
+            g_autofree char *align_str = NULL;
+
+            align_path = g_strdup_printf("/sys/dev/char/%d:%d/device/align",
+                                    major(st.st_rdev), minor(st.st_rdev));
+
+            if (g_file_get_contents(align_path, &align_str, NULL, NULL)) {
+                return g_ascii_strtoll(align_str, NULL, 0);
+            }
+        }
+    }
+#endif /* defined(__linux__) */
+
+    return align;
+}
+
 static int file_ram_open(const char *path,
                          const char *region_name,
                          bool *created,
@@ -2275,7 +2311,7 @@ RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, MemoryRegion *mr,
 {
     RAMBlock *new_block;
     Error *local_err = NULL;
-    int64_t file_size;
+    int64_t file_size, file_align;
 
     /* Just support these ram flags by now. */
     assert((ram_flags & ~(RAM_SHARED | RAM_PMEM)) == 0);
@@ -2311,6 +2347,14 @@ RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, MemoryRegion *mr,
         return NULL;
     }
 
+    file_align = get_file_align(fd);
+    if (file_align > 0 && mr && file_align > mr->align) {
+        error_setg(errp, "backing store align 0x%" PRIx64
+                   " is larger than 'align' option 0x" RAM_ADDR_FMT,
+                   file_align, mr->align);
+        return NULL;
+    }
+
     new_block = g_malloc0(sizeof(*new_block));
     new_block->mr = mr;
     new_block->used_length = size;
-- 
2.17.1


