Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC26FC47247
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 13:05:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41367206B9
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 13:05:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Arxz+Y9S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41367206B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49226 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVxGG-0002pd-5u
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 09:05:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38866)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jVxAJ-0001yz-Pk
 for qemu-devel@nongnu.org; Tue, 05 May 2020 08:59:15 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:28912
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jVxAG-0001G3-OO
 for qemu-devel@nongnu.org; Tue, 05 May 2020 08:59:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588683552;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pbXi/6hdtFIwWPOcv1q8IAUrdGfW8a8cRmcfOXUeG0A=;
 b=Arxz+Y9SiSQkJuzPgZg90V0ZbhB9O2pTusXeDPP8ml9EzHt+o1NWr3fBdj1MHl4U1tewiL
 nIwYsJfV0xoMhAz0SXwnwH4USS5jcB+6qYKdfqrmtydVcWm96w8Lrx75QlUFUd+RMS1SEK
 Vnx5y4BLStao5NYVxlXaQwGEOq1y2l8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-280-WVjr-pGnNmGBczsYJ2pl9g-1; Tue, 05 May 2020 08:59:00 -0400
X-MC-Unique: WVjr-pGnNmGBczsYJ2pl9g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A6B81A0C01;
 Tue,  5 May 2020 12:58:59 +0000 (UTC)
Received: from localhost (ovpn-113-206.ams2.redhat.com [10.36.113.206])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0B55060E3E;
 Tue,  5 May 2020 12:58:58 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 14/24] iotests: use python logging for iotests.log()
Date: Tue,  5 May 2020 14:58:16 +0200
Message-Id: <20200505125826.1001451-15-mreitz@redhat.com>
In-Reply-To: <20200505125826.1001451-1-mreitz@redhat.com>
References: <20200505125826.1001451-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/05 00:37:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: John Snow <jsnow@redhat.com>

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
Message-Id: <20200331000014.11581-15-jsnow@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/030        |  4 +--
 tests/qemu-iotests/155        |  2 +-
 tests/qemu-iotests/245        |  1 +
 tests/qemu-iotests/245.out    | 10 +++----
 tests/qemu-iotests/iotests.py | 53 ++++++++++++++++++++---------------
 5 files changed, 39 insertions(+), 31 deletions(-)

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
@@ -1,8 +1,3 @@
-.....................
-----------------------------------------------------------------------
-Ran 21 tests
-
-OK
 {"execute": "job-finalize", "arguments": {"id": "commit0"}}
 {"return": {}}
 {"data": {"id": "commit0", "type": "commit"}, "event": "BLOCK_JOB_PENDING"=
, "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
@@ -15,3 +10,8 @@ OK
 {"return": {}}
 {"data": {"id": "stream0", "type": "stream"}, "event": "BLOCK_JOB_PENDING"=
, "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 {"data": {"device": "stream0", "len": 3145728, "offset": 3145728, "speed":=
 0, "type": "stream"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"micro=
seconds": "USECS", "seconds": "SECS"}}
+.....................
+----------------------------------------------------------------------
+Ran 21 tests
+
+OK
diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index 35d8cae997..6c0e781af7 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -42,6 +42,14 @@ assert sys.version_info >=3D (3, 6)
 QMPResponse =3D Dict[str, Any]
=20
=20
+# Use this logger for logging messages directly from the iotests module
+logger =3D logging.getLogger('qemu.iotests')
+logger.addHandler(logging.NullHandler())
+
+# Use this logger for messages that ought to be used for diff output.
+test_logger =3D logging.getLogger('qemu.iotests.diff_io')
+
+
 faulthandler.enable()
=20
 # This will not work if arguments contain spaces but is necessary if we
@@ -385,9 +393,9 @@ def log(msg: Msg,
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
@@ -609,7 +617,7 @@ class VM(qtest.QEMUQtestMachine):
=20
     # Returns None on success, and an error string on failure
     def run_job(self, job, auto_finalize=3DTrue, auto_dismiss=3DFalse,
-                pre_finalize=3DNone, cancel=3DFalse, use_log=3DTrue, wait=
=3D60.0):
+                pre_finalize=3DNone, cancel=3DFalse, wait=3D60.0):
         """
         run_job moves a job from creation through to dismissal.
=20
@@ -622,7 +630,6 @@ class VM(qtest.QEMUQtestMachine):
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
@@ -640,8 +647,7 @@ class VM(qtest.QEMUQtestMachine):
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
@@ -649,29 +655,18 @@ class VM(qtest.QEMUQtestMachine):
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
-                    self.qmp_log('job-finalize', id=3Djob)
                 else:
-                    self.qmp('job-finalize', id=3Djob)
+                    self.qmp_log('job-finalize', id=3Djob)
             elif status =3D=3D 'concluded' and not auto_dismiss:
-                if use_log:
-                    self.qmp_log('job-dismiss', id=3Djob)
-                else:
-                    self.qmp('job-dismiss', id=3Djob)
+                self.qmp_log('job-dismiss', id=3Djob)
             elif status =3D=3D 'null':
                 return error
=20
@@ -991,7 +986,7 @@ def notrun(reason):
     seq =3D os.path.basename(sys.argv[0])
=20
     open('%s/%s.notrun' % (output_dir, seq), 'w').write(reason + '\n')
-    print('%s not run: %s' % (seq, reason))
+    logger.warning("%s not run: %s", seq, reason)
     sys.exit(0)
=20
 def case_notrun(reason):
@@ -1183,6 +1178,7 @@ def execute_setup_common(supported_fmts: Sequence[str=
] =3D (),
     if debug:
         sys.argv.remove('-d')
     logging.basicConfig(level=3D(logging.DEBUG if debug else logging.WARN)=
)
+    logger.debug("iotests debugging messages active")
=20
     return debug
=20
@@ -1195,14 +1191,25 @@ def execute_test(*args, test_function=3DNone, **kwa=
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
2.26.2


