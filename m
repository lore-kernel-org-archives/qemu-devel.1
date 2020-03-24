Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C3C7C10DCE
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 23:24:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15A9920409
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 23:24:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nc/r5SDy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15A9920409
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56626 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGsuk-0004uQ-89
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 19:24:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51644)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsnow@redhat.com>) id 1jGssN-0008Ip-WF
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 19:22:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1jGssL-00025X-S4
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 19:22:27 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:43699)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1jGssL-00025H-Nz
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 19:22:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585092145;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=POU7ZRyYYyy36im/Vp3NjQotZdhBSmgiNcRcFp7PirI=;
 b=Nc/r5SDyjPWyYC1UpQyd2devk2UTs2olqwcyKc9ToP66zJu+NM+3LdWCl7n4dcfMKwEwSE
 KrbpRdFPykQvqi8hAvlLQzGAdcadNQRkatdu0MvIo1+FRfaDo5byg53BidVpoOLZhNlfRK
 W3/PlRVzxI+SaYmj+DdYAUEWLblZOXE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-118-nk-l4vtvOWagN-0MNrlwoQ-1; Tue, 24 Mar 2020 19:22:21 -0400
X-MC-Unique: nk-l4vtvOWagN-0MNrlwoQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7C86E19057D5;
 Tue, 24 Mar 2020 23:22:05 +0000 (UTC)
Received: from probe.redhat.com (ovpn-112-191.rdu2.redhat.com [10.10.112.191])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 39D685D9C5;
 Tue, 24 Mar 2020 23:22:04 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 14/14] iotests: use python logging for iotests.log()
Date: Tue, 24 Mar 2020 19:21:03 -0400
Message-Id: <20200324232103.4195-15-jsnow@redhat.com>
In-Reply-To: <20200324232103.4195-1-jsnow@redhat.com>
References: <20200324232103.4195-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Kevin Wolf <kwolf@redhat.com>, ehabkost@redhat.com, qemu-block@nongnu.org,
 philmd@redhat.com, armbru@redhat.com, Max Reitz <mreitz@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We can turn logging on/off globally instead of per-function.

Remove use_log from run_job, and use python logging to turn on
diffable output when we run through a script entry point.

iotest 245 changes output order due to buffering reasons.


An extended note on python logging:

A NullHandler is added to `qemu.iotests` to stop output from being
generated if this code is used as a library without configuring logging.
A NullHandler is only needed at the root, so a duplicate handler is not
needed for `qemu.iotests.diff_io`.

When logging is not configured, messages at the 'WARNING' levels or
above are printed with default settings. The NullHandler stops this from
occurring, which is considered good hygiene for code used as a library.

See https://docs.python.org/3/howto/logging.html#library-config

When logging is actually enabled (always at the behest of an explicit
call by a client script), a root logger is implicitly created at the
root, which allows messages to propagate upwards and be handled/emitted
from the root logger with default settings.

When we want iotest logging, we attach a handler to the
qemu.iotests.diff_io logger and disable propagation to avoid possible
double-printing.

For more information on python logging infrastructure, I highly
recommend downloading the pip package `logging_tree`, which provides
convenient visualizations of the hierarchical logging configuration
under different circumstances.

See https://pypi.org/project/logging_tree/ for more information.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/030        |  4 +--
 tests/qemu-iotests/155        |  2 +-
 tests/qemu-iotests/245        |  1 +
 tests/qemu-iotests/245.out    | 24 ++++++++--------
 tests/qemu-iotests/iotests.py | 52 +++++++++++++++++++----------------
 5 files changed, 45 insertions(+), 38 deletions(-)

diff --git a/tests/qemu-iotests/030 b/tests/qemu-iotests/030
index aa911d266a..104e3cee1b 100755
--- a/tests/qemu-iotests/030
+++ b/tests/qemu-iotests/030
@@ -411,8 +411,8 @@ class TestParallelOps(iotests.QMPTestCase):
         result =3D self.vm.qmp('block-job-set-speed', device=3D'drive0', s=
peed=3D0)
         self.assert_qmp(result, 'return', {})
=20
-        self.vm.run_job(job=3D'drive0', auto_dismiss=3DTrue, use_log=3DFal=
se)
-        self.vm.run_job(job=3D'node4', auto_dismiss=3DTrue, use_log=3DFals=
e)
+        self.vm.run_job(job=3D'drive0', auto_dismiss=3DTrue)
+        self.vm.run_job(job=3D'node4', auto_dismiss=3DTrue)
         self.assert_no_active_block_jobs()
=20
     # Test a block-stream and a block-commit job in parallel
diff --git a/tests/qemu-iotests/155 b/tests/qemu-iotests/155
index 571bce9de4..cb371d4649 100755
--- a/tests/qemu-iotests/155
+++ b/tests/qemu-iotests/155
@@ -188,7 +188,7 @@ class MirrorBaseClass(BaseClass):
=20
         self.assert_qmp(result, 'return', {})
=20
-        self.vm.run_job('mirror-job', use_log=3DFalse, auto_finalize=3DFal=
se,
+        self.vm.run_job('mirror-job', auto_finalize=3DFalse,
                         pre_finalize=3Dself.openBacking, auto_dismiss=3DTr=
ue)
=20
     def testFull(self):
diff --git a/tests/qemu-iotests/245 b/tests/qemu-iotests/245
index 1001275a44..4f5f0bb901 100755
--- a/tests/qemu-iotests/245
+++ b/tests/qemu-iotests/245
@@ -1027,5 +1027,6 @@ class TestBlockdevReopen(iotests.QMPTestCase):
         self.run_test_iothreads(None, 'iothread0')
=20
 if __name__ =3D=3D '__main__':
+    iotests.activate_logging()
     iotests.main(supported_fmts=3D["qcow2"],
                  supported_protocols=3D["file"])
diff --git a/tests/qemu-iotests/245.out b/tests/qemu-iotests/245.out
index 682b93394d..4b33dcaf5c 100644
--- a/tests/qemu-iotests/245.out
+++ b/tests/qemu-iotests/245.out
@@ -1,17 +1,17 @@
+{"execute": "job-finalize", "arguments": {"id": "commit0"}}
+{"return": {}}
+{"data": {"id": "commit0", "type": "commit"}, "event": "BLOCK_JOB_PENDING"=
, "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "commit0", "len": 3145728, "offset": 3145728, "speed":=
 0, "type": "commit"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"micro=
seconds": "USECS", "seconds": "SECS"}}
+{"execute": "job-finalize", "arguments": {"id": "stream0"}}
+{"return": {}}
+{"data": {"id": "stream0", "type": "stream"}, "event": "BLOCK_JOB_PENDING"=
, "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "stream0", "len": 3145728, "offset": 3145728, "speed":=
 0, "type": "stream"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"micro=
seconds": "USECS", "seconds": "SECS"}}
+{"execute": "job-finalize", "arguments": {"id": "stream0"}}
+{"return": {}}
+{"data": {"id": "stream0", "type": "stream"}, "event": "BLOCK_JOB_PENDING"=
, "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "stream0", "len": 3145728, "offset": 3145728, "speed":=
 0, "type": "stream"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"micro=
seconds": "USECS", "seconds": "SECS"}}
 .....................
 ----------------------------------------------------------------------
 Ran 21 tests
=20
 OK
-{"execute": "job-finalize", "arguments": {"id": "commit0"}}
-{"return": {}}
-{"data": {"id": "commit0", "type": "commit"}, "event": "BLOCK_JOB_PENDING"=
, "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
-{"data": {"device": "commit0", "len": 3145728, "offset": 3145728, "speed":=
 0, "type": "commit"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"micro=
seconds": "USECS", "seconds": "SECS"}}
-{"execute": "job-finalize", "arguments": {"id": "stream0"}}
-{"return": {}}
-{"data": {"id": "stream0", "type": "stream"}, "event": "BLOCK_JOB_PENDING"=
, "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
-{"data": {"device": "stream0", "len": 3145728, "offset": 3145728, "speed":=
 0, "type": "stream"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"micro=
seconds": "USECS", "seconds": "SECS"}}
-{"execute": "job-finalize", "arguments": {"id": "stream0"}}
-{"return": {}}
-{"data": {"id": "stream0", "type": "stream"}, "event": "BLOCK_JOB_PENDING"=
, "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
-{"data": {"device": "stream0", "len": 3145728, "offset": 3145728, "speed":=
 0, "type": "stream"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"micro=
seconds": "USECS", "seconds": "SECS"}}
diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index a356dd1b45..0b9c2b08c9 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -38,6 +38,13 @@
=20
 assert sys.version_info >=3D (3, 6)
=20
+# Use this logger for logging messages directly from the iotests module
+logger =3D logging.getLogger('qemu.iotests')
+logger.addHandler(logging.NullHandler())
+
+# Use this logger for messages that ought to be used for diff output.
+test_logger =3D logging.getLogger('qemu.iotests.diff_io')
+
 faulthandler.enable()
=20
 # This will not work if arguments contain spaces but is necessary if we
@@ -380,9 +387,9 @@ def log(msg: Msg,
     if isinstance(msg, (dict, list)):
         # Don't sort if it's already sorted
         do_sort =3D not isinstance(msg, OrderedDict)
-        print(json.dumps(msg, sort_keys=3Ddo_sort, indent=3Dindent))
+        test_logger.info(json.dumps(msg, sort_keys=3Ddo_sort, indent=3Dind=
ent))
     else:
-        print(msg)
+        test_logger.info(msg)
=20
 class Timeout:
     def __init__(self, seconds, errmsg=3D"Timeout"):
@@ -603,7 +610,7 @@ def qmp_log(self, cmd, filters=3D(), indent=3DNone, **k=
wargs):
=20
     # Returns None on success, and an error string on failure
     def run_job(self, job, auto_finalize=3DTrue, auto_dismiss=3DFalse,
-                pre_finalize=3DNone, cancel=3DFalse, use_log=3DTrue, wait=
=3D60.0):
+                pre_finalize=3DNone, cancel=3DFalse, wait=3D60.0):
         """
         run_job moves a job from creation through to dismissal.
=20
@@ -616,7 +623,6 @@ def run_job(self, job, auto_finalize=3DTrue, auto_dismi=
ss=3DFalse,
                              invoked prior to issuing job-finalize, if any=
.
         :param cancel: Bool. When true, cancels the job after the pre_fina=
lize
                        callback.
-        :param use_log: Bool. When false, does not log QMP messages.
         :param wait: Float. Timeout value specifying how long to wait for =
any
                      event, in seconds. Defaults to 60.0.
         """
@@ -634,8 +640,7 @@ def run_job(self, job, auto_finalize=3DTrue, auto_dismi=
ss=3DFalse,
         while True:
             ev =3D filter_qmp_event(self.events_wait(events, timeout=3Dwai=
t))
             if ev['event'] !=3D 'JOB_STATUS_CHANGE':
-                if use_log:
-                    log(ev)
+                log(ev)
                 continue
             status =3D ev['data']['status']
             if status =3D=3D 'aborting':
@@ -643,29 +648,18 @@ def run_job(self, job, auto_finalize=3DTrue, auto_dis=
miss=3DFalse,
                 for j in result['return']:
                     if j['id'] =3D=3D job:
                         error =3D j['error']
-                        if use_log:
-                            log('Job failed: %s' % (j['error']))
+                        log('Job failed: %s' % (j['error']))
             elif status =3D=3D 'ready':
-                if use_log:
-                    self.qmp_log('job-complete', id=3Djob)
-                else:
-                    self.qmp('job-complete', id=3Djob)
+                self.qmp_log('job-complete', id=3Djob)
             elif status =3D=3D 'pending' and not auto_finalize:
                 if pre_finalize:
                     pre_finalize()
-                if cancel and use_log:
+                if cancel:
                     self.qmp_log('job-cancel', id=3Djob)
-                elif cancel:
-                    self.qmp('job-cancel', id=3Djob)
-                elif use_log:
+                else:
                     self.qmp_log('job-finalize', id=3Djob)
-                else:
-                    self.qmp('job-finalize', id=3Djob)
             elif status =3D=3D 'concluded' and not auto_dismiss:
-                if use_log:
-                    self.qmp_log('job-dismiss', id=3Djob)
-                else:
-                    self.qmp('job-dismiss', id=3Djob)
+                self.qmp_log('job-dismiss', id=3Djob)
             elif status =3D=3D 'null':
                 return error
=20
@@ -985,7 +979,7 @@ def notrun(reason):
     seq =3D os.path.basename(sys.argv[0])
=20
     open('%s/%s.notrun' % (output_dir, seq), 'w').write(reason + '\n')
-    print('%s not run: %s' % (seq, reason))
+    logger.warning("%s not run: %s", seq, reason)
     sys.exit(0)
=20
 def case_notrun(reason):
@@ -1173,6 +1167,7 @@ def execute_setup_common(supported_fmts: Collection[s=
tr] =3D (),
     if debug:
         sys.argv.remove('-d')
     logging.basicConfig(level=3D(logging.DEBUG if debug else logging.WARN)=
)
+    logger.debug("iotests debugging messages active")
=20
     return debug
=20
@@ -1185,14 +1180,25 @@ def execute_test(*args, test_function=3DNone, **kwa=
rgs):
     else:
         test_function()
=20
+def activate_logging():
+    """Activate iotests.log() output to stdout for script-style tests."""
+    handler =3D logging.StreamHandler(stream=3Dsys.stdout)
+    formatter =3D logging.Formatter('%(message)s')
+    handler.setFormatter(formatter)
+    test_logger.addHandler(handler)
+    test_logger.setLevel(logging.INFO)
+    test_logger.propagate =3D False
+
 # This is called from script-style iotests without a single point of entry
 def script_initialize(*args, **kwargs):
     """Initialize script-style tests without running any tests."""
+    activate_logging()
     execute_setup_common(*args, **kwargs)
=20
 # This is called from script-style iotests with a single point of entry
 def script_main(test_function, *args, **kwargs):
     """Run script-style tests outside of the unittest framework"""
+    activate_logging()
     execute_test(*args, test_function=3Dtest_function, **kwargs)
=20
 # This is called from unittest style iotests
--=20
2.21.1


