Received: from eggs.gnu.org ([2001:4830:134:3::10]:44517)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1frjbW-00027k-Cm
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 08:48:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1frjbV-0002N9-M7
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 08:48:18 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:44588)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1frjbV-0002MH-FI
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 08:48:17 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Aug 2018 13:48:11 +0100
Message-Id: <20180820124811.7982-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH] tests/vm: Clean out old working directories on
 build
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, Fam Zheng <famz@redhat.com>, =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>

When we do a build inside one of the BSD VMs, first
delete any stale old build directories from the VM's
/var/tmp. This prevents the VM from running out of
disk space after it has been used for a dozen or
so builds.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
The Ubuntu test VM has a similar issue, but it doesn't
put its test build directories in /var/tmp/ like the
BSDs, and I don't use it so I'm not sure what the right
rm command would be. Somebody else can fix it if they care...

Disclaimer: not actually tested yet, but obviously it will
get tested as part of applying it to master, which I'd
like to do so my pullrequest tests don't keep getting
tripped up by this bug.

 tests/vm/freebsd | 1 +
 tests/vm/netbsd  | 1 +
 tests/vm/openbsd | 1 +
 3 files changed, 3 insertions(+)

diff --git a/tests/vm/freebsd b/tests/vm/freebsd
index 0a6ec4614a7..b6983127d09 100755
--- a/tests/vm/freebsd
+++ b/tests/vm/freebsd
@@ -20,6 +20,7 @@ class FreeBSDVM(basevm.BaseVM):
     name = "freebsd"
     BUILD_SCRIPT = """
         set -e;
+        rm -rf /var/tmp/qemu-test.*
         cd $(mktemp -d /var/tmp/qemu-test.XXXXXX);
         tar -xf /dev/vtbd1;
         ./configure {configure_opts};
diff --git a/tests/vm/netbsd b/tests/vm/netbsd
index 45c9260dc0d..a4e25820d50 100755
--- a/tests/vm/netbsd
+++ b/tests/vm/netbsd
@@ -20,6 +20,7 @@ class NetBSDVM(basevm.BaseVM):
     name = "netbsd"
     BUILD_SCRIPT = """
         set -e;
+        rm -rf /var/tmp/qemu-test.*
         cd $(mktemp -d /var/tmp/qemu-test.XXXXXX);
         tar -xf /dev/rld1a;
         ./configure --python=python2.7 {configure_opts};
diff --git a/tests/vm/openbsd b/tests/vm/openbsd
index 98edfbca4ba..52500ee52bb 100755
--- a/tests/vm/openbsd
+++ b/tests/vm/openbsd
@@ -20,6 +20,7 @@ class OpenBSDVM(basevm.BaseVM):
     name = "openbsd"
     BUILD_SCRIPT = """
         set -e;
+        rm -rf /var/tmp/qemu-test.*
         cd $(mktemp -d /var/tmp/qemu-test.XXXXXX);
         tar -xf /dev/rsd1c;
         ./configure --cc=x86_64-unknown-openbsd6.1-gcc-4.9.4 --python=python2.7 {configure_opts};
-- 
2.18.0
