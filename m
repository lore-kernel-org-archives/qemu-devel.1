Received: from eggs.gnu.org ([209.51.188.92]:41065)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1groYn-0000KN-La
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 13:38:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1groYk-0007aI-0i
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 13:38:03 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e]:47013)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1groYg-0007S6-Ah
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 13:38:00 -0500
Received: by mail-wr1-x42e.google.com with SMTP id l9so892292wrt.13
	for <qemu-devel@nongnu.org>; Thu, 07 Feb 2019 10:37:56 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu,  7 Feb 2019 18:37:37 +0000
Message-Id: <20190207183744.5054-10-alex.bennee@linaro.org>
In-Reply-To: <20190207183744.5054-1-alex.bennee@linaro.org>
References: <20190207183744.5054-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 09/16] tests: make docker.py check for
 persistent configs
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

binfmt_misc configured with the "F" flag opens the interpreter at
config time. This means it can use an already open file-descriptor to
run QEMU so there is no point trying to copy the binary into a
container.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/docker/docker.py | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tests/docker/docker.py b/tests/docker/docker.py
index 30f463af9f..768728785f 100755
--- a/tests/docker/docker.py
+++ b/tests/docker/docker.py
@@ -127,6 +127,11 @@ def _check_binfmt_misc(executable):
 
     with open(binfmt_entry) as x: entry = x.read()
 
+    if re.search("flags:.*F.*\n", entry):
+        print("binfmt_misc for %s uses persistent(F) mapping to host binary\n" %
+              (binary))
+        return None
+
     m = re.search("interpreter (\S+)\n", entry)
     interp = m.group(1)
     if interp and interp != executable:
-- 
2.20.1
