Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B02EC49ED6
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 00:22:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BAAE2082C
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 00:22:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BAAE2082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57276 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8Csk-0000UH-DH
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 20:22:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58622)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsnow@redhat.com>) id 1i8Cn0-0002ky-DZ
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 20:16:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1i8Cmy-0006J1-H7
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 20:16:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35494)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>)
 id 1i8Cmu-0006Gu-Gw; Wed, 11 Sep 2019 20:16:40 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id CA51A3082E03;
 Thu, 12 Sep 2019 00:16:39 +0000 (UTC)
Received: from probe.bos.redhat.com (dhcp-17-203.bos.redhat.com [10.18.17.203])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3366D5D6D0;
 Thu, 12 Sep 2019 00:16:39 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed, 11 Sep 2019 20:16:33 -0400
Message-Id: <20190912001633.11372-5-jsnow@redhat.com>
In-Reply-To: <20190912001633.11372-1-jsnow@redhat.com>
References: <20190912001633.11372-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Thu, 12 Sep 2019 00:16:39 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v4 4/4] iotests: use python logging for
 iotests.log()
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

We can turn logging on/off globally instead of per-function.

Remove use_log from run_job, and use python logging to turn on
diffable output when we run through a script entry point.

iotest 245 changes output order due to buffering reasons.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 tests/qemu-iotests/030        |  4 +--
 tests/qemu-iotests/245        |  1 +
 tests/qemu-iotests/245.out    | 24 +++++++++---------
 tests/qemu-iotests/iotests.py | 47 +++++++++++++++++++++--------------
 4 files changed, 43 insertions(+), 33 deletions(-)

diff --git a/tests/qemu-iotests/030 b/tests/qemu-iotests/030
index f3766f2a81..01aa96ed16 100755
--- a/tests/qemu-iotests/030
+++ b/tests/qemu-iotests/030
@@ -411,8 +411,8 @@ class TestParallelOps(iotests.QMPTestCase):
         result =3D self.vm.qmp('block-job-set-speed', device=3D'drive0',=
 speed=3D0)
         self.assert_qmp(result, 'return', {})
=20
-        self.vm.run_job(job=3D'drive0', auto_dismiss=3DTrue, use_log=3DF=
alse)
-        self.vm.run_job(job=3D'node4', auto_dismiss=3DTrue, use_log=3DFa=
lse)
+        self.vm.run_job(job=3D'drive0', auto_dismiss=3DTrue)
+        self.vm.run_job(job=3D'node4', auto_dismiss=3DTrue)
         self.assert_no_active_block_jobs()
=20
     # Test a block-stream and a block-commit job in parallel
diff --git a/tests/qemu-iotests/245 b/tests/qemu-iotests/245
index 41218d5f1d..eba2157cff 100644
--- a/tests/qemu-iotests/245
+++ b/tests/qemu-iotests/245
@@ -1000,5 +1000,6 @@ class TestBlockdevReopen(iotests.QMPTestCase):
         self.reopen(opts, {'backing': 'hd2'})
=20
 if __name__ =3D=3D '__main__':
+    iotests.activate_logging()
     iotests.main(supported_fmts=3D["qcow2"],
                  supported_protocols=3D["file"])
diff --git a/tests/qemu-iotests/245.out b/tests/qemu-iotests/245.out
index a19de5214d..15c3630e92 100644
--- a/tests/qemu-iotests/245.out
+++ b/tests/qemu-iotests/245.out
@@ -1,17 +1,17 @@
+{"execute": "job-finalize", "arguments": {"id": "commit0"}}
+{"return": {}}
+{"data": {"id": "commit0", "type": "commit"}, "event": "BLOCK_JOB_PENDIN=
G", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "commit0", "len": 3145728, "offset": 3145728, "speed=
": 0, "type": "commit"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"m=
icroseconds": "USECS", "seconds": "SECS"}}
+{"execute": "job-finalize", "arguments": {"id": "stream0"}}
+{"return": {}}
+{"data": {"id": "stream0", "type": "stream"}, "event": "BLOCK_JOB_PENDIN=
G", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "stream0", "len": 3145728, "offset": 3145728, "speed=
": 0, "type": "stream"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"m=
icroseconds": "USECS", "seconds": "SECS"}}
+{"execute": "job-finalize", "arguments": {"id": "stream0"}}
+{"return": {}}
+{"data": {"id": "stream0", "type": "stream"}, "event": "BLOCK_JOB_PENDIN=
G", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "stream0", "len": 3145728, "offset": 3145728, "speed=
": 0, "type": "stream"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"m=
icroseconds": "USECS", "seconds": "SECS"}}
 ..................
 ----------------------------------------------------------------------
 Ran 18 tests
=20
 OK
-{"execute": "job-finalize", "arguments": {"id": "commit0"}}
-{"return": {}}
-{"data": {"id": "commit0", "type": "commit"}, "event": "BLOCK_JOB_PENDIN=
G", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
-{"data": {"device": "commit0", "len": 3145728, "offset": 3145728, "speed=
": 0, "type": "commit"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"m=
icroseconds": "USECS", "seconds": "SECS"}}
-{"execute": "job-finalize", "arguments": {"id": "stream0"}}
-{"return": {}}
-{"data": {"id": "stream0", "type": "stream"}, "event": "BLOCK_JOB_PENDIN=
G", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
-{"data": {"device": "stream0", "len": 3145728, "offset": 3145728, "speed=
": 0, "type": "stream"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"m=
icroseconds": "USECS", "seconds": "SECS"}}
-{"execute": "job-finalize", "arguments": {"id": "stream0"}}
-{"return": {}}
-{"data": {"id": "stream0", "type": "stream"}, "event": "BLOCK_JOB_PENDIN=
G", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
-{"data": {"device": "stream0", "len": 3145728, "offset": 3145728, "speed=
": 0, "type": "stream"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"m=
icroseconds": "USECS", "seconds": "SECS"}}
diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.p=
y
index 92117a64bc..7e46fb2754 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -35,6 +35,13 @@ from collections import OrderedDict
 sys.path.append(os.path.join(os.path.dirname(__file__), '..', '..', 'pyt=
hon'))
 from qemu import qtest
=20
+# Use this logger for logging messages directly from the iotests module
+logger =3D logging.getLogger(__name__)
+logger.addHandler(logging.NullHandler())
+
+# Use this logger for messages that ought to be used for diff output.
+test_logger =3D logging.getLogger('.'.join((__name__, 'iotest')))
+test_logger.addHandler(logging.NullHandler())
=20
 # This will not work if arguments contain spaces but is necessary if we
 # want to support the override options that ./check supports.
@@ -343,10 +350,10 @@ def log(msg, filters=3D[], indent=3DNone):
         separators =3D (', ', ': ') if indent is None else (',', ': ')
         # Don't sort if it's already sorted
         do_sort =3D not isinstance(msg, OrderedDict)
-        print(json.dumps(msg, sort_keys=3Ddo_sort,
-                         indent=3Dindent, separators=3Dseparators))
+        test_logger.info(json.dumps(msg, sort_keys=3Ddo_sort,
+                                    indent=3Dindent, separators=3Dsepara=
tors))
     else:
-        print(msg)
+        test_logger.info(msg)
=20
 class Timeout:
     def __init__(self, seconds, errmsg =3D "Timeout"):
@@ -559,7 +566,7 @@ class VM(qtest.QEMUQtestMachine):
=20
     # Returns None on success, and an error string on failure
     def run_job(self, job, auto_finalize=3DTrue, auto_dismiss=3DFalse,
-                pre_finalize=3DNone, cancel=3DFalse, use_log=3DTrue, wai=
t=3D60.0):
+                pre_finalize=3DNone, cancel=3DFalse, wait=3D60.0):
         """
         run_job moves a job from creation through to dismissal.
=20
@@ -572,7 +579,6 @@ class VM(qtest.QEMUQtestMachine):
                              invoked prior to issuing job-finalize, if a=
ny.
         :param cancel: Bool. When true, cancels the job after the pre_fi=
nalize
                        callback.
-        :param use_log: Bool. When false, does not log QMP messages.
         :param wait: Float. Timeout value specifying how long to wait fo=
r any
                      event, in seconds. Defaults to 60.0.
         """
@@ -590,8 +596,7 @@ class VM(qtest.QEMUQtestMachine):
         while True:
             ev =3D filter_qmp_event(self.events_wait(events))
             if ev['event'] !=3D 'JOB_STATUS_CHANGE':
-                if use_log:
-                    log(ev)
+                log(ev)
                 continue
             status =3D ev['data']['status']
             if status =3D=3D 'aborting':
@@ -599,24 +604,16 @@ class VM(qtest.QEMUQtestMachine):
                 for j in result['return']:
                     if j['id'] =3D=3D job:
                         error =3D j['error']
-                        if use_log:
-                            log('Job failed: %s' % (j['error']))
+                        log('Job failed: %s' % (j['error']))
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
@@ -949,6 +946,7 @@ def execute_setup_common(supported_fmts=3D[],
     if debug:
         sys.argv.remove('-d')
     logging.basicConfig(level=3D(logging.DEBUG if debug else logging.WAR=
N))
+    logger.debug("iotests debugging messages active")
=20
     return debug
=20
@@ -961,14 +959,25 @@ def execute_test(test_function=3DNone, *args, **kwa=
rgs):
     else:
         test_function()
=20
+def activate_logging():
+    """Activate iotests.log() output to stdout for script-style tests.""=
"
+    handler =3D logging.StreamHandler(stream=3Dsys.stdout)
+    formatter =3D logging.Formatter('%(message)s')
+    handler.setFormatter(formatter)
+    test_logger.addHandler(handler)
+    test_logger.setLevel(logging.INFO)
+    test_logger.propagate =3D False
+
 # This is called from script-style iotests without a single point of ent=
ry
 def script_initialize(*args, **kwargs):
     """Initialize script-style tests without running any tests."""
+    activate_logging()
     execute_setup_common(*args, **kwargs)
=20
 # This is called from script-style iotests with a single point of entry
 def script_main(test_function, *args, **kwargs):
     """Run script-style tests outside of the unittest framework"""
+    activate_logging()
     execute_test(test_function, *args, **kwargs)
=20
 # This is called from unittest style iotests
--=20
2.21.0


