Received: from eggs.gnu.org ([2001:4830:134:3::10]:60092)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gMFfs-0000nl-1a
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 12:07:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gMFfq-0007Jp-2S
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 12:06:55 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 12 Nov 2018 18:05:57 +0100
Message-Id: <20181112170603.23986-9-kwolf@redhat.com>
In-Reply-To: <20181112170603.23986-1-kwolf@redhat.com>
References: <20181112170603.23986-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 08/14] tests: Add unit tests for image locking
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

From: Fam Zheng <famz@redhat.com>

Signed-off-by: Fam Zheng <famz@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/test-image-locking.c | 157 +++++++++++++++++++++++++++++++++++++
 tests/Makefile.include     |   2 +
 2 files changed, 159 insertions(+)
 create mode 100644 tests/test-image-locking.c

diff --git a/tests/test-image-locking.c b/tests/test-image-locking.c
new file mode 100644
index 0000000000..7614cbf90c
--- /dev/null
+++ b/tests/test-image-locking.c
@@ -0,0 +1,157 @@
+/*
+ * Image locking tests
+ *
+ * Copyright (c) 2018 Red Hat Inc.
+ *
+ * Author: Fam Zheng <famz@redhat.com>
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining=
 a copy
+ * of this software and associated documentation files (the "Software"),=
 to deal
+ * in the Software without restriction, including without limitation the=
 rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or =
sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be includ=
ed in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHA=
LL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR =
OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISI=
NG FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALING=
S IN
+ * THE SOFTWARE.
+ */
+
+#include "qemu/osdep.h"
+#include "block/block.h"
+#include "sysemu/block-backend.h"
+#include "qapi/error.h"
+#include "qapi/qmp/qdict.h"
+
+static BlockBackend *open_image(const char *path,
+                                uint64_t perm, uint64_t shared_perm,
+                                Error **errp)
+{
+    Error *local_err =3D NULL;
+    BlockBackend *blk;
+    QDict *options =3D qdict_new();
+
+    qdict_put_str(options, "driver", "raw");
+    blk =3D blk_new_open(path, NULL, options, BDRV_O_RDWR, &local_err);
+    if (blk) {
+        g_assert_null(local_err);
+        if (blk_set_perm(blk, perm, shared_perm, errp)) {
+            blk_unref(blk);
+            blk =3D NULL;
+        }
+    } else {
+        error_propagate(errp, local_err);
+    }
+    return blk;
+}
+
+static void check_locked_bytes(int fd, uint64_t perm_locks,
+                               uint64_t shared_perm_locks)
+{
+    int i;
+
+    if (!perm_locks && !shared_perm_locks) {
+        g_assert(!qemu_lock_fd_test(fd, 0, 0, true));
+        return;
+    }
+    for (i =3D 0; (1ULL << i) <=3D BLK_PERM_ALL; i++) {
+        uint64_t bit =3D (1ULL << i);
+        bool perm_expected =3D !!(bit & perm_locks);
+        bool shared_perm_expected =3D !!(bit & shared_perm_locks);
+        g_assert_cmpint(perm_expected, =3D=3D,
+                        !!qemu_lock_fd_test(fd, 100 + i, 1, true));
+        g_assert_cmpint(shared_perm_expected, =3D=3D,
+                        !!qemu_lock_fd_test(fd, 200 + i, 1, true));
+    }
+}
+
+static void test_image_locking_basic(void)
+{
+    BlockBackend *blk1, *blk2, *blk3;
+    char img_path[] =3D "/tmp/qtest.XXXXXX";
+    uint64_t perm, shared_perm;
+
+    int fd =3D mkstemp(img_path);
+    assert(fd >=3D 0);
+
+    perm =3D BLK_PERM_WRITE | BLK_PERM_CONSISTENT_READ;
+    shared_perm =3D BLK_PERM_ALL;
+    blk1 =3D open_image(img_path, perm, shared_perm, &error_abort);
+    g_assert(blk1);
+
+    check_locked_bytes(fd, perm, ~shared_perm);
+
+    /* compatible perm between blk1 and blk2 */
+    blk2 =3D open_image(img_path, perm | BLK_PERM_RESIZE, shared_perm, N=
ULL);
+    g_assert(blk2);
+    check_locked_bytes(fd, perm | BLK_PERM_RESIZE, ~shared_perm);
+
+    /* incompatible perm with already open blk1 and blk2 */
+    blk3 =3D open_image(img_path, perm, BLK_PERM_WRITE_UNCHANGED, NULL);
+    g_assert_null(blk3);
+
+    blk_unref(blk2);
+
+    /* Check that extra bytes in blk2 are correctly unlocked */
+    check_locked_bytes(fd, perm, ~shared_perm);
+
+    blk_unref(blk1);
+
+    /* Image is unused, no lock there */
+    check_locked_bytes(fd, 0, 0);
+    blk3 =3D open_image(img_path, perm, BLK_PERM_WRITE_UNCHANGED, &error=
_abort);
+    g_assert(blk3);
+    blk_unref(blk3);
+    close(fd);
+    unlink(img_path);
+}
+
+static void test_set_perm_abort(void)
+{
+    BlockBackend *blk1, *blk2;
+    char img_path[] =3D "/tmp/qtest.XXXXXX";
+    uint64_t perm, shared_perm;
+    int r;
+    int fd =3D mkstemp(img_path);
+    assert(fd >=3D 0);
+
+    perm =3D BLK_PERM_WRITE | BLK_PERM_CONSISTENT_READ;
+    shared_perm =3D BLK_PERM_ALL;
+    blk1 =3D open_image(img_path, perm, shared_perm, &error_abort);
+    g_assert(blk1);
+
+    blk2 =3D open_image(img_path, perm, shared_perm, &error_abort);
+    g_assert(blk2);
+
+    check_locked_bytes(fd, perm, ~shared_perm);
+
+    /* A failed blk_set_perm mustn't change perm status (locked bytes) *=
/
+    r =3D blk_set_perm(blk2, perm | BLK_PERM_RESIZE, BLK_PERM_WRITE_UNCH=
ANGED,
+                     NULL);
+    g_assert_cmpint(r, !=3D, 0);
+    check_locked_bytes(fd, perm, ~shared_perm);
+    blk_unref(blk1);
+    blk_unref(blk2);
+}
+
+int main(int argc, char **argv)
+{
+    bdrv_init();
+    qemu_init_main_loop(&error_abort);
+
+    g_test_init(&argc, &argv, NULL);
+
+    if (qemu_has_ofd_lock()) {
+        g_test_add_func("/image-locking/basic", test_image_locking_basic=
);
+        g_test_add_func("/image-locking/set-perm-abort", test_set_perm_a=
bort);
+    }
+
+    return g_test_run();
+}
diff --git a/tests/Makefile.include b/tests/Makefile.include
index 074eece558..613242bc6e 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -70,6 +70,7 @@ check-unit-y +=3D tests/test-bdrv-drain$(EXESUF)
 check-unit-y +=3D tests/test-blockjob$(EXESUF)
 check-unit-y +=3D tests/test-blockjob-txn$(EXESUF)
 check-unit-y +=3D tests/test-block-backend$(EXESUF)
+check-unit-y +=3D tests/test-image-locking$(EXESUF)
 check-unit-y +=3D tests/test-x86-cpuid$(EXESUF)
 # all code tested by test-x86-cpuid is inside topology.h
 ifeq ($(CONFIG_SOFTMMU),y)
@@ -537,6 +538,7 @@ tests/test-bdrv-drain$(EXESUF): tests/test-bdrv-drain=
.o $(test-block-obj-y) $(te
 tests/test-blockjob$(EXESUF): tests/test-blockjob.o $(test-block-obj-y) =
$(test-util-obj-y)
 tests/test-blockjob-txn$(EXESUF): tests/test-blockjob-txn.o $(test-block=
-obj-y) $(test-util-obj-y)
 tests/test-block-backend$(EXESUF): tests/test-block-backend.o $(test-blo=
ck-obj-y) $(test-util-obj-y)
+tests/test-image-locking$(EXESUF): tests/test-image-locking.o $(test-blo=
ck-obj-y) $(test-util-obj-y)
 tests/test-thread-pool$(EXESUF): tests/test-thread-pool.o $(test-block-o=
bj-y)
 tests/test-iov$(EXESUF): tests/test-iov.o $(test-util-obj-y)
 tests/test-hbitmap$(EXESUF): tests/test-hbitmap.o $(test-util-obj-y) $(t=
est-crypto-obj-y)
--=20
2.19.1
