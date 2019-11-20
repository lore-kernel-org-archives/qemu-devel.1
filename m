Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B775CC432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 14:10:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7054B2230F
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 14:10:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GfTlYsyK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7054B2230F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58500 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXQga-0007qU-Hv
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 09:10:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47426)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iXQaQ-0006bW-4O
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 09:04:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iXQaN-0000wb-SP
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 09:04:01 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:32158
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1iXQaN-0000wJ-N5
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 09:03:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574258639;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RsNlEvxTRmcP+MdbECcLdHWspCLvIsRQJe1Q/mpB4a4=;
 b=GfTlYsyKdlLtly0C8DLDNXGTxHgP3DO2w0COyVQEF/nnl4H9xaK2jjR0tyJqoAqEYrf98v
 /Oic6aJ6/+ulC9l9LjPRbqtr+k2xOyBs9uNInKz1ac+myfBkhie3gWuPAL6N3vwbU2lGMS
 oPuMXC3N2UceIJHm/5T7kH0Cn8WcoFo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-58-bWF8f7uXP9-ud6LSNT2KBQ-1; Wed, 20 Nov 2019 09:03:56 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 056BE63CCC;
 Wed, 20 Nov 2019 14:03:55 +0000 (UTC)
Received: from linux.fritz.box.com (unknown [10.36.118.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 71DD960BB5;
 Wed, 20 Nov 2019 14:03:53 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 6/6] iotests: Test committing to short backing file
Date: Wed, 20 Nov 2019 15:03:19 +0100
Message-Id: <20191120140319.1505-7-kwolf@redhat.com>
In-Reply-To: <20191120140319.1505-1-kwolf@redhat.com>
References: <20191120140319.1505-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: bWF8f7uXP9-ud6LSNT2KBQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, qemu-devel@nongnu.org,
 mreitz@redhat.com, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/274        | 131 +++++++++++++++++++++++++++++
 tests/qemu-iotests/274.out    | 150 ++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/group      |   1 +
 tests/qemu-iotests/iotests.py |   2 +-
 4 files changed, 283 insertions(+), 1 deletion(-)
 create mode 100755 tests/qemu-iotests/274
 create mode 100644 tests/qemu-iotests/274.out

diff --git a/tests/qemu-iotests/274 b/tests/qemu-iotests/274
new file mode 100755
index 0000000000..f3b71e2859
--- /dev/null
+++ b/tests/qemu-iotests/274
@@ -0,0 +1,131 @@
+#!/usr/bin/env python
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
+    iotests.qemu_img_log('create', '-f', iotests.imgfmt, base, '6G')
+    iotests.qemu_img_log('create', '-f', iotests.imgfmt, '-b', base, top, =
'1G')
+    iotests.qemu_io_log('-c', 'write -P 1 3G 64k', base)
+    iotests.qemu_io_log('-c', 'write -P 2 5G 64k', base)
+
+    # After this, 0 to 6 GB should be allocated/zeroed
+    # 6 GB to 8 BG should be unallocated
+    iotests.qemu_img_log('resize', '-f', iotests.imgfmt, top, '8G')
+    iotests.qemu_io_log('-c', 'read -P 0 3G 64k', top)
+    iotests.qemu_io_log('-c', 'read -P 0 5G 64k', top)
+    iotests.qemu_img_log('map', '--output=3Djson', top)
diff --git a/tests/qemu-iotests/274.out b/tests/qemu-iotests/274.out
new file mode 100644
index 0000000000..def0ac7d27
--- /dev/null
+++ b/tests/qemu-iotests/274.out
@@ -0,0 +1,150 @@
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
+Formatting 'TEST_DIR/PID-base', fmt=3Dqcow2 size=3D6442450944 cluster_size=
=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
+
+Formatting 'TEST_DIR/PID-top', fmt=3Dqcow2 size=3D1073741824 backing_file=
=3DTEST_DIR/PID-base cluster_size=3D65536 lazy_refcounts=3Doff refcount_bit=
s=3D16
+
+wrote 65536/65536 bytes at offset 3221225472
+64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+wrote 65536/65536 bytes at offset 5368709120
+64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+Image resized.
+
+read 65536/65536 bytes at offset 3221225472
+64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+read 65536/65536 bytes at offset 5368709120
+64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+[{ "start": 0, "length": 1073741824, "depth": 1, "zero": true, "data": fal=
se},
+{ "start": 1073741824, "length": 7516192768, "depth": 0, "zero": true, "da=
ta": false}]
+
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index c56bb69031..329c9e4d37 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -285,3 +285,4 @@
 270 rw backing quick
 272 rw
 273 backing quick
+274 rw backing quick
diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index c4063ef6bb..5fd6d820b1 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -144,7 +144,7 @@ def img_info_log(filename, filter_path=3DNone, imgopts=
=3DFalse, extra_args=3D[]):
     output =3D qemu_img_pipe(*args)
     if not filter_path:
         filter_path =3D filename
-    log(filter_img_info(output, filter_path))
+    log(filter_img_info(output, filter_path), filters=3D[filter_testfiles]=
)
=20
 def qemu_io(*args):
     '''Run qemu-io and return the stdout data'''
--=20
2.20.1


