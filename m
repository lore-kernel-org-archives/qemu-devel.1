Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C15DBC3F2CE
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 00:12:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DB4E20842
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 00:12:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UjnVM3Y7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DB4E20842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41558 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9e87-0006l7-Lv
	for qemu-devel@archiver.kernel.org; Wed, 04 Mar 2020 19:12:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57379)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsnow@redhat.com>) id 1j9e6z-0005Ha-4G
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 19:11:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1j9e6x-0003o8-7R
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 19:11:37 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:20473)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1j9e6x-0003nq-2f
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 19:11:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583367094;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ry+y39RsNGSPdEDxQssgl4xtmO++rRwj6UpHS0nKtW8=;
 b=UjnVM3Y7xwZsSpx6vNf9eYrtDwvNlKiGf659ZTwcc0Rb17b2lBr0A7PDXB7aC1lGJxLsW1
 nQ2iIObCfLUv0H+7GXldxQ6kXqoQ3C2IC/55MzWdFTY434xzHMgj/LVG5+nso/7rNpbulD
 bFARj6wSv97GZ4dz8ECEuZXCxrxl02w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-3-86TCWPoYPOuTns5qxaIqvg-1; Wed, 04 Mar 2020 19:11:32 -0500
X-MC-Unique: 86TCWPoYPOuTns5qxaIqvg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DC11C107ACC7;
 Thu,  5 Mar 2020 00:11:30 +0000 (UTC)
Received: from probe.redhat.com (ovpn-120-212.rdu2.redhat.com [10.10.120.212])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1F30B5C1D4;
 Thu,  5 Mar 2020 00:11:29 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 2/3] iotests: add JobRunner class
Date: Wed,  4 Mar 2020 19:11:24 -0500
Message-Id: <20200305001125.27549-3-jsnow@redhat.com>
In-Reply-To: <20200305001125.27549-1-jsnow@redhat.com>
References: <20200305001125.27549-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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
 tests/qemu-iotests/255        |   9 +-
 tests/qemu-iotests/257        |  54 +++++----
 tests/qemu-iotests/iotests.py | 201 +++++++++++++++++++++++++---------
 tests/qemu-iotests/pylintrc   |  11 ++
 4 files changed, 200 insertions(+), 75 deletions(-)

diff --git a/tests/qemu-iotests/255 b/tests/qemu-iotests/255
index 8f08f741da..e66cdfd672 100755
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
index 004a433b8b..95341c330f 100755
--- a/tests/qemu-iotests/257
+++ b/tests/qemu-iotests/257
@@ -352,30 +352,40 @@ def test_bitmap_sync(bsync_mode, msync_mode=3D'bitmap=
', failure=3DNone):
         job =3D backup(drive0, 1, bsync1, msync_mode,
                      bitmap=3D"bitmap0", bitmap_mode=3Dbsync_mode)
=20
-        def _callback():
-            """Issue writes while the job is open to test bitmap divergenc=
e."""
-            # Note: when `failure` is 'intermediate', this isn't called.
-            log('')
-            bitmaps =3D perform_writes(drive0, 2, filter_node_name=3D'back=
up-top')
-            # Named bitmap (static, should be unchanged)
-            ebitmap.compare(vm.get_bitmap(drive0.node, 'bitmap0',
-                                          bitmaps=3Dbitmaps))
-            # Anonymous bitmap (dynamic, shows new writes)
-            anonymous =3D EmulatedBitmap()
-            anonymous.dirty_group(2)
-            anonymous.compare(vm.get_bitmap(drive0.node, '', recording=3DT=
rue,
-                                            bitmaps=3Dbitmaps))
=20
-            # Simulate the order in which this will happen:
-            # group 1 gets cleared first, then group two gets written.
-            if ((bsync_mode =3D=3D 'on-success' and not failure) or
-                (bsync_mode =3D=3D 'always')):
-                ebitmap.clear()
-            ebitmap.dirty_group(2)
+        class TestJobRunner(iotests.JobRunner):
+            def on_pending(self, event):
+                """
+                Issue writes while the job is open to test bitmap divergen=
ce.
+                """
+
+                # Note: when `failure` is 'intermediate', this isn't calle=
d.
+                log('')
+                bitmaps =3D perform_writes(drive0, 2,
+                                         filter_node_name=3D'backup-top')
+                # Named bitmap (static, should be unchanged)
+                ebitmap.compare(vm.get_bitmap(drive0.node, 'bitmap0',
+                                              bitmaps=3Dbitmaps))
+                # Anonymous bitmap (dynamic, shows new writes)
+                anonymous =3D EmulatedBitmap()
+                anonymous.dirty_group(2)
+                anonymous.compare(vm.get_bitmap(drive0.node, '', recording=
=3DTrue,
+                                                bitmaps=3Dbitmaps))
+
+                # Simulate the order in which this will happen:
+                # group 1 gets cleared first, then group two gets written.
+                if ((bsync_mode =3D=3D 'on-success' and not failure) or
+                    (bsync_mode =3D=3D 'always')):
+                    ebitmap.clear()
+                ebitmap.dirty_group(2)
+
+                super().on_pending(event)
+
+
+        runner =3D TestJobRunner(vm, job, cancel=3D(failure =3D=3D 'simula=
ted'),
+                               auto_finalize=3DFalse, auto_dismiss=3DTrue)
+        runner.run()
=20
-        vm.run_job(job, auto_dismiss=3DTrue, auto_finalize=3DFalse,
-                   pre_finalize=3D_callback,
-                   cancel=3D(failure =3D=3D 'simulated'))
         bitmaps =3D vm.query_bitmaps()
         log({'bitmaps': bitmaps}, indent=3D2)
         log('')
diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index 2625001978..90d42cdff1 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -28,7 +28,7 @@
 import atexit
 import io
 from collections import OrderedDict
-from typing import Collection
+from typing import Any, Collection, Dict, Optional
=20
 # pylint: disable=3Dimport-error, wrong-import-position
 sys.path.append(os.path.join(os.path.dirname(__file__), '..', '..', 'pytho=
n'))
@@ -36,6 +36,9 @@
=20
 assert sys.version_info >=3D (3, 6)
=20
+# Type aliases
+QapiEvent =3D Dict[str, Any]
+
 # Use this logger for logging messages directly from the iotests module
 logger =3D logging.getLogger('qemu.iotests')
 logger.addHandler(logging.NullHandler())
@@ -473,6 +476,141 @@ def remote_filename(path):
     else:
         raise Exception("Protocol %s not supported" % (imgproto))
=20
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
+    :param auto_finalize: True if the job was configured to finalize itsel=
f.
+    :param auto_dismiss: True if the job will dismiss itself post-finaliza=
tion.
+    """
+    def __init__(self,
+                 vm: 'VM',
+                 job: str,
+                 cancel: bool =3D False,
+                 auto_finalize: bool =3D True,
+                 auto_dismiss: bool =3D False):
+        self._vm =3D vm
+        self._id =3D job
+        self.cancel =3D cancel
+
+        self._auto_finalize =3D auto_finalize
+        self._auto_dismiss =3D auto_dismiss
+        self._exited =3D False
+        self._error: Optional[str] =3D None
+
+        match_device =3D {'data': {'device': self._id}}
+        match_id =3D {'data': {'id': self._id}}
+
+        # Listen for these events with these parameters:
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
+        self._vm.qmp_log('job-complete', id=3Dself._id)
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
+            self._vm.qmp_log('job-cancel', id=3Dself._id)
+        else:
+            self._vm.qmp_log('job-finalize', id=3Dself._id)
+
+    def on_abort(self, event: QapiEvent) -> None:
+        result =3D self._vm.qmp('query-jobs')
+        for j in result['return']:
+            if j['id'] =3D=3D self._id:
+                self._error =3D j['error']
+                log('Job failed: %s' % (j['error']))
+
+    def on_conclude(self, event: QapiEvent) -> None:
+        if self._auto_dismiss:
+            return
+
+        self._vm.qmp_log('job-dismiss', id=3Dself._id)
+
+    def on_null(self, event: QapiEvent) -> None:
+        self._exited =3D True
+
+    # Macro events -- QAPI events.
+    # These are callbacks for individual top-level events.
+
+    def on_change(self, event: QapiEvent) -> None:
+        status =3D event['data']['status']
+        assert status in self._dispatch
+        self._dispatch[status](event)
+
+    def on_block_job_event(self, event: QapiEvent) -> None:
+        # pylint: disable=3Dno-self-use
+        log(event)
+
+    def event(self, event: QapiEvent) -> None:
+        assert event['event'] in self._events.keys()
+        if event['event'] =3D=3D 'JOB_STATUS_CHANGE':
+            self.on_change(event)
+        else:
+            self.on_block_job_event(event)
+
+    def run(self, wait: float =3D 60.0) -> Optional[str]:
+        """
+        Run the event loop for this job.
+
+        :param wait: Timeout in seconds specifying how long to wait
+                     for an event. Defaults to 60.0.
+        :return: Error string on failure, Nothing on success.
+        """
+        while not self._exited:
+            raw_event =3D self._vm.events_wait(self._events, timeout=3Dwai=
t)
+            self.event(filter_qmp_event(raw_event))
+        return self._error
+
+
 class VM(qtest.QEMUQtestMachine):
     '''A QEMU VM'''
=20
@@ -594,60 +732,21 @@ def qmp_log(self, cmd, filters=3D(), indent=3DNone, *=
*kwargs):
         log(result, filters, indent=3Dindent)
         return result
=20
-    # Returns None on success, and an error string on failure
-    def run_job(self, job, auto_finalize=3DTrue, auto_dismiss=3DFalse,
-                pre_finalize=3DNone, cancel=3DFalse, wait=3D60.0):
+    def run_job(self, job, **kwargs) -> Optional[str]:
         """
         run_job moves a job from creation through to dismissal.
=20
-        :param job: String. ID of recently-launched job
-        :param auto_finalize: Bool. True if the job was launched with
-                              auto_finalize. Defaults to True.
-        :param auto_dismiss: Bool. True if the job was launched with
-                             auto_dismiss=3DTrue. Defaults to False.
-        :param pre_finalize: Callback. A callable that takes no arguments =
to be
-                             invoked prior to issuing job-finalize, if any=
.
-        :param cancel: Bool. When true, cancels the job after the pre_fina=
lize
-                       callback.
-        :param wait: Float. Timeout value specifying how long to wait for =
any
-                     event, in seconds. Defaults to 60.0.
+        :param job: Job ID of a recently created job.
+        :param kwargs: See JobRunner.__init__() and JobRunner.run().
+
+        :return: Error string on failure, Nothing on success.
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
-                log(ev)
-                continue
-            status =3D ev['data']['status']
-            if status =3D=3D 'aborting':
-                result =3D self.qmp('query-jobs')
-                for j in result['return']:
-                    if j['id'] =3D=3D job:
-                        error =3D j['error']
-                        log('Job failed: %s' % (j['error']))
-            elif status =3D=3D 'ready':
-                self.qmp_log('job-complete', id=3Djob)
-            elif status =3D=3D 'pending' and not auto_finalize:
-                if pre_finalize:
-                    pre_finalize()
-                if cancel:
-                    self.qmp_log('job-cancel', id=3Djob)
-                else:
-                    self.qmp_log('job-finalize', id=3Djob)
-            elif status =3D=3D 'concluded' and not auto_dismiss:
-                self.qmp_log('job-dismiss', id=3Djob)
-            elif status =3D=3D 'null':
-                return error
+        if 'wait' in kwargs:
+            run_kwargs =3D {'wait': kwargs.pop('wait')}
+        else:
+            run_kwargs =3D {}
+        job_runner =3D JobRunner(self, job, **kwargs)
+        return job_runner.run(**run_kwargs)
=20
     # Returns None on success, and an error string on failure
     def blockdev_create(self, options, job_id=3D'job0', filters=3DNone):
diff --git a/tests/qemu-iotests/pylintrc b/tests/qemu-iotests/pylintrc
index 8d02f00607..6dae97d916 100644
--- a/tests/qemu-iotests/pylintrc
+++ b/tests/qemu-iotests/pylintrc
@@ -17,9 +17,20 @@ disable=3Dinvalid-name,
         too-many-locals,
         too-many-branches,
         too-many-public-methods,
+        too-many-instance-attributes,
         # These are temporary, and should be removed:
         missing-docstring,
=20
+
+[VARIABLES]
+
+# List of strings which can identify a callback function by name. A callba=
ck
+# name must start or end with one of those strings.
+callbacks=3Dcb_,
+          _cb,
+          on_,
+
+
 [FORMAT]
=20
 # Maximum number of characters on a single line.
--=20
2.21.1


