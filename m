Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51D03C2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 09:10:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8F7720702
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 09:10:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8F7720702
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46796 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kc3CQ-0005hn-ER
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 04:10:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53450)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jinzeyu@huawei.com>)
 id 1kc3Ax-0004Pd-I0
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 04:09:23 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:2511)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jinzeyu@huawei.com>)
 id 1kc3At-0006xo-1g
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 04:09:23 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
 by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CV4tR0f48zhhGL;
 Mon,  9 Nov 2020 17:09:03 +0800 (CST)
Received: from localhost (10.174.186.67) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.487.0; Mon, 9 Nov 2020
 17:09:03 +0800
From: Zeyu Jin <jinzeyu@huawei.com>
To: <quintela@redhat.com>, <dgilbert@redhat.com>
Subject: [RFC PATCH 4/6] migration: Add zstd support in multi-thread
 compression
Date: Mon, 9 Nov 2020 17:08:48 +0800
Message-ID: <20201109090850.2424-5-jinzeyu@huawei.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20201109090850.2424-1-jinzeyu@huawei.com>
References: <20201109090850.2424-1-jinzeyu@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.174.186.67]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.191; envelope-from=jinzeyu@huawei.com;
 helo=szxga05-in.huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/09 03:39:34
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: Ying Fang <fangying1@huawei.com>, qemu-devel@nongnu.org,
 Zeyu Jin <jinzeyu@huawei.com>, zhang.zhanghailiang@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch enables zstd option in multi-thread compression.

Signed-off-by: Zeyu Jin <jinzeyu@huawei.com>
Signed-off-by: Ying Fang <fangying1@huawei.com>
---
 hw/core/qdev-properties-system.c |   2 +-
 migration/ram.c                  | 128 ++++++++++++++++++++++++++++++-
 qapi/migration.json              |   2 +-
 3 files changed, 129 insertions(+), 3 deletions(-)

diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
index d757b2cd70..54760d94b3 100644
--- a/hw/core/qdev-properties-system.c
+++ b/hw/core/qdev-properties-system.c
@@ -667,7 +667,7 @@ const PropertyInfo qdev_prop_multifd_compression = {
 const PropertyInfo qdev_prop_compress_method = {
     .name = "CompressMethod",
     .description = "multi-thread compression method, "
-                   "zlib",
+                   "zlib/zstd",
     .enum_table = &CompressMethod_lookup,
     .get = qdev_propinfo_get_enum,
     .set = qdev_propinfo_set_enum,
diff --git a/migration/ram.c b/migration/ram.c
index 94a7422204..a732d80db2 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -57,6 +57,10 @@
 #include "qemu/iov.h"
 #include "multifd.h"
 
+#ifdef CONFIG_ZSTD
+#include <zstd.h>
+#include <zstd_errors.h>
+#endif
 /***********************************************************/
 /* ram save/restore */
 
@@ -424,6 +428,11 @@ struct CompressParam {
     /* for zlib compression */
     z_stream stream;
 
+#ifdef CONFIG_ZSTD
+    ZSTD_CStream *zstd_cs;
+    ZSTD_inBuffer in;
+    ZSTD_outBuffer out;
+#endif
 };
 typedef struct CompressParam CompressParam;
 
@@ -438,6 +447,12 @@ struct DecompressParam {
 
     /* for zlib compression */
     z_stream stream;
+
+#ifdef CONFIG_ZSTD
+    ZSTD_DStream *zstd_ds;
+    ZSTD_inBuffer in;
+    ZSTD_outBuffer out;
+#endif
 };
 typedef struct DecompressParam DecompressParam;
 
@@ -571,6 +586,102 @@ static int zlib_check_len(int len)
     return len < 0 || len > compressBound(TARGET_PAGE_SIZE);
 }
 
+#ifdef CONFIG_ZSTD
+static int zstd_save_setup(CompressParam *param)
+{
+    int res;
+    param->zstd_cs = ZSTD_createCStream();
+    if (!param->zstd_cs) {
+        return -1;
+    }
+    res = ZSTD_initCStream(param->zstd_cs, migrate_compress_level());
+    if (ZSTD_isError(res)) {
+        return -1;
+    }
+    return 0;
+}
+static void zstd_save_cleanup(CompressParam *param)
+{
+    ZSTD_freeCStream(param->zstd_cs);
+    param->zstd_cs = NULL;
+}
+static ssize_t zstd_compress_data(CompressParam *param, size_t size)
+{
+    int ret;
+    uint8_t *dest = NULL;
+    uint8_t *p = param->originbuf;
+    QEMUFile *f = f = param->file;
+    ssize_t blen = qemu_put_compress_start(f, &dest);
+    if (blen < ZSTD_compressBound(size)) {
+        return -1;
+    }
+    param->out.dst = dest;
+    param->out.size = blen;
+    param->out.pos = 0;
+    param->in.src = p;
+    param->in.size = size;
+    param->in.pos = 0;
+    do {
+        ret = ZSTD_compressStream2(param->zstd_cs, &param->out,
+                                   &param->in, ZSTD_e_end);
+    } while (ret > 0 && (param->in.size - param->in.pos > 0)
+            && (param->out.size - param->out.pos > 0));
+    if (ret > 0 && (param->in.size - param->in.pos > 0)) {
+        return -1;
+    }
+    if (ZSTD_isError(ret)) {
+        return -1;
+    }
+    blen = param->out.pos;
+    qemu_put_compress_end(f, blen);
+    return blen + sizeof(int32_t);
+}
+static int zstd_load_setup(DecompressParam *param)
+{
+    int ret;
+    param->zstd_ds = ZSTD_createDStream();
+    if (!param->zstd_ds) {
+        return -1;
+    }
+    ret = ZSTD_initDStream(param->zstd_ds);
+    if (ZSTD_isError(ret)) {
+        return -1;
+    }
+    return 0;
+}
+static void zstd_load_cleanup(DecompressParam *param)
+{
+    ZSTD_freeDStream(param->zstd_ds);
+    param->zstd_ds = NULL;
+}
+static int
+zstd_decompress_data(DecompressParam *param, uint8_t *dest, size_t size)
+{
+    int ret;
+    param->out.dst = dest;
+    param->out.size = size;
+    param->out.pos = 0;
+    param->in.src = param->compbuf;
+    param->in.size = param->len;
+    param->in.pos = 0;
+    do {
+        ret = ZSTD_decompressStream(param->zstd_ds, &param->out, &param->in);
+    } while (ret > 0 && (param->in.size - param->in.pos > 0)
+                    && (param->out.size - param->out.pos > 0));
+    if (ret > 0 && (param->in.size - param->in.pos > 0)) {
+        return -1;
+    }
+    if (ZSTD_isError(ret)) {
+        return -1;
+    }
+    return ret;
+}
+static int zstd_check_len(int len)
+{
+    return len < 0 || len > ZSTD_compressBound(TARGET_PAGE_SIZE);
+}
+#endif
+
 static int set_compress_ops(void)
 {
    compress_ops = g_new0(MigrationCompressOps, 1);
@@ -581,9 +692,16 @@ static int set_compress_ops(void)
         compress_ops->save_cleanup = zlib_save_cleanup;
         compress_ops->compress_data = zlib_compress_data;
         break;
+#ifdef CONFIG_ZSTD
+    case COMPRESS_METHOD_ZSTD:
+        compress_ops->save_setup = zstd_save_setup;
+        compress_ops->save_cleanup = zstd_save_cleanup;
+        compress_ops->compress_data = zstd_compress_data;
+        break;
+#endif
     default:
         return -1;
-    }
+   }
 
     return 0;
 }
@@ -599,6 +717,14 @@ static int set_decompress_ops(void)
         decompress_ops->decompress_data = zlib_decompress_data;
         decompress_ops->check_len = zlib_check_len;
         break;
+#ifdef CONFIG_ZSTD
+    case COMPRESS_METHOD_ZSTD:
+        decompress_ops->load_setup = zstd_load_setup;
+        decompress_ops->load_cleanup = zstd_load_cleanup;
+        decompress_ops->decompress_data = zstd_decompress_data;
+        decompress_ops->check_len = zstd_check_len;
+        break;
+#endif
     default:
         return -1;
    }
diff --git a/qapi/migration.json b/qapi/migration.json
index d262683a38..ac6d06c683 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -536,7 +536,7 @@
 #
 ##
 { 'enum': 'CompressMethod',
-  'data': [ 'zlib' ] }
+  'data': [ 'zlib', { 'name': 'zstd', 'if': 'defined(CONFIG_ZSTD)' } ] }
 
 ##
 # @BitmapMigrationBitmapAlias:
-- 
2.23.0


