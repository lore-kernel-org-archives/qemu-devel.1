Received: from eggs.gnu.org ([2001:4830:134:3::10]:41477)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1gUsJq-00082h-95
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 06:59:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1gUsJm-0004hx-9Q
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 06:59:50 -0500
Received: from mail.ispras.ru ([83.149.199.45]:59912)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1gUsJl-0004hi-S0
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 06:59:46 -0500
From: Mikhail Abakumov <mikhail.abakumov@ispras.ru>
Date: Thu, 06 Dec 2018 14:59:40 +0300
Message-ID: <154409758028.5432.10253854347982820034.stgit@Misha-PC.lan02.inno>
In-Reply-To: <154409751316.5432.3325938832238028060.stgit@Misha-PC.lan02.inno>
References: <154409751316.5432.3325938832238028060.stgit@Misha-PC.lan02.inno>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v3 11/39] windbg: add windbg_search_vmaddr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: sw@weilnetz.de, lprosek@redhat.com, dovgaluk@ispras.ru, rkagan@virtuozzo.com, pbonzini@redhat.com, den@openvz.org

Add function to search in virtual memory.
Implemented Boyer-Moore search algorithm.

Signed-off-by: Mikhail Abakumov <mikhail.abakumov@ispras.ru>
Signed-off-by: Pavel Dovgalyuk <dovgaluk@ispras.ru>
---
 include/exec/windbgstub-utils.h |    4 +
 windbgstub-utils.c              |  120 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 124 insertions(+)

diff --git a/include/exec/windbgstub-utils.h b/include/exec/windbgstub-utils.h
index e076227b39..2760684cfb 100644
--- a/include/exec/windbgstub-utils.h
+++ b/include/exec/windbgstub-utils.h
@@ -59,4 +59,8 @@ const char *kd_pkt_type_name(int id);
 bool windbg_on_load(void);
 void windbg_on_reset(void);
 
+InitedAddr windbg_search_vmaddr(CPUState *cs, target_ulong start,
+                                target_ulong finish, const uint8_t *pattern,
+                                int pLen);
+
 #endif /* WINDBGSTUB_UTILS_H */
diff --git a/windbgstub-utils.c b/windbgstub-utils.c
index 968e5cb2dd..6c5a86f667 100644
--- a/windbgstub-utils.c
+++ b/windbgstub-utils.c
@@ -80,6 +80,126 @@ static const char *kd_packet_type_names[] = {
     "PACKET_TYPE_MAX",
 };
 
+static void prep_bmbc(const uint8_t *pattern, int pLen, int bmBc[])
+{
+    int i;
+
+    for (i = 0; i < 256; ++i) {
+        bmBc[i] = pLen;
+    }
+    for (i = 0; i < pLen - 1; ++i) {
+        bmBc[pattern[i]] = pLen - i - 1;
+    }
+}
+
+static void prep_suffixes(const uint8_t *pattern, int pLen, int *suff)
+{
+    int f, g, i;
+
+    suff[pLen - 1] = pLen;
+    f = 0;
+    g = pLen - 1;
+    for (i = pLen - 2; i >= 0; --i) {
+        if (i > g && suff[i + pLen - 1 - f] < i - g) {
+            suff[i] = suff[i + pLen - 1 - f];
+        } else {
+            if (i < g) {
+                g = i;
+            }
+            f = i;
+            while (g >= 0 && pattern[g] == pattern[g + pLen - 1 - f]) {
+                --g;
+            }
+            suff[i] = f - g;
+        }
+    }
+}
+
+static void prep_bmgs(const uint8_t *pattern, int pLen, int bmGs[])
+{
+    int i, j, suff[pLen];
+
+    prep_suffixes(pattern, pLen, suff);
+
+    for (i = 0; i < pLen; ++i) {
+        bmGs[i] = pLen;
+    }
+
+    j = 0;
+    for (i = pLen - 1; i >= 0; --i) {
+        if (suff[i] == i + 1) {
+            for (; j < pLen - 1 - i; ++j) {
+                if (bmGs[j] == pLen) {
+                    bmGs[j] = pLen - 1 - i;
+                }
+            }
+        }
+    }
+
+    for (i = 0; i <= pLen - 2; ++i) {
+        bmGs[pLen - 1 - suff[i]] = pLen - 1 - i;
+    }
+}
+
+static int search_boyermoore(const uint8_t *data, int dLen,
+                             const uint8_t *pattern, int pLen, int bmGs[],
+                             int bmBc[])
+{
+    int i;
+    int j = 0;
+    while (j <= dLen - pLen) {
+        i = pLen - 1;
+        while (i >= 0 && pattern[i] == data[i + j]) {
+            --i;
+        }
+        if (i < 0) {
+            return j;
+        } else {
+            j += MAX(bmGs[i], bmBc[data[i + j]] - pLen + 1 + i);
+        }
+    }
+    return -1;
+}
+
+InitedAddr windbg_search_vmaddr(CPUState *cs, target_ulong start,
+                                target_ulong finish, const uint8_t *pattern,
+                                int pLen)
+{
+    InitedAddr ret = {
+        .addr = 0,
+        .is_init = false,
+    };
+    int bmGs[pLen], bmBc[256];
+    int find;
+    target_ulong offset = start;
+    target_ulong step = MIN(MAX(finish - start, 0x10000), pLen * 2);
+
+    if (finish <= start || pLen > finish - start) {
+        return ret;
+    }
+
+    uint8_t *buf = g_new(uint8_t, step);
+
+    prep_bmgs(pattern, pLen, bmGs);
+    prep_bmbc(pattern, pLen, bmBc);
+
+    while (offset < finish) {
+        step = MIN(step, finish - offset);
+        if (cpu_memory_rw_debug(cs, offset, buf, step, 0) == 0) {
+            find = search_boyermoore(buf, step, pattern, pLen, bmGs, bmBc);
+            if (find >= 0) {
+                ret.addr = offset + find;
+                ret.is_init = true;
+                break;
+            }
+        }
+        offset += step - pLen;
+    }
+
+    g_free(buf);
+    return ret;
+}
+
 const char *kd_api_name(int id)
 {
     return (id >= DbgKdMinimumManipulate && id < DbgKdMaximumManipulate)
