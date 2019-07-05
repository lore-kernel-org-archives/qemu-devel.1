Return-Path: <SRS0=wUMn=VC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF31CC46499
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 20:41:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CBCA216E3
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 20:41:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CBCA216E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjV0y-00049A-P9
	for qemu-devel@archiver.kernel.org; Fri, 05 Jul 2019 16:41:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33224)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jsnow@redhat.com>) id 1hjUep-0006Q2-U6
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 16:18:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1hjUei-0007ga-Af
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 16:18:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41992)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>)
 id 1hjUeT-0007VD-Io; Fri, 05 Jul 2019 16:17:49 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id DDC65C057F31;
 Fri,  5 Jul 2019 20:17:48 +0000 (UTC)
Received: from probe.redhat.com (ovpn-122-149.rdu2.redhat.com [10.10.122.149])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5CFDA867F8;
 Fri,  5 Jul 2019 20:17:45 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Date: Fri,  5 Jul 2019 16:16:30 -0400
Message-Id: <20190705201631.26266-18-jsnow@redhat.com>
In-Reply-To: <20190705201631.26266-1-jsnow@redhat.com>
References: <20190705201631.26266-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Fri, 05 Jul 2019 20:17:48 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3 17/18] iotests: add test 257 for bitmap-mode
 backups
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 vsementsov@virtuozzo.com, Juan Quintela <quintela@redhat.com>,
 Wen Congyang <wencongyang2@huawei.com>,
 Xie Changlong <xiechanglong.d@gmail.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, John Snow <jsnow@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: John Snow <jsnow@redhat.com>
---
 tests/qemu-iotests/257     |  409 +++++++
 tests/qemu-iotests/257.out | 2199 ++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/group   |    1 +
 3 files changed, 2609 insertions(+)
 create mode 100755 tests/qemu-iotests/257
 create mode 100644 tests/qemu-iotests/257.out

diff --git a/tests/qemu-iotests/257 b/tests/qemu-iotests/257
new file mode 100755
index 0000000000..fd3b3328d8
--- /dev/null
+++ b/tests/qemu-iotests/257
@@ -0,0 +1,409 @@
+#!/usr/bin/env python
+#
+# Test bitmap-sync backups (incremental, differential, and partials)
+#
+# Copyright (c) 2019 John Snow for Red Hat, Inc.
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 2 of the License, or
+# (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program.  If not, see <http://www.gnu.org/licenses/>.
+#
+# owner=3Djsnow@redhat.com
+
+from collections import namedtuple
+import math
+import os
+
+import iotests
+from iotests import log, qemu_img
+
+SIZE =3D 64 * 1024 * 1024
+GRANULARITY =3D 64 * 1024
+
+Pattern =3D namedtuple('Pattern', ['byte', 'offset', 'size'])
+def mkpattern(byte, offset, size=3DGRANULARITY):
+    """Constructor for Pattern() with default size"""
+    return Pattern(byte, offset, size)
+
+class PatternGroup:
+    """Grouping of Pattern objects. Initialize with an iterable of Patte=
rns."""
+    def __init__(self, patterns):
+        self.patterns =3D patterns
+
+    def bits(self, granularity):
+        """Calculate the unique bits dirtied by this pattern grouping"""
+        res =3D set()
+        for pattern in self.patterns:
+            lower =3D math.floor(pattern.offset / granularity)
+            upper =3D math.floor((pattern.offset + pattern.size - 1) / g=
ranularity)
+            res =3D res | set(range(lower, upper + 1))
+        return res
+
+GROUPS =3D [
+    PatternGroup([
+        # Batch 0: 4 clusters
+        mkpattern('0x49', 0x0000000),
+        mkpattern('0x6c', 0x0100000),   # 1M
+        mkpattern('0x6f', 0x2000000),   # 32M
+        mkpattern('0x76', 0x3ff0000)]), # 64M - 64K
+    PatternGroup([
+        # Batch 1: 6 clusters (3 new)
+        mkpattern('0x65', 0x0000000),   # Full overwrite
+        mkpattern('0x77', 0x00f8000),   # Partial-left (1M-32K)
+        mkpattern('0x72', 0x2008000),   # Partial-right (32M+32K)
+        mkpattern('0x69', 0x3fe0000)]), # Adjacent-left (64M - 128K)
+    PatternGroup([
+        # Batch 2: 7 clusters (3 new)
+        mkpattern('0x74', 0x0010000),   # Adjacent-right
+        mkpattern('0x69', 0x00e8000),   # Partial-left  (1M-96K)
+        mkpattern('0x6e', 0x2018000),   # Partial-right (32M+96K)
+        mkpattern('0x67', 0x3fe0000,
+                  2*GRANULARITY)]),     # Overwrite [(64M-128K)-64M)
+    PatternGroup([
+        # Batch 3: 8 clusters (5 new)
+        # Carefully chosen such that nothing re-dirties the one cluster
+        # that copies out successfully before failure in Group #1.
+        mkpattern('0xaa', 0x0010000,
+                  3*GRANULARITY),       # Overwrite and 2x Adjacent-righ=
t
+        mkpattern('0xbb', 0x00d8000),   # Partial-left (1M-160K)
+        mkpattern('0xcc', 0x2028000),   # Partial-right (32M+160K)
+        mkpattern('0xdd', 0x3fc0000)]), # New; leaving a gap to the righ=
t
+]
+
+class Drive:
+    """Represents, vaguely, a drive attached to a VM.
+    Includes format, graph, and device information."""
+
+    def __init__(self, path, vm=3DNone):
+        self.path =3D path
+        self.vm =3D vm
+        self.fmt =3D None
+        self.size =3D None
+        self.node =3D None
+        self.device =3D None
+
+    @property
+    def name(self):
+        return self.node or self.device
+
+    def img_create(self, fmt, size):
+        self.fmt =3D fmt
+        self.size =3D size
+        iotests.qemu_img_create('-f', self.fmt, self.path, str(self.size=
))
+
+    def create_target(self, name, fmt, size):
+        basename =3D os.path.basename(self.path)
+        file_node_name =3D "file_{}".format(basename)
+        vm =3D self.vm
+
+        log(vm.command('blockdev-create', job_id=3D'bdc-file-job',
+                       options=3D{
+                           'driver': 'file',
+                           'filename': self.path,
+                           'size': 0,
+                       }))
+        vm.run_job('bdc-file-job')
+        log(vm.command('blockdev-add', driver=3D'file',
+                       node_name=3Dfile_node_name, filename=3Dself.path)=
)
+
+        log(vm.command('blockdev-create', job_id=3D'bdc-fmt-job',
+                       options=3D{
+                           'driver': fmt,
+                           'file': file_node_name,
+                           'size': size,
+                       }))
+        vm.run_job('bdc-fmt-job')
+        log(vm.command('blockdev-add', driver=3Dfmt,
+                       node_name=3Dname,
+                       file=3Dfile_node_name))
+        self.fmt =3D fmt
+        self.size =3D size
+        self.node =3D name
+
+def query_bitmaps(vm):
+    res =3D vm.qmp("query-block")
+    return {"bitmaps": {device['device'] or device['qdev']:
+                        device.get('dirty-bitmaps', []) for
+                        device in res['return']}}
+
+def get_bitmap(bitmaps, drivename, name):
+    for bitmap in bitmaps['bitmaps'][drivename]:
+        if bitmap.get('name', '') =3D=3D name:
+            return bitmap
+    return None
+
+def reference_backup(drive, n, filepath):
+    log("--- Reference Backup #{:d} ---\n".format(n))
+    target_id =3D "ref_target_{:d}".format(n)
+    job_id =3D "ref_backup_{:d}".format(n)
+    target_drive =3D Drive(filepath, vm=3Ddrive.vm)
+
+    target_drive.create_target(target_id, drive.fmt, drive.size)
+    drive.vm.qmp_log("blockdev-backup",
+                     job_id=3Djob_id, device=3Ddrive.name,
+                     target=3Dtarget_id, sync=3D"full")
+    drive.vm.run_job(job_id, auto_dismiss=3DTrue)
+    log('')
+
+def bitmap_backup(drive, n, filepath, bitmap, bitmap_mode):
+    log("--- Bitmap Backup #{:d} ---\n".format(n))
+    target_id =3D "bitmap_target_{:d}".format(n)
+    job_id =3D "bitmap_backup_{:d}".format(n)
+    target_drive =3D Drive(filepath, vm=3Ddrive.vm)
+
+    target_drive.create_target(target_id, drive.fmt, drive.size)
+    drive.vm.qmp_log("blockdev-backup", job_id=3Djob_id, device=3Ddrive.=
name,
+                     target=3Dtarget_id, sync=3D"bitmap",
+                     bitmap_mode=3Dbitmap_mode,
+                     bitmap=3Dbitmap,
+                     auto_finalize=3DFalse)
+    return job_id
+
+def perform_writes(drive, n):
+    log("--- Write #{:d} ---\n".format(n))
+    for pattern in GROUPS[n].patterns:
+        cmd =3D "write -P{:s} 0x{:07x} 0x{:x}".format(
+            pattern.byte,
+            pattern.offset,
+            pattern.size)
+        log(cmd)
+        log(drive.vm.hmp_qemu_io(drive.name, cmd))
+    bitmaps =3D query_bitmaps(drive.vm)
+    log(bitmaps, indent=3D2)
+    log('')
+    return bitmaps
+
+def calculate_bits(groups=3DNone):
+    """Calculate how many bits we expect to see dirtied."""
+    if groups:
+        bits =3D set.union(*(GROUPS[group].bits(GRANULARITY) for group i=
n groups))
+        return len(bits)
+    return 0
+
+def bitmap_comparison(bitmap, groups=3DNone, want=3D0):
+    """
+    Print a nice human-readable message checking that this bitmap has as
+    many bits set as we expect it to.
+    """
+    log("=3D Checking Bitmap {:s} =3D".format(bitmap.get('name', '(anony=
mous)')))
+
+    if groups:
+        want =3D calculate_bits(groups)
+    have =3D bitmap['count'] // bitmap['granularity']
+
+    log("expecting {:d} dirty sectors; have {:d}. {:s}".format(
+        want, have, "OK!" if want =3D=3D have else "ERROR!"))
+    log('')
+
+def compare_images(image, reference, baseimg=3DNone, expected_match=3DTr=
ue):
+    """
+    Print a nice human-readable message comparing these images.
+    """
+    expected_ret =3D 0 if expected_match else 1
+    if baseimg:
+        assert qemu_img("rebase", "-u", "-b", baseimg, image) =3D=3D 0
+    ret =3D qemu_img("compare", image, reference)
+    log('qemu_img compare "{:s}" "{:s}" =3D=3D> {:s}, {:s}'.format(
+        image, reference,
+        "Identical" if ret =3D=3D 0 else "Mismatch",
+        "OK!" if ret =3D=3D expected_ret else "ERROR!"),
+        filters=3D[iotests.filter_testfiles])
+
+def test_bitmap_sync(bsync_mode, failure=3DNone):
+    """
+    Test bitmap backup routines.
+
+    :param bsync_mode: Is the Bitmap Sync mode, and can be any of:
+        - on-success: This is the "incremental" style mode. Bitmaps are
+                      synchronized to what was copied out only on succes=
s.
+                      (Partial images must be discarded.)
+        - never:      This is the "differential" style mode.
+                      Bitmaps are never synchronized.
+        - always:     This is a "best effort" style mode.
+                      Bitmaps are always synchronized, regardless of fai=
lure.
+                      (Partial images must be kept.)
+
+    :param failure: Is the (optional) failure mode, and can be any of:
+        - None:         No failure. Test the normative path. Default.
+        - simulated:    Cancel the job right before it completes.
+                        This also tests writes "during" the job.
+        - intermediate: This tests a job that fails mid-process and prod=
uces
+                        an incomplete backup. Testing limitations preven=
t
+                        testing competing writes.
+    """
+    with iotests.FilePaths(['img', 'bsync1', 'bsync2',
+                            'fbackup0', 'fbackup1', 'fbackup2']) as \
+                            (img_path, bsync1, bsync2,
+                             fbackup0, fbackup1, fbackup2), \
+         iotests.VM() as vm:
+
+        mode =3D "Bitmap Sync Mode {:s}".format(bsync_mode)
+        preposition =3D "with" if failure else "without"
+        cond =3D "{:s} {:s}".format(preposition,
+                                  "{:s} failure".format(failure) if fail=
ure
+                                  else "failure")
+        log("\n=3D=3D=3D {:s} {:s} =3D=3D=3D\n".format(mode, cond))
+
+        log('--- Preparing image & VM ---\n')
+        drive0 =3D Drive(img_path, vm=3Dvm)
+        drive0.img_create(iotests.imgfmt, SIZE)
+        vm.add_device("{},id=3Dscsi0".format(iotests.get_virtio_scsi_dev=
ice()))
+        vm.launch()
+
+        file_config =3D {
+            'driver': 'file',
+            'filename': drive0.path
+        }
+
+        if failure =3D=3D 'intermediate':
+            file_config =3D {
+                'driver': 'blkdebug',
+                'image': file_config,
+                'set-state': [{
+                    'event': 'flush_to_disk',
+                    'state': 1,
+                    'new_state': 2
+                }, {
+                    'event': 'read_aio',
+                    'state': 2,
+                    'new_state': 3
+                }],
+                'inject-error': [{
+                    'event': 'read_aio',
+                    'errno': 5,
+                    'state': 3,
+                    'immediately': False,
+                    'once': True
+                }]
+            }
+
+        vm.qmp_log('blockdev-add',
+                   filters=3D[iotests.filter_qmp_testfiles],
+                   node_name=3D"drive0",
+                   driver=3Ddrive0.fmt,
+                   file=3Dfile_config)
+        drive0.node =3D 'drive0'
+        drive0.device =3D 'device0'
+        # Use share-rw to allow writes directly to the node;
+        # The anonymous block-backend for this configuration prevents us
+        # from using HMP's qemu-io commands to address the device.
+        vm.qmp_log("device_add", id=3Ddrive0.device,
+                   drive=3Ddrive0.name, driver=3D"scsi-hd",
+                   share_rw=3DTrue)
+        log('')
+
+        # 0 - Writes and Reference Backup
+        perform_writes(drive0, 0)
+        reference_backup(drive0, 0, fbackup0)
+        log('--- Add Bitmap ---\n')
+        vm.qmp_log("block-dirty-bitmap-add", node=3Ddrive0.name,
+                   name=3D"bitmap0", granularity=3DGRANULARITY)
+        log('')
+
+        # 1 - Writes and Reference Backup
+        bitmaps =3D perform_writes(drive0, 1)
+        dirty_groups =3D {1}
+        bitmap =3D get_bitmap(bitmaps, drive0.device, 'bitmap0')
+        bitmap_comparison(bitmap, groups=3Ddirty_groups)
+        reference_backup(drive0, 1, fbackup1)
+
+        # 1 - Bitmap Backup (Optional induced failure)
+        if failure =3D=3D 'intermediate':
+            # Activate blkdebug induced failure for second-to-next read
+            log(vm.hmp_qemu_io(drive0.name, 'flush'))
+            log('')
+        job =3D bitmap_backup(drive0, 1, bsync1, "bitmap0", bsync_mode)
+
+        def _callback():
+            """Issue writes while the job is open to test bitmap diverge=
nce."""
+            # Note: when `failure` is 'intermediate', this isn't called.
+            log('')
+            bitmaps =3D perform_writes(drive0, 2)
+            # Named bitmap (static, should be unchanged)
+            bitmap_comparison(get_bitmap(bitmaps, drive0.device, 'bitmap=
0'),
+                              groups=3Ddirty_groups)
+            # Anonymous bitmap (dynamic, shows new writes)
+            bitmap_comparison(get_bitmap(bitmaps, drive0.device, ''),
+                              groups=3D{2})
+            dirty_groups.add(2)
+
+        vm.run_job(job, auto_dismiss=3DTrue, auto_finalize=3DFalse,
+                   pre_finalize=3D_callback,
+                   cancel=3D(failure =3D=3D 'simulated'))
+        bitmaps =3D query_bitmaps(vm)
+        bitmap =3D get_bitmap(bitmaps, drive0.device, 'bitmap0')
+        log(bitmaps, indent=3D2)
+        log('')
+
+        if ((bsync_mode =3D=3D 'on-success' and not failure) or
+                (bsync_mode =3D=3D 'always' and failure !=3D 'intermedia=
te')):
+            dirty_groups.remove(1)
+
+        if bsync_mode =3D=3D 'always' and failure =3D=3D 'intermediate':
+            # We manage to copy one sector (one bit) before the error.
+            bitmap_comparison(bitmap,
+                              want=3Dcalculate_bits(groups=3Ddirty_group=
s) - 1)
+        else:
+            bitmap_comparison(bitmap, groups=3Ddirty_groups)
+
+        # 2 - Writes and Reference Backup
+        bitmaps =3D perform_writes(drive0, 3)
+        dirty_groups.add(3)
+        bitmap =3D get_bitmap(bitmaps, drive0.device, 'bitmap0')
+        if bsync_mode =3D=3D 'always' and failure =3D=3D 'intermediate':
+            # We're one bit short, still.
+            bitmap_comparison(bitmap,
+                              want=3Dcalculate_bits(groups=3Ddirty_group=
s) - 1)
+        else:
+            bitmap_comparison(bitmap, groups=3Ddirty_groups)
+        reference_backup(drive0, 2, fbackup2)
+
+        # 2 - Bitmap Backup (In failure modes, this is a recovery.)
+        job =3D bitmap_backup(drive0, 2, bsync2, "bitmap0", bsync_mode)
+        vm.run_job(job, auto_dismiss=3DTrue, auto_finalize=3DFalse)
+        bitmaps =3D query_bitmaps(vm)
+        bitmap =3D get_bitmap(bitmaps, drive0.device, 'bitmap0')
+        log(bitmaps, indent=3D2)
+        log('')
+        bitmap_comparison(bitmap, groups=3D{}
+                          if bsync_mode !=3D 'never'
+                          else dirty_groups)
+
+        log('--- Cleanup ---\n')
+        vm.qmp_log("block-dirty-bitmap-remove",
+                   node=3Ddrive0.name, name=3D"bitmap0")
+        log(query_bitmaps(vm), indent=3D2)
+        vm.shutdown()
+        log('')
+
+        log('--- Verification ---\n')
+        # 'simulated' failures will actually all pass here because we ca=
nceled
+        # while "pending". This is actually undefined behavior,
+        # don't rely on this to be true!
+        compare_images(bsync1, fbackup1, baseimg=3Dfbackup0,
+                       expected_match=3Dfailure !=3D 'intermediate')
+        if not failure or bsync_mode =3D=3D 'always':
+            # Always keep the last backup on success or when using 'alwa=
ys'
+            base =3D bsync1
+        else:
+            base =3D fbackup0
+        compare_images(bsync2, fbackup2, baseimg=3Dbase)
+        compare_images(img_path, fbackup2)
+        log('')
+
+def main():
+    for bsync_mode in ("never", "on-success", "always"):
+        for failure in ("simulated", "intermediate", None):
+            test_bitmap_sync(bsync_mode, failure)
+
+if __name__ =3D=3D '__main__':
+    iotests.script_main(main, supported_fmts=3D['qcow2'])
diff --git a/tests/qemu-iotests/257.out b/tests/qemu-iotests/257.out
new file mode 100644
index 0000000000..12cdd788e3
--- /dev/null
+++ b/tests/qemu-iotests/257.out
@@ -0,0 +1,2199 @@
+
+=3D=3D=3D Bitmap Sync Mode never with simulated failure =3D=3D=3D
+
+--- Preparing image & VM ---
+
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"d=
river": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
+{"return": {}}
+{"execute": "device_add", "arguments": {"drive": "drive0", "driver": "sc=
si-hd", "id": "device0", "share-rw": true}}
+{"return": {}}
+
+--- Write #0 ---
+
+write -P0x49 0x0000000 0x10000
+{"return": ""}
+write -P0x6c 0x0100000 0x10000
+{"return": ""}
+write -P0x6f 0x2000000 0x10000
+{"return": ""}
+write -P0x76 0x3ff0000 0x10000
+{"return": ""}
+{
+  "bitmaps": {
+    "device0": []
+  }
+}
+
+--- Reference Backup #0 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id=
": "ref_backup_0", "sync": "full", "target": "ref_target_0"}}
+{"return": {}}
+{"data": {"device": "ref_backup_0", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
+
+--- Add Bitmap ---
+
+{"execute": "block-dirty-bitmap-add", "arguments": {"granularity": 65536=
, "name": "bitmap0", "node": "drive0"}}
+{"return": {}}
+
+--- Write #1 ---
+
+write -P0x65 0x0000000 0x10000
+{"return": ""}
+write -P0x77 0x00f8000 0x10000
+{"return": ""}
+write -P0x72 0x2008000 0x10000
+{"return": ""}
+write -P0x69 0x3fe0000 0x10000
+{"return": ""}
+{
+  "bitmaps": {
+    "device0": [
+      {
+        "busy": false,
+        "count": 393216,
+        "granularity": 65536,
+        "name": "bitmap0",
+        "persistent": false,
+        "recording": true,
+        "status": "active"
+      }
+    ]
+  }
+}
+
+=3D Checking Bitmap bitmap0 =3D
+expecting 6 dirty sectors; have 6. OK!
+
+--- Reference Backup #1 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id=
": "ref_backup_1", "sync": "full", "target": "ref_target_1"}}
+{"return": {}}
+{"data": {"device": "ref_backup_1", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
+
+--- Bitmap Backup #1 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "never", "device": "drive0", "job-id": "=
bitmap_backup_1", "sync": "bitmap", "target": "bitmap_target_1"}}
+{"return": {}}
+
+--- Write #2 ---
+
+write -P0x74 0x0010000 0x10000
+{"return": ""}
+write -P0x69 0x00e8000 0x10000
+{"return": ""}
+write -P0x6e 0x2018000 0x10000
+{"return": ""}
+write -P0x67 0x3fe0000 0x20000
+{"return": ""}
+{
+  "bitmaps": {
+    "device0": [
+      {
+        "busy": false,
+        "count": 458752,
+        "granularity": 65536,
+        "persistent": false,
+        "recording": true,
+        "status": "active"
+      },
+      {
+        "busy": true,
+        "count": 393216,
+        "granularity": 65536,
+        "name": "bitmap0",
+        "persistent": false,
+        "recording": true,
+        "status": "frozen"
+      }
+    ]
+  }
+}
+
+=3D Checking Bitmap bitmap0 =3D
+expecting 6 dirty sectors; have 6. OK!
+
+=3D Checking Bitmap (anonymous) =3D
+expecting 7 dirty sectors; have 7. OK!
+
+{"execute": "job-cancel", "arguments": {"id": "bitmap_backup_1"}}
+{"return": {}}
+{"data": {"id": "bitmap_backup_1", "type": "backup"}, "event": "BLOCK_JO=
B_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "bitmap_backup_1", "len": 67108864, "offset": 671088=
64, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_CANCELLED", "times=
tamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{
+  "bitmaps": {
+    "device0": [
+      {
+        "busy": false,
+        "count": 655360,
+        "granularity": 65536,
+        "name": "bitmap0",
+        "persistent": false,
+        "recording": true,
+        "status": "active"
+      }
+    ]
+  }
+}
+
+=3D Checking Bitmap bitmap0 =3D
+expecting 10 dirty sectors; have 10. OK!
+
+--- Write #3 ---
+
+write -P0xaa 0x0010000 0x30000
+{"return": ""}
+write -P0xbb 0x00d8000 0x10000
+{"return": ""}
+write -P0xcc 0x2028000 0x10000
+{"return": ""}
+write -P0xdd 0x3fc0000 0x10000
+{"return": ""}
+{
+  "bitmaps": {
+    "device0": [
+      {
+        "busy": false,
+        "count": 983040,
+        "granularity": 65536,
+        "name": "bitmap0",
+        "persistent": false,
+        "recording": true,
+        "status": "active"
+      }
+    ]
+  }
+}
+
+=3D Checking Bitmap bitmap0 =3D
+expecting 15 dirty sectors; have 15. OK!
+
+--- Reference Backup #2 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id=
": "ref_backup_2", "sync": "full", "target": "ref_target_2"}}
+{"return": {}}
+{"data": {"device": "ref_backup_2", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
+
+--- Bitmap Backup #2 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "never", "device": "drive0", "job-id": "=
bitmap_backup_2", "sync": "bitmap", "target": "bitmap_target_2"}}
+{"return": {}}
+{"execute": "job-finalize", "arguments": {"id": "bitmap_backup_2"}}
+{"return": {}}
+{"data": {"id": "bitmap_backup_2", "type": "backup"}, "event": "BLOCK_JO=
B_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "bitmap_backup_2", "len": 67108864, "offset": 671088=
64, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "times=
tamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{
+  "bitmaps": {
+    "device0": [
+      {
+        "busy": false,
+        "count": 983040,
+        "granularity": 65536,
+        "name": "bitmap0",
+        "persistent": false,
+        "recording": true,
+        "status": "active"
+      }
+    ]
+  }
+}
+
+=3D Checking Bitmap bitmap0 =3D
+expecting 15 dirty sectors; have 15. OK!
+
+--- Cleanup ---
+
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "bitmap0"=
, "node": "drive0"}}
+{"return": {}}
+{
+  "bitmaps": {
+    "device0": []
+  }
+}
+
+--- Verification ---
+
+qemu_img compare "TEST_DIR/PID-bsync1" "TEST_DIR/PID-fbackup1" =3D=3D> I=
dentical, OK!
+qemu_img compare "TEST_DIR/PID-bsync2" "TEST_DIR/PID-fbackup2" =3D=3D> I=
dentical, OK!
+qemu_img compare "TEST_DIR/PID-img" "TEST_DIR/PID-fbackup2" =3D=3D> Iden=
tical, OK!
+
+
+=3D=3D=3D Bitmap Sync Mode never with intermediate failure =3D=3D=3D
+
+--- Preparing image & VM ---
+
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"d=
river": "blkdebug", "image": {"driver": "file", "filename": "TEST_DIR/PID=
-img"}, "inject-error": [{"errno": 5, "event": "read_aio", "immediately":=
 false, "once": true, "state": 3}], "set-state": [{"event": "flush_to_dis=
k", "new-state": 2, "state": 1}, {"event": "read_aio", "new-state": 3, "s=
tate": 2}]}, "node-name": "drive0"}}
+{"return": {}}
+{"execute": "device_add", "arguments": {"drive": "drive0", "driver": "sc=
si-hd", "id": "device0", "share-rw": true}}
+{"return": {}}
+
+--- Write #0 ---
+
+write -P0x49 0x0000000 0x10000
+{"return": ""}
+write -P0x6c 0x0100000 0x10000
+{"return": ""}
+write -P0x6f 0x2000000 0x10000
+{"return": ""}
+write -P0x76 0x3ff0000 0x10000
+{"return": ""}
+{
+  "bitmaps": {
+    "device0": []
+  }
+}
+
+--- Reference Backup #0 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id=
": "ref_backup_0", "sync": "full", "target": "ref_target_0"}}
+{"return": {}}
+{"data": {"device": "ref_backup_0", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
+
+--- Add Bitmap ---
+
+{"execute": "block-dirty-bitmap-add", "arguments": {"granularity": 65536=
, "name": "bitmap0", "node": "drive0"}}
+{"return": {}}
+
+--- Write #1 ---
+
+write -P0x65 0x0000000 0x10000
+{"return": ""}
+write -P0x77 0x00f8000 0x10000
+{"return": ""}
+write -P0x72 0x2008000 0x10000
+{"return": ""}
+write -P0x69 0x3fe0000 0x10000
+{"return": ""}
+{
+  "bitmaps": {
+    "device0": [
+      {
+        "busy": false,
+        "count": 393216,
+        "granularity": 65536,
+        "name": "bitmap0",
+        "persistent": false,
+        "recording": true,
+        "status": "active"
+      }
+    ]
+  }
+}
+
+=3D Checking Bitmap bitmap0 =3D
+expecting 6 dirty sectors; have 6. OK!
+
+--- Reference Backup #1 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id=
": "ref_backup_1", "sync": "full", "target": "ref_target_1"}}
+{"return": {}}
+{"data": {"device": "ref_backup_1", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
+
+{"return": ""}
+
+--- Bitmap Backup #1 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "never", "device": "drive0", "job-id": "=
bitmap_backup_1", "sync": "bitmap", "target": "bitmap_target_1"}}
+{"return": {}}
+{"data": {"action": "report", "device": "bitmap_backup_1", "operation": =
"read"}, "event": "BLOCK_JOB_ERROR", "timestamp": {"microseconds": "USECS=
", "seconds": "SECS"}}
+{"data": {"device": "bitmap_backup_1", "error": "Input/output error", "l=
en": 67108864, "offset": 66781184, "speed": 0, "type": "backup"}, "event"=
: "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds"=
: "SECS"}}
+{
+  "bitmaps": {
+    "device0": [
+      {
+        "busy": false,
+        "count": 393216,
+        "granularity": 65536,
+        "name": "bitmap0",
+        "persistent": false,
+        "recording": true,
+        "status": "active"
+      }
+    ]
+  }
+}
+
+=3D Checking Bitmap bitmap0 =3D
+expecting 6 dirty sectors; have 6. OK!
+
+--- Write #3 ---
+
+write -P0xaa 0x0010000 0x30000
+{"return": ""}
+write -P0xbb 0x00d8000 0x10000
+{"return": ""}
+write -P0xcc 0x2028000 0x10000
+{"return": ""}
+write -P0xdd 0x3fc0000 0x10000
+{"return": ""}
+{
+  "bitmaps": {
+    "device0": [
+      {
+        "busy": false,
+        "count": 917504,
+        "granularity": 65536,
+        "name": "bitmap0",
+        "persistent": false,
+        "recording": true,
+        "status": "active"
+      }
+    ]
+  }
+}
+
+=3D Checking Bitmap bitmap0 =3D
+expecting 14 dirty sectors; have 14. OK!
+
+--- Reference Backup #2 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id=
": "ref_backup_2", "sync": "full", "target": "ref_target_2"}}
+{"return": {}}
+{"data": {"device": "ref_backup_2", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
+
+--- Bitmap Backup #2 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "never", "device": "drive0", "job-id": "=
bitmap_backup_2", "sync": "bitmap", "target": "bitmap_target_2"}}
+{"return": {}}
+{"execute": "job-finalize", "arguments": {"id": "bitmap_backup_2"}}
+{"return": {}}
+{"data": {"id": "bitmap_backup_2", "type": "backup"}, "event": "BLOCK_JO=
B_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "bitmap_backup_2", "len": 67108864, "offset": 671088=
64, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "times=
tamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{
+  "bitmaps": {
+    "device0": [
+      {
+        "busy": false,
+        "count": 917504,
+        "granularity": 65536,
+        "name": "bitmap0",
+        "persistent": false,
+        "recording": true,
+        "status": "active"
+      }
+    ]
+  }
+}
+
+=3D Checking Bitmap bitmap0 =3D
+expecting 14 dirty sectors; have 14. OK!
+
+--- Cleanup ---
+
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "bitmap0"=
, "node": "drive0"}}
+{"return": {}}
+{
+  "bitmaps": {
+    "device0": []
+  }
+}
+
+--- Verification ---
+
+qemu_img compare "TEST_DIR/PID-bsync1" "TEST_DIR/PID-fbackup1" =3D=3D> M=
ismatch, OK!
+qemu_img compare "TEST_DIR/PID-bsync2" "TEST_DIR/PID-fbackup2" =3D=3D> I=
dentical, OK!
+qemu_img compare "TEST_DIR/PID-img" "TEST_DIR/PID-fbackup2" =3D=3D> Iden=
tical, OK!
+
+
+=3D=3D=3D Bitmap Sync Mode never without failure =3D=3D=3D
+
+--- Preparing image & VM ---
+
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"d=
river": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
+{"return": {}}
+{"execute": "device_add", "arguments": {"drive": "drive0", "driver": "sc=
si-hd", "id": "device0", "share-rw": true}}
+{"return": {}}
+
+--- Write #0 ---
+
+write -P0x49 0x0000000 0x10000
+{"return": ""}
+write -P0x6c 0x0100000 0x10000
+{"return": ""}
+write -P0x6f 0x2000000 0x10000
+{"return": ""}
+write -P0x76 0x3ff0000 0x10000
+{"return": ""}
+{
+  "bitmaps": {
+    "device0": []
+  }
+}
+
+--- Reference Backup #0 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id=
": "ref_backup_0", "sync": "full", "target": "ref_target_0"}}
+{"return": {}}
+{"data": {"device": "ref_backup_0", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
+
+--- Add Bitmap ---
+
+{"execute": "block-dirty-bitmap-add", "arguments": {"granularity": 65536=
, "name": "bitmap0", "node": "drive0"}}
+{"return": {}}
+
+--- Write #1 ---
+
+write -P0x65 0x0000000 0x10000
+{"return": ""}
+write -P0x77 0x00f8000 0x10000
+{"return": ""}
+write -P0x72 0x2008000 0x10000
+{"return": ""}
+write -P0x69 0x3fe0000 0x10000
+{"return": ""}
+{
+  "bitmaps": {
+    "device0": [
+      {
+        "busy": false,
+        "count": 393216,
+        "granularity": 65536,
+        "name": "bitmap0",
+        "persistent": false,
+        "recording": true,
+        "status": "active"
+      }
+    ]
+  }
+}
+
+=3D Checking Bitmap bitmap0 =3D
+expecting 6 dirty sectors; have 6. OK!
+
+--- Reference Backup #1 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id=
": "ref_backup_1", "sync": "full", "target": "ref_target_1"}}
+{"return": {}}
+{"data": {"device": "ref_backup_1", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
+
+--- Bitmap Backup #1 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "never", "device": "drive0", "job-id": "=
bitmap_backup_1", "sync": "bitmap", "target": "bitmap_target_1"}}
+{"return": {}}
+
+--- Write #2 ---
+
+write -P0x74 0x0010000 0x10000
+{"return": ""}
+write -P0x69 0x00e8000 0x10000
+{"return": ""}
+write -P0x6e 0x2018000 0x10000
+{"return": ""}
+write -P0x67 0x3fe0000 0x20000
+{"return": ""}
+{
+  "bitmaps": {
+    "device0": [
+      {
+        "busy": false,
+        "count": 458752,
+        "granularity": 65536,
+        "persistent": false,
+        "recording": true,
+        "status": "active"
+      },
+      {
+        "busy": true,
+        "count": 393216,
+        "granularity": 65536,
+        "name": "bitmap0",
+        "persistent": false,
+        "recording": true,
+        "status": "frozen"
+      }
+    ]
+  }
+}
+
+=3D Checking Bitmap bitmap0 =3D
+expecting 6 dirty sectors; have 6. OK!
+
+=3D Checking Bitmap (anonymous) =3D
+expecting 7 dirty sectors; have 7. OK!
+
+{"execute": "job-finalize", "arguments": {"id": "bitmap_backup_1"}}
+{"return": {}}
+{"data": {"id": "bitmap_backup_1", "type": "backup"}, "event": "BLOCK_JO=
B_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "bitmap_backup_1", "len": 67108864, "offset": 671088=
64, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "times=
tamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{
+  "bitmaps": {
+    "device0": [
+      {
+        "busy": false,
+        "count": 655360,
+        "granularity": 65536,
+        "name": "bitmap0",
+        "persistent": false,
+        "recording": true,
+        "status": "active"
+      }
+    ]
+  }
+}
+
+=3D Checking Bitmap bitmap0 =3D
+expecting 10 dirty sectors; have 10. OK!
+
+--- Write #3 ---
+
+write -P0xaa 0x0010000 0x30000
+{"return": ""}
+write -P0xbb 0x00d8000 0x10000
+{"return": ""}
+write -P0xcc 0x2028000 0x10000
+{"return": ""}
+write -P0xdd 0x3fc0000 0x10000
+{"return": ""}
+{
+  "bitmaps": {
+    "device0": [
+      {
+        "busy": false,
+        "count": 983040,
+        "granularity": 65536,
+        "name": "bitmap0",
+        "persistent": false,
+        "recording": true,
+        "status": "active"
+      }
+    ]
+  }
+}
+
+=3D Checking Bitmap bitmap0 =3D
+expecting 15 dirty sectors; have 15. OK!
+
+--- Reference Backup #2 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id=
": "ref_backup_2", "sync": "full", "target": "ref_target_2"}}
+{"return": {}}
+{"data": {"device": "ref_backup_2", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
+
+--- Bitmap Backup #2 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "never", "device": "drive0", "job-id": "=
bitmap_backup_2", "sync": "bitmap", "target": "bitmap_target_2"}}
+{"return": {}}
+{"execute": "job-finalize", "arguments": {"id": "bitmap_backup_2"}}
+{"return": {}}
+{"data": {"id": "bitmap_backup_2", "type": "backup"}, "event": "BLOCK_JO=
B_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "bitmap_backup_2", "len": 67108864, "offset": 671088=
64, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "times=
tamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{
+  "bitmaps": {
+    "device0": [
+      {
+        "busy": false,
+        "count": 983040,
+        "granularity": 65536,
+        "name": "bitmap0",
+        "persistent": false,
+        "recording": true,
+        "status": "active"
+      }
+    ]
+  }
+}
+
+=3D Checking Bitmap bitmap0 =3D
+expecting 15 dirty sectors; have 15. OK!
+
+--- Cleanup ---
+
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "bitmap0"=
, "node": "drive0"}}
+{"return": {}}
+{
+  "bitmaps": {
+    "device0": []
+  }
+}
+
+--- Verification ---
+
+qemu_img compare "TEST_DIR/PID-bsync1" "TEST_DIR/PID-fbackup1" =3D=3D> I=
dentical, OK!
+qemu_img compare "TEST_DIR/PID-bsync2" "TEST_DIR/PID-fbackup2" =3D=3D> I=
dentical, OK!
+qemu_img compare "TEST_DIR/PID-img" "TEST_DIR/PID-fbackup2" =3D=3D> Iden=
tical, OK!
+
+
+=3D=3D=3D Bitmap Sync Mode on-success with simulated failure =3D=3D=3D
+
+--- Preparing image & VM ---
+
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"d=
river": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
+{"return": {}}
+{"execute": "device_add", "arguments": {"drive": "drive0", "driver": "sc=
si-hd", "id": "device0", "share-rw": true}}
+{"return": {}}
+
+--- Write #0 ---
+
+write -P0x49 0x0000000 0x10000
+{"return": ""}
+write -P0x6c 0x0100000 0x10000
+{"return": ""}
+write -P0x6f 0x2000000 0x10000
+{"return": ""}
+write -P0x76 0x3ff0000 0x10000
+{"return": ""}
+{
+  "bitmaps": {
+    "device0": []
+  }
+}
+
+--- Reference Backup #0 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id=
": "ref_backup_0", "sync": "full", "target": "ref_target_0"}}
+{"return": {}}
+{"data": {"device": "ref_backup_0", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
+
+--- Add Bitmap ---
+
+{"execute": "block-dirty-bitmap-add", "arguments": {"granularity": 65536=
, "name": "bitmap0", "node": "drive0"}}
+{"return": {}}
+
+--- Write #1 ---
+
+write -P0x65 0x0000000 0x10000
+{"return": ""}
+write -P0x77 0x00f8000 0x10000
+{"return": ""}
+write -P0x72 0x2008000 0x10000
+{"return": ""}
+write -P0x69 0x3fe0000 0x10000
+{"return": ""}
+{
+  "bitmaps": {
+    "device0": [
+      {
+        "busy": false,
+        "count": 393216,
+        "granularity": 65536,
+        "name": "bitmap0",
+        "persistent": false,
+        "recording": true,
+        "status": "active"
+      }
+    ]
+  }
+}
+
+=3D Checking Bitmap bitmap0 =3D
+expecting 6 dirty sectors; have 6. OK!
+
+--- Reference Backup #1 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id=
": "ref_backup_1", "sync": "full", "target": "ref_target_1"}}
+{"return": {}}
+{"data": {"device": "ref_backup_1", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
+
+--- Bitmap Backup #1 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "on-success", "device": "drive0", "job-i=
d": "bitmap_backup_1", "sync": "bitmap", "target": "bitmap_target_1"}}
+{"return": {}}
+
+--- Write #2 ---
+
+write -P0x74 0x0010000 0x10000
+{"return": ""}
+write -P0x69 0x00e8000 0x10000
+{"return": ""}
+write -P0x6e 0x2018000 0x10000
+{"return": ""}
+write -P0x67 0x3fe0000 0x20000
+{"return": ""}
+{
+  "bitmaps": {
+    "device0": [
+      {
+        "busy": false,
+        "count": 458752,
+        "granularity": 65536,
+        "persistent": false,
+        "recording": true,
+        "status": "active"
+      },
+      {
+        "busy": true,
+        "count": 393216,
+        "granularity": 65536,
+        "name": "bitmap0",
+        "persistent": false,
+        "recording": true,
+        "status": "frozen"
+      }
+    ]
+  }
+}
+
+=3D Checking Bitmap bitmap0 =3D
+expecting 6 dirty sectors; have 6. OK!
+
+=3D Checking Bitmap (anonymous) =3D
+expecting 7 dirty sectors; have 7. OK!
+
+{"execute": "job-cancel", "arguments": {"id": "bitmap_backup_1"}}
+{"return": {}}
+{"data": {"id": "bitmap_backup_1", "type": "backup"}, "event": "BLOCK_JO=
B_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "bitmap_backup_1", "len": 67108864, "offset": 671088=
64, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_CANCELLED", "times=
tamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{
+  "bitmaps": {
+    "device0": [
+      {
+        "busy": false,
+        "count": 655360,
+        "granularity": 65536,
+        "name": "bitmap0",
+        "persistent": false,
+        "recording": true,
+        "status": "active"
+      }
+    ]
+  }
+}
+
+=3D Checking Bitmap bitmap0 =3D
+expecting 10 dirty sectors; have 10. OK!
+
+--- Write #3 ---
+
+write -P0xaa 0x0010000 0x30000
+{"return": ""}
+write -P0xbb 0x00d8000 0x10000
+{"return": ""}
+write -P0xcc 0x2028000 0x10000
+{"return": ""}
+write -P0xdd 0x3fc0000 0x10000
+{"return": ""}
+{
+  "bitmaps": {
+    "device0": [
+      {
+        "busy": false,
+        "count": 983040,
+        "granularity": 65536,
+        "name": "bitmap0",
+        "persistent": false,
+        "recording": true,
+        "status": "active"
+      }
+    ]
+  }
+}
+
+=3D Checking Bitmap bitmap0 =3D
+expecting 15 dirty sectors; have 15. OK!
+
+--- Reference Backup #2 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id=
": "ref_backup_2", "sync": "full", "target": "ref_target_2"}}
+{"return": {}}
+{"data": {"device": "ref_backup_2", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
+
+--- Bitmap Backup #2 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "on-success", "device": "drive0", "job-i=
d": "bitmap_backup_2", "sync": "bitmap", "target": "bitmap_target_2"}}
+{"return": {}}
+{"execute": "job-finalize", "arguments": {"id": "bitmap_backup_2"}}
+{"return": {}}
+{"data": {"id": "bitmap_backup_2", "type": "backup"}, "event": "BLOCK_JO=
B_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "bitmap_backup_2", "len": 67108864, "offset": 671088=
64, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "times=
tamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{
+  "bitmaps": {
+    "device0": [
+      {
+        "busy": false,
+        "count": 0,
+        "granularity": 65536,
+        "name": "bitmap0",
+        "persistent": false,
+        "recording": true,
+        "status": "active"
+      }
+    ]
+  }
+}
+
+=3D Checking Bitmap bitmap0 =3D
+expecting 0 dirty sectors; have 0. OK!
+
+--- Cleanup ---
+
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "bitmap0"=
, "node": "drive0"}}
+{"return": {}}
+{
+  "bitmaps": {
+    "device0": []
+  }
+}
+
+--- Verification ---
+
+qemu_img compare "TEST_DIR/PID-bsync1" "TEST_DIR/PID-fbackup1" =3D=3D> I=
dentical, OK!
+qemu_img compare "TEST_DIR/PID-bsync2" "TEST_DIR/PID-fbackup2" =3D=3D> I=
dentical, OK!
+qemu_img compare "TEST_DIR/PID-img" "TEST_DIR/PID-fbackup2" =3D=3D> Iden=
tical, OK!
+
+
+=3D=3D=3D Bitmap Sync Mode on-success with intermediate failure =3D=3D=3D
+
+--- Preparing image & VM ---
+
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"d=
river": "blkdebug", "image": {"driver": "file", "filename": "TEST_DIR/PID=
-img"}, "inject-error": [{"errno": 5, "event": "read_aio", "immediately":=
 false, "once": true, "state": 3}], "set-state": [{"event": "flush_to_dis=
k", "new-state": 2, "state": 1}, {"event": "read_aio", "new-state": 3, "s=
tate": 2}]}, "node-name": "drive0"}}
+{"return": {}}
+{"execute": "device_add", "arguments": {"drive": "drive0", "driver": "sc=
si-hd", "id": "device0", "share-rw": true}}
+{"return": {}}
+
+--- Write #0 ---
+
+write -P0x49 0x0000000 0x10000
+{"return": ""}
+write -P0x6c 0x0100000 0x10000
+{"return": ""}
+write -P0x6f 0x2000000 0x10000
+{"return": ""}
+write -P0x76 0x3ff0000 0x10000
+{"return": ""}
+{
+  "bitmaps": {
+    "device0": []
+  }
+}
+
+--- Reference Backup #0 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id=
": "ref_backup_0", "sync": "full", "target": "ref_target_0"}}
+{"return": {}}
+{"data": {"device": "ref_backup_0", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
+
+--- Add Bitmap ---
+
+{"execute": "block-dirty-bitmap-add", "arguments": {"granularity": 65536=
, "name": "bitmap0", "node": "drive0"}}
+{"return": {}}
+
+--- Write #1 ---
+
+write -P0x65 0x0000000 0x10000
+{"return": ""}
+write -P0x77 0x00f8000 0x10000
+{"return": ""}
+write -P0x72 0x2008000 0x10000
+{"return": ""}
+write -P0x69 0x3fe0000 0x10000
+{"return": ""}
+{
+  "bitmaps": {
+    "device0": [
+      {
+        "busy": false,
+        "count": 393216,
+        "granularity": 65536,
+        "name": "bitmap0",
+        "persistent": false,
+        "recording": true,
+        "status": "active"
+      }
+    ]
+  }
+}
+
+=3D Checking Bitmap bitmap0 =3D
+expecting 6 dirty sectors; have 6. OK!
+
+--- Reference Backup #1 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id=
": "ref_backup_1", "sync": "full", "target": "ref_target_1"}}
+{"return": {}}
+{"data": {"device": "ref_backup_1", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
+
+{"return": ""}
+
+--- Bitmap Backup #1 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "on-success", "device": "drive0", "job-i=
d": "bitmap_backup_1", "sync": "bitmap", "target": "bitmap_target_1"}}
+{"return": {}}
+{"data": {"action": "report", "device": "bitmap_backup_1", "operation": =
"read"}, "event": "BLOCK_JOB_ERROR", "timestamp": {"microseconds": "USECS=
", "seconds": "SECS"}}
+{"data": {"device": "bitmap_backup_1", "error": "Input/output error", "l=
en": 67108864, "offset": 66781184, "speed": 0, "type": "backup"}, "event"=
: "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds"=
: "SECS"}}
+{
+  "bitmaps": {
+    "device0": [
+      {
+        "busy": false,
+        "count": 393216,
+        "granularity": 65536,
+        "name": "bitmap0",
+        "persistent": false,
+        "recording": true,
+        "status": "active"
+      }
+    ]
+  }
+}
+
+=3D Checking Bitmap bitmap0 =3D
+expecting 6 dirty sectors; have 6. OK!
+
+--- Write #3 ---
+
+write -P0xaa 0x0010000 0x30000
+{"return": ""}
+write -P0xbb 0x00d8000 0x10000
+{"return": ""}
+write -P0xcc 0x2028000 0x10000
+{"return": ""}
+write -P0xdd 0x3fc0000 0x10000
+{"return": ""}
+{
+  "bitmaps": {
+    "device0": [
+      {
+        "busy": false,
+        "count": 917504,
+        "granularity": 65536,
+        "name": "bitmap0",
+        "persistent": false,
+        "recording": true,
+        "status": "active"
+      }
+    ]
+  }
+}
+
+=3D Checking Bitmap bitmap0 =3D
+expecting 14 dirty sectors; have 14. OK!
+
+--- Reference Backup #2 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id=
": "ref_backup_2", "sync": "full", "target": "ref_target_2"}}
+{"return": {}}
+{"data": {"device": "ref_backup_2", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
+
+--- Bitmap Backup #2 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "on-success", "device": "drive0", "job-i=
d": "bitmap_backup_2", "sync": "bitmap", "target": "bitmap_target_2"}}
+{"return": {}}
+{"execute": "job-finalize", "arguments": {"id": "bitmap_backup_2"}}
+{"return": {}}
+{"data": {"id": "bitmap_backup_2", "type": "backup"}, "event": "BLOCK_JO=
B_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "bitmap_backup_2", "len": 67108864, "offset": 671088=
64, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "times=
tamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{
+  "bitmaps": {
+    "device0": [
+      {
+        "busy": false,
+        "count": 0,
+        "granularity": 65536,
+        "name": "bitmap0",
+        "persistent": false,
+        "recording": true,
+        "status": "active"
+      }
+    ]
+  }
+}
+
+=3D Checking Bitmap bitmap0 =3D
+expecting 0 dirty sectors; have 0. OK!
+
+--- Cleanup ---
+
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "bitmap0"=
, "node": "drive0"}}
+{"return": {}}
+{
+  "bitmaps": {
+    "device0": []
+  }
+}
+
+--- Verification ---
+
+qemu_img compare "TEST_DIR/PID-bsync1" "TEST_DIR/PID-fbackup1" =3D=3D> M=
ismatch, OK!
+qemu_img compare "TEST_DIR/PID-bsync2" "TEST_DIR/PID-fbackup2" =3D=3D> I=
dentical, OK!
+qemu_img compare "TEST_DIR/PID-img" "TEST_DIR/PID-fbackup2" =3D=3D> Iden=
tical, OK!
+
+
+=3D=3D=3D Bitmap Sync Mode on-success without failure =3D=3D=3D
+
+--- Preparing image & VM ---
+
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"d=
river": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
+{"return": {}}
+{"execute": "device_add", "arguments": {"drive": "drive0", "driver": "sc=
si-hd", "id": "device0", "share-rw": true}}
+{"return": {}}
+
+--- Write #0 ---
+
+write -P0x49 0x0000000 0x10000
+{"return": ""}
+write -P0x6c 0x0100000 0x10000
+{"return": ""}
+write -P0x6f 0x2000000 0x10000
+{"return": ""}
+write -P0x76 0x3ff0000 0x10000
+{"return": ""}
+{
+  "bitmaps": {
+    "device0": []
+  }
+}
+
+--- Reference Backup #0 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id=
": "ref_backup_0", "sync": "full", "target": "ref_target_0"}}
+{"return": {}}
+{"data": {"device": "ref_backup_0", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
+
+--- Add Bitmap ---
+
+{"execute": "block-dirty-bitmap-add", "arguments": {"granularity": 65536=
, "name": "bitmap0", "node": "drive0"}}
+{"return": {}}
+
+--- Write #1 ---
+
+write -P0x65 0x0000000 0x10000
+{"return": ""}
+write -P0x77 0x00f8000 0x10000
+{"return": ""}
+write -P0x72 0x2008000 0x10000
+{"return": ""}
+write -P0x69 0x3fe0000 0x10000
+{"return": ""}
+{
+  "bitmaps": {
+    "device0": [
+      {
+        "busy": false,
+        "count": 393216,
+        "granularity": 65536,
+        "name": "bitmap0",
+        "persistent": false,
+        "recording": true,
+        "status": "active"
+      }
+    ]
+  }
+}
+
+=3D Checking Bitmap bitmap0 =3D
+expecting 6 dirty sectors; have 6. OK!
+
+--- Reference Backup #1 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id=
": "ref_backup_1", "sync": "full", "target": "ref_target_1"}}
+{"return": {}}
+{"data": {"device": "ref_backup_1", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
+
+--- Bitmap Backup #1 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "on-success", "device": "drive0", "job-i=
d": "bitmap_backup_1", "sync": "bitmap", "target": "bitmap_target_1"}}
+{"return": {}}
+
+--- Write #2 ---
+
+write -P0x74 0x0010000 0x10000
+{"return": ""}
+write -P0x69 0x00e8000 0x10000
+{"return": ""}
+write -P0x6e 0x2018000 0x10000
+{"return": ""}
+write -P0x67 0x3fe0000 0x20000
+{"return": ""}
+{
+  "bitmaps": {
+    "device0": [
+      {
+        "busy": false,
+        "count": 458752,
+        "granularity": 65536,
+        "persistent": false,
+        "recording": true,
+        "status": "active"
+      },
+      {
+        "busy": true,
+        "count": 393216,
+        "granularity": 65536,
+        "name": "bitmap0",
+        "persistent": false,
+        "recording": true,
+        "status": "frozen"
+      }
+    ]
+  }
+}
+
+=3D Checking Bitmap bitmap0 =3D
+expecting 6 dirty sectors; have 6. OK!
+
+=3D Checking Bitmap (anonymous) =3D
+expecting 7 dirty sectors; have 7. OK!
+
+{"execute": "job-finalize", "arguments": {"id": "bitmap_backup_1"}}
+{"return": {}}
+{"data": {"id": "bitmap_backup_1", "type": "backup"}, "event": "BLOCK_JO=
B_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "bitmap_backup_1", "len": 67108864, "offset": 671088=
64, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "times=
tamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{
+  "bitmaps": {
+    "device0": [
+      {
+        "busy": false,
+        "count": 458752,
+        "granularity": 65536,
+        "name": "bitmap0",
+        "persistent": false,
+        "recording": true,
+        "status": "active"
+      }
+    ]
+  }
+}
+
+=3D Checking Bitmap bitmap0 =3D
+expecting 7 dirty sectors; have 7. OK!
+
+--- Write #3 ---
+
+write -P0xaa 0x0010000 0x30000
+{"return": ""}
+write -P0xbb 0x00d8000 0x10000
+{"return": ""}
+write -P0xcc 0x2028000 0x10000
+{"return": ""}
+write -P0xdd 0x3fc0000 0x10000
+{"return": ""}
+{
+  "bitmaps": {
+    "device0": [
+      {
+        "busy": false,
+        "count": 786432,
+        "granularity": 65536,
+        "name": "bitmap0",
+        "persistent": false,
+        "recording": true,
+        "status": "active"
+      }
+    ]
+  }
+}
+
+=3D Checking Bitmap bitmap0 =3D
+expecting 12 dirty sectors; have 12. OK!
+
+--- Reference Backup #2 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id=
": "ref_backup_2", "sync": "full", "target": "ref_target_2"}}
+{"return": {}}
+{"data": {"device": "ref_backup_2", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
+
+--- Bitmap Backup #2 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "on-success", "device": "drive0", "job-i=
d": "bitmap_backup_2", "sync": "bitmap", "target": "bitmap_target_2"}}
+{"return": {}}
+{"execute": "job-finalize", "arguments": {"id": "bitmap_backup_2"}}
+{"return": {}}
+{"data": {"id": "bitmap_backup_2", "type": "backup"}, "event": "BLOCK_JO=
B_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "bitmap_backup_2", "len": 67108864, "offset": 671088=
64, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "times=
tamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{
+  "bitmaps": {
+    "device0": [
+      {
+        "busy": false,
+        "count": 0,
+        "granularity": 65536,
+        "name": "bitmap0",
+        "persistent": false,
+        "recording": true,
+        "status": "active"
+      }
+    ]
+  }
+}
+
+=3D Checking Bitmap bitmap0 =3D
+expecting 0 dirty sectors; have 0. OK!
+
+--- Cleanup ---
+
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "bitmap0"=
, "node": "drive0"}}
+{"return": {}}
+{
+  "bitmaps": {
+    "device0": []
+  }
+}
+
+--- Verification ---
+
+qemu_img compare "TEST_DIR/PID-bsync1" "TEST_DIR/PID-fbackup1" =3D=3D> I=
dentical, OK!
+qemu_img compare "TEST_DIR/PID-bsync2" "TEST_DIR/PID-fbackup2" =3D=3D> I=
dentical, OK!
+qemu_img compare "TEST_DIR/PID-img" "TEST_DIR/PID-fbackup2" =3D=3D> Iden=
tical, OK!
+
+
+=3D=3D=3D Bitmap Sync Mode always with simulated failure =3D=3D=3D
+
+--- Preparing image & VM ---
+
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"d=
river": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
+{"return": {}}
+{"execute": "device_add", "arguments": {"drive": "drive0", "driver": "sc=
si-hd", "id": "device0", "share-rw": true}}
+{"return": {}}
+
+--- Write #0 ---
+
+write -P0x49 0x0000000 0x10000
+{"return": ""}
+write -P0x6c 0x0100000 0x10000
+{"return": ""}
+write -P0x6f 0x2000000 0x10000
+{"return": ""}
+write -P0x76 0x3ff0000 0x10000
+{"return": ""}
+{
+  "bitmaps": {
+    "device0": []
+  }
+}
+
+--- Reference Backup #0 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id=
": "ref_backup_0", "sync": "full", "target": "ref_target_0"}}
+{"return": {}}
+{"data": {"device": "ref_backup_0", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
+
+--- Add Bitmap ---
+
+{"execute": "block-dirty-bitmap-add", "arguments": {"granularity": 65536=
, "name": "bitmap0", "node": "drive0"}}
+{"return": {}}
+
+--- Write #1 ---
+
+write -P0x65 0x0000000 0x10000
+{"return": ""}
+write -P0x77 0x00f8000 0x10000
+{"return": ""}
+write -P0x72 0x2008000 0x10000
+{"return": ""}
+write -P0x69 0x3fe0000 0x10000
+{"return": ""}
+{
+  "bitmaps": {
+    "device0": [
+      {
+        "busy": false,
+        "count": 393216,
+        "granularity": 65536,
+        "name": "bitmap0",
+        "persistent": false,
+        "recording": true,
+        "status": "active"
+      }
+    ]
+  }
+}
+
+=3D Checking Bitmap bitmap0 =3D
+expecting 6 dirty sectors; have 6. OK!
+
+--- Reference Backup #1 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id=
": "ref_backup_1", "sync": "full", "target": "ref_target_1"}}
+{"return": {}}
+{"data": {"device": "ref_backup_1", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
+
+--- Bitmap Backup #1 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "always", "device": "drive0", "job-id": =
"bitmap_backup_1", "sync": "bitmap", "target": "bitmap_target_1"}}
+{"return": {}}
+
+--- Write #2 ---
+
+write -P0x74 0x0010000 0x10000
+{"return": ""}
+write -P0x69 0x00e8000 0x10000
+{"return": ""}
+write -P0x6e 0x2018000 0x10000
+{"return": ""}
+write -P0x67 0x3fe0000 0x20000
+{"return": ""}
+{
+  "bitmaps": {
+    "device0": [
+      {
+        "busy": false,
+        "count": 458752,
+        "granularity": 65536,
+        "persistent": false,
+        "recording": true,
+        "status": "active"
+      },
+      {
+        "busy": true,
+        "count": 393216,
+        "granularity": 65536,
+        "name": "bitmap0",
+        "persistent": false,
+        "recording": true,
+        "status": "frozen"
+      }
+    ]
+  }
+}
+
+=3D Checking Bitmap bitmap0 =3D
+expecting 6 dirty sectors; have 6. OK!
+
+=3D Checking Bitmap (anonymous) =3D
+expecting 7 dirty sectors; have 7. OK!
+
+{"execute": "job-cancel", "arguments": {"id": "bitmap_backup_1"}}
+{"return": {}}
+{"data": {"id": "bitmap_backup_1", "type": "backup"}, "event": "BLOCK_JO=
B_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "bitmap_backup_1", "len": 67108864, "offset": 671088=
64, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_CANCELLED", "times=
tamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{
+  "bitmaps": {
+    "device0": [
+      {
+        "busy": false,
+        "count": 458752,
+        "granularity": 65536,
+        "name": "bitmap0",
+        "persistent": false,
+        "recording": true,
+        "status": "active"
+      }
+    ]
+  }
+}
+
+=3D Checking Bitmap bitmap0 =3D
+expecting 7 dirty sectors; have 7. OK!
+
+--- Write #3 ---
+
+write -P0xaa 0x0010000 0x30000
+{"return": ""}
+write -P0xbb 0x00d8000 0x10000
+{"return": ""}
+write -P0xcc 0x2028000 0x10000
+{"return": ""}
+write -P0xdd 0x3fc0000 0x10000
+{"return": ""}
+{
+  "bitmaps": {
+    "device0": [
+      {
+        "busy": false,
+        "count": 786432,
+        "granularity": 65536,
+        "name": "bitmap0",
+        "persistent": false,
+        "recording": true,
+        "status": "active"
+      }
+    ]
+  }
+}
+
+=3D Checking Bitmap bitmap0 =3D
+expecting 12 dirty sectors; have 12. OK!
+
+--- Reference Backup #2 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id=
": "ref_backup_2", "sync": "full", "target": "ref_target_2"}}
+{"return": {}}
+{"data": {"device": "ref_backup_2", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
+
+--- Bitmap Backup #2 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "always", "device": "drive0", "job-id": =
"bitmap_backup_2", "sync": "bitmap", "target": "bitmap_target_2"}}
+{"return": {}}
+{"execute": "job-finalize", "arguments": {"id": "bitmap_backup_2"}}
+{"return": {}}
+{"data": {"id": "bitmap_backup_2", "type": "backup"}, "event": "BLOCK_JO=
B_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "bitmap_backup_2", "len": 67108864, "offset": 671088=
64, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "times=
tamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{
+  "bitmaps": {
+    "device0": [
+      {
+        "busy": false,
+        "count": 0,
+        "granularity": 65536,
+        "name": "bitmap0",
+        "persistent": false,
+        "recording": true,
+        "status": "active"
+      }
+    ]
+  }
+}
+
+=3D Checking Bitmap bitmap0 =3D
+expecting 0 dirty sectors; have 0. OK!
+
+--- Cleanup ---
+
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "bitmap0"=
, "node": "drive0"}}
+{"return": {}}
+{
+  "bitmaps": {
+    "device0": []
+  }
+}
+
+--- Verification ---
+
+qemu_img compare "TEST_DIR/PID-bsync1" "TEST_DIR/PID-fbackup1" =3D=3D> I=
dentical, OK!
+qemu_img compare "TEST_DIR/PID-bsync2" "TEST_DIR/PID-fbackup2" =3D=3D> I=
dentical, OK!
+qemu_img compare "TEST_DIR/PID-img" "TEST_DIR/PID-fbackup2" =3D=3D> Iden=
tical, OK!
+
+
+=3D=3D=3D Bitmap Sync Mode always with intermediate failure =3D=3D=3D
+
+--- Preparing image & VM ---
+
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"d=
river": "blkdebug", "image": {"driver": "file", "filename": "TEST_DIR/PID=
-img"}, "inject-error": [{"errno": 5, "event": "read_aio", "immediately":=
 false, "once": true, "state": 3}], "set-state": [{"event": "flush_to_dis=
k", "new-state": 2, "state": 1}, {"event": "read_aio", "new-state": 3, "s=
tate": 2}]}, "node-name": "drive0"}}
+{"return": {}}
+{"execute": "device_add", "arguments": {"drive": "drive0", "driver": "sc=
si-hd", "id": "device0", "share-rw": true}}
+{"return": {}}
+
+--- Write #0 ---
+
+write -P0x49 0x0000000 0x10000
+{"return": ""}
+write -P0x6c 0x0100000 0x10000
+{"return": ""}
+write -P0x6f 0x2000000 0x10000
+{"return": ""}
+write -P0x76 0x3ff0000 0x10000
+{"return": ""}
+{
+  "bitmaps": {
+    "device0": []
+  }
+}
+
+--- Reference Backup #0 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id=
": "ref_backup_0", "sync": "full", "target": "ref_target_0"}}
+{"return": {}}
+{"data": {"device": "ref_backup_0", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
+
+--- Add Bitmap ---
+
+{"execute": "block-dirty-bitmap-add", "arguments": {"granularity": 65536=
, "name": "bitmap0", "node": "drive0"}}
+{"return": {}}
+
+--- Write #1 ---
+
+write -P0x65 0x0000000 0x10000
+{"return": ""}
+write -P0x77 0x00f8000 0x10000
+{"return": ""}
+write -P0x72 0x2008000 0x10000
+{"return": ""}
+write -P0x69 0x3fe0000 0x10000
+{"return": ""}
+{
+  "bitmaps": {
+    "device0": [
+      {
+        "busy": false,
+        "count": 393216,
+        "granularity": 65536,
+        "name": "bitmap0",
+        "persistent": false,
+        "recording": true,
+        "status": "active"
+      }
+    ]
+  }
+}
+
+=3D Checking Bitmap bitmap0 =3D
+expecting 6 dirty sectors; have 6. OK!
+
+--- Reference Backup #1 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id=
": "ref_backup_1", "sync": "full", "target": "ref_target_1"}}
+{"return": {}}
+{"data": {"device": "ref_backup_1", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
+
+{"return": ""}
+
+--- Bitmap Backup #1 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "always", "device": "drive0", "job-id": =
"bitmap_backup_1", "sync": "bitmap", "target": "bitmap_target_1"}}
+{"return": {}}
+{"data": {"action": "report", "device": "bitmap_backup_1", "operation": =
"read"}, "event": "BLOCK_JOB_ERROR", "timestamp": {"microseconds": "USECS=
", "seconds": "SECS"}}
+{"data": {"device": "bitmap_backup_1", "error": "Input/output error", "l=
en": 67108864, "offset": 66781184, "speed": 0, "type": "backup"}, "event"=
: "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds"=
: "SECS"}}
+{
+  "bitmaps": {
+    "device0": [
+      {
+        "busy": false,
+        "count": 327680,
+        "granularity": 65536,
+        "name": "bitmap0",
+        "persistent": false,
+        "recording": true,
+        "status": "active"
+      }
+    ]
+  }
+}
+
+=3D Checking Bitmap bitmap0 =3D
+expecting 5 dirty sectors; have 5. OK!
+
+--- Write #3 ---
+
+write -P0xaa 0x0010000 0x30000
+{"return": ""}
+write -P0xbb 0x00d8000 0x10000
+{"return": ""}
+write -P0xcc 0x2028000 0x10000
+{"return": ""}
+write -P0xdd 0x3fc0000 0x10000
+{"return": ""}
+{
+  "bitmaps": {
+    "device0": [
+      {
+        "busy": false,
+        "count": 851968,
+        "granularity": 65536,
+        "name": "bitmap0",
+        "persistent": false,
+        "recording": true,
+        "status": "active"
+      }
+    ]
+  }
+}
+
+=3D Checking Bitmap bitmap0 =3D
+expecting 13 dirty sectors; have 13. OK!
+
+--- Reference Backup #2 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id=
": "ref_backup_2", "sync": "full", "target": "ref_target_2"}}
+{"return": {}}
+{"data": {"device": "ref_backup_2", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
+
+--- Bitmap Backup #2 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "always", "device": "drive0", "job-id": =
"bitmap_backup_2", "sync": "bitmap", "target": "bitmap_target_2"}}
+{"return": {}}
+{"execute": "job-finalize", "arguments": {"id": "bitmap_backup_2"}}
+{"return": {}}
+{"data": {"id": "bitmap_backup_2", "type": "backup"}, "event": "BLOCK_JO=
B_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "bitmap_backup_2", "len": 67108864, "offset": 671088=
64, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "times=
tamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{
+  "bitmaps": {
+    "device0": [
+      {
+        "busy": false,
+        "count": 0,
+        "granularity": 65536,
+        "name": "bitmap0",
+        "persistent": false,
+        "recording": true,
+        "status": "active"
+      }
+    ]
+  }
+}
+
+=3D Checking Bitmap bitmap0 =3D
+expecting 0 dirty sectors; have 0. OK!
+
+--- Cleanup ---
+
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "bitmap0"=
, "node": "drive0"}}
+{"return": {}}
+{
+  "bitmaps": {
+    "device0": []
+  }
+}
+
+--- Verification ---
+
+qemu_img compare "TEST_DIR/PID-bsync1" "TEST_DIR/PID-fbackup1" =3D=3D> M=
ismatch, OK!
+qemu_img compare "TEST_DIR/PID-bsync2" "TEST_DIR/PID-fbackup2" =3D=3D> I=
dentical, OK!
+qemu_img compare "TEST_DIR/PID-img" "TEST_DIR/PID-fbackup2" =3D=3D> Iden=
tical, OK!
+
+
+=3D=3D=3D Bitmap Sync Mode always without failure =3D=3D=3D
+
+--- Preparing image & VM ---
+
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"d=
river": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
+{"return": {}}
+{"execute": "device_add", "arguments": {"drive": "drive0", "driver": "sc=
si-hd", "id": "device0", "share-rw": true}}
+{"return": {}}
+
+--- Write #0 ---
+
+write -P0x49 0x0000000 0x10000
+{"return": ""}
+write -P0x6c 0x0100000 0x10000
+{"return": ""}
+write -P0x6f 0x2000000 0x10000
+{"return": ""}
+write -P0x76 0x3ff0000 0x10000
+{"return": ""}
+{
+  "bitmaps": {
+    "device0": []
+  }
+}
+
+--- Reference Backup #0 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id=
": "ref_backup_0", "sync": "full", "target": "ref_target_0"}}
+{"return": {}}
+{"data": {"device": "ref_backup_0", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
+
+--- Add Bitmap ---
+
+{"execute": "block-dirty-bitmap-add", "arguments": {"granularity": 65536=
, "name": "bitmap0", "node": "drive0"}}
+{"return": {}}
+
+--- Write #1 ---
+
+write -P0x65 0x0000000 0x10000
+{"return": ""}
+write -P0x77 0x00f8000 0x10000
+{"return": ""}
+write -P0x72 0x2008000 0x10000
+{"return": ""}
+write -P0x69 0x3fe0000 0x10000
+{"return": ""}
+{
+  "bitmaps": {
+    "device0": [
+      {
+        "busy": false,
+        "count": 393216,
+        "granularity": 65536,
+        "name": "bitmap0",
+        "persistent": false,
+        "recording": true,
+        "status": "active"
+      }
+    ]
+  }
+}
+
+=3D Checking Bitmap bitmap0 =3D
+expecting 6 dirty sectors; have 6. OK!
+
+--- Reference Backup #1 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id=
": "ref_backup_1", "sync": "full", "target": "ref_target_1"}}
+{"return": {}}
+{"data": {"device": "ref_backup_1", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
+
+--- Bitmap Backup #1 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "always", "device": "drive0", "job-id": =
"bitmap_backup_1", "sync": "bitmap", "target": "bitmap_target_1"}}
+{"return": {}}
+
+--- Write #2 ---
+
+write -P0x74 0x0010000 0x10000
+{"return": ""}
+write -P0x69 0x00e8000 0x10000
+{"return": ""}
+write -P0x6e 0x2018000 0x10000
+{"return": ""}
+write -P0x67 0x3fe0000 0x20000
+{"return": ""}
+{
+  "bitmaps": {
+    "device0": [
+      {
+        "busy": false,
+        "count": 458752,
+        "granularity": 65536,
+        "persistent": false,
+        "recording": true,
+        "status": "active"
+      },
+      {
+        "busy": true,
+        "count": 393216,
+        "granularity": 65536,
+        "name": "bitmap0",
+        "persistent": false,
+        "recording": true,
+        "status": "frozen"
+      }
+    ]
+  }
+}
+
+=3D Checking Bitmap bitmap0 =3D
+expecting 6 dirty sectors; have 6. OK!
+
+=3D Checking Bitmap (anonymous) =3D
+expecting 7 dirty sectors; have 7. OK!
+
+{"execute": "job-finalize", "arguments": {"id": "bitmap_backup_1"}}
+{"return": {}}
+{"data": {"id": "bitmap_backup_1", "type": "backup"}, "event": "BLOCK_JO=
B_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "bitmap_backup_1", "len": 67108864, "offset": 671088=
64, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "times=
tamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{
+  "bitmaps": {
+    "device0": [
+      {
+        "busy": false,
+        "count": 458752,
+        "granularity": 65536,
+        "name": "bitmap0",
+        "persistent": false,
+        "recording": true,
+        "status": "active"
+      }
+    ]
+  }
+}
+
+=3D Checking Bitmap bitmap0 =3D
+expecting 7 dirty sectors; have 7. OK!
+
+--- Write #3 ---
+
+write -P0xaa 0x0010000 0x30000
+{"return": ""}
+write -P0xbb 0x00d8000 0x10000
+{"return": ""}
+write -P0xcc 0x2028000 0x10000
+{"return": ""}
+write -P0xdd 0x3fc0000 0x10000
+{"return": ""}
+{
+  "bitmaps": {
+    "device0": [
+      {
+        "busy": false,
+        "count": 786432,
+        "granularity": 65536,
+        "name": "bitmap0",
+        "persistent": false,
+        "recording": true,
+        "status": "active"
+      }
+    ]
+  }
+}
+
+=3D Checking Bitmap bitmap0 =3D
+expecting 12 dirty sectors; have 12. OK!
+
+--- Reference Backup #2 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "job-id=
": "ref_backup_2", "sync": "full", "target": "ref_target_2"}}
+{"return": {}}
+{"data": {"device": "ref_backup_2", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
+
+--- Bitmap Backup #2 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "always", "device": "drive0", "job-id": =
"bitmap_backup_2", "sync": "bitmap", "target": "bitmap_target_2"}}
+{"return": {}}
+{"execute": "job-finalize", "arguments": {"id": "bitmap_backup_2"}}
+{"return": {}}
+{"data": {"id": "bitmap_backup_2", "type": "backup"}, "event": "BLOCK_JO=
B_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "bitmap_backup_2", "len": 67108864, "offset": 671088=
64, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "times=
tamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{
+  "bitmaps": {
+    "device0": [
+      {
+        "busy": false,
+        "count": 0,
+        "granularity": 65536,
+        "name": "bitmap0",
+        "persistent": false,
+        "recording": true,
+        "status": "active"
+      }
+    ]
+  }
+}
+
+=3D Checking Bitmap bitmap0 =3D
+expecting 0 dirty sectors; have 0. OK!
+
+--- Cleanup ---
+
+{"execute": "block-dirty-bitmap-remove", "arguments": {"name": "bitmap0"=
, "node": "drive0"}}
+{"return": {}}
+{
+  "bitmaps": {
+    "device0": []
+  }
+}
+
+--- Verification ---
+
+qemu_img compare "TEST_DIR/PID-bsync1" "TEST_DIR/PID-fbackup1" =3D=3D> I=
dentical, OK!
+qemu_img compare "TEST_DIR/PID-bsync2" "TEST_DIR/PID-fbackup2" =3D=3D> I=
dentical, OK!
+qemu_img compare "TEST_DIR/PID-img" "TEST_DIR/PID-fbackup2" =3D=3D> Iden=
tical, OK!
+
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index b34c8e3c0c..b53afcd149 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -269,3 +269,4 @@
 254 rw auto backing quick
 255 rw auto quick
 256 rw auto quick
+257 rw auto
--=20
2.21.0


