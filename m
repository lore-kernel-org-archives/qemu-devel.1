Received: from eggs.gnu.org ([2001:4830:134:3::10]:41776)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dqG0t-00083L-0c
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 05:55:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dqG0o-0004lA-Br
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 05:55:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38638)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dqG0o-0004kN-2L
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 05:55:46 -0400
From: Fam Zheng <famz@redhat.com>
Date: Fri,  8 Sep 2017 17:54:46 +0800
Message-Id: <20170908095506.13594-19-famz@redhat.com>
In-Reply-To: <20170908095506.13594-1-famz@redhat.com>
References: <20170908095506.13594-1-famz@redhat.com>
Subject: [Qemu-devel] [PULL 18/38] tests: Add README for vm tests
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
Message-Id: <20170905021201.25684-12-famz@redhat.com>
---
 tests/vm/README | 63 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)
 create mode 100644 tests/vm/README

diff --git a/tests/vm/README b/tests/vm/README
new file mode 100644
index 0000000000..7d2fe4ac8d
--- /dev/null
+++ b/tests/vm/README
@@ -0,0 +1,63 @@
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
+Run "make vm-test" to list available make targets.
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
+    * SSH service is enabled and started on boot, BaseVM.SSH_PUB_KEY is added
+      to authorized_keys of both root and the normal user
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
+
-- 
2.13.5
