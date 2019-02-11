Received: from eggs.gnu.org ([209.51.188.92]:52636)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gtBOX-0004YG-SS
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 08:13:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gtBOV-000099-GF
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 08:13:09 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:40919)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gtBOU-00007f-BS
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 08:13:06 -0500
Received: by mail-wm1-x341.google.com with SMTP id q21so17181214wmc.5
	for <qemu-devel@nongnu.org>; Mon, 11 Feb 2019 05:13:05 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon, 11 Feb 2019 13:05:03 +0000
Message-Id: <20190211130507.8710-15-alex.bennee@linaro.org>
In-Reply-To: <20190211130507.8710-1-alex.bennee@linaro.org>
References: <20190211130507.8710-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 14/18] tests/vm: add --build-target option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

This allows us to invoke the build with a custom target (for the VMs
that use the {target} format string specifier). Currently OpenBSD is
still hardwired due to problems running check.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
index 5caf77d6b8..bdca6cb2fc 100755
--- a/tests/vm/basevm.py
+++ b/tests/vm/basevm.py
@@ -228,6 +228,8 @@ def parse_args(vmcls):
                       help="build image")
     parser.add_option("--build-qemu",
                       help="build QEMU from source in guest")
+    parser.add_option("--build-target",
+                      help="QEMU build target", default="check")
     parser.add_option("--interactive", "-I", action="store_true",
                       help="Interactively run command")
     parser.add_option("--snapshot", "-s", action="store_true",
@@ -255,6 +257,7 @@ def main(vmcls):
             cmd = [vm.BUILD_SCRIPT.format(
                    configure_opts = " ".join(argv),
                    jobs=args.jobs,
+                   target=args.build_target,
                    verbose = "V=1" if args.verbose else "")]
         else:
             cmd = argv
diff --git a/tests/vm/freebsd b/tests/vm/freebsd
index a85c866c30..1d64c31b7c 100755
--- a/tests/vm/freebsd
+++ b/tests/vm/freebsd
@@ -25,7 +25,7 @@ class FreeBSDVM(basevm.BaseVM):
         cd $(mktemp -d /var/tmp/qemu-test.XXXXXX);
         tar -xf /dev/vtbd1;
         ./configure {configure_opts};
-        gmake --output-sync -j{jobs} check {verbose};
+        gmake --output-sync -j{jobs} {target} {verbose};
     """
 
     def build_image(self, img):
diff --git a/tests/vm/netbsd b/tests/vm/netbsd
index edea113bb5..a2c3d13af4 100755
--- a/tests/vm/netbsd
+++ b/tests/vm/netbsd
@@ -25,7 +25,7 @@ class NetBSDVM(basevm.BaseVM):
         cd $(mktemp -d /var/tmp/qemu-test.XXXXXX);
         tar -xf /dev/rld1a;
         ./configure --python=python2.7 {configure_opts};
-        gmake --output-sync -j{jobs} check {verbose};
+        gmake --output-sync -j{jobs} {target} {verbose};
     """
 
     def build_image(self, img):
diff --git a/tests/vm/ubuntu.i386 b/tests/vm/ubuntu.i386
index 252e514859..a22d137e76 100755
--- a/tests/vm/ubuntu.i386
+++ b/tests/vm/ubuntu.i386
@@ -26,7 +26,7 @@ class UbuntuX86VM(basevm.BaseVM):
         sudo chmod a+r /dev/vdb;
         tar -xf /dev/vdb;
         ./configure {configure_opts};
-        make --output-sync check -j{jobs} {verbose};
+        make --output-sync {target} -j{jobs} {verbose};
     """
 
     def _gen_cloud_init_iso(self):
-- 
2.20.1
