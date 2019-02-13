Received: from eggs.gnu.org ([209.51.188.92]:38331)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gu3QG-0005DG-K0
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 17:54:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gu3QE-0007B7-Hk
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 17:54:32 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Wed, 13 Feb 2019 23:53:11 +0100
Message-Id: <20190213225311.17876-13-mreitz@redhat.com>
In-Reply-To: <20190213225311.17876-1-mreitz@redhat.com>
References: <20190213225311.17876-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 12/12] iotests: Test committing to
 overridden backing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/040     | 61 ++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/040.out |  4 +--
 2 files changed, 63 insertions(+), 2 deletions(-)

diff --git a/tests/qemu-iotests/040 b/tests/qemu-iotests/040
index dc3fe57fbd..155c1d8c23 100755
--- a/tests/qemu-iotests/040
+++ b/tests/qemu-iotests/040
@@ -524,5 +524,66 @@ class TestCommitWithFilters(iotests.QMPTestCase):
         self.assert_qmp(result, 'error/desc',
                         'Top image file %s not found' % cow3_name)
=20
+class TestCommitWithOverriddenBacking(iotests.QMPTestCase):
+    img_base_a =3D os.path.join(iotests.test_dir, 'base_a.img')
+    img_base_b =3D os.path.join(iotests.test_dir, 'base_b.img')
+    img_top =3D os.path.join(iotests.test_dir, 'top.img')
+
+    def setUp(self):
+        qemu_img('create', '-f', iotests.imgfmt, self.img_base_a, '1M')
+        qemu_img('create', '-f', iotests.imgfmt, self.img_base_b, '1M')
+        qemu_img('create', '-f', iotests.imgfmt, '-b', self.img_base_a, =
\
+                 self.img_top)
+
+        self.vm =3D iotests.VM()
+        self.vm.launch()
+
+        # Use base_b instead of base_a as the backing of top
+        result =3D self.vm.qmp('blockdev-add', **{
+                                'node-name': 'top',
+                                'driver': iotests.imgfmt,
+                                'file': {
+                                    'driver': 'file',
+                                    'filename': self.img_top
+                                },
+                                'backing': {
+                                    'node-name': 'base',
+                                    'driver': iotests.imgfmt,
+                                    'file': {
+                                        'driver': 'file',
+                                        'filename': self.img_base_b
+                                    }
+                                }
+                            })
+        self.assert_qmp(result, 'return', {})
+
+    def tearDown(self):
+        self.vm.shutdown()
+        os.remove(self.img_top)
+        os.remove(self.img_base_a)
+        os.remove(self.img_base_b)
+
+    def test_commit_to_a(self):
+        # Try committing to base_a (which should fail, as top's
+        # backing image is base_b instead)
+        result =3D self.vm.qmp('block-commit',
+                             job_id=3D'commit',
+                             device=3D'top',
+                             base=3Dself.img_base_a)
+        self.assert_qmp(result, 'error/class', 'GenericError')
+
+    def test_commit_to_b(self):
+        # Try committing to base_b (which should work, since that is
+        # actually top's backing image)
+        result =3D self.vm.qmp('block-commit',
+                             job_id=3D'commit',
+                             device=3D'top',
+                             base=3Dself.img_base_b)
+        self.assert_qmp(result, 'return', {})
+
+        self.vm.event_wait('BLOCK_JOB_READY')
+        self.vm.qmp('block-job-complete', device=3D'commit')
+        self.vm.event_wait('BLOCK_JOB_COMPLETED')
+
 if __name__ =3D=3D '__main__':
     iotests.main(supported_fmts=3D['qcow2', 'qed'])
diff --git a/tests/qemu-iotests/040.out b/tests/qemu-iotests/040.out
index 220a5fa82c..bbcbc202a0 100644
--- a/tests/qemu-iotests/040.out
+++ b/tests/qemu-iotests/040.out
@@ -1,5 +1,5 @@
-...............................................
+.................................................
 ----------------------------------------------------------------------
-Ran 47 tests
+Ran 49 tests
=20
 OK
--=20
2.20.1
