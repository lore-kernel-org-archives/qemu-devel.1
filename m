Return-Path: <SRS0=axyf=VH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA2CAC73C63
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 01:22:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D3B220693
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 01:22:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D3B220693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57412 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hl1JT-0001PW-Uj
	for qemu-devel@archiver.kernel.org; Tue, 09 Jul 2019 21:22:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49361)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jsnow@redhat.com>) id 1hl13x-0000YY-N7
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 21:06:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1hl13q-0004cm-JN
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 21:06:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38542)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>)
 id 1hl13b-0004F4-7f; Tue, 09 Jul 2019 21:06:05 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 59D2681111;
 Wed, 10 Jul 2019 01:06:02 +0000 (UTC)
Received: from probe.bos.redhat.com (dhcp-17-215.bos.redhat.com [10.18.17.215])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 82ECA1001B19;
 Wed, 10 Jul 2019 01:06:01 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Date: Tue,  9 Jul 2019 21:05:51 -0400
Message-Id: <20190710010556.32365-4-jsnow@redhat.com>
In-Reply-To: <20190710010556.32365-1-jsnow@redhat.com>
References: <20190710010556.32365-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.28]); Wed, 10 Jul 2019 01:06:02 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 3/8] iotests/257: Refactor backup helpers
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
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This test needs support for non-bitmap backups and missing or
unspecified bitmap sync modes, so rewrite the helpers to be a little
more generic.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 tests/qemu-iotests/257     |  46 +++++----
 tests/qemu-iotests/257.out | 192 ++++++++++++++++++-------------------
 2 files changed, 124 insertions(+), 114 deletions(-)

diff --git a/tests/qemu-iotests/257 b/tests/qemu-iotests/257
index 2ff4aa8695..2eb4f26c28 100755
--- a/tests/qemu-iotests/257
+++ b/tests/qemu-iotests/257
@@ -208,6 +208,14 @@ def get_bitmap(bitmaps, drivename, name, recording=3D=
None):
                 return bitmap
     return None
=20
+def blockdev_backup(vm, device, target, sync, **kwargs):
+    result =3D vm.qmp_log('blockdev-backup',
+                        device=3Ddevice,
+                        target=3Dtarget,
+                        sync=3Dsync,
+                        **kwargs)
+    return result
+
 def reference_backup(drive, n, filepath):
     log("--- Reference Backup #{:d} ---\n".format(n))
     target_id =3D "ref_target_{:d}".format(n)
@@ -215,24 +223,26 @@ def reference_backup(drive, n, filepath):
     target_drive =3D Drive(filepath, vm=3Ddrive.vm)
=20
     target_drive.create_target(target_id, drive.fmt, drive.size)
-    drive.vm.qmp_log("blockdev-backup",
-                     job_id=3Djob_id, device=3Ddrive.name,
-                     target=3Dtarget_id, sync=3D"full")
+    blockdev_backup(drive.vm, drive.name, target_id, "full", job_id=3Djo=
b_id)
     drive.vm.run_job(job_id, auto_dismiss=3DTrue)
     log('')
=20
-def bitmap_backup(drive, n, filepath, bitmap, bitmap_mode):
-    log("--- Bitmap Backup #{:d} ---\n".format(n))
-    target_id =3D "bitmap_target_{:d}".format(n)
-    job_id =3D "bitmap_backup_{:d}".format(n)
+def backup(drive, n, filepath, bitmap, bitmap_mode, sync=3D'bitmap'):
+    log("--- Test Backup #{:d} ---\n".format(n))
+    target_id =3D "backup_target_{:d}".format(n)
+    job_id =3D "backup_{:d}".format(n)
     target_drive =3D Drive(filepath, vm=3Ddrive.vm)
=20
     target_drive.create_target(target_id, drive.fmt, drive.size)
-    drive.vm.qmp_log("blockdev-backup", job_id=3Djob_id, device=3Ddrive.=
name,
-                     target=3Dtarget_id, sync=3D"bitmap",
-                     bitmap_mode=3Dbitmap_mode,
-                     bitmap=3Dbitmap,
-                     auto_finalize=3DFalse)
+
+    kwargs =3D {
+        'job_id': job_id,
+        'auto_finalize': False,
+        'bitmap': bitmap,
+        'bitmap_mode': bitmap_mode,
+    }
+    kwargs =3D {key: val for key, val in kwargs.items() if val is not No=
ne}
+    blockdev_backup(drive.vm, drive.name, target_id, sync, **kwargs)
     return job_id
=20
 def perform_writes(drive, n):
@@ -264,7 +274,7 @@ def compare_images(image, reference, baseimg=3DNone, =
expected_match=3DTrue):
         "OK!" if ret =3D=3D expected_ret else "ERROR!"),
         filters=3D[iotests.filter_testfiles])
=20
-def test_bitmap_sync(bsync_mode, failure=3DNone):
+def test_bitmap_sync(bsync_mode, msync_mode=3D'bitmap', failure=3DNone):
     """
     Test bitmap backup routines.
=20
@@ -292,7 +302,7 @@ def test_bitmap_sync(bsync_mode, failure=3DNone):
                              fbackup0, fbackup1, fbackup2), \
          iotests.VM() as vm:
=20
-        mode =3D "Bitmap Sync Mode {:s}".format(bsync_mode)
+        mode =3D "Mode {:s}; Bitmap Sync {:s}".format(msync_mode, bsync_=
mode)
         preposition =3D "with" if failure else "without"
         cond =3D "{:s} {:s}".format(preposition,
                                   "{:s} failure".format(failure) if fail=
ure
@@ -363,12 +373,12 @@ def test_bitmap_sync(bsync_mode, failure=3DNone):
         ebitmap.compare(bitmap)
         reference_backup(drive0, 1, fbackup1)
=20
-        # 1 - Bitmap Backup (Optional induced failure)
+        # 1 - Test Backup (w/ Optional induced failure)
         if failure =3D=3D 'intermediate':
             # Activate blkdebug induced failure for second-to-next read
             log(vm.hmp_qemu_io(drive0.name, 'flush'))
             log('')
-        job =3D bitmap_backup(drive0, 1, bsync1, "bitmap0", bsync_mode)
+        job =3D backup(drive0, 1, bsync1, "bitmap0", bsync_mode, sync=3D=
msync_mode)
=20
         def _callback():
             """Issue writes while the job is open to test bitmap diverge=
nce."""
@@ -409,7 +419,7 @@ def test_bitmap_sync(bsync_mode, failure=3DNone):
         reference_backup(drive0, 2, fbackup2)
=20
         # 2 - Bitmap Backup (In failure modes, this is a recovery.)
-        job =3D bitmap_backup(drive0, 2, bsync2, "bitmap0", bsync_mode)
+        job =3D backup(drive0, 2, bsync2, "bitmap0", bsync_mode)
         vm.run_job(job, auto_dismiss=3DTrue, auto_finalize=3DFalse)
         bitmaps =3D query_bitmaps(vm)
         log(bitmaps, indent=3D2)
@@ -443,7 +453,7 @@ def test_bitmap_sync(bsync_mode, failure=3DNone):
 def main():
     for bsync_mode in ("never", "on-success", "always"):
         for failure in ("simulated", "intermediate", None):
-            test_bitmap_sync(bsync_mode, failure)
+            test_bitmap_sync(bsync_mode, "bitmap", failure)
=20
 if __name__ =3D=3D '__main__':
     iotests.script_main(main, supported_fmts=3D['qcow2'])
diff --git a/tests/qemu-iotests/257.out b/tests/qemu-iotests/257.out
index e0775d4815..0abc96acd3 100644
--- a/tests/qemu-iotests/257.out
+++ b/tests/qemu-iotests/257.out
@@ -1,5 +1,5 @@
=20
-=3D=3D=3D Bitmap Sync Mode never with simulated failure =3D=3D=3D
+=3D=3D=3D Mode bitmap; Bitmap Sync never with simulated failure =3D=3D=3D
=20
 --- Preparing image & VM ---
=20
@@ -86,7 +86,7 @@ expecting 6 dirty sectors; have 6. OK!
 {"return": {}}
 {"data": {"device": "ref_backup_1", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
=20
---- Bitmap Backup #1 ---
+--- Test Backup #1 ---
=20
 {}
 {"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
@@ -96,7 +96,7 @@ expecting 6 dirty sectors; have 6. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "never", "device": "drive0", "job-id": "=
bitmap_backup_1", "sync": "bitmap", "target": "bitmap_target_1"}}
+{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "never", "device": "drive0", "job-id": "=
backup_1", "sync": "bitmap", "target": "backup_target_1"}}
 {"return": {}}
=20
 --- Write #2 ---
@@ -147,10 +147,10 @@ expecting 6 dirty sectors; have 6. OK!
 =3D Checking Bitmap (anonymous) =3D
 expecting 7 dirty sectors; have 7. OK!
=20
-{"execute": "job-cancel", "arguments": {"id": "bitmap_backup_1"}}
+{"execute": "job-cancel", "arguments": {"id": "backup_1"}}
 {"return": {}}
-{"data": {"id": "bitmap_backup_1", "type": "backup"}, "event": "BLOCK_JO=
B_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
-{"data": {"device": "bitmap_backup_1", "len": 67108864, "offset": 671088=
64, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_CANCELLED", "times=
tamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"id": "backup_1", "type": "backup"}, "event": "BLOCK_JOB_PENDI=
NG", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "backup_1", "len": 67108864, "offset": 67108864, "sp=
eed": 0, "type": "backup"}, "event": "BLOCK_JOB_CANCELLED", "timestamp": =
{"microseconds": "USECS", "seconds": "SECS"}}
 {
   "bitmaps": {
     "device0": [
@@ -213,7 +213,7 @@ expecting 15 dirty sectors; have 15. OK!
 {"return": {}}
 {"data": {"device": "ref_backup_2", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
=20
---- Bitmap Backup #2 ---
+--- Test Backup #2 ---
=20
 {}
 {"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
@@ -223,12 +223,12 @@ expecting 15 dirty sectors; have 15. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "never", "device": "drive0", "job-id": "=
bitmap_backup_2", "sync": "bitmap", "target": "bitmap_target_2"}}
+{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "never", "device": "drive0", "job-id": "=
backup_2", "sync": "bitmap", "target": "backup_target_2"}}
 {"return": {}}
-{"execute": "job-finalize", "arguments": {"id": "bitmap_backup_2"}}
+{"execute": "job-finalize", "arguments": {"id": "backup_2"}}
 {"return": {}}
-{"data": {"id": "bitmap_backup_2", "type": "backup"}, "event": "BLOCK_JO=
B_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
-{"data": {"device": "bitmap_backup_2", "len": 67108864, "offset": 671088=
64, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "times=
tamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"id": "backup_2", "type": "backup"}, "event": "BLOCK_JOB_PENDI=
NG", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "backup_2", "len": 67108864, "offset": 67108864, "sp=
eed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": =
{"microseconds": "USECS", "seconds": "SECS"}}
 {
   "bitmaps": {
     "device0": [
@@ -265,7 +265,7 @@ qemu_img compare "TEST_DIR/PID-bsync2" "TEST_DIR/PID-=
fbackup2" =3D=3D> Identical, OK
 qemu_img compare "TEST_DIR/PID-img" "TEST_DIR/PID-fbackup2" =3D=3D> Iden=
tical, OK!
=20
=20
-=3D=3D=3D Bitmap Sync Mode never with intermediate failure =3D=3D=3D
+=3D=3D=3D Mode bitmap; Bitmap Sync never with intermediate failure =3D=3D=
=3D
=20
 --- Preparing image & VM ---
=20
@@ -354,7 +354,7 @@ expecting 6 dirty sectors; have 6. OK!
=20
 {"return": ""}
=20
---- Bitmap Backup #1 ---
+--- Test Backup #1 ---
=20
 {}
 {"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
@@ -364,10 +364,10 @@ expecting 6 dirty sectors; have 6. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "never", "device": "drive0", "job-id": "=
bitmap_backup_1", "sync": "bitmap", "target": "bitmap_target_1"}}
+{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "never", "device": "drive0", "job-id": "=
backup_1", "sync": "bitmap", "target": "backup_target_1"}}
 {"return": {}}
-{"data": {"action": "report", "device": "bitmap_backup_1", "operation": =
"read"}, "event": "BLOCK_JOB_ERROR", "timestamp": {"microseconds": "USECS=
", "seconds": "SECS"}}
-{"data": {"device": "bitmap_backup_1", "error": "Input/output error", "l=
en": 67108864, "offset": 66781184, "speed": 0, "type": "backup"}, "event"=
: "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds"=
: "SECS"}}
+{"data": {"action": "report", "device": "backup_1", "operation": "read"}=
, "event": "BLOCK_JOB_ERROR", "timestamp": {"microseconds": "USECS", "sec=
onds": "SECS"}}
+{"data": {"device": "backup_1", "error": "Input/output error", "len": 67=
108864, "offset": 66781184, "speed": 0, "type": "backup"}, "event": "BLOC=
K_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS=
"}}
 {
   "bitmaps": {
     "device0": [
@@ -430,7 +430,7 @@ expecting 14 dirty sectors; have 14. OK!
 {"return": {}}
 {"data": {"device": "ref_backup_2", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
=20
---- Bitmap Backup #2 ---
+--- Test Backup #2 ---
=20
 {}
 {"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
@@ -440,12 +440,12 @@ expecting 14 dirty sectors; have 14. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "never", "device": "drive0", "job-id": "=
bitmap_backup_2", "sync": "bitmap", "target": "bitmap_target_2"}}
+{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "never", "device": "drive0", "job-id": "=
backup_2", "sync": "bitmap", "target": "backup_target_2"}}
 {"return": {}}
-{"execute": "job-finalize", "arguments": {"id": "bitmap_backup_2"}}
+{"execute": "job-finalize", "arguments": {"id": "backup_2"}}
 {"return": {}}
-{"data": {"id": "bitmap_backup_2", "type": "backup"}, "event": "BLOCK_JO=
B_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
-{"data": {"device": "bitmap_backup_2", "len": 67108864, "offset": 671088=
64, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "times=
tamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"id": "backup_2", "type": "backup"}, "event": "BLOCK_JOB_PENDI=
NG", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "backup_2", "len": 67108864, "offset": 67108864, "sp=
eed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": =
{"microseconds": "USECS", "seconds": "SECS"}}
 {
   "bitmaps": {
     "device0": [
@@ -482,7 +482,7 @@ qemu_img compare "TEST_DIR/PID-bsync2" "TEST_DIR/PID-=
fbackup2" =3D=3D> Identical, OK
 qemu_img compare "TEST_DIR/PID-img" "TEST_DIR/PID-fbackup2" =3D=3D> Iden=
tical, OK!
=20
=20
-=3D=3D=3D Bitmap Sync Mode never without failure =3D=3D=3D
+=3D=3D=3D Mode bitmap; Bitmap Sync never without failure =3D=3D=3D
=20
 --- Preparing image & VM ---
=20
@@ -569,7 +569,7 @@ expecting 6 dirty sectors; have 6. OK!
 {"return": {}}
 {"data": {"device": "ref_backup_1", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
=20
---- Bitmap Backup #1 ---
+--- Test Backup #1 ---
=20
 {}
 {"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
@@ -579,7 +579,7 @@ expecting 6 dirty sectors; have 6. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "never", "device": "drive0", "job-id": "=
bitmap_backup_1", "sync": "bitmap", "target": "bitmap_target_1"}}
+{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "never", "device": "drive0", "job-id": "=
backup_1", "sync": "bitmap", "target": "backup_target_1"}}
 {"return": {}}
=20
 --- Write #2 ---
@@ -630,10 +630,10 @@ expecting 6 dirty sectors; have 6. OK!
 =3D Checking Bitmap (anonymous) =3D
 expecting 7 dirty sectors; have 7. OK!
=20
-{"execute": "job-finalize", "arguments": {"id": "bitmap_backup_1"}}
+{"execute": "job-finalize", "arguments": {"id": "backup_1"}}
 {"return": {}}
-{"data": {"id": "bitmap_backup_1", "type": "backup"}, "event": "BLOCK_JO=
B_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
-{"data": {"device": "bitmap_backup_1", "len": 67108864, "offset": 671088=
64, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "times=
tamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"id": "backup_1", "type": "backup"}, "event": "BLOCK_JOB_PENDI=
NG", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "backup_1", "len": 67108864, "offset": 67108864, "sp=
eed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": =
{"microseconds": "USECS", "seconds": "SECS"}}
 {
   "bitmaps": {
     "device0": [
@@ -696,7 +696,7 @@ expecting 15 dirty sectors; have 15. OK!
 {"return": {}}
 {"data": {"device": "ref_backup_2", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
=20
---- Bitmap Backup #2 ---
+--- Test Backup #2 ---
=20
 {}
 {"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
@@ -706,12 +706,12 @@ expecting 15 dirty sectors; have 15. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "never", "device": "drive0", "job-id": "=
bitmap_backup_2", "sync": "bitmap", "target": "bitmap_target_2"}}
+{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "never", "device": "drive0", "job-id": "=
backup_2", "sync": "bitmap", "target": "backup_target_2"}}
 {"return": {}}
-{"execute": "job-finalize", "arguments": {"id": "bitmap_backup_2"}}
+{"execute": "job-finalize", "arguments": {"id": "backup_2"}}
 {"return": {}}
-{"data": {"id": "bitmap_backup_2", "type": "backup"}, "event": "BLOCK_JO=
B_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
-{"data": {"device": "bitmap_backup_2", "len": 67108864, "offset": 671088=
64, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "times=
tamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"id": "backup_2", "type": "backup"}, "event": "BLOCK_JOB_PENDI=
NG", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "backup_2", "len": 67108864, "offset": 67108864, "sp=
eed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": =
{"microseconds": "USECS", "seconds": "SECS"}}
 {
   "bitmaps": {
     "device0": [
@@ -748,7 +748,7 @@ qemu_img compare "TEST_DIR/PID-bsync2" "TEST_DIR/PID-=
fbackup2" =3D=3D> Identical, OK
 qemu_img compare "TEST_DIR/PID-img" "TEST_DIR/PID-fbackup2" =3D=3D> Iden=
tical, OK!
=20
=20
-=3D=3D=3D Bitmap Sync Mode on-success with simulated failure =3D=3D=3D
+=3D=3D=3D Mode bitmap; Bitmap Sync on-success with simulated failure =3D=
=3D=3D
=20
 --- Preparing image & VM ---
=20
@@ -835,7 +835,7 @@ expecting 6 dirty sectors; have 6. OK!
 {"return": {}}
 {"data": {"device": "ref_backup_1", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
=20
---- Bitmap Backup #1 ---
+--- Test Backup #1 ---
=20
 {}
 {"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
@@ -845,7 +845,7 @@ expecting 6 dirty sectors; have 6. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "on-success", "device": "drive0", "job-i=
d": "bitmap_backup_1", "sync": "bitmap", "target": "bitmap_target_1"}}
+{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "on-success", "device": "drive0", "job-i=
d": "backup_1", "sync": "bitmap", "target": "backup_target_1"}}
 {"return": {}}
=20
 --- Write #2 ---
@@ -896,10 +896,10 @@ expecting 6 dirty sectors; have 6. OK!
 =3D Checking Bitmap (anonymous) =3D
 expecting 7 dirty sectors; have 7. OK!
=20
-{"execute": "job-cancel", "arguments": {"id": "bitmap_backup_1"}}
+{"execute": "job-cancel", "arguments": {"id": "backup_1"}}
 {"return": {}}
-{"data": {"id": "bitmap_backup_1", "type": "backup"}, "event": "BLOCK_JO=
B_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
-{"data": {"device": "bitmap_backup_1", "len": 67108864, "offset": 671088=
64, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_CANCELLED", "times=
tamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"id": "backup_1", "type": "backup"}, "event": "BLOCK_JOB_PENDI=
NG", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "backup_1", "len": 67108864, "offset": 67108864, "sp=
eed": 0, "type": "backup"}, "event": "BLOCK_JOB_CANCELLED", "timestamp": =
{"microseconds": "USECS", "seconds": "SECS"}}
 {
   "bitmaps": {
     "device0": [
@@ -962,7 +962,7 @@ expecting 15 dirty sectors; have 15. OK!
 {"return": {}}
 {"data": {"device": "ref_backup_2", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
=20
---- Bitmap Backup #2 ---
+--- Test Backup #2 ---
=20
 {}
 {"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
@@ -972,12 +972,12 @@ expecting 15 dirty sectors; have 15. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "on-success", "device": "drive0", "job-i=
d": "bitmap_backup_2", "sync": "bitmap", "target": "bitmap_target_2"}}
+{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "on-success", "device": "drive0", "job-i=
d": "backup_2", "sync": "bitmap", "target": "backup_target_2"}}
 {"return": {}}
-{"execute": "job-finalize", "arguments": {"id": "bitmap_backup_2"}}
+{"execute": "job-finalize", "arguments": {"id": "backup_2"}}
 {"return": {}}
-{"data": {"id": "bitmap_backup_2", "type": "backup"}, "event": "BLOCK_JO=
B_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
-{"data": {"device": "bitmap_backup_2", "len": 67108864, "offset": 671088=
64, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "times=
tamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"id": "backup_2", "type": "backup"}, "event": "BLOCK_JOB_PENDI=
NG", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "backup_2", "len": 67108864, "offset": 67108864, "sp=
eed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": =
{"microseconds": "USECS", "seconds": "SECS"}}
 {
   "bitmaps": {
     "device0": [
@@ -1014,7 +1014,7 @@ qemu_img compare "TEST_DIR/PID-bsync2" "TEST_DIR/PI=
D-fbackup2" =3D=3D> Identical, OK
 qemu_img compare "TEST_DIR/PID-img" "TEST_DIR/PID-fbackup2" =3D=3D> Iden=
tical, OK!
=20
=20
-=3D=3D=3D Bitmap Sync Mode on-success with intermediate failure =3D=3D=3D
+=3D=3D=3D Mode bitmap; Bitmap Sync on-success with intermediate failure =
=3D=3D=3D
=20
 --- Preparing image & VM ---
=20
@@ -1103,7 +1103,7 @@ expecting 6 dirty sectors; have 6. OK!
=20
 {"return": ""}
=20
---- Bitmap Backup #1 ---
+--- Test Backup #1 ---
=20
 {}
 {"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
@@ -1113,10 +1113,10 @@ expecting 6 dirty sectors; have 6. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "on-success", "device": "drive0", "job-i=
d": "bitmap_backup_1", "sync": "bitmap", "target": "bitmap_target_1"}}
+{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "on-success", "device": "drive0", "job-i=
d": "backup_1", "sync": "bitmap", "target": "backup_target_1"}}
 {"return": {}}
-{"data": {"action": "report", "device": "bitmap_backup_1", "operation": =
"read"}, "event": "BLOCK_JOB_ERROR", "timestamp": {"microseconds": "USECS=
", "seconds": "SECS"}}
-{"data": {"device": "bitmap_backup_1", "error": "Input/output error", "l=
en": 67108864, "offset": 66781184, "speed": 0, "type": "backup"}, "event"=
: "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds"=
: "SECS"}}
+{"data": {"action": "report", "device": "backup_1", "operation": "read"}=
, "event": "BLOCK_JOB_ERROR", "timestamp": {"microseconds": "USECS", "sec=
onds": "SECS"}}
+{"data": {"device": "backup_1", "error": "Input/output error", "len": 67=
108864, "offset": 66781184, "speed": 0, "type": "backup"}, "event": "BLOC=
K_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS=
"}}
 {
   "bitmaps": {
     "device0": [
@@ -1179,7 +1179,7 @@ expecting 14 dirty sectors; have 14. OK!
 {"return": {}}
 {"data": {"device": "ref_backup_2", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
=20
---- Bitmap Backup #2 ---
+--- Test Backup #2 ---
=20
 {}
 {"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
@@ -1189,12 +1189,12 @@ expecting 14 dirty sectors; have 14. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "on-success", "device": "drive0", "job-i=
d": "bitmap_backup_2", "sync": "bitmap", "target": "bitmap_target_2"}}
+{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "on-success", "device": "drive0", "job-i=
d": "backup_2", "sync": "bitmap", "target": "backup_target_2"}}
 {"return": {}}
-{"execute": "job-finalize", "arguments": {"id": "bitmap_backup_2"}}
+{"execute": "job-finalize", "arguments": {"id": "backup_2"}}
 {"return": {}}
-{"data": {"id": "bitmap_backup_2", "type": "backup"}, "event": "BLOCK_JO=
B_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
-{"data": {"device": "bitmap_backup_2", "len": 67108864, "offset": 671088=
64, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "times=
tamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"id": "backup_2", "type": "backup"}, "event": "BLOCK_JOB_PENDI=
NG", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "backup_2", "len": 67108864, "offset": 67108864, "sp=
eed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": =
{"microseconds": "USECS", "seconds": "SECS"}}
 {
   "bitmaps": {
     "device0": [
@@ -1231,7 +1231,7 @@ qemu_img compare "TEST_DIR/PID-bsync2" "TEST_DIR/PI=
D-fbackup2" =3D=3D> Identical, OK
 qemu_img compare "TEST_DIR/PID-img" "TEST_DIR/PID-fbackup2" =3D=3D> Iden=
tical, OK!
=20
=20
-=3D=3D=3D Bitmap Sync Mode on-success without failure =3D=3D=3D
+=3D=3D=3D Mode bitmap; Bitmap Sync on-success without failure =3D=3D=3D
=20
 --- Preparing image & VM ---
=20
@@ -1318,7 +1318,7 @@ expecting 6 dirty sectors; have 6. OK!
 {"return": {}}
 {"data": {"device": "ref_backup_1", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
=20
---- Bitmap Backup #1 ---
+--- Test Backup #1 ---
=20
 {}
 {"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
@@ -1328,7 +1328,7 @@ expecting 6 dirty sectors; have 6. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "on-success", "device": "drive0", "job-i=
d": "bitmap_backup_1", "sync": "bitmap", "target": "bitmap_target_1"}}
+{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "on-success", "device": "drive0", "job-i=
d": "backup_1", "sync": "bitmap", "target": "backup_target_1"}}
 {"return": {}}
=20
 --- Write #2 ---
@@ -1379,10 +1379,10 @@ expecting 6 dirty sectors; have 6. OK!
 =3D Checking Bitmap (anonymous) =3D
 expecting 7 dirty sectors; have 7. OK!
=20
-{"execute": "job-finalize", "arguments": {"id": "bitmap_backup_1"}}
+{"execute": "job-finalize", "arguments": {"id": "backup_1"}}
 {"return": {}}
-{"data": {"id": "bitmap_backup_1", "type": "backup"}, "event": "BLOCK_JO=
B_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
-{"data": {"device": "bitmap_backup_1", "len": 67108864, "offset": 671088=
64, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "times=
tamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"id": "backup_1", "type": "backup"}, "event": "BLOCK_JOB_PENDI=
NG", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "backup_1", "len": 67108864, "offset": 67108864, "sp=
eed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": =
{"microseconds": "USECS", "seconds": "SECS"}}
 {
   "bitmaps": {
     "device0": [
@@ -1445,7 +1445,7 @@ expecting 12 dirty sectors; have 12. OK!
 {"return": {}}
 {"data": {"device": "ref_backup_2", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
=20
---- Bitmap Backup #2 ---
+--- Test Backup #2 ---
=20
 {}
 {"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
@@ -1455,12 +1455,12 @@ expecting 12 dirty sectors; have 12. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "on-success", "device": "drive0", "job-i=
d": "bitmap_backup_2", "sync": "bitmap", "target": "bitmap_target_2"}}
+{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "on-success", "device": "drive0", "job-i=
d": "backup_2", "sync": "bitmap", "target": "backup_target_2"}}
 {"return": {}}
-{"execute": "job-finalize", "arguments": {"id": "bitmap_backup_2"}}
+{"execute": "job-finalize", "arguments": {"id": "backup_2"}}
 {"return": {}}
-{"data": {"id": "bitmap_backup_2", "type": "backup"}, "event": "BLOCK_JO=
B_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
-{"data": {"device": "bitmap_backup_2", "len": 67108864, "offset": 671088=
64, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "times=
tamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"id": "backup_2", "type": "backup"}, "event": "BLOCK_JOB_PENDI=
NG", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "backup_2", "len": 67108864, "offset": 67108864, "sp=
eed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": =
{"microseconds": "USECS", "seconds": "SECS"}}
 {
   "bitmaps": {
     "device0": [
@@ -1497,7 +1497,7 @@ qemu_img compare "TEST_DIR/PID-bsync2" "TEST_DIR/PI=
D-fbackup2" =3D=3D> Identical, OK
 qemu_img compare "TEST_DIR/PID-img" "TEST_DIR/PID-fbackup2" =3D=3D> Iden=
tical, OK!
=20
=20
-=3D=3D=3D Bitmap Sync Mode always with simulated failure =3D=3D=3D
+=3D=3D=3D Mode bitmap; Bitmap Sync always with simulated failure =3D=3D=3D
=20
 --- Preparing image & VM ---
=20
@@ -1584,7 +1584,7 @@ expecting 6 dirty sectors; have 6. OK!
 {"return": {}}
 {"data": {"device": "ref_backup_1", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
=20
---- Bitmap Backup #1 ---
+--- Test Backup #1 ---
=20
 {}
 {"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
@@ -1594,7 +1594,7 @@ expecting 6 dirty sectors; have 6. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "always", "device": "drive0", "job-id": =
"bitmap_backup_1", "sync": "bitmap", "target": "bitmap_target_1"}}
+{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "always", "device": "drive0", "job-id": =
"backup_1", "sync": "bitmap", "target": "backup_target_1"}}
 {"return": {}}
=20
 --- Write #2 ---
@@ -1645,10 +1645,10 @@ expecting 6 dirty sectors; have 6. OK!
 =3D Checking Bitmap (anonymous) =3D
 expecting 7 dirty sectors; have 7. OK!
=20
-{"execute": "job-cancel", "arguments": {"id": "bitmap_backup_1"}}
+{"execute": "job-cancel", "arguments": {"id": "backup_1"}}
 {"return": {}}
-{"data": {"id": "bitmap_backup_1", "type": "backup"}, "event": "BLOCK_JO=
B_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
-{"data": {"device": "bitmap_backup_1", "len": 67108864, "offset": 671088=
64, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_CANCELLED", "times=
tamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"id": "backup_1", "type": "backup"}, "event": "BLOCK_JOB_PENDI=
NG", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "backup_1", "len": 67108864, "offset": 67108864, "sp=
eed": 0, "type": "backup"}, "event": "BLOCK_JOB_CANCELLED", "timestamp": =
{"microseconds": "USECS", "seconds": "SECS"}}
 {
   "bitmaps": {
     "device0": [
@@ -1711,7 +1711,7 @@ expecting 12 dirty sectors; have 12. OK!
 {"return": {}}
 {"data": {"device": "ref_backup_2", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
=20
---- Bitmap Backup #2 ---
+--- Test Backup #2 ---
=20
 {}
 {"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
@@ -1721,12 +1721,12 @@ expecting 12 dirty sectors; have 12. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "always", "device": "drive0", "job-id": =
"bitmap_backup_2", "sync": "bitmap", "target": "bitmap_target_2"}}
+{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "always", "device": "drive0", "job-id": =
"backup_2", "sync": "bitmap", "target": "backup_target_2"}}
 {"return": {}}
-{"execute": "job-finalize", "arguments": {"id": "bitmap_backup_2"}}
+{"execute": "job-finalize", "arguments": {"id": "backup_2"}}
 {"return": {}}
-{"data": {"id": "bitmap_backup_2", "type": "backup"}, "event": "BLOCK_JO=
B_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
-{"data": {"device": "bitmap_backup_2", "len": 67108864, "offset": 671088=
64, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "times=
tamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"id": "backup_2", "type": "backup"}, "event": "BLOCK_JOB_PENDI=
NG", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "backup_2", "len": 67108864, "offset": 67108864, "sp=
eed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": =
{"microseconds": "USECS", "seconds": "SECS"}}
 {
   "bitmaps": {
     "device0": [
@@ -1763,7 +1763,7 @@ qemu_img compare "TEST_DIR/PID-bsync2" "TEST_DIR/PI=
D-fbackup2" =3D=3D> Identical, OK
 qemu_img compare "TEST_DIR/PID-img" "TEST_DIR/PID-fbackup2" =3D=3D> Iden=
tical, OK!
=20
=20
-=3D=3D=3D Bitmap Sync Mode always with intermediate failure =3D=3D=3D
+=3D=3D=3D Mode bitmap; Bitmap Sync always with intermediate failure =3D=3D=
=3D
=20
 --- Preparing image & VM ---
=20
@@ -1852,7 +1852,7 @@ expecting 6 dirty sectors; have 6. OK!
=20
 {"return": ""}
=20
---- Bitmap Backup #1 ---
+--- Test Backup #1 ---
=20
 {}
 {"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
@@ -1862,10 +1862,10 @@ expecting 6 dirty sectors; have 6. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "always", "device": "drive0", "job-id": =
"bitmap_backup_1", "sync": "bitmap", "target": "bitmap_target_1"}}
+{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "always", "device": "drive0", "job-id": =
"backup_1", "sync": "bitmap", "target": "backup_target_1"}}
 {"return": {}}
-{"data": {"action": "report", "device": "bitmap_backup_1", "operation": =
"read"}, "event": "BLOCK_JOB_ERROR", "timestamp": {"microseconds": "USECS=
", "seconds": "SECS"}}
-{"data": {"device": "bitmap_backup_1", "error": "Input/output error", "l=
en": 67108864, "offset": 66781184, "speed": 0, "type": "backup"}, "event"=
: "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds"=
: "SECS"}}
+{"data": {"action": "report", "device": "backup_1", "operation": "read"}=
, "event": "BLOCK_JOB_ERROR", "timestamp": {"microseconds": "USECS", "sec=
onds": "SECS"}}
+{"data": {"device": "backup_1", "error": "Input/output error", "len": 67=
108864, "offset": 66781184, "speed": 0, "type": "backup"}, "event": "BLOC=
K_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS=
"}}
 {
   "bitmaps": {
     "device0": [
@@ -1928,7 +1928,7 @@ expecting 13 dirty sectors; have 13. OK!
 {"return": {}}
 {"data": {"device": "ref_backup_2", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
=20
---- Bitmap Backup #2 ---
+--- Test Backup #2 ---
=20
 {}
 {"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
@@ -1938,12 +1938,12 @@ expecting 13 dirty sectors; have 13. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "always", "device": "drive0", "job-id": =
"bitmap_backup_2", "sync": "bitmap", "target": "bitmap_target_2"}}
+{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "always", "device": "drive0", "job-id": =
"backup_2", "sync": "bitmap", "target": "backup_target_2"}}
 {"return": {}}
-{"execute": "job-finalize", "arguments": {"id": "bitmap_backup_2"}}
+{"execute": "job-finalize", "arguments": {"id": "backup_2"}}
 {"return": {}}
-{"data": {"id": "bitmap_backup_2", "type": "backup"}, "event": "BLOCK_JO=
B_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
-{"data": {"device": "bitmap_backup_2", "len": 67108864, "offset": 671088=
64, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "times=
tamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"id": "backup_2", "type": "backup"}, "event": "BLOCK_JOB_PENDI=
NG", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "backup_2", "len": 67108864, "offset": 67108864, "sp=
eed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": =
{"microseconds": "USECS", "seconds": "SECS"}}
 {
   "bitmaps": {
     "device0": [
@@ -1980,7 +1980,7 @@ qemu_img compare "TEST_DIR/PID-bsync2" "TEST_DIR/PI=
D-fbackup2" =3D=3D> Identical, OK
 qemu_img compare "TEST_DIR/PID-img" "TEST_DIR/PID-fbackup2" =3D=3D> Iden=
tical, OK!
=20
=20
-=3D=3D=3D Bitmap Sync Mode always without failure =3D=3D=3D
+=3D=3D=3D Mode bitmap; Bitmap Sync always without failure =3D=3D=3D
=20
 --- Preparing image & VM ---
=20
@@ -2067,7 +2067,7 @@ expecting 6 dirty sectors; have 6. OK!
 {"return": {}}
 {"data": {"device": "ref_backup_1", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
=20
---- Bitmap Backup #1 ---
+--- Test Backup #1 ---
=20
 {}
 {"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
@@ -2077,7 +2077,7 @@ expecting 6 dirty sectors; have 6. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "always", "device": "drive0", "job-id": =
"bitmap_backup_1", "sync": "bitmap", "target": "bitmap_target_1"}}
+{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "always", "device": "drive0", "job-id": =
"backup_1", "sync": "bitmap", "target": "backup_target_1"}}
 {"return": {}}
=20
 --- Write #2 ---
@@ -2128,10 +2128,10 @@ expecting 6 dirty sectors; have 6. OK!
 =3D Checking Bitmap (anonymous) =3D
 expecting 7 dirty sectors; have 7. OK!
=20
-{"execute": "job-finalize", "arguments": {"id": "bitmap_backup_1"}}
+{"execute": "job-finalize", "arguments": {"id": "backup_1"}}
 {"return": {}}
-{"data": {"id": "bitmap_backup_1", "type": "backup"}, "event": "BLOCK_JO=
B_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
-{"data": {"device": "bitmap_backup_1", "len": 67108864, "offset": 671088=
64, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "times=
tamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"id": "backup_1", "type": "backup"}, "event": "BLOCK_JOB_PENDI=
NG", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "backup_1", "len": 67108864, "offset": 67108864, "sp=
eed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": =
{"microseconds": "USECS", "seconds": "SECS"}}
 {
   "bitmaps": {
     "device0": [
@@ -2194,7 +2194,7 @@ expecting 12 dirty sectors; have 12. OK!
 {"return": {}}
 {"data": {"device": "ref_backup_2", "len": 67108864, "offset": 67108864,=
 "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestam=
p": {"microseconds": "USECS", "seconds": "SECS"}}
=20
---- Bitmap Backup #2 ---
+--- Test Backup #2 ---
=20
 {}
 {"execute": "job-dismiss", "arguments": {"id": "bdc-file-job"}}
@@ -2204,12 +2204,12 @@ expecting 12 dirty sectors; have 12. OK!
 {"execute": "job-dismiss", "arguments": {"id": "bdc-fmt-job"}}
 {"return": {}}
 {}
-{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "always", "device": "drive0", "job-id": =
"bitmap_backup_2", "sync": "bitmap", "target": "bitmap_target_2"}}
+{"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "always", "device": "drive0", "job-id": =
"backup_2", "sync": "bitmap", "target": "backup_target_2"}}
 {"return": {}}
-{"execute": "job-finalize", "arguments": {"id": "bitmap_backup_2"}}
+{"execute": "job-finalize", "arguments": {"id": "backup_2"}}
 {"return": {}}
-{"data": {"id": "bitmap_backup_2", "type": "backup"}, "event": "BLOCK_JO=
B_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
-{"data": {"device": "bitmap_backup_2", "len": 67108864, "offset": 671088=
64, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "times=
tamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"id": "backup_2", "type": "backup"}, "event": "BLOCK_JOB_PENDI=
NG", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "backup_2", "len": 67108864, "offset": 67108864, "sp=
eed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": =
{"microseconds": "USECS", "seconds": "SECS"}}
 {
   "bitmaps": {
     "device0": [
--=20
2.21.0


