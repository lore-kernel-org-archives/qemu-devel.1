Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B36C6C54FCB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 15:06:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D1CA2098B
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 15:06:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cdDFtBb8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D1CA2098B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45172 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRdR6-0003il-Jd
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 11:06:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41124)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jRdMj-0005ON-Vr
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 11:02:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jRdMi-00067M-Hh
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 11:02:13 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34184
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jRdMi-00065S-1c
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 11:02:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587654131;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=juTyjPKZMR9MQ5Oun4vl8jfPnjJs5HdCe5jBk4Z26go=;
 b=cdDFtBb8buQD9gRe0apAvQK2h60bV59YP+hLBtBCxjVuZ4SY3Kui0LUj3v/s2MhAIm5Uzz
 PCZ2hOXx/bkfk6zyd2A6GAag4JRL+ndW4y5lCLz7lMXFJLPXuXgx6uIL9sNR1DDxf/aGgv
 5aqBc5GayOQBtrWA/r5WgYxZ9uxERzE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-238-frbPEVRVMeq-1jf08jtb5A-1; Thu, 23 Apr 2020 11:02:07 -0400
X-MC-Unique: frbPEVRVMeq-1jf08jtb5A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F3E6E835B90;
 Thu, 23 Apr 2020 15:02:05 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-114-28.ams2.redhat.com [10.36.114.28])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 974D960C81;
 Thu, 23 Apr 2020 15:01:59 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v6 09/10] iotests: Test committing to short backing file
Date: Thu, 23 Apr 2020 17:01:26 +0200
Message-Id: <20200423150127.142609-10-kwolf@redhat.com>
In-Reply-To: <20200423150127.142609-1-kwolf@redhat.com>
References: <20200423150127.142609-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/23 05:42:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, berto@igalia.com,
 qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/274     | 157 ++++++++++++++++++++++
 tests/qemu-iotests/274.out | 260 +++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/group   |   1 +
 3 files changed, 418 insertions(+)
 create mode 100755 tests/qemu-iotests/274
 create mode 100644 tests/qemu-iotests/274.out

diff --git a/tests/qemu-iotests/274 b/tests/qemu-iotests/274
new file mode 100755
index 0000000000..8bf7ff3122
--- /dev/null
+++ b/tests/qemu-iotests/274
@@ -0,0 +1,157 @@
+#!/usr/bin/env python3
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
+# Creator/Owner: Kevin Wolf <kwolf@redhat.com>
+#
+# Some tests for short backing files and short overlays
+
+import iotests
+import os
+
+iotests.verify_image_format(supported_fmts=3D['qcow2'])
+iotests.verify_platform(['linux'])
+
+size_short =3D 1 * 1024 * 1024
+size_long =3D 2 * 1024 * 1024
+size_diff =3D size_long - size_short
+
+def create_chain():
+    iotests.qemu_img_log('create', '-f', iotests.imgfmt, base,
+                         str(size_long))
+    iotests.qemu_img_log('create', '-f', iotests.imgfmt, '-b', base, mid,
+                         str(size_short))
+    iotests.qemu_img_log('create', '-f', iotests.imgfmt, '-b', mid, top,
+                         str(size_long))
+
+    iotests.qemu_io_log('-c', 'write -P 1 0 %d' % size_long, base)
+
+def create_vm():
+    vm =3D iotests.VM()
+    vm.add_blockdev('file,filename=3D%s,node-name=3Dbase-file' % (base))
+    vm.add_blockdev('%s,file=3Dbase-file,node-name=3Dbase' % (iotests.imgf=
mt))
+    vm.add_blockdev('file,filename=3D%s,node-name=3Dmid-file' % (mid))
+    vm.add_blockdev('%s,file=3Dmid-file,node-name=3Dmid,backing=3Dbase' % =
(iotests.imgfmt))
+    vm.add_drive(top, 'backing=3Dmid,node-name=3Dtop')
+    return vm
+
+with iotests.FilePath('base') as base, \
+     iotests.FilePath('mid') as mid, \
+     iotests.FilePath('top') as top:
+
+    iotests.log('=3D=3D Commit tests =3D=3D')
+
+    create_chain()
+
+    iotests.log('=3D=3D=3D Check visible data =3D=3D=3D')
+
+    iotests.qemu_io_log('-c', 'read -P 1 0 %d' % size_short, top)
+    iotests.qemu_io_log('-c', 'read -P 0 %d %d' % (size_short, size_diff),=
 top)
+
+    iotests.log('=3D=3D=3D Checking allocation status =3D=3D=3D')
+
+    iotests.qemu_io_log('-c', 'alloc 0 %d' % size_short,
+                        '-c', 'alloc %d %d' % (size_short, size_diff),
+                        base)
+
+    iotests.qemu_io_log('-c', 'alloc 0 %d' % size_short,
+                        '-c', 'alloc %d %d' % (size_short, size_diff),
+                        mid)
+
+    iotests.qemu_io_log('-c', 'alloc 0 %d' % size_short,
+                        '-c', 'alloc %d %d' % (size_short, size_diff),
+                        top)
+
+    iotests.log('=3D=3D=3D Checking map =3D=3D=3D')
+
+    iotests.qemu_img_log('map', '--output=3Djson', base)
+    iotests.qemu_img_log('map', '--output=3Dhuman', base)
+    iotests.qemu_img_log('map', '--output=3Djson', mid)
+    iotests.qemu_img_log('map', '--output=3Dhuman', mid)
+    iotests.qemu_img_log('map', '--output=3Djson', top)
+    iotests.qemu_img_log('map', '--output=3Dhuman', top)
+
+    iotests.log('=3D=3D=3D Testing qemu-img commit (top -> mid) =3D=3D=3D'=
)
+
+    iotests.qemu_img_log('commit', top)
+    iotests.img_info_log(mid)
+    iotests.qemu_io_log('-c', 'read -P 1 0 %d' % size_short, mid)
+    iotests.qemu_io_log('-c', 'read -P 0 %d %d' % (size_short, size_diff),=
 mid)
+
+    iotests.log('=3D=3D=3D Testing HMP commit (top -> mid) =3D=3D=3D')
+
+    create_chain()
+    with create_vm() as vm:
+        vm.launch()
+        vm.qmp_log('human-monitor-command', command_line=3D'commit drive0'=
)
+
+    iotests.img_info_log(mid)
+    iotests.qemu_io_log('-c', 'read -P 1 0 %d' % size_short, mid)
+    iotests.qemu_io_log('-c', 'read -P 0 %d %d' % (size_short, size_diff),=
 mid)
+
+    iotests.log('=3D=3D=3D Testing QMP active commit (top -> mid) =3D=3D=
=3D')
+
+    create_chain()
+    with create_vm() as vm:
+        vm.launch()
+        vm.qmp_log('block-commit', device=3D'top', base_node=3D'mid',
+                   job_id=3D'job0', auto_dismiss=3DFalse)
+        vm.run_job('job0', wait=3D5)
+
+    iotests.img_info_log(mid)
+    iotests.qemu_io_log('-c', 'read -P 1 0 %d' % size_short, mid)
+    iotests.qemu_io_log('-c', 'read -P 0 %d %d' % (size_short, size_diff),=
 mid)
+
+
+    iotests.log('=3D=3D Resize tests =3D=3D')
+
+    # Use different sizes for different allocation modes:
+    #
+    # We want to have at least one test where 32 bit truncation in the siz=
e of
+    # the overlapping area becomes visible. This is covered by the
+    # prealloc=3D'off' case (1G to 6G is an overlap of 5G).
+    #
+    # However, we can only do this for modes that don't preallocate data
+    # because otherwise we might run out of space on the test host.
+    #
+    # We also want to test some unaligned combinations.
+    for (prealloc, base_size, top_size_old, top_size_new, off)  in [
+            ('off',       '6G',    '1G',   '8G',   '5G'),
+            ('metadata', '32G',   '30G',  '33G',  '31G'),
+            ('falloc',   '10M',    '5M',  '15M',   '9M'),
+            ('full',     '16M',    '8M',  '12M',  '11M'),
+            ('off',      '384k', '253k', '512k', '253k'),
+            ('off',      '400k', '256k', '512k', '336k'),
+            ('off',      '512k', '256k', '500k', '436k')]:
+
+        iotests.log('=3D=3D=3D preallocation=3D%s =3D=3D=3D' % prealloc)
+        iotests.qemu_img_log('create', '-f', iotests.imgfmt, base, base_si=
ze)
+        iotests.qemu_img_log('create', '-f', iotests.imgfmt, '-b', base, t=
op,
+                             top_size_old)
+        iotests.qemu_io_log('-c', 'write -P 1 %s 64k' % off, base)
+
+        # After this, 0 to base_size should be allocated/zeroed
+        # base_size to top_size_new should be unallocated with
+        # preallocation=3Doff and allocated with preallocation enabled
+        iotests.qemu_img_log('resize', '-f', iotests.imgfmt,
+                             '--preallocation', prealloc, top, top_size_ne=
w)
+        iotests.qemu_io_log('-c', 'read -P 0 %s 64k' % off, top)
+
+        # Metadata preallocation doesn't have a defined result on the file
+        # system level with respect to holes, so skip it here
+        iotests.qemu_io_log('-c', 'map', top)
+        if prealloc !=3D 'metadata':
+            iotests.qemu_img_log('map', '--output=3Djson', top)
diff --git a/tests/qemu-iotests/274.out b/tests/qemu-iotests/274.out
new file mode 100644
index 0000000000..179bd7ccaf
--- /dev/null
+++ b/tests/qemu-iotests/274.out
@@ -0,0 +1,260 @@
+=3D=3D Commit tests =3D=3D
+Formatting 'TEST_DIR/PID-base', fmt=3Dqcow2 size=3D2097152 cluster_size=3D=
65536 lazy_refcounts=3Doff refcount_bits=3D16
+
+Formatting 'TEST_DIR/PID-mid', fmt=3Dqcow2 size=3D1048576 backing_file=3DT=
EST_DIR/PID-base cluster_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D=
16
+
+Formatting 'TEST_DIR/PID-top', fmt=3Dqcow2 size=3D2097152 backing_file=3DT=
EST_DIR/PID-mid cluster_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D1=
6
+
+wrote 2097152/2097152 bytes at offset 0
+2 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+=3D=3D=3D Check visible data =3D=3D=3D
+read 1048576/1048576 bytes at offset 0
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+read 1048576/1048576 bytes at offset 1048576
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+=3D=3D=3D Checking allocation status =3D=3D=3D
+1048576/1048576 bytes allocated at offset 0 bytes
+1048576/1048576 bytes allocated at offset 1 MiB
+
+0/1048576 bytes allocated at offset 0 bytes
+0/0 bytes allocated at offset 1 MiB
+
+0/1048576 bytes allocated at offset 0 bytes
+0/1048576 bytes allocated at offset 1 MiB
+
+=3D=3D=3D Checking map =3D=3D=3D
+[{ "start": 0, "length": 2097152, "depth": 0, "zero": false, "data": true,=
 "offset": 327680}]
+
+Offset          Length          Mapped to       File
+0               0x200000        0x50000         TEST_DIR/PID-base
+
+[{ "start": 0, "length": 1048576, "depth": 1, "zero": false, "data": true,=
 "offset": 327680}]
+
+Offset          Length          Mapped to       File
+0               0x100000        0x50000         TEST_DIR/PID-base
+
+[{ "start": 0, "length": 1048576, "depth": 2, "zero": false, "data": true,=
 "offset": 327680},
+{ "start": 1048576, "length": 1048576, "depth": 0, "zero": true, "data": f=
alse}]
+
+Offset          Length          Mapped to       File
+0               0x100000        0x50000         TEST_DIR/PID-base
+
+=3D=3D=3D Testing qemu-img commit (top -> mid) =3D=3D=3D
+Image committed.
+
+image: TEST_IMG
+file format: IMGFMT
+virtual size: 2 MiB (2097152 bytes)
+cluster_size: 65536
+backing file: TEST_DIR/PID-base
+Format specific information:
+    compat: 1.1
+    lazy refcounts: false
+    refcount bits: 16
+    corrupt: false
+
+read 1048576/1048576 bytes at offset 0
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+read 1048576/1048576 bytes at offset 1048576
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+=3D=3D=3D Testing HMP commit (top -> mid) =3D=3D=3D
+Formatting 'TEST_DIR/PID-base', fmt=3Dqcow2 size=3D2097152 cluster_size=3D=
65536 lazy_refcounts=3Doff refcount_bits=3D16
+
+Formatting 'TEST_DIR/PID-mid', fmt=3Dqcow2 size=3D1048576 backing_file=3DT=
EST_DIR/PID-base cluster_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D=
16
+
+Formatting 'TEST_DIR/PID-top', fmt=3Dqcow2 size=3D2097152 backing_file=3DT=
EST_DIR/PID-mid cluster_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D1=
6
+
+wrote 2097152/2097152 bytes at offset 0
+2 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+{"execute": "human-monitor-command", "arguments": {"command-line": "commit=
 drive0"}}
+{"return": ""}
+image: TEST_IMG
+file format: IMGFMT
+virtual size: 2 MiB (2097152 bytes)
+cluster_size: 65536
+backing file: TEST_DIR/PID-base
+Format specific information:
+    compat: 1.1
+    lazy refcounts: false
+    refcount bits: 16
+    corrupt: false
+
+read 1048576/1048576 bytes at offset 0
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+read 1048576/1048576 bytes at offset 1048576
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+=3D=3D=3D Testing QMP active commit (top -> mid) =3D=3D=3D
+Formatting 'TEST_DIR/PID-base', fmt=3Dqcow2 size=3D2097152 cluster_size=3D=
65536 lazy_refcounts=3Doff refcount_bits=3D16
+
+Formatting 'TEST_DIR/PID-mid', fmt=3Dqcow2 size=3D1048576 backing_file=3DT=
EST_DIR/PID-base cluster_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D=
16
+
+Formatting 'TEST_DIR/PID-top', fmt=3Dqcow2 size=3D2097152 backing_file=3DT=
EST_DIR/PID-mid cluster_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D1=
6
+
+wrote 2097152/2097152 bytes at offset 0
+2 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+{"execute": "block-commit", "arguments": {"auto-dismiss": false, "base-nod=
e": "mid", "device": "top", "job-id": "job0"}}
+{"return": {}}
+{"execute": "job-complete", "arguments": {"id": "job0"}}
+{"return": {}}
+{"data": {"device": "job0", "len": 0, "offset": 0, "speed": 0, "type": "co=
mmit"}, "event": "BLOCK_JOB_READY", "timestamp": {"microseconds": "USECS", =
"seconds": "SECS"}}
+{"data": {"device": "job0", "len": 0, "offset": 0, "speed": 0, "type": "co=
mmit"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USEC=
S", "seconds": "SECS"}}
+{"execute": "job-dismiss", "arguments": {"id": "job0"}}
+{"return": {}}
+image: TEST_IMG
+file format: IMGFMT
+virtual size: 2 MiB (2097152 bytes)
+cluster_size: 65536
+backing file: TEST_DIR/PID-base
+Format specific information:
+    compat: 1.1
+    lazy refcounts: false
+    refcount bits: 16
+    corrupt: false
+
+read 1048576/1048576 bytes at offset 0
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+read 1048576/1048576 bytes at offset 1048576
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+=3D=3D Resize tests =3D=3D
+=3D=3D=3D preallocation=3Doff =3D=3D=3D
+Formatting 'TEST_DIR/PID-base', fmt=3Dqcow2 size=3D6442450944 cluster_size=
=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
+
+Formatting 'TEST_DIR/PID-top', fmt=3Dqcow2 size=3D1073741824 backing_file=
=3DTEST_DIR/PID-base cluster_size=3D65536 lazy_refcounts=3Doff refcount_bit=
s=3D16
+
+wrote 65536/65536 bytes at offset 5368709120
+64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+Image resized.
+
+read 65536/65536 bytes at offset 5368709120
+64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+1 GiB (0x40000000) bytes not allocated at offset 0 bytes (0x0)
+7 GiB (0x1c0000000) bytes     allocated at offset 1 GiB (0x40000000)
+
+[{ "start": 0, "length": 1073741824, "depth": 1, "zero": true, "data": fal=
se},
+{ "start": 1073741824, "length": 7516192768, "depth": 0, "zero": true, "da=
ta": false}]
+
+=3D=3D=3D preallocation=3Dmetadata =3D=3D=3D
+Formatting 'TEST_DIR/PID-base', fmt=3Dqcow2 size=3D34359738368 cluster_siz=
e=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
+
+Formatting 'TEST_DIR/PID-top', fmt=3Dqcow2 size=3D32212254720 backing_file=
=3DTEST_DIR/PID-base cluster_size=3D65536 lazy_refcounts=3Doff refcount_bit=
s=3D16
+
+wrote 65536/65536 bytes at offset 33285996544
+64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+Image resized.
+
+read 65536/65536 bytes at offset 33285996544
+64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+30 GiB (0x780000000) bytes not allocated at offset 0 bytes (0x0)
+3 GiB (0xc0000000) bytes     allocated at offset 30 GiB (0x780000000)
+
+=3D=3D=3D preallocation=3Dfalloc =3D=3D=3D
+Formatting 'TEST_DIR/PID-base', fmt=3Dqcow2 size=3D10485760 cluster_size=
=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
+
+Formatting 'TEST_DIR/PID-top', fmt=3Dqcow2 size=3D5242880 backing_file=3DT=
EST_DIR/PID-base cluster_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D=
16
+
+wrote 65536/65536 bytes at offset 9437184
+64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+Image resized.
+
+read 65536/65536 bytes at offset 9437184
+64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+5 MiB (0x500000) bytes not allocated at offset 0 bytes (0x0)
+10 MiB (0xa00000) bytes     allocated at offset 5 MiB (0x500000)
+
+[{ "start": 0, "length": 5242880, "depth": 1, "zero": true, "data": false}=
,
+{ "start": 5242880, "length": 10485760, "depth": 0, "zero": true, "data": =
false, "offset": 327680}]
+
+=3D=3D=3D preallocation=3Dfull =3D=3D=3D
+Formatting 'TEST_DIR/PID-base', fmt=3Dqcow2 size=3D16777216 cluster_size=
=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
+
+Formatting 'TEST_DIR/PID-top', fmt=3Dqcow2 size=3D8388608 backing_file=3DT=
EST_DIR/PID-base cluster_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D=
16
+
+wrote 65536/65536 bytes at offset 11534336
+64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+Image resized.
+
+read 65536/65536 bytes at offset 11534336
+64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+8 MiB (0x800000) bytes not allocated at offset 0 bytes (0x0)
+4 MiB (0x400000) bytes     allocated at offset 8 MiB (0x800000)
+
+[{ "start": 0, "length": 8388608, "depth": 1, "zero": true, "data": false}=
,
+{ "start": 8388608, "length": 4194304, "depth": 0, "zero": true, "data": f=
alse, "offset": 327680}]
+
+=3D=3D=3D preallocation=3Doff =3D=3D=3D
+Formatting 'TEST_DIR/PID-base', fmt=3Dqcow2 size=3D393216 cluster_size=3D6=
5536 lazy_refcounts=3Doff refcount_bits=3D16
+
+Formatting 'TEST_DIR/PID-top', fmt=3Dqcow2 size=3D259072 backing_file=3DTE=
ST_DIR/PID-base cluster_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D1=
6
+
+wrote 65536/65536 bytes at offset 259072
+64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+Image resized.
+
+read 65536/65536 bytes at offset 259072
+64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+192 KiB (0x30000) bytes not allocated at offset 0 bytes (0x0)
+320 KiB (0x50000) bytes     allocated at offset 192 KiB (0x30000)
+
+[{ "start": 0, "length": 196608, "depth": 1, "zero": true, "data": false},
+{ "start": 196608, "length": 65536, "depth": 0, "zero": false, "data": tru=
e, "offset": 327680},
+{ "start": 262144, "length": 262144, "depth": 0, "zero": true, "data": fal=
se}]
+
+=3D=3D=3D preallocation=3Doff =3D=3D=3D
+Formatting 'TEST_DIR/PID-base', fmt=3Dqcow2 size=3D409600 cluster_size=3D6=
5536 lazy_refcounts=3Doff refcount_bits=3D16
+
+Formatting 'TEST_DIR/PID-top', fmt=3Dqcow2 size=3D262144 backing_file=3DTE=
ST_DIR/PID-base cluster_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D1=
6
+
+wrote 65536/65536 bytes at offset 344064
+64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+Image resized.
+
+read 65536/65536 bytes at offset 344064
+64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+256 KiB (0x40000) bytes not allocated at offset 0 bytes (0x0)
+256 KiB (0x40000) bytes     allocated at offset 256 KiB (0x40000)
+
+[{ "start": 0, "length": 262144, "depth": 1, "zero": true, "data": false},
+{ "start": 262144, "length": 262144, "depth": 0, "zero": true, "data": fal=
se}]
+
+=3D=3D=3D preallocation=3Doff =3D=3D=3D
+Formatting 'TEST_DIR/PID-base', fmt=3Dqcow2 size=3D524288 cluster_size=3D6=
5536 lazy_refcounts=3Doff refcount_bits=3D16
+
+Formatting 'TEST_DIR/PID-top', fmt=3Dqcow2 size=3D262144 backing_file=3DTE=
ST_DIR/PID-base cluster_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D1=
6
+
+wrote 65536/65536 bytes at offset 446464
+64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+Image resized.
+
+read 65536/65536 bytes at offset 446464
+64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+256 KiB (0x40000) bytes not allocated at offset 0 bytes (0x0)
+244 KiB (0x3d000) bytes     allocated at offset 256 KiB (0x40000)
+
+[{ "start": 0, "length": 262144, "depth": 1, "zero": true, "data": false},
+{ "start": 262144, "length": 249856, "depth": 0, "zero": true, "data": fal=
se}]
+
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index 435dccd5af..1710470e70 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -286,6 +286,7 @@
 270 rw backing quick
 272 rw
 273 backing quick
+274 rw backing
 277 rw quick
 279 rw backing quick
 280 rw migration quick
--=20
2.25.3


