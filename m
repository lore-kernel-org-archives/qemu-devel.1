Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED5C3C4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 13:48:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F6532242C
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 13:48:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F6532242C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54710 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX2r3-0001Xs-I3
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 09:48:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37596)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengchuan@huawei.com>)
 id 1kX2mM-00044u-Ql
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 09:43:18 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2364)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengchuan@huawei.com>)
 id 1kX2mH-0000Jm-Li
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 09:43:18 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
 by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CKbd22lSZz15M5N;
 Mon, 26 Oct 2020 21:43:02 +0800 (CST)
Received: from huawei.com (10.175.101.6) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.487.0; Mon, 26 Oct 2020
 21:42:49 +0800
From: Chuan Zheng <zhengchuan@huawei.com>
To: <quintela@redhat.com>, <dgilbert@redhat.com>
Subject: [PATCH v1 2/4] migration/debug: Implement migration memory
 consistency check
Date: Mon, 26 Oct 2020 21:58:43 +0800
Message-ID: <1603720725-81206-3-git-send-email-zhengchuan@huawei.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1603720725-81206-1-git-send-email-zhengchuan@huawei.com>
References: <1603720725-81206-1-git-send-email-zhengchuan@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.101.6]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.190;
 envelope-from=zhengchuan@huawei.com; helo=szxga04-in.huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/26 07:55:44
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: yubihong@huawei.com, zhang.zhanghailiang@huawei.com, qemu-devel@nongnu.org,
 xiexiangyou@huawei.com, alex.chen@huawei.com, wanghao232@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Traverse all migratable ramblocks, calculate sha256 for memory consistency check

Signed-off-by: Chuan Zheng <zhengchuan@huawei.com>
---
 migration/ram.c | 73 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 migration/ram.h |  7 ++++++
 2 files changed, 80 insertions(+)

diff --git a/migration/ram.c b/migration/ram.c
index aa39908..f04594e 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -55,6 +55,8 @@
 #include "sysemu/cpu-throttle.h"
 #include "savevm.h"
 #include "qemu/iov.h"
+#include "crypto/hash.h"
+#include "qemu/typedefs.h"
 #include "multifd.h"
 
 /***********************************************************/
@@ -198,6 +200,77 @@ int foreach_not_ignored_block(RAMBlockIterFunc func, void *opaque)
     return ret;
 }
 
+#define SHA256_DIGEST_LENGTH 32
+#define SHA256_CHUNK_SIZE 0x80000000
+
+static void ram_debug_dump_sha256(uint8_t *md, const char *idstr,
+                                  const char *prefix)
+{
+    int i;
+    char buf[2 * SHA256_DIGEST_LENGTH + 1] = { 0 };
+
+    for (i = 0; i < SHA256_DIGEST_LENGTH; i++) {
+        sprintf(&buf[2 * i], "%02x", md[i]);
+    }
+
+    fprintf(stderr, "CheckPoint: %s, Ramblock: %s, CheckValue: %s\n",
+            prefix, idstr, buf);
+}
+
+static void ram_debug_calc_sha256(RAMBlock *block, const char *idstr,
+                                  const char *prefix)
+{
+    uint8_t *md = NULL;
+    size_t sha256_len;
+    size_t i, niov;
+    void *addr = NULL;
+    ram_addr_t remaining = 0;
+    size_t resultlen = 0;
+    struct iovec *iov_array = NULL;
+
+    sha256_len = qcrypto_hash_digest_len(QCRYPTO_HASH_ALG_SHA256);
+    assert(sha256_len == SHA256_DIGEST_LENGTH);
+
+    niov = DIV_ROUND_UP(qemu_ram_get_used_length(block), SHA256_CHUNK_SIZE);
+    iov_array = g_malloc0_n(niov, sizeof(struct iovec));
+
+    addr = qemu_ram_get_host_addr(block);
+    remaining = qemu_ram_get_used_length(block);
+    for (i = 0; i < niov; i++) {
+        iov_array[i].iov_base = addr;
+        iov_array[i].iov_len = MIN(SHA256_CHUNK_SIZE, remaining);
+        addr += SHA256_CHUNK_SIZE;
+        remaining -= SHA256_CHUNK_SIZE;
+    }
+
+    if (qcrypto_hash_bytesv(QCRYPTO_HASH_ALG_SHA256,
+                            iov_array, niov,
+                            &md, &resultlen, NULL) || !md) {
+        fprintf(stderr, "Consistency check(%s) calc failed.\n", prefix);
+        goto out;
+    }
+
+    ram_debug_dump_sha256(md, idstr, prefix);
+
+out:
+    g_free(iov_array);
+}
+
+static int ram_debug_consistency(RAMBlock *block, void *opaque)
+{
+    const char *prefix = opaque;
+    const char *idstr = qemu_ram_get_idstr(block);
+
+    ram_debug_calc_sha256(block, idstr, prefix);
+
+    return 0;
+}
+
+void migration_debug_ram_consistency(const char *prefix)
+{
+    foreach_migratable_block(ram_debug_consistency, (void *)prefix);
+}
+
 static void ramblock_recv_map_init(void)
 {
     RAMBlock *rb;
diff --git a/migration/ram.h b/migration/ram.h
index 011e854..d73de6e 100644
--- a/migration/ram.h
+++ b/migration/ram.h
@@ -47,6 +47,13 @@ bool ramblock_is_ignored(RAMBlock *block);
     INTERNAL_RAMBLOCK_FOREACH(block)                   \
         if (!qemu_ram_is_migratable(block)) {} else
 
+void migration_debug_ram_consistency(const char *prefix);
+
+#define MIGRATION_RAM_CONSISTENCY_CHECK()              \
+do {                                              \
+        migration_debug_ram_consistency(__func__);      \
+} while (0)
+
 int xbzrle_cache_resize(int64_t new_size, Error **errp);
 uint64_t ram_bytes_remaining(void);
 uint64_t ram_bytes_total(void);
-- 
1.8.3.1


