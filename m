Return-Path: <SRS0=+QfZ=VN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E211BC7618F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 00:04:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A46C420880
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 00:04:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A46C420880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44488 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnAwr-0000Sr-Rp
	for qemu-devel@archiver.kernel.org; Mon, 15 Jul 2019 20:04:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44699)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jsnow@redhat.com>) id 1hnAuX-0007Mg-HB
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 20:01:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1hnAuT-0007aM-Q0
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 20:01:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50888)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>)
 id 1hnAuO-0007UI-Is; Mon, 15 Jul 2019 20:01:28 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D63AD30821A3;
 Tue, 16 Jul 2019 00:01:27 +0000 (UTC)
Received: from probe.bos.redhat.com (dhcp-17-130.bos.redhat.com [10.18.17.130])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 02D9D6085B;
 Tue, 16 Jul 2019 00:01:26 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Date: Mon, 15 Jul 2019 20:01:12 -0400
Message-Id: <20190716000117.25219-7-jsnow@redhat.com>
In-Reply-To: <20190716000117.25219-1-jsnow@redhat.com>
References: <20190716000117.25219-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Tue, 16 Jul 2019 00:01:27 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 06/11] block/backup: improve sync=bitmap
 work estimates
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
Cc: Kevin Wolf <kwolf@redhat.com>, vsementsov@virtuozzo.com,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When making backups based on bitmaps, the work estimate can be more
accurate. Update iotests to reflect the new strategy.

TOP work estimates are broken, but do not get worse with this commit.
That issue is addressed in the following commits instead.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 block/backup.c             |  8 +++-----
 tests/qemu-iotests/256.out |  4 ++--
 tests/qemu-iotests/257.out | 36 ++++++++++++++++++------------------
 3 files changed, 23 insertions(+), 25 deletions(-)

diff --git a/block/backup.c b/block/backup.c
index a64b768e24..22fafbb80f 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -449,9 +449,8 @@ static void backup_incremental_init_copy_bitmap(Backu=
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
@@ -463,12 +462,11 @@ static int coroutine_fn backup_run(Job *job, Error =
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
index eec38614ec..f18ecb0f91 100644
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
index 43f2e0f9c9..811b1b11f1 100644
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


