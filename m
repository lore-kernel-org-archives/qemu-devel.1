Received: from eggs.gnu.org ([2001:4830:134:3::10]:60013)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fhuuU-0000rp-2J
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 06:51:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fhuuS-0006QO-4j
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 06:51:18 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431]:40751)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fhuuR-0006Py-UU
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 06:51:16 -0400
Received: by mail-wr1-x431.google.com with SMTP id t6-v6so3653842wrn.7
	for <qemu-devel@nongnu.org>; Tue, 24 Jul 2018 03:51:15 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 24 Jul 2018 11:50:56 +0100
Message-Id: <20180724105109.8392-5-alex.bennee@linaro.org>
In-Reply-To: <20180724105109.8392-1-alex.bennee@linaro.org>
References: <20180724105109.8392-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 04/17] docker: fail more gracefully on docker.py
 check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

As this is called directly from the Makefile while determining
dependencies and it is possible the user was configured in one window
but not have credentials in the other. Let's catch the Exceptions and
deal with it quietly.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

diff --git a/tests/docker/docker.py b/tests/docker/docker.py
index 69e7130db7..2f81c6b13b 100755
--- a/tests/docker/docker.py
+++ b/tests/docker/docker.py
@@ -479,7 +479,12 @@ class CheckCommand(SubCommand):
     def run(self, args, argv):
         tag = args.tag
 
-        dkr = Docker()
+        try:
+            dkr = Docker()
+        except:
+            print("Docker not set up")
+            return 1
+
         info = dkr.inspect_tag(tag)
         if info is None:
             print("Image does not exist")
-- 
2.17.1
