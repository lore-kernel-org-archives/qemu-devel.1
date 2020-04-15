Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1EB3C2BA2B
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 03:42:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93B4E2083B
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 03:42:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93B4E2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42368 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOYwM-0005GW-NF
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 23:42:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48657)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jingqi.liu@intel.com>) id 1jOYuW-00029H-2P
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 23:40:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jingqi.liu@intel.com>) id 1jOYuU-0000ko-GF
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 23:40:23 -0400
Received: from mga01.intel.com ([192.55.52.88]:4321)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jingqi.liu@intel.com>)
 id 1jOYuT-0000il-Uv
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 23:40:22 -0400
IronPort-SDR: hsv30nG8nXvtUPIKpFnMYV2L9NgJgQM+iS4+kOcIB4lbb6oLR5orFFr0tDjHslRnxEQ5XCCIfQ
 s4wUB9A1RIow==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Apr 2020 20:40:15 -0700
IronPort-SDR: aSpHhgfP5+7mUNptpgEg8lFvXL60uKwnRf6uPJy7OKAjYKNnS7/fLhRD9kPp0v9TGqGvx04iTT
 lrziVRl0/cPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,385,1580803200"; d="scan'208";a="256729954"
Received: from dazhang1-mobile.sh.intel.com ([10.239.48.70])
 by orsmga006.jf.intel.com with ESMTP; 14 Apr 2020 20:40:13 -0700
From: Jingqi Liu <jingqi.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH v2 1/3] exec: fetch the alignment of Linux devdax pmem
 character device nodes
Date: Wed, 15 Apr 2020 11:35:36 +0800
Message-Id: <20200415033538.43329-2-jingqi.liu@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200415033538.43329-1-jingqi.liu@intel.com>
References: <20200415033538.43329-1-jingqi.liu@intel.com>
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 192.55.52.88
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
Cc: Jingqi Liu <jingqi.liu@intel.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If the backend file is devdax pmem character device, the alignment
specified by the option 'align=NUM' in the '-object memory-backend-file'
needs to match the alignment requirement of the devdax pmem character device.

This patch uses the interfaces of libdaxctl to fetch the devdax pmem file
'align', so that we can compare it with the NUM of 'align=NUM'.
The NUM needs to be larger than or equal to the devdax pmem file 'align'.

It also fixes the problem that mmap() returns failure in qemu_ram_mmap()
when the NUM of 'align=NUM' is less than the devdax pmem file 'align'.

Suggested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Jingqi Liu <jingqi.liu@intel.com>
---
 exec.c | 54 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 53 insertions(+), 1 deletion(-)

diff --git a/exec.c b/exec.c
index de9d949902..2c3444e47e 100644
--- a/exec.c
+++ b/exec.c
@@ -77,6 +77,10 @@
 
 #include "monitor/monitor.h"
 
+#ifdef CONFIG_LIBDAXCTL
+#include <daxctl/libdaxctl.h>
+#endif
+
 //#define DEBUG_SUBPAGE
 
 #if !defined(CONFIG_USER_ONLY)
@@ -1736,6 +1740,46 @@ static int64_t get_file_size(int fd)
     return size;
 }
 
+static int64_t get_file_align(int fd)
+{
+    int64_t align = -1;
+#if defined(__linux__) && defined(CONFIG_LIBDAXCTL)
+    struct stat st;
+
+    if (fstat(fd, &st) < 0) {
+        return -errno;
+    }
+
+    /* Special handling for devdax character devices */
+    if (S_ISCHR(st.st_mode)) {
+        g_autofree char *path = NULL;
+        g_autofree char *rpath = NULL;
+        struct daxctl_ctx *ctx;
+        struct daxctl_region *region;
+        int rc = 0;
+
+        path = g_strdup_printf("/sys/dev/char/%d:%d",
+                    major(st.st_rdev), minor(st.st_rdev));
+        rpath = realpath(path, NULL);
+
+        rc = daxctl_new(&ctx);
+        if (rc) {
+            return -1;
+        }
+
+        daxctl_region_foreach(ctx, region) {
+            if (strstr(rpath, daxctl_region_get_path(region))) {
+                align = daxctl_region_get_align(region);
+                break;
+            }
+        }
+        daxctl_unref(ctx);
+    }
+#endif /* defined(__linux__) && defined(CONFIG_LIBDAXCTL) */
+
+    return align;
+}
+
 static int file_ram_open(const char *path,
                          const char *region_name,
                          bool *created,
@@ -2275,7 +2319,7 @@ RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, MemoryRegion *mr,
 {
     RAMBlock *new_block;
     Error *local_err = NULL;
-    int64_t file_size;
+    int64_t file_size, file_align;
 
     /* Just support these ram flags by now. */
     assert((ram_flags & ~(RAM_SHARED | RAM_PMEM)) == 0);
@@ -2311,6 +2355,14 @@ RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, MemoryRegion *mr,
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


