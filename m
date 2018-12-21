Received: from eggs.gnu.org ([2001:4830:134:3::10]:41118)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gaK2f-0002k8-27
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 07:36:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gaK2Z-0003VK-5i
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 07:36:35 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:42333)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gaK2X-0003R9-7U
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 07:36:30 -0500
Received: by mail-wr1-x42b.google.com with SMTP id q18so5096182wrx.9
	for <qemu-devel@nongnu.org>; Fri, 21 Dec 2018 04:36:27 -0800 (PST)
Received: from 640k.lan ([93.56.166.5]) by smtp.gmail.com with ESMTPSA id
	k7sm11217839wrl.51.2018.12.21.04.36.25 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 21 Dec 2018 04:36:25 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 21 Dec 2018 13:36:22 +0100
Message-Id: <1545395783-39040-2-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1545395783-39040-1-git-send-email-pbonzini@redhat.com>
References: <1545395783-39040-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 22/35] test: execute g_test_run when tests are
 skipped
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Sometimes a test's main() function recognizes that the environment
does not support the test, and therefore exits.  In this case, we
still should run g_test_run() so that a TAP harness will print the
test plan ("1..0") and the test will be marked as skipped.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Message-Id: <1543513531-1151-2-git-send-email-pbonzini@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/cdrom-test.c        | 2 +-
 tests/ivshmem-test.c      | 5 ++---
 tests/migration-test.c    | 8 ++++----
 tests/test-crypto-pbkdf.c | 3 ++-
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/tests/cdrom-test.c b/tests/cdrom-test.c
index 9b43dc9..14bd981 100644
--- a/tests/cdrom-test.c
+++ b/tests/cdrom-test.c
@@ -169,7 +169,7 @@ int main(int argc, char **argv)
 
     if (exec_genisoimg(genisocheck)) {
         /* genisoimage not available - so can't run tests */
-        return 0;
+        return g_test_run();
     }
 
     ret = prepare_image(arch, isoimage);
diff --git a/tests/ivshmem-test.c b/tests/ivshmem-test.c
index 089e268..fe5eb30 100644
--- a/tests/ivshmem-test.c
+++ b/tests/ivshmem-test.c
@@ -492,7 +492,7 @@ int main(int argc, char **argv)
     /* shm */
     tmpshm = mktempshm(TMPSHMSIZE, &fd);
     if (!tmpshm) {
-        return 0;
+        goto out;
     }
     tmpshmem = mmap(0, TMPSHMSIZE, PROT_READ|PROT_WRITE, MAP_SHARED, fd, 0);
     g_assert(tmpshmem != MAP_FAILED);
@@ -514,9 +514,8 @@ int main(int argc, char **argv)
         }
     }
 
+out:
     ret = g_test_run();
-
     cleanup();
-
     return ret;
 }
diff --git a/tests/migration-test.c b/tests/migration-test.c
index 06ca506..8352612 100644
--- a/tests/migration-test.c
+++ b/tests/migration-test.c
@@ -789,7 +789,7 @@ int main(int argc, char **argv)
     g_test_init(&argc, &argv, NULL);
 
     if (!ufd_version_check()) {
-        return 0;
+        return g_test_run();
     }
 
     /*
@@ -800,7 +800,7 @@ int main(int argc, char **argv)
     if (g_str_equal(qtest_get_arch(), "ppc64") &&
         access("/sys/module/kvm_hv", F_OK)) {
         g_test_message("Skipping test: kvm_hv not available");
-        return 0;
+        return g_test_run();
     }
 
     /*
@@ -811,11 +811,11 @@ int main(int argc, char **argv)
 #if defined(HOST_S390X)
         if (access("/dev/kvm", R_OK | W_OK)) {
             g_test_message("Skipping test: kvm not available");
-            return 0;
+            return g_test_run();
         }
 #else
         g_test_message("Skipping test: Need s390x host to work properly");
-        return 0;
+        return g_test_run();
 #endif
     }
 
diff --git a/tests/test-crypto-pbkdf.c b/tests/test-crypto-pbkdf.c
index d937aff..85ed1f9 100644
--- a/tests/test-crypto-pbkdf.c
+++ b/tests/test-crypto-pbkdf.c
@@ -440,6 +440,7 @@ int main(int argc, char **argv)
 #else
 int main(int argc, char **argv)
 {
-    return 0;
+    g_test_init(&argc, &argv, NULL);
+    return g_test_run();
 }
 #endif
-- 
1.8.3.1
