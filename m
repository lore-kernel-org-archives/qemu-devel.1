Return-Path: <SRS0=5Zkg=SY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE571C10F14
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2019 00:57:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99E1420859
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2019 00:57:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99E1420859
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58843 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hINHG-00018S-Vd
	for qemu-devel@archiver.kernel.org; Sun, 21 Apr 2019 20:57:46 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41627)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hINEd-0007lQ-MW
	for qemu-devel@nongnu.org; Sun, 21 Apr 2019 20:55:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hINEc-0003dy-K2
	for qemu-devel@nongnu.org; Sun, 21 Apr 2019 20:55:03 -0400
Received: from mga05.intel.com ([192.55.52.43]:45606)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
	id 1hINEc-0003ci-CM
	for qemu-devel@nongnu.org; Sun, 21 Apr 2019 20:55:02 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
	by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	21 Apr 2019 17:55:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,379,1549958400"; d="scan'208";a="293416722"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
	by orsmga004.jf.intel.com with ESMTP; 21 Apr 2019 17:50:00 -0700
From: Wei Yang <richardw.yang@linux.intel.com>
To: qemu-devel@nongnu.org
Date: Mon, 22 Apr 2019 08:48:48 +0800
Message-Id: <20190422004849.26463-2-richardw.yang@linux.intel.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190422004849.26463-1-richardw.yang@linux.intel.com>
References: <20190422004849.26463-1-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 192.55.52.43
Subject: [Qemu-devel] [PATCH v14 1/2] util/mmap-alloc: support MAP_SYNC in
 qemu_ram_mmap()
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
Cc: pagupta@redhat.com, xiaoguangrong.eric@gmail.com, mst@redhat.com,
	Haozhong Zhang <haozhong.zhang@intel.com>,
	yi.z.zhang@linux.intel.com, yu.c.zhang@linux.intel.com,
	richardw.yang@linux.intel.com, stefanha@redhat.com,
	imammedo@redhat.com, pbonzini@redhat.com,
	dan.j.williams@intel.com, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190422004848.btqlOWIcn_0SqwKxrynW5GY94ZTznqspdhZCgoZHVZA@z>

From: Zhang Yi <yi.z.zhang@linux.intel.com>

When a file supporting DAX is used as vNVDIMM backend, mmap it with
MAP_SYNC flag in addition which can ensure file system metadata
synced in each guest writes to the backend file, without other QEMU
actions (e.g., periodic fsync() by QEMU).

Current, We have below different possible use cases:

1. pmem=on is set, shared=on is set, MAP_SYNC supported:
   a: backend is a dax supporting file.
    - MAP_SYNC will active.
   b: backend is not a dax supporting file.
    - mmap will trigger a warning. then MAP_SYNC flag will be ignored

2. The rest of cases:
   - we will never pass the MAP_SYNC to mmap2

Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
Signed-off-by: Zhang Yi <yi.z.zhang@linux.intel.com>
[ehabkost: Rebased patch to latest code on master]
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
Tested-by: Wei Yang <richardw.yang@linux.intel.com>

---
v14: rebase on top of current upstream
---
 util/mmap-alloc.c | 41 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 40 insertions(+), 1 deletion(-)

diff --git a/util/mmap-alloc.c b/util/mmap-alloc.c
index 9713f4b960..f7f177d0ea 100644
--- a/util/mmap-alloc.c
+++ b/util/mmap-alloc.c
@@ -10,6 +10,13 @@
  * later.  See the COPYING file in the top-level directory.
  */
 
+#ifdef CONFIG_LINUX
+#include <linux/mman.h>
+#else  /* !CONFIG_LINUX */
+#define MAP_SYNC              0x0
+#define MAP_SHARED_VALIDATE   0x0
+#endif /* CONFIG_LINUX */
+
 #include "qemu/osdep.h"
 #include "qemu/mmap-alloc.h"
 #include "qemu/host-utils.h"
@@ -82,6 +89,7 @@ void *qemu_ram_mmap(int fd,
                     bool is_pmem)
 {
     int flags;
+    int map_sync_flags = 0;
     int guardfd;
     size_t offset;
     size_t pagesize;
@@ -132,9 +140,40 @@ void *qemu_ram_mmap(int fd,
     flags = MAP_FIXED;
     flags |= fd == -1 ? MAP_ANONYMOUS : 0;
     flags |= shared ? MAP_SHARED : MAP_PRIVATE;
+    if (shared && is_pmem) {
+        map_sync_flags = MAP_SYNC | MAP_SHARED_VALIDATE;
+    }
+
     offset = QEMU_ALIGN_UP((uintptr_t)guardptr, align) - (uintptr_t)guardptr;
 
-    ptr = mmap(guardptr + offset, size, PROT_READ | PROT_WRITE, flags, fd, 0);
+    ptr = mmap(guardptr + offset, size, PROT_READ | PROT_WRITE,
+               flags | map_sync_flags, fd, 0);
+
+    if (ptr == MAP_FAILED && map_sync_flags) {
+        if (errno == ENOTSUP) {
+            char *proc_link, *file_name;
+            int len;
+            proc_link = g_strdup_printf("/proc/self/fd/%d", fd);
+            file_name = g_malloc0(PATH_MAX);
+            len = readlink(proc_link, file_name, PATH_MAX - 1);
+            if (len < 0) {
+                len = 0;
+            }
+            file_name[len] = '\0';
+            fprintf(stderr, "Warning: requesting persistence across crashes "
+                    "for backend file %s failed. Proceeding without "
+                    "persistence, data might become corrupted in case of host "
+                    "crash.\n", file_name);
+            g_free(proc_link);
+            g_free(file_name);
+        }
+        /*
+         * if map failed with MAP_SHARED_VALIDATE | MAP_SYNC,
+         * we will remove these flags to handle compatibility.
+         */
+        ptr = mmap(guardptr + offset, size, PROT_READ | PROT_WRITE,
+                   flags, fd, 0);
+    }
 
     if (ptr == MAP_FAILED) {
         munmap(guardptr, total);
-- 
2.19.1


