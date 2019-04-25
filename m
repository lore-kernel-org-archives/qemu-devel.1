Return-Path: <SRS0=VSQP=S3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDC52C43219
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 18:04:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54E1E206BF
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 18:04:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54E1E206BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33343 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJijL-00066j-Nm
	for qemu-devel@archiver.kernel.org; Thu, 25 Apr 2019 14:04:19 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41566)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hJicq-0000ge-H0
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 13:57:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hJico-0005ML-SS
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 13:57:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44184)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hJico-0005Cf-If
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 13:57:34 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 700CD3088B82;
	Thu, 25 Apr 2019 17:57:24 +0000 (UTC)
Received: from localhost (ovpn-116-9.gru2.redhat.com [10.97.116.9])
	by smtp.corp.redhat.com (Postfix) with ESMTP id F12E460BE5;
	Thu, 25 Apr 2019 17:57:23 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
	Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Date: Thu, 25 Apr 2019 14:56:59 -0300
Message-Id: <20190425175659.24876-12-ehabkost@redhat.com>
In-Reply-To: <20190425175659.24876-1-ehabkost@redhat.com>
References: <20190425175659.24876-1-ehabkost@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.42]);
	Thu, 25 Apr 2019 17:57:24 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 11/11] util/mmap-alloc: support MAP_SYNC in
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
Cc: Zhang Yi <yi.z.zhang@linux.intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190425175659.YzCAQ5nZ6S5rxudCpVPo0jPfxdr6uKrdKOLpJJr4cvs@z>

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
Message-Id: <20190422004849.26463-2-richardw.yang@linux.intel.com>
[ehabkost: squashed documentation patch]
Message-Id: <20190422004849.26463-3-richardw.yang@linux.intel.com>
[ehabkost: documentation fixup]
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Pankaj Gupta <pagupta@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 docs/nvdimm.txt   | 22 +++++++++++++++++++---
 util/mmap-alloc.c | 41 ++++++++++++++++++++++++++++++++++++++++-
 qemu-options.hx   |  5 +++++
 3 files changed, 64 insertions(+), 4 deletions(-)

diff --git a/docs/nvdimm.txt b/docs/nvdimm.txt
index 7231c2d78f..b531cacd35 100644
--- a/docs/nvdimm.txt
+++ b/docs/nvdimm.txt
@@ -144,9 +144,25 @@ Guest Data Persistence
 ----------------------
 
 Though QEMU supports multiple types of vNVDIMM backends on Linux,
-currently the only one that can guarantee the guest write persistence
-is the device DAX on the real NVDIMM device (e.g., /dev/dax0.0), to
-which all guest access do not involve any host-side kernel cache.
+the only backend that can guarantee the guest write persistence is:
+
+A. DAX device (e.g., /dev/dax0.0, ) or
+B. DAX file(mounted with dax option)
+
+When using B (A file supporting direct mapping of persistent memory)
+as a backend, write persistence is guaranteed if the host kernel has
+support for the MAP_SYNC flag in the mmap system call (available
+since Linux 4.15 and on certain distro kernels) and additionally
+both 'pmem' and 'share' flags are set to 'on' on the backend.
+
+If these conditions are not satisfied i.e. if either 'pmem' or 'share'
+are not set, if the backend file does not support DAX or if MAP_SYNC
+is not supported by the host kernel, write persistence is not
+guaranteed after a system crash. For compatibility reasons, these
+conditions are ignored if not satisfied. Currently, no way is
+provided to test for them.
+For more details, please reference mmap(2) man page:
+http://man7.org/linux/man-pages/man2/mmap.2.html.
 
 When using other types of backends, it's suggested to set 'unarmed'
 option of '-device nvdimm' to 'on', which sets the unarmed flag of the
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
diff --git a/qemu-options.hx b/qemu-options.hx
index 08749a3391..bdc74c0620 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4233,6 +4233,11 @@ using the SNIA NVM programming model (e.g. Intel NVDIMM).
 If @option{pmem} is set to 'on', QEMU will take necessary operations to
 guarantee the persistence of its own writes to @option{mem-path}
 (e.g. in vNVDIMM label emulation and live migration).
+Also, we will map the backend-file with MAP_SYNC flag, which ensures the
+file metadata is in sync for @option{mem-path} in case of host crash
+or a power failure. MAP_SYNC requires support from both the host kernel
+(since Linux kernel 4.15) and the filesystem of @option{mem-path} mounted
+with DAX option.
 
 @item -object memory-backend-ram,id=@var{id},merge=@var{on|off},dump=@var{on|off},share=@var{on|off},prealloc=@var{on|off},size=@var{size},host-nodes=@var{host-nodes},policy=@var{default|preferred|bind|interleave}
 
-- 
2.18.0.rc1.1.g3f1ff2140


