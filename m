Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EC60C34026
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 10:17:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C736F207FD
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 10:17:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C736F207FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60026 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3zwm-0006JF-Sc
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 05:17:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48949)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <f.gruenbichler@proxmox.com>) id 1j3zvb-0003xd-Tn
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 05:16:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <f.gruenbichler@proxmox.com>) id 1j3zvR-00080M-66
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 05:16:31 -0500
Received: from proxmox-new.maurer-it.com ([212.186.127.180]:21467)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <f.gruenbichler@proxmox.com>)
 id 1j3zv5-0007rg-HX; Tue, 18 Feb 2020 05:16:00 -0500
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 5FAD441FEA;
 Tue, 18 Feb 2020 11:08:14 +0100 (CET)
From: =?UTF-8?q?Fabian=20Gr=C3=BCnbichler?= <f.gruenbichler@proxmox.com>
To: qemu-devel@nongnu.org
Subject: [RFC qemu 5/6] iotests: add test for bitmap mirror
Date: Tue, 18 Feb 2020 11:07:39 +0100
Message-Id: <20200218100740.2228521-6-f.gruenbichler@proxmox.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200218100740.2228521-1-f.gruenbichler@proxmox.com>
References: <20200218100740.2228521-1-f.gruenbichler@proxmox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.186.127.180
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 John Snow <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

heavily based on/practically forked off iotest 257 for bitmap backups,
but:

- no writes to filter node 'mirror-top' between completion and
finalization, as those seem to deadlock?
- no inclusion of not-yet-available full/top sync modes in combination
with bitmaps
- extra set of reference/test mirrors to verify that writes in parallel
with active mirror work as expected

intentionally keeping copyright and ownership of original test case to
honor provenance.

Signed-off-by: Fabian Gr=C3=BCnbichler <f.gruenbichler@proxmox.com>
---
 tests/qemu-iotests/284     |  547 +++++++
 tests/qemu-iotests/284.out | 2846 ++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/group   |    1 +
 3 files changed, 3394 insertions(+)
 create mode 100755 tests/qemu-iotests/284
 create mode 100644 tests/qemu-iotests/284.out

diff --git a/tests/qemu-iotests/284 b/tests/qemu-iotests/284
new file mode 100755
index 0000000000..b04a8e651a
--- /dev/null
+++ b/tests/qemu-iotests/284
@@ -0,0 +1,547 @@
+#!/usr/bin/env python3
+#
+# Test bitmap-sync mirrors (incremental, differential, and partials)
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
+import math
+import os
+
+import iotests
+from iotests import log, qemu_img
+
+SIZE =3D 64 * 1024 * 1024
+GRANULARITY =3D 64 * 1024
+
+
+class Pattern:
+    def __init__(self, byte, offset, size=3DGRANULARITY):
+        self.byte =3D byte
+        self.offset =3D offset
+        self.size =3D size
+
+    def bits(self, granularity):
+        lower =3D self.offset // granularity
+        upper =3D (self.offset + self.size - 1) // granularity
+        return set(range(lower, upper + 1))
+
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
+            res |=3D pattern.bits(granularity)
+        return res
+
+
+GROUPS =3D [
+    PatternGroup([
+        # Batch 0: 4 clusters
+        Pattern('0x49', 0x0000000),
+        Pattern('0x6c', 0x0100000),   # 1M
+        Pattern('0x6f', 0x2000000),   # 32M
+        Pattern('0x76', 0x3ff0000)]), # 64M - 64K
+    PatternGroup([
+        # Batch 1: 6 clusters (3 new)
+        Pattern('0x65', 0x0000000),   # Full overwrite
+        Pattern('0x77', 0x00f8000),   # Partial-left (1M-32K)
+        Pattern('0x72', 0x2008000),   # Partial-right (32M+32K)
+        Pattern('0x69', 0x3fe0000)]), # Adjacent-left (64M - 128K)
+    PatternGroup([
+        # Batch 2: 7 clusters (3 new)
+        Pattern('0x74', 0x0010000),   # Adjacent-right
+        Pattern('0x69', 0x00e8000),   # Partial-left  (1M-96K)
+        Pattern('0x6e', 0x2018000),   # Partial-right (32M+96K)
+        Pattern('0x67', 0x3fe0000,
+                2*GRANULARITY)]),     # Overwrite [(64M-128K)-64M)
+    PatternGroup([
+        # Batch 3: 8 clusters (5 new)
+        # Carefully chosen such that nothing re-dirties the one cluster
+        # that copies out successfully before failure in Group #1.
+        Pattern('0xaa', 0x0010000,
+                3*GRANULARITY),       # Overwrite and 2x Adjacent-right
+        Pattern('0xbb', 0x00d8000),   # Partial-left (1M-160K)
+        Pattern('0xcc', 0x2028000),   # Partial-right (32M+160K)
+        Pattern('0xdd', 0x3fc0000)]), # New; leaving a gap to the right
+]
+
+
+class EmulatedBitmap:
+    def __init__(self, granularity=3DGRANULARITY):
+        self._bits =3D set()
+        self.granularity =3D granularity
+
+    def dirty_bits(self, bits):
+        self._bits |=3D set(bits)
+
+    def dirty_group(self, n):
+        self.dirty_bits(GROUPS[n].bits(self.granularity))
+
+    def clear(self):
+        self._bits =3D set()
+
+    def clear_bits(self, bits):
+        self._bits -=3D set(bits)
+
+    def clear_bit(self, bit):
+        self.clear_bits({bit})
+
+    def clear_group(self, n):
+        self.clear_bits(GROUPS[n].bits(self.granularity))
+
+    @property
+    def first_bit(self):
+        return sorted(self.bits)[0]
+
+    @property
+    def bits(self):
+        return self._bits
+
+    @property
+    def count(self):
+        return len(self.bits)
+
+    def compare(self, qmp_bitmap):
+        """
+        Print a nice human-readable message checking that a bitmap as re=
ported
+        by the QMP interface has as many bits set as we expect it to.
+        """
+
+        name =3D qmp_bitmap.get('name', '(anonymous)')
+        log("=3D Checking Bitmap {:s} =3D".format(name))
+
+        want =3D self.count
+        have =3D qmp_bitmap['count'] // qmp_bitmap['granularity']
+
+        log("expecting {:d} dirty sectors; have {:d}. {:s}".format(
+            want, have, "OK!" if want =3D=3D have else "ERROR!"))
+        log('')
+
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
+def blockdev_mirror(vm, device, target, sync, **kwargs):
+    # Strip any arguments explicitly nulled by the caller:
+    kwargs =3D {key: val for key, val in kwargs.items() if val is not No=
ne}
+    result =3D vm.qmp_log('blockdev-mirror',
+                        device=3Ddevice,
+                        target=3Dtarget,
+                        sync=3Dsync,
+                        filter_node_name=3D'mirror-top',
+                        **kwargs)
+    return result
+
+def blockdev_mirror_mktarget(drive, target_id, filepath, sync, **kwargs)=
:
+    target_drive =3D Drive(filepath, vm=3Ddrive.vm)
+    target_drive.create_target(target_id, drive.fmt, drive.size)
+    blockdev_mirror(drive.vm, drive.node, target_id, sync, **kwargs)
+
+def reference_mirror(drive, n, filepath):
+    log("--- Reference mirror #{:d} ---\n".format(n))
+    target_id =3D "ref_target_{:d}".format(n)
+    job_id =3D "ref_mirror_{:d}".format(n)
+    blockdev_mirror_mktarget(drive, target_id, filepath, "full",
+                             job_id=3Djob_id)
+    drive.vm.run_job(job_id, auto_dismiss=3DTrue)
+    log('')
+
+def mirror(drive, n, filepath, sync, **kwargs):
+    log("--- Test mirror #{:d} ---\n".format(n))
+    target_id =3D "mirror_target_{:d}".format(n)
+    job_id =3D "mirror_{:d}".format(n)
+    kwargs.setdefault('auto-finalize', False)
+    blockdev_mirror_mktarget(drive, target_id, filepath, sync,
+                             job_id=3Djob_id, **kwargs)
+    return job_id
+
+def perform_writes(drive, n, filter_node_name=3DNone):
+    log("--- Write #{:d} ---\n".format(n))
+    for pattern in GROUPS[n].patterns:
+        cmd =3D "write -P{:s} 0x{:07x} 0x{:x}".format(
+            pattern.byte,
+            pattern.offset,
+            pattern.size)
+        log(cmd)
+        log(drive.vm.hmp_qemu_io(filter_node_name or drive.node, cmd))
+    bitmaps =3D drive.vm.query_bitmaps()
+    log({'bitmaps': bitmaps}, indent=3D2)
+    log('')
+    return bitmaps
+
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
+def test_bitmap_sync(bsync_mode, msync_mode=3D'bitmap', failure=3DNone):
+    """
+    Test bitmap mirror routines.
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
+    :param msync_mode: The mirror sync mode to use for the first mirror.
+                       Can be any one of:
+        - bitmap: mirrors based on bitmap manifest.
+        - full:   Full mirrors.
+        - top:    Full mirrors of the top layer only.
+
+    :param failure: Is the (optional) failure mode, and can be any of:
+        - None:         No failure. Test the normative path. Default.
+        - simulated:    Cancel the job right before it completes.
+                        This also tests writes "during" the job.
+        - intermediate: This tests a job that fails mid-process and prod=
uces
+                        an incomplete mirror. Testing limitations preven=
t
+                        testing competing writes.
+    """
+    with iotests.FilePaths(['img', 'bsync1', 'bsync2', 'bsync3',
+                            'fmirror0', 'fmirror1', 'fmirror2', 'fmirror=
3']) as \
+                            (img_path, bsync1, bsync2, bsync3,
+                             fmirror0, fmirror1, fmirror2, fmirror3), \
+         iotests.VM() as vm:
+
+        mode =3D "Mode {:s}; Bitmap Sync {:s}".format(msync_mode, bsync_=
mode)
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
+                }, {
+                    'event': 'read_aio',
+                    'state': 3,
+                    'new_state': 4
+                }],
+                'inject-error': [{
+                    'event': 'read_aio',
+                    'errno': 5,
+                    'state': 3,
+                    'immediately': False,
+                    'once': True
+                }, {
+                    'event': 'read_aio',
+                    'errno': 5,
+                    'state': 4,
+                    'immediately': False,
+                    'once': True
+                }]
+            }
+
+        drive0.node =3D 'drive0'
+        vm.qmp_log('blockdev-add',
+                   filters=3D[iotests.filter_qmp_testfiles],
+                   node_name=3Ddrive0.node,
+                   driver=3Ddrive0.fmt,
+                   file=3Dfile_config)
+        log('')
+
+        # 0 - Writes and Reference mirror
+        perform_writes(drive0, 0)
+        reference_mirror(drive0, 0, fmirror0)
+        log('--- Add Bitmap ---\n')
+        vm.qmp_log("block-dirty-bitmap-add", node=3Ddrive0.node,
+                   name=3D"bitmap0", granularity=3DGRANULARITY)
+        log('')
+        ebitmap =3D EmulatedBitmap()
+
+        # 1 - Writes and Reference mirror
+        bitmaps =3D perform_writes(drive0, 1)
+        ebitmap.dirty_group(1)
+        bitmap =3D vm.get_bitmap(drive0.node, 'bitmap0', bitmaps=3Dbitma=
ps)
+        ebitmap.compare(bitmap)
+        reference_mirror(drive0, 1, fmirror1)
+
+        # 1 - Test mirror (w/ Optional induced failure)
+        if failure =3D=3D 'intermediate':
+            # Activate blkdebug induced failure for second-to-next read
+            log(vm.hmp_qemu_io(drive0.node, 'flush'))
+            log('')
+        job =3D mirror(drive0, 1, bsync1, msync_mode,
+                     bitmap=3D"bitmap0", bitmap_mode=3Dbsync_mode)
+
+        vm.run_job(job, auto_dismiss=3DTrue, auto_finalize=3DFalse,
+                   cancel=3D(failure =3D=3D 'simulated'))
+        bitmaps =3D vm.query_bitmaps()
+        log({'bitmaps': bitmaps}, indent=3D2)
+        log('')
+
+        if bsync_mode =3D=3D 'always':
+            if failure =3D=3D 'intermediate':
+                # We manage to copy one sector (one bit) before the erro=
r.
+                ebitmap.clear_bit(ebitmap.first_bit)
+            else:
+                # successful mirror / cancelled complete mirror
+                ebitmap.clear()
+
+        if bsync_mode =3D=3D 'on-success' and not failure:
+            ebitmap.clear()
+
+        ebitmap.compare(vm.get_bitmap(drive0.node, 'bitmap0', bitmaps=3D=
bitmaps))
+
+        # 2 - Reference mirror
+        reference_mirror(drive0, 2, fmirror2)
+
+        # 2 - Bitmap mirror with writes before completion
+        job =3D mirror(drive0, 2, bsync2, "bitmap",
+                     bitmap=3D"bitmap0", bitmap_mode=3Dbsync_mode)
+
+        bitmaps =3D perform_writes(drive0, 2)
+        ebitmap.dirty_group(2)
+        ebitmap.compare(vm.get_bitmap(drive0.node, 'bitmap0', bitmaps=3D=
bitmaps))
+
+        # don't use run_job as that logs too much even with use_log=3DFa=
lse
+        events =3D [('JOB_STATUS_CHANGE', {'data': {'id': job}})]
+        while True:
+            ev =3D iotests.filter_qmp_event(vm.events_wait(events, timeo=
ut=3D10))
+            status =3D ev['data']['status']
+            if status =3D=3D 'ready':
+                vm.qmp('job-complete', id=3Djob)
+            elif status =3D=3D 'standby':
+                vm.qmp('job-resume', id=3Djob)
+            elif status =3D=3D 'pending':
+                vm.qmp('job-finalize', id=3Djob)
+            elif status =3D=3D 'null':
+                break
+
+        if bsync_mode !=3D 'never':
+            ebitmap.clear()
+
+        bitmaps =3D vm.query_bitmaps()
+        ebitmap.compare(vm.get_bitmap(drive0.node, 'bitmap0', bitmaps=3D=
bitmaps))
+
+        # 3 - Writes and Reference mirror
+        bitmaps =3D perform_writes(drive0, 3)
+        ebitmap.dirty_group(3)
+        ebitmap.compare(vm.get_bitmap(drive0.node, 'bitmap0', bitmaps=3D=
bitmaps))
+        reference_mirror(drive0, 3, fmirror3)
+
+        # 3 - Bitmap mirror (In failure modes, this is a recovery.)
+        job =3D mirror(drive0, 3, bsync3, "bitmap",
+                     bitmap=3D"bitmap0", bitmap_mode=3Dbsync_mode)
+
+        vm.run_job(job, auto_dismiss=3DTrue, auto_finalize=3DFalse)
+        bitmaps =3D vm.query_bitmaps()
+
+        log({'bitmaps': bitmaps}, indent=3D2)
+        log('')
+        if bsync_mode !=3D 'never':
+            ebitmap.clear()
+        ebitmap.compare(vm.get_bitmap(drive0.node, 'bitmap0', bitmaps=3D=
bitmaps))
+
+        log('--- Cleanup ---\n')
+        vm.qmp_log("block-dirty-bitmap-remove",
+                   node=3Ddrive0.node, name=3D"bitmap0")
+        bitmaps =3D vm.query_bitmaps()
+        log({'bitmaps': bitmaps}, indent=3D2)
+        vm.shutdown()
+        log('')
+
+        log('--- Verification ---\n')
+        compare_images(bsync1, fmirror1, baseimg=3Dfmirror0,
+                       expected_match=3Dfailure !=3D 'intermediate')
+        if not failure or bsync_mode =3D=3D 'always':
+            # Always keep the last mirror on success or when using 'alwa=
ys'
+            base =3D bsync1
+        else:
+            base =3D fmirror1
+
+        compare_images(bsync2, fmirror2, baseimg=3Dbase, expected_match=3D=
0)
+        compare_images(bsync3, fmirror3, baseimg=3Dbsync2)
+        compare_images(img_path, fmirror3)
+        log('')
+
+def test_mirror_api():
+    """
+    Test malformed and prohibited invocations of the mirror API.
+    """
+    with iotests.FilePaths(['img', 'bsync1']) as \
+         (img_path, mirror_path), \
+         iotests.VM() as vm:
+
+        log("\n=3D=3D=3D API failure tests =3D=3D=3D\n")
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
+        drive0.node =3D 'drive0'
+        vm.qmp_log('blockdev-add',
+                   filters=3D[iotests.filter_qmp_testfiles],
+                   node_name=3Ddrive0.node,
+                   driver=3Ddrive0.fmt,
+                   file=3Dfile_config)
+        log('')
+
+        target0 =3D Drive(mirror_path, vm=3Dvm)
+        target0.create_target("mirror_target", drive0.fmt, drive0.size)
+        log('')
+
+        vm.qmp_log("block-dirty-bitmap-add", node=3Ddrive0.node,
+                   name=3D"bitmap0", granularity=3DGRANULARITY)
+        log('')
+
+        log('-- Testing invalid QMP commands --\n')
+
+        error_cases =3D {
+            'incremental': {
+                None:        ['on-success', 'always', 'never', None],
+                'bitmap404': ['on-success', 'always', 'never', None],
+                'bitmap0':   ['always', 'never']
+            },
+            'bitmap': {
+                None:        ['on-success', 'always', 'never', None],
+                'bitmap404': ['on-success', 'always', 'never', None],
+                'bitmap0':   [None],
+            },
+            'full': {
+                None:        ['on-success', 'always', 'never'],
+                'bitmap404': ['on-success', 'always', 'never', None],
+                'bitmap0':   ['on-success', 'always', 'never', None],
+            },
+            'top': {
+                None:        ['on-success', 'always', 'never'],
+                'bitmap404': ['on-success', 'always', 'never', None],
+                'bitmap0':   ['on-success', 'always', 'never', None],
+            },
+            'none': {
+                None:        ['on-success', 'always', 'never'],
+                'bitmap404': ['on-success', 'always', 'never', None],
+                'bitmap0':   ['on-success', 'always', 'never', None],
+            }
+        }
+
+        # Dicts, as always, are not stably-ordered prior to 3.7, so use =
tuples:
+        for sync_mode in ('incremental', 'bitmap', 'full', 'top', 'none'=
):
+            log("-- Sync mode {:s} tests --\n".format(sync_mode))
+            for bitmap in (None, 'bitmap404', 'bitmap0'):
+                for policy in error_cases[sync_mode][bitmap]:
+                    blockdev_mirror(drive0.vm, drive0.node, "mirror_targ=
et",
+                                    sync_mode, job_id=3D'api_job',
+                                    bitmap=3Dbitmap, bitmap_mode=3Dpolic=
y)
+                    log('')
+
+
+def main():
+    for bsync_mode in ("never", "on-success", "always"):
+        for failure in ("simulated", "intermediate", None):
+            test_bitmap_sync(bsync_mode, "bitmap", failure)
+
+#    for sync_mode in ('full', 'top'):
+#        for bsync_mode in ('on-success', 'always'):
+#            for failure in ('simulated', 'intermediate', None):
+#                test_bitmap_sync(bsync_mode, sync_mode, failure)
+
+    test_mirror_api()
+
+if __name__ =3D=3D '__main__':
+    iotests.script_main(main, supported_fmts=3D['qcow2'],
+                        supported_protocols=3D['file'])
diff --git a/tests/qemu-iotests/284.out b/tests/qemu-iotests/284.out
new file mode 100644
index 0000000000..9b7408b6d6
--- /dev/null
+++ b/tests/qemu-iotests/284.out
@@ -0,0 +1,2846 @@
+
+=3D=3D=3D Mode bitmap; Bitmap Sync never with simulated failure =3D=3D=3D
+
+--- Preparing image & VM ---
+
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"d=
river": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
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
+  "bitmaps": {}
+}
+
+--- Reference mirror #0 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-mirror", "arguments": {"device": "drive0", "filter=
-node-name": "mirror-top", "job-id": "ref_mirror_0", "sync": "full", "tar=
get": "ref_target_0"}}
+{"return": {}}
+{"execute": "job-complete", "arguments": {"id": "ref_mirror_0"}}
+{"return": {}}
+{"data": {"device": "ref_mirror_0", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_READY", "timestamp": =
{"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "ref_mirror_0", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
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
+    "drive0": [
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
+--- Reference mirror #1 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-mirror", "arguments": {"device": "drive0", "filter=
-node-name": "mirror-top", "job-id": "ref_mirror_1", "sync": "full", "tar=
get": "ref_target_1"}}
+{"return": {}}
+{"execute": "job-complete", "arguments": {"id": "ref_mirror_1"}}
+{"return": {}}
+{"data": {"device": "ref_mirror_1", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_READY", "timestamp": =
{"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "ref_mirror_1", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
+
+--- Test mirror #1 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-mirror", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "never", "device": "drive0", "filter-nod=
e-name": "mirror-top", "job-id": "mirror_1", "sync": "bitmap", "target": =
"mirror_target_1"}}
+{"return": {}}
+{"execute": "job-complete", "arguments": {"id": "mirror_1"}}
+{"return": {}}
+{"data": {"device": "mirror_1", "len": 393216, "offset": 393216, "speed"=
: 0, "type": "mirror"}, "event": "BLOCK_JOB_READY", "timestamp": {"micros=
econds": "USECS", "seconds": "SECS"}}
+{"execute": "job-cancel", "arguments": {"id": "mirror_1"}}
+{"return": {}}
+{"data": {"id": "mirror_1", "type": "mirror"}, "event": "BLOCK_JOB_PENDI=
NG", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "mirror_1", "len": 393216, "offset": 393216, "speed"=
: 0, "type": "mirror"}, "event": "BLOCK_JOB_CANCELLED", "timestamp": {"mi=
croseconds": "USECS", "seconds": "SECS"}}
+{
+  "bitmaps": {
+    "drive0": [
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
+--- Reference mirror #2 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-mirror", "arguments": {"device": "drive0", "filter=
-node-name": "mirror-top", "job-id": "ref_mirror_2", "sync": "full", "tar=
get": "ref_target_2"}}
+{"return": {}}
+{"execute": "job-complete", "arguments": {"id": "ref_mirror_2"}}
+{"return": {}}
+{"data": {"device": "ref_mirror_2", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_READY", "timestamp": =
{"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "ref_mirror_2", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
+
+--- Test mirror #2 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-mirror", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "never", "device": "drive0", "filter-nod=
e-name": "mirror-top", "job-id": "mirror_2", "sync": "bitmap", "target": =
"mirror_target_2"}}
+{"return": {}}
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
+    "drive0": [
+      {
+        "busy": false,
+        "count": 262144,
+        "granularity": 65536,
+        "persistent": false,
+        "recording": true,
+        "status": "active"
+      },
+      {
+        "busy": true,
+        "count": 655360,
+        "granularity": 65536,
+        "name": "bitmap0",
+        "persistent": false,
+        "recording": true,
+        "status": "locked"
+      }
+    ]
+  }
+}
+
+=3D Checking Bitmap bitmap0 =3D
+expecting 10 dirty sectors; have 10. OK!
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
+    "drive0": [
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
+--- Reference mirror #3 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-mirror", "arguments": {"device": "drive0", "filter=
-node-name": "mirror-top", "job-id": "ref_mirror_3", "sync": "full", "tar=
get": "ref_target_3"}}
+{"return": {}}
+{"execute": "job-complete", "arguments": {"id": "ref_mirror_3"}}
+{"return": {}}
+{"data": {"device": "ref_mirror_3", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_READY", "timestamp": =
{"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "ref_mirror_3", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
+
+--- Test mirror #3 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-mirror", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "never", "device": "drive0", "filter-nod=
e-name": "mirror-top", "job-id": "mirror_3", "sync": "bitmap", "target": =
"mirror_target_3"}}
+{"return": {}}
+{"execute": "job-complete", "arguments": {"id": "mirror_3"}}
+{"return": {}}
+{"data": {"device": "mirror_3", "len": 983040, "offset": 983040, "speed"=
: 0, "type": "mirror"}, "event": "BLOCK_JOB_READY", "timestamp": {"micros=
econds": "USECS", "seconds": "SECS"}}
+{"execute": "job-finalize", "arguments": {"id": "mirror_3"}}
+{"return": {}}
+{"data": {"id": "mirror_3", "type": "mirror"}, "event": "BLOCK_JOB_PENDI=
NG", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "mirror_3", "len": 983040, "offset": 983040, "speed"=
: 0, "type": "mirror"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"mi=
croseconds": "USECS", "seconds": "SECS"}}
+{
+  "bitmaps": {
+    "drive0": [
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
+  "bitmaps": {}
+}
+
+--- Verification ---
+
+qemu_img compare "TEST_DIR/PID-bsync1" "TEST_DIR/PID-fmirror1" =3D=3D> I=
dentical, OK!
+qemu_img compare "TEST_DIR/PID-bsync2" "TEST_DIR/PID-fmirror2" =3D=3D> M=
ismatch, OK!
+qemu_img compare "TEST_DIR/PID-bsync3" "TEST_DIR/PID-fmirror3" =3D=3D> I=
dentical, OK!
+qemu_img compare "TEST_DIR/PID-img" "TEST_DIR/PID-fmirror3" =3D=3D> Iden=
tical, OK!
+
+
+=3D=3D=3D Mode bitmap; Bitmap Sync never with intermediate failure =3D=3D=
=3D
+
+--- Preparing image & VM ---
+
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"d=
river": "blkdebug", "image": {"driver": "file", "filename": "TEST_DIR/PID=
-img"}, "inject-error": [{"errno": 5, "event": "read_aio", "immediately":=
 false, "once": true, "state": 3}, {"errno": 5, "event": "read_aio", "imm=
ediately": false, "once": true, "state": 4}], "set-state": [{"event": "fl=
ush_to_disk", "new-state": 2, "state": 1}, {"event": "read_aio", "new-sta=
te": 3, "state": 2}, {"event": "read_aio", "new-state": 4, "state": 3}]},=
 "node-name": "drive0"}}
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
+  "bitmaps": {}
+}
+
+--- Reference mirror #0 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-mirror", "arguments": {"device": "drive0", "filter=
-node-name": "mirror-top", "job-id": "ref_mirror_0", "sync": "full", "tar=
get": "ref_target_0"}}
+{"return": {}}
+{"execute": "job-complete", "arguments": {"id": "ref_mirror_0"}}
+{"return": {}}
+{"data": {"device": "ref_mirror_0", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_READY", "timestamp": =
{"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "ref_mirror_0", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
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
+    "drive0": [
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
+--- Reference mirror #1 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-mirror", "arguments": {"device": "drive0", "filter=
-node-name": "mirror-top", "job-id": "ref_mirror_1", "sync": "full", "tar=
get": "ref_target_1"}}
+{"return": {}}
+{"execute": "job-complete", "arguments": {"id": "ref_mirror_1"}}
+{"return": {}}
+{"data": {"device": "ref_mirror_1", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_READY", "timestamp": =
{"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "ref_mirror_1", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
+
+{"return": ""}
+
+--- Test mirror #1 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-mirror", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "never", "device": "drive0", "filter-nod=
e-name": "mirror-top", "job-id": "mirror_1", "sync": "bitmap", "target": =
"mirror_target_1"}}
+{"return": {}}
+{"data": {"action": "report", "device": "mirror_1", "operation": "read"}=
, "event": "BLOCK_JOB_ERROR", "timestamp": {"microseconds": "USECS", "sec=
onds": "SECS"}}
+{"data": {"action": "report", "device": "mirror_1", "operation": "read"}=
, "event": "BLOCK_JOB_ERROR", "timestamp": {"microseconds": "USECS", "sec=
onds": "SECS"}}
+{"data": {"device": "mirror_1", "error": "Input/output error", "len": 39=
3216, "offset": 65536, "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB=
_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{
+  "bitmaps": {
+    "drive0": [
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
+--- Reference mirror #2 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-mirror", "arguments": {"device": "drive0", "filter=
-node-name": "mirror-top", "job-id": "ref_mirror_2", "sync": "full", "tar=
get": "ref_target_2"}}
+{"return": {}}
+{"execute": "job-complete", "arguments": {"id": "ref_mirror_2"}}
+{"return": {}}
+{"data": {"device": "ref_mirror_2", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_READY", "timestamp": =
{"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "ref_mirror_2", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
+
+--- Test mirror #2 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-mirror", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "never", "device": "drive0", "filter-nod=
e-name": "mirror-top", "job-id": "mirror_2", "sync": "bitmap", "target": =
"mirror_target_2"}}
+{"return": {}}
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
+    "drive0": [
+      {
+        "busy": false,
+        "count": 262144,
+        "granularity": 65536,
+        "persistent": false,
+        "recording": true,
+        "status": "active"
+      },
+      {
+        "busy": true,
+        "count": 655360,
+        "granularity": 65536,
+        "name": "bitmap0",
+        "persistent": false,
+        "recording": true,
+        "status": "locked"
+      }
+    ]
+  }
+}
+
+=3D Checking Bitmap bitmap0 =3D
+expecting 10 dirty sectors; have 10. OK!
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
+    "drive0": [
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
+--- Reference mirror #3 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-mirror", "arguments": {"device": "drive0", "filter=
-node-name": "mirror-top", "job-id": "ref_mirror_3", "sync": "full", "tar=
get": "ref_target_3"}}
+{"return": {}}
+{"execute": "job-complete", "arguments": {"id": "ref_mirror_3"}}
+{"return": {}}
+{"data": {"device": "ref_mirror_3", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_READY", "timestamp": =
{"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "ref_mirror_3", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
+
+--- Test mirror #3 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-mirror", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "never", "device": "drive0", "filter-nod=
e-name": "mirror-top", "job-id": "mirror_3", "sync": "bitmap", "target": =
"mirror_target_3"}}
+{"return": {}}
+{"execute": "job-complete", "arguments": {"id": "mirror_3"}}
+{"return": {}}
+{"data": {"device": "mirror_3", "len": 983040, "offset": 983040, "speed"=
: 0, "type": "mirror"}, "event": "BLOCK_JOB_READY", "timestamp": {"micros=
econds": "USECS", "seconds": "SECS"}}
+{"execute": "job-finalize", "arguments": {"id": "mirror_3"}}
+{"return": {}}
+{"data": {"id": "mirror_3", "type": "mirror"}, "event": "BLOCK_JOB_PENDI=
NG", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "mirror_3", "len": 983040, "offset": 983040, "speed"=
: 0, "type": "mirror"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"mi=
croseconds": "USECS", "seconds": "SECS"}}
+{
+  "bitmaps": {
+    "drive0": [
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
+  "bitmaps": {}
+}
+
+--- Verification ---
+
+qemu_img compare "TEST_DIR/PID-bsync1" "TEST_DIR/PID-fmirror1" =3D=3D> M=
ismatch, OK!
+qemu_img compare "TEST_DIR/PID-bsync2" "TEST_DIR/PID-fmirror2" =3D=3D> M=
ismatch, OK!
+qemu_img compare "TEST_DIR/PID-bsync3" "TEST_DIR/PID-fmirror3" =3D=3D> I=
dentical, OK!
+qemu_img compare "TEST_DIR/PID-img" "TEST_DIR/PID-fmirror3" =3D=3D> Iden=
tical, OK!
+
+
+=3D=3D=3D Mode bitmap; Bitmap Sync never without failure =3D=3D=3D
+
+--- Preparing image & VM ---
+
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"d=
river": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
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
+  "bitmaps": {}
+}
+
+--- Reference mirror #0 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-mirror", "arguments": {"device": "drive0", "filter=
-node-name": "mirror-top", "job-id": "ref_mirror_0", "sync": "full", "tar=
get": "ref_target_0"}}
+{"return": {}}
+{"execute": "job-complete", "arguments": {"id": "ref_mirror_0"}}
+{"return": {}}
+{"data": {"device": "ref_mirror_0", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_READY", "timestamp": =
{"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "ref_mirror_0", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
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
+    "drive0": [
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
+--- Reference mirror #1 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-mirror", "arguments": {"device": "drive0", "filter=
-node-name": "mirror-top", "job-id": "ref_mirror_1", "sync": "full", "tar=
get": "ref_target_1"}}
+{"return": {}}
+{"execute": "job-complete", "arguments": {"id": "ref_mirror_1"}}
+{"return": {}}
+{"data": {"device": "ref_mirror_1", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_READY", "timestamp": =
{"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "ref_mirror_1", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
+
+--- Test mirror #1 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-mirror", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "never", "device": "drive0", "filter-nod=
e-name": "mirror-top", "job-id": "mirror_1", "sync": "bitmap", "target": =
"mirror_target_1"}}
+{"return": {}}
+{"execute": "job-complete", "arguments": {"id": "mirror_1"}}
+{"return": {}}
+{"data": {"device": "mirror_1", "len": 393216, "offset": 393216, "speed"=
: 0, "type": "mirror"}, "event": "BLOCK_JOB_READY", "timestamp": {"micros=
econds": "USECS", "seconds": "SECS"}}
+{"execute": "job-finalize", "arguments": {"id": "mirror_1"}}
+{"return": {}}
+{"data": {"id": "mirror_1", "type": "mirror"}, "event": "BLOCK_JOB_PENDI=
NG", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "mirror_1", "len": 393216, "offset": 393216, "speed"=
: 0, "type": "mirror"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"mi=
croseconds": "USECS", "seconds": "SECS"}}
+{
+  "bitmaps": {
+    "drive0": [
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
+--- Reference mirror #2 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-mirror", "arguments": {"device": "drive0", "filter=
-node-name": "mirror-top", "job-id": "ref_mirror_2", "sync": "full", "tar=
get": "ref_target_2"}}
+{"return": {}}
+{"execute": "job-complete", "arguments": {"id": "ref_mirror_2"}}
+{"return": {}}
+{"data": {"device": "ref_mirror_2", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_READY", "timestamp": =
{"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "ref_mirror_2", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
+
+--- Test mirror #2 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-mirror", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "never", "device": "drive0", "filter-nod=
e-name": "mirror-top", "job-id": "mirror_2", "sync": "bitmap", "target": =
"mirror_target_2"}}
+{"return": {}}
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
+    "drive0": [
+      {
+        "busy": false,
+        "count": 262144,
+        "granularity": 65536,
+        "persistent": false,
+        "recording": true,
+        "status": "active"
+      },
+      {
+        "busy": true,
+        "count": 655360,
+        "granularity": 65536,
+        "name": "bitmap0",
+        "persistent": false,
+        "recording": true,
+        "status": "locked"
+      }
+    ]
+  }
+}
+
+=3D Checking Bitmap bitmap0 =3D
+expecting 10 dirty sectors; have 10. OK!
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
+    "drive0": [
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
+--- Reference mirror #3 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-mirror", "arguments": {"device": "drive0", "filter=
-node-name": "mirror-top", "job-id": "ref_mirror_3", "sync": "full", "tar=
get": "ref_target_3"}}
+{"return": {}}
+{"execute": "job-complete", "arguments": {"id": "ref_mirror_3"}}
+{"return": {}}
+{"data": {"device": "ref_mirror_3", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_READY", "timestamp": =
{"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "ref_mirror_3", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
+
+--- Test mirror #3 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-mirror", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "never", "device": "drive0", "filter-nod=
e-name": "mirror-top", "job-id": "mirror_3", "sync": "bitmap", "target": =
"mirror_target_3"}}
+{"return": {}}
+{"execute": "job-complete", "arguments": {"id": "mirror_3"}}
+{"return": {}}
+{"data": {"device": "mirror_3", "len": 983040, "offset": 983040, "speed"=
: 0, "type": "mirror"}, "event": "BLOCK_JOB_READY", "timestamp": {"micros=
econds": "USECS", "seconds": "SECS"}}
+{"execute": "job-finalize", "arguments": {"id": "mirror_3"}}
+{"return": {}}
+{"data": {"id": "mirror_3", "type": "mirror"}, "event": "BLOCK_JOB_PENDI=
NG", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "mirror_3", "len": 983040, "offset": 983040, "speed"=
: 0, "type": "mirror"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"mi=
croseconds": "USECS", "seconds": "SECS"}}
+{
+  "bitmaps": {
+    "drive0": [
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
+  "bitmaps": {}
+}
+
+--- Verification ---
+
+qemu_img compare "TEST_DIR/PID-bsync1" "TEST_DIR/PID-fmirror1" =3D=3D> I=
dentical, OK!
+qemu_img compare "TEST_DIR/PID-bsync2" "TEST_DIR/PID-fmirror2" =3D=3D> M=
ismatch, OK!
+qemu_img compare "TEST_DIR/PID-bsync3" "TEST_DIR/PID-fmirror3" =3D=3D> I=
dentical, OK!
+qemu_img compare "TEST_DIR/PID-img" "TEST_DIR/PID-fmirror3" =3D=3D> Iden=
tical, OK!
+
+
+=3D=3D=3D Mode bitmap; Bitmap Sync on-success with simulated failure =3D=
=3D=3D
+
+--- Preparing image & VM ---
+
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"d=
river": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
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
+  "bitmaps": {}
+}
+
+--- Reference mirror #0 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-mirror", "arguments": {"device": "drive0", "filter=
-node-name": "mirror-top", "job-id": "ref_mirror_0", "sync": "full", "tar=
get": "ref_target_0"}}
+{"return": {}}
+{"execute": "job-complete", "arguments": {"id": "ref_mirror_0"}}
+{"return": {}}
+{"data": {"device": "ref_mirror_0", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_READY", "timestamp": =
{"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "ref_mirror_0", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
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
+    "drive0": [
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
+--- Reference mirror #1 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-mirror", "arguments": {"device": "drive0", "filter=
-node-name": "mirror-top", "job-id": "ref_mirror_1", "sync": "full", "tar=
get": "ref_target_1"}}
+{"return": {}}
+{"execute": "job-complete", "arguments": {"id": "ref_mirror_1"}}
+{"return": {}}
+{"data": {"device": "ref_mirror_1", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_READY", "timestamp": =
{"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "ref_mirror_1", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
+
+--- Test mirror #1 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-mirror", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "on-success", "device": "drive0", "filte=
r-node-name": "mirror-top", "job-id": "mirror_1", "sync": "bitmap", "targ=
et": "mirror_target_1"}}
+{"return": {}}
+{"execute": "job-complete", "arguments": {"id": "mirror_1"}}
+{"return": {}}
+{"data": {"device": "mirror_1", "len": 393216, "offset": 393216, "speed"=
: 0, "type": "mirror"}, "event": "BLOCK_JOB_READY", "timestamp": {"micros=
econds": "USECS", "seconds": "SECS"}}
+{"execute": "job-cancel", "arguments": {"id": "mirror_1"}}
+{"return": {}}
+{"data": {"id": "mirror_1", "type": "mirror"}, "event": "BLOCK_JOB_PENDI=
NG", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "mirror_1", "len": 393216, "offset": 393216, "speed"=
: 0, "type": "mirror"}, "event": "BLOCK_JOB_CANCELLED", "timestamp": {"mi=
croseconds": "USECS", "seconds": "SECS"}}
+{
+  "bitmaps": {
+    "drive0": [
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
+--- Reference mirror #2 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-mirror", "arguments": {"device": "drive0", "filter=
-node-name": "mirror-top", "job-id": "ref_mirror_2", "sync": "full", "tar=
get": "ref_target_2"}}
+{"return": {}}
+{"execute": "job-complete", "arguments": {"id": "ref_mirror_2"}}
+{"return": {}}
+{"data": {"device": "ref_mirror_2", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_READY", "timestamp": =
{"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "ref_mirror_2", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
+
+--- Test mirror #2 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-mirror", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "on-success", "device": "drive0", "filte=
r-node-name": "mirror-top", "job-id": "mirror_2", "sync": "bitmap", "targ=
et": "mirror_target_2"}}
+{"return": {}}
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
+    "drive0": [
+      {
+        "busy": false,
+        "count": 262144,
+        "granularity": 65536,
+        "persistent": false,
+        "recording": true,
+        "status": "active"
+      },
+      {
+        "busy": true,
+        "count": 655360,
+        "granularity": 65536,
+        "name": "bitmap0",
+        "persistent": false,
+        "recording": true,
+        "status": "locked"
+      }
+    ]
+  }
+}
+
+=3D Checking Bitmap bitmap0 =3D
+expecting 10 dirty sectors; have 10. OK!
+
+=3D Checking Bitmap bitmap0 =3D
+expecting 0 dirty sectors; have 0. OK!
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
+    "drive0": [
+      {
+        "busy": false,
+        "count": 524288,
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
+expecting 8 dirty sectors; have 8. OK!
+
+--- Reference mirror #3 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-mirror", "arguments": {"device": "drive0", "filter=
-node-name": "mirror-top", "job-id": "ref_mirror_3", "sync": "full", "tar=
get": "ref_target_3"}}
+{"return": {}}
+{"execute": "job-complete", "arguments": {"id": "ref_mirror_3"}}
+{"return": {}}
+{"data": {"device": "ref_mirror_3", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_READY", "timestamp": =
{"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "ref_mirror_3", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
+
+--- Test mirror #3 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-mirror", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "on-success", "device": "drive0", "filte=
r-node-name": "mirror-top", "job-id": "mirror_3", "sync": "bitmap", "targ=
et": "mirror_target_3"}}
+{"return": {}}
+{"execute": "job-complete", "arguments": {"id": "mirror_3"}}
+{"return": {}}
+{"data": {"device": "mirror_3", "len": 524288, "offset": 524288, "speed"=
: 0, "type": "mirror"}, "event": "BLOCK_JOB_READY", "timestamp": {"micros=
econds": "USECS", "seconds": "SECS"}}
+{"execute": "job-finalize", "arguments": {"id": "mirror_3"}}
+{"return": {}}
+{"data": {"id": "mirror_3", "type": "mirror"}, "event": "BLOCK_JOB_PENDI=
NG", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "mirror_3", "len": 524288, "offset": 524288, "speed"=
: 0, "type": "mirror"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"mi=
croseconds": "USECS", "seconds": "SECS"}}
+{
+  "bitmaps": {
+    "drive0": [
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
+  "bitmaps": {}
+}
+
+--- Verification ---
+
+qemu_img compare "TEST_DIR/PID-bsync1" "TEST_DIR/PID-fmirror1" =3D=3D> I=
dentical, OK!
+qemu_img compare "TEST_DIR/PID-bsync2" "TEST_DIR/PID-fmirror2" =3D=3D> M=
ismatch, OK!
+qemu_img compare "TEST_DIR/PID-bsync3" "TEST_DIR/PID-fmirror3" =3D=3D> I=
dentical, OK!
+qemu_img compare "TEST_DIR/PID-img" "TEST_DIR/PID-fmirror3" =3D=3D> Iden=
tical, OK!
+
+
+=3D=3D=3D Mode bitmap; Bitmap Sync on-success with intermediate failure =
=3D=3D=3D
+
+--- Preparing image & VM ---
+
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"d=
river": "blkdebug", "image": {"driver": "file", "filename": "TEST_DIR/PID=
-img"}, "inject-error": [{"errno": 5, "event": "read_aio", "immediately":=
 false, "once": true, "state": 3}, {"errno": 5, "event": "read_aio", "imm=
ediately": false, "once": true, "state": 4}], "set-state": [{"event": "fl=
ush_to_disk", "new-state": 2, "state": 1}, {"event": "read_aio", "new-sta=
te": 3, "state": 2}, {"event": "read_aio", "new-state": 4, "state": 3}]},=
 "node-name": "drive0"}}
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
+  "bitmaps": {}
+}
+
+--- Reference mirror #0 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-mirror", "arguments": {"device": "drive0", "filter=
-node-name": "mirror-top", "job-id": "ref_mirror_0", "sync": "full", "tar=
get": "ref_target_0"}}
+{"return": {}}
+{"execute": "job-complete", "arguments": {"id": "ref_mirror_0"}}
+{"return": {}}
+{"data": {"device": "ref_mirror_0", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_READY", "timestamp": =
{"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "ref_mirror_0", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
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
+    "drive0": [
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
+--- Reference mirror #1 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-mirror", "arguments": {"device": "drive0", "filter=
-node-name": "mirror-top", "job-id": "ref_mirror_1", "sync": "full", "tar=
get": "ref_target_1"}}
+{"return": {}}
+{"execute": "job-complete", "arguments": {"id": "ref_mirror_1"}}
+{"return": {}}
+{"data": {"device": "ref_mirror_1", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_READY", "timestamp": =
{"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "ref_mirror_1", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
+
+{"return": ""}
+
+--- Test mirror #1 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-mirror", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "on-success", "device": "drive0", "filte=
r-node-name": "mirror-top", "job-id": "mirror_1", "sync": "bitmap", "targ=
et": "mirror_target_1"}}
+{"return": {}}
+{"data": {"action": "report", "device": "mirror_1", "operation": "read"}=
, "event": "BLOCK_JOB_ERROR", "timestamp": {"microseconds": "USECS", "sec=
onds": "SECS"}}
+{"data": {"action": "report", "device": "mirror_1", "operation": "read"}=
, "event": "BLOCK_JOB_ERROR", "timestamp": {"microseconds": "USECS", "sec=
onds": "SECS"}}
+{"data": {"device": "mirror_1", "error": "Input/output error", "len": 39=
3216, "offset": 65536, "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB=
_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{
+  "bitmaps": {
+    "drive0": [
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
+--- Reference mirror #2 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-mirror", "arguments": {"device": "drive0", "filter=
-node-name": "mirror-top", "job-id": "ref_mirror_2", "sync": "full", "tar=
get": "ref_target_2"}}
+{"return": {}}
+{"execute": "job-complete", "arguments": {"id": "ref_mirror_2"}}
+{"return": {}}
+{"data": {"device": "ref_mirror_2", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_READY", "timestamp": =
{"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "ref_mirror_2", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
+
+--- Test mirror #2 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-mirror", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "on-success", "device": "drive0", "filte=
r-node-name": "mirror-top", "job-id": "mirror_2", "sync": "bitmap", "targ=
et": "mirror_target_2"}}
+{"return": {}}
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
+    "drive0": [
+      {
+        "busy": false,
+        "count": 262144,
+        "granularity": 65536,
+        "persistent": false,
+        "recording": true,
+        "status": "active"
+      },
+      {
+        "busy": true,
+        "count": 655360,
+        "granularity": 65536,
+        "name": "bitmap0",
+        "persistent": false,
+        "recording": true,
+        "status": "locked"
+      }
+    ]
+  }
+}
+
+=3D Checking Bitmap bitmap0 =3D
+expecting 10 dirty sectors; have 10. OK!
+
+=3D Checking Bitmap bitmap0 =3D
+expecting 0 dirty sectors; have 0. OK!
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
+    "drive0": [
+      {
+        "busy": false,
+        "count": 524288,
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
+expecting 8 dirty sectors; have 8. OK!
+
+--- Reference mirror #3 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-mirror", "arguments": {"device": "drive0", "filter=
-node-name": "mirror-top", "job-id": "ref_mirror_3", "sync": "full", "tar=
get": "ref_target_3"}}
+{"return": {}}
+{"execute": "job-complete", "arguments": {"id": "ref_mirror_3"}}
+{"return": {}}
+{"data": {"device": "ref_mirror_3", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_READY", "timestamp": =
{"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "ref_mirror_3", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
+
+--- Test mirror #3 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-mirror", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "on-success", "device": "drive0", "filte=
r-node-name": "mirror-top", "job-id": "mirror_3", "sync": "bitmap", "targ=
et": "mirror_target_3"}}
+{"return": {}}
+{"execute": "job-complete", "arguments": {"id": "mirror_3"}}
+{"return": {}}
+{"data": {"device": "mirror_3", "len": 524288, "offset": 524288, "speed"=
: 0, "type": "mirror"}, "event": "BLOCK_JOB_READY", "timestamp": {"micros=
econds": "USECS", "seconds": "SECS"}}
+{"execute": "job-finalize", "arguments": {"id": "mirror_3"}}
+{"return": {}}
+{"data": {"id": "mirror_3", "type": "mirror"}, "event": "BLOCK_JOB_PENDI=
NG", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "mirror_3", "len": 524288, "offset": 524288, "speed"=
: 0, "type": "mirror"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"mi=
croseconds": "USECS", "seconds": "SECS"}}
+{
+  "bitmaps": {
+    "drive0": [
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
+  "bitmaps": {}
+}
+
+--- Verification ---
+
+qemu_img compare "TEST_DIR/PID-bsync1" "TEST_DIR/PID-fmirror1" =3D=3D> M=
ismatch, OK!
+qemu_img compare "TEST_DIR/PID-bsync2" "TEST_DIR/PID-fmirror2" =3D=3D> M=
ismatch, OK!
+qemu_img compare "TEST_DIR/PID-bsync3" "TEST_DIR/PID-fmirror3" =3D=3D> I=
dentical, OK!
+qemu_img compare "TEST_DIR/PID-img" "TEST_DIR/PID-fmirror3" =3D=3D> Iden=
tical, OK!
+
+
+=3D=3D=3D Mode bitmap; Bitmap Sync on-success without failure =3D=3D=3D
+
+--- Preparing image & VM ---
+
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"d=
river": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
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
+  "bitmaps": {}
+}
+
+--- Reference mirror #0 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-mirror", "arguments": {"device": "drive0", "filter=
-node-name": "mirror-top", "job-id": "ref_mirror_0", "sync": "full", "tar=
get": "ref_target_0"}}
+{"return": {}}
+{"execute": "job-complete", "arguments": {"id": "ref_mirror_0"}}
+{"return": {}}
+{"data": {"device": "ref_mirror_0", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_READY", "timestamp": =
{"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "ref_mirror_0", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
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
+    "drive0": [
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
+--- Reference mirror #1 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-mirror", "arguments": {"device": "drive0", "filter=
-node-name": "mirror-top", "job-id": "ref_mirror_1", "sync": "full", "tar=
get": "ref_target_1"}}
+{"return": {}}
+{"execute": "job-complete", "arguments": {"id": "ref_mirror_1"}}
+{"return": {}}
+{"data": {"device": "ref_mirror_1", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_READY", "timestamp": =
{"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "ref_mirror_1", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
+
+--- Test mirror #1 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-mirror", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "on-success", "device": "drive0", "filte=
r-node-name": "mirror-top", "job-id": "mirror_1", "sync": "bitmap", "targ=
et": "mirror_target_1"}}
+{"return": {}}
+{"execute": "job-complete", "arguments": {"id": "mirror_1"}}
+{"return": {}}
+{"data": {"device": "mirror_1", "len": 393216, "offset": 393216, "speed"=
: 0, "type": "mirror"}, "event": "BLOCK_JOB_READY", "timestamp": {"micros=
econds": "USECS", "seconds": "SECS"}}
+{"execute": "job-finalize", "arguments": {"id": "mirror_1"}}
+{"return": {}}
+{"data": {"id": "mirror_1", "type": "mirror"}, "event": "BLOCK_JOB_PENDI=
NG", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "mirror_1", "len": 393216, "offset": 393216, "speed"=
: 0, "type": "mirror"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"mi=
croseconds": "USECS", "seconds": "SECS"}}
+{
+  "bitmaps": {
+    "drive0": [
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
+--- Reference mirror #2 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-mirror", "arguments": {"device": "drive0", "filter=
-node-name": "mirror-top", "job-id": "ref_mirror_2", "sync": "full", "tar=
get": "ref_target_2"}}
+{"return": {}}
+{"execute": "job-complete", "arguments": {"id": "ref_mirror_2"}}
+{"return": {}}
+{"data": {"device": "ref_mirror_2", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_READY", "timestamp": =
{"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "ref_mirror_2", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
+
+--- Test mirror #2 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-mirror", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "on-success", "device": "drive0", "filte=
r-node-name": "mirror-top", "job-id": "mirror_2", "sync": "bitmap", "targ=
et": "mirror_target_2"}}
+{"return": {}}
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
+    "drive0": [
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
+        "count": 458752,
+        "granularity": 65536,
+        "name": "bitmap0",
+        "persistent": false,
+        "recording": true,
+        "status": "locked"
+      }
+    ]
+  }
+}
+
+=3D Checking Bitmap bitmap0 =3D
+expecting 7 dirty sectors; have 7. OK!
+
+=3D Checking Bitmap bitmap0 =3D
+expecting 0 dirty sectors; have 0. OK!
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
+    "drive0": [
+      {
+        "busy": false,
+        "count": 524288,
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
+expecting 8 dirty sectors; have 8. OK!
+
+--- Reference mirror #3 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-mirror", "arguments": {"device": "drive0", "filter=
-node-name": "mirror-top", "job-id": "ref_mirror_3", "sync": "full", "tar=
get": "ref_target_3"}}
+{"return": {}}
+{"execute": "job-complete", "arguments": {"id": "ref_mirror_3"}}
+{"return": {}}
+{"data": {"device": "ref_mirror_3", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_READY", "timestamp": =
{"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "ref_mirror_3", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
+
+--- Test mirror #3 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-mirror", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "on-success", "device": "drive0", "filte=
r-node-name": "mirror-top", "job-id": "mirror_3", "sync": "bitmap", "targ=
et": "mirror_target_3"}}
+{"return": {}}
+{"execute": "job-complete", "arguments": {"id": "mirror_3"}}
+{"return": {}}
+{"data": {"device": "mirror_3", "len": 524288, "offset": 524288, "speed"=
: 0, "type": "mirror"}, "event": "BLOCK_JOB_READY", "timestamp": {"micros=
econds": "USECS", "seconds": "SECS"}}
+{"execute": "job-finalize", "arguments": {"id": "mirror_3"}}
+{"return": {}}
+{"data": {"id": "mirror_3", "type": "mirror"}, "event": "BLOCK_JOB_PENDI=
NG", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "mirror_3", "len": 524288, "offset": 524288, "speed"=
: 0, "type": "mirror"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"mi=
croseconds": "USECS", "seconds": "SECS"}}
+{
+  "bitmaps": {
+    "drive0": [
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
+  "bitmaps": {}
+}
+
+--- Verification ---
+
+qemu_img compare "TEST_DIR/PID-bsync1" "TEST_DIR/PID-fmirror1" =3D=3D> I=
dentical, OK!
+qemu_img compare "TEST_DIR/PID-bsync2" "TEST_DIR/PID-fmirror2" =3D=3D> M=
ismatch, OK!
+qemu_img compare "TEST_DIR/PID-bsync3" "TEST_DIR/PID-fmirror3" =3D=3D> I=
dentical, OK!
+qemu_img compare "TEST_DIR/PID-img" "TEST_DIR/PID-fmirror3" =3D=3D> Iden=
tical, OK!
+
+
+=3D=3D=3D Mode bitmap; Bitmap Sync always with simulated failure =3D=3D=3D
+
+--- Preparing image & VM ---
+
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"d=
river": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
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
+  "bitmaps": {}
+}
+
+--- Reference mirror #0 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-mirror", "arguments": {"device": "drive0", "filter=
-node-name": "mirror-top", "job-id": "ref_mirror_0", "sync": "full", "tar=
get": "ref_target_0"}}
+{"return": {}}
+{"execute": "job-complete", "arguments": {"id": "ref_mirror_0"}}
+{"return": {}}
+{"data": {"device": "ref_mirror_0", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_READY", "timestamp": =
{"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "ref_mirror_0", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
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
+    "drive0": [
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
+--- Reference mirror #1 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-mirror", "arguments": {"device": "drive0", "filter=
-node-name": "mirror-top", "job-id": "ref_mirror_1", "sync": "full", "tar=
get": "ref_target_1"}}
+{"return": {}}
+{"execute": "job-complete", "arguments": {"id": "ref_mirror_1"}}
+{"return": {}}
+{"data": {"device": "ref_mirror_1", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_READY", "timestamp": =
{"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "ref_mirror_1", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
+
+--- Test mirror #1 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-mirror", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "always", "device": "drive0", "filter-no=
de-name": "mirror-top", "job-id": "mirror_1", "sync": "bitmap", "target":=
 "mirror_target_1"}}
+{"return": {}}
+{"execute": "job-complete", "arguments": {"id": "mirror_1"}}
+{"return": {}}
+{"data": {"device": "mirror_1", "len": 393216, "offset": 393216, "speed"=
: 0, "type": "mirror"}, "event": "BLOCK_JOB_READY", "timestamp": {"micros=
econds": "USECS", "seconds": "SECS"}}
+{"execute": "job-cancel", "arguments": {"id": "mirror_1"}}
+{"return": {}}
+{"data": {"id": "mirror_1", "type": "mirror"}, "event": "BLOCK_JOB_PENDI=
NG", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "mirror_1", "len": 393216, "offset": 393216, "speed"=
: 0, "type": "mirror"}, "event": "BLOCK_JOB_CANCELLED", "timestamp": {"mi=
croseconds": "USECS", "seconds": "SECS"}}
+{
+  "bitmaps": {
+    "drive0": [
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
+--- Reference mirror #2 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-mirror", "arguments": {"device": "drive0", "filter=
-node-name": "mirror-top", "job-id": "ref_mirror_2", "sync": "full", "tar=
get": "ref_target_2"}}
+{"return": {}}
+{"execute": "job-complete", "arguments": {"id": "ref_mirror_2"}}
+{"return": {}}
+{"data": {"device": "ref_mirror_2", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_READY", "timestamp": =
{"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "ref_mirror_2", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
+
+--- Test mirror #2 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-mirror", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "always", "device": "drive0", "filter-no=
de-name": "mirror-top", "job-id": "mirror_2", "sync": "bitmap", "target":=
 "mirror_target_2"}}
+{"return": {}}
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
+    "drive0": [
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
+        "count": 458752,
+        "granularity": 65536,
+        "name": "bitmap0",
+        "persistent": false,
+        "recording": true,
+        "status": "locked"
+      }
+    ]
+  }
+}
+
+=3D Checking Bitmap bitmap0 =3D
+expecting 7 dirty sectors; have 7. OK!
+
+=3D Checking Bitmap bitmap0 =3D
+expecting 0 dirty sectors; have 0. OK!
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
+    "drive0": [
+      {
+        "busy": false,
+        "count": 524288,
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
+expecting 8 dirty sectors; have 8. OK!
+
+--- Reference mirror #3 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-mirror", "arguments": {"device": "drive0", "filter=
-node-name": "mirror-top", "job-id": "ref_mirror_3", "sync": "full", "tar=
get": "ref_target_3"}}
+{"return": {}}
+{"execute": "job-complete", "arguments": {"id": "ref_mirror_3"}}
+{"return": {}}
+{"data": {"device": "ref_mirror_3", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_READY", "timestamp": =
{"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "ref_mirror_3", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
+
+--- Test mirror #3 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-mirror", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "always", "device": "drive0", "filter-no=
de-name": "mirror-top", "job-id": "mirror_3", "sync": "bitmap", "target":=
 "mirror_target_3"}}
+{"return": {}}
+{"execute": "job-complete", "arguments": {"id": "mirror_3"}}
+{"return": {}}
+{"data": {"device": "mirror_3", "len": 524288, "offset": 524288, "speed"=
: 0, "type": "mirror"}, "event": "BLOCK_JOB_READY", "timestamp": {"micros=
econds": "USECS", "seconds": "SECS"}}
+{"execute": "job-finalize", "arguments": {"id": "mirror_3"}}
+{"return": {}}
+{"data": {"id": "mirror_3", "type": "mirror"}, "event": "BLOCK_JOB_PENDI=
NG", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "mirror_3", "len": 524288, "offset": 524288, "speed"=
: 0, "type": "mirror"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"mi=
croseconds": "USECS", "seconds": "SECS"}}
+{
+  "bitmaps": {
+    "drive0": [
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
+  "bitmaps": {}
+}
+
+--- Verification ---
+
+qemu_img compare "TEST_DIR/PID-bsync1" "TEST_DIR/PID-fmirror1" =3D=3D> I=
dentical, OK!
+qemu_img compare "TEST_DIR/PID-bsync2" "TEST_DIR/PID-fmirror2" =3D=3D> M=
ismatch, OK!
+qemu_img compare "TEST_DIR/PID-bsync3" "TEST_DIR/PID-fmirror3" =3D=3D> I=
dentical, OK!
+qemu_img compare "TEST_DIR/PID-img" "TEST_DIR/PID-fmirror3" =3D=3D> Iden=
tical, OK!
+
+
+=3D=3D=3D Mode bitmap; Bitmap Sync always with intermediate failure =3D=3D=
=3D
+
+--- Preparing image & VM ---
+
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"d=
river": "blkdebug", "image": {"driver": "file", "filename": "TEST_DIR/PID=
-img"}, "inject-error": [{"errno": 5, "event": "read_aio", "immediately":=
 false, "once": true, "state": 3}, {"errno": 5, "event": "read_aio", "imm=
ediately": false, "once": true, "state": 4}], "set-state": [{"event": "fl=
ush_to_disk", "new-state": 2, "state": 1}, {"event": "read_aio", "new-sta=
te": 3, "state": 2}, {"event": "read_aio", "new-state": 4, "state": 3}]},=
 "node-name": "drive0"}}
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
+  "bitmaps": {}
+}
+
+--- Reference mirror #0 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-mirror", "arguments": {"device": "drive0", "filter=
-node-name": "mirror-top", "job-id": "ref_mirror_0", "sync": "full", "tar=
get": "ref_target_0"}}
+{"return": {}}
+{"execute": "job-complete", "arguments": {"id": "ref_mirror_0"}}
+{"return": {}}
+{"data": {"device": "ref_mirror_0", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_READY", "timestamp": =
{"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "ref_mirror_0", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
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
+    "drive0": [
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
+--- Reference mirror #1 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-mirror", "arguments": {"device": "drive0", "filter=
-node-name": "mirror-top", "job-id": "ref_mirror_1", "sync": "full", "tar=
get": "ref_target_1"}}
+{"return": {}}
+{"execute": "job-complete", "arguments": {"id": "ref_mirror_1"}}
+{"return": {}}
+{"data": {"device": "ref_mirror_1", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_READY", "timestamp": =
{"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "ref_mirror_1", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
+
+{"return": ""}
+
+--- Test mirror #1 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-mirror", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "always", "device": "drive0", "filter-no=
de-name": "mirror-top", "job-id": "mirror_1", "sync": "bitmap", "target":=
 "mirror_target_1"}}
+{"return": {}}
+{"data": {"action": "report", "device": "mirror_1", "operation": "read"}=
, "event": "BLOCK_JOB_ERROR", "timestamp": {"microseconds": "USECS", "sec=
onds": "SECS"}}
+{"data": {"action": "report", "device": "mirror_1", "operation": "read"}=
, "event": "BLOCK_JOB_ERROR", "timestamp": {"microseconds": "USECS", "sec=
onds": "SECS"}}
+{"data": {"device": "mirror_1", "error": "Input/output error", "len": 39=
3216, "offset": 65536, "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB=
_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{
+  "bitmaps": {
+    "drive0": [
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
+--- Reference mirror #2 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-mirror", "arguments": {"device": "drive0", "filter=
-node-name": "mirror-top", "job-id": "ref_mirror_2", "sync": "full", "tar=
get": "ref_target_2"}}
+{"return": {}}
+{"execute": "job-complete", "arguments": {"id": "ref_mirror_2"}}
+{"return": {}}
+{"data": {"device": "ref_mirror_2", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_READY", "timestamp": =
{"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "ref_mirror_2", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
+
+--- Test mirror #2 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-mirror", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "always", "device": "drive0", "filter-no=
de-name": "mirror-top", "job-id": "mirror_2", "sync": "bitmap", "target":=
 "mirror_target_2"}}
+{"return": {}}
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
+    "drive0": [
+      {
+        "busy": false,
+        "count": 262144,
+        "granularity": 65536,
+        "persistent": false,
+        "recording": true,
+        "status": "active"
+      },
+      {
+        "busy": true,
+        "count": 589824,
+        "granularity": 65536,
+        "name": "bitmap0",
+        "persistent": false,
+        "recording": true,
+        "status": "locked"
+      }
+    ]
+  }
+}
+
+=3D Checking Bitmap bitmap0 =3D
+expecting 9 dirty sectors; have 9. OK!
+
+=3D Checking Bitmap bitmap0 =3D
+expecting 0 dirty sectors; have 0. OK!
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
+    "drive0": [
+      {
+        "busy": false,
+        "count": 524288,
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
+expecting 8 dirty sectors; have 8. OK!
+
+--- Reference mirror #3 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-mirror", "arguments": {"device": "drive0", "filter=
-node-name": "mirror-top", "job-id": "ref_mirror_3", "sync": "full", "tar=
get": "ref_target_3"}}
+{"return": {}}
+{"execute": "job-complete", "arguments": {"id": "ref_mirror_3"}}
+{"return": {}}
+{"data": {"device": "ref_mirror_3", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_READY", "timestamp": =
{"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "ref_mirror_3", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
+
+--- Test mirror #3 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-mirror", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "always", "device": "drive0", "filter-no=
de-name": "mirror-top", "job-id": "mirror_3", "sync": "bitmap", "target":=
 "mirror_target_3"}}
+{"return": {}}
+{"execute": "job-complete", "arguments": {"id": "mirror_3"}}
+{"return": {}}
+{"data": {"device": "mirror_3", "len": 524288, "offset": 524288, "speed"=
: 0, "type": "mirror"}, "event": "BLOCK_JOB_READY", "timestamp": {"micros=
econds": "USECS", "seconds": "SECS"}}
+{"execute": "job-finalize", "arguments": {"id": "mirror_3"}}
+{"return": {}}
+{"data": {"id": "mirror_3", "type": "mirror"}, "event": "BLOCK_JOB_PENDI=
NG", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "mirror_3", "len": 524288, "offset": 524288, "speed"=
: 0, "type": "mirror"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"mi=
croseconds": "USECS", "seconds": "SECS"}}
+{
+  "bitmaps": {
+    "drive0": [
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
+  "bitmaps": {}
+}
+
+--- Verification ---
+
+qemu_img compare "TEST_DIR/PID-bsync1" "TEST_DIR/PID-fmirror1" =3D=3D> M=
ismatch, OK!
+qemu_img compare "TEST_DIR/PID-bsync2" "TEST_DIR/PID-fmirror2" =3D=3D> M=
ismatch, OK!
+qemu_img compare "TEST_DIR/PID-bsync3" "TEST_DIR/PID-fmirror3" =3D=3D> I=
dentical, OK!
+qemu_img compare "TEST_DIR/PID-img" "TEST_DIR/PID-fmirror3" =3D=3D> Iden=
tical, OK!
+
+
+=3D=3D=3D Mode bitmap; Bitmap Sync always without failure =3D=3D=3D
+
+--- Preparing image & VM ---
+
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"d=
river": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
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
+  "bitmaps": {}
+}
+
+--- Reference mirror #0 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-mirror", "arguments": {"device": "drive0", "filter=
-node-name": "mirror-top", "job-id": "ref_mirror_0", "sync": "full", "tar=
get": "ref_target_0"}}
+{"return": {}}
+{"execute": "job-complete", "arguments": {"id": "ref_mirror_0"}}
+{"return": {}}
+{"data": {"device": "ref_mirror_0", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_READY", "timestamp": =
{"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "ref_mirror_0", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
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
+    "drive0": [
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
+--- Reference mirror #1 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-mirror", "arguments": {"device": "drive0", "filter=
-node-name": "mirror-top", "job-id": "ref_mirror_1", "sync": "full", "tar=
get": "ref_target_1"}}
+{"return": {}}
+{"execute": "job-complete", "arguments": {"id": "ref_mirror_1"}}
+{"return": {}}
+{"data": {"device": "ref_mirror_1", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_READY", "timestamp": =
{"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "ref_mirror_1", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
+
+--- Test mirror #1 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-mirror", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "always", "device": "drive0", "filter-no=
de-name": "mirror-top", "job-id": "mirror_1", "sync": "bitmap", "target":=
 "mirror_target_1"}}
+{"return": {}}
+{"execute": "job-complete", "arguments": {"id": "mirror_1"}}
+{"return": {}}
+{"data": {"device": "mirror_1", "len": 393216, "offset": 393216, "speed"=
: 0, "type": "mirror"}, "event": "BLOCK_JOB_READY", "timestamp": {"micros=
econds": "USECS", "seconds": "SECS"}}
+{"execute": "job-finalize", "arguments": {"id": "mirror_1"}}
+{"return": {}}
+{"data": {"id": "mirror_1", "type": "mirror"}, "event": "BLOCK_JOB_PENDI=
NG", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "mirror_1", "len": 393216, "offset": 393216, "speed"=
: 0, "type": "mirror"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"mi=
croseconds": "USECS", "seconds": "SECS"}}
+{
+  "bitmaps": {
+    "drive0": [
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
+--- Reference mirror #2 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-mirror", "arguments": {"device": "drive0", "filter=
-node-name": "mirror-top", "job-id": "ref_mirror_2", "sync": "full", "tar=
get": "ref_target_2"}}
+{"return": {}}
+{"execute": "job-complete", "arguments": {"id": "ref_mirror_2"}}
+{"return": {}}
+{"data": {"device": "ref_mirror_2", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_READY", "timestamp": =
{"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "ref_mirror_2", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
+
+--- Test mirror #2 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-mirror", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "always", "device": "drive0", "filter-no=
de-name": "mirror-top", "job-id": "mirror_2", "sync": "bitmap", "target":=
 "mirror_target_2"}}
+{"return": {}}
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
+    "drive0": [
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
+        "count": 458752,
+        "granularity": 65536,
+        "name": "bitmap0",
+        "persistent": false,
+        "recording": true,
+        "status": "locked"
+      }
+    ]
+  }
+}
+
+=3D Checking Bitmap bitmap0 =3D
+expecting 7 dirty sectors; have 7. OK!
+
+=3D Checking Bitmap bitmap0 =3D
+expecting 0 dirty sectors; have 0. OK!
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
+    "drive0": [
+      {
+        "busy": false,
+        "count": 524288,
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
+expecting 8 dirty sectors; have 8. OK!
+
+--- Reference mirror #3 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-mirror", "arguments": {"device": "drive0", "filter=
-node-name": "mirror-top", "job-id": "ref_mirror_3", "sync": "full", "tar=
get": "ref_target_3"}}
+{"return": {}}
+{"execute": "job-complete", "arguments": {"id": "ref_mirror_3"}}
+{"return": {}}
+{"data": {"device": "ref_mirror_3", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_READY", "timestamp": =
{"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "ref_mirror_3", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "mirror"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
+
+--- Test mirror #3 ---
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+{"execute": "blockdev-mirror", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "always", "device": "drive0", "filter-no=
de-name": "mirror-top", "job-id": "mirror_3", "sync": "bitmap", "target":=
 "mirror_target_3"}}
+{"return": {}}
+{"execute": "job-complete", "arguments": {"id": "mirror_3"}}
+{"return": {}}
+{"data": {"device": "mirror_3", "len": 524288, "offset": 524288, "speed"=
: 0, "type": "mirror"}, "event": "BLOCK_JOB_READY", "timestamp": {"micros=
econds": "USECS", "seconds": "SECS"}}
+{"execute": "job-finalize", "arguments": {"id": "mirror_3"}}
+{"return": {}}
+{"data": {"id": "mirror_3", "type": "mirror"}, "event": "BLOCK_JOB_PENDI=
NG", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "mirror_3", "len": 524288, "offset": 524288, "speed"=
: 0, "type": "mirror"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"mi=
croseconds": "USECS", "seconds": "SECS"}}
+{
+  "bitmaps": {
+    "drive0": [
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
+  "bitmaps": {}
+}
+
+--- Verification ---
+
+qemu_img compare "TEST_DIR/PID-bsync1" "TEST_DIR/PID-fmirror1" =3D=3D> I=
dentical, OK!
+qemu_img compare "TEST_DIR/PID-bsync2" "TEST_DIR/PID-fmirror2" =3D=3D> M=
ismatch, OK!
+qemu_img compare "TEST_DIR/PID-bsync3" "TEST_DIR/PID-fmirror3" =3D=3D> I=
dentical, OK!
+qemu_img compare "TEST_DIR/PID-img" "TEST_DIR/PID-fmirror3" =3D=3D> Iden=
tical, OK!
+
+
+=3D=3D=3D API failure tests =3D=3D=3D
+
+--- Preparing image & VM ---
+
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"d=
river": "file", "filename": "TEST_DIR/PID-img"}, "node-name": "drive0"}}
+{"return": {}}
+
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
+{"return": {}}
+{}
+{}
+{"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
+{"return": {}}
+{}
+
+{"execute": "block-dirty-bitmap-add", "arguments": {"granularity": 65536=
, "name": "bitmap0", "node": "drive0"}}
+{"return": {}}
+
+-- Testing invalid QMP commands --
+
+-- Sync mode incremental tests --
+
+{"execute": "blockdev-mirror", "arguments": {"bitmap-mode": "on-success"=
, "device": "drive0", "filter-node-name": "mirror-top", "job-id": "api_jo=
b", "sync": "incremental", "target": "mirror_target"}}
+{"error": {"class": "GenericError", "desc": "Cannot specify bitmap sync =
mode without a bitmap"}}
+
+{"execute": "blockdev-mirror", "arguments": {"bitmap-mode": "always", "d=
evice": "drive0", "filter-node-name": "mirror-top", "job-id": "api_job", =
"sync": "incremental", "target": "mirror_target"}}
+{"error": {"class": "GenericError", "desc": "Cannot specify bitmap sync =
mode without a bitmap"}}
+
+{"execute": "blockdev-mirror", "arguments": {"bitmap-mode": "never", "de=
vice": "drive0", "filter-node-name": "mirror-top", "job-id": "api_job", "=
sync": "incremental", "target": "mirror_target"}}
+{"error": {"class": "GenericError", "desc": "Cannot specify bitmap sync =
mode without a bitmap"}}
+
+{"execute": "blockdev-mirror", "arguments": {"device": "drive0", "filter=
-node-name": "mirror-top", "job-id": "api_job", "sync": "incremental", "t=
arget": "mirror_target"}}
+{"error": {"class": "GenericError", "desc": "Sync mode 'incremental' not=
 supported"}}
+
+{"execute": "blockdev-mirror", "arguments": {"bitmap": "bitmap404", "bit=
map-mode": "on-success", "device": "drive0", "filter-node-name": "mirror-=
top", "job-id": "api_job", "sync": "incremental", "target": "mirror_targe=
t"}}
+{"error": {"class": "GenericError", "desc": "Dirty bitmap 'bitmap404' no=
t found"}}
+
+{"execute": "blockdev-mirror", "arguments": {"bitmap": "bitmap404", "bit=
map-mode": "always", "device": "drive0", "filter-node-name": "mirror-top"=
, "job-id": "api_job", "sync": "incremental", "target": "mirror_target"}}
+{"error": {"class": "GenericError", "desc": "Dirty bitmap 'bitmap404' no=
t found"}}
+
+{"execute": "blockdev-mirror", "arguments": {"bitmap": "bitmap404", "bit=
map-mode": "never", "device": "drive0", "filter-node-name": "mirror-top",=
 "job-id": "api_job", "sync": "incremental", "target": "mirror_target"}}
+{"error": {"class": "GenericError", "desc": "Dirty bitmap 'bitmap404' no=
t found"}}
+
+{"execute": "blockdev-mirror", "arguments": {"bitmap": "bitmap404", "dev=
ice": "drive0", "filter-node-name": "mirror-top", "job-id": "api_job", "s=
ync": "incremental", "target": "mirror_target"}}
+{"error": {"class": "GenericError", "desc": "bitmap-mode must be specifi=
ed if a bitmap is provided"}}
+
+{"execute": "blockdev-mirror", "arguments": {"bitmap": "bitmap0", "bitma=
p-mode": "always", "device": "drive0", "filter-node-name": "mirror-top", =
"job-id": "api_job", "sync": "incremental", "target": "mirror_target"}}
+{"error": {"class": "GenericError", "desc": "Sync mode 'incremental' not=
 supported"}}
+
+{"execute": "blockdev-mirror", "arguments": {"bitmap": "bitmap0", "bitma=
p-mode": "never", "device": "drive0", "filter-node-name": "mirror-top", "=
job-id": "api_job", "sync": "incremental", "target": "mirror_target"}}
+{"error": {"class": "GenericError", "desc": "Sync mode 'incremental' not=
 supported"}}
+
+-- Sync mode bitmap tests --
+
+{"execute": "blockdev-mirror", "arguments": {"bitmap-mode": "on-success"=
, "device": "drive0", "filter-node-name": "mirror-top", "job-id": "api_jo=
b", "sync": "bitmap", "target": "mirror_target"}}
+{"error": {"class": "GenericError", "desc": "Cannot specify bitmap sync =
mode without a bitmap"}}
+
+{"execute": "blockdev-mirror", "arguments": {"bitmap-mode": "always", "d=
evice": "drive0", "filter-node-name": "mirror-top", "job-id": "api_job", =
"sync": "bitmap", "target": "mirror_target"}}
+{"error": {"class": "GenericError", "desc": "Cannot specify bitmap sync =
mode without a bitmap"}}
+
+{"execute": "blockdev-mirror", "arguments": {"bitmap-mode": "never", "de=
vice": "drive0", "filter-node-name": "mirror-top", "job-id": "api_job", "=
sync": "bitmap", "target": "mirror_target"}}
+{"error": {"class": "GenericError", "desc": "Cannot specify bitmap sync =
mode without a bitmap"}}
+
+{"execute": "blockdev-mirror", "arguments": {"device": "drive0", "filter=
-node-name": "mirror-top", "job-id": "api_job", "sync": "bitmap", "target=
": "mirror_target"}}
+{"error": {"class": "GenericError", "desc": "Must provide a valid bitmap=
 name for 'bitmap' sync mode"}}
+
+{"execute": "blockdev-mirror", "arguments": {"bitmap": "bitmap404", "bit=
map-mode": "on-success", "device": "drive0", "filter-node-name": "mirror-=
top", "job-id": "api_job", "sync": "bitmap", "target": "mirror_target"}}
+{"error": {"class": "GenericError", "desc": "Dirty bitmap 'bitmap404' no=
t found"}}
+
+{"execute": "blockdev-mirror", "arguments": {"bitmap": "bitmap404", "bit=
map-mode": "always", "device": "drive0", "filter-node-name": "mirror-top"=
, "job-id": "api_job", "sync": "bitmap", "target": "mirror_target"}}
+{"error": {"class": "GenericError", "desc": "Dirty bitmap 'bitmap404' no=
t found"}}
+
+{"execute": "blockdev-mirror", "arguments": {"bitmap": "bitmap404", "bit=
map-mode": "never", "device": "drive0", "filter-node-name": "mirror-top",=
 "job-id": "api_job", "sync": "bitmap", "target": "mirror_target"}}
+{"error": {"class": "GenericError", "desc": "Dirty bitmap 'bitmap404' no=
t found"}}
+
+{"execute": "blockdev-mirror", "arguments": {"bitmap": "bitmap404", "dev=
ice": "drive0", "filter-node-name": "mirror-top", "job-id": "api_job", "s=
ync": "bitmap", "target": "mirror_target"}}
+{"error": {"class": "GenericError", "desc": "bitmap-mode must be specifi=
ed if a bitmap is provided"}}
+
+{"execute": "blockdev-mirror", "arguments": {"bitmap": "bitmap0", "devic=
e": "drive0", "filter-node-name": "mirror-top", "job-id": "api_job", "syn=
c": "bitmap", "target": "mirror_target"}}
+{"error": {"class": "GenericError", "desc": "bitmap-mode must be specifi=
ed if a bitmap is provided"}}
+
+-- Sync mode full tests --
+
+{"execute": "blockdev-mirror", "arguments": {"bitmap-mode": "on-success"=
, "device": "drive0", "filter-node-name": "mirror-top", "job-id": "api_jo=
b", "sync": "full", "target": "mirror_target"}}
+{"error": {"class": "GenericError", "desc": "Cannot specify bitmap sync =
mode without a bitmap"}}
+
+{"execute": "blockdev-mirror", "arguments": {"bitmap-mode": "always", "d=
evice": "drive0", "filter-node-name": "mirror-top", "job-id": "api_job", =
"sync": "full", "target": "mirror_target"}}
+{"error": {"class": "GenericError", "desc": "Cannot specify bitmap sync =
mode without a bitmap"}}
+
+{"execute": "blockdev-mirror", "arguments": {"bitmap-mode": "never", "de=
vice": "drive0", "filter-node-name": "mirror-top", "job-id": "api_job", "=
sync": "full", "target": "mirror_target"}}
+{"error": {"class": "GenericError", "desc": "Cannot specify bitmap sync =
mode without a bitmap"}}
+
+{"execute": "blockdev-mirror", "arguments": {"bitmap": "bitmap404", "bit=
map-mode": "on-success", "device": "drive0", "filter-node-name": "mirror-=
top", "job-id": "api_job", "sync": "full", "target": "mirror_target"}}
+{"error": {"class": "GenericError", "desc": "Dirty bitmap 'bitmap404' no=
t found"}}
+
+{"execute": "blockdev-mirror", "arguments": {"bitmap": "bitmap404", "bit=
map-mode": "always", "device": "drive0", "filter-node-name": "mirror-top"=
, "job-id": "api_job", "sync": "full", "target": "mirror_target"}}
+{"error": {"class": "GenericError", "desc": "Dirty bitmap 'bitmap404' no=
t found"}}
+
+{"execute": "blockdev-mirror", "arguments": {"bitmap": "bitmap404", "bit=
map-mode": "never", "device": "drive0", "filter-node-name": "mirror-top",=
 "job-id": "api_job", "sync": "full", "target": "mirror_target"}}
+{"error": {"class": "GenericError", "desc": "Dirty bitmap 'bitmap404' no=
t found"}}
+
+{"execute": "blockdev-mirror", "arguments": {"bitmap": "bitmap404", "dev=
ice": "drive0", "filter-node-name": "mirror-top", "job-id": "api_job", "s=
ync": "full", "target": "mirror_target"}}
+{"error": {"class": "GenericError", "desc": "bitmap-mode must be specifi=
ed if a bitmap is provided"}}
+
+{"execute": "blockdev-mirror", "arguments": {"bitmap": "bitmap0", "bitma=
p-mode": "on-success", "device": "drive0", "filter-node-name": "mirror-to=
p", "job-id": "api_job", "sync": "full", "target": "mirror_target"}}
+{"error": {"class": "GenericError", "desc": "sync mode 'full' is not com=
patible with bitmaps"}}
+
+{"execute": "blockdev-mirror", "arguments": {"bitmap": "bitmap0", "bitma=
p-mode": "always", "device": "drive0", "filter-node-name": "mirror-top", =
"job-id": "api_job", "sync": "full", "target": "mirror_target"}}
+{"error": {"class": "GenericError", "desc": "sync mode 'full' is not com=
patible with bitmaps"}}
+
+{"execute": "blockdev-mirror", "arguments": {"bitmap": "bitmap0", "bitma=
p-mode": "never", "device": "drive0", "filter-node-name": "mirror-top", "=
job-id": "api_job", "sync": "full", "target": "mirror_target"}}
+{"error": {"class": "GenericError", "desc": "sync mode 'full' is not com=
patible with bitmaps"}}
+
+{"execute": "blockdev-mirror", "arguments": {"bitmap": "bitmap0", "devic=
e": "drive0", "filter-node-name": "mirror-top", "job-id": "api_job", "syn=
c": "full", "target": "mirror_target"}}
+{"error": {"class": "GenericError", "desc": "bitmap-mode must be specifi=
ed if a bitmap is provided"}}
+
+-- Sync mode top tests --
+
+{"execute": "blockdev-mirror", "arguments": {"bitmap-mode": "on-success"=
, "device": "drive0", "filter-node-name": "mirror-top", "job-id": "api_jo=
b", "sync": "top", "target": "mirror_target"}}
+{"error": {"class": "GenericError", "desc": "Cannot specify bitmap sync =
mode without a bitmap"}}
+
+{"execute": "blockdev-mirror", "arguments": {"bitmap-mode": "always", "d=
evice": "drive0", "filter-node-name": "mirror-top", "job-id": "api_job", =
"sync": "top", "target": "mirror_target"}}
+{"error": {"class": "GenericError", "desc": "Cannot specify bitmap sync =
mode without a bitmap"}}
+
+{"execute": "blockdev-mirror", "arguments": {"bitmap-mode": "never", "de=
vice": "drive0", "filter-node-name": "mirror-top", "job-id": "api_job", "=
sync": "top", "target": "mirror_target"}}
+{"error": {"class": "GenericError", "desc": "Cannot specify bitmap sync =
mode without a bitmap"}}
+
+{"execute": "blockdev-mirror", "arguments": {"bitmap": "bitmap404", "bit=
map-mode": "on-success", "device": "drive0", "filter-node-name": "mirror-=
top", "job-id": "api_job", "sync": "top", "target": "mirror_target"}}
+{"error": {"class": "GenericError", "desc": "Dirty bitmap 'bitmap404' no=
t found"}}
+
+{"execute": "blockdev-mirror", "arguments": {"bitmap": "bitmap404", "bit=
map-mode": "always", "device": "drive0", "filter-node-name": "mirror-top"=
, "job-id": "api_job", "sync": "top", "target": "mirror_target"}}
+{"error": {"class": "GenericError", "desc": "Dirty bitmap 'bitmap404' no=
t found"}}
+
+{"execute": "blockdev-mirror", "arguments": {"bitmap": "bitmap404", "bit=
map-mode": "never", "device": "drive0", "filter-node-name": "mirror-top",=
 "job-id": "api_job", "sync": "top", "target": "mirror_target"}}
+{"error": {"class": "GenericError", "desc": "Dirty bitmap 'bitmap404' no=
t found"}}
+
+{"execute": "blockdev-mirror", "arguments": {"bitmap": "bitmap404", "dev=
ice": "drive0", "filter-node-name": "mirror-top", "job-id": "api_job", "s=
ync": "top", "target": "mirror_target"}}
+{"error": {"class": "GenericError", "desc": "bitmap-mode must be specifi=
ed if a bitmap is provided"}}
+
+{"execute": "blockdev-mirror", "arguments": {"bitmap": "bitmap0", "bitma=
p-mode": "on-success", "device": "drive0", "filter-node-name": "mirror-to=
p", "job-id": "api_job", "sync": "top", "target": "mirror_target"}}
+{"error": {"class": "GenericError", "desc": "sync mode 'full' is not com=
patible with bitmaps"}}
+
+{"execute": "blockdev-mirror", "arguments": {"bitmap": "bitmap0", "bitma=
p-mode": "always", "device": "drive0", "filter-node-name": "mirror-top", =
"job-id": "api_job", "sync": "top", "target": "mirror_target"}}
+{"error": {"class": "GenericError", "desc": "sync mode 'full' is not com=
patible with bitmaps"}}
+
+{"execute": "blockdev-mirror", "arguments": {"bitmap": "bitmap0", "bitma=
p-mode": "never", "device": "drive0", "filter-node-name": "mirror-top", "=
job-id": "api_job", "sync": "top", "target": "mirror_target"}}
+{"error": {"class": "GenericError", "desc": "sync mode 'full' is not com=
patible with bitmaps"}}
+
+{"execute": "blockdev-mirror", "arguments": {"bitmap": "bitmap0", "devic=
e": "drive0", "filter-node-name": "mirror-top", "job-id": "api_job", "syn=
c": "top", "target": "mirror_target"}}
+{"error": {"class": "GenericError", "desc": "bitmap-mode must be specifi=
ed if a bitmap is provided"}}
+
+-- Sync mode none tests --
+
+{"execute": "blockdev-mirror", "arguments": {"bitmap-mode": "on-success"=
, "device": "drive0", "filter-node-name": "mirror-top", "job-id": "api_jo=
b", "sync": "none", "target": "mirror_target"}}
+{"error": {"class": "GenericError", "desc": "Cannot specify bitmap sync =
mode without a bitmap"}}
+
+{"execute": "blockdev-mirror", "arguments": {"bitmap-mode": "always", "d=
evice": "drive0", "filter-node-name": "mirror-top", "job-id": "api_job", =
"sync": "none", "target": "mirror_target"}}
+{"error": {"class": "GenericError", "desc": "Cannot specify bitmap sync =
mode without a bitmap"}}
+
+{"execute": "blockdev-mirror", "arguments": {"bitmap-mode": "never", "de=
vice": "drive0", "filter-node-name": "mirror-top", "job-id": "api_job", "=
sync": "none", "target": "mirror_target"}}
+{"error": {"class": "GenericError", "desc": "Cannot specify bitmap sync =
mode without a bitmap"}}
+
+{"execute": "blockdev-mirror", "arguments": {"bitmap": "bitmap404", "bit=
map-mode": "on-success", "device": "drive0", "filter-node-name": "mirror-=
top", "job-id": "api_job", "sync": "none", "target": "mirror_target"}}
+{"error": {"class": "GenericError", "desc": "Dirty bitmap 'bitmap404' no=
t found"}}
+
+{"execute": "blockdev-mirror", "arguments": {"bitmap": "bitmap404", "bit=
map-mode": "always", "device": "drive0", "filter-node-name": "mirror-top"=
, "job-id": "api_job", "sync": "none", "target": "mirror_target"}}
+{"error": {"class": "GenericError", "desc": "Dirty bitmap 'bitmap404' no=
t found"}}
+
+{"execute": "blockdev-mirror", "arguments": {"bitmap": "bitmap404", "bit=
map-mode": "never", "device": "drive0", "filter-node-name": "mirror-top",=
 "job-id": "api_job", "sync": "none", "target": "mirror_target"}}
+{"error": {"class": "GenericError", "desc": "Dirty bitmap 'bitmap404' no=
t found"}}
+
+{"execute": "blockdev-mirror", "arguments": {"bitmap": "bitmap404", "dev=
ice": "drive0", "filter-node-name": "mirror-top", "job-id": "api_job", "s=
ync": "none", "target": "mirror_target"}}
+{"error": {"class": "GenericError", "desc": "bitmap-mode must be specifi=
ed if a bitmap is provided"}}
+
+{"execute": "blockdev-mirror", "arguments": {"bitmap": "bitmap0", "bitma=
p-mode": "on-success", "device": "drive0", "filter-node-name": "mirror-to=
p", "job-id": "api_job", "sync": "none", "target": "mirror_target"}}
+{"error": {"class": "GenericError", "desc": "sync mode 'none' is not com=
patible with bitmaps"}}
+
+{"execute": "blockdev-mirror", "arguments": {"bitmap": "bitmap0", "bitma=
p-mode": "always", "device": "drive0", "filter-node-name": "mirror-top", =
"job-id": "api_job", "sync": "none", "target": "mirror_target"}}
+{"error": {"class": "GenericError", "desc": "sync mode 'none' is not com=
patible with bitmaps"}}
+
+{"execute": "blockdev-mirror", "arguments": {"bitmap": "bitmap0", "bitma=
p-mode": "never", "device": "drive0", "filter-node-name": "mirror-top", "=
job-id": "api_job", "sync": "none", "target": "mirror_target"}}
+{"error": {"class": "GenericError", "desc": "sync mode 'none' is not com=
patible with bitmaps"}}
+
+{"execute": "blockdev-mirror", "arguments": {"bitmap": "bitmap0", "devic=
e": "drive0", "filter-node-name": "mirror-top", "job-id": "api_job", "syn=
c": "none", "target": "mirror_target"}}
+{"error": {"class": "GenericError", "desc": "bitmap-mode must be specifi=
ed if a bitmap is provided"}}
+
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index 1904223020..818380a8f0 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -290,3 +290,4 @@
 280 rw migration quick
 281 rw quick
 283 auto quick
+284 rw
--=20
2.20.1



