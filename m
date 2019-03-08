Received: from eggs.gnu.org ([209.51.188.92]:36957)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1h2Bf0-0005k0-DV
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 04:19:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1h2Bez-0000Gv-66
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 04:19:22 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59960)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1h2Bey-0000GU-TM
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 04:19:21 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Fri,  8 Mar 2019 10:18:40 +0100
Message-Id: <1552036723-1949-5-git-send-email-thuth@redhat.com>
In-Reply-To: <1552036723-1949-1-git-send-email-thuth@redhat.com>
References: <1552036723-1949-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PULL 4/7] tests: Do not use "\n" in g_test_message()
 strings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

g_test_message() takes care of the newline on its own, so we
should not use \n in the strings here.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/ivshmem-test.c         |  4 ++--
 tests/m48t59-test.c          |  4 ++--
 tests/migration-test.c       |  4 ++--
 tests/rtc-test.c             |  4 ++--
 tests/rtl8139-test.c         |  6 +++---
 tests/test-aio-multithread.c |  8 ++++----
 tests/test-coroutine.c       | 10 ++++------
 tests/vhost-user-test.c      | 10 +++++-----
 8 files changed, 24 insertions(+), 26 deletions(-)

diff --git a/tests/ivshmem-test.c b/tests/ivshmem-test.c
index 942ddc9..227561f 100644
--- a/tests/ivshmem-test.c
+++ b/tests/ivshmem-test.c
@@ -74,7 +74,7 @@ static inline unsigned in_reg(IVState *s, enum Reg reg)
     unsigned res;
 
     res = qpci_io_readl(s->dev, s->reg_bar, reg);
-    g_test_message("*%s -> %x\n", name, res);
+    g_test_message("*%s -> %x", name, res);
 
     return res;
 }
@@ -83,7 +83,7 @@ static inline void out_reg(IVState *s, enum Reg reg, unsigned v)
 {
     const char *name = reg2str(reg);
 
-    g_test_message("%x -> *%s\n", v, name);
+    g_test_message("%x -> *%s", v, name);
     qpci_io_writel(s->dev, s->reg_bar, reg, v);
 }
 
diff --git a/tests/m48t59-test.c b/tests/m48t59-test.c
index 4abf9c6..b94a123 100644
--- a/tests/m48t59-test.c
+++ b/tests/m48t59-test.c
@@ -199,9 +199,9 @@ static void bcd_check_time(void)
         t = (long)mktime(datep);
         s = (long)mktime(&start);
         if (t < s) {
-            g_test_message("RTC is %ld second(s) behind wall-clock\n", (s - t));
+            g_test_message("RTC is %ld second(s) behind wall-clock", (s - t));
         } else {
-            g_test_message("RTC is %ld second(s) ahead of wall-clock\n", (t - s));
+            g_test_message("RTC is %ld second(s) ahead of wall-clock", (t - s));
         }
 
         g_assert_cmpint(ABS(t - s), <=, wiggle);
diff --git a/tests/migration-test.c b/tests/migration-test.c
index e3617ce..48dc20a 100644
--- a/tests/migration-test.c
+++ b/tests/migration-test.c
@@ -1066,7 +1066,7 @@ int main(int argc, char **argv)
 
     tmpfs = mkdtemp(template);
     if (!tmpfs) {
-        g_test_message("mkdtemp on path (%s): %s\n", template, strerror(errno));
+        g_test_message("mkdtemp on path (%s): %s", template, strerror(errno));
     }
     g_assert(tmpfs);
 
@@ -1087,7 +1087,7 @@ int main(int argc, char **argv)
 
     ret = rmdir(tmpfs);
     if (ret != 0) {
-        g_test_message("unable to rmdir: path (%s): %s\n",
+        g_test_message("unable to rmdir: path (%s): %s",
                        tmpfs, strerror(errno));
     }
 
diff --git a/tests/rtc-test.c b/tests/rtc-test.c
index d7a96cb..509be70 100644
--- a/tests/rtc-test.c
+++ b/tests/rtc-test.c
@@ -165,9 +165,9 @@ static void check_time(int wiggle)
         t = (long)mktime(datep);
         s = (long)mktime(&start);
         if (t < s) {
-            g_test_message("RTC is %ld second(s) behind wall-clock\n", (s - t));
+            g_test_message("RTC is %ld second(s) behind wall-clock", (s - t));
         } else {
-            g_test_message("RTC is %ld second(s) ahead of wall-clock\n", (t - s));
+            g_test_message("RTC is %ld second(s) ahead of wall-clock", (t - s));
         }
 
         g_assert_cmpint(ABS(t - s), <=, wiggle);
diff --git a/tests/rtl8139-test.c b/tests/rtl8139-test.c
index 68bfc42..49e3f03 100644
--- a/tests/rtl8139-test.c
+++ b/tests/rtl8139-test.c
@@ -46,12 +46,12 @@ static QPCIDevice *get_device(void)
 static unsigned __attribute__((unused)) in_##name(void) \
 { \
     unsigned res = qpci_io_read##len(dev, dev_bar, (val));     \
-    g_test_message("*%s -> %x\n", #name, res); \
+    g_test_message("*%s -> %x", #name, res); \
     return res; \
 } \
 static void out_##name(unsigned v) \
 { \
-    g_test_message("%x -> *%s\n", v, #name); \
+    g_test_message("%x -> *%s", v, #name); \
     qpci_io_write##len(dev, dev_bar, (val), v);        \
 }
 
@@ -176,7 +176,7 @@ static void test_timer(void)
         }
     }
 
-    g_test_message("Everythink is ok!\n");
+    g_test_message("Everythink is ok!");
 }
 
 
diff --git a/tests/test-aio-multithread.c b/tests/test-aio-multithread.c
index 6440d54..d3144be 100644
--- a/tests/test-aio-multithread.c
+++ b/tests/test-aio-multithread.c
@@ -178,7 +178,7 @@ static void test_multi_co_schedule(int seconds)
     }
 
     join_aio_contexts();
-    g_test_message("scheduled %d, queued %d, retry %d, total %d\n",
+    g_test_message("scheduled %d, queued %d, retry %d, total %d",
                   count_other, count_here, count_retry,
                   count_here + count_other + count_retry);
 }
@@ -242,7 +242,7 @@ static void test_multi_co_mutex(int threads, int seconds)
     }
 
     join_aio_contexts();
-    g_test_message("%d iterations/second\n", counter / seconds);
+    g_test_message("%d iterations/second", counter / seconds);
     g_assert_cmpint(counter, ==, atomic_counter);
 }
 
@@ -361,7 +361,7 @@ static void test_multi_fair_mutex(int threads, int seconds)
     }
 
     join_aio_contexts();
-    g_test_message("%d iterations/second\n", counter / seconds);
+    g_test_message("%d iterations/second", counter / seconds);
     g_assert_cmpint(counter, ==, atomic_counter);
 }
 
@@ -417,7 +417,7 @@ static void test_multi_mutex(int threads, int seconds)
     }
 
     join_aio_contexts();
-    g_test_message("%d iterations/second\n", counter / seconds);
+    g_test_message("%d iterations/second", counter / seconds);
     g_assert_cmpint(counter, ==, atomic_counter);
 }
 
diff --git a/tests/test-coroutine.c b/tests/test-coroutine.c
index 28e79b3..e946d93 100644
--- a/tests/test-coroutine.c
+++ b/tests/test-coroutine.c
@@ -369,7 +369,7 @@ static void perf_lifecycle(void)
     }
     duration = g_test_timer_elapsed();
 
-    g_test_message("Lifecycle %u iterations: %f s\n", max, duration);
+    g_test_message("Lifecycle %u iterations: %f s", max, duration);
 }
 
 static void perf_nesting(void)
@@ -393,7 +393,7 @@ static void perf_nesting(void)
     }
     duration = g_test_timer_elapsed();
 
-    g_test_message("Nesting %u iterations of %u depth each: %f s\n",
+    g_test_message("Nesting %u iterations of %u depth each: %f s",
         maxcycles, maxnesting, duration);
 }
 
@@ -426,8 +426,7 @@ static void perf_yield(void)
     }
     duration = g_test_timer_elapsed();
 
-    g_test_message("Yield %u iterations: %f s\n",
-        maxcycles, duration);
+    g_test_message("Yield %u iterations: %f s", maxcycles, duration);
 }
 
 static __attribute__((noinline)) void dummy(unsigned *i)
@@ -449,8 +448,7 @@ static void perf_baseline(void)
     }
     duration = g_test_timer_elapsed();
 
-    g_test_message("Function call %u iterations: %f s\n",
-        maxcycles, duration);
+    g_test_message("Function call %u iterations: %f s", maxcycles, duration);
 }
 
 static __attribute__((noinline)) void perf_cost_func(void *opaque)
diff --git a/tests/vhost-user-test.c b/tests/vhost-user-test.c
index 4cd0a97..83ea15f 100644
--- a/tests/vhost-user-test.c
+++ b/tests/vhost-user-test.c
@@ -337,7 +337,7 @@ static void chr_read(void *opaque, const uint8_t *buf, int size)
     }
 
     if (size != VHOST_USER_HDR_SIZE) {
-        g_test_message("Wrong message size received %d\n", size);
+        g_test_message("Wrong message size received %d", size);
         return;
     }
 
@@ -348,7 +348,7 @@ static void chr_read(void *opaque, const uint8_t *buf, int size)
         p += VHOST_USER_HDR_SIZE;
         size = qemu_chr_fe_read_all(chr, p, msg.size);
         if (size != msg.size) {
-            g_test_message("Wrong message size received %d != %d\n",
+            g_test_message("Wrong message size received %d != %d",
                            size, msg.size);
             return;
         }
@@ -476,7 +476,7 @@ static const char *init_hugepagefs(void)
     }
 
     if (access(path, R_OK | W_OK | X_OK)) {
-        g_test_message("access on path (%s): %s\n", path, strerror(errno));
+        g_test_message("access on path (%s): %s", path, strerror(errno));
         abort();
         return NULL;
     }
@@ -486,13 +486,13 @@ static const char *init_hugepagefs(void)
     } while (ret != 0 && errno == EINTR);
 
     if (ret != 0) {
-        g_test_message("statfs on path (%s): %s\n", path, strerror(errno));
+        g_test_message("statfs on path (%s): %s", path, strerror(errno));
         abort();
         return NULL;
     }
 
     if (fs.f_type != HUGETLBFS_MAGIC) {
-        g_test_message("Warning: path not on HugeTLBFS: %s\n", path);
+        g_test_message("Warning: path not on HugeTLBFS: %s", path);
         abort();
         return NULL;
     }
-- 
1.8.3.1
