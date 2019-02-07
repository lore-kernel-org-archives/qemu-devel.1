Received: from eggs.gnu.org ([209.51.188.92]:41237)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1groYy-0000WP-7Z
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 13:38:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1groYt-0007nC-Sx
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 13:38:13 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:55748)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1groYr-0007Yf-Rz
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 13:38:11 -0500
Received: by mail-wm1-x344.google.com with SMTP id r17so917409wmh.5
	for <qemu-devel@nongnu.org>; Thu, 07 Feb 2019 10:38:01 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu,  7 Feb 2019 18:37:44 +0000
Message-Id: <20190207183744.5054-17-alex.bennee@linaro.org>
In-Reply-To: <20190207183744.5054-1-alex.bennee@linaro.org>
References: <20190207183744.5054-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 16/16] scripts/qemu.py: allow arches use KVM
 for their 32bit cousins
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

A lot of architectures can run their 32 bit cousins on KVM so the
kvm_available function needs to be a little less restricting when
deciding if KVM is available.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 scripts/qemu.py | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

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
