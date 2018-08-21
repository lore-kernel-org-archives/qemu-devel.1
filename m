Received: from eggs.gnu.org ([2001:4830:134:3::10]:33319)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fsA4V-0001nD-5p
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 13:04:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fsA4R-0006eN-9A
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 13:03:58 -0400
Received: from mail-wm0-x22d.google.com ([2a00:1450:400c:c09::22d]:36240)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fsA4I-0006Kf-LJ
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 13:03:48 -0400
Received: by mail-wm0-x22d.google.com with SMTP id w24-v6so3506192wmc.1
	for <qemu-devel@nongnu.org>; Tue, 21 Aug 2018 10:03:41 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 21 Aug 2018 19:02:05 +0200
Message-Id: <1534870966-9287-34-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1534870966-9287-1-git-send-email-pbonzini@redhat.com>
References: <1534870966-9287-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 33/74] build-sys: remove glib_subprocess check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

The check should be unnecessary since commit
e7b3af81597db1a6b55f2c15d030d703c6b2c6ac "glib: bump min required glib
library version to 2.40".

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20180730153639.26466-1-marcandre.lureau@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure                     | 3 ---
 tests/Makefile.include        | 2 +-
 tests/test-char.c             | 4 ----
 tests/test-x86-cpuid-compat.c | 6 ------
 tests/vhost-user-test.c       | 4 ----
 5 files changed, 1 insertion(+), 18 deletions(-)

diff --git a/configure b/configure
index af0c149..2ff272d 100755
--- a/configure
+++ b/configure
@@ -6428,9 +6428,6 @@ if test "$bluez" = "yes" ; then
   echo "CONFIG_BLUEZ=y" >> $config_host_mak
   echo "BLUEZ_CFLAGS=$bluez_cflags" >> $config_host_mak
 fi
-if test "$glib_subprocess" = "yes" ; then
-  echo "CONFIG_HAS_GLIB_SUBPROCESS_TESTS=y" >> $config_host_mak
-fi
 if test "$gtk" = "yes" ; then
   echo "CONFIG_GTK=m" >> $config_host_mak
   echo "CONFIG_GTKABI=$gtkabi" >> $config_host_mak
diff --git a/tests/Makefile.include b/tests/Makefile.include
index 29e70f4..f3a761b 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -124,7 +124,7 @@ check-unit-y += tests/test-qht-par$(EXESUF)
 gcov-files-test-qht-par-y = util/qht.c
 check-unit-y += tests/test-bitops$(EXESUF)
 check-unit-y += tests/test-bitcnt$(EXESUF)
-check-unit-$(CONFIG_HAS_GLIB_SUBPROCESS_TESTS) += tests/test-qdev-global-props$(EXESUF)
+check-unit-y += tests/test-qdev-global-props$(EXESUF)
 check-unit-y += tests/check-qom-interface$(EXESUF)
 gcov-files-check-qom-interface-y = qom/object.c
 check-unit-y += tests/check-qom-proplist$(EXESUF)
diff --git a/tests/test-char.c b/tests/test-char.c
index 5905d31..2a2ff32 100644
--- a/tests/test-char.c
+++ b/tests/test-char.c
@@ -56,7 +56,6 @@ static void fe_event(void *opaque, int event)
     }
 }
 
-#ifdef CONFIG_HAS_GLIB_SUBPROCESS_TESTS
 #ifdef _WIN32
 static void char_console_test_subprocess(void)
 {
@@ -106,7 +105,6 @@ static void char_stdio_test(void)
     g_test_trap_assert_passed();
     g_test_trap_assert_stdout("buf");
 }
-#endif
 
 static void char_ringbuf_test(void)
 {
@@ -807,14 +805,12 @@ int main(int argc, char **argv)
     g_test_add_func("/char/invalid", char_invalid_test);
     g_test_add_func("/char/ringbuf", char_ringbuf_test);
     g_test_add_func("/char/mux", char_mux_test);
-#ifdef CONFIG_HAS_GLIB_SUBPROCESS_TESTS
 #ifdef _WIN32
     g_test_add_func("/char/console/subprocess", char_console_test_subprocess);
     g_test_add_func("/char/console", char_console_test);
 #endif
     g_test_add_func("/char/stdio/subprocess", char_stdio_test_subprocess);
     g_test_add_func("/char/stdio", char_stdio_test);
-#endif
 #ifndef _WIN32
     g_test_add_func("/char/pipe", char_pipe_test);
 #endif
diff --git a/tests/test-x86-cpuid-compat.c b/tests/test-x86-cpuid-compat.c
index 84ce9c7..e75b959 100644
--- a/tests/test-x86-cpuid-compat.c
+++ b/tests/test-x86-cpuid-compat.c
@@ -35,7 +35,6 @@ static QObject *qom_get(const char *path, const char *prop)
     return ret;
 }
 
-#ifdef CONFIG_HAS_GLIB_SUBPROCESS_TESTS
 static bool qom_get_bool(const char *path, const char *prop)
 {
     QBool *value = qobject_to(QBool, qom_get(path, prop));
@@ -44,7 +43,6 @@ static bool qom_get_bool(const char *path, const char *prop)
     qobject_unref(value);
     return b;
 }
-#endif
 
 typedef struct CpuidTestArgs {
     const char *cmdline;
@@ -168,7 +166,6 @@ static FeatureTestArgs *add_feature_test(const char *name, const char *cmdline,
     return args;
 }
 
-#ifdef CONFIG_HAS_GLIB_SUBPROCESS_TESTS
 static void test_plus_minus_subprocess(void)
 {
     char *path;
@@ -210,17 +207,14 @@ static void test_plus_minus(void)
                               "Don't mix both \"+cx8\" and \"cx8=off\"*");
     g_test_trap_assert_stdout("");
 }
-#endif
 
 int main(int argc, char **argv)
 {
     g_test_init(&argc, &argv, NULL);
 
-#ifdef CONFIG_HAS_GLIB_SUBPROCESS_TESTS
     g_test_add_func("/x86/cpuid/parsing-plus-minus/subprocess",
                     test_plus_minus_subprocess);
     g_test_add_func("/x86/cpuid/parsing-plus-minus", test_plus_minus);
-#endif
 
     /* Original level values for CPU models: */
     add_cpuid_test("x86/cpuid/phenom/level",
diff --git a/tests/vhost-user-test.c b/tests/vhost-user-test.c
index ca6251f..716aff7 100644
--- a/tests/vhost-user-test.c
+++ b/tests/vhost-user-test.c
@@ -768,7 +768,6 @@ static void wait_for_rings_started(TestServer *s, size_t count)
     g_mutex_unlock(&s->data_mutex);
 }
 
-#if defined(CONFIG_HAS_GLIB_SUBPROCESS_TESTS)
 static inline void test_server_connect(TestServer *server)
 {
     test_server_create_chr(server, ",reconnect=1");
@@ -893,7 +892,6 @@ static void test_flags_mismatch(void)
     g_free(path);
 }
 
-#endif
 
 static void test_multiqueue(void)
 {
@@ -975,7 +973,6 @@ int main(int argc, char **argv)
     qtest_add_func("/vhost-user/migrate", test_migrate);
     qtest_add_func("/vhost-user/multiqueue", test_multiqueue);
 
-#if defined(CONFIG_HAS_GLIB_SUBPROCESS_TESTS)
     /* keeps failing on build-system since Aug 15 2017 */
     if (getenv("QTEST_VHOST_USER_FIXME")) {
         qtest_add_func("/vhost-user/reconnect/subprocess",
@@ -988,7 +985,6 @@ int main(int argc, char **argv)
                        test_flags_mismatch_subprocess);
         qtest_add_func("/vhost-user/flags-mismatch", test_flags_mismatch);
     }
-#endif
 
     ret = g_test_run();
 
-- 
1.8.3.1
