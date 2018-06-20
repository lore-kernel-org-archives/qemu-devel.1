Received: from eggs.gnu.org ([2001:4830:134:3::10]:45978)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fVcdA-0002c8-AJ
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 08:54:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fVcd7-0008Fk-6e
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 08:54:36 -0400
Received: from 2.mo179.mail-out.ovh.net ([178.33.250.45]:37155)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1fVcd6-0008FJ-TG
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 08:54:33 -0400
Received: from player786.ha.ovh.net (unknown [10.109.120.26])
	by mo179.mail-out.ovh.net (Postfix) with ESMTP id 1E805D104B
	for <qemu-devel@nongnu.org>; Wed, 20 Jun 2018 14:54:30 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
Date: Wed, 20 Jun 2018 14:54:15 +0200
Message-ID: <152949925592.606785.4717120428688653960.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v2 for-2.11.2] spapr: make pseries-2.11 the
 default machine type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-stable@nongnu.org
Cc: qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>, David Gibson <david@gibson.dropbear.id.au>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Thomas Huth <thuth@redhat.com>

The spapr capability framework was introduced in QEMU 2.12. It allows
to have an explicit control on how host features are exposed to the
guest. This is especially needed to handle migration between hetero-
geneous hosts (eg, POWER8 to POWER9). It is also used to expose fixes/
workarounds against speculative execution vulnerabilities to guests.
The framework was hence backported to QEMU 2.11.1, especially these
commits:

0fac4aa93074 spapr: Add pseries-2.12 machine type
9070f408f491 spapr: Treat Hardware Transactional Memory (HTM) as an
 optional capability

0fac4aa93074 has the confusing effect of making pseries-2.12 the default
machine type for QEMU 2.11.1, instead of the expected pseries-2.11. This
patch changes the default machine back to pseries-2.11.

Unfortunately, 9070f408f491 enforces the HTM capability for pseries-2.11
to be enabled by default, ie, when not passing cap-htm on the command
line. This breaks several 'make check' testcases that run qemu-system-ppc64
with TCG.

The only sane way to fix this is to adapt the impacted testcases so that
they all pass cap-htm=off in this case. This patch does that as well.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
v2: - have the testcases to pass cap-htm=off instead of violating the
      capabilities logic.

Upstream doesn't need anything like that since newer pseries machine types
start with HTM disabled by default. This is really a oneshot fix for 2.11.2,
and I've tried to make it as small as possible.

This is a full replacement of the previous version. It is based on Mike's
staging tree for 2.11:

https://github.com/mdroth/qemu/commits/stable-2.11-staging 72cc467aabd1a2
---
 hw/ppc/spapr.c           |    4 ++--
 tests/boot-serial-test.c |    8 ++++++--
 tests/migration-test.c   |    4 ++--
 tests/prom-env-test.c    |    6 ++++--
 tests/pxe-test.c         |   10 +++++++---
 5 files changed, 21 insertions(+), 11 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 1a2dd1f597d9..6499a867520f 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3820,7 +3820,7 @@ static void spapr_machine_2_12_class_options(MachineClass *mc)
     /* Defaults for the latest behaviour inherited from the base class */
 }
 
-DEFINE_SPAPR_MACHINE(2_12, "2.12", true);
+DEFINE_SPAPR_MACHINE(2_12, "2.12", false);
 
 /*
  * pseries-2.11
@@ -3842,7 +3842,7 @@ static void spapr_machine_2_11_class_options(MachineClass *mc)
     SET_MACHINE_COMPAT(mc, SPAPR_COMPAT_2_11);
 }
 
-DEFINE_SPAPR_MACHINE(2_11, "2.11", false);
+DEFINE_SPAPR_MACHINE(2_11, "2.11", true);
 
 /*
  * pseries-2.10
diff --git a/tests/boot-serial-test.c b/tests/boot-serial-test.c
index c935d69824bd..98c5462377f8 100644
--- a/tests/boot-serial-test.c
+++ b/tests/boot-serial-test.c
@@ -73,18 +73,22 @@ static void test_machine(const void *data)
     const testdef_t *test = data;
     char tmpname[] = "/tmp/qtest-boot-serial-XXXXXX";
     int fd;
+    const char *machine_props;
 
     fd = mkstemp(tmpname);
     g_assert(fd != -1);
 
+    machine_props = strcmp(test->machine, "pseries") == 0 ? ",cap-htm=off" : "";
+
     /*
      * Make sure that this test uses tcg if available: It is used as a
      * fast-enough smoketest for that.
      */
-    global_qtest = qtest_startf("-M %s,accel=tcg:kvm "
+    global_qtest = qtest_startf("-M %s%s,accel=tcg:kvm "
                                 "-chardev file,id=serial0,path=%s "
                                 "-no-shutdown -serial chardev:serial0 %s",
-                                test->machine, tmpname, test->extra);
+                                test->machine, machine_props, tmpname,
+                                test->extra);
     unlink(tmpname);
 
     check_guest_output(test, fd);
diff --git a/tests/migration-test.c b/tests/migration-test.c
index be598d3257ba..906d29b38241 100644
--- a/tests/migration-test.c
+++ b/tests/migration-test.c
@@ -460,12 +460,12 @@ static void test_migrate_start(QTestState **from, QTestState **to,
         /* On ppc64, the test only works with kvm-hv, but not with kvm-pr */
         accel = access("/sys/module/kvm_hv", F_OK) ? "tcg" : "kvm:tcg";
         init_bootfile_ppc(bootpath);
-        cmd_src = g_strdup_printf("-machine accel=%s -m 256M"
+        cmd_src = g_strdup_printf("-machine accel=%s,cap-htm=off -m 256M"
                                   " -name pcsource,debug-threads=on"
                                   " -serial file:%s/src_serial"
                                   " -drive file=%s,if=pflash,format=raw",
                                   accel, tmpfs, bootpath);
-        cmd_dst = g_strdup_printf("-machine accel=%s -m 256M"
+        cmd_dst = g_strdup_printf("-machine accel=%s,cap-htm=off -m 256M"
                                   " -name pcdest,debug-threads=on"
                                   " -serial file:%s/dest_serial"
                                   " -incoming %s",
diff --git a/tests/prom-env-test.c b/tests/prom-env-test.c
index 8c867e631ab6..f6946090d183 100644
--- a/tests/prom-env-test.c
+++ b/tests/prom-env-test.c
@@ -45,14 +45,16 @@ static void check_guest_memory(void)
 static void test_machine(const void *machine)
 {
     const char *extra_args;
+    const char *extra_props;
 
     /* The pseries firmware boots much faster without the default devices */
     extra_args = strcmp(machine, "pseries") == 0 ? "-nodefaults" : "";
+    extra_props = strcmp(machine, "pseries") == 0 ? ",cap-htm=off" : "";
 
-    global_qtest = qtest_startf("-M %s,accel=tcg %s "
+    global_qtest = qtest_startf("-M %s%s,accel=tcg %s "
                                 "-prom-env 'use-nvramrc?=true' "
                                 "-prom-env 'nvramrc=%x %x l!' ",
-                                (const char *)machine, extra_args,
+                                (const char *)machine, extra_props, extra_args,
                                 MAGIC, ADDRESS);
     check_guest_memory();
     qtest_quit(global_qtest);
diff --git a/tests/pxe-test.c b/tests/pxe-test.c
index 937f29e63193..f3a65bd80cb1 100644
--- a/tests/pxe-test.c
+++ b/tests/pxe-test.c
@@ -25,11 +25,15 @@ static char disk[] = "tests/pxe-test-disk-XXXXXX";
 static void test_pxe_one(const char *params, bool ipv6)
 {
     char *args;
+    const char *machine_props;
 
-    args = g_strdup_printf("-machine accel=kvm:tcg -nodefaults -boot order=n "
+    machine_props =
+        strcmp(qtest_get_arch(), "ppc64") == 0 ? ",cap-htm=off" : "";
+
+    args = g_strdup_printf("-machine accel=kvm:tcg%s -nodefaults -boot order=n "
                            "-netdev user,id=" NETNAME ",tftp=./,bootfile=%s,"
-                           "ipv4=%s,ipv6=%s %s", disk, ipv6 ? "off" : "on",
-                           ipv6 ? "on" : "off", params);
+                           "ipv4=%s,ipv6=%s %s", machine_props, disk,
+                           ipv6 ? "off" : "on", ipv6 ? "on" : "off", params);
 
     qtest_start(args);
     boot_sector_test();
