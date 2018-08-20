Received: from eggs.gnu.org ([2001:4830:134:3::10]:52964)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1frmXB-0001t3-Eo
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 11:56:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1frmXA-0004lg-Jk
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 11:56:01 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:44742)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1frmXA-0004k7-Ct
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 11:56:00 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Aug 2018 16:55:54 +0100
Message-Id: <20180820155554.23476-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH] tests/vm: Use -cpu max rather than -cpu host
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, Fam Zheng <famz@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

-cpu max works with any accelerator, so we don't need
to use it only conditionally if not using KVM. Just use
it all the time.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
This is equivalent to "revert dcf7ea4a78b105 and apply
https://patchwork.ozlabs.org/patch/953122/".
---
 tests/vm/basevm.py | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
index d7149dea7da..13c06a35491 100755
--- a/tests/vm/basevm.py
+++ b/tests/vm/basevm.py
@@ -65,6 +65,7 @@ class BaseVM(object):
             self._stdout = self._devnull
         self._args = [ \
             "-nodefaults", "-m", "4G",
+            "-cpu", "max",
             "-netdev", "user,id=vnet,hostfwd=:127.0.0.1:0-:22",
             "-device", "virtio-net-pci,netdev=vnet",
             "-vnc", "127.0.0.1:0,to=20",
@@ -72,11 +73,9 @@ class BaseVM(object):
         if vcpus:
             self._args += ["-smp", str(vcpus)]
         if os.access("/dev/kvm", os.R_OK | os.W_OK):
-            self._args += ["-cpu", "host"]
             self._args += ["-enable-kvm"]
         else:
             logging.info("KVM not available, not using -enable-kvm")
-            self._args += ["-cpu", "max"]
         self._data_args = []
 
     def _download_with_cache(self, url, sha256sum=None):
-- 
2.18.0
