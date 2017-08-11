Received: from eggs.gnu.org ([2001:4830:134:3::10]:57345)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dgAaC-0001Yg-0D
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 10:06:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dgAaA-0003KU-UN
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 10:06:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36306)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dgAaA-0003K5-OK
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 10:06:34 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Fri, 11 Aug 2017 16:06:27 +0200
Message-Id: <20170811140627.22421-2-cohuck@redhat.com>
In-Reply-To: <20170811140627.22421-1-cohuck@redhat.com>
References: <20170811140627.22421-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL for-2.10 1/1] boot-serial-test: fallback to kvm
 accelerator
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, thuth@redhat.com, pbonzini@redhat.com, berrange@redhat.com, Cornelia Huck <cohuck@redhat.com>

Currently, at least x86_64 and s390x support building with --disable-tcg.
Instead of forcing tcg (which causes the test to fail on such builds),
allow to use kvm as well.

Reviewed-by: Daniel P. Berrange <berrange@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 tests/boot-serial-test.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tests/boot-serial-test.c b/tests/boot-serial-test.c
index 11f48b049c..a8ca877168 100644
--- a/tests/boot-serial-test.c
+++ b/tests/boot-serial-test.c
@@ -78,8 +78,9 @@ static void test_machine(const void *data)
     fd = mkstemp(tmpname);
     g_assert(fd != -1);
 
-    args = g_strdup_printf("-M %s,accel=tcg -chardev file,id=serial0,path=%s"
-                           " -no-shutdown -serial chardev:serial0 %s",
+    args = g_strdup_printf("-M %s,accel=kvm:tcg "
+                           "-chardev file,id=serial0,path=%s "
+                           "-no-shutdown -serial chardev:serial0 %s",
                            test->machine, tmpname, test->extra);
 
     qtest_start(args);
-- 
2.13.4
