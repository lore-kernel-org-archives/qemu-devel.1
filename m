Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E46EC4BA06
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 00:46:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35D3B20658
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 00:46:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fuyQHhD0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35D3B20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36526 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6kpu-0006fw-6a
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 19:46:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46606)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsnow@redhat.com>) id 1j6koS-0004zE-Ia
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 19:44:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1j6koQ-0003aL-NK
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 19:44:32 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53498
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1j6koQ-0003ZS-Eo
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 19:44:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582677870;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IUFlbAeNNCdo97bP+hIQ1Xb7c3PXEcLn7/CnGvCsdqI=;
 b=fuyQHhD0tJ0VfiUu9E2A388Z9+LjRmRVH5IzrAlZ+XrCM9qv9O/N34d0qh6xm1pMxOh3FA
 PaXrP/nf2KY9p3M7HjkG6oPXteaM6gA5dQYnZiC2RSJiUTFtDT0oXaEomLjfMV2oh4oXS1
 /RTyCgsoP1mKNqwfrB5Ktib5mQiF/Lc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-358-EKDFS2o0MsOVjTuqgSLqig-1; Tue, 25 Feb 2020 19:44:28 -0500
X-MC-Unique: EKDFS2o0MsOVjTuqgSLqig-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5445318FF661;
 Wed, 26 Feb 2020 00:44:27 +0000 (UTC)
Received: from probe.bos.redhat.com (dhcp-17-182.bos.redhat.com [10.18.17.182])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AB3628AC42;
 Wed, 26 Feb 2020 00:44:26 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/2] iotests: add JobRunner class
Date: Tue, 25 Feb 2020 19:44:24 -0500
Message-Id: <20200226004425.1303-2-jsnow@redhat.com>
In-Reply-To: <20200226004425.1303-1-jsnow@redhat.com>
References: <20200226004425.1303-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
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
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The idea is that instead of increasing the arguments to job_run all the
time, create a more general-purpose job runner that can be subclassed to
do interesting things with.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 tests/qemu-iotests/255        |   9 +-
 tests/qemu-iotests/257        |  12 ++-
 tests/qemu-iotests/287        |  19 +++-
 tests/qemu-iotests/iotests.py | 176 ++++++++++++++++++++++++----------
 4 files changed, 158 insertions(+), 58 deletions(-)

diff --git a/tests/qemu-iotests/255 b/tests/qemu-iotests/255
index 4a4818bafb..513e9ebb58 100755
--- a/tests/qemu-iotests/255
+++ b/tests/qemu-iotests/255
@@ -71,8 +71,13 @@ with iotests.FilePath('t.qcow2') as disk_path, \
     result =3D vm.qmp_log('block-commit', job_id=3D'job0', auto_finalize=
=3DFalse,
                         device=3D'overlay', top_node=3D'mid')
=20
-    vm.run_job('job0', auto_finalize=3DFalse, pre_finalize=3Dstart_request=
s,
-                auto_dismiss=3DTrue)
+    class TestJobRunner(iotests.JobRunner):
+        def on_pending(self, event):
+            start_requests()
+            super().on_pending(event)
+
+    runner =3D TestJobRunner(vm, 'job0', auto_finalize=3DFalse, auto_dismi=
ss=3DTrue)
+    runner.run()
=20
     vm.shutdown()
=20
diff --git a/tests/qemu-iotests/257 b/tests/qemu-iotests/257
index 2a81f9e30c..e73b0c20b3 100755
--- a/tests/qemu-iotests/257
+++ b/tests/qemu-iotests/257
@@ -265,9 +265,15 @@ def test_bitmap_sync(bsync_mode, msync_mode=3D'bitmap'=
, failure=3DNone):
                 ebitmap.clear()
             ebitmap.dirty_group(2)
=20
-        vm.run_job(job, auto_dismiss=3DTrue, auto_finalize=3DFalse,
-                   pre_finalize=3D_callback,
-                   cancel=3D(failure =3D=3D 'simulated'))
+        class TestJobRunner(iotests.JobRunner):
+            def on_pending(self, event):
+                _callback()
+                super().on_pending(event)
+
+        runner =3D TestJobRunner(vm, job, cancel=3D(failure =3D=3D 'simula=
ted'),
+                               auto_finalize=3DFalse, auto_dismiss=3DTrue)
+        runner.run()
+
         bitmaps =3D vm.query_bitmaps()
         log({'bitmaps': bitmaps}, indent=3D2)
         log('')
diff --git a/tests/qemu-iotests/287 b/tests/qemu-iotests/287
index 0ab58dc011..f06e6ff084 100755
--- a/tests/qemu-iotests/287
+++ b/tests/qemu-iotests/287
@@ -165,13 +165,22 @@ def test_bitmap_populate(config):
                 if not config.disabled:
                     ebitmap.dirty_group(2)
=20
+
+        class TestJobRunner(iotests.JobRunner):
+            def on_pending(self, event):
+                if config.mid_writes:
+                    perform_writes(drive0, 2)
+                    if not config.disabled:
+                        ebitmap.dirty_group(2)
+                super().on_pending(event)
+
         job =3D populate(drive0, 'target', 'bitpop0')
         assert job['return'] =3D=3D {'return': {}}
-        vm.run_job(job['id'],
-                   auto_dismiss=3Djob['auto-dismiss'],
-                   auto_finalize=3Djob['auto-finalize'],
-                   pre_finalize=3Dpre_finalize,
-                   cancel=3Dconfig.cancel)
+        job_runner =3D TestJobRunner(vm, job['id'],
+                                   auto_dismiss=3Djob['auto-dismiss'],
+                                   auto_finalize=3Djob['auto-finalize'],
+                                   cancel=3Dconfig.cancel)
+        job_runner.run()
         log('')
=20
=20
diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index 3390fab021..37a8b4d649 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -460,6 +460,130 @@ def remote_filename(path):
     else:
         raise Exception("Protocol %s not supported" % (imgproto))
=20
+
+class JobRunner:
+    def __init__(self, vm, job,
+                 use_log=3DTrue,
+                 cancel=3DFalse,
+                 auto_finalize=3DTrue,
+                 auto_dismiss=3DFalse):
+        self._vm =3D vm
+        self._id =3D job
+        self.logging =3D use_log
+        self.cancel =3D cancel
+
+        self._auto_finalize =3D auto_finalize
+        self._auto_dismiss =3D auto_dismiss
+        self._exited =3D False
+        self._error =3D None
+
+        match_device =3D {'data': {'device': job}}
+        match_id =3D {'data': {'id': job}}
+        self._events =3D {
+            'BLOCK_JOB_COMPLETED': match_device,
+            'BLOCK_JOB_CANCELLED': match_device,
+            'BLOCK_JOB_ERROR': match_device,
+            'BLOCK_JOB_READY': match_device,
+            'BLOCK_JOB_PENDING': match_id,
+            'JOB_STATUS_CHANGE': match_id
+        }
+
+        self._dispatch =3D {
+            'created': self.on_create,
+            'running': self.on_run,
+            'paused': self.on_pause,
+            'ready': self.on_ready,
+            'standby': self.on_standby,
+            'waiting': self.on_waiting,
+            'pending': self.on_pending,
+            'aborting': self.on_abort,
+            'concluded': self.on_conclude,
+            'null': self.on_null,
+        }
+
+    # Job events -- state changes.
+
+    def on_create(self, event):
+        pass
+
+    def on_run(self, event):
+        pass
+
+    def on_pause(self, event):
+        pass
+
+    def on_ready(self, event):
+        if self.logging:
+            self._vm.qmp_log('job-complete', id=3Dself._id)
+        else:
+            self._vm.qmp('job-complete', id=3Dself._id)
+
+    def on_standby(self, event):
+        pass
+
+    def on_waiting(self, event):
+        pass
+
+    def on_pending(self, event):
+        if self._auto_finalize:
+            return
+
+        if self.cancel:
+            if self.logging:
+                self._vm.qmp_log('job-cancel', id=3Dself._id)
+            else:
+                self._vm.qmp('job-cancel', id=3Dself._id)
+        else:
+            if self.logging:
+                self._vm.qmp_log('job-finalize', id=3Dself._id)
+            else:
+                self._vm.qmp('job-finalize', id=3Dself._id)
+
+    def on_abort(self, event):
+        result =3D self._vm.qmp('query-jobs')
+        for j in result['return']:
+            if j['id'] =3D=3D self._id:
+                self.error =3D j['error']
+                if self.logging:
+                    log('Job failed: %s' % (j['error']))
+
+    def on_conclude(self, event):
+        if self._auto_dismiss:
+            return
+
+        if self.logging:
+            self._vm.qmp_log('job-dismiss', id=3Dself._id)
+        else:
+            self._vm.qmp('job-dismiss', id=3Dself._id)
+
+    def on_null(self, event):
+        self._exited =3D True
+
+    # Macro events -- QAPI events
+
+    def on_change(self, event):
+        status =3D event['data']['status']
+        assert status in self._dispatch
+        self._dispatch[status](event)
+
+    def on_block_job_event(self, event):
+        if self.logging:
+            log(event)
+
+    def _event(self, event):
+        assert event['event'] in self._events.keys()
+        if event['event'] =3D=3D 'JOB_STATUS_CHANGE':
+            self.on_change(event)
+        else:
+            self.on_block_job_event(event)
+
+    def run(self, wait=3D60.0):
+        while not self._exited:
+            raw_event =3D self._vm.events_wait(self._events, timeout=3Dwai=
t)
+            self._event(filter_qmp_event(raw_event))
+        return self._error
+
+
 class VM(qtest.QEMUQtestMachine):
     '''A QEMU VM'''
=20
@@ -585,7 +709,7 @@ def qmp_log(self, cmd, filters=3D[], indent=3DNone, **k=
wargs):
=20
     # Returns None on success, and an error string on failure
     def run_job(self, job, auto_finalize=3DTrue, auto_dismiss=3DFalse,
-                pre_finalize=3DNone, cancel=3DFalse, use_log=3DTrue, wait=
=3D60.0):
+                cancel=3DFalse, use_log=3DTrue, wait=3D60.0):
         """
         run_job moves a job from creation through to dismissal.
=20
@@ -594,59 +718,15 @@ def run_job(self, job, auto_finalize=3DTrue, auto_dis=
miss=3DFalse,
                               auto_finalize. Defaults to True.
         :param auto_dismiss: Bool. True if the job was launched with
                              auto_dismiss=3DTrue. Defaults to False.
-        :param pre_finalize: Callback. A callable that takes no arguments =
to be
-                             invoked prior to issuing job-finalize, if any=
.
         :param cancel: Bool. When true, cancels the job after the pre_fina=
lize
                        callback.
         :param use_log: Bool. When false, does not log QMP messages.
         :param wait: Float. Timeout value specifying how long to wait for =
any
                      event, in seconds. Defaults to 60.0.
         """
-        match_device =3D {'data': {'device': job}}
-        match_id =3D {'data': {'id': job}}
-        events =3D {
-            'BLOCK_JOB_COMPLETED': match_device,
-            'BLOCK_JOB_CANCELLED': match_device,
-            'BLOCK_JOB_ERROR': match_device,
-            'BLOCK_JOB_READY': match_device,
-            'BLOCK_JOB_PENDING': match_id,
-            'JOB_STATUS_CHANGE': match_id,
-        }
-        error =3D None
-        while True:
-            ev =3D filter_qmp_event(self.events_wait(events, timeout=3Dwai=
t))
-            if ev['event'] !=3D 'JOB_STATUS_CHANGE':
-                if use_log:
-                    log(ev)
-                continue
-            status =3D ev['data']['status']
-            if status =3D=3D 'aborting':
-                result =3D self.qmp('query-jobs')
-                for j in result['return']:
-                    if j['id'] =3D=3D job:
-                        error =3D j['error']
-                        if use_log:
-                            log('Job failed: %s' % (j['error']))
-            elif status =3D=3D 'ready':
-                self.qmp_log('job-complete', id=3Djob)
-            elif status =3D=3D 'pending' and not auto_finalize:
-                if pre_finalize:
-                    pre_finalize()
-                if cancel and use_log:
-                    self.qmp_log('job-cancel', id=3Djob)
-                elif cancel:
-                    self.qmp('job-cancel', id=3Djob)
-                elif use_log:
-                    self.qmp_log('job-finalize', id=3Djob)
-                else:
-                    self.qmp('job-finalize', id=3Djob)
-            elif status =3D=3D 'concluded' and not auto_dismiss:
-                if use_log:
-                    self.qmp_log('job-dismiss', id=3Djob)
-                else:
-                    self.qmp('job-dismiss', id=3Djob)
-            elif status =3D=3D 'null':
-                return error
+        job_runner =3D JobRunner(self, job, use_log, cancel,
+                               auto_finalize, auto_dismiss)
+        return job_runner.run(wait=3Dwait)
=20
     # Returns None on success, and an error string on failure
     def blockdev_create(self, options, job_id=3D'job0', filters=3DNone):
--=20
2.21.1


