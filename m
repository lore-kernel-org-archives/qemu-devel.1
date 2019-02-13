Received: from eggs.gnu.org ([209.51.188.92]:37732)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gu3Pl-0004iX-Q1
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 17:54:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gu3PJ-0006EW-T8
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 17:53:34 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Wed, 13 Feb 2019 23:53:06 +0100
Message-Id: <20190213225311.17876-8-mreitz@redhat.com>
In-Reply-To: <20190213225311.17876-1-mreitz@redhat.com>
References: <20190213225311.17876-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 07/12] iotests: Add tests for mirror
 @replaces loops
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

This adds two tests for cases where our old check_to_replace_node()
function failed to detect that executing this job with these parameters
would result in a cyclic graph.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 tests/qemu-iotests/041     | 124 +++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/041.out |   4 +-
 2 files changed, 126 insertions(+), 2 deletions(-)

diff --git a/tests/qemu-iotests/041 b/tests/qemu-iotests/041
index 26bf1701eb..0c1432f189 100755
--- a/tests/qemu-iotests/041
+++ b/tests/qemu-iotests/041
@@ -1067,5 +1067,129 @@ class TestOrphanedSource(iotests.QMPTestCase):
                              target=3D'dest-ro')
         self.assert_qmp(result, 'error/class', 'GenericError')
=20
+# Various tests for the @replaces option (independent of quorum)
+class TestReplaces(iotests.QMPTestCase):
+    def setUp(self):
+        self.vm =3D iotests.VM()
+        self.vm.launch()
+
+    def tearDown(self):
+        self.vm.shutdown()
+
+    def test_drive_mirror_loop(self):
+        qemu_img('create', '-f', iotests.imgfmt, test_img, '1M')
+
+        result =3D self.vm.qmp('object-add', qom_type=3D'throttle-group'=
, id=3D'tg')
+        self.assert_qmp(result, 'return', {})
+
+        result =3D self.vm.qmp('blockdev-add', **{
+                    'node-name': 'source',
+                    'driver': 'throttle',
+                    'throttle-group': 'tg',
+                    'file': {
+                        'node-name': 'filtered',
+                        'driver': iotests.imgfmt,
+                        'file': {
+                            'driver': 'file',
+                            'filename': test_img
+                        }
+                    }
+                })
+        self.assert_qmp(result, 'return', {})
+
+        # Mirror from @source to @target in sync=3Dnone, so that @source
+        # will be @target's backing file; but replace @filtered.
+        # Then, @target's backing file will be @source, whose backing
+        # file is now @target instead of @filtered.  That is a loop.
+        # (But apart from the loop, replacing @filtered instead of
+        # @source is fine, because both are just filtered versions of
+        # each other.)
+        result =3D self.vm.qmp('drive-mirror',
+                             job_id=3D'mirror',
+                             device=3D'source',
+                             target=3Dtarget_img,
+                             format=3Diotests.imgfmt,
+                             node_name=3D'target',
+                             sync=3D'none',
+                             replaces=3D'filtered')
+        if 'error' in result:
+            # This is the correct result
+            self.assert_qmp(result, 'error/class', 'GenericError')
+        else:
+            # This is wrong, but let's run it to the bitter conclusion
+            self.complete_and_wait(drive=3D'mirror')
+            # Fail for good measure, although qemu should have crashed
+            # anyway
+            self.fail('Loop creation was successful')
+
+        os.remove(test_img)
+        try:
+            os.remove(target_img)
+        except OSError:
+            pass
+
+    def test_blockdev_mirror_loop(self):
+        qemu_img('create', '-f', iotests.imgfmt, test_img, '1M')
+        qemu_img('create', '-f', iotests.imgfmt, target_img, '1M')
+
+        result =3D self.vm.qmp('object-add', qom_type=3D'throttle-group'=
, id=3D'tg')
+        self.assert_qmp(result, 'return', {})
+
+        result =3D self.vm.qmp('blockdev-add', **{
+                    'node-name': 'source',
+                    'driver': 'throttle',
+                    'throttle-group': 'tg',
+                    'file': {
+                        'node-name': 'middle',
+                        'driver': 'throttle',
+                        'throttle-group': 'tg',
+                        'file': {
+                            'node-name': 'bottom',
+                            'driver': iotests.imgfmt,
+                            'file': {
+                                'driver': 'file',
+                                'filename': test_img
+                            }
+                        }
+                    }
+                })
+        self.assert_qmp(result, 'return', {})
+
+        result =3D self.vm.qmp('blockdev-add', **{
+                    'node-name': 'target',
+                    'driver': iotests.imgfmt,
+                    'file': {
+                        'driver': 'file',
+                        'filename': target_img
+                    },
+                    'backing': 'middle'
+                })
+
+        # Mirror from @source to @target.  With blockdev-mirror, the
+        # current (old) backing file is retained (which is @middle).
+        # By replacing @bottom, @middle's file will be @target, whose
+        # backing file is @middle again.  That is a loop.
+        # (But apart from the loop, replacing @bottom instead of
+        # @source is fine, because both are just filtered versions of
+        # each other.)
+        result =3D self.vm.qmp('blockdev-mirror',
+                             job_id=3D'mirror',
+                             device=3D'source',
+                             target=3D'target',
+                             sync=3D'full',
+                             replaces=3D'bottom')
+        if 'error' in result:
+            # This is the correct result
+            self.assert_qmp(result, 'error/class', 'GenericError')
+        else:
+            # This is wrong, but let's run it to the bitter conclusion
+            self.complete_and_wait(drive=3D'mirror')
+            # Fail for good measure, although qemu should have crashed
+            # anyway
+            self.fail('Loop creation was successful')
+
+        os.remove(test_img)
+        os.remove(target_img)
+
 if __name__ =3D=3D '__main__':
     iotests.main(supported_fmts=3D['qcow2', 'qed'])
diff --git a/tests/qemu-iotests/041.out b/tests/qemu-iotests/041.out
index e071d0b261..2c448b4239 100644
--- a/tests/qemu-iotests/041.out
+++ b/tests/qemu-iotests/041.out
@@ -1,5 +1,5 @@
-........................................................................=
................
+........................................................................=
..................
 ----------------------------------------------------------------------
-Ran 88 tests
+Ran 90 tests
=20
 OK
--=20
2.20.1
