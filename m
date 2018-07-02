Received: from eggs.gnu.org ([2001:4830:134:3::10]:38737)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jusual@mail.ru>) id 1fZshw-0005dp-Kt
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 02:53:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jusual@mail.ru>) id 1fZsht-0001SY-GY
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 02:53:08 -0400
Received: from smtp33.i.mail.ru ([94.100.177.93]:42540)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jusual@mail.ru>) id 1fZsht-0001Ol-5a
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 02:53:05 -0400
From: Julia Suvorova <jusual@mail.ru>
Date: Mon,  2 Jul 2018 09:52:37 +0300
Message-Id: <20180702065237.27899-1-jusual@mail.ru>
Subject: [Qemu-devel] [PATCH] qtest: Use cpu address space instead of system
 memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, =?UTF-8?q?Steffen=20G=C3=B6rtz?= <mail@steffen-goertz.de>, Julia Suvorova <jusual@mail.ru>

Some devices (like nvic in armv7m) are not accessable through
address_space_memory, therefore can not be tested with qtest.

Signed-off-by: Julia Suvorova <jusual@mail.ru>
---
 qtest.c | 39 ++++++++++++++++++++++++++-------------
 1 file changed, 26 insertions(+), 13 deletions(-)

diff --git a/qtest.c b/qtest.c
index cbbfb71114..69b9e9962b 100644
--- a/qtest.c
+++ b/qtest.c
@@ -387,19 +387,23 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
 
         if (words[0][5] == 'b') {
             uint8_t data = value;
-            cpu_physical_memory_write(addr, &data, 1);
+            address_space_rw(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
+                             &data, 1, true);
         } else if (words[0][5] == 'w') {
             uint16_t data = value;
             tswap16s(&data);
-            cpu_physical_memory_write(addr, &data, 2);
+            address_space_rw(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
+                             (uint8_t *) &data, 2, true);
         } else if (words[0][5] == 'l') {
             uint32_t data = value;
             tswap32s(&data);
-            cpu_physical_memory_write(addr, &data, 4);
+            address_space_rw(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
+                             (uint8_t *) &data, 4, true);
         } else if (words[0][5] == 'q') {
             uint64_t data = value;
             tswap64s(&data);
-            cpu_physical_memory_write(addr, &data, 8);
+            address_space_rw(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
+                             (uint8_t *) &data, 8, true);
         }
         qtest_send_prefix(chr);
         qtest_send(chr, "OK\n");
@@ -417,18 +421,22 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
 
         if (words[0][4] == 'b') {
             uint8_t data;
-            cpu_physical_memory_read(addr, &data, 1);
+            address_space_rw(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
+                             &data, 1, false);
             value = data;
         } else if (words[0][4] == 'w') {
             uint16_t data;
-            cpu_physical_memory_read(addr, &data, 2);
+            address_space_rw(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
+                             (uint8_t *) &data, 2, false);
             value = tswap16(data);
         } else if (words[0][4] == 'l') {
             uint32_t data;
-            cpu_physical_memory_read(addr, &data, 4);
+            address_space_rw(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
+                             (uint8_t *) &data, 4, false);
             value = tswap32(data);
         } else if (words[0][4] == 'q') {
-            cpu_physical_memory_read(addr, &value, 8);
+            address_space_rw(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
+                             (uint8_t *) &value, 8, false);
             tswap64s(&value);
         }
         qtest_send_prefix(chr);
@@ -448,7 +456,8 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
         g_assert(len);
 
         data = g_malloc(len);
-        cpu_physical_memory_read(addr, data, len);
+        address_space_rw(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
+                         data, len, false);
 
         enc = g_malloc(2 * len + 1);
         for (i = 0; i < len; i++) {
@@ -473,7 +482,8 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
         g_assert(ret == 0);
 
         data = g_malloc(len);
-        cpu_physical_memory_read(addr, data, len);
+        address_space_rw(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
+                         data, len, false);
         b64_data = g_base64_encode(data, len);
         qtest_send_prefix(chr);
         qtest_sendf(chr, "OK %s\n", b64_data);
@@ -507,7 +517,8 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
                 data[i] = 0;
             }
         }
-        cpu_physical_memory_write(addr, data, len);
+        address_space_rw(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
+                         data, len, true);
         g_free(data);
 
         qtest_send_prefix(chr);
@@ -529,7 +540,8 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
         if (len) {
             data = g_malloc(len);
             memset(data, pattern, len);
-            cpu_physical_memory_write(addr, data, len);
+            address_space_rw(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
+                             data, len, true);
             g_free(data);
         }
 
@@ -562,7 +574,8 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
             out_len = MIN(out_len, len);
         }
 
-        cpu_physical_memory_write(addr, data, out_len);
+        address_space_rw(first_cpu->as, addr, MEMTXATTRS_UNSPECIFIED,
+                         data, len, true);
 
         qtest_send_prefix(chr);
         qtest_send(chr, "OK\n");
-- 
2.17.1
