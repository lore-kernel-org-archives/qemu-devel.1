Received: from eggs.gnu.org ([2001:4830:134:3::10]:39331)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dhetH-0000Lf-Uh
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 12:40:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dhetG-0003Mm-Ry
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 12:40:27 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:35256)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dhetG-0003M1-Mi
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 12:40:26 -0400
Received: by mail-qt0-x241.google.com with SMTP id t37so1208463qtg.2
	for <qemu-devel@nongnu.org>; Tue, 15 Aug 2017 09:40:26 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Tue, 15 Aug 2017 13:39:59 -0300
Message-Id: <20170815163959.6632-3-f4bug@amsat.org>
In-Reply-To: <20170815163959.6632-1-f4bug@amsat.org>
References: <20170815163959.6632-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 2/2] tests: use qtest_accel()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S . Tsirkin" <mst@redhat.com>, Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 tests/bios-tables-test.c |  2 +-
 tests/boot-serial-test.c |  5 +++--
 tests/postcopy-test.c    | 10 ++++++----
 tests/pxe-test.c         |  5 +++--
 tests/vmgenid-test.c     |  4 ++--
 5 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
index 564da45f65..621bd8d95d 100644
--- a/tests/bios-tables-test.c
+++ b/tests/bios-tables-test.c
@@ -627,7 +627,7 @@ static void test_acpi_one(const char *params, test_data *data)
                            "-net none -display none %s "
                            "-drive id=hd0,if=none,file=%s,format=raw "
                            "-device ide-hd,drive=hd0 ",
-                           data->machine, "kvm:tcg",
+                           data->machine, qtest_accel("kvm:tcg"),
                            params ? params : "", disk);
 
     qtest_start(args);
diff --git a/tests/boot-serial-test.c b/tests/boot-serial-test.c
index a8ca877168..f986ea51b5 100644
--- a/tests/boot-serial-test.c
+++ b/tests/boot-serial-test.c
@@ -78,10 +78,11 @@ static void test_machine(const void *data)
     fd = mkstemp(tmpname);
     g_assert(fd != -1);
 
-    args = g_strdup_printf("-M %s,accel=kvm:tcg "
+    args = g_strdup_printf("-M %s,accel=%s "
                            "-chardev file,id=serial0,path=%s "
                            "-no-shutdown -serial chardev:serial0 %s",
-                           test->machine, tmpname, test->extra);
+                           test->machine, qtest_accel("kvm:tcg"),
+                           tmpname, test->extra);
 
     qtest_start(args);
     unlink(tmpname);
diff --git a/tests/postcopy-test.c b/tests/postcopy-test.c
index 8142f2ab90..781b955a59 100644
--- a/tests/postcopy-test.c
+++ b/tests/postcopy-test.c
@@ -367,18 +367,20 @@ static void test_migrate(void)
     got_stop = false;
 
     if (strcmp(arch, "i386") == 0 || strcmp(arch, "x86_64") == 0) {
+        const char *accel = qtest_accel("kvm:tcg");
+
         init_bootfile_x86(bootpath);
-        cmd_src = g_strdup_printf("-machine accel=kvm:tcg -m 150M"
+        cmd_src = g_strdup_printf("-machine accel=%s -m 150M"
                                   " -name pcsource,debug-threads=on"
                                   " -serial file:%s/src_serial"
                                   " -drive file=%s,format=raw",
-                                  tmpfs, bootpath);
-        cmd_dst = g_strdup_printf("-machine accel=kvm:tcg -m 150M"
+                                  accel, tmpfs, bootpath);
+        cmd_dst = g_strdup_printf("-machine accel=%s -m 150M"
                                   " -name pcdest,debug-threads=on"
                                   " -serial file:%s/dest_serial"
                                   " -drive file=%s,format=raw"
                                   " -incoming %s",
-                                  tmpfs, bootpath, uri);
+                                  accel, tmpfs, bootpath, uri);
     } else if (strcmp(arch, "ppc64") == 0) {
         const char *accel;
 
diff --git a/tests/pxe-test.c b/tests/pxe-test.c
index cf6e225330..531e0d5506 100644
--- a/tests/pxe-test.c
+++ b/tests/pxe-test.c
@@ -25,9 +25,10 @@ static void test_pxe_one(const char *params, bool ipv6)
 {
     char *args;
 
-    args = g_strdup_printf("-machine accel=kvm:tcg -nodefaults -boot order=n "
+    args = g_strdup_printf("-machine accel=%s -nodefaults -boot order=n "
                            "-netdev user,id=" NETNAME ",tftp=./,bootfile=%s,"
-                           "ipv4=%s,ipv6=%s %s", disk, ipv6 ? "off" : "on",
+                           "ipv4=%s,ipv6=%s %s", qtest_accel("kvm:tcg"),
+                           disk, ipv6 ? "off" : "on",
                            ipv6 ? "on" : "off", params);
 
     qtest_start(args);
diff --git a/tests/vmgenid-test.c b/tests/vmgenid-test.c
index 3d5c1c3615..82b52aa44c 100644
--- a/tests/vmgenid-test.c
+++ b/tests/vmgenid-test.c
@@ -132,11 +132,11 @@ static char disk[] = "tests/vmgenid-test-disk-XXXXXX";
 
 static char *guid_cmd_strdup(const char *guid)
 {
-    return g_strdup_printf("-machine accel=kvm:tcg "
+    return g_strdup_printf("-machine accel=%s "
                            "-device vmgenid,id=testvgid,guid=%s "
                            "-drive id=hd0,if=none,file=%s,format=raw "
                            "-device ide-hd,drive=hd0 ",
-                           guid, disk);
+                           qtest_accel("kvm:tcg"), guid, disk);
 }
 
 
-- 
2.14.1
