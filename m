Received: from eggs.gnu.org ([2001:4830:134:3::10]:39767)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gB7zA-0001zU-O6
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 20:40:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gB7z8-0000X5-V7
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 20:40:52 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:33570)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gB7z8-0000We-On
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 20:40:50 -0400
Received: by mail-wr1-x441.google.com with SMTP id e4-v6so15127945wrs.0
	for <qemu-devel@nongnu.org>; Fri, 12 Oct 2018 17:40:50 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Sat, 13 Oct 2018 02:40:30 +0200
Message-Id: <20181013004034.6968-6-f4bug@amsat.org>
In-Reply-To: <20181013004034.6968-1-f4bug@amsat.org>
References: <20181013004034.6968-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 5/8] tests/vm: Add a BaseVM::arch property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>

The 'arch' property gives a hint on which architecture the guest image runs.

This can be use to select the correct QEMU binary path.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 tests/vm/basevm.py   | 4 +++-
 tests/vm/centos      | 1 +
 tests/vm/freebsd     | 1 +
 tests/vm/netbsd      | 1 +
 tests/vm/openbsd     | 1 +
 tests/vm/ubuntu.i386 | 1 +
 6 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
index 81a1cb05dd..b2e0de2022 100755
--- a/tests/vm/basevm.py
+++ b/tests/vm/basevm.py
@@ -42,6 +42,8 @@ class BaseVM(object):
     BUILD_SCRIPT = ""
     # The guest name, to be overridden by subclasses
     name = "#base"
+    # The guest architecture, to be overridden by subclasses
+    arch = "#arch"
     def __init__(self, debug=False, vcpus=None):
         self._guest = None
         self._tmpdir = os.path.realpath(tempfile.mkdtemp(prefix="vm-test-",
@@ -151,7 +153,7 @@ class BaseVM(object):
             "-device", "virtio-blk,drive=drive0,bootindex=0"]
         args += self._data_args + extra_args
         logging.debug("QEMU args: %s", " ".join(args))
-        qemu_bin = os.environ.get("QEMU", "qemu-system-x86_64")
+        qemu_bin = os.environ.get("QEMU", "qemu-system-" + self.arch)
         guest = QEMUMachine(binary=qemu_bin, args=args)
         try:
             guest.launch()
diff --git a/tests/vm/centos b/tests/vm/centos
index afd560c564..daa2dbca03 100755
--- a/tests/vm/centos
+++ b/tests/vm/centos
@@ -19,6 +19,7 @@ import time
 
 class CentosVM(basevm.BaseVM):
     name = "centos"
+    arch = "x86_64"
     BUILD_SCRIPT = """
         set -e;
         cd $(mktemp -d);
diff --git a/tests/vm/freebsd b/tests/vm/freebsd
index b6983127d0..19a3729172 100755
--- a/tests/vm/freebsd
+++ b/tests/vm/freebsd
@@ -18,6 +18,7 @@ import basevm
 
 class FreeBSDVM(basevm.BaseVM):
     name = "freebsd"
+    arch = "x86_64"
     BUILD_SCRIPT = """
         set -e;
         rm -rf /var/tmp/qemu-test.*
diff --git a/tests/vm/netbsd b/tests/vm/netbsd
index a4e25820d5..fac6a7ce51 100755
--- a/tests/vm/netbsd
+++ b/tests/vm/netbsd
@@ -18,6 +18,7 @@ import basevm
 
 class NetBSDVM(basevm.BaseVM):
     name = "netbsd"
+    arch = "x86_64"
     BUILD_SCRIPT = """
         set -e;
         rm -rf /var/tmp/qemu-test.*
diff --git a/tests/vm/openbsd b/tests/vm/openbsd
index 52500ee52b..cfe0572c59 100755
--- a/tests/vm/openbsd
+++ b/tests/vm/openbsd
@@ -18,6 +18,7 @@ import basevm
 
 class OpenBSDVM(basevm.BaseVM):
     name = "openbsd"
+    arch = "x86_64"
     BUILD_SCRIPT = """
         set -e;
         rm -rf /var/tmp/qemu-test.*
diff --git a/tests/vm/ubuntu.i386 b/tests/vm/ubuntu.i386
index 3f6ed48b74..1b7e1ab8f0 100755
--- a/tests/vm/ubuntu.i386
+++ b/tests/vm/ubuntu.i386
@@ -19,6 +19,7 @@ import time
 
 class UbuntuX86VM(basevm.BaseVM):
     name = "ubuntu.i386"
+    arch = "i386"
     BUILD_SCRIPT = """
         set -e;
         cd $(mktemp -d);
-- 
2.19.1
