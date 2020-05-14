Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B7EFC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 02:27:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3875205CB
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 02:27:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PPAZCHOd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3875205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58620 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZ3bG-0003C1-5R
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 22:27:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42150)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jZ3ZG-0008Fb-4w
 for qemu-devel@nongnu.org; Wed, 13 May 2020 22:25:50 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36026
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jZ3ZD-00030e-Kb
 for qemu-devel@nongnu.org; Wed, 13 May 2020 22:25:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589423146;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fNIOPZCAQymSh1653exouKLx0WJK8WQ9XabE6c3zeaM=;
 b=PPAZCHOdAy4KIvP78TJe1PzsQAwZxWxcQY6ueP8lA0ziBY66UJcMUWpvYLk014d3JuY86w
 oXpDcE1kuC/qDpEKOz496rt27MdIGLQn+MWDAN/aYa/exxVF1Y6rqxV9Mq1KgCar+qIRxW
 Tgkok74dRB8YJl89vGE3hl9ovlCpHCs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-167-XsXixpEmP6yXVWStjvkpPQ-1; Wed, 13 May 2020 22:25:44 -0400
X-MC-Unique: XsXixpEmP6yXVWStjvkpPQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C1EAB1009600;
 Thu, 14 May 2020 02:25:43 +0000 (UTC)
Received: from probe.redhat.com (ovpn-113-9.rdu2.redhat.com [10.10.113.9])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1EBAA783B3;
 Thu, 14 May 2020 02:25:39 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 2/3] iotests: add JobRunner class
Date: Wed, 13 May 2020 22:25:35 -0400
Message-Id: <20200514022536.2568-3-jsnow@redhat.com>
In-Reply-To: <20200514022536.2568-1-jsnow@redhat.com>
References: <20200514022536.2568-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=jsnow@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 22:25:46
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The idea is that instead of increasing the arguments to job_run all the
time, create a more general-purpose job runner that can be subclassed to
do interesting things with.

pylint note: the 'callbacks' option guards against unused warning
arguments in functions designated as callbacks. It does not currently
guard against "no-self-use" though; hence a once-off ignore.

mypy note: QapiEvent is only a weak alias; it's fully interchangable
with the type it's declared as. In the future, we may wish to tighten
these types. For now, this communicates the rough shape of the type and
(more importantly) the intent.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 tests/qemu-iotests/055        |  17 +--
 tests/qemu-iotests/155        |  11 +-
 tests/qemu-iotests/255        |   9 +-
 tests/qemu-iotests/257        |  54 +++++----
 tests/qemu-iotests/iotests.py | 206 +++++++++++++++++++++++++---------
 tests/qemu-iotests/pylintrc   |  11 ++
 6 files changed, 225 insertions(+), 83 deletions(-)

diff --git a/tests/qemu-iotests/055 b/tests/qemu-iotests/055
index 4d3744b0d3..7e13585a94 100755
--- a/tests/qemu-iotests/055
+++ b/tests/qemu-iotests/055
@@ -115,19 +115,22 @@ class TestSingleDrive(iotests.QMPTestCase):
         self.do_test_pause('blockdev-backup', 'drive1', blockdev_target_img)
 
     def do_test_resize_blockdev_backup(self, device, node):
-        def pre_finalize():
-            result = self.vm.qmp('block_resize', device=device, size=65536)
-            self.assert_qmp(result, 'error/class', 'GenericError')
-
-            result = self.vm.qmp('block_resize', node_name=node, size=65536)
-            self.assert_qmp(result, 'error/class', 'GenericError')
+        class JobRunner(iotests.TestJobRunner):
+            def on_pending(self, event):
+                qmp = self._vm.qmp
+                result = qmp('block_resize', device=device, size=65536)
+                self.test.assert_qmp(result, 'error/class', 'GenericError')
+                result = qmp('block_resize', node_name=node, size=65536)
+                self.test.assert_qmp(result, 'error/class', 'GenericError')
+                super().on_pending(event)
 
         result = self.vm.qmp('blockdev-backup', job_id='job0', device='drive0',
                              target='drive1', sync='full', auto_finalize=False,
                              auto_dismiss=False)
         self.assert_qmp(result, 'return', {})
 
-        self.vm.run_job('job0', auto_finalize=False, pre_finalize=pre_finalize)
+        runner = JobRunner(self.vm, 'job0', test=self, auto_finalize=False)
+        runner.run()
 
     def test_source_resize_blockdev_backup(self):
         self.do_test_resize_blockdev_backup('drive0', 'source')
diff --git a/tests/qemu-iotests/155 b/tests/qemu-iotests/155
index cb371d4649..1aa6cfefb8 100755
--- a/tests/qemu-iotests/155
+++ b/tests/qemu-iotests/155
@@ -163,6 +163,12 @@ class BaseClass(iotests.QMPTestCase):
             self.assert_qmp_absent(node, 'image/backing-image')
 
 
+class MirrorJob(iotests.TestJobRunner):
+    def on_pending(self, event):
+        self.test.openBacking()
+        super().on_pending(event)
+
+
 # Class variables for controlling its behavior:
 #
 # cmd: Mirroring command to execute, either drive-mirror or blockdev-mirror
@@ -188,8 +194,9 @@ class MirrorBaseClass(BaseClass):
 
         self.assert_qmp(result, 'return', {})
 
-        self.vm.run_job('mirror-job', auto_finalize=False,
-                        pre_finalize=self.openBacking, auto_dismiss=True)
+        job = MirrorJob(self.vm, 'mirror-job', test=self,
+                        auto_finalize=False, auto_dismiss=True)
+        job.run()
 
     def testFull(self):
         self.runMirror('full')
diff --git a/tests/qemu-iotests/255 b/tests/qemu-iotests/255
index 8f08f741da..74487548fa 100755
--- a/tests/qemu-iotests/255
+++ b/tests/qemu-iotests/255
@@ -71,8 +71,13 @@ with iotests.FilePath('t.qcow2') as disk_path, \
     result = vm.qmp_log('block-commit', job_id='job0', auto_finalize=False,
                         device='overlay', top_node='mid')
 
-    vm.run_job('job0', auto_finalize=False, pre_finalize=start_requests,
-                auto_dismiss=True)
+    class JobRunner(iotests.JobRunner):
+        def on_pending(self, event):
+            start_requests()
+            super().on_pending(event)
+
+    runner = JobRunner(vm, 'job0', auto_finalize=False, auto_dismiss=True)
+    runner.run()
 
     vm.shutdown()
 
diff --git a/tests/qemu-iotests/257 b/tests/qemu-iotests/257
index 004a433b8b..2933e2670b 100755
--- a/tests/qemu-iotests/257
+++ b/tests/qemu-iotests/257
@@ -352,30 +352,40 @@ def test_bitmap_sync(bsync_mode, msync_mode='bitmap', failure=None):
         job = backup(drive0, 1, bsync1, msync_mode,
                      bitmap="bitmap0", bitmap_mode=bsync_mode)
 
-        def _callback():
-            """Issue writes while the job is open to test bitmap divergence."""
-            # Note: when `failure` is 'intermediate', this isn't called.
-            log('')
-            bitmaps = perform_writes(drive0, 2, filter_node_name='backup-top')
-            # Named bitmap (static, should be unchanged)
-            ebitmap.compare(vm.get_bitmap(drive0.node, 'bitmap0',
-                                          bitmaps=bitmaps))
-            # Anonymous bitmap (dynamic, shows new writes)
-            anonymous = EmulatedBitmap()
-            anonymous.dirty_group(2)
-            anonymous.compare(vm.get_bitmap(drive0.node, '', recording=True,
-                                            bitmaps=bitmaps))
 
-            # Simulate the order in which this will happen:
-            # group 1 gets cleared first, then group two gets written.
-            if ((bsync_mode == 'on-success' and not failure) or
-                (bsync_mode == 'always')):
-                ebitmap.clear()
-            ebitmap.dirty_group(2)
+        class JobRunner(iotests.JobRunner):
+            def on_pending(self, event):
+                """
+                Issue writes while the job is open to test bitmap divergence.
+                """
+
+                # Note: when `failure` is 'intermediate', this isn't called.
+                log('')
+                bitmaps = perform_writes(drive0, 2,
+                                         filter_node_name='backup-top')
+                # Named bitmap (static, should be unchanged)
+                ebitmap.compare(vm.get_bitmap(drive0.node, 'bitmap0',
+                                              bitmaps=bitmaps))
+                # Anonymous bitmap (dynamic, shows new writes)
+                anonymous = EmulatedBitmap()
+                anonymous.dirty_group(2)
+                anonymous.compare(vm.get_bitmap(drive0.node, '', recording=True,
+                                                bitmaps=bitmaps))
+
+                # Simulate the order in which this will happen:
+                # group 1 gets cleared first, then group two gets written.
+                if ((bsync_mode == 'on-success' and not failure) or
+                    (bsync_mode == 'always')):
+                    ebitmap.clear()
+                ebitmap.dirty_group(2)
+
+                super().on_pending(event)
+
+
+        runner = JobRunner(vm, job, cancel=(failure == 'simulated'),
+                           auto_finalize=False, auto_dismiss=True)
+        runner.run()
 
-        vm.run_job(job, auto_dismiss=True, auto_finalize=False,
-                   pre_finalize=_callback,
-                   cancel=(failure == 'simulated'))
         bitmaps = vm.query_bitmaps()
         log({'bitmaps': bitmaps}, indent=2)
         log('')
diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index aada94f4f9..6b9b35acb7 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -40,6 +40,7 @@
 
 # Type Aliases
 QMPResponse = Dict[str, Any]
+QapiEvent = Dict[str, Any]
 
 
 # Use this logger for logging messages directly from the iotests module
@@ -489,6 +490,141 @@ def remote_filename(path):
     else:
         raise Exception("Protocol %s not supported" % (imgproto))
 
+
+class JobRunner:
+    """
+    JobRunner offers a job-lifetime management framework.
+
+    It can be used as-is for a no-frills run-to-completion module,
+    or subclassed to gain access to per-event callbacks for
+    customizable behavior.
+
+    :param vm: The VM the job is running on
+    :param job: Job ID of a recently created job
+    :param cancel: When true, cancels the job prior to finalization.
+    :param auto_finalize: True if the job was configured to finalize itself.
+    :param auto_dismiss: True if the job will dismiss itself post-finalization.
+    """
+    def __init__(self,
+                 vm: 'VM',
+                 job: str,
+                 cancel: bool = False,
+                 auto_finalize: bool = True,
+                 auto_dismiss: bool = False):
+        self._vm = vm
+        self._id = job
+        self.cancel = cancel
+
+        self._auto_finalize = auto_finalize
+        self._auto_dismiss = auto_dismiss
+        self._exited = False
+        self._error: Optional[str] = None
+
+        match_device = {'data': {'device': self._id}}
+        match_id = {'data': {'id': self._id}}
+
+        # Listen for these events with these parameters:
+        self._events = {
+            'BLOCK_JOB_COMPLETED': match_device,
+            'BLOCK_JOB_CANCELLED': match_device,
+            'BLOCK_JOB_ERROR': match_device,
+            'BLOCK_JOB_READY': match_device,
+            'BLOCK_JOB_PENDING': match_id,
+            'JOB_STATUS_CHANGE': match_id
+        }
+
+        self._dispatch = {
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
+    # These are Job state change callbacks.
+    # Subclass and override these for custom workflows.
+
+    def on_create(self, event: QapiEvent) -> None:
+        pass
+
+    def on_run(self, event: QapiEvent) -> None:
+        pass
+
+    def on_pause(self, event: QapiEvent) -> None:
+        pass
+
+    def on_ready(self, event: QapiEvent) -> None:
+        self._vm.qmp_log('job-complete', id=self._id)
+
+    def on_standby(self, event: QapiEvent) -> None:
+        pass
+
+    def on_waiting(self, event: QapiEvent) -> None:
+        pass
+
+    def on_pending(self, event: QapiEvent) -> None:
+        if self._auto_finalize:
+            return
+
+        if self.cancel:
+            self._vm.qmp_log('job-cancel', id=self._id)
+        else:
+            self._vm.qmp_log('job-finalize', id=self._id)
+
+    def on_abort(self, event: QapiEvent) -> None:
+        result = self._vm.qmp('query-jobs')
+        for j in result['return']:
+            if j['id'] == self._id:
+                self._error = j['error']
+                log('Job failed: %s' % (j['error']))
+
+    def on_conclude(self, event: QapiEvent) -> None:
+        if self._auto_dismiss:
+            return
+
+        self._vm.qmp_log('job-dismiss', id=self._id)
+
+    def on_null(self, event: QapiEvent) -> None:
+        self._exited = True
+
+    # Macro events -- QAPI events.
+    # These are callbacks for individual top-level events.
+
+    def on_change(self, event: QapiEvent) -> None:
+        status = event['data']['status']
+        assert status in self._dispatch
+        self._dispatch[status](event)
+
+    def on_block_job_event(self, event: QapiEvent) -> None:
+        # pylint: disable=no-self-use
+        log(event)
+
+    def event(self, event: QapiEvent) -> None:
+        assert event['event'] in self._events.keys()
+        if event['event'] == 'JOB_STATUS_CHANGE':
+            self.on_change(event)
+        else:
+            self.on_block_job_event(event)
+
+    def run(self, wait: float = 60.0) -> Optional[str]:
+        """
+        Run the event loop for this job.
+
+        :param wait: Timeout in seconds specifying how long to wait
+                     for an event. Defaults to 60.0.
+        :return: Error string on failure, Nothing on success.
+        """
+        while not self._exited:
+            raw_event = self._vm.events_wait(self._events, timeout=wait)
+            self.event(filter_qmp_event(raw_event))
+        return self._error
+
+
 class VM(qtest.QEMUQtestMachine):
     '''A QEMU VM'''
 
@@ -615,60 +751,21 @@ def qmp_log(self, cmd, filters=(), indent=None, **kwargs):
         log(result, filters, indent=indent)
         return result
 
-    # Returns None on success, and an error string on failure
-    def run_job(self, job, auto_finalize=True, auto_dismiss=False,
-                pre_finalize=None, cancel=False, wait=60.0):
+    def run_job(self, job, **kwargs) -> Optional[str]:
         """
         run_job moves a job from creation through to dismissal.
 
-        :param job: String. ID of recently-launched job
-        :param auto_finalize: Bool. True if the job was launched with
-                              auto_finalize. Defaults to True.
-        :param auto_dismiss: Bool. True if the job was launched with
-                             auto_dismiss=True. Defaults to False.
-        :param pre_finalize: Callback. A callable that takes no arguments to be
-                             invoked prior to issuing job-finalize, if any.
-        :param cancel: Bool. When true, cancels the job after the pre_finalize
-                       callback.
-        :param wait: Float. Timeout value specifying how long to wait for any
-                     event, in seconds. Defaults to 60.0.
+        :param job: Job ID of a recently created job.
+        :param kwargs: See JobRunner.__init__() and JobRunner.run().
+
+        :return: Error string on failure, Nothing on success.
         """
-        match_device = {'data': {'device': job}}
-        match_id = {'data': {'id': job}}
-        events = {
-            'BLOCK_JOB_COMPLETED': match_device,
-            'BLOCK_JOB_CANCELLED': match_device,
-            'BLOCK_JOB_ERROR': match_device,
-            'BLOCK_JOB_READY': match_device,
-            'BLOCK_JOB_PENDING': match_id,
-            'JOB_STATUS_CHANGE': match_id,
-        }
-        error = None
-        while True:
-            ev = filter_qmp_event(self.events_wait(events, timeout=wait))
-            if ev['event'] != 'JOB_STATUS_CHANGE':
-                log(ev)
-                continue
-            status = ev['data']['status']
-            if status == 'aborting':
-                result = self.qmp('query-jobs')
-                for j in result['return']:
-                    if j['id'] == job:
-                        error = j['error']
-                        log('Job failed: %s' % (j['error']))
-            elif status == 'ready':
-                self.qmp_log('job-complete', id=job)
-            elif status == 'pending' and not auto_finalize:
-                if pre_finalize:
-                    pre_finalize()
-                if cancel:
-                    self.qmp_log('job-cancel', id=job)
-                else:
-                    self.qmp_log('job-finalize', id=job)
-            elif status == 'concluded' and not auto_dismiss:
-                self.qmp_log('job-dismiss', id=job)
-            elif status == 'null':
-                return error
+        if 'wait' in kwargs:
+            run_kwargs = {'wait': kwargs.pop('wait')}
+        else:
+            run_kwargs = {}
+        job_runner = JobRunner(self, job, **kwargs)
+        return job_runner.run(**run_kwargs)
 
     # Returns None on success, and an error string on failure
     def blockdev_create(self, options, job_id='job0', filters=None):
@@ -980,6 +1077,15 @@ def case_skip(self, reason):
         self.skipTest(reason)
 
 
+class TestJobRunner(JobRunner):
+    """
+    JobRunner intended for use within a QMPTestCase.
+    """
+    def __init__(self, *args, test: QMPTestCase, **kwargs):
+        super().__init__(*args, **kwargs)
+        self.test = test
+
+
 def notrun(reason):
     '''Skip this test suite'''
     # Each test in qemu-iotests has a number ("seq")
diff --git a/tests/qemu-iotests/pylintrc b/tests/qemu-iotests/pylintrc
index 5481afe528..df602e02b1 100644
--- a/tests/qemu-iotests/pylintrc
+++ b/tests/qemu-iotests/pylintrc
@@ -17,9 +17,20 @@ disable=invalid-name,
         too-many-lines,
         too-many-locals,
         too-many-public-methods,
+        too-many-instance-attributes,
         # These are temporary, and should be removed:
         missing-docstring,
 
+
+[VARIABLES]
+
+# List of strings which can identify a callback function by name. A callback
+# name must start or end with one of those strings.
+callbacks=cb_,
+          _cb,
+          on_,
+
+
 [FORMAT]
 
 # Maximum number of characters on a single line.
-- 
2.21.1


