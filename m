Received: from eggs.gnu.org ([2001:4830:134:3::10]:55056)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1elDWF-0002FO-Kk
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 07:47:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1elDWE-0006NI-MM
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 07:47:39 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Mon, 12 Feb 2018 13:47:18 +0100
Message-Id: <20180212124718.21935-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH] iotests: Use virtio-blk in 155
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>

Only a few select machine types support floppy drives and there is
actually nothing preventing us from using virtio here, so let's do it.

Reported-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/155 | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/tests/qemu-iotests/155 b/tests/qemu-iotests/155
index fc9fa975be..42dae04c83 100755
--- a/tests/qemu-iotests/155
+++ b/tests/qemu-iotests/155
@@ -64,7 +64,7 @@ class BaseClass(iotests.QMPTestCase):
                     'file': {'driver': 'file',
                              'filename': source_img}}
         self.vm.add_blockdev(self.qmp_to_opts(blockdev))
-        self.vm.add_device('floppy,id=qdev0,drive=source')
+        self.vm.add_device('virtio-blk,id=qdev0,drive=source')
         self.vm.launch()
 
         self.assertIntactSourceBackingChain()
@@ -173,21 +173,24 @@ class MirrorBaseClass(BaseClass):
     def testFull(self):
         self.runMirror('full')
 
-        node = self.findBlockNode('target', 'qdev0')
+        node = self.findBlockNode('target',
+                                  '/machine/peripheral/qdev0/virtio-backend')
         self.assertCorrectBackingImage(node, None)
         self.assertIntactSourceBackingChain()
 
     def testTop(self):
         self.runMirror('top')
 
-        node = self.findBlockNode('target', 'qdev0')
+        node = self.findBlockNode('target',
+                                  '/machine/peripheral/qdev0/virtio-backend')
         self.assertCorrectBackingImage(node, back2_img)
         self.assertIntactSourceBackingChain()
 
     def testNone(self):
         self.runMirror('none')
 
-        node = self.findBlockNode('target', 'qdev0')
+        node = self.findBlockNode('target',
+                                  '/machine/peripheral/qdev0/virtio-backend')
         self.assertCorrectBackingImage(node, source_img)
         self.assertIntactSourceBackingChain()
 
@@ -239,7 +242,8 @@ class TestCommit(BaseClass):
 
         self.vm.event_wait('BLOCK_JOB_COMPLETED')
 
-        node = self.findBlockNode(None, 'qdev0')
+        node = self.findBlockNode(None,
+                                  '/machine/peripheral/qdev0/virtio-backend')
         self.assert_qmp(node, 'image' + '/backing-image' * 0 + '/filename',
                         back1_img)
         self.assert_qmp(node, 'image' + '/backing-image' * 1 + '/filename',
-- 
2.14.3
