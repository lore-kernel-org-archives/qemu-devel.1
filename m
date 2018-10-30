Received: from eggs.gnu.org ([2001:4830:134:3::10]:37893)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1gHLeM-0002R0-OK
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 00:29:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1gHLeL-0001ib-R8
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 00:29:06 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:43885)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1gHLeL-0001hw-JY
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 00:29:05 -0400
Received: by mail-pf1-x442.google.com with SMTP id h4-v6so5125989pfi.10
	for <qemu-devel@nongnu.org>; Mon, 29 Oct 2018 21:29:05 -0700 (PDT)
From: Li Qiang <liq3ea@gmail.com>
Date: Mon, 29 Oct 2018 21:28:51 -0700
Message-Id: <1540873732-3503-2-git-send-email-liq3ea@gmail.com>
In-Reply-To: <1540873732-3503-1-git-send-email-liq3ea@gmail.com>
References: <1540873732-3503-1-git-send-email-liq3ea@gmail.com>
Subject: [Qemu-devel] [PATCH v2 1/2] tests: fw_cfg: add a function to get
 the fw_cfg file entry
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, thuth@redhat.com, lvivier@redhat.com, philmd@redhat.com
Cc: qemu-devel@nongnu.org, Li Qiang <liq3ea@gmail.com>

This is useful to write qtest about fw_cfg file entry.

Signed-off-by: Li Qiang <liq3ea@gmail.com>
---
 tests/libqos/fw_cfg.c | 33 +++++++++++++++++++++++++++++++++
 tests/libqos/fw_cfg.h |  2 ++
 2 files changed, 35 insertions(+)

diff --git a/tests/libqos/fw_cfg.c b/tests/libqos/fw_cfg.c
index d0889d1e22..45338655f4 100644
--- a/tests/libqos/fw_cfg.c
+++ b/tests/libqos/fw_cfg.c
@@ -16,6 +16,7 @@
 #include "libqos/fw_cfg.h"
 #include "libqtest.h"
 #include "qemu/bswap.h"
+#include "standard-headers/linux/qemu_fw_cfg.h"
 
 void qfw_cfg_select(QFWCFG *fw_cfg, uint16_t key)
 {
@@ -54,6 +55,38 @@ uint64_t qfw_cfg_get_u64(QFWCFG *fw_cfg, uint16_t key)
     return le64_to_cpu(value);
 }
 
+size_t qfw_cfg_get_file(QFWCFG *fw_cfg, const char *filename,
+                      void *data, size_t buflen)
+{
+    uint32_t count;
+    uint32_t i;
+    unsigned char *filesbuf = NULL;
+    uint32_t dsize;
+    struct fw_cfg_file *p;
+    size_t filesize = 0;
+
+    qfw_cfg_get(fw_cfg, FW_CFG_FILE_DIR, &count, sizeof(count));
+    count = be32_to_cpu(count);
+    dsize = sizeof(uint32_t) + count * sizeof(struct fw_cfg_file);
+    filesbuf = g_malloc0(dsize);
+    qfw_cfg_get(fw_cfg, FW_CFG_FILE_DIR, filesbuf, dsize);
+    p = (struct fw_cfg_file *)(filesbuf + 4);
+    for (i = 0; i < count; ++i, ++p) {
+        if (!strcmp(p->name, filename)) {
+            uint32_t len = be32_to_cpu(p->size);
+            uint16_t sel = be16_to_cpu(p->select);
+            filesize = len;
+            if (len > buflen) {
+                len = buflen;
+            }
+            qfw_cfg_get(fw_cfg, sel, data, len);
+            break;
+        }
+    }
+    g_free(filesbuf);
+    return filesize;
+}
+
 static void mm_fw_cfg_select(QFWCFG *fw_cfg, uint16_t key)
 {
     qtest_writew(fw_cfg->qts, fw_cfg->base, key);
diff --git a/tests/libqos/fw_cfg.h b/tests/libqos/fw_cfg.h
index 0353416af0..de73722e67 100644
--- a/tests/libqos/fw_cfg.h
+++ b/tests/libqos/fw_cfg.h
@@ -31,6 +31,8 @@ void qfw_cfg_get(QFWCFG *fw_cfg, uint16_t key, void *data, size_t len);
 uint16_t qfw_cfg_get_u16(QFWCFG *fw_cfg, uint16_t key);
 uint32_t qfw_cfg_get_u32(QFWCFG *fw_cfg, uint16_t key);
 uint64_t qfw_cfg_get_u64(QFWCFG *fw_cfg, uint16_t key);
+size_t qfw_cfg_get_file(QFWCFG *fw_cfg, const char *filename,
+                      void *data, size_t buflen);
 
 QFWCFG *mm_fw_cfg_init(QTestState *qts, uint64_t base);
 QFWCFG *io_fw_cfg_init(QTestState *qts, uint16_t base);
-- 
2.11.0
