Return-Path: <SRS0=pVGd=WM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A57C0C3A59D
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 23:37:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6682F2086C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 23:37:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6682F2086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33388 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hylmz-0004A4-7r
	for qemu-devel@archiver.kernel.org; Fri, 16 Aug 2019 19:37:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47106)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsnow@redhat.com>) id 1hylQ0-00071q-Bs
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 19:14:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1hylPx-0006IN-N6
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 19:14:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43746)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>)
 id 1hylPr-0006AX-TW; Fri, 16 Aug 2019 19:13:52 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 296B5C049E1A;
 Fri, 16 Aug 2019 23:13:48 +0000 (UTC)
Received: from probe.bos.redhat.com (dhcp-17-187.bos.redhat.com [10.18.17.187])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 76A5619C6A;
 Fri, 16 Aug 2019 23:13:47 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 16 Aug 2019 19:13:09 -0400
Message-Id: <20190816231318.8650-28-jsnow@redhat.com>
In-Reply-To: <20190816231318.8650-1-jsnow@redhat.com>
References: <20190816231318.8650-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.31]); Fri, 16 Aug 2019 23:13:48 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 27/36] block/backup: improve sync=bitmap work
 estimates
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
Cc: peter.maydell@linaro.org, jsnow@redhat.com, qemu-stable@nongnu.org,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When making backups based on bitmaps, the work estimate can be more
accurate. Update iotests to reflect the new strategy.

TOP work estimates are broken, but do not get worse with this commit.
That issue is addressed in the following commits instead.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Message-id: 20190716000117.25219-7-jsnow@redhat.com
Signed-off-by: John Snow <jsnow@redhat.com>
---
 block/backup.c             |  8 +++-----
 tests/qemu-iotests/256.out |  4 ++--
 tests/qemu-iotests/257.out | 36 ++++++++++++++++++------------------
 3 files changed, 23 insertions(+), 25 deletions(-)

diff --git a/block/backup.c b/block/backup.c
index f704c83a98f..b04ab2d5f0c 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -459,9 +459,8 @@ static void backup_incremental_init_copy_bitmap(Backu=
pBlockJob *job)
                                                 NULL, true);
     assert(ret);
=20
-    /* TODO job_progress_set_remaining() would make more sense */
-    job_progress_update(&job->common.job,
-                        job->len - bdrv_get_dirty_count(job->copy_bitmap=
));
+    job_progress_set_remaining(&job->common.job,
+                               bdrv_get_dirty_count(job->copy_bitmap));
 }
=20
 static int coroutine_fn backup_run(Job *job, Error **errp)
@@ -473,12 +472,11 @@ static int coroutine_fn backup_run(Job *job, Error =
**errp)
     QLIST_INIT(&s->inflight_reqs);
     qemu_co_rwlock_init(&s->flush_rwlock);
=20
-    job_progress_set_remaining(job, s->len);
-
     if (s->sync_mode =3D=3D MIRROR_SYNC_MODE_BITMAP) {
         backup_incremental_init_copy_bitmap(s);
     } else {
         bdrv_set_dirty_bitmap(s->copy_bitmap, 0, s->len);
+        job_progress_set_remaining(job, s->len);
     }
=20
     s->before_write.notify =3D backup_before_write_notify;
diff --git a/tests/qemu-iotests/256.out b/tests/qemu-iotests/256.out
index eec38614ec4..f18ecb0f912 100644
--- a/tests/qemu-iotests/256.out
+++ b/tests/qemu-iotests/256.out
@@ -113,7 +113,7 @@
 {
   "return": {}
 }
-{"data": {"device": "j2", "len": 67108864, "offset": 67108864, "speed": =
0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"micr=
oseconds": "USECS", "seconds": "SECS"}}
-{"data": {"device": "j3", "len": 67108864, "offset": 67108864, "speed": =
0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"micr=
oseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "j2", "len": 0, "offset": 0, "speed": 0, "type": "ba=
ckup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "US=
ECS", "seconds": "SECS"}}
+{"data": {"device": "j3", "len": 0, "offset": 0, "speed": 0, "type": "ba=
ckup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "US=
ECS", "seconds": "SECS"}}
=20
 --- Done ---
diff --git a/tests/qemu-iotests/257.out b/tests/qemu-iotests/257.out
index 43f2e0f9c99..811b1b11f19 100644
--- a/tests/qemu-iotests/257.out
+++ b/tests/qemu-iotests/257.out
@@ -150,7 +150,7 @@ expecting 7 dirty sectors; have 7. OK!
 {"execute": "job-cancel", "arguments": {"id": "backup_1"}}
 {"return": {}}
 {"data": {"id": "backup_1", "type": "backup"}, "event": "BLOCK_JOB_PENDI=
NG", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
-{"data": {"device": "backup_1", "len": 67108864, "offset": 67108864, "sp=
eed": 0, "type": "backup"}, "event": "BLOCK_JOB_CANCELLED", "timestamp": =
{"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "backup_1", "len": 393216, "offset": 393216, "speed"=
: 0, "type": "backup"}, "event": "BLOCK_JOB_CANCELLED", "timestamp": {"mi=
croseconds": "USECS", "seconds": "SECS"}}
 {
   "bitmaps": {
     "device0": [
@@ -228,7 +228,7 @@ expecting 15 dirty sectors; have 15. OK!
 {"execute": "job-finalize", "arguments": {"id": "backup_2"}}
 {"return": {}}
 {"data": {"id": "backup_2", "type": "backup"}, "event": "BLOCK_JOB_PENDI=
NG", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
-{"data": {"device": "backup_2", "len": 67108864, "offset": 67108864, "sp=
eed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": =
{"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "backup_2", "len": 983040, "offset": 983040, "speed"=
: 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"mi=
croseconds": "USECS", "seconds": "SECS"}}
 {
   "bitmaps": {
     "device0": [
@@ -367,7 +367,7 @@ expecting 6 dirty sectors; have 6. OK!
 {"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "never", "device": "drive0", "job-id": "=
backup_1", "sync": "bitmap", "target": "backup_target_1"}}
 {"return": {}}
 {"data": {"action": "report", "device": "backup_1", "operation": "read"}=
, "event": "BLOCK_JOB_ERROR", "timestamp": {"microseconds": "USECS", "sec=
onds": "SECS"}}
-{"data": {"device": "backup_1", "error": "Input/output error", "len": 67=
108864, "offset": 66781184, "speed": 0, "type": "backup"}, "event": "BLOC=
K_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS=
"}}
+{"data": {"device": "backup_1", "error": "Input/output error", "len": 39=
3216, "offset": 65536, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB=
_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 {
   "bitmaps": {
     "device0": [
@@ -445,7 +445,7 @@ expecting 14 dirty sectors; have 14. OK!
 {"execute": "job-finalize", "arguments": {"id": "backup_2"}}
 {"return": {}}
 {"data": {"id": "backup_2", "type": "backup"}, "event": "BLOCK_JOB_PENDI=
NG", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
-{"data": {"device": "backup_2", "len": 67108864, "offset": 67108864, "sp=
eed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": =
{"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "backup_2", "len": 917504, "offset": 917504, "speed"=
: 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"mi=
croseconds": "USECS", "seconds": "SECS"}}
 {
   "bitmaps": {
     "device0": [
@@ -633,7 +633,7 @@ expecting 7 dirty sectors; have 7. OK!
 {"execute": "job-finalize", "arguments": {"id": "backup_1"}}
 {"return": {}}
 {"data": {"id": "backup_1", "type": "backup"}, "event": "BLOCK_JOB_PENDI=
NG", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
-{"data": {"device": "backup_1", "len": 67108864, "offset": 67108864, "sp=
eed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": =
{"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "backup_1", "len": 393216, "offset": 393216, "speed"=
: 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"mi=
croseconds": "USECS", "seconds": "SECS"}}
 {
   "bitmaps": {
     "device0": [
@@ -711,7 +711,7 @@ expecting 15 dirty sectors; have 15. OK!
 {"execute": "job-finalize", "arguments": {"id": "backup_2"}}
 {"return": {}}
 {"data": {"id": "backup_2", "type": "backup"}, "event": "BLOCK_JOB_PENDI=
NG", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
-{"data": {"device": "backup_2", "len": 67108864, "offset": 67108864, "sp=
eed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": =
{"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "backup_2", "len": 983040, "offset": 983040, "speed"=
: 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"mi=
croseconds": "USECS", "seconds": "SECS"}}
 {
   "bitmaps": {
     "device0": [
@@ -899,7 +899,7 @@ expecting 7 dirty sectors; have 7. OK!
 {"execute": "job-cancel", "arguments": {"id": "backup_1"}}
 {"return": {}}
 {"data": {"id": "backup_1", "type": "backup"}, "event": "BLOCK_JOB_PENDI=
NG", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
-{"data": {"device": "backup_1", "len": 67108864, "offset": 67108864, "sp=
eed": 0, "type": "backup"}, "event": "BLOCK_JOB_CANCELLED", "timestamp": =
{"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "backup_1", "len": 393216, "offset": 393216, "speed"=
: 0, "type": "backup"}, "event": "BLOCK_JOB_CANCELLED", "timestamp": {"mi=
croseconds": "USECS", "seconds": "SECS"}}
 {
   "bitmaps": {
     "device0": [
@@ -977,7 +977,7 @@ expecting 15 dirty sectors; have 15. OK!
 {"execute": "job-finalize", "arguments": {"id": "backup_2"}}
 {"return": {}}
 {"data": {"id": "backup_2", "type": "backup"}, "event": "BLOCK_JOB_PENDI=
NG", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
-{"data": {"device": "backup_2", "len": 67108864, "offset": 67108864, "sp=
eed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": =
{"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "backup_2", "len": 983040, "offset": 983040, "speed"=
: 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"mi=
croseconds": "USECS", "seconds": "SECS"}}
 {
   "bitmaps": {
     "device0": [
@@ -1116,7 +1116,7 @@ expecting 6 dirty sectors; have 6. OK!
 {"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "on-success", "device": "drive0", "job-i=
d": "backup_1", "sync": "bitmap", "target": "backup_target_1"}}
 {"return": {}}
 {"data": {"action": "report", "device": "backup_1", "operation": "read"}=
, "event": "BLOCK_JOB_ERROR", "timestamp": {"microseconds": "USECS", "sec=
onds": "SECS"}}
-{"data": {"device": "backup_1", "error": "Input/output error", "len": 67=
108864, "offset": 66781184, "speed": 0, "type": "backup"}, "event": "BLOC=
K_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS=
"}}
+{"data": {"device": "backup_1", "error": "Input/output error", "len": 39=
3216, "offset": 65536, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB=
_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 {
   "bitmaps": {
     "device0": [
@@ -1194,7 +1194,7 @@ expecting 14 dirty sectors; have 14. OK!
 {"execute": "job-finalize", "arguments": {"id": "backup_2"}}
 {"return": {}}
 {"data": {"id": "backup_2", "type": "backup"}, "event": "BLOCK_JOB_PENDI=
NG", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
-{"data": {"device": "backup_2", "len": 67108864, "offset": 67108864, "sp=
eed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": =
{"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "backup_2", "len": 917504, "offset": 917504, "speed"=
: 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"mi=
croseconds": "USECS", "seconds": "SECS"}}
 {
   "bitmaps": {
     "device0": [
@@ -1382,7 +1382,7 @@ expecting 7 dirty sectors; have 7. OK!
 {"execute": "job-finalize", "arguments": {"id": "backup_1"}}
 {"return": {}}
 {"data": {"id": "backup_1", "type": "backup"}, "event": "BLOCK_JOB_PENDI=
NG", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
-{"data": {"device": "backup_1", "len": 67108864, "offset": 67108864, "sp=
eed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": =
{"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "backup_1", "len": 393216, "offset": 393216, "speed"=
: 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"mi=
croseconds": "USECS", "seconds": "SECS"}}
 {
   "bitmaps": {
     "device0": [
@@ -1460,7 +1460,7 @@ expecting 12 dirty sectors; have 12. OK!
 {"execute": "job-finalize", "arguments": {"id": "backup_2"}}
 {"return": {}}
 {"data": {"id": "backup_2", "type": "backup"}, "event": "BLOCK_JOB_PENDI=
NG", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
-{"data": {"device": "backup_2", "len": 67108864, "offset": 67108864, "sp=
eed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": =
{"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "backup_2", "len": 786432, "offset": 786432, "speed"=
: 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"mi=
croseconds": "USECS", "seconds": "SECS"}}
 {
   "bitmaps": {
     "device0": [
@@ -1648,7 +1648,7 @@ expecting 7 dirty sectors; have 7. OK!
 {"execute": "job-cancel", "arguments": {"id": "backup_1"}}
 {"return": {}}
 {"data": {"id": "backup_1", "type": "backup"}, "event": "BLOCK_JOB_PENDI=
NG", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
-{"data": {"device": "backup_1", "len": 67108864, "offset": 67108864, "sp=
eed": 0, "type": "backup"}, "event": "BLOCK_JOB_CANCELLED", "timestamp": =
{"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "backup_1", "len": 393216, "offset": 393216, "speed"=
: 0, "type": "backup"}, "event": "BLOCK_JOB_CANCELLED", "timestamp": {"mi=
croseconds": "USECS", "seconds": "SECS"}}
 {
   "bitmaps": {
     "device0": [
@@ -1726,7 +1726,7 @@ expecting 12 dirty sectors; have 12. OK!
 {"execute": "job-finalize", "arguments": {"id": "backup_2"}}
 {"return": {}}
 {"data": {"id": "backup_2", "type": "backup"}, "event": "BLOCK_JOB_PENDI=
NG", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
-{"data": {"device": "backup_2", "len": 67108864, "offset": 67108864, "sp=
eed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": =
{"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "backup_2", "len": 786432, "offset": 786432, "speed"=
: 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"mi=
croseconds": "USECS", "seconds": "SECS"}}
 {
   "bitmaps": {
     "device0": [
@@ -1865,7 +1865,7 @@ expecting 6 dirty sectors; have 6. OK!
 {"execute": "blockdev-backup", "arguments": {"auto-finalize": false, "bi=
tmap": "bitmap0", "bitmap-mode": "always", "device": "drive0", "job-id": =
"backup_1", "sync": "bitmap", "target": "backup_target_1"}}
 {"return": {}}
 {"data": {"action": "report", "device": "backup_1", "operation": "read"}=
, "event": "BLOCK_JOB_ERROR", "timestamp": {"microseconds": "USECS", "sec=
onds": "SECS"}}
-{"data": {"device": "backup_1", "error": "Input/output error", "len": 67=
108864, "offset": 66781184, "speed": 0, "type": "backup"}, "event": "BLOC=
K_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS=
"}}
+{"data": {"device": "backup_1", "error": "Input/output error", "len": 39=
3216, "offset": 65536, "speed": 0, "type": "backup"}, "event": "BLOCK_JOB=
_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 {
   "bitmaps": {
     "device0": [
@@ -1943,7 +1943,7 @@ expecting 13 dirty sectors; have 13. OK!
 {"execute": "job-finalize", "arguments": {"id": "backup_2"}}
 {"return": {}}
 {"data": {"id": "backup_2", "type": "backup"}, "event": "BLOCK_JOB_PENDI=
NG", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
-{"data": {"device": "backup_2", "len": 67108864, "offset": 67108864, "sp=
eed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": =
{"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "backup_2", "len": 851968, "offset": 851968, "speed"=
: 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"mi=
croseconds": "USECS", "seconds": "SECS"}}
 {
   "bitmaps": {
     "device0": [
@@ -2131,7 +2131,7 @@ expecting 7 dirty sectors; have 7. OK!
 {"execute": "job-finalize", "arguments": {"id": "backup_1"}}
 {"return": {}}
 {"data": {"id": "backup_1", "type": "backup"}, "event": "BLOCK_JOB_PENDI=
NG", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
-{"data": {"device": "backup_1", "len": 67108864, "offset": 67108864, "sp=
eed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": =
{"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "backup_1", "len": 393216, "offset": 393216, "speed"=
: 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"mi=
croseconds": "USECS", "seconds": "SECS"}}
 {
   "bitmaps": {
     "device0": [
@@ -2209,7 +2209,7 @@ expecting 12 dirty sectors; have 12. OK!
 {"execute": "job-finalize", "arguments": {"id": "backup_2"}}
 {"return": {}}
 {"data": {"id": "backup_2", "type": "backup"}, "event": "BLOCK_JOB_PENDI=
NG", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
-{"data": {"device": "backup_2", "len": 67108864, "offset": 67108864, "sp=
eed": 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": =
{"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "backup_2", "len": 786432, "offset": 786432, "speed"=
: 0, "type": "backup"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"mi=
croseconds": "USECS", "seconds": "SECS"}}
 {
   "bitmaps": {
     "device0": [
--=20
2.21.0


