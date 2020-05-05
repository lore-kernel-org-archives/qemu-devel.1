Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D196AC47247
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 13:06:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89306206B9
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 13:06:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fn4fTO2C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89306206B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53566 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVxH9-0004f1-O7
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 09:06:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38698)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jVx9u-0001Hg-HA
 for qemu-devel@nongnu.org; Tue, 05 May 2020 08:58:50 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52148
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jVx9s-0000mH-QP
 for qemu-devel@nongnu.org; Tue, 05 May 2020 08:58:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588683528;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Qef1dmn4AtamnZwBgAi9HGsLrBW+ppcBl1pWHe8MRJ0=;
 b=fn4fTO2CDgrHBULgw1VQ1KeYnAIjkwcpvmSkFeyKCh6hyagOXrmasDUrCGpDWyBthiLRal
 DHB+AvqknY9WawS3/iDBYZ41TB4MRUa2pAG6SaWKpz5Qh8C3tQcu+ZGeyb44hUR+8zztJX
 QdlkJN2QLRF0P6A8N8rCmnxy0hkOJ/k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-451-wOSZC0fuN8e83vY0m40FBw-1; Tue, 05 May 2020 08:58:31 -0400
X-MC-Unique: wOSZC0fuN8e83vY0m40FBw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A8E5880B713;
 Tue,  5 May 2020 12:58:30 +0000 (UTC)
Received: from localhost (ovpn-113-206.ams2.redhat.com [10.36.113.206])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 235DD5C1D4;
 Tue,  5 May 2020 12:58:29 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 01/24] iotests: do a light delinting
Date: Tue,  5 May 2020 14:58:03 +0200
Message-Id: <20200505125826.1001451-2-mreitz@redhat.com>
In-Reply-To: <20200505125826.1001451-1-mreitz@redhat.com>
References: <20200505125826.1001451-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/05 00:37:38
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: John Snow <jsnow@redhat.com>

This doesn't fix everything in here, but it does help clean up the
pylint report considerably.

This should be 100% style changes only; the intent is to make pylint
more useful by working on establishing a baseline for iotests that we
can gate against in the future.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Message-Id: <20200331000014.11581-2-jsnow@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/iotests.py | 83 ++++++++++++++++++-----------------
 1 file changed, 43 insertions(+), 40 deletions(-)

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index 5f8c263d59..6f6363f3ec 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -16,11 +16,9 @@
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
=20
-import errno
 import os
 import re
 import subprocess
-import string
 import unittest
 import sys
 import struct
@@ -35,7 +33,7 @@ import faulthandler
 sys.path.append(os.path.join(os.path.dirname(__file__), '..', '..', 'pytho=
n'))
 from qemu import qtest
=20
-assert sys.version_info >=3D (3,6)
+assert sys.version_info >=3D (3, 6)
=20
 faulthandler.enable()
=20
@@ -141,11 +139,11 @@ def qemu_img_log(*args):
     return result
=20
 def img_info_log(filename, filter_path=3DNone, imgopts=3DFalse, extra_args=
=3D[]):
-    args =3D [ 'info' ]
+    args =3D ['info']
     if imgopts:
         args.append('--image-opts')
     else:
-        args +=3D [ '-f', imgfmt ]
+        args +=3D ['-f', imgfmt]
     args +=3D extra_args
     args.append(filename)
=20
@@ -224,7 +222,7 @@ class QemuIoInteractive:
         # quit command is in close(), '\n' is added automatically
         assert '\n' not in cmd
         cmd =3D cmd.strip()
-        assert cmd !=3D 'q' and cmd !=3D 'quit'
+        assert cmd not in ('q', 'quit')
         self._p.stdin.write(cmd + '\n')
         self._p.stdin.flush()
         return self._read_output()
@@ -246,10 +244,8 @@ def qemu_nbd_early_pipe(*args):
         sys.stderr.write('qemu-nbd received signal %i: %s\n' %
                          (-exitcode,
                           ' '.join(qemu_nbd_args + ['--fork'] + list(args)=
)))
-    if exitcode =3D=3D 0:
-        return exitcode, ''
-    else:
-        return exitcode, subp.communicate()[0]
+
+    return exitcode, subp.communicate()[0] if exitcode else ''
=20
 def qemu_nbd_popen(*args):
     '''Run qemu-nbd in daemon mode and return the parent's exit code'''
@@ -313,7 +309,7 @@ def filter_qmp(qmsg, filter_fn):
         items =3D qmsg.items()
=20
     for k, v in items:
-        if isinstance(v, list) or isinstance(v, dict):
+        if isinstance(v, (dict, list)):
             qmsg[k] =3D filter_qmp(v, filter_fn)
         else:
             qmsg[k] =3D filter_fn(k, v)
@@ -324,7 +320,7 @@ def filter_testfiles(msg):
     return msg.replace(prefix, 'TEST_DIR/PID-')
=20
 def filter_qmp_testfiles(qmsg):
-    def _filter(key, value):
+    def _filter(_key, value):
         if is_str(value):
             return filter_testfiles(value)
         return value
@@ -351,7 +347,7 @@ def filter_imgfmt(msg):
     return msg.replace(imgfmt, 'IMGFMT')
=20
 def filter_qmp_imgfmt(qmsg):
-    def _filter(key, value):
+    def _filter(_key, value):
         if is_str(value):
             return filter_imgfmt(value)
         return value
@@ -362,7 +358,7 @@ def log(msg, filters=3D[], indent=3DNone):
     If indent is provided, JSON serializable messages are pretty-printed.'=
''
     for flt in filters:
         msg =3D flt(msg)
-    if isinstance(msg, dict) or isinstance(msg, list):
+    if isinstance(msg, (dict, list)):
         # Python < 3.4 needs to know not to add whitespace when pretty-pri=
nting:
         separators =3D (', ', ': ') if indent is None else (',', ': ')
         # Don't sort if it's already sorted
@@ -373,14 +369,14 @@ def log(msg, filters=3D[], indent=3DNone):
         print(msg)
=20
 class Timeout:
-    def __init__(self, seconds, errmsg =3D "Timeout"):
+    def __init__(self, seconds, errmsg=3D"Timeout"):
         self.seconds =3D seconds
         self.errmsg =3D errmsg
     def __enter__(self):
         signal.signal(signal.SIGALRM, self.timeout)
         signal.setitimer(signal.ITIMER_REAL, self.seconds)
         return self
-    def __exit__(self, type, value, traceback):
+    def __exit__(self, exc_type, value, traceback):
         signal.setitimer(signal.ITIMER_REAL, 0)
         return False
     def timeout(self, signum, frame):
@@ -389,7 +385,7 @@ class Timeout:
 def file_pattern(name):
     return "{0}-{1}".format(os.getpid(), name)
=20
-class FilePaths(object):
+class FilePaths:
     """
     FilePaths is an auto-generated filename that cleans itself up.
=20
@@ -536,11 +532,11 @@ class VM(qtest.QEMUQtestMachine):
             self.pause_drive(drive, "write_aio")
             return
         self.qmp('human-monitor-command',
-                    command_line=3D'qemu-io %s "break %s bp_%s"' % (drive,=
 event, drive))
+                 command_line=3D'qemu-io %s "break %s bp_%s"' % (drive, ev=
ent, drive))
=20
     def resume_drive(self, drive):
         self.qmp('human-monitor-command',
-                    command_line=3D'qemu-io %s "remove_break bp_%s"' % (dr=
ive, drive))
+                 command_line=3D'qemu-io %s "remove_break bp_%s"' % (drive=
, drive))
=20
     def hmp_qemu_io(self, drive, cmd):
         '''Write to a given drive using an HMP command'''
@@ -551,8 +547,8 @@ class VM(qtest.QEMUQtestMachine):
         if output is None:
             output =3D dict()
         if isinstance(obj, list):
-            for i in range(len(obj)):
-                self.flatten_qmp_object(obj[i], output, basestr + str(i) +=
 '.')
+            for i, item in enumerate(obj):
+                self.flatten_qmp_object(item, output, basestr + str(i) + '=
.')
         elif isinstance(obj, dict):
             for key in obj:
                 self.flatten_qmp_object(obj[key], output, basestr + key + =
'.')
@@ -710,9 +706,7 @@ class VM(qtest.QEMUQtestMachine):
=20
         for bitmap in bitmaps[node_name]:
             if bitmap.get('name', '') =3D=3D bitmap_name:
-                if recording is None:
-                    return bitmap
-                elif bitmap.get('recording') =3D=3D recording:
+                if recording is None or bitmap.get('recording') =3D=3D rec=
ording:
                     return bitmap
         return None
=20
@@ -763,12 +757,13 @@ class VM(qtest.QEMUQtestMachine):
             assert node is not None, 'Cannot follow path %s%s' % (root, pa=
th)
=20
             try:
-                node_id =3D next(edge['child'] for edge in graph['edges'] =
\
-                                             if edge['parent'] =3D=3D node=
['id'] and
-                                                edge['name'] =3D=3D child_=
name)
+                node_id =3D next(edge['child'] for edge in graph['edges']
+                               if (edge['parent'] =3D=3D node['id'] and
+                                   edge['name'] =3D=3D child_name))
+
+                node =3D next(node for node in graph['nodes']
+                            if node['id'] =3D=3D node_id)
=20
-                node =3D next(node for node in graph['nodes'] \
-                                 if node['id'] =3D=3D node_id)
             except StopIteration:
                 node =3D None
=20
@@ -786,6 +781,12 @@ index_re =3D re.compile(r'([^\[]+)\[([^\]]+)\]')
 class QMPTestCase(unittest.TestCase):
     '''Abstract base class for QMP test cases'''
=20
+    def __init__(self, *args, **kwargs):
+        super().__init__(*args, **kwargs)
+        # Many users of this class set a VM property we rely on heavily
+        # in the methods below.
+        self.vm =3D None
+
     def dictpath(self, d, path):
         '''Traverse a path in a nested dict'''
         for component in path.split('/'):
@@ -831,7 +832,7 @@ class QMPTestCase(unittest.TestCase):
         else:
             self.assertEqual(result, value,
                              '"%s" is "%s", expected "%s"'
-                                 % (path, str(result), str(value)))
+                             % (path, str(result), str(value)))
=20
     def assert_no_active_block_jobs(self):
         result =3D self.vm.qmp('query-block-jobs')
@@ -841,15 +842,15 @@ class QMPTestCase(unittest.TestCase):
         """Issue a query-named-block-nodes and assert node_name and/or
         file_name is present in the result"""
         def check_equal_or_none(a, b):
-            return a =3D=3D None or b =3D=3D None or a =3D=3D b
+            return a is None or b is None or a =3D=3D b
         assert node_name or file_name
         result =3D self.vm.qmp('query-named-block-nodes')
         for x in result["return"]:
             if check_equal_or_none(x.get("node-name"), node_name) and \
                     check_equal_or_none(x.get("file"), file_name):
                 return
-        self.assertTrue(False, "Cannot find %s %s in result:\n%s" % \
-                (node_name, file_name, result))
+        self.fail("Cannot find %s %s in result:\n%s" %
+                  (node_name, file_name, result))
=20
     def assert_json_filename_equal(self, json_filename, reference):
         '''Asserts that the given filename is a json: filename and that it=
s
@@ -898,13 +899,13 @@ class QMPTestCase(unittest.TestCase):
                         self.assert_qmp(event, 'data/error', error)
                     self.assert_no_active_block_jobs()
                     return event
-                elif event['event'] =3D=3D 'JOB_STATUS_CHANGE':
+                if event['event'] =3D=3D 'JOB_STATUS_CHANGE':
                     self.assert_qmp(event, 'data/id', drive)
=20
     def wait_ready(self, drive=3D'drive0'):
-        '''Wait until a block job BLOCK_JOB_READY event'''
-        f =3D {'data': {'type': 'mirror', 'device': drive } }
-        event =3D self.vm.event_wait(name=3D'BLOCK_JOB_READY', match=3Df)
+        """Wait until a BLOCK_JOB_READY event, and return the event."""
+        f =3D {'data': {'type': 'mirror', 'device': drive}}
+        return self.vm.event_wait(name=3D'BLOCK_JOB_READY', match=3Df)
=20
     def wait_ready_and_cancel(self, drive=3D'drive0'):
         self.wait_ready(drive=3Ddrive)
@@ -933,7 +934,7 @@ class QMPTestCase(unittest.TestCase):
                 for job in result['return']:
                     if job['device'] =3D=3D job_id:
                         found =3D True
-                        if job['paused'] =3D=3D True and job['busy'] =3D=
=3D False:
+                        if job['paused'] and not job['busy']:
                             return job
                         break
                 assert found
@@ -1030,8 +1031,8 @@ def qemu_pipe(*args):
                             universal_newlines=3DTrue)
     exitcode =3D subp.wait()
     if exitcode < 0:
-        sys.stderr.write('qemu received signal %i: %s\n' % (-exitcode,
-                         ' '.join(args)))
+        sys.stderr.write('qemu received signal %i: %s\n' %
+                         (-exitcode, ' '.join(args)))
     return subp.communicate()[0]
=20
 def supported_formats(read_only=3DFalse):
@@ -1063,6 +1064,7 @@ def skip_if_unsupported(required_formats=3D[], read_o=
nly=3DFalse):
             if usf_list:
                 test_case.case_skip('{}: formats {} are not whitelisted'.f=
ormat(
                     test_case, usf_list))
+                return None
             else:
                 return func(test_case, *args, **kwargs)
         return func_wrapper
@@ -1074,6 +1076,7 @@ def skip_if_user_is_root(func):
     def func_wrapper(*args, **kwargs):
         if os.getuid() =3D=3D 0:
             case_notrun('{}: cannot be run as root'.format(args[0]))
+            return None
         else:
             return func(*args, **kwargs)
     return func_wrapper
--=20
2.26.2


