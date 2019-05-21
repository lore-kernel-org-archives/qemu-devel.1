Return-Path: <SRS0=/4tE=TV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93EC1C04AAF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 19:19:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CE1C217D7
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 19:19:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CE1C217D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58216 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTAHy-000133-K1
	for qemu-devel@archiver.kernel.org; Tue, 21 May 2019 15:19:06 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46819)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hTAG1-00089d-Av
	for qemu-devel@nongnu.org; Tue, 21 May 2019 15:17:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hTAG0-0000ND-0p
	for qemu-devel@nongnu.org; Tue, 21 May 2019 15:17:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54740)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>)
	id 1hTAFw-0000Es-Pi; Tue, 21 May 2019 15:17:00 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D17AB30917AB;
	Tue, 21 May 2019 19:16:49 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-117-63.ams2.redhat.com [10.36.117.63])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C153D6013C;
	Tue, 21 May 2019 19:16:48 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Date: Tue, 21 May 2019 21:16:38 +0200
Message-Id: <20190521191638.32713-3-kwolf@redhat.com>
In-Reply-To: <20190521191638.32713-1-kwolf@redhat.com>
References: <20190521191638.32713-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.41]);
	Tue, 21 May 2019 19:16:54 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 2/2] iotests: Test commit job start with
 concurrent I/O
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This tests that concurrent requests are correctly drained before making
graph modifications instead of running into assertions in
bdrv_replace_node().

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/255        | 83 +++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/255.out    | 16 +++++++
 tests/qemu-iotests/group      |  1 +
 tests/qemu-iotests/iotests.py | 10 ++++-
 4 files changed, 109 insertions(+), 1 deletion(-)
 create mode 100755 tests/qemu-iotests/255
 create mode 100644 tests/qemu-iotests/255.out

diff --git a/tests/qemu-iotests/255 b/tests/qemu-iotests/255
new file mode 100755
index 0000000000..c0bb37a9b0
--- /dev/null
+++ b/tests/qemu-iotests/255
@@ -0,0 +1,83 @@
+#!/usr/bin/env python
+#
+# Test commit job graph modifications while requests are active
+#
+# Copyright (C) 2019 Red Hat, Inc.
+#
+# Creator/Owner: Kevin Wolf <kwolf@redhat.com>
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 2 of the License, or
+# (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program.  If not, see <http://www.gnu.org/licenses/>.
+#
+
+import iotests
+from iotests import imgfmt
+
+iotests.verify_image_format(supported_fmts=3D['qcow2'])
+
+def blockdev_create(vm, options):
+    result =3D vm.qmp_log('blockdev-create',
+                        filters=3D[iotests.filter_qmp_testfiles],
+                        job_id=3D'job0', options=3Doptions)
+
+    if 'return' in result:
+        assert result['return'] =3D=3D {}
+        vm.run_job('job0')
+    iotests.log("")
+
+with iotests.FilePath('t.qcow2') as disk_path, \
+     iotests.FilePath('t.qcow2.mid') as mid_path, \
+     iotests.FilePath('t.qcow2.base') as base_path, \
+     iotests.VM() as vm:
+
+    iotests.log("=3D=3D=3D Create backing chain and start VM =3D=3D=3D")
+    iotests.log("")
+
+    size =3D 128 * 1024 * 1024
+    size_str =3D str(size)
+
+    iotests.create_image(base_path, size)
+    iotests.qemu_img_log('create', '-f', iotests.imgfmt, mid_path, size_=
str)
+    iotests.qemu_img_log('create', '-f', iotests.imgfmt, disk_path, size=
_str)
+
+    # Create a backing chain like this:
+    # base <- [throttled: bps-read=3D4096] <- mid <- overlay
+
+    vm.add_object('throttle-group,x-bps-read=3D4096,id=3Dthrottle0')
+    vm.add_blockdev('file,filename=3D%s,node-name=3Dbase' % (base_path))
+    vm.add_blockdev('throttle,throttle-group=3Dthrottle0,file=3Dbase,nod=
e-name=3Dthrottled')
+    vm.add_blockdev('file,filename=3D%s,node-name=3Dmid-file' % (mid_pat=
h))
+    vm.add_blockdev('qcow2,file=3Dmid-file,node-name=3Dmid,backing=3Dthr=
ottled')
+    vm.add_drive_raw('if=3Dnone,id=3Doverlay,driver=3Dqcow2,file=3D%s,ba=
cking=3Dmid' % (disk_path))
+
+    vm.launch()
+
+    iotests.log("=3D=3D=3D Start background read requests =3D=3D=3D")
+    iotests.log("")
+
+    def start_requests():
+        vm.hmp_qemu_io('overlay', 'aio_read 0 4k')
+        vm.hmp_qemu_io('overlay', 'aio_read 0 4k')
+
+    start_requests()
+
+    iotests.log("=3D=3D=3D Run a commit job =3D=3D=3D")
+    iotests.log("")
+
+    result =3D vm.qmp_log('block-commit', job_id=3D'job0', auto_finalize=
=3DFalse,
+                        device=3D'overlay', top_node=3D'mid')
+
+    vm.run_job('job0', auto_finalize=3DFalse, pre_finalize=3Dstart_reque=
sts,
+                auto_dismiss=3DTrue)
+
+    vm.shutdown()
diff --git a/tests/qemu-iotests/255.out b/tests/qemu-iotests/255.out
new file mode 100644
index 0000000000..9a2d7cbb77
--- /dev/null
+++ b/tests/qemu-iotests/255.out
@@ -0,0 +1,16 @@
+=3D=3D=3D Create backing chain and start VM =3D=3D=3D
+
+Formatting 'TEST_DIR/PID-t.qcow2.mid', fmt=3Dqcow2 size=3D134217728 clus=
ter_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
+
+Formatting 'TEST_DIR/PID-t.qcow2', fmt=3Dqcow2 size=3D134217728 cluster_=
size=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
+
+=3D=3D=3D Start background read requests =3D=3D=3D
+
+=3D=3D=3D Run a commit job =3D=3D=3D
+
+{"execute": "block-commit", "arguments": {"auto-finalize": false, "devic=
e": "overlay", "job-id": "job0", "top-node": "mid"}}
+{"return": {}}
+{"execute": "job-finalize", "arguments": {"id": "job0"}}
+{"return": {}}
+{"data": {"id": "job0", "type": "commit"}, "event": "BLOCK_JOB_PENDING",=
 "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "job0", "len": 134217728, "offset": 134217728, "spee=
d": 0, "type": "commit"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"=
microseconds": "USECS", "seconds": "SECS"}}
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index 52b7c16e15..2758f48143 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -251,3 +251,4 @@
 249 rw auto quick
 252 rw auto backing quick
 253 rw auto quick
+255 rw auto quick
diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.p=
y
index 7bde380d96..6bcddd8870 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -126,6 +126,11 @@ def qemu_img_pipe(*args):
         sys.stderr.write('qemu-img received signal %i: %s\n' % (-exitcod=
e, ' '.join(qemu_img_args + list(args))))
     return subp.communicate()[0]
=20
+def qemu_img_log(*args):
+    result =3D qemu_img_pipe(*args)
+    log(result, filters=3D[filter_testfiles])
+    return result
+
 def img_info_log(filename, filter_path=3DNone, imgopts=3DFalse, extra_ar=
gs=3D[]):
     args =3D [ 'info' ]
     if imgopts:
@@ -533,7 +538,8 @@ class VM(qtest.QEMUQtestMachine):
         return result
=20
     # Returns None on success, and an error string on failure
-    def run_job(self, job, auto_finalize=3DTrue, auto_dismiss=3DFalse):
+    def run_job(self, job, auto_finalize=3DTrue, auto_dismiss=3DFalse,
+                pre_finalize=3DNone):
         error =3D None
         while True:
             for ev in self.get_qmp_events_filtered(wait=3DTrue):
@@ -546,6 +552,8 @@ class VM(qtest.QEMUQtestMachine):
                                 error =3D j['error']
                                 log('Job failed: %s' % (j['error']))
                     elif status =3D=3D 'pending' and not auto_finalize:
+                        if pre_finalize:
+                            pre_finalize()
                         self.qmp_log('job-finalize', id=3Djob)
                     elif status =3D=3D 'concluded' and not auto_dismiss:
                         self.qmp_log('job-dismiss', id=3Djob)
--=20
2.20.1


