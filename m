Received: from eggs.gnu.org ([2001:4830:134:3::10]:56998)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fpmFS-0007CN-Er
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 23:13:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fpmFR-0001Iy-CE
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 23:13:26 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35482 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1fpmFQ-0001H3-Rg
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 23:13:25 -0400
From: Fam Zheng <famz@redhat.com>
Date: Wed, 15 Aug 2018 11:12:44 +0800
Message-Id: <20180815031248.14908-14-famz@redhat.com>
In-Reply-To: <20180815031248.14908-1-famz@redhat.com>
References: <20180815031248.14908-1-famz@redhat.com>
Subject: [Qemu-devel] [PULL 13/17] tests/vm: Propagate V=1 down into the
 make inside the VM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>

From: Peter Maydell <peter.maydell@linaro.org>

Invoking 'make vm-build-freebsd' and friends with V=1 should
propagate that verbosity setting down into the build run
inside the VM. Make sure we do that. This brings it into
line with how the container tests handle V=1.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20180803085230.30574-4-peter.maydell@linaro.org>
Signed-off-by: Fam Zheng <famz@redhat.com>
---
 docs/devel/testing.rst    | 1 +
 tests/vm/Makefile.include | 1 +
 tests/vm/basevm.py        | 5 ++++-
 tests/vm/freebsd          | 4 ++--
 tests/vm/netbsd           | 4 ++--
 tests/vm/openbsd          | 4 ++--
 tests/vm/ubuntu.i386      | 2 +-
 7 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/docs/devel/testing.rst b/docs/devel/testing.rst
index 8e1fa3a66e..727c4019b5 100644
--- a/docs/devel/testing.rst
+++ b/docs/devel/testing.rst
@@ -434,6 +434,7 @@ Debugging
 
 Add ``DEBUG=1`` and/or ``V=1`` to the make command to allow interactive
 debugging and verbose output. If this is not enough, see the next section.
+``V=1`` will be propagated down into the make jobs in the guest.
 
 Manual invocation
 -----------------
diff --git a/tests/vm/Makefile.include b/tests/vm/Makefile.include
index a5abb569c5..76f416286e 100644
--- a/tests/vm/Makefile.include
+++ b/tests/vm/Makefile.include
@@ -40,6 +40,7 @@ vm-build-%: tests/vm/%.img
 		$(if $(V)$(DEBUG), --debug) \
 		$(if $(DEBUG), --interactive) \
 		$(if $(J),--jobs $(J)) \
+		$(if $(V),--verbose) \
 		--image "$<" \
 		--build-qemu $(SRC_PATH), \
 		"  VM-BUILD $*")
diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
index 1f1579dc9a..d73cba9edb 100755
--- a/tests/vm/basevm.py
+++ b/tests/vm/basevm.py
@@ -211,6 +211,8 @@ def parse_args(vm_name):
                       help="force build image even if image exists")
     parser.add_option("--jobs", type=int, default=multiprocessing.cpu_count() / 2,
                       help="number of virtual CPUs")
+    parser.add_option("--verbose", "-V", action="store_true",
+                      help="Pass V=1 to builds within the guest")
     parser.add_option("--build-image", "-b", action="store_true",
                       help="build image")
     parser.add_option("--build-qemu",
@@ -241,7 +243,8 @@ def main(vmcls):
             vm.add_source_dir(args.build_qemu)
             cmd = [vm.BUILD_SCRIPT.format(
                    configure_opts = " ".join(argv),
-                   jobs=args.jobs)]
+                   jobs=args.jobs,
+                   verbose = "V=1" if args.verbose else "")]
         else:
             cmd = argv
         img = args.image
diff --git a/tests/vm/freebsd b/tests/vm/freebsd
index 2187a17327..795f739c7b 100755
--- a/tests/vm/freebsd
+++ b/tests/vm/freebsd
@@ -23,8 +23,8 @@ class FreeBSDVM(basevm.BaseVM):
         cd $(mktemp -d /var/tmp/qemu-test.XXXXXX);
         tar -xf /dev/vtbd1;
         ./configure {configure_opts};
-        gmake -j{jobs};
-        gmake -j{jobs} check;
+        gmake -j{jobs} {verbose};
+        gmake -j{jobs} check {verbose};
     """
 
     def build_image(self, img):
diff --git a/tests/vm/netbsd b/tests/vm/netbsd
index 2cc4798f0c..c211672bcb 100755
--- a/tests/vm/netbsd
+++ b/tests/vm/netbsd
@@ -23,8 +23,8 @@ class NetBSDVM(basevm.BaseVM):
         cd $(mktemp -d /var/tmp/qemu-test.XXXXXX);
         tar -xf /dev/rld1a;
         ./configure --python=python2.7 {configure_opts};
-        gmake -j{jobs};
-        gmake -j{jobs} check;
+        gmake -j{jobs} {verbose};
+        gmake -j{jobs} check {verbose};
     """
 
     def build_image(self, img):
diff --git a/tests/vm/openbsd b/tests/vm/openbsd
index df6b79fe7d..1e0c2500ad 100755
--- a/tests/vm/openbsd
+++ b/tests/vm/openbsd
@@ -23,9 +23,9 @@ class OpenBSDVM(basevm.BaseVM):
         cd $(mktemp -d /var/tmp/qemu-test.XXXXXX);
         tar -xf /dev/rsd1c;
         ./configure --cc=x86_64-unknown-openbsd6.1-gcc-4.9.4 --python=python2.7 {configure_opts};
-        gmake -j{jobs};
+        gmake -j{jobs} {verbose};
         # XXX: "gmake check" seems to always hang or fail
-        #gmake -j{jobs} check;
+        #gmake -j{jobs} check {verbose};
     """
 
     def build_image(self, img):
diff --git a/tests/vm/ubuntu.i386 b/tests/vm/ubuntu.i386
index 2498fc7570..160b9be034 100755
--- a/tests/vm/ubuntu.i386
+++ b/tests/vm/ubuntu.i386
@@ -26,7 +26,7 @@ class UbuntuX86VM(basevm.BaseVM):
         tar -xf /dev/vdb;
         ./configure {configure_opts};
         make -j{jobs};
-        make -j{jobs} check;
+        make check -j{jobs} {verbose};
     """
 
     def _gen_cloud_init_iso(self):
-- 
2.17.1
