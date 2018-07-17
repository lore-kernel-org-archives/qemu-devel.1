Received: from eggs.gnu.org ([2001:4830:134:3::10]:40894)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ffW4q-00032b-TK
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 15:56:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ffW4m-0004bh-Cv
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 15:56:04 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:34372)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1ffW4m-0004b1-5w
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 15:56:00 -0400
Received: by mail-wr1-x42c.google.com with SMTP id c13-v6so2397702wrt.1
	for <qemu-devel@nongnu.org>; Tue, 17 Jul 2018 12:55:59 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 17 Jul 2018 20:55:39 +0100
Message-Id: <20180717195553.9111-5-alex.bennee@linaro.org>
In-Reply-To: <20180717195553.9111-1-alex.bennee@linaro.org>
References: <20180717195553.9111-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 for 3.0 04/18] docker: fail more gracefully
 on docker.py check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

As this is called directly from the Makefile while determining
dependencies and it is possible the user was configured in one window
but not have credentials in the other. Let's catch the Exceptions and
deal with it quietly.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 tests/docker/docker.py | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

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
