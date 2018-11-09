Received: from eggs.gnu.org ([2001:4830:134:3::10]:45389)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gLF1L-000704-JI
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 17:12:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gLF1F-000578-8g
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 17:12:54 -0500
From: Cleber Rosa <crosa@redhat.com>
Date: Fri,  9 Nov 2018 17:12:13 -0500
Message-Id: <20181109221213.7310-3-crosa@redhat.com>
In-Reply-To: <20181109221213.7310-1-crosa@redhat.com>
References: <20181109221213.7310-1-crosa@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC PATCH 2/2] qemu-img: consider a zero number of
 I/O requests an invalid count
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Wainer dos Santos Moschetta <wainersm@redhat.com>, Caio Carrara <ccarrara@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>

It's debatable whether it makes sense to consider the bench command
successful when no I/O requests will be performed.  This changes the
behavior to consider a zero count of I/O requests an invalid value.
While at it, avoid using signed types for number of I/O requests.

The image file used, is a simple raw image with 1K size.  There's a
obvious trade off between creating and reusing those images.  This is
an experiment in sharing those among tests.  It was created using:

 mkdir -p tests/data/images/empty
 cd tests/data/images/empty
 qemu-img create raw 1K

This relies on the Test's "get_data()", which by default looks for
data files on sources that map to various levels of specificity of a
test: file, test and additionally with variant and a symlink.

One other possibility with regards to in-tree images, is to extend the
Test's "get_data()" API (which is extensible by design) and make the
common images directory a "source".  The resulting API usage would be
similar to:

   self.get_data("empty/raw", source=3D"common_images")

or simply:

   self.get_data("empty/raw")

To look for "empty/raw" in any of the available sources.  That would
make the symlink unnecessary.

Reference: https://avocado-framework.readthedocs.io/en/65.0/api/core/avoc=
ado.core.html#avocado.core.test.TestData
Signed-off-by: Cleber Rosa <crosa@redhat.com>
---
 qemu-img.c                                  |   8 ++---
 tests/acceptance/qemu_img_bench.py          |  34 ++++++++++++++++++++
 tests/acceptance/qemu_img_bench.py.data/img |   1 +
 tests/data/images/empty/raw                 | Bin 0 -> 1024 bytes
 4 files changed, 39 insertions(+), 4 deletions(-)
 create mode 100644 tests/acceptance/qemu_img_bench.py
 create mode 120000 tests/acceptance/qemu_img_bench.py.data/img
 create mode 100644 tests/data/images/empty/raw

diff --git a/qemu-img.c b/qemu-img.c
index 4c96db7ba4..7ffcdd1589 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -3960,7 +3960,7 @@ typedef struct BenchData {
     int bufsize;
     int step;
     int nrreq;
-    int n;
+    unsigned int n;
     int flush_interval;
     bool drain_on_flush;
     uint8_t *buf;
@@ -4051,7 +4051,7 @@ static int img_bench(int argc, char **argv)
     bool quiet =3D false;
     bool image_opts =3D false;
     bool is_write =3D false;
-    int count =3D 75000;
+    unsigned int count =3D 75000;
     int depth =3D 64;
     int64_t offset =3D 0;
     size_t bufsize =3D 4096;
@@ -4098,7 +4098,7 @@ static int img_bench(int argc, char **argv)
         {
             unsigned long res;
=20
-            if (qemu_strtoul(optarg, NULL, 0, &res) < 0 || res > INT_MAX=
) {
+            if (qemu_strtoul(optarg, NULL, 0, &res) < 0 || res > UINT_MA=
X || res <=3D 0) {
                 error_report("Invalid request count specified");
                 return 1;
             }
@@ -4248,7 +4248,7 @@ static int img_bench(int argc, char **argv)
         .flush_interval =3D flush_interval,
         .drain_on_flush =3D drain_on_flush,
     };
-    printf("Sending %d %s requests, %d bytes each, %d in parallel "
+    printf("Sending %u %s requests, %d bytes each, %d in parallel "
            "(starting at offset %" PRId64 ", step size %d)\n",
            data.n, data.write ? "write" : "read", data.bufsize, data.nrr=
eq,
            data.offset, data.step);
diff --git a/tests/acceptance/qemu_img_bench.py b/tests/acceptance/qemu_i=
mg_bench.py
new file mode 100644
index 0000000000..327524ad8f
--- /dev/null
+++ b/tests/acceptance/qemu_img_bench.py
@@ -0,0 +1,34 @@
+# Test for the basic qemu-img bench command
+#
+# Copyright (c) 2018 Red Hat, Inc.
+#
+# Author:
+#  Cleber Rosa <crosa@redhat.com>
+#
+# This work is licensed under the terms of the GNU GPL, version 2 or
+# later.  See the COPYING file in the top-level directory.
+
+import os
+
+from avocado_qemu import QemuImgTest
+from avocado.utils import process
+
+
+class Bench(QemuImgTest):
+    """
+    Runs the qemu-img tool with the bench command and different
+    options and verifies the expected outcome.
+
+    :avocado: enable
+    """
+    def check_invalid_count(self, count):
+        cmd =3D "%s bench -c %d %s" % (self.qemu_img_bin, count, self.ge=
t_data("img"))
+        result =3D process.run(cmd, ignore_status=3DTrue)
+        self.assertEqual(1, result.exit_status)
+        self.assertIn(b"Invalid request count", result.stderr)
+
+    def test_zero_count(self):
+        self.check_invalid_count(0)
+
+    def test_negative_count(self):
+        self.check_invalid_count(-1)
diff --git a/tests/acceptance/qemu_img_bench.py.data/img b/tests/acceptan=
ce/qemu_img_bench.py.data/img
new file mode 120000
index 0000000000..6d01ef2e85
--- /dev/null
+++ b/tests/acceptance/qemu_img_bench.py.data/img
@@ -0,0 +1 @@
+../../data/images/empty/raw
\ No newline at end of file
diff --git a/tests/data/images/empty/raw b/tests/data/images/empty/raw
new file mode 100644
index 0000000000000000000000000000000000000000..06d7405020018ddf3cacee90f=
d4af10487da3d20
GIT binary patch
literal 1024
ScmZQz7zLvtFd70QH3R?z00031

literal 0
HcmV?d00001

--=20
2.19.1
