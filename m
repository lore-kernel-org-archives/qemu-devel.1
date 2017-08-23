Received: from eggs.gnu.org ([2001:4830:134:3::10]:51066)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dkJb6-0007G9-0L
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 20:32:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dkJb3-0004e7-Cy
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 20:32:40 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed, 23 Aug 2017 10:32:11 +1000
Message-Id: <20170823003217.6769-2-david@gibson.dropbear.id.au>
In-Reply-To: <20170823003217.6769-1-david@gibson.dropbear.id.au>
References: <20170823003217.6769-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 1/7] boot-serial-test: prefer tcg accelerator
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, thuth@redhat.com, mdroth@linux.vnet.ibm.com, cohuck@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, lvivier@redhat.com, David Gibson <david@gibson.dropbear.id.au>

From: Cornelia Huck <cohuck@redhat.com>

Prefer to use the tcg accelarator if it is available: This is our only
real smoke test for tcg, and fast enough to use it for that.

Fixes: 480bc11e6 ("boot-serial-test: fallback to kvm accelerator")
Reported-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 tests/boot-serial-test.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tests/boot-serial-test.c b/tests/boot-serial-test.c
index a8ca877168..b95c5e74ea 100644
--- a/tests/boot-serial-test.c
+++ b/tests/boot-serial-test.c
@@ -78,7 +78,11 @@ static void test_machine(const void *data)
     fd = mkstemp(tmpname);
     g_assert(fd != -1);
 
-    args = g_strdup_printf("-M %s,accel=kvm:tcg "
+    /*
+     * Make sure that this test uses tcg if available: It is used as a
+     * fast-enough smoketest for that.
+     */
+    args = g_strdup_printf("-M %s,accel=tcg:kvm "
                            "-chardev file,id=serial0,path=%s "
                            "-no-shutdown -serial chardev:serial0 %s",
                            test->machine, tmpname, test->extra);
-- 
2.13.5
