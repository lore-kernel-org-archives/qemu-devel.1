Received: from eggs.gnu.org ([2001:4830:134:3::10]:49183)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ffG2b-00005n-89
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 22:48:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ffG2a-0008Tk-IP
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 22:48:41 -0400
Received: from mail-vk0-x229.google.com ([2607:f8b0:400c:c05::229]:41027)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ffG2a-0008TP-Dp
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 22:48:40 -0400
Received: by mail-vk0-x229.google.com with SMTP id j11-v6so22782985vke.8
	for <qemu-devel@nongnu.org>; Mon, 16 Jul 2018 19:48:40 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 16 Jul 2018 23:48:24 -0300
Message-Id: <20180717024827.27897-3-f4bug@amsat.org>
In-Reply-To: <20180717024827.27897-1-f4bug@amsat.org>
References: <20180717024827.27897-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 2/5] tests/vm: Use 'host' cpu when KVM is
 available, else default to 'max'
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

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 tests/vm/basevm.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
index 04089cd545..1f4ad04c32 100755
--- a/tests/vm/basevm.py
+++ b/tests/vm/basevm.py
@@ -70,7 +70,6 @@ class BaseVM(object):
             self._stdout = self._devnull
         self._args = [ \
             "-nodefaults", "-m", "2G",
-            "-cpu", "host",
             "-netdev", "user,id=vnet,hostfwd=:127.0.0.1:0-:22",
             "-device", "virtio-net-pci,netdev=vnet",
             "-vnc", "127.0.0.1:0,to=20",
@@ -79,8 +78,10 @@ class BaseVM(object):
             self._args += ["-smp", str(vcpus)]
         if kvm_available():
             self._args += ["-enable-kvm"]
+            self._args += ["-cpu", "host"]
         else:
             logging.info("KVM not available, not using -enable-kvm")
+            self._args += ["-cpu", "max"]
         self._data_args = []
 
     def _download_with_cache(self, url, sha256sum=None):
-- 
2.18.0
