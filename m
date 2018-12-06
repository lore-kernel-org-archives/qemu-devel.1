Received: from eggs.gnu.org ([2001:4830:134:3::10]:36424)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gV1XY-0005xJ-GL
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 16:50:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gV1XW-00055i-B6
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 16:50:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48452)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gV1XU-00051G-LC
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 16:50:32 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CDDDB3078AD4
	for <qemu-devel@nongnu.org>; Thu,  6 Dec 2018 21:50:31 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu,  6 Dec 2018 22:50:25 +0100
Message-Id: <20181206215026.7716-2-pbonzini@redhat.com>
In-Reply-To: <20181206215026.7716-1-pbonzini@redhat.com>
References: <20181206215026.7716-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
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
Cc: berrange@redhat.com, eblake@redhat.com, thuth@redhat.com

Sometimes a test's main() function recognizes that the environment
does not support the test, and therefore exits.  In this case, we
still should run g_test_run() so that a TAP harness will print the
test plan ("1..0") and the test will be marked as skipped.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/cdrom-test.c     | 2 +-
 tests/migration-test.c | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

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
--=20
2.19.2
