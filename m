Received: from eggs.gnu.org ([2001:4830:134:3::10]:48629)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dg8Pb-0006Y2-0K
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 07:47:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dg8Pa-0002XN-09
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 07:47:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57976)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dg8PZ-0002X0-QP
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 07:47:29 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C2CB483F44
	for <qemu-devel@nongnu.org>; Fri, 11 Aug 2017 11:47:28 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
Date: Fri, 11 Aug 2017 13:47:23 +0200
Message-Id: <20170811114723.12044-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PATCH] boot-serial-test: fallback to kvm accelerator
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com, Cornelia Huck <cohuck@redhat.com>

Currently, at least x86_64 and s390x support building with --disable-tcg.
Instead of forcing tcg (which causes the test to fail on such builds),
allow to use kvm as well.

Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---

Not sure who should merge this. I can add it to the s390 tree if nobody
else takes it.

---
 tests/boot-serial-test.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/boot-serial-test.c b/tests/boot-serial-test.c
index 11f48b049c..38664a0594 100644
--- a/tests/boot-serial-test.c
+++ b/tests/boot-serial-test.c
@@ -78,7 +78,8 @@ static void test_machine(const void *data)
     fd = mkstemp(tmpname);
     g_assert(fd != -1);
 
-    args = g_strdup_printf("-M %s,accel=tcg -chardev file,id=serial0,path=%s"
+    args = g_strdup_printf("-M %s,accel=tcg:kvm "
+                           "-chardev file,id=serial0,path=%s"
                            " -no-shutdown -serial chardev:serial0 %s",
                            test->machine, tmpname, test->extra);
 
-- 
2.13.4
