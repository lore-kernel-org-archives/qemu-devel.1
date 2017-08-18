Received: from eggs.gnu.org ([2001:4830:134:3::10]:59494)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dioca-00071b-Bk
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 17:16:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1diocY-0000te-NN
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 17:16:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52300)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1diocY-0000sr-Cg
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 17:15:58 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7C7A8C047B64
	for <qemu-devel@nongnu.org>; Fri, 18 Aug 2017 21:15:57 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Fri, 18 Aug 2017 16:15:41 -0500
Message-Id: <20170818211542.5380-13-eblake@redhat.com>
In-Reply-To: <20170818211542.5380-1-eblake@redhat.com>
References: <20170818211542.5380-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v5 12/13] libqtest: Use global_qtest in
 qtest_sendf() and qtest_rsp()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com

All callers are now passing global_qtest, just remove the parameter
instead.  While at it, improve the naming of the va_list variant
of socket_sendf() to be more like the printf/vprintf naming scheme.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 tests/libqtest.c | 77 +++++++++++++++++++++++++++-----------------------------
 1 file changed, 37 insertions(+), 40 deletions(-)

diff --git a/tests/libqtest.c b/tests/libqtest.c
index 2998b173f0..0ec8668c88 100644
--- a/tests/libqtest.c
+++ b/tests/libqtest.c
@@ -150,7 +150,7 @@ static void socket_send(int fd, const char *buf, ssize_t size)
     }
 }

-static void socket_sendf(int fd, const char *fmt, va_list ap)
+static void socket_vsendf(int fd, const char *fmt, va_list ap)
 {
     gchar *str = g_strdup_vprintf(fmt, ap);

@@ -158,12 +158,12 @@ static void socket_sendf(int fd, const char *fmt, va_list ap)
     g_free(str);
 }

-static void GCC_FMT_ATTR(2, 3) qtest_sendf(QTestState *s, const char *fmt, ...)
+static void GCC_FMT_ATTR(1, 2) qtest_sendf(const char *fmt, ...)
 {
     va_list ap;

     va_start(ap, fmt);
-    socket_sendf(s->fd, fmt, ap);
+    socket_vsendf(global_qtest->fd, fmt, ap);
     va_end(ap);
 }

@@ -197,14 +197,14 @@ static GString *qtest_recv_line(QTestState *s)
     return line;
 }

-static gchar **qtest_rsp(QTestState *s, int expected_args)
+static gchar **qtest_rsp(int expected_args)
 {
     GString *line;
     gchar **words;
     int i;

 redo:
-    line = qtest_recv_line(s);
+    line = qtest_recv_line(global_qtest);
     words = g_strsplit(line->str, " ", 0);
     g_string_free(line, TRUE);

@@ -221,9 +221,9 @@ redo:
         g_assert_cmpint(irq, <, MAX_IRQ);

         if (strcmp(words[1], "raise") == 0) {
-            s->irq_level[irq] = true;
+            global_qtest->irq_level[irq] = true;
         } else {
-            s->irq_level[irq] = false;
+            global_qtest->irq_level[irq] = false;
         }

         g_strfreev(words);
@@ -338,8 +338,8 @@ void qtest_start_without_qmp_handshake(const char *extra_args)
     }

     /* ask endianness of the target */
-    qtest_sendf(global_qtest, "endianness\n");
-    args = qtest_rsp(global_qtest, 1);
+    qtest_sendf("endianness\n");
+    args = qtest_rsp(1);
     g_assert(strcmp(args[1], "big") == 0 || strcmp(args[1], "little") == 0);
     s->big_endian = strcmp(args[1], "big") == 0;
     g_strfreev(args);
@@ -618,7 +618,7 @@ static int64_t qtest_clock_rsp(void)
 {
     gchar **words;
     int64_t clock;
-    words = qtest_rsp(global_qtest, 2);
+    words = qtest_rsp(2);
     clock = g_ascii_strtoll(words[1], NULL, 0);
     g_strfreev(words);
     return clock;
@@ -626,38 +626,38 @@ static int64_t qtest_clock_rsp(void)

 int64_t clock_step_next(void)
 {
-    qtest_sendf(global_qtest, "clock_step\n");
+    qtest_sendf("clock_step\n");
     return qtest_clock_rsp();
 }

 int64_t clock_step(int64_t step)
 {
-    qtest_sendf(global_qtest, "clock_step %"PRIi64"\n", step);
+    qtest_sendf("clock_step %"PRIi64"\n", step);
     return qtest_clock_rsp();
 }

 int64_t clock_set(int64_t val)
 {
-    qtest_sendf(global_qtest, "clock_set %"PRIi64"\n", val);
+    qtest_sendf("clock_set %"PRIi64"\n", val);
     return qtest_clock_rsp();
 }

 void irq_intercept_out(const char *qom_path)
 {
-    qtest_sendf(global_qtest, "irq_intercept_out %s\n", qom_path);
-    qtest_rsp(global_qtest, 0);
+    qtest_sendf("irq_intercept_out %s\n", qom_path);
+    qtest_rsp(0);
 }

 void irq_intercept_in(const char *qom_path)
 {
-    qtest_sendf(global_qtest, "irq_intercept_in %s\n", qom_path);
-    qtest_rsp(global_qtest, 0);
+    qtest_sendf("irq_intercept_in %s\n", qom_path);
+    qtest_rsp(0);
 }

 static void out(const char *cmd, uint16_t addr, uint32_t value)
 {
-    qtest_sendf(global_qtest, "%s 0x%x 0x%x\n", cmd, addr, value);
-    qtest_rsp(global_qtest, 0);
+    qtest_sendf("%s 0x%x 0x%x\n", cmd, addr, value);
+    qtest_rsp(0);
 }

 void outb(uint16_t addr, uint8_t value)
@@ -681,8 +681,8 @@ static uint32_t in(const char *cmd, uint16_t addr)
     int ret;
     unsigned long value;

-    qtest_sendf(global_qtest, "%s 0x%x\n", cmd, addr);
-    args = qtest_rsp(global_qtest, 2);
+    qtest_sendf("%s 0x%x\n", cmd, addr);
+    args = qtest_rsp(2);
     ret = qemu_strtoul(args[1], NULL, 0, &value);
     g_assert(!ret && value <= UINT32_MAX);
     g_strfreev(args);
@@ -708,9 +708,8 @@ uint32_t inl(uint16_t addr)
 static void qtest_write(const char *cmd, uint64_t addr,
                         uint64_t value)
 {
-    qtest_sendf(global_qtest, "%s 0x%" PRIx64 " 0x%" PRIx64 "\n", cmd, addr,
-                value);
-    qtest_rsp(global_qtest, 0);
+    qtest_sendf("%s 0x%" PRIx64 " 0x%" PRIx64 "\n", cmd, addr, value);
+    qtest_rsp(0);
 }

 void writeb(uint64_t addr, uint8_t value)
@@ -739,8 +738,8 @@ static uint64_t qtest_read(const char *cmd, uint64_t addr)
     int ret;
     uint64_t value;

-    qtest_sendf(global_qtest, "%s 0x%" PRIx64 "\n", cmd, addr);
-    args = qtest_rsp(global_qtest, 2);
+    qtest_sendf("%s 0x%" PRIx64 "\n", cmd, addr);
+    args = qtest_rsp(2);
     ret = qemu_strtou64(args[1], NULL, 0, &value);
     g_assert(!ret);
     g_strfreev(args);
@@ -791,8 +790,8 @@ void memread(uint64_t addr, void *data, size_t size)
         return;
     }

-    qtest_sendf(global_qtest, "read 0x%" PRIx64 " 0x%zx\n", addr, size);
-    args = qtest_rsp(global_qtest, 2);
+    qtest_sendf("read 0x%" PRIx64 " 0x%zx\n", addr, size);
+    args = qtest_rsp(2);

     for (i = 0; i < size; i++) {
         ptr[i] = hex2nib(args[1][2 + (i * 2)]) << 4;
@@ -805,9 +804,9 @@ void memread(uint64_t addr, void *data, size_t size)
 uint64_t rtas_call(const char *name, uint32_t nargs, uint64_t args,
                    uint32_t nret, uint64_t ret)
 {
-    qtest_sendf(global_qtest, "rtas %s %u 0x%"PRIx64" %u 0x%"PRIx64"\n",
+    qtest_sendf("rtas %s %u 0x%"PRIx64" %u 0x%"PRIx64"\n",
                 name, nargs, args, nret, ret);
-    qtest_rsp(global_qtest, 0);
+    qtest_rsp(0);
     return 0;
 }

@@ -840,10 +839,10 @@ void bufwrite(uint64_t addr, const void *data, size_t size)
     gchar *bdata;

     bdata = g_base64_encode(data, size);
-    qtest_sendf(global_qtest, "b64write 0x%" PRIx64 " 0x%zx ", addr, size);
+    qtest_sendf("b64write 0x%" PRIx64 " 0x%zx ", addr, size);
     socket_send(global_qtest->fd, bdata, -1);
     socket_send(global_qtest->fd, "\n", 1);
-    qtest_rsp(global_qtest, 0);
+    qtest_rsp(0);
     g_free(bdata);
 }

@@ -852,8 +851,8 @@ void bufread(uint64_t addr, void *data, size_t size)
     gchar **args;
     size_t len;

-    qtest_sendf(global_qtest, "b64read 0x%" PRIx64 " 0x%zx\n", addr, size);
-    args = qtest_rsp(global_qtest, 2);
+    qtest_sendf("b64read 0x%" PRIx64 " 0x%zx\n", addr, size);
+    args = qtest_rsp(2);

     g_base64_decode_inplace(args[1], &len);
     if (size != len) {
@@ -882,17 +881,15 @@ void memwrite(uint64_t addr, const void *data, size_t size)
         sprintf(&enc[i * 2], "%02x", ptr[i]);
     }

-    qtest_sendf(global_qtest, "write 0x%" PRIx64 " 0x%zx 0x%s\n", addr, size,
-                enc);
-    qtest_rsp(global_qtest, 0);
+    qtest_sendf("write 0x%" PRIx64 " 0x%zx 0x%s\n", addr, size, enc);
+    qtest_rsp(0);
     g_free(enc);
 }

 void qmemset(uint64_t addr, uint8_t pattern, size_t size)
 {
-    qtest_sendf(global_qtest, "memset 0x%" PRIx64 " 0x%zx 0x%02x\n", addr, size,
-                pattern);
-    qtest_rsp(global_qtest, 0);
+    qtest_sendf("memset 0x%" PRIx64 " 0x%zx 0x%02x\n", addr, size, pattern);
+    qtest_rsp(0);
 }

 QDict *qmp(const char *fmt, ...)
-- 
2.13.5
