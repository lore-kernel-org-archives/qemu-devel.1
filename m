Received: from eggs.gnu.org ([2001:4830:134:3::10]:56855)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gSQNg-0005fT-D3
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 12:45:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gSQNc-0004S5-Bf
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 12:45:40 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:34658)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gSQNc-0004R8-22
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 12:45:36 -0500
Received: by mail-wr1-x443.google.com with SMTP id j2so2797321wrw.1
	for <qemu-devel@nongnu.org>; Thu, 29 Nov 2018 09:45:35 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 29 Nov 2018 18:45:30 +0100
Message-Id: <1543513531-1151-2-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1543513531-1151-1-git-send-email-pbonzini@redhat.com>
References: <1543513531-1151-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 1/2] test: execute g_test_run when tests are
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
Cc: peter.maydell@linaro.org, eblake@redhat.com, berrange@redhat.com

Sometimes a test's main() function recognizes that the environment
does not support the test, and therefore exits.  In this case, we
still should run g_test_run() so that a TAP harness will print the
test plan ("1..0") and the test will be marked as skipped.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/cdrom-test.c     | 2 +-
 tests/migration-test.c | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

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
 
-- 
1.8.3.1
