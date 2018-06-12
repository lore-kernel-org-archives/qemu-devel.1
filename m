Received: from eggs.gnu.org ([2001:4830:134:3::10]:44393)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fSnC3-0002GZ-5i
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 13:34:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fSnC0-0001VO-2u
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 13:34:55 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:38380)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fSnBz-0001Uy-V1
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 13:34:52 -0400
Received: by mail-qt0-x243.google.com with SMTP id x34-v6so24481397qtk.5
	for <qemu-devel@nongnu.org>; Tue, 12 Jun 2018 10:34:51 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Tue, 12 Jun 2018 14:34:37 -0300
Message-Id: <20180612173437.14462-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] configure: Enable out-of-tree acceptance tests
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

Currently to run Avocado acceptance tests in an out-of-tree
build directory, we need to use the full path to the test:

  build_dir$ avocado run /full/path/to/sources/qemu/tests/acceptance/boot_linux_console.py

This patch adds a symlink in the build tree to simplify the
tests invocation, allowing the same command than in in-tree builds:

  build_dir$ avocado run tests/acceptance/boot_linux_console.py

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
Based-on: 20180530184156.15634-1-crosa@redhat.com

Since RFC: reworded the commit message (Eduardo Habkost)

 configure | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/configure b/configure
index a8c4094c87..d095ed45a4 100755
--- a/configure
+++ b/configure
@@ -7239,9 +7239,11 @@ for rom in seabios vgabios ; do
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
