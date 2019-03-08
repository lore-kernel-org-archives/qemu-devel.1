Received: from eggs.gnu.org ([209.51.188.92]:44919)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1h2M7L-0000u8-OH
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 15:29:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1h2M7J-0006xB-3N
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 15:29:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55640)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1h2M7G-0006oV-UT
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 15:29:15 -0500
From: John Snow <jsnow@redhat.com>
Date: Fri,  8 Mar 2019 15:28:51 -0500
Message-Id: <20190308202858.26636-11-jsnow@redhat.com>
In-Reply-To: <20190308202858.26636-1-jsnow@redhat.com>
References: <20190308202858.26636-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PULL 10/17] iotests: add busy/recording bit test to
 124
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com, peter.maydell@linaro.org

This adds a simple test that ensures the busy bit works for push backups,
as well as doubling as bonus test for incremental backups that get interrupted
by EIO errors.

Recording bit tests are already handled sufficiently by 236.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Tested-by: Eric Blake <eblake@redhat.com>
Message-id: 20190223000614.13894-11-jsnow@redhat.com
Signed-off-by: John Snow <jsnow@redhat.com>
---
 tests/qemu-iotests/124     | 113 +++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/124.out |   4 +-
 2 files changed, 115 insertions(+), 2 deletions(-)

diff --git a/tests/qemu-iotests/124 b/tests/qemu-iotests/124
index 5aa1bf1bd6..80b356f7bb 100755
--- a/tests/qemu-iotests/124
+++ b/tests/qemu-iotests/124
@@ -634,6 +634,119 @@ class TestIncrementalBackupBlkdebug(TestIncrementalBackupBase):
         self.vm.shutdown()
         self.check_backups()
 
+    def test_incremental_pause(self):
+        """
+        Test an incremental backup that errors into a pause and is resumed.
+        """
+
+        drive0 = self.drives[0]
+        # NB: The blkdebug script here looks for a "flush, read, read" pattern.
+        # The flush occurs in hmp_io_writes, the first read in device_add, and
+        # the last read during the block job.
+        result = self.vm.qmp('blockdev-add',
+                             node_name=drive0['id'],
+                             driver=drive0['fmt'],
+                             file={
+                                 'driver': 'blkdebug',
+                                 'image': {
+                                     'driver': 'file',
+                                     'filename': drive0['file']
+                                 },
+                                 'set-state': [{
+                                     'event': 'flush_to_disk',
+                                     'state': 1,
+                                     'new_state': 2
+                                 },{
+                                     'event': 'read_aio',
+                                     'state': 2,
+                                     'new_state': 3
+                                 }],
+                                 'inject-error': [{
+                                     'event': 'read_aio',
+                                     'errno': 5,
+                                     'state': 3,
+                                     'immediately': False,
+                                     'once': True
+                                 }],
+                             })
+        self.assert_qmp(result, 'return', {})
+        self.create_anchor_backup(drive0)
+        bitmap = self.add_bitmap('bitmap0', drive0)
+
+        # Emulate guest activity
+        self.hmp_io_writes(drive0['id'], (('0xab', 0, 512),
+                                          ('0xfe', '16M', '256k'),
+                                          ('0x64', '32736k', '64k')))
+
+        # For the purposes of query-block visibility of bitmaps, add a drive
+        # frontend after we've written data; otherwise we can't use hmp-io
+        result = self.vm.qmp("device_add",
+                             id="device0",
+                             drive=drive0['id'],
+                             driver="virtio-blk")
+        self.assert_qmp(result, 'return', {})
+
+        # Bitmap Status Check
+        query = self.vm.qmp('query-block')
+        ret = [bmap for bmap in query['return'][0]['dirty-bitmaps']
+               if bmap.get('name') == bitmap.name][0]
+        self.assert_qmp(ret, 'count', 458752)
+        self.assert_qmp(ret, 'granularity', 65536)
+        self.assert_qmp(ret, 'status', 'active')
+        self.assert_qmp(ret, 'busy', False)
+        self.assert_qmp(ret, 'recording', True)
+
+        # Start backup
+        parent, _ = bitmap.last_target()
+        target = self.prepare_backup(bitmap, parent)
+        res = self.vm.qmp('drive-backup',
+                          job_id=bitmap.drive['id'],
+                          device=bitmap.drive['id'],
+                          sync='incremental',
+                          bitmap=bitmap.name,
+                          format=bitmap.drive['fmt'],
+                          target=target,
+                          mode='existing',
+                          on_source_error='stop')
+        self.assert_qmp(res, 'return', {})
+
+        # Wait for the error
+        event = self.vm.event_wait(name="BLOCK_JOB_ERROR",
+                                   match={"data":{"device":bitmap.drive['id']}})
+        self.assert_qmp(event, 'data', {'device': bitmap.drive['id'],
+                                        'action': 'stop',
+                                        'operation': 'read'})
+
+        # Bitmap Status Check
+        query = self.vm.qmp('query-block')
+        ret = [bmap for bmap in query['return'][0]['dirty-bitmaps']
+               if bmap.get('name') == bitmap.name][0]
+        self.assert_qmp(ret, 'count', 458752)
+        self.assert_qmp(ret, 'granularity', 65536)
+        self.assert_qmp(ret, 'status', 'frozen')
+        self.assert_qmp(ret, 'busy', True)
+        self.assert_qmp(ret, 'recording', True)
+
+        # Resume and check incremental backup for consistency
+        res = self.vm.qmp('block-job-resume', device=bitmap.drive['id'])
+        self.assert_qmp(res, 'return', {})
+        self.wait_qmp_backup(bitmap.drive['id'])
+
+        # Bitmap Status Check
+        query = self.vm.qmp('query-block')
+        ret = [bmap for bmap in query['return'][0]['dirty-bitmaps']
+               if bmap.get('name') == bitmap.name][0]
+        self.assert_qmp(ret, 'count', 0)
+        self.assert_qmp(ret, 'granularity', 65536)
+        self.assert_qmp(ret, 'status', 'active')
+        self.assert_qmp(ret, 'busy', False)
+        self.assert_qmp(ret, 'recording', True)
+
+        # Finalize / Cleanup
+        self.make_reference_backup(bitmap)
+        self.vm.shutdown()
+        self.check_backups()
+
 
 if __name__ == '__main__':
     iotests.main(supported_fmts=['qcow2'])
diff --git a/tests/qemu-iotests/124.out b/tests/qemu-iotests/124.out
index e56cae021b..281b69efea 100644
--- a/tests/qemu-iotests/124.out
+++ b/tests/qemu-iotests/124.out
@@ -1,5 +1,5 @@
-...........
+............
 ----------------------------------------------------------------------
-Ran 11 tests
+Ran 12 tests
 
 OK
-- 
2.17.2
