Received: from eggs.gnu.org ([2001:4830:134:3::10]:36180)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fssmE-0002iA-7A
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 12:48:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fssmA-0007I0-8j
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 12:48:06 -0400
Received: from mail-wm0-x233.google.com ([2a00:1450:400c:c09::233]:37796)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fssm9-0007HM-VG
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 12:48:02 -0400
Received: by mail-wm0-x233.google.com with SMTP id n11-v6so6494819wmc.2
	for <qemu-devel@nongnu.org>; Thu, 23 Aug 2018 09:48:01 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 23 Aug 2018 18:47:56 +0200
Message-Id: <20180823164756.16948-2-pbonzini@redhat.com>
In-Reply-To: <20180823164756.16948-1-pbonzini@redhat.com>
References: <20180823164756.16948-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 14/69] tests: Skip old versioned machine types
 in quick testing mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>

From: Thomas Huth <thuth@redhat.com>

The tests that check something for all machine types currently spend
a lot of time checking old machine types (like "pc-i440fx-2.0" for
example). The chances that we find something new there in addition
to checking the latest version of a machine type are pretty low, so
we should not waste the time of the developers by testing this again
and again in the "quick" testing mode.
Thus let's add some code to determine whether we are testing a current
machine type or an old one, and only test the old types if we are
running in "SPEED=slow" mode.
This decreases the testing time quite a bit now, e.g. the qom-test
now finishes within 4 seconds for qemu-system-x86_64 instead of 30
seconds when testing all machines.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <1534419358-10932-6-git-send-email-thuth@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/cpu-plug-test.c |  6 ++---
 tests/libqtest.c      | 52 +++++++++++++++++++++++++++++++++++++++++--
 tests/libqtest.h      |  4 +++-
 tests/qom-test.c      |  2 +-
 tests/test-hmp.c      |  2 +-
 5 files changed, 58 insertions(+), 8 deletions(-)

diff --git a/tests/cpu-plug-test.c b/tests/cpu-plug-test.c
index f5d57da60e..3e93c8e096 100644
--- a/tests/cpu-plug-test.c
+++ b/tests/cpu-plug-test.c
@@ -257,11 +257,11 @@ int main(int argc, char **argv)
     g_test_init(&argc, &argv, NULL);
 
     if (strcmp(arch, "i386") == 0 || strcmp(arch, "x86_64") == 0) {
-        qtest_cb_for_every_machine(add_pc_test_case);
+        qtest_cb_for_every_machine(add_pc_test_case, g_test_quick());
     } else if (g_str_equal(arch, "ppc64")) {
-        qtest_cb_for_every_machine(add_pseries_test_case);
+        qtest_cb_for_every_machine(add_pseries_test_case, g_test_quick());
     } else if (g_str_equal(arch, "s390x")) {
-        qtest_cb_for_every_machine(add_s390x_test_case);
+        qtest_cb_for_every_machine(add_s390x_test_case, g_test_quick());
     }
 
     return g_test_run();
diff --git a/tests/libqtest.c b/tests/libqtest.c
index 852ccff1ce..1105c37e08 100644
--- a/tests/libqtest.c
+++ b/tests/libqtest.c
@@ -991,7 +991,53 @@ bool qtest_big_endian(QTestState *s)
     return s->big_endian;
 }
 
-void qtest_cb_for_every_machine(void (*cb)(const char *machine))
+static bool qtest_check_machine_version(const char *mname, const char *basename,
+                                        int major, int minor)
+{
+    char *newname;
+    bool is_equal;
+
+    newname = g_strdup_printf("%s-%i.%i", basename, major, minor);
+    is_equal = g_str_equal(mname, newname);
+    g_free(newname);
+
+    return is_equal;
+}
+
+static bool qtest_is_old_versioned_machine(const char *mname)
+{
+    const char *dash = strrchr(mname, '-');
+    const char *dot = strrchr(mname, '.');
+    const char *chr;
+    char *bname;
+    const int major = QEMU_VERSION_MAJOR;
+    const int minor = QEMU_VERSION_MINOR;
+    bool res = false;
+
+    if (dash && dot && dot > dash) {
+        for (chr = dash + 1; *chr; chr++) {
+            if (!qemu_isdigit(*chr) && *chr != '.') {
+                return false;
+            }
+        }
+        /*
+         * Now check if it is one of the latest versions. Check major + 1
+         * and minor + 1 versions as well, since they might already exist
+         * in the development branch.
+         */
+        bname = g_strdup(mname);
+        bname[dash - mname] = 0;
+        res = !qtest_check_machine_version(mname, bname, major + 1, 0) &&
+              !qtest_check_machine_version(mname, bname, major, minor + 1) &&
+              !qtest_check_machine_version(mname, bname, major, minor);
+        g_free(bname);
+    }
+
+    return res;
+}
+
+void qtest_cb_for_every_machine(void (*cb)(const char *machine),
+                                bool skip_old_versioned)
 {
     QDict *response, *minfo;
     QList *list;
@@ -1014,7 +1060,9 @@ void qtest_cb_for_every_machine(void (*cb)(const char *machine))
         qstr = qobject_to(QString, qobj);
         g_assert(qstr);
         mname = qstring_get_str(qstr);
-        cb(mname);
+        if (!skip_old_versioned || !qtest_is_old_versioned_machine(mname)) {
+            cb(mname);
+        }
     }
 
     qtest_end();
diff --git a/tests/libqtest.h b/tests/libqtest.h
index def1edaafa..1159b73d15 100644
--- a/tests/libqtest.h
+++ b/tests/libqtest.h
@@ -954,10 +954,12 @@ QDict *qmp_fd(int fd, const char *fmt, ...) GCC_FMT_ATTR(2, 3);
 /**
  * qtest_cb_for_every_machine:
  * @cb: Pointer to the callback function
+ * @skip_old_versioned: true if versioned old machine types should be skipped
  *
  *  Call a callback function for every name of all available machines.
  */
-void qtest_cb_for_every_machine(void (*cb)(const char *machine));
+void qtest_cb_for_every_machine(void (*cb)(const char *machine),
+                                bool skip_old_versioned);
 
 /**
  * qtest_qmp_device_add:
diff --git a/tests/qom-test.c b/tests/qom-test.c
index e6f712cbd3..73c52af3bb 100644
--- a/tests/qom-test.c
+++ b/tests/qom-test.c
@@ -123,7 +123,7 @@ int main(int argc, char **argv)
 {
     g_test_init(&argc, &argv, NULL);
 
-    qtest_cb_for_every_machine(add_machine_test_case);
+    qtest_cb_for_every_machine(add_machine_test_case, g_test_quick());
 
     return g_test_run();
 }
diff --git a/tests/test-hmp.c b/tests/test-hmp.c
index 5352c9c088..1a3a9c5099 100644
--- a/tests/test-hmp.c
+++ b/tests/test-hmp.c
@@ -158,7 +158,7 @@ int main(int argc, char **argv)
 
     g_test_init(&argc, &argv, NULL);
 
-    qtest_cb_for_every_machine(add_machine_test_case);
+    qtest_cb_for_every_machine(add_machine_test_case, g_test_quick());
 
     /* as none machine has no memory by default, add a test case with memory */
     qtest_add_data_func("hmp/none+2MB", g_strdup("none -m 2"), test_machine);
-- 
2.17.1
