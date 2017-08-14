Received: from eggs.gnu.org ([2001:4830:134:3::10]:49050)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dhGRh-0002UN-Aa
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 10:34:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dhGRe-0001LV-1Z
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 10:34:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49490)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dhGRd-0001L3-QZ
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 10:34:17 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BC6E15B30D
	for <qemu-devel@nongnu.org>; Mon, 14 Aug 2017 14:34:16 +0000 (UTC)
Date: Mon, 14 Aug 2017 17:34:15 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1502721197-32717-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] [PATCH] tests: switch tests to accel=kvm:tcg
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Cornelia Huck <cohuck@redhat.com>

Speed up tests on host systems with kvm support.
In particular, this fixes tests with --disable-tcg.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>
Cc: Laurent Vivier <lvivier@redhat.com>
Suggested-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---

Tested on x86 only.

 tests/boot-serial-test.c | 2 +-
 tests/pnv-xscom-test.c   | 4 ++--
 tests/prom-env-test.c    | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tests/boot-serial-test.c b/tests/boot-serial-test.c
index 11f48b0..c3b2e4e 100644
--- a/tests/boot-serial-test.c
+++ b/tests/boot-serial-test.c
@@ -78,7 +78,7 @@ static void test_machine(const void *data)
     fd = mkstemp(tmpname);
     g_assert(fd != -1);
 
-    args = g_strdup_printf("-M %s,accel=tcg -chardev file,id=serial0,path=%s"
+    args = g_strdup_printf("-M %s,accel=kvm:tcg -chardev file,id=serial0,path=%s"
                            " -no-shutdown -serial chardev:serial0 %s",
                            test->machine, tmpname, test->extra);
 
diff --git a/tests/pnv-xscom-test.c b/tests/pnv-xscom-test.c
index 5adc3fd..7be396f 100644
--- a/tests/pnv-xscom-test.c
+++ b/tests/pnv-xscom-test.c
@@ -84,7 +84,7 @@ static void test_cfam_id(const void *data)
     char *args;
     const PnvChip *chip = data;
 
-    args = g_strdup_printf("-M powernv,accel=tcg -cpu %s", chip->cpu_model);
+    args = g_strdup_printf("-M powernv,accel=kvm:tcg -cpu %s", chip->cpu_model);
 
     qtest_start(args);
     test_xscom_cfam_id(chip);
@@ -112,7 +112,7 @@ static void test_core(const void *data)
     char *args;
     const PnvChip *chip = data;
 
-    args = g_strdup_printf("-M powernv,accel=tcg -cpu %s", chip->cpu_model);
+    args = g_strdup_printf("-M powernv,accel=kvm:tcg -cpu %s", chip->cpu_model);
 
     qtest_start(args);
     test_xscom_core(chip);
diff --git a/tests/prom-env-test.c b/tests/prom-env-test.c
index eac207b..0a10f06 100644
--- a/tests/prom-env-test.c
+++ b/tests/prom-env-test.c
@@ -50,7 +50,7 @@ static void test_machine(const void *machine)
     /* The pseries firmware boots much faster without the default devices */
     extra_args = strcmp(machine, "pseries") == 0 ? "-nodefaults" : "";
 
-    args = g_strdup_printf("-M %s,accel=tcg %s -prom-env 'use-nvramrc?=true' "
+    args = g_strdup_printf("-M %s,accel=kvm:tcg %s -prom-env 'use-nvramrc?=true' "
                            "-prom-env 'nvramrc=%x %x l!' ",
                            (const char *)machine, extra_args, MAGIC, ADDRESS);
 
-- 
MST
