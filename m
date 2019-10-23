Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63FD1CA9EA0
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 02:05:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29B2F2086D
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 02:05:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="efOJ/ixX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29B2F2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51092 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iN61r-0004xp-B3
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 22:05:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44771)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iN5y1-00015R-0q
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 22:01:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iN5xy-0008NI-Aj
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 22:01:40 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:31801
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1iN5xx-0008Mz-Vx
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 22:01:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571796097;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iiSRtTNLZaRPcBmMm2ZxL5C9AdBFlWyqaDexDBpSSEM=;
 b=efOJ/ixX3HrbfNjwrysCM5GyKmQ2/dR0cqm9C/61c/7OKjweUhdBEIlA6Mp4FSHd3WqZUA
 KwdxcO63sBLU0B/grL5+WbZgE3iFQ3ExhaSHcMklkKnIphQL4d3FUf1qHiA2/aqHCDYLLO
 YMRA5l/LMa4u9mAyJWQuIocpJG/bxmU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-257-PzKEYUU3PiK1zbGWUUFrDg-1; Tue, 22 Oct 2019 22:01:35 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 987D5107AD33;
 Wed, 23 Oct 2019 02:01:34 +0000 (UTC)
Received: from blue.redhat.com (ovpn-117-0.phx2.redhat.com [10.3.117.0])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2295E6012D;
 Wed, 23 Oct 2019 02:01:34 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 3/3] iotests: test nbd reconnect
Date: Tue, 22 Oct 2019 21:01:26 -0500
Message-Id: <20191023020126.24991-4-eblake@redhat.com>
In-Reply-To: <20191023020126.24991-1-eblake@redhat.com>
References: <20191023020126.24991-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: PzKEYUU3PiK1zbGWUUFrDg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Add test, which starts backup to nbd target and restarts nbd server
during backup.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-Id: <20191009084158.15614-4-vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 tests/qemu-iotests/264        | 95 +++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/264.out    | 13 +++++
 tests/qemu-iotests/group      |  1 +
 tests/qemu-iotests/iotests.py | 11 ++++
 4 files changed, 120 insertions(+)
 create mode 100755 tests/qemu-iotests/264
 create mode 100644 tests/qemu-iotests/264.out

diff --git a/tests/qemu-iotests/264 b/tests/qemu-iotests/264
new file mode 100755
index 000000000000..c8cd97ae2b74
--- /dev/null
+++ b/tests/qemu-iotests/264
@@ -0,0 +1,95 @@
+#!/usr/bin/env python
+#
+# Test nbd reconnect
+#
+# Copyright (c) 2019 Virtuozzo International GmbH.
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
+import time
+
+import iotests
+from iotests import qemu_img_create, qemu_io_silent_check, file_path, \
+        qemu_nbd_popen, log
+
+disk_a, disk_b, nbd_sock =3D file_path('disk_a', 'disk_b', 'nbd-sock')
+nbd_uri =3D 'nbd+unix:///?socket=3D' + nbd_sock
+size =3D 5 * 1024 * 1024
+wait_limit =3D 3
+wait_step =3D 0.2
+
+qemu_img_create('-f', iotests.imgfmt, disk_a, str(size))
+qemu_img_create('-f', iotests.imgfmt, disk_b, str(size))
+srv =3D qemu_nbd_popen('-k', nbd_sock, '-f', iotests.imgfmt, disk_b)
+
+# Wait for NBD server availability
+t =3D 0
+ok =3D False
+while t < wait_limit:
+    ok =3D qemu_io_silent_check('-f', 'raw', '-c', 'read 0 512', nbd_uri)
+    if ok:
+        break
+    time.sleep(wait_step)
+    t +=3D wait_step
+
+assert ok
+
+vm =3D iotests.VM().add_drive(disk_a)
+vm.launch()
+vm.hmp_qemu_io('drive0', 'write 0 {}'.format(size))
+
+vm.qmp_log('blockdev-add', filters=3D[iotests.filter_qmp_testfiles],
+           **{'node_name': 'backup0',
+              'driver': 'raw',
+              'file': {'driver': 'nbd',
+                       'server': {'type': 'unix', 'path': nbd_sock},
+                       'reconnect-delay': 10}})
+vm.qmp_log('blockdev-backup', device=3D'drive0', sync=3D'full', target=3D'=
backup0',
+           speed=3D(1 * 1024 * 1024))
+
+# Wait for some progress
+t =3D 0
+while t < wait_limit:
+    jobs =3D vm.qmp('query-block-jobs')['return']
+    if jobs and jobs[0]['offset'] > 0:
+        break
+    time.sleep(wait_step)
+    t +=3D wait_step
+
+if jobs and jobs[0]['offset'] > 0:
+    log('Backup job is started')
+
+log('Kill NBD server')
+srv.kill()
+srv.wait()
+
+jobs =3D vm.qmp('query-block-jobs')['return']
+if jobs and jobs[0]['offset'] < jobs[0]['len']:
+    log('Backup job is still in progress')
+
+vm.qmp_log('block-job-set-speed', device=3D'drive0', speed=3D0)
+
+# Emulate server down time for 1 second
+time.sleep(1)
+
+log('Start NBD server')
+srv =3D qemu_nbd_popen('-k', nbd_sock, '-f', iotests.imgfmt, disk_b)
+
+e =3D vm.event_wait('BLOCK_JOB_COMPLETED')
+log('Backup completed: {}'.format(e['data']['offset']))
+
+vm.qmp_log('blockdev-del', node_name=3D'backup0')
+srv.kill()
+vm.shutdown()
diff --git a/tests/qemu-iotests/264.out b/tests/qemu-iotests/264.out
new file mode 100644
index 000000000000..3000944b099a
--- /dev/null
+++ b/tests/qemu-iotests/264.out
@@ -0,0 +1,13 @@
+{"execute": "blockdev-add", "arguments": {"driver": "raw", "file": {"drive=
r": "nbd", "reconnect-delay": 10, "server": {"path": "TEST_DIR/PID-nbd-sock=
", "type": "unix"}}, "node-name": "backup0"}}
+{"return": {}}
+{"execute": "blockdev-backup", "arguments": {"device": "drive0", "speed": =
1048576, "sync": "full", "target": "backup0"}}
+{"return": {}}
+Backup job is started
+Kill NBD server
+Backup job is still in progress
+{"execute": "block-job-set-speed", "arguments": {"device": "drive0", "spee=
d": 0}}
+{"return": {}}
+Start NBD server
+Backup completed: 5242880
+{"execute": "blockdev-del", "arguments": {"node-name": "backup0"}}
+{"return": {}}
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index a73df279e5ee..af322af75683 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -276,6 +276,7 @@
 260 rw quick
 262 rw quick migration
 263 rw quick
+264 rw
 265 rw auto quick
 266 rw quick
 267 rw auto quick snapshot
diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index 3a8f378f90d3..693fde155a43 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -165,6 +165,13 @@ def qemu_io_silent(*args):
                          (-exitcode, ' '.join(args)))
     return exitcode

+def qemu_io_silent_check(*args):
+    '''Run qemu-io and return the true if subprocess returned 0'''
+    args =3D qemu_io_args + list(args)
+    exitcode =3D subprocess.call(args, stdout=3Dopen('/dev/null', 'w'),
+                               stderr=3Dsubprocess.STDOUT)
+    return exitcode =3D=3D 0
+
 def get_virtio_scsi_device():
     if qemu_default_machine =3D=3D 's390-ccw-virtio':
         return 'virtio-scsi-ccw'
@@ -230,6 +237,10 @@ def qemu_nbd_early_pipe(*args):
     else:
         return exitcode, subp.communicate()[0]

+def qemu_nbd_popen(*args):
+    '''Run qemu-nbd in daemon mode and return the parent's exit code'''
+    return subprocess.Popen(qemu_nbd_args + ['--persistent'] + list(args))
+
 def compare_images(img1, img2, fmt1=3Dimgfmt, fmt2=3Dimgfmt):
     '''Return True if two image files are identical'''
     return qemu_img('compare', '-f', fmt1,
--=20
2.21.0


