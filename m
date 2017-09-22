Received: from eggs.gnu.org ([2001:4830:134:3::10]:38179)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dvIh0-0000DW-Ot
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 03:48:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dvIgz-0001FS-H8
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 03:48:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45956)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dvIgz-0001F5-7s
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 03:48:09 -0400
From: Fam Zheng <famz@redhat.com>
Date: Fri, 22 Sep 2017 15:46:57 +0800
Message-Id: <20170922074659.30097-35-famz@redhat.com>
In-Reply-To: <20170922074659.30097-1-famz@redhat.com>
References: <20170922074659.30097-1-famz@redhat.com>
Subject: [Qemu-devel] [PULL 34/36] tests: Add README for vm tests
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

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 tests/vm/README | 89 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 89 insertions(+)
 create mode 100644 tests/vm/README

diff --git a/tests/vm/README b/tests/vm/README
new file mode 100644
index 0000000000..ae53dce6ee
--- /dev/null
+++ b/tests/vm/README
@@ -0,0 +1,89 @@
+=== VM test suite to run build in guests ===
+
+== Intro ==
+
+This test suite contains scripts that bootstrap various guest images that have
+necessary packages to build QEMU. The basic usage is documented in Makefile
+help which is displayed with "make vm-test".
+
+== Quick start ==
+
+Run "make vm-test" to list available make targets. Invoke a specific make
+command to run build test in an image. For example, "make vm-build-freebsd"
+will build the source tree in the FreeBSD image. The command can be executed
+from either the source tree or the build dir; if the former, ./configure is not
+needed. The command will then generate the test image in ./tests/vm/ under the
+working directory.
+
+Note: images created by the scripts accept a well-known RSA key pair for SSH
+access, so they SHOULD NOT be exposed to external interfaces if you are
+concerned about attackers taking control of the guest and potentially
+exploiting a QEMU security bug to compromise the host.
+
+== QEMU binary ==
+
+By default, qemu-system-x86_64 is searched in $PATH to run the guest. If there
+isn't one, or if it is older than 2.10, the test won't work. In this case,
+provide the QEMU binary in env var: QEMU=/path/to/qemu-2.10+.
+
+== Make jobs ==
+
+The "-j$X" option in the make command line is not propagated into the VM,
+specify "J=$X" to control the make jobs in the guest.
+
+== Debugging ==
+
+Add "DEBUG=1" and/or "V=1" to the make command to allow interactive debugging
+and verbose output. If this is not enough, see the next section.
+
+== Manual invocation ==
+
+Each guest script is an executable script with the same command line options.
+For example to work with the netbsd guest, use $QEMU_SRC/tests/vm/netbsd:
+
+    $ cd $QEMU_SRC/tests/vm
+
+    # To bootstrap the image
+    $ ./netbsd --build-image --image /var/tmp/netbsd.img
+    <...>
+
+    # To run an arbitrary command in guest (the output will not be echoed unless
+    # --debug is added)
+    $ ./netbsd --debug --image /var/tmp/netbsd.img uname -a
+
+    # To build QEMU in guest
+    $ ./netbsd --debug --image /var/tmp/netbsd.img --build-qemu $QEMU_SRC
+
+    # To get to an interactive shell
+    $ ./netbsd --interactive --image /var/tmp/netbsd.img sh
+
+== Adding new guests ==
+
+Please look at existing guest scripts for how to add new guests.
+
+Most importantly, create a subclass of BaseVM and implement build_image()
+method and define BUILD_SCRIPT, then finally call basevm.main() from the
+script's main().
+
+  - Usually in build_image(), a template image is downloaded from a predefined
+    URL. BaseVM._download_with_cache() takes care of the cache and the
+    checksum, so consider using it.
+
+  - Once the image is downloaded, users, SSH server and QEMU build deps should
+    be set up:
+
+    * Root password set to BaseVM.ROOT_PASS
+    * User BaseVM.GUEST_USER is created, and password set to BaseVM.GUEST_PASS
+    * SSH service is enabled and started on boot,
+      $QEMU_SRC/tests/keys/id_rsa.pub is added to ssh's "authorized_keys" file
+      of both root and the normal user
+    * DHCP client service is enabled and started on boot, so that it can
+      automatically configure the virtio-net-pci NIC and communicate with QEMU
+      user net (10.0.2.2)
+    * Necessary packages are installed to untar the source tarball and build
+      QEMU
+
+  - Write a proper BUILD_SCRIPT template, which should be a shell script that
+    untars a raw virtio-blk block device, which is the tarball data blob of the
+    QEMU source tree, then configure/build it. Running "make check" is also
+    recommended.
-- 
2.13.5
