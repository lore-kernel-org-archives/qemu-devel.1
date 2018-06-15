Received: from eggs.gnu.org ([2001:4830:134:3::10]:46980)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fTuAK-00081l-Eu
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 15:13:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fTuAJ-0007S4-Gu
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 15:13:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34550)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fTuAJ-0007RH-BU
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 15:13:43 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri, 15 Jun 2018 16:13:27 -0300
Message-Id: <20180615191327.11480-8-ehabkost@redhat.com>
In-Reply-To: <20180615191327.11480-1-ehabkost@redhat.com>
References: <20180615191327.11480-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 7/7] configure: Enable out-of-tree acceptance
 tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Currently to run Avocado acceptance tests in an out-of-tree
build directory, we need to use the full path to the test:

  build_dir$ avocado run /full/path/to/sources/qemu/tests/acceptance/boot=
_linux_console.py

This patch adds a symlink in the build tree to simplify the
tests invocation, allowing the same command than in in-tree builds:

  build_dir$ avocado run tests/acceptance/boot_linux_console.py

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Message-Id: <20180612173437.14462-1-f4bug@amsat.org>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 configure | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/configure b/configure
index a8c4094c87..d095ed45a4 100755
--- a/configure
+++ b/configure
@@ -7239,9 +7239,11 @@ for rom in seabios vgabios ; do
 done
=20
 # set up tests data directory
-if [ ! -e tests/data ]; then
-    symlink "$source_path/tests/data" tests/data
-fi
+for tests_subdir in acceptance data; do
+    if [ ! -e tests/$tests_subdir ]; then
+        symlink "$source_path/tests/$tests_subdir" tests/$tests_subdir
+    fi
+done
=20
 # set up qemu-iotests in this build directory
 iotests_common_env=3D"tests/qemu-iotests/common.env"
--=20
2.18.0.rc1.1.g3f1ff2140
