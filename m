Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78DC6C0650E
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 17:39:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 449EA21881
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 17:39:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 449EA21881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38074 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hijEE-0000gq-I1
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 13:39:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48989)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hij3u-0007fr-9o
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 13:28:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hij3s-0008QL-4h
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 13:28:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52196)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hij3n-0008DL-K3; Wed, 03 Jul 2019 13:28:47 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D4FF730024B1;
 Wed,  3 Jul 2019 17:28:43 +0000 (UTC)
Received: from localhost (ovpn-204-65.brq.redhat.com [10.40.204.65])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 412281001B1B;
 Wed,  3 Jul 2019 17:28:43 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Wed,  3 Jul 2019 19:28:13 +0200
Message-Id: <20190703172813.6868-13-mreitz@redhat.com>
In-Reply-To: <20190703172813.6868-1-mreitz@redhat.com>
References: <20190703172813.6868-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Wed, 03 Jul 2019 17:28:43 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 12/12] iotests: Add test for concurrent
 stream/commit
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We already have 030 for that in general, but this tests very specific
cases of both jobs finishing concurrently.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/258     | 163 +++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/258.out |  33 ++++++++
 tests/qemu-iotests/group   |   1 +
 3 files changed, 197 insertions(+)
 create mode 100755 tests/qemu-iotests/258
 create mode 100644 tests/qemu-iotests/258.out

diff --git a/tests/qemu-iotests/258 b/tests/qemu-iotests/258
new file mode 100755
index 0000000000..b84cf02254
--- /dev/null
+++ b/tests/qemu-iotests/258
@@ -0,0 +1,163 @@
+#!/usr/bin/env python
+#
+# Very specific tests for adjacent commit/stream block jobs
+#
+# Copyright (C) 2019 Red Hat, Inc.
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
+# Creator/Owner: Max Reitz <mreitz@redhat.com>
+
+import iotests
+from iotests import log, qemu_img, qemu_io_silent, \
+        filter_qmp_testfiles, filter_qmp_imgfmt
+
+# Need backing file and change-backing-file support
+iotests.verify_image_format(supported_fmts=3D['qcow2', 'qed'])
+iotests.verify_platform(['linux'])
+
+
+# Returns a node for blockdev-add
+def node(node_name, path, backing=3DNone, fmt=3DNone, throttle=3DNone):
+    if fmt is None:
+        fmt =3D iotests.imgfmt
+
+    res =3D {
+        'node-name': node_name,
+        'driver': fmt,
+        'file': {
+            'driver': 'file',
+            'filename': path
+        }
+    }
+
+    if backing is not None:
+        res['backing'] =3D backing
+
+    if throttle:
+        res['file'] =3D {
+            'driver': 'throttle',
+            'throttle-group': throttle,
+            'file': res['file']
+        }
+
+    return res
+
+# Finds a node in the debug block graph
+def find_graph_node(graph, node_id):
+    return next(node for node in graph['nodes'] if node['id'] =3D=3D nod=
e_id)
+
+
+def test_concurrent_finish(write_to_stream_node):
+    log('')
+    log('=3D=3D=3D Commit and stream finish concurrently (letting %s wri=
te) =3D=3D=3D' % \
+        ('stream' if write_to_stream_node else 'commit'))
+    log('')
+
+    # All chosen in such a way that when the commit job wants to
+    # finish, it polls and thus makes stream finish concurrently --
+    # and the other way around, depending on whether the commit job
+    # is finalized before stream completes or not.
+
+    with iotests.FilePath('node4.img') as node4_path, \
+         iotests.FilePath('node3.img') as node3_path, \
+         iotests.FilePath('node2.img') as node2_path, \
+         iotests.FilePath('node1.img') as node1_path, \
+         iotests.FilePath('node0.img') as node0_path, \
+         iotests.VM() as vm:
+
+        # It is important to use raw for the base layer (so that
+        # permissions are just handed through to the protocol layer)
+        assert qemu_img('create', '-f', 'raw', node0_path, '64M') =3D=3D=
 0
+
+        stream_throttle=3DNone
+        commit_throttle=3DNone
+
+        for path in [node1_path, node2_path, node3_path, node4_path]:
+            assert qemu_img('create', '-f', iotests.imgfmt, path, '64M')=
 =3D=3D 0
+
+        if write_to_stream_node:
+            # This is what (most of the time) makes commit finish
+            # earlier and then pull in stream
+            assert qemu_io_silent(node2_path,
+                                  '-c', 'write %iK 64K' % (65536 - 192),
+                                  '-c', 'write %iK 64K' % (65536 -  64))=
 =3D=3D 0
+
+            stream_throttle=3D'tg'
+        else:
+            # And this makes stream finish earlier
+            assert qemu_io_silent(node1_path,
+                                  '-c', 'write %iK 64K' % (65536 - 64)) =
=3D=3D 0
+
+            commit_throttle=3D'tg'
+
+        vm.launch()
+
+        vm.qmp_log('object-add',
+                   qom_type=3D'throttle-group',
+                   id=3D'tg',
+                   props=3D{
+                       'x-iops-write': 1,
+                       'x-iops-write-max': 1
+                   })
+
+        vm.qmp_log('blockdev-add',
+                   filters=3D[filter_qmp_testfiles, filter_qmp_imgfmt],
+                   **node('node4', node4_path, throttle=3Dstream_throttl=
e,
+                     backing=3Dnode('node3', node3_path,
+                     backing=3Dnode('node2', node2_path,
+                     backing=3Dnode('node1', node1_path,
+                     backing=3Dnode('node0', node0_path, throttle=3Dcomm=
it_throttle,
+                                  fmt=3D'raw'))))))
+
+        vm.qmp_log('block-commit',
+                   job_id=3D'commit',
+                   device=3D'node4',
+                   filter_node_name=3D'commit-filter',
+                   top_node=3D'node1',
+                   base_node=3D'node0',
+                   auto_finalize=3DFalse)
+
+        vm.qmp_log('block-stream',
+                   job_id=3D'stream',
+                   device=3D'node3',
+                   base_node=3D'commit-filter')
+
+        if write_to_stream_node:
+            vm.run_job('commit', auto_finalize=3DFalse, auto_dismiss=3DT=
rue)
+            vm.run_job('stream', auto_finalize=3DTrue, auto_dismiss=3DTr=
ue)
+        else:
+            # No, the jobs do not really finish concurrently here,
+            # the stream job does complete strictly before commit.
+            # But still, this is close enough for what we want to
+            # test.
+            vm.run_job('stream', auto_finalize=3DTrue, auto_dismiss=3DTr=
ue)
+            vm.run_job('commit', auto_finalize=3DFalse, auto_dismiss=3DT=
rue)
+
+        # Assert that the backing node of node3 is node 0 now
+        graph =3D vm.qmp('x-debug-query-block-graph')['return']
+        for edge in graph['edges']:
+            if edge['name'] =3D=3D 'backing' and \
+               find_graph_node(graph, edge['parent'])['name'] =3D=3D 'no=
de3':
+                assert find_graph_node(graph, edge['child'])['name'] =3D=
=3D 'node0'
+                break
+
+
+def main():
+    log('Running tests:')
+    test_concurrent_finish(True)
+    test_concurrent_finish(False)
+
+if __name__ =3D=3D '__main__':
+    main()
diff --git a/tests/qemu-iotests/258.out b/tests/qemu-iotests/258.out
new file mode 100644
index 0000000000..ce6e9ba3e5
--- /dev/null
+++ b/tests/qemu-iotests/258.out
@@ -0,0 +1,33 @@
+Running tests:
+
+=3D=3D=3D Commit and stream finish concurrently (letting stream write) =3D=
=3D=3D
+
+{"execute": "object-add", "arguments": {"id": "tg", "props": {"x-iops-wr=
ite": 1, "x-iops-write-max": 1}, "qom-type": "throttle-group"}}
+{"return": {}}
+{"execute": "blockdev-add", "arguments": {"backing": {"backing": {"backi=
ng": {"backing": {"driver": "raw", "file": {"driver": "file", "filename":=
 "TEST_DIR/PID-node0.img"}, "node-name": "node0"}, "driver": "IMGFMT", "f=
ile": {"driver": "file", "filename": "TEST_DIR/PID-node1.img"}, "node-nam=
e": "node1"}, "driver": "IMGFMT", "file": {"driver": "file", "filename": =
"TEST_DIR/PID-node2.img"}, "node-name": "node2"}, "driver": "IMGFMT", "fi=
le": {"driver": "file", "filename": "TEST_DIR/PID-node3.img"}, "node-name=
": "node3"}, "driver": "IMGFMT", "file": {"driver": "throttle", "file": {=
"driver": "file", "filename": "TEST_DIR/PID-node4.img"}, "throttle-group"=
: "tg"}, "node-name": "node4"}}
+{"return": {}}
+{"execute": "block-commit", "arguments": {"auto-finalize": false, "base-=
node": "node0", "device": "node4", "filter-node-name": "commit-filter", "=
job-id": "commit", "top-node": "node1"}}
+{"return": {}}
+{"execute": "block-stream", "arguments": {"base-node": "commit-filter", =
"device": "node3", "job-id": "stream"}}
+{"return": {}}
+{"execute": "job-finalize", "arguments": {"id": "commit"}}
+{"return": {}}
+{"data": {"id": "commit", "type": "commit"}, "event": "BLOCK_JOB_PENDING=
", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "commit", "len": 67108864, "offset": 67108864, "spee=
d": 0, "type": "commit"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"=
microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "stream", "len": 67108864, "offset": 67108864, "spee=
d": 0, "type": "stream"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"=
microseconds": "USECS", "seconds": "SECS"}}
+
+=3D=3D=3D Commit and stream finish concurrently (letting commit write) =3D=
=3D=3D
+
+{"execute": "object-add", "arguments": {"id": "tg", "props": {"x-iops-wr=
ite": 1, "x-iops-write-max": 1}, "qom-type": "throttle-group"}}
+{"return": {}}
+{"execute": "blockdev-add", "arguments": {"backing": {"backing": {"backi=
ng": {"backing": {"driver": "raw", "file": {"driver": "throttle", "file":=
 {"driver": "file", "filename": "TEST_DIR/PID-node0.img"}, "throttle-grou=
p": "tg"}, "node-name": "node0"}, "driver": "IMGFMT", "file": {"driver": =
"file", "filename": "TEST_DIR/PID-node1.img"}, "node-name": "node1"}, "dr=
iver": "IMGFMT", "file": {"driver": "file", "filename": "TEST_DIR/PID-nod=
e2.img"}, "node-name": "node2"}, "driver": "IMGFMT", "file": {"driver": "=
file", "filename": "TEST_DIR/PID-node3.img"}, "node-name": "node3"}, "dri=
ver": "IMGFMT", "file": {"driver": "file", "filename": "TEST_DIR/PID-node=
4.img"}, "node-name": "node4"}}
+{"return": {}}
+{"execute": "block-commit", "arguments": {"auto-finalize": false, "base-=
node": "node0", "device": "node4", "filter-node-name": "commit-filter", "=
job-id": "commit", "top-node": "node1"}}
+{"return": {}}
+{"execute": "block-stream", "arguments": {"base-node": "commit-filter", =
"device": "node3", "job-id": "stream"}}
+{"return": {}}
+{"data": {"device": "stream", "len": 67108864, "offset": 67108864, "spee=
d": 0, "type": "stream"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"=
microseconds": "USECS", "seconds": "SECS"}}
+{"execute": "job-finalize", "arguments": {"id": "commit"}}
+{"return": {}}
+{"data": {"id": "commit", "type": "commit"}, "event": "BLOCK_JOB_PENDING=
", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
+{"data": {"device": "commit", "len": 67108864, "offset": 67108864, "spee=
d": 0, "type": "commit"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"=
microseconds": "USECS", "seconds": "SECS"}}
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index b34c8e3c0c..21bebc00e6 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -269,3 +269,4 @@
 254 rw auto backing quick
 255 rw auto quick
 256 rw auto quick
+258 rw auto
--=20
2.21.0


