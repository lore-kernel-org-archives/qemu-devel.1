Received: from eggs.gnu.org ([2001:4830:134:3::10]:36147)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fdFxE-0001OY-5I
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 10:18:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fdFxB-0003kG-0o
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 10:18:52 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41798 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1fdFxA-0003k5-Rx
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 10:18:48 -0400
From: Fam Zheng <famz@redhat.com>
Date: Wed, 11 Jul 2018 22:18:27 +0800
Message-Id: <20180711141829.17406-3-famz@redhat.com>
In-Reply-To: <20180711141829.17406-1-famz@redhat.com>
References: <20180711141829.17406-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v2 2/4] tests/vm: Pass verbose flag into VM
 make commands
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, Fam Zheng <famz@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

Our Makefile has:

vm-build-%: tests/vm/%.img
	$(call quiet-command, \
		$(SRC_PATH)/tests/vm/$* \
		$(if $(V)$(DEBUG), --debug) \
		$(if $(DEBUG), --interactive) \

the intention of which is to let the make command in VM have V=1 if
V=1 is set. We pass this to the BUILD_SCRIPT format.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 tests/vm/basevm.py   | 3 ++-
 tests/vm/freebsd     | 4 ++--
 tests/vm/netbsd      | 4 ++--
 tests/vm/openbsd     | 4 ++--
 tests/vm/ubuntu.i386 | 4 ++--
 5 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
index e5d6a328d5..25361c6b7d 100755
--- a/tests/vm/basevm.py
+++ b/tests/vm/basevm.py
@@ -240,7 +240,8 @@ def main(vmcls):
             vm.add_source_dir(args.build_qemu)
             cmd = [vm.BUILD_SCRIPT.format(
                    configure_opts = " ".join(argv),
-                   jobs=args.jobs)]
+                   jobs=args.jobs,
+                   verbose="1" if args.debug else "")]
         else:
             cmd = argv
         img = args.image
diff --git a/tests/vm/freebsd b/tests/vm/freebsd
index 039dad8f69..b20612a6c9 100755
--- a/tests/vm/freebsd
+++ b/tests/vm/freebsd
@@ -23,8 +23,8 @@ class FreeBSDVM(basevm.BaseVM):
         cd $(mktemp -d /var/tmp/qemu-test.XXXXXX);
         tar -xf /dev/vtbd1;
         ./configure {configure_opts};
-        gmake -j{jobs};
-        gmake check;
+        gmake -j{jobs} V={verbose};
+        gmake check V={verbose};
     """
 
     def build_image(self, img):
diff --git a/tests/vm/netbsd b/tests/vm/netbsd
index 3972d8b45c..3f9d34a208 100755
--- a/tests/vm/netbsd
+++ b/tests/vm/netbsd
@@ -23,8 +23,8 @@ class NetBSDVM(basevm.BaseVM):
         cd $(mktemp -d /var/tmp/qemu-test.XXXXXX);
         tar -xf /dev/rld1a;
         ./configure --python=python2.7 {configure_opts};
-        gmake -j{jobs};
-        gmake check;
+        gmake -j{jobs} V={verbose};
+        gmake check V={verbose};
     """
 
     def build_image(self, img):
diff --git a/tests/vm/openbsd b/tests/vm/openbsd
index 6ae16d97fd..3285c1abde 100755
--- a/tests/vm/openbsd
+++ b/tests/vm/openbsd
@@ -23,9 +23,9 @@ class OpenBSDVM(basevm.BaseVM):
         cd $(mktemp -d /var/tmp/qemu-test.XXXXXX);
         tar -xf /dev/rsd1c;
         ./configure --cc=x86_64-unknown-openbsd6.1-gcc-4.9.4 --python=python2.7 {configure_opts};
-        gmake -j{jobs};
+        gmake -j{jobs} V={verbose};
         # XXX: "gmake check" seems to always hang or fail
-        #gmake check;
+        #gmake check V={verbose};
     """
 
     def build_image(self, img):
diff --git a/tests/vm/ubuntu.i386 b/tests/vm/ubuntu.i386
index fc319e0e6e..b4eaa0dedc 100755
--- a/tests/vm/ubuntu.i386
+++ b/tests/vm/ubuntu.i386
@@ -25,8 +25,8 @@ class UbuntuX86VM(basevm.BaseVM):
         sudo chmod a+r /dev/vdb;
         tar -xf /dev/vdb;
         ./configure {configure_opts};
-        make -j{jobs};
-        make check;
+        make -j{jobs} V={verbose};
+        make check V={verbose};
     """
 
     def _gen_cloud_init_iso(self):
-- 
2.17.1
