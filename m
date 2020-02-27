Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E0C1C4BA24
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 00:09:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2908D24650
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 00:09:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dIW1Sv2t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2908D24650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51998 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j76k7-0001sq-By
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 19:09:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43441)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsnow@redhat.com>) id 1j76hg-0005BS-Ui
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 19:07:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1j76he-0006Er-SJ
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 19:07:00 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20998
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1j76he-0006CV-N7
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 19:06:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582762018;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UcgUwAOBd3LDPg2kzsnKY2Wr6fuoNlU8dqfG2hiDis0=;
 b=dIW1Sv2tRmYZ8a9vlcPzAplhxBAxvysKSYvNw4SkceXFiJt4rDALGi80R2UAmt8V16KjwK
 Ys8L4CiWgzQF7sDjHqyRQtvWfyjiCQ4aCRqeESpqf4Wtm/UqYlHktQRRn/Y6lH7SRrWON0
 itaSsGo5zIOi0UDqLMDcYF8du4WpRjw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-182-CndbzEnMOdiF-hS2nDcPSg-1; Wed, 26 Feb 2020 19:06:45 -0500
X-MC-Unique: CndbzEnMOdiF-hS2nDcPSg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 439F318FF663;
 Thu, 27 Feb 2020 00:06:44 +0000 (UTC)
Received: from probe.redhat.com (ovpn-123-58.rdu2.redhat.com [10.10.123.58])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BA5E3390;
 Thu, 27 Feb 2020 00:06:40 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 1/9] iotests: do a light delinting
Date: Wed, 26 Feb 2020 19:06:31 -0500
Message-Id: <20200227000639.9644-2-jsnow@redhat.com>
In-Reply-To: <20200227000639.9644-1-jsnow@redhat.com>
References: <20200227000639.9644-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
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

This doesn't fix everything in here, but it does help clean up the
pylint report considerably.

This should be 100% style changes only; the intent is to make pylint
more useful by working on establishing a baseline for iotests that we
can gate against in the future. This will be important if (when?) we
begin adding type hints to our code base.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 tests/qemu-iotests/iotests.py | 88 ++++++++++++++++++-----------------
 1 file changed, 45 insertions(+), 43 deletions(-)

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index 8815052eb5..e8a0ea14fc 100644
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
@@ -34,7 +32,7 @@
 sys.path.append(os.path.join(os.path.dirname(__file__), '..', '..', 'pytho=
n'))
 from qemu import qtest
=20
-assert sys.version_info >=3D (3,6)
+assert sys.version_info >=3D (3, 6)
=20
 # This will not work if arguments contain spaces but is necessary if we
 # want to support the override options that ./check supports.
@@ -138,11 +136,11 @@ def qemu_img_log(*args):
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
@@ -221,7 +219,7 @@ def cmd(self, cmd):
         # quit command is in close(), '\n' is added automatically
         assert '\n' not in cmd
         cmd =3D cmd.strip()
-        assert cmd !=3D 'q' and cmd !=3D 'quit'
+        assert cmd not in ('q', 'quit')
         self._p.stdin.write(cmd + '\n')
         self._p.stdin.flush()
         return self._read_output()
@@ -245,8 +243,7 @@ def qemu_nbd_early_pipe(*args):
                           ' '.join(qemu_nbd_args + ['--fork'] + list(args)=
)))
     if exitcode =3D=3D 0:
         return exitcode, ''
-    else:
-        return exitcode, subp.communicate()[0]
+    return exitcode, subp.communicate()[0]
=20
 def qemu_nbd_popen(*args):
     '''Run qemu-nbd in daemon mode and return the parent's exit code'''
@@ -310,7 +307,7 @@ def filter_qmp(qmsg, filter_fn):
         items =3D qmsg.items()
=20
     for k, v in items:
-        if isinstance(v, list) or isinstance(v, dict):
+        if isinstance(v, (dict, list)):
             qmsg[k] =3D filter_qmp(v, filter_fn)
         else:
             qmsg[k] =3D filter_fn(k, v)
@@ -321,7 +318,7 @@ def filter_testfiles(msg):
     return msg.replace(prefix, 'TEST_DIR/PID-')
=20
 def filter_qmp_testfiles(qmsg):
-    def _filter(key, value):
+    def _filter(_key, value):
         if is_str(value):
             return filter_testfiles(value)
         return value
@@ -347,7 +344,7 @@ def filter_imgfmt(msg):
     return msg.replace(imgfmt, 'IMGFMT')
=20
 def filter_qmp_imgfmt(qmsg):
-    def _filter(key, value):
+    def _filter(_key, value):
         if is_str(value):
             return filter_imgfmt(value)
         return value
@@ -358,7 +355,7 @@ def log(msg, filters=3D[], indent=3DNone):
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
@@ -369,14 +366,14 @@ def log(msg, filters=3D[], indent=3DNone):
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
@@ -385,7 +382,7 @@ def timeout(self, signum, frame):
 def file_pattern(name):
     return "{0}-{1}".format(os.getpid(), name)
=20
-class FilePaths(object):
+class FilePaths:
     """
     FilePaths is an auto-generated filename that cleans itself up.
=20
@@ -455,10 +452,9 @@ def file_path(*names, base_dir=3Dtest_dir):
 def remote_filename(path):
     if imgproto =3D=3D 'file':
         return path
-    elif imgproto =3D=3D 'ssh':
+    if imgproto =3D=3D 'ssh':
         return "ssh://%s@127.0.0.1:22%s" % (os.environ.get('USER'), path)
-    else:
-        raise Exception("Protocol %s not supported" % (imgproto))
+    raise Exception("Protocol %s not supported" % (imgproto))
=20
 class VM(qtest.QEMUQtestMachine):
     '''A QEMU VM'''
@@ -532,11 +528,11 @@ def pause_drive(self, drive, event=3DNone):
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
@@ -547,8 +543,8 @@ def flatten_qmp_object(self, obj, output=3DNone, basest=
r=3D''):
         if output is None:
             output =3D dict()
         if isinstance(obj, list):
-            for i in range(len(obj)):
-                self.flatten_qmp_object(obj[i], output, basestr + str(i) +=
 '.')
+            for i, atom in enumerate(obj):
+                self.flatten_qmp_object(atom, output, basestr + str(i) + '=
.')
         elif isinstance(obj, dict):
             for key in obj:
                 self.flatten_qmp_object(obj[key], output, basestr + key + =
'.')
@@ -703,9 +699,7 @@ def get_bitmap(self, node_name, bitmap_name, recording=
=3DNone, bitmaps=3DNone):
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
@@ -756,12 +750,13 @@ def assert_block_path(self, root, path, expected_node=
, graph=3DNone):
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
+                               if edge['parent'] =3D=3D node['id'] and
+                               edge['name'] =3D=3D child_name)
+
+                node =3D next(node for node in graph['nodes']
+                            if node['id'] =3D=3D node_id)
=20
-                node =3D next(node for node in graph['nodes'] \
-                                 if node['id'] =3D=3D node_id)
             except StopIteration:
                 node =3D None
=20
@@ -779,6 +774,12 @@ def assert_block_path(self, root, path, expected_node,=
 graph=3DNone):
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
@@ -824,7 +825,7 @@ def assert_qmp(self, d, path, value):
         else:
             self.assertEqual(result, value,
                              '"%s" is "%s", expected "%s"'
-                                 % (path, str(result), str(value)))
+                             % (path, str(result), str(value)))
=20
     def assert_no_active_block_jobs(self):
         result =3D self.vm.qmp('query-block-jobs')
@@ -834,15 +835,15 @@ def assert_has_block_node(self, node_name=3DNone, fil=
e_name=3DNone):
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
@@ -891,13 +892,14 @@ def wait_until_completed(self, drive=3D'drive0', chec=
k_offset=3DTrue, wait=3D60.0,
                         self.assert_qmp(event, 'data/error', error)
                     self.assert_no_active_block_jobs()
                     return event
-                elif event['event'] =3D=3D 'JOB_STATUS_CHANGE':
+                if event['event'] =3D=3D 'JOB_STATUS_CHANGE':
                     self.assert_qmp(event, 'data/id', drive)
=20
     def wait_ready(self, drive=3D'drive0'):
         '''Wait until a block job BLOCK_JOB_READY event'''
-        f =3D {'data': {'type': 'mirror', 'device': drive } }
+        f =3D {'data': {'type': 'mirror', 'device': drive}}
         event =3D self.vm.event_wait(name=3D'BLOCK_JOB_READY', match=3Df)
+        return event
=20
     def wait_ready_and_cancel(self, drive=3D'drive0'):
         self.wait_ready(drive=3Ddrive)
@@ -926,7 +928,7 @@ def pause_wait(self, job_id=3D'job0'):
                 for job in result['return']:
                     if job['device'] =3D=3D job_id:
                         found =3D True
-                        if job['paused'] =3D=3D True and job['busy'] =3D=
=3D False:
+                        if job['paused'] and not job['busy']:
                             return job
                         break
                 assert found
@@ -1023,8 +1025,8 @@ def qemu_pipe(*args):
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
@@ -1056,8 +1058,8 @@ def func_wrapper(test_case: QMPTestCase, *args, **kwa=
rgs):
             if usf_list:
                 test_case.case_skip('{}: formats {} are not whitelisted'.f=
ormat(
                     test_case, usf_list))
-            else:
-                return func(test_case, *args, **kwargs)
+                return None
+            return func(test_case, *args, **kwargs)
         return func_wrapper
     return skip_test_decorator
=20
@@ -1067,8 +1069,8 @@ def skip_if_user_is_root(func):
     def func_wrapper(*args, **kwargs):
         if os.getuid() =3D=3D 0:
             case_notrun('{}: cannot be run as root'.format(args[0]))
-        else:
-            return func(*args, **kwargs)
+            return None
+        return func(*args, **kwargs)
     return func_wrapper
=20
 def execute_unittest(output, verbosity, debug):
--=20
2.21.1


