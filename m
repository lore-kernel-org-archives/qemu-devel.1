Received: from eggs.gnu.org ([2001:4830:134:3::10]:42146)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eAGfg-0004F6-EV
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 10:40:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eAGfd-0003PB-Qu
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 10:40:40 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:56484)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1eAGfd-0003N6-K2
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 10:40:37 -0400
Received: by mail-wm0-x241.google.com with SMTP id z3so11895132wme.5
	for <qemu-devel@nongnu.org>; Thu, 02 Nov 2017 07:40:37 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu,  2 Nov 2017 14:40:34 +0000
Message-Id: <20171102144034.888-2-alex.bennee@linaro.org>
In-Reply-To: <20171102144034.888-1-alex.bennee@linaro.org>
References: <20171102144034.888-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 1/1] docker: add python stdlib dependency
 (required by keycodemapdb)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Since 927128222b0a QEMU depends of keycodemapdb, which uses the python 'csv'
module from stdlib to parse keymaps.csv.

Without this package the build fails:

    GEN     ui/input-keymap-linux-to-qcode.c
  Traceback (most recent call last):
    File "ui/keycodemapdb/tools/keymap-gen", line 15, in <module>
      import csv
  ImportError: No module named csv
    GEN     ui/input-keymap-qcode-to-qnum.c
  Traceback (most recent call last):
    File "ui/keycodemapdb/tools/keymap-gen", line 15, in <module>
      import csv
  ImportError: No module named csv
  [...]
    CC      ui/input-keymap.o
  ui/input-keymap.c:8:44: fatal error: ui/input-keymap-linux-to-qcode.c: No such file or directory
  make: *** [ui/input-keymap.o] Error 1

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/docker/dockerfiles/debian8-mxe.docker b/tests/docker/dockerfiles/debian8-mxe.docker
index 7bf1b59e54..9b8e577b03 100644
--- a/tests/docker/dockerfiles/debian8-mxe.docker
+++ b/tests/docker/dockerfiles/debian8-mxe.docker
@@ -13,6 +13,7 @@ RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys D43A795B73B16ABE964
 RUN apt-get update
 RUN DEBIAN_FRONTEND=noninteractive eatmydata \
     apt-get install -y --no-install-recommends \
+        libpython2.7-stdlib \
         $(apt-get -s install -y --no-install-recommends gw32.shared-mingw-w64 gw32.shared-mingw-w64 | egrep "^Inst mxe-x86-64-unknown-" | cut -d\  -f2)
 
 ENV PATH $PATH:/usr/lib/mxe/usr/bin/ 
-- 
2.14.2
