Received: from eggs.gnu.org ([2001:4830:134:3::10]:48311)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e9Vfw-00079u-T8
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 08:29:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e9Vft-0007wk-Ok
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 08:29:48 -0400
Received: from mail-qk0-x232.google.com ([2607:f8b0:400d:c09::232]:49414)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e9Vft-0007wb-K6
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 08:29:45 -0400
Received: by mail-qk0-x232.google.com with SMTP id q83so20153467qke.6
	for <qemu-devel@nongnu.org>; Tue, 31 Oct 2017 05:29:45 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Tue, 31 Oct 2017 09:28:24 -0300
Message-Id: <20171031122824.25686-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] docker: add python stdlib dependency (required
 by keycodemapdb)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Debian QEMU Team <pkg-qemu-devel@lists.alioth.debian.org>

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
---
this might affect native MinGW builds.

(master broken since a4faa26857694fa87d96d15ad5b6afa8fbc2c900)

we didn't notice Shippable failures:
https://app.shippable.com/github/qemu/qemu/runs/501/summary/console and next

 tests/docker/dockerfiles/debian8-mxe.docker | 1 +
 1 file changed, 1 insertion(+)

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
2.15.0.rc2
