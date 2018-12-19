Received: from eggs.gnu.org ([2001:4830:134:3::10]:55972)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gZdeJ-0006iS-58
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 10:20:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gZdeH-0004ms-G0
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 10:20:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34406)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gZdeH-0004mU-8E
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 10:20:37 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 91B7C100CB2
	for <qemu-devel@nongnu.org>; Wed, 19 Dec 2018 15:20:36 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 19 Dec 2018 16:19:04 +0100
Message-Id: <20181219151917.3874-23-pbonzini@redhat.com>
In-Reply-To: <20181219151917.3874-1-pbonzini@redhat.com>
References: <20181219151917.3874-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
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
Cc: Eric Blake <eblake@redhat.com>, Thomas Huth <thuth@redhat.com>

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
 tests/test-crypto-pbkdf.c | 4 +++-
 4 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/tests/cdrom-test.c b/tests/cdrom-test.c
index 9b43dc9ab4..14bd981336 100644
--- a/tests/cdrom-test.c
+++ b/tests/cdrom-test.c
@@ -169,7 +169,7 @@ int main(int argc, char **argv)
=20
     if (exec_genisoimg(genisocheck)) {
         /* genisoimage not available - so can't run tests */
-        return 0;
+        return g_test_run();
     }
=20
     ret =3D prepare_image(arch, isoimage);
diff --git a/tests/ivshmem-test.c b/tests/ivshmem-test.c
index 089e268154..fe5eb304b1 100644
--- a/tests/ivshmem-test.c
+++ b/tests/ivshmem-test.c
@@ -492,7 +492,7 @@ int main(int argc, char **argv)
     /* shm */
     tmpshm =3D mktempshm(TMPSHMSIZE, &fd);
     if (!tmpshm) {
-        return 0;
+        goto out;
     }
     tmpshmem =3D mmap(0, TMPSHMSIZE, PROT_READ|PROT_WRITE, MAP_SHARED, f=
d, 0);
     g_assert(tmpshmem !=3D MAP_FAILED);
@@ -514,9 +514,8 @@ int main(int argc, char **argv)
         }
     }
=20
+out:
     ret =3D g_test_run();
-
     cleanup();
-
     return ret;
 }
diff --git a/tests/migration-test.c b/tests/migration-test.c
index 06ca5068d8..8352612364 100644
--- a/tests/migration-test.c
+++ b/tests/migration-test.c
@@ -789,7 +789,7 @@ int main(int argc, char **argv)
     g_test_init(&argc, &argv, NULL);
=20
     if (!ufd_version_check()) {
-        return 0;
+        return g_test_run();
     }
=20
     /*
@@ -800,7 +800,7 @@ int main(int argc, char **argv)
     if (g_str_equal(qtest_get_arch(), "ppc64") &&
         access("/sys/module/kvm_hv", F_OK)) {
         g_test_message("Skipping test: kvm_hv not available");
-        return 0;
+        return g_test_run();
     }
=20
     /*
@@ -811,11 +811,11 @@ int main(int argc, char **argv)
 #if defined(HOST_S390X)
         if (access("/dev/kvm", R_OK | W_OK)) {
             g_test_message("Skipping test: kvm not available");
-            return 0;
+            return g_test_run();
         }
 #else
         g_test_message("Skipping test: Need s390x host to work properly"=
);
-        return 0;
+        return g_test_run();
 #endif
     }
=20
diff --git a/tests/test-crypto-pbkdf.c b/tests/test-crypto-pbkdf.c
index d937aff6b2..f32e0fbea2 100644
--- a/tests/test-crypto-pbkdf.c
+++ b/tests/test-crypto-pbkdf.c
@@ -440,6 +440,8 @@ int main(int argc, char **argv)
 #else
 int main(int argc, char **argv)
 {
-    return 0;
+    g_test_init(&argc, &argv, NULL);
+    g_test_skip();
+    return g_test_run();
 }
 #endif
--=20
2.20.1
