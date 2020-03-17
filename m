Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1F40C0044D
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 00:42:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BF6B20674
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 00:42:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UVRVZsxG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BF6B20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50832 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jE0JV-0005sM-Ib
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 20:42:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41410)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsnow@redhat.com>) id 1jE0IG-00040B-My
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 20:41:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1jE0IE-0004up-JU
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 20:41:16 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:49659)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1jE0IE-0004s5-Co
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 20:41:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584405674;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TWco7/C0lTRnkqd8Rm0pU6sFt2LFRem+KeJabA6WcZU=;
 b=UVRVZsxGpSQdduTpmRegBlF3N4QBBwUfIAuWwD7fnocZiHUny/kZYjcsmWw3BT5ZEXLtGd
 lrYsGgFVWRyFFfIJ9S7WgAudiUYBM42MvZZtFzDVbG949OD0bdcPRuCUmSzyNlOdsUH2X9
 JsToPBYlhmEe2O1YXAM9l4E9VE07THI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-365-urNrHlfGOY-yGY3hzsQ8Ew-1; Mon, 16 Mar 2020 20:41:09 -0400
X-MC-Unique: urNrHlfGOY-yGY3hzsQ8Ew-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 72F3C107ACC4;
 Tue, 17 Mar 2020 00:41:08 +0000 (UTC)
Received: from probe.redhat.com (ovpn-112-191.rdu2.redhat.com [10.10.112.191])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 41F6E7A411;
 Tue, 17 Mar 2020 00:41:07 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 01/11] iotests: do a light delinting
Date: Mon, 16 Mar 2020 20:40:55 -0400
Message-Id: <20200317004105.27059-2-jsnow@redhat.com>
In-Reply-To: <20200317004105.27059-1-jsnow@redhat.com>
References: <20200317004105.27059-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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

This doesn't fix everything in here, but it does help clean up the
pylint report considerably.

This should be 100% style changes only; the intent is to make pylint
more useful by working on establishing a baseline for iotests that we
can gate against in the future.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 tests/qemu-iotests/iotests.py | 83 ++++++++++++++++++-----------------
 1 file changed, 43 insertions(+), 40 deletions(-)

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index 23043baa26..c6d9ae130d 100644
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
@@ -243,10 +241,8 @@ def qemu_nbd_early_pipe(*args):
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
@@ -310,7 +306,7 @@ def filter_qmp(qmsg, filter_fn):
         items =3D qmsg.items()
=20
     for k, v in items:
-        if isinstance(v, list) or isinstance(v, dict):
+        if isinstance(v, (dict, list)):
             qmsg[k] =3D filter_qmp(v, filter_fn)
         else:
             qmsg[k] =3D filter_fn(k, v)
@@ -321,7 +317,7 @@ def filter_testfiles(msg):
     return msg.replace(prefix, 'TEST_DIR/PID-')
=20
 def filter_qmp_testfiles(qmsg):
-    def _filter(key, value):
+    def _filter(_key, value):
         if is_str(value):
             return filter_testfiles(value)
         return value
@@ -347,7 +343,7 @@ def filter_imgfmt(msg):
     return msg.replace(imgfmt, 'IMGFMT')
=20
 def filter_qmp_imgfmt(qmsg):
-    def _filter(key, value):
+    def _filter(_key, value):
         if is_str(value):
             return filter_imgfmt(value)
         return value
@@ -358,7 +354,7 @@ def log(msg, filters=3D[], indent=3DNone):
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
@@ -369,14 +365,14 @@ def log(msg, filters=3D[], indent=3DNone):
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
@@ -385,7 +381,7 @@ def timeout(self, signum, frame):
 def file_pattern(name):
     return "{0}-{1}".format(os.getpid(), name)
=20
-class FilePaths(object):
+class FilePaths:
     """
     FilePaths is an auto-generated filename that cleans itself up.
=20
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
@@ -706,9 +702,7 @@ def get_bitmap(self, node_name, bitmap_name, recording=
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
@@ -759,12 +753,13 @@ def assert_block_path(self, root, path, expected_node=
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
@@ -782,6 +777,12 @@ def assert_block_path(self, root, path, expected_node,=
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
@@ -827,7 +828,7 @@ def assert_qmp(self, d, path, value):
         else:
             self.assertEqual(result, value,
                              '"%s" is "%s", expected "%s"'
-                                 % (path, str(result), str(value)))
+                             % (path, str(result), str(value)))
=20
     def assert_no_active_block_jobs(self):
         result =3D self.vm.qmp('query-block-jobs')
@@ -837,15 +838,15 @@ def assert_has_block_node(self, node_name=3DNone, fil=
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
@@ -894,13 +895,13 @@ def wait_until_completed(self, drive=3D'drive0', chec=
k_offset=3DTrue, wait=3D60.0,
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
@@ -929,7 +930,7 @@ def pause_wait(self, job_id=3D'job0'):
                 for job in result['return']:
                     if job['device'] =3D=3D job_id:
                         found =3D True
-                        if job['paused'] =3D=3D True and job['busy'] =3D=
=3D False:
+                        if job['paused'] and not job['busy']:
                             return job
                         break
                 assert found
@@ -1026,8 +1027,8 @@ def qemu_pipe(*args):
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
@@ -1059,6 +1060,7 @@ def func_wrapper(test_case: QMPTestCase, *args, **kwa=
rgs):
             if usf_list:
                 test_case.case_skip('{}: formats {} are not whitelisted'.f=
ormat(
                     test_case, usf_list))
+                return None
             else:
                 return func(test_case, *args, **kwargs)
         return func_wrapper
@@ -1070,6 +1072,7 @@ def skip_if_user_is_root(func):
     def func_wrapper(*args, **kwargs):
         if os.getuid() =3D=3D 0:
             case_notrun('{}: cannot be run as root'.format(args[0]))
+            return None
         else:
             return func(*args, **kwargs)
     return func_wrapper
--=20
2.21.1


