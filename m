Received: from eggs.gnu.org ([2001:4830:134:3::10]:39316)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePDtc-0003zE-Sq
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 15:44:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePDtc-0006EM-0X
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 15:44:52 -0500
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:42748)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePDtb-0006Dx-Ra
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 15:44:51 -0500
Received: by mail-qk0-x242.google.com with SMTP id a71so3674503qkc.9
	for <qemu-devel@nongnu.org>; Wed, 13 Dec 2017 12:44:51 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed, 13 Dec 2017 17:44:26 -0300
Message-Id: <20171213204436.5379-2-f4bug@amsat.org>
In-Reply-To: <20171213204436.5379-1-f4bug@amsat.org>
References: <20171213204436.5379-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH 01/11] util/cutils: add
 qemu_hexbuf_strdup(), yet another hexdump()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Isaac Lozano <109lozanoi@gmail.com>, Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

This will be helpful for tracing() API.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
"yet", so probably duplicating a better way to do it :|

 include/qemu/cutils.h |  3 +++
 util/hexdump.c        | 19 +++++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/include/qemu/cutils.h b/include/qemu/cutils.h
index f0878eaafa..2966cd5d64 100644
--- a/include/qemu/cutils.h
+++ b/include/qemu/cutils.h
@@ -164,4 +164,7 @@ bool test_buffer_is_zero_next_accel(void);
 int uleb128_encode_small(uint8_t *out, uint32_t n);
 int uleb128_decode_small(const uint8_t *in, uint32_t *n);
 
+char *qemu_hexbuf_strdup(const void *buf, size_t size,
+                         const char *str_hdr, const char *desc_if_empty);
+
 #endif
diff --git a/util/hexdump.c b/util/hexdump.c
index f879ff0ad6..cabf33b2b8 100644
--- a/util/hexdump.c
+++ b/util/hexdump.c
@@ -15,6 +15,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu-common.h"
+#include "qemu/cutils.h"
 
 void qemu_hexdump(const char *buf, FILE *fp, const char *prefix, size_t size)
 {
@@ -47,3 +48,21 @@ void qemu_hexdump(const char *buf, FILE *fp, const char *prefix, size_t size)
         fprintf(fp, "\n");
     }
 }
+
+char *qemu_hexbuf_strdup(const void *buf, size_t size,
+                         const char *str_hdr, const char *desc_if_empty)
+{
+    const uint8_t *u8 = (uint8_t *)buf;
+    GString *s;
+    int i;
+
+    if (!size) {
+        return g_strdup(desc_if_empty ? desc_if_empty : "");
+    }
+    s = g_string_new(str_hdr ? : "");
+    for (i = 0; i < size; i++) {
+        g_string_append_printf(s, "%02x ", u8[i]);
+    }
+
+    return g_string_free(s, FALSE);
+}
-- 
2.15.1
