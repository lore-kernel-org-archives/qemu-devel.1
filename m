Received: from eggs.gnu.org ([209.51.188.92]:52638)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gtBOX-0004YH-Ss
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 08:13:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gtBOW-00009v-8U
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 08:13:09 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329]:39315)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gtBOW-000090-1f
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 08:13:08 -0500
Received: by mail-wm1-x329.google.com with SMTP id f16so17208130wmh.4
	for <qemu-devel@nongnu.org>; Mon, 11 Feb 2019 05:13:07 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon, 11 Feb 2019 13:05:05 +0000
Message-Id: <20190211130507.8710-17-alex.bennee@linaro.org>
In-Reply-To: <20190211130507.8710-1-alex.bennee@linaro.org>
References: <20190211130507.8710-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 16/18] scripts/qemu.py: allow arches use KVM for
 their 32bit cousins
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

A lot of architectures can run their 32 bit cousins on KVM so the
kvm_available function needs to be a little less restricting when
deciding if KVM is available.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/scripts/qemu.py b/scripts/qemu.py
index 0a5e02eb56..32b00af5cc 100644
--- a/scripts/qemu.py
+++ b/scripts/qemu.py
@@ -25,10 +25,18 @@ import tempfile
 
 LOG = logging.getLogger(__name__)
 
+# Mapping host architecture to any additional architectures it can
+# support which often includes its 32 bit cousin.
+ADDITIONAL_ARCHES = {
+    "x86_64" : "i386",
+    "aarch64" : "armhf"
+}
 
 def kvm_available(target_arch=None):
-    if target_arch and target_arch != os.uname()[4]:
-        return False
+    host_arch = os.uname()[4]
+    if target_arch and target_arch != host_arch:
+        if target_arch != ADDITIONAL_ARCHES.get(host_arch):
+            return False
     return os.access("/dev/kvm", os.R_OK | os.W_OK)
 
 
-- 
2.20.1
