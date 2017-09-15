Received: from eggs.gnu.org ([2001:4830:134:3::10]:54788)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dslaV-0007vf-4M
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 04:03:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dslaR-0000kx-WB
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 04:02:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49612)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dslaR-0000ko-Ne
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 04:02:55 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Fri, 15 Sep 2017 10:02:26 +0200
Message-Id: <1505462549-27298-7-git-send-email-thuth@redhat.com>
In-Reply-To: <1505462549-27298-1-git-send-email-thuth@redhat.com>
References: <1505462549-27298-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PULL 6/9] qtest: Don't perform side effects inside
 assertion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Eric Blake <eblake@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Peter Xu <peterx@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, John Snow <jsnow@redhat.com>

From: Eric Blake <eblake@redhat.com>

Assertions should be separate from the side effects, since in
theory, g_assert() can be disabled (in practice, we can't really
ever do that).

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 qtest.c | 82 ++++++++++++++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 58 insertions(+), 24 deletions(-)

diff --git a/qtest.c b/qtest.c
index 88a09e9..cbbfb71 100644
--- a/qtest.c
+++ b/qtest.c
@@ -332,10 +332,13 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
                strcmp(words[0], "outl") == 0) {
         unsigned long addr;
         unsigned long value;
+        int ret;
 
         g_assert(words[1] && words[2]);
-        g_assert(qemu_strtoul(words[1], NULL, 0, &addr) == 0);
-        g_assert(qemu_strtoul(words[2], NULL, 0, &value) == 0);
+        ret = qemu_strtoul(words[1], NULL, 0, &addr);
+        g_assert(ret == 0);
+        ret = qemu_strtoul(words[2], NULL, 0, &value);
+        g_assert(ret == 0);
         g_assert(addr <= 0xffff);
 
         if (words[0][3] == 'b') {
@@ -352,9 +355,11 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
         strcmp(words[0], "inl") == 0) {
         unsigned long addr;
         uint32_t value = -1U;
+        int ret;
 
         g_assert(words[1]);
-        g_assert(qemu_strtoul(words[1], NULL, 0, &addr) == 0);
+        ret = qemu_strtoul(words[1], NULL, 0, &addr);
+        g_assert(ret == 0);
         g_assert(addr <= 0xffff);
 
         if (words[0][2] == 'b') {
@@ -372,10 +377,13 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
                strcmp(words[0], "writeq") == 0) {
         uint64_t addr;
         uint64_t value;
+        int ret;
 
         g_assert(words[1] && words[2]);
-        g_assert(qemu_strtou64(words[1], NULL, 0, &addr) == 0);
-        g_assert(qemu_strtou64(words[2], NULL, 0, &value) == 0);
+        ret = qemu_strtou64(words[1], NULL, 0, &addr);
+        g_assert(ret == 0);
+        ret = qemu_strtou64(words[2], NULL, 0, &value);
+        g_assert(ret == 0);
 
         if (words[0][5] == 'b') {
             uint8_t data = value;
@@ -401,9 +409,11 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
                strcmp(words[0], "readq") == 0) {
         uint64_t addr;
         uint64_t value = UINT64_C(-1);
+        int ret;
 
         g_assert(words[1]);
-        g_assert(qemu_strtou64(words[1], NULL, 0, &addr) == 0);
+        ret = qemu_strtou64(words[1], NULL, 0, &addr);
+        g_assert(ret == 0);
 
         if (words[0][4] == 'b') {
             uint8_t data;
@@ -427,10 +437,13 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
         uint64_t addr, len, i;
         uint8_t *data;
         char *enc;
+        int ret;
 
         g_assert(words[1] && words[2]);
-        g_assert(qemu_strtou64(words[1], NULL, 0, &addr) == 0);
-        g_assert(qemu_strtou64(words[2], NULL, 0, &len) == 0);
+        ret = qemu_strtou64(words[1], NULL, 0, &addr);
+        g_assert(ret == 0);
+        ret = qemu_strtou64(words[2], NULL, 0, &len);
+        g_assert(ret == 0);
         /* We'd send garbage to libqtest if len is 0 */
         g_assert(len);
 
@@ -451,10 +464,13 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
         uint64_t addr, len;
         uint8_t *data;
         gchar *b64_data;
+        int ret;
 
         g_assert(words[1] && words[2]);
-        g_assert(qemu_strtou64(words[1], NULL, 0, &addr) == 0);
-        g_assert(qemu_strtou64(words[2], NULL, 0, &len) == 0);
+        ret = qemu_strtou64(words[1], NULL, 0, &addr);
+        g_assert(ret == 0);
+        ret = qemu_strtou64(words[2], NULL, 0, &len);
+        g_assert(ret == 0);
 
         data = g_malloc(len);
         cpu_physical_memory_read(addr, data, len);
@@ -468,10 +484,13 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
         uint64_t addr, len, i;
         uint8_t *data;
         size_t data_len;
+        int ret;
 
         g_assert(words[1] && words[2] && words[3]);
-        g_assert(qemu_strtou64(words[1], NULL, 0, &addr) == 0);
-        g_assert(qemu_strtou64(words[2], NULL, 0, &len) == 0);
+        ret = qemu_strtou64(words[1], NULL, 0, &addr);
+        g_assert(ret == 0);
+        ret = qemu_strtou64(words[2], NULL, 0, &len);
+        g_assert(ret == 0);
 
         data_len = strlen(words[3]);
         if (data_len < 3) {
@@ -497,11 +516,15 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
         uint64_t addr, len;
         uint8_t *data;
         unsigned long pattern;
+        int ret;
 
         g_assert(words[1] && words[2] && words[3]);
-        g_assert(qemu_strtou64(words[1], NULL, 0, &addr) == 0);
-        g_assert(qemu_strtou64(words[2], NULL, 0, &len) == 0);
-        g_assert(qemu_strtoul(words[3], NULL, 0, &pattern) == 0);
+        ret = qemu_strtou64(words[1], NULL, 0, &addr);
+        g_assert(ret == 0);
+        ret = qemu_strtou64(words[2], NULL, 0, &len);
+        g_assert(ret == 0);
+        ret = qemu_strtoul(words[3], NULL, 0, &pattern);
+        g_assert(ret == 0);
 
         if (len) {
             data = g_malloc(len);
@@ -517,10 +540,13 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
         uint8_t *data;
         size_t data_len;
         gsize out_len;
+        int ret;
 
         g_assert(words[1] && words[2] && words[3]);
-        g_assert(qemu_strtou64(words[1], NULL, 0, &addr) == 0);
-        g_assert(qemu_strtou64(words[2], NULL, 0, &len) == 0);
+        ret = qemu_strtou64(words[1], NULL, 0, &addr);
+        g_assert(ret == 0);
+        ret = qemu_strtou64(words[2], NULL, 0, &len);
+        g_assert(ret == 0);
 
         data_len = strlen(words[3]);
         if (data_len < 3) {
@@ -551,11 +577,16 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
     } else if (strcmp(words[0], "rtas") == 0) {
         uint64_t res, args, ret;
         unsigned long nargs, nret;
-
-        g_assert(qemu_strtoul(words[2], NULL, 0, &nargs) == 0);
-        g_assert(qemu_strtou64(words[3], NULL, 0, &args) == 0);
-        g_assert(qemu_strtoul(words[4], NULL, 0, &nret) == 0);
-        g_assert(qemu_strtou64(words[5], NULL, 0, &ret) == 0);
+        int rc;
+
+        rc = qemu_strtoul(words[2], NULL, 0, &nargs);
+        g_assert(rc == 0);
+        rc = qemu_strtou64(words[3], NULL, 0, &args);
+        g_assert(rc == 0);
+        rc = qemu_strtoul(words[4], NULL, 0, &nret);
+        g_assert(rc == 0);
+        rc = qemu_strtou64(words[5], NULL, 0, &ret);
+        g_assert(rc == 0);
         res = qtest_rtas_call(words[1], nargs, args, nret, ret);
 
         qtest_send_prefix(chr);
@@ -565,7 +596,8 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
         int64_t ns;
 
         if (words[1]) {
-            g_assert(qemu_strtoi64(words[1], NULL, 0, &ns) == 0);
+            int ret = qemu_strtoi64(words[1], NULL, 0, &ns);
+            g_assert(ret == 0);
         } else {
             ns = qemu_clock_deadline_ns_all(QEMU_CLOCK_VIRTUAL);
         }
@@ -575,9 +607,11 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
                     (int64_t)qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL));
     } else if (qtest_enabled() && strcmp(words[0], "clock_set") == 0) {
         int64_t ns;
+        int ret;
 
         g_assert(words[1]);
-        g_assert(qemu_strtoi64(words[1], NULL, 0, &ns) == 0);
+        ret = qemu_strtoi64(words[1], NULL, 0, &ns);
+        g_assert(ret == 0);
         qtest_clock_warp(ns);
         qtest_send_prefix(chr);
         qtest_sendf(chr, "OK %"PRIi64"\n",
-- 
1.8.3.1
