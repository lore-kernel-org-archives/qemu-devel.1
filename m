Received: from eggs.gnu.org ([2001:4830:134:3::10]:39956)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fO7XY-0007zn-RM
	for qemu-devel@nongnu.org; Wed, 30 May 2018 16:18:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fO7Jx-0001C1-Gd
	for qemu-devel@nongnu.org; Wed, 30 May 2018 16:03:48 -0400
Received: from mail-qt0-x234.google.com ([2607:f8b0:400d:c0d::234]:33486)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fO7Jx-0001BZ-Bg
	for qemu-devel@nongnu.org; Wed, 30 May 2018 16:03:45 -0400
Received: by mail-qt0-x234.google.com with SMTP id e8-v6so24959065qth.0
	for <qemu-devel@nongnu.org>; Wed, 30 May 2018 13:03:45 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed, 30 May 2018 17:03:34 -0300
Message-Id: <20180530200334.24179-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH] configure: Enable out-of-tree acceptance
 tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Amador Pahim <amador@pahim.org>, Cleber Rosa <crosa@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

In order to allow out-of-tree acceptance tests with Avocado,
create a symlink in the build tree.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
Based-on: 20180530184156.15634-1-crosa@redhat.com
http://lists.nongnu.org/archive/html/qemu-devel/2018-05/msg06877.html

Before:

  build_dir$ avocado run /full/path/to/sources/qemu/tests/acceptance/boot_linux_console.py

After

  build_dir$ avocado run tests/acceptance/boot_linux_console.py

I first wanted to try something like:

echo "[datadir.paths]" > .avocado.conf
echo "test_dir = $source_path/tests/acceptance" >> .avocado.conf

to run:

  build_dir$ avocado run -t console

but this doesn't work this way, I'd have to use

  build_dir$ avocado --config .avocado.conf boot_linux_console.py -t console

which isn't a win.
---
 configure | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/configure b/configure
index a6a4616c3e..0763ebe5ba 100755
--- a/configure
+++ b/configure
@@ -7213,9 +7213,11 @@ for rom in seabios vgabios ; do
 done
 
 # set up tests data directory
-if [ ! -e tests/data ]; then
-    symlink "$source_path/tests/data" tests/data
-fi
+for tests_subdir in acceptance data; do
+    if [ ! -e tests/$tests_subdir ]; then
+        symlink "$source_path/tests/$tests_subdir" tests/$tests_subdir
+    fi
+done
 
 # set up qemu-iotests in this build directory
 iotests_common_env="tests/qemu-iotests/common.env"
-- 
2.17.1
