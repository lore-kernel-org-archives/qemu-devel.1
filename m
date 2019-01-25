Received: from eggs.gnu.org ([209.51.188.92]:54130)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gn28z-0000nH-PB
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 09:07:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gn28x-0004Yd-UD
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 09:07:41 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:47029)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gn28w-0004Q9-Gk
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 09:07:39 -0500
Received: by mail-wr1-x442.google.com with SMTP id l9so10385441wrt.13
	for <qemu-devel@nongnu.org>; Fri, 25 Jan 2019 06:07:30 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 25 Jan 2019 14:00:17 +0000
Message-Id: <20190125140017.6092-15-alex.bennee@linaro.org>
In-Reply-To: <20190125140017.6092-1-alex.bennee@linaro.org>
References: <20190125140017.6092-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v1 14/14] scripts/qemu.py: allow arches use KVM
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>

A lot of architectures can run their 32 bit cousins on KVM so the
kvm_available function needs to be a little less restricting when
deciding if KVM is available.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 scripts/qemu.py | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/scripts/qemu.py b/scripts/qemu.py
index 0a5e02eb56..2934ee12c5 100644
--- a/scripts/qemu.py
+++ b/scripts/qemu.py
@@ -25,9 +25,18 @@ import tempfile
 
 LOG = logging.getLogger(__name__)
 
+# Mapping host architecture to any additional architectures it can
+# support which often includes its 32 bit cousin.
+ADDITIONAL_ARCHES = {
+    "x86_64" : "i386",
+    "aarch64" : "armhf"
+}
 
 def kvm_available(target_arch=None):
-    if target_arch and target_arch != os.uname()[4]:
+    host_arch = os.uname()[4]
+    if target_arch and target_arch != host_arch:
+        if target_arch == ADDITIONAL_ARCHES[host_arch]:
+            return True
         return False
     return os.access("/dev/kvm", os.R_OK | os.W_OK)
 
-- 
2.17.1
