Received: from eggs.gnu.org ([2001:4830:134:3::10]:60589)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fYYxz-0002Ov-QT
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 11:36:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fYYxw-0001YC-Ng
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 11:36:15 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:33933)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fYYxw-0001Wy-Ht
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 11:36:12 -0400
Received: by mail-qt0-x243.google.com with SMTP id d23-v6so5116275qtp.1
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 08:36:12 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 28 Jun 2018 12:35:34 -0300
Message-Id: <20180628153535.1411-4-f4bug@amsat.org>
In-Reply-To: <20180628153535.1411-1-f4bug@amsat.org>
References: <20180628153535.1411-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 3/4] tests/vm: Only use -cpu 'host' if KVM is
 available
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

If KVM is not available, then use the 'max' cpu.

This fixes:

  ERROR:root:Log:
  ERROR:root:qemu-system-x86_64: CPU model 'host' requires KVM
  Failed to prepare guest environment
  error: [Errno 104] Connection reset by peer
  source/qemu/tests/vm/Makefile.include:25: recipe for target 'tests/vm/ubuntu.i386.img' failed
  make: *** [tests/vm/ubuntu.i386.img] Error 2

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 tests/vm/basevm.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
index 3643117816..d80cc8ab85 100755
--- a/tests/vm/basevm.py
+++ b/tests/vm/basevm.py
@@ -65,7 +65,6 @@ class BaseVM(object):
             self._stdout = self._devnull
         self._args = [ \
             "-nodefaults", "-m", "2G",
-            "-cpu", "host",
             "-netdev", "user,id=vnet,hostfwd=:127.0.0.1:0-:22",
             "-device", "virtio-net-pci,netdev=vnet",
             "-vnc", "127.0.0.1:0,to=20",
@@ -73,9 +72,11 @@ class BaseVM(object):
         if vcpus:
             self._args += ["-smp", str(vcpus)]
         if os.access("/dev/kvm", os.R_OK | os.W_OK):
+            self._args += ["-cpu", "host"]
             self._args += ["-enable-kvm"]
         else:
             logging.info("KVM not available, not using -enable-kvm")
+            self._args += ["-cpu", "max"]
         self._data_args = []
 
     def _download_with_cache(self, url, sha256sum=None):
-- 
2.18.0
