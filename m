Received: from eggs.gnu.org ([2001:4830:134:3::10]:52317)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fiL8u-0005nn-PZ
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 10:51:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fiL8r-0001MU-S2
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 10:51:56 -0400
Received: from 5.mo6.mail-out.ovh.net ([46.105.54.31]:35023)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1fiL8r-0001Fa-JC
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 10:51:53 -0400
Received: from player797.ha.ovh.net (unknown [10.109.160.230])
	by mo6.mail-out.ovh.net (Postfix) with ESMTP id 6E454170EE5
	for <qemu-devel@nongnu.org>; Wed, 25 Jul 2018 16:51:44 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
Date: Wed, 25 Jul 2018 16:45:26 +0200
Message-ID: <153252992640.319494.8451297710133862507.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH for-3.1] tests/cpu-plug-test: check CPU hotplug
 on ppc64 with KVM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>, Thomas Huth <thuth@redhat.com>, =?utf-8?q?C=C3=A9dric?= Le Goater <clg@kaod.org>

Commit b585395b655 fixed a regression introduced by some recent changes
in the XICS code, that was causing QEMU to crash instantly during CPU
hotplug with KVM. This is typically the kind of bug we'd like our
test suite to detect before it gets merged. Unfortunately, the current
tests run with '-machine accel=qtest' and don't exercise KVM specific
paths in QEMU.

This patch hence changes add_pseries_test_case() to launch QEMU with
'-machine accel=kvm' if KVM is available.

A notable consequence is that the guest will execute SLOF, but for some
reasons SLOF sometimes hits a program exception. This causes the guest
to loop forever and the test to be stuck.  Since we don't need the guest
to be truely running, let's pass -S to QEMU to avoid that.

Also disable machine capabilities that could be unavailable in KVM, eg,
when using PR KVM.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 tests/cpu-plug-test.c |   20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/tests/cpu-plug-test.c b/tests/cpu-plug-test.c
index 5f39ba0df394..2107557809b7 100644
--- a/tests/cpu-plug-test.c
+++ b/tests/cpu-plug-test.c
@@ -21,6 +21,7 @@ struct PlugTestData {
     unsigned cores;
     unsigned threads;
     unsigned maxcpus;
+    const char *extra_args;
 };
 typedef struct PlugTestData PlugTestData;
 
@@ -106,9 +107,10 @@ static void test_plug_with_device_add_coreid(gconstpointer data)
     char *args;
     unsigned int c;
 
-    args = g_strdup_printf("-machine %s -cpu %s "
+    args = g_strdup_printf("-machine %s -cpu %s %s "
                            "-smp 1,sockets=%u,cores=%u,threads=%u,maxcpus=%u",
                            td->machine, td->cpu_model,
+                           td->extra_args ? td->extra_args : "",
                            td->sockets, td->cores, td->threads, td->maxcpus);
     qtest_start(args);
 
@@ -195,10 +197,20 @@ static void add_pseries_test_case(const char *mname)
         (g_str_has_prefix(mname, "pseries-2.") && atoi(&mname[10]) < 7)) {
         return;
     }
-    data = g_new(PlugTestData, 1);
+    data = g_new0(PlugTestData, 1);
     data->machine = g_strdup(mname);
     data->cpu_model = "power8_v2.0";
-    data->device_model = g_strdup("power8_v2.0-spapr-cpu-core");
+    if (!access("/sys/module/kvm_hv", F_OK) ||
+        !access("/sys/module/kvm_pr", F_OK)) {
+        data->cpu_model = "host";
+        data->extra_args =
+            "-machine accel=kvm "
+            "-machine cap-cfpc=broken,cap-sbbc=broken,cap-ibs=broken "
+            "-machine cap-htm=off "
+            "-machine cap-hpt-max-page-size=64k "
+            "-S";
+    }
+    data->device_model = g_strdup_printf("%s-spapr-cpu-core", data->cpu_model);
     data->sockets = 2;
     data->cores = 3;
     data->threads = 1;
@@ -221,7 +233,7 @@ static void add_s390x_test_case(const char *mname)
         return;
     }
 
-    data = g_new(PlugTestData, 1);
+    data = g_new0(PlugTestData, 1);
     data->machine = g_strdup(mname);
     data->cpu_model = "qemu";
     data->device_model = g_strdup("qemu-s390x-cpu");
