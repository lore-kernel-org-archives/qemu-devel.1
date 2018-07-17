Received: from eggs.gnu.org ([2001:4830:134:3::10]:49158)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ffG2Z-00004y-Sv
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 22:48:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ffG2Y-0008Ry-8c
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 22:48:39 -0400
Received: from mail-vk0-x244.google.com ([2607:f8b0:400c:c05::244]:37911)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ffG2Y-0008Ri-40
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 22:48:38 -0400
Received: by mail-vk0-x244.google.com with SMTP id b77-v6so22797078vkb.5
	for <qemu-devel@nongnu.org>; Mon, 16 Jul 2018 19:48:37 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 16 Jul 2018 23:48:23 -0300
Message-Id: <20180717024827.27897-2-f4bug@amsat.org>
In-Reply-To: <20180717024827.27897-1-f4bug@amsat.org>
References: <20180717024827.27897-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 1/5] tests/vm: Extract the kvm_available()
 handy function
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
 tests/vm/basevm.py | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
index 3643117816..04089cd545 100755
--- a/tests/vm/basevm.py
+++ b/tests/vm/basevm.py
@@ -33,6 +33,11 @@ SSH_KEY = open(os.path.join(os.path.dirname(__file__),
 SSH_PUB_KEY = open(os.path.join(os.path.dirname(__file__),
                    "..", "keys", "id_rsa.pub")).read()
 
+
+def kvm_available():
+    return os.access("/dev/kvm", os.R_OK | os.W_OK)
+
+
 class BaseVM(object):
     GUEST_USER = "qemu"
     GUEST_PASS = "qemupass"
@@ -72,7 +77,7 @@ class BaseVM(object):
             "-serial", "file:%s" % os.path.join(self._tmpdir, "serial.out")]
         if vcpus:
             self._args += ["-smp", str(vcpus)]
-        if os.access("/dev/kvm", os.R_OK | os.W_OK):
+        if kvm_available():
             self._args += ["-enable-kvm"]
         else:
             logging.info("KVM not available, not using -enable-kvm")
-- 
2.18.0
