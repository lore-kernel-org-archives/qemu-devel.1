Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 264EDC35242
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 20:11:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C88FD222C4
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 20:11:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JYuJjXzF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C88FD222C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45154 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2hIq-0004CO-W8
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 15:11:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52067)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1j2hGi-0008Gd-M6
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 15:08:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1j2hGg-0005xQ-PB
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 15:08:56 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49444
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1j2hGg-0005wd-Ko
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 15:08:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581710934;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+WKpefP9BgROxoZoqUBH6uGP1/rI1g20cTiL0991K+g=;
 b=JYuJjXzFe0P8/VABVmT/wytEk5a0G0T5vloEm+QwaCjw/VvUMTwT1i9F6cjNfiLOJkp265
 63hOe1QhLGUBMH2B73/TmkmYcfV7gZCGHhK9kfJXcFiSvGQp32UvJTBQNgLpRBDzRm7rD+
 X9UzPMn+pv/bQaKogwY3a9jhDOMYOzQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-328-Vj0VISqNPbCbXpGYBG-Aww-1; Fri, 14 Feb 2020 15:08:41 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 183EF13E2;
 Fri, 14 Feb 2020 20:08:40 +0000 (UTC)
Received: from linux.fritz.box.com (unknown [10.36.118.128])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 927C05C1C3;
 Fri, 14 Feb 2020 20:08:38 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 7/7] iotests: Test error handling policies with block-commit
Date: Fri, 14 Feb 2020 21:08:12 +0100
Message-Id: <20200214200812.28180-8-kwolf@redhat.com>
In-Reply-To: <20200214200812.28180-1-kwolf@redhat.com>
References: <20200214200812.28180-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: Vj0VISqNPbCbXpGYBG-Aww-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: kwolf@redhat.com, pkrempa@redhat.com, qemu-devel@nongnu.org,
 mreitz@redhat.com, nsoffer@redhat.com, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This tests both read failure (from the top node) and write failure (to
the base node) for on-error=3Dreport/stop/ignore.

As block-commit actually starts two different types of block jobs
(mirror.c for committing the active later, commit.c for intermediate
layers), all tests are run for both cases.

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


