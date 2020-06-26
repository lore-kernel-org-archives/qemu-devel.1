Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E997C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 13:58:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B0302080C
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 13:58:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yv9D3CMM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B0302080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42270 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joort-0007PD-DO
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 09:58:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40760)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jooq1-0005At-TK
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 09:56:17 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25604
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jooq0-0000Ow-4D
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 09:56:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593179775;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=27FBSLD97IXkacBHsHNfuY1T6+kmG/JdRKJFQzspjU0=;
 b=Yv9D3CMMhCNSkG6Oz0GUdnkoyywIZ0DEaioyjm4J4kc2TpJj/3XdjQa/EHYEByOQ8Eu51/
 VQl4idjBkqPeq5eCtT/zTdXkwoj87SMQeXa7AEOs62K7TbaCVGlMssCKuf08bbvjx1D+Zh
 ZCRNfGZW3EhVBCFz8Lo9pL6hnS5LgU4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-394-fHJF7iUtPQKCqisaae9sSQ-1; Fri, 26 Jun 2020 09:56:11 -0400
X-MC-Unique: fHJF7iUtPQKCqisaae9sSQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 008F287950D;
 Fri, 26 Jun 2020 13:56:10 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5B08410016E8;
 Fri, 26 Jun 2020 13:56:09 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 09/31] exec: fetch the alignment of Linux devdax pmem
 character device nodes
Date: Fri, 26 Jun 2020 09:56:07 -0400
Message-Id: <20200626135608.6920-2-pbonzini@redhat.com>
In-Reply-To: <20200626135608.6920-1-pbonzini@redhat.com>
References: <20200626135608.6920-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/26 01:55:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Jingqi Liu <jingqi.liu@intel.com>, Dan Williams <dan.j.williams@intel.com>,
 Joao Martins <joao.m.martins@oracle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Jingqi Liu <jingqi.liu@intel.com>

If the backend file is devdax pmem character device, the alignment
specified by the option 'align=NUM' in the '-object memory-backend-file'
needs to match the alignment requirement of the devdax pmem character device.

This patch uses the interfaces of libdaxctl to fetch the devdax pmem file
'align', so that we can compare it with the NUM of 'align=NUM'.
The NUM needs to be larger than or equal to the devdax pmem file 'align'.

It also fixes the problem that mmap() returns failure in qemu_ram_mmap()
when the NUM of 'align=NUM' is less than the devdax pmem file 'align'.

Suggested-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Joao Martins <joao.m.martins@oracle.com>
Signed-off-by: Jingqi Liu <jingqi.liu@intel.com>
Message-Id: <20200429085011.63752-2-jingqi.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 exec.c | 54 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 53 insertions(+), 1 deletion(-)

diff --git a/exec.c b/exec.c
index d6712fba7e..21926dc9c7 100644
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
@@ -1745,6 +1749,46 @@ static int64_t get_file_size(int fd)
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
@@ -2296,7 +2340,7 @@ RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, MemoryRegion *mr,
 {
     RAMBlock *new_block;
     Error *local_err = NULL;
-    int64_t file_size;
+    int64_t file_size, file_align;
 
     /* Just support these ram flags by now. */
     assert((ram_flags & ~(RAM_SHARED | RAM_PMEM)) == 0);
@@ -2332,6 +2376,14 @@ RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, MemoryRegion *mr,
         return NULL;
     }
 
+    file_align = get_file_align(fd);
+    if (file_align > 0 && mr && file_align > mr->align) {
+        error_setg(errp, "backing store align 0x%" PRIx64
+                   " is larger than 'align' option 0x%" PRIx64,
+                   file_align, mr->align);
+        return NULL;
+    }
+
     new_block = g_malloc0(sizeof(*new_block));
     new_block->mr = mr;
     new_block->used_length = size;
-- 
2.26.2



