Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7808C34026
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 14:18:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7035F2176D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 14:18:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h7sUJR4+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7035F2176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35942 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j43hN-0002vZ-Fx
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 09:18:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53117)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1j43Xz-0007b3-JZ
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 09:08:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1j43Xx-0001a3-I6
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 09:08:23 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:58115
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1j43Xx-0001ZX-Bw
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 09:08:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582034901;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RWOhqFRWeheZLwj4fm2AJ1O6G5N5fhnM2m0057AxEUM=;
 b=h7sUJR4+YDlZp2u40eYksQWM2r3W8itmEphqWVJIgcQH+cd7nb2s9oBp/JUY9Gf3TUGIx2
 oYWBOFd3UUDa4twX9B6Kxw4xDvMp1BjJYzYZqSDP9xQ/WTMsPXXL83sMdhThRXOyJCfak2
 ImikcRnRn6Ta6hgOZLs+vJCRJclVfrk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-153-MUlA0BNNOEqOEKYMwt6i7g-1; Tue, 18 Feb 2020 09:08:13 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E6DAD107ACC9;
 Tue, 18 Feb 2020 14:08:11 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-117-181.ams2.redhat.com
 [10.36.117.181])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D5A9919E9C;
 Tue, 18 Feb 2020 14:08:10 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 15/36] iotests: Test error handling policies with block-commit
Date: Tue, 18 Feb 2020 15:07:01 +0100
Message-Id: <20200218140722.23876-16-kwolf@redhat.com>
In-Reply-To: <20200218140722.23876-1-kwolf@redhat.com>
References: <20200218140722.23876-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: MUlA0BNNOEqOEKYMwt6i7g-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This tests both read failure (from the top node) and write failure (to
the base node) for on-error=3Dreport/stop/ignore.

As block-commit actually starts two different types of block jobs
(mirror.c for committing the active later, commit.c for intermediate
layers), all tests are run for both cases.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Message-Id: <20200214200812.28180-8-kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/040     | 283 +++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/040.out |   4 +-
 2 files changed, 285 insertions(+), 2 deletions(-)

diff --git a/tests/qemu-iotests/040 b/tests/qemu-iotests/040
index 2e7ee0e84f..32c82b4ec6 100755
--- a/tests/qemu-iotests/040
+++ b/tests/qemu-iotests/040
@@ -430,6 +430,289 @@ class TestReopenOverlay(ImageCommitTestCase):
     def test_reopen_overlay(self):
         self.run_commit_test(self.img1, self.img0)
=20
+class TestErrorHandling(iotests.QMPTestCase):
+    image_len =3D 2 * 1024 * 1024
+
+    def setUp(self):
+        iotests.create_image(backing_img, self.image_len)
+        qemu_img('create', '-f', iotests.imgfmt, '-o', 'backing_file=3D%s'=
 % backing_img, mid_img)
+        qemu_img('create', '-f', iotests.imgfmt, '-o', 'backing_file=3D%s'=
 % mid_img, test_img)
+
+        qemu_io('-f', iotests.imgfmt, '-c', 'write -P 0x11 0 512k', mid_im=
g)
+        qemu_io('-f', iotests.imgfmt, '-c', 'write -P 0x22 0 512k', test_i=
mg)
+
+        self.vm =3D iotests.VM()
+        self.vm.launch()
+
+        self.blkdebug_file =3D iotests.file_path("blkdebug.conf")
+
+    def tearDown(self):
+        self.vm.shutdown()
+        os.remove(test_img)
+        os.remove(mid_img)
+        os.remove(backing_img)
+
+    def blockdev_add(self, **kwargs):
+        result =3D self.vm.qmp('blockdev-add', **kwargs)
+        self.assert_qmp(result, 'return', {})
+
+    def add_block_nodes(self, base_debug=3DNone, mid_debug=3DNone, top_deb=
ug=3DNone):
+        self.blockdev_add(node_name=3D'base-file', driver=3D'file',
+                          filename=3Dbacking_img)
+        self.blockdev_add(node_name=3D'mid-file', driver=3D'file',
+                          filename=3Dmid_img)
+        self.blockdev_add(node_name=3D'top-file', driver=3D'file',
+                          filename=3Dtest_img)
+
+        if base_debug:
+            self.blockdev_add(node_name=3D'base-dbg', driver=3D'blkdebug',
+                              image=3D'base-file', inject_error=3Dbase_deb=
ug)
+        if mid_debug:
+            self.blockdev_add(node_name=3D'mid-dbg', driver=3D'blkdebug',
+                              image=3D'mid-file', inject_error=3Dmid_debug=
)
+        if top_debug:
+            self.blockdev_add(node_name=3D'top-dbg', driver=3D'blkdebug',
+                              image=3D'top-file', inject_error=3Dtop_debug=
)
+
+        self.blockdev_add(node_name=3D'base-fmt', driver=3D'raw',
+                          file=3D('base-dbg' if base_debug else 'base-file=
'))
+        self.blockdev_add(node_name=3D'mid-fmt', driver=3Diotests.imgfmt,
+                          file=3D('mid-dbg' if mid_debug else 'mid-file'),
+                          backing=3D'base-fmt')
+        self.blockdev_add(node_name=3D'top-fmt', driver=3Diotests.imgfmt,
+                          file=3D('top-dbg' if top_debug else 'top-file'),
+                          backing=3D'mid-fmt')
+
+    def run_job(self, expected_events, error_pauses_job=3DFalse):
+        match_device =3D {'data': {'device': 'job0'}}
+        events =3D [
+            ('BLOCK_JOB_COMPLETED', match_device),
+            ('BLOCK_JOB_CANCELLED', match_device),
+            ('BLOCK_JOB_ERROR', match_device),
+            ('BLOCK_JOB_READY', match_device),
+        ]
+
+        completed =3D False
+        log =3D []
+        while not completed:
+            ev =3D self.vm.events_wait(events, timeout=3D5.0)
+            if ev['event'] =3D=3D 'BLOCK_JOB_COMPLETED':
+                completed =3D True
+            elif ev['event'] =3D=3D 'BLOCK_JOB_ERROR':
+                if error_pauses_job:
+                    result =3D self.vm.qmp('block-job-resume', device=3D'j=
ob0')
+                    self.assert_qmp(result, 'return', {})
+            elif ev['event'] =3D=3D 'BLOCK_JOB_READY':
+                result =3D self.vm.qmp('block-job-complete', device=3D'job=
0')
+                self.assert_qmp(result, 'return', {})
+            else:
+                self.fail("Unexpected event: %s" % ev)
+            log.append(iotests.filter_qmp_event(ev))
+
+        self.maxDiff =3D None
+        self.assertEqual(expected_events, log)
+
+    def event_error(self, op, action):
+        return {
+            'event': 'BLOCK_JOB_ERROR',
+            'data': {'action': action, 'device': 'job0', 'operation': op},
+            'timestamp': {'microseconds': 'USECS', 'seconds': 'SECS'}
+        }
+
+    def event_ready(self):
+        return {
+            'event': 'BLOCK_JOB_READY',
+            'data': {'device': 'job0',
+                     'len': 524288,
+                     'offset': 524288,
+                     'speed': 0,
+                     'type': 'commit'},
+            'timestamp': {'microseconds': 'USECS', 'seconds': 'SECS'},
+        }
+
+    def event_completed(self, errmsg=3DNone, active=3DTrue):
+        max_len =3D 524288 if active else self.image_len
+        data =3D {
+            'device': 'job0',
+            'len': max_len,
+            'offset': 0 if errmsg else max_len,
+            'speed': 0,
+            'type': 'commit'
+        }
+        if errmsg:
+            data['error'] =3D errmsg
+
+        return {
+            'event': 'BLOCK_JOB_COMPLETED',
+            'data': data,
+            'timestamp': {'microseconds': 'USECS', 'seconds': 'SECS'},
+        }
+
+    def blkdebug_event(self, event, is_raw=3DFalse):
+        if event:
+            return [{
+                'event': event,
+                'sector': 512 if is_raw else 1024,
+                'once': True,
+            }]
+        return None
+
+    def prepare_and_start_job(self, on_error, active=3DTrue,
+                              top_event=3DNone, mid_event=3DNone, base_eve=
nt=3DNone):
+
+        top_debug =3D self.blkdebug_event(top_event)
+        mid_debug =3D self.blkdebug_event(mid_event)
+        base_debug =3D self.blkdebug_event(base_event, True)
+
+        self.add_block_nodes(top_debug=3Dtop_debug, mid_debug=3Dmid_debug,
+                             base_debug=3Dbase_debug)
+
+        result =3D self.vm.qmp('block-commit', job_id=3D'job0', device=3D'=
top-fmt',
+                             top_node=3D'top-fmt' if active else 'mid-fmt'=
,
+                             base_node=3D'mid-fmt' if active else 'base-fm=
t',
+                             on_error=3Don_error)
+        self.assert_qmp(result, 'return', {})
+
+    def testActiveReadErrorReport(self):
+        self.prepare_and_start_job('report', top_event=3D'read_aio')
+        self.run_job([
+            self.event_error('read', 'report'),
+            self.event_completed('Input/output error')
+        ])
+
+        self.vm.shutdown()
+        self.assertFalse(iotests.compare_images(test_img, mid_img),
+                         'target image matches source after error')
+
+    def testActiveReadErrorStop(self):
+        self.prepare_and_start_job('stop', top_event=3D'read_aio')
+        self.run_job([
+            self.event_error('read', 'stop'),
+            self.event_ready(),
+            self.event_completed()
+        ], error_pauses_job=3DTrue)
+
+        self.vm.shutdown()
+        self.assertTrue(iotests.compare_images(test_img, mid_img),
+                        'target image does not match source after commit')
+
+    def testActiveReadErrorIgnore(self):
+        self.prepare_and_start_job('ignore', top_event=3D'read_aio')
+        self.run_job([
+            self.event_error('read', 'ignore'),
+            self.event_ready(),
+            self.event_completed()
+        ])
+
+        # For commit, 'ignore' actually means retry, so this will succeed
+        self.vm.shutdown()
+        self.assertTrue(iotests.compare_images(test_img, mid_img),
+                        'target image does not match source after commit')
+
+    def testActiveWriteErrorReport(self):
+        self.prepare_and_start_job('report', mid_event=3D'write_aio')
+        self.run_job([
+            self.event_error('write', 'report'),
+            self.event_completed('Input/output error')
+        ])
+
+        self.vm.shutdown()
+        self.assertFalse(iotests.compare_images(test_img, mid_img),
+                         'target image matches source after error')
+
+    def testActiveWriteErrorStop(self):
+        self.prepare_and_start_job('stop', mid_event=3D'write_aio')
+        self.run_job([
+            self.event_error('write', 'stop'),
+            self.event_ready(),
+            self.event_completed()
+        ], error_pauses_job=3DTrue)
+
+        self.vm.shutdown()
+        self.assertTrue(iotests.compare_images(test_img, mid_img),
+                        'target image does not match source after commit')
+
+    def testActiveWriteErrorIgnore(self):
+        self.prepare_and_start_job('ignore', mid_event=3D'write_aio')
+        self.run_job([
+            self.event_error('write', 'ignore'),
+            self.event_ready(),
+            self.event_completed()
+        ])
+
+        # For commit, 'ignore' actually means retry, so this will succeed
+        self.vm.shutdown()
+        self.assertTrue(iotests.compare_images(test_img, mid_img),
+                        'target image does not match source after commit')
+
+    def testIntermediateReadErrorReport(self):
+        self.prepare_and_start_job('report', active=3DFalse, mid_event=3D'=
read_aio')
+        self.run_job([
+            self.event_error('read', 'report'),
+            self.event_completed('Input/output error', active=3DFalse)
+        ])
+
+        self.vm.shutdown()
+        self.assertFalse(iotests.compare_images(mid_img, backing_img, fmt2=
=3D'raw'),
+                         'target image matches source after error')
+
+    def testIntermediateReadErrorStop(self):
+        self.prepare_and_start_job('stop', active=3DFalse, mid_event=3D're=
ad_aio')
+        self.run_job([
+            self.event_error('read', 'stop'),
+            self.event_completed(active=3DFalse)
+        ], error_pauses_job=3DTrue)
+
+        self.vm.shutdown()
+        self.assertTrue(iotests.compare_images(mid_img, backing_img, fmt2=
=3D'raw'),
+                        'target image does not match source after commit')
+
+    def testIntermediateReadErrorIgnore(self):
+        self.prepare_and_start_job('ignore', active=3DFalse, mid_event=3D'=
read_aio')
+        self.run_job([
+            self.event_error('read', 'ignore'),
+            self.event_completed(active=3DFalse)
+        ])
+
+        # For commit, 'ignore' actually means retry, so this will succeed
+        self.vm.shutdown()
+        self.assertTrue(iotests.compare_images(mid_img, backing_img, fmt2=
=3D'raw'),
+                        'target image does not match source after commit')
+
+    def testIntermediateWriteErrorReport(self):
+        self.prepare_and_start_job('report', active=3DFalse, base_event=3D=
'write_aio')
+        self.run_job([
+            self.event_error('write', 'report'),
+            self.event_completed('Input/output error', active=3DFalse)
+        ])
+
+        self.vm.shutdown()
+        self.assertFalse(iotests.compare_images(mid_img, backing_img, fmt2=
=3D'raw'),
+                         'target image matches source after error')
+
+    def testIntermediateWriteErrorStop(self):
+        self.prepare_and_start_job('stop', active=3DFalse, base_event=3D'w=
rite_aio')
+        self.run_job([
+            self.event_error('write', 'stop'),
+            self.event_completed(active=3DFalse)
+        ], error_pauses_job=3DTrue)
+
+        self.vm.shutdown()
+        self.assertTrue(iotests.compare_images(mid_img, backing_img, fmt2=
=3D'raw'),
+                        'target image does not match source after commit')
+
+    def testIntermediateWriteErrorIgnore(self):
+        self.prepare_and_start_job('ignore', active=3DFalse, base_event=3D=
'write_aio')
+        self.run_job([
+            self.event_error('write', 'ignore'),
+            self.event_completed(active=3DFalse)
+        ])
+
+        # For commit, 'ignore' actually means retry, so this will succeed
+        self.vm.shutdown()
+        self.assertTrue(iotests.compare_images(mid_img, backing_img, fmt2=
=3D'raw'),
+                        'target image does not match source after commit')
+
 if __name__ =3D=3D '__main__':
     iotests.main(supported_fmts=3D['qcow2', 'qed'],
                  supported_protocols=3D['file'])
diff --git a/tests/qemu-iotests/040.out b/tests/qemu-iotests/040.out
index 220a5fa82c..6a917130b6 100644
--- a/tests/qemu-iotests/040.out
+++ b/tests/qemu-iotests/040.out
@@ -1,5 +1,5 @@
-...............................................
+...........................................................
 ----------------------------------------------------------------------
-Ran 47 tests
+Ran 59 tests
=20
 OK
--=20
2.20.1


