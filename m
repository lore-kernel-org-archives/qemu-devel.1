Received: from eggs.gnu.org ([209.51.188.92]:38360)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gu3QI-0005DI-CG
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 17:54:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gu3QG-0007Er-FJ
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 17:54:34 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Wed, 13 Feb 2019 23:53:08 +0100
Message-Id: <20190213225311.17876-10-mreitz@redhat.com>
In-Reply-To: <20190213225311.17876-1-mreitz@redhat.com>
References: <20190213225311.17876-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 09/12] iotests: Add filter commit test cases
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

This patch adds some tests on how commit copes with filter nodes.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/040     | 130 +++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/040.out |   4 +-
 2 files changed, 132 insertions(+), 2 deletions(-)

diff --git a/tests/qemu-iotests/040 b/tests/qemu-iotests/040
index b81133a474..dc3fe57fbd 100755
--- a/tests/qemu-iotests/040
+++ b/tests/qemu-iotests/040
@@ -394,5 +394,135 @@ class TestReopenOverlay(ImageCommitTestCase):
     def test_reopen_overlay(self):
         self.run_commit_test(self.img1, self.img0)
=20
+class TestCommitWithFilters(iotests.QMPTestCase):
+    img0 =3D os.path.join(iotests.test_dir, '0.img')
+    img1 =3D os.path.join(iotests.test_dir, '1.img')
+    img2 =3D os.path.join(iotests.test_dir, '2.img')
+    img3 =3D os.path.join(iotests.test_dir, '3.img')
+
+    def setUp(self):
+        qemu_img('create', '-f', iotests.imgfmt, self.img0, '1M')
+        qemu_img('create', '-f', iotests.imgfmt, self.img1, '1M')
+        qemu_img('create', '-f', iotests.imgfmt, self.img2, '1M')
+        qemu_img('create', '-f', iotests.imgfmt, self.img3, '1M')
+
+        self.vm =3D iotests.VM()
+        self.vm.launch()
+        result =3D self.vm.qmp('object-add', qom_type=3D'throttle-group'=
, id=3D'tg')
+        self.assert_qmp(result, 'return', {})
+
+        result =3D self.vm.qmp('blockdev-add', **{
+                'node-name': 'top-filter',
+                'driver': 'throttle',
+                'throttle-group': 'tg',
+                'file': {
+                    'node-name': 'cow-3',
+                    'driver': iotests.imgfmt,
+                    'file': {
+                        'driver': 'file',
+                        'filename': self.img3
+                    },
+                    'backing': {
+                        'node-name': 'cow-2',
+                        'driver': iotests.imgfmt,
+                        'file': {
+                            'driver': 'file',
+                            'filename': self.img2
+                        },
+                        'backing': {
+                            'node-name': 'cow-1',
+                            'driver': iotests.imgfmt,
+                            'file': {
+                                'driver': 'file',
+                                'filename': self.img1
+                            },
+                            'backing': {
+                                'node-name': 'bottom-filter',
+                                'driver': 'throttle',
+                                'throttle-group': 'tg',
+                                'file': {
+                                    'node-name': 'cow-0',
+                                    'driver': iotests.imgfmt,
+                                    'file': {
+                                        'driver': 'file',
+                                        'filename': self.img0
+                                    }
+                                }
+                            }
+                        }
+                    }
+                }
+            })
+        self.assert_qmp(result, 'return', {})
+
+    def tearDown(self):
+        self.vm.shutdown()
+        os.remove(self.img3)
+        os.remove(self.img2)
+        os.remove(self.img1)
+        os.remove(self.img0)
+
+    # Filters make for funny filenames, so we cannot just use
+    # self.imgX for the block-commit parameters
+    def get_filename(self, node):
+        return self.vm.node_info(node)['image']['filename']
+
+    def test_filterless_commit(self):
+        self.assert_no_active_block_jobs()
+        result =3D self.vm.qmp('block-commit',
+                             job_id=3D'commit',
+                             device=3D'top-filter',
+                             top=3Dself.get_filename('cow-2'),
+                             base=3Dself.get_filename('cow-1'))
+        self.assert_qmp(result, 'return', {})
+        self.wait_until_completed(drive=3D'commit')
+
+    def test_commit_through_filter(self):
+        self.assert_no_active_block_jobs()
+        result =3D self.vm.qmp('block-commit',
+                             job_id=3D'commit',
+                             device=3D'top-filter',
+                             top=3Dself.get_filename('cow-1'),
+                             base=3Dself.get_filename('cow-0'))
+        # Cannot commit through explicitly added filters (yet,
+        # although in the future we probably want to make users use
+        # blockdev-copy for this)
+        self.assert_qmp(result, 'error/class', 'GenericError')
+        self.assert_qmp(result, 'error/desc', 'Cannot commit through exp=
licit filter nodes')
+
+    def test_filtered_active_commit_with_filter(self):
+        self.assert_no_active_block_jobs()
+        result =3D self.vm.qmp('block-commit',
+                             job_id=3D'commit',
+                             device=3D'top-filter',
+                             base=3Dself.get_filename('cow-2'))
+        # Not specifying @top means active commit, so including the
+        # filter on top (which is not allowed right now)
+        self.assert_qmp(result, 'error/class', 'GenericError')
+        self.assert_qmp(result, 'error/desc', 'Cannot commit through exp=
licit filter nodes')
+
+    def test_filtered_active_commit_without_filter(self):
+        cow3_name =3D self.get_filename('cow-3')
+
+        self.assert_no_active_block_jobs()
+        result =3D self.vm.qmp('block-commit',
+                             job_id=3D'commit',
+                             device=3D'top-filter',
+                             top=3Dcow3_name,
+                             base=3Dself.get_filename('cow-2'))
+        # This is how you'd want to specify committing img3 into img2
+        # disregarding the filter on top of img3 -- but that does not
+        # work, because you can only specify names of backing files
+        # (and img3 is not a backing file).  The solution for this
+        # would be for block-commit to accept node names.
+        # Note that even if it did work, the above command would
+        # result in a non-active commit, because img3 is not the top
+        # node.  Which is wrong, because img3 can still be written to,
+        # so it should be an active commit, but that is a different
+        # story.
+        self.assert_qmp(result, 'error/class', 'GenericError')
+        self.assert_qmp(result, 'error/desc',
+                        'Top image file %s not found' % cow3_name)
+
 if __name__ =3D=3D '__main__':
     iotests.main(supported_fmts=3D['qcow2', 'qed'])
diff --git a/tests/qemu-iotests/040.out b/tests/qemu-iotests/040.out
index 802ffaa0c0..220a5fa82c 100644
--- a/tests/qemu-iotests/040.out
+++ b/tests/qemu-iotests/040.out
@@ -1,5 +1,5 @@
-...........................................
+...............................................
 ----------------------------------------------------------------------
-Ran 43 tests
+Ran 47 tests
=20
 OK
--=20
2.20.1
