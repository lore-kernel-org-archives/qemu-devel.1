Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63771C433EA
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 15:07:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FD7E204EA
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 15:07:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AlNJ/+di"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FD7E204EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52648 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0RCc-0002bG-Ej
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 11:07:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39838)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1k0R9T-00067M-NP
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 11:04:23 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:56572
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1k0R9Q-0006se-Vy
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 11:04:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595948659;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9gHPdIJ5NKGQI04PaXppH9DfzdHxKKOt0eEbsUplSgQ=;
 b=AlNJ/+divCBdP6m6cv3pSDVdedbRZxANwncRtYG9dHGNiYA1igrLb82PzQtWTf7PezG/a8
 WKpVPii5LBhCLy9k6h8i5Dl/b72Va2M2xc5v1tgh2B79QzlyfMO9YE1s04sg/1F41bXpcM
 pS2OW9HP90L7BzCSgU2DvxYV7NCkEVU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-249-X_HjwuNTMZyXpdAxRgMWTQ-1; Tue, 28 Jul 2020 11:04:15 -0400
X-MC-Unique: X_HjwuNTMZyXpdAxRgMWTQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 54EC710059B6;
 Tue, 28 Jul 2020 15:04:14 +0000 (UTC)
Received: from blue.redhat.com (ovpn-118-248.rdu2.redhat.com [10.10.118.248])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 43E2219741;
 Tue, 28 Jul 2020 15:04:13 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 3/9] iotests: Make qemu_nbd_popen() a contextmanager
Date: Tue, 28 Jul 2020 10:04:01 -0500
Message-Id: <20200728150408.291299-4-eblake@redhat.com>
In-Reply-To: <20200728150408.291299-1-eblake@redhat.com>
References: <20200728150408.291299-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/28 10:28:27
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Nir Soffer <nirsof@gmail.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>, Nir Soffer <nsoffer@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Nir Soffer <nirsof@gmail.com>

Instead of duplicating the code to wait until the server is ready and
remember to terminate the server and wait for it, make it possible to
use like this:

    with qemu_nbd_popen('-k', sock, image):
        # Access image via qemu-nbd socket...

Only test 264 used this helper, but I had to modify the output since it
did not consistently when starting and stopping qemu-nbd.

Signed-off-by: Nir Soffer <nsoffer@redhat.com>
Message-Id: <20200727215846.395443-3-nsoffer@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 tests/qemu-iotests/264        | 72 +++++++++++++----------------------
 tests/qemu-iotests/264.out    |  2 +
 tests/qemu-iotests/iotests.py | 28 +++++++++++++-
 3 files changed, 54 insertions(+), 48 deletions(-)

diff --git a/tests/qemu-iotests/264 b/tests/qemu-iotests/264
index 304a7443d77f..666f164ed8f4 100755
--- a/tests/qemu-iotests/264
+++ b/tests/qemu-iotests/264
@@ -36,48 +36,32 @@ wait_step = 0.2

 qemu_img_create('-f', iotests.imgfmt, disk_a, str(size))
 qemu_img_create('-f', iotests.imgfmt, disk_b, str(size))
-srv = qemu_nbd_popen('-k', nbd_sock, '-f', iotests.imgfmt, disk_b)

-# Wait for NBD server availability
-t = 0
-ok = False
-while t < wait_limit:
-    ok = qemu_io_silent_check('-f', 'raw', '-c', 'read 0 512', nbd_uri)
-    if ok:
-        break
-    time.sleep(wait_step)
-    t += wait_step
+with qemu_nbd_popen('-k', nbd_sock, '-f', iotests.imgfmt, disk_b):
+    vm = iotests.VM().add_drive(disk_a)
+    vm.launch()
+    vm.hmp_qemu_io('drive0', 'write 0 {}'.format(size))

-assert ok
+    vm.qmp_log('blockdev-add', filters=[iotests.filter_qmp_testfiles],
+               **{'node_name': 'backup0',
+                  'driver': 'raw',
+                  'file': {'driver': 'nbd',
+                           'server': {'type': 'unix', 'path': nbd_sock},
+                           'reconnect-delay': 10}})
+    vm.qmp_log('blockdev-backup', device='drive0', sync='full', target='backup0',
+               speed=(1 * 1024 * 1024))

-vm = iotests.VM().add_drive(disk_a)
-vm.launch()
-vm.hmp_qemu_io('drive0', 'write 0 {}'.format(size))
+    # Wait for some progress
+    t = 0
+    while t < wait_limit:
+        jobs = vm.qmp('query-block-jobs')['return']
+        if jobs and jobs[0]['offset'] > 0:
+            break
+        time.sleep(wait_step)
+        t += wait_step

-vm.qmp_log('blockdev-add', filters=[iotests.filter_qmp_testfiles],
-           **{'node_name': 'backup0',
-              'driver': 'raw',
-              'file': {'driver': 'nbd',
-                       'server': {'type': 'unix', 'path': nbd_sock},
-                       'reconnect-delay': 10}})
-vm.qmp_log('blockdev-backup', device='drive0', sync='full', target='backup0',
-           speed=(1 * 1024 * 1024))
-
-# Wait for some progress
-t = 0
-while t < wait_limit:
-    jobs = vm.qmp('query-block-jobs')['return']
     if jobs and jobs[0]['offset'] > 0:
-        break
-    time.sleep(wait_step)
-    t += wait_step
-
-if jobs and jobs[0]['offset'] > 0:
-    log('Backup job is started')
-
-log('Kill NBD server')
-srv.kill()
-srv.wait()
+        log('Backup job is started')

 jobs = vm.qmp('query-block-jobs')['return']
 if jobs and jobs[0]['offset'] < jobs[0]['len']:
@@ -88,12 +72,8 @@ vm.qmp_log('block-job-set-speed', device='drive0', speed=0)
 # Emulate server down time for 1 second
 time.sleep(1)

-log('Start NBD server')
-srv = qemu_nbd_popen('-k', nbd_sock, '-f', iotests.imgfmt, disk_b)
-
-e = vm.event_wait('BLOCK_JOB_COMPLETED')
-log('Backup completed: {}'.format(e['data']['offset']))
-
-vm.qmp_log('blockdev-del', node_name='backup0')
-srv.kill()
-vm.shutdown()
+with qemu_nbd_popen('-k', nbd_sock, '-f', iotests.imgfmt, disk_b):
+    e = vm.event_wait('BLOCK_JOB_COMPLETED')
+    log('Backup completed: {}'.format(e['data']['offset']))
+    vm.qmp_log('blockdev-del', node_name='backup0')
+    vm.shutdown()
diff --git a/tests/qemu-iotests/264.out b/tests/qemu-iotests/264.out
index 3000944b099a..c45b1e81ef26 100644
--- a/tests/qemu-iotests/264.out
+++ b/tests/qemu-iotests/264.out
@@ -1,3 +1,4 @@
+Start NBD server
 {"execute": "blockdev-add", "arguments": {"driver": "raw", "file": {"driver": "nbd", "reconnect-delay": 10, "server": {"path": "TEST_DIR/PID-nbd-sock", "type": "unix"}}, "node-name": "backup0"}}
 {"return": {}}
 {"execute": "blockdev-backup", "arguments": {"device": "drive0", "speed": 1048576, "sync": "full", "target": "backup0"}}
@@ -11,3 +12,4 @@ Start NBD server
 Backup completed: 5242880
 {"execute": "blockdev-del", "arguments": {"node-name": "backup0"}}
 {"return": {}}
+Kill NBD server
diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index 3590ed78a0e4..8f79668435a0 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -28,10 +28,13 @@ import signal
 import struct
 import subprocess
 import sys
+import time
 from typing import (Any, Callable, Dict, Iterable,
                     List, Optional, Sequence, Tuple, TypeVar)
 import unittest

+from contextlib import contextmanager
+
 # pylint: disable=import-error, wrong-import-position
 sys.path.append(os.path.join(os.path.dirname(__file__), '..', '..', 'python'))
 from qemu import qtest
@@ -270,9 +273,30 @@ def qemu_nbd_early_pipe(*args):

     return subp.returncode, output if subp.returncode else ''

+@contextmanager
 def qemu_nbd_popen(*args):
-    '''Run qemu-nbd in daemon mode and return the parent's exit code'''
-    return subprocess.Popen(qemu_nbd_args + ['--persistent'] + list(args))
+    '''Context manager running qemu-nbd within the context'''
+    pid_file = file_path("pid")
+
+    cmd = list(qemu_nbd_args)
+    cmd.extend(('--persistent', '--pid-file', pid_file))
+    cmd.extend(args)
+
+    log('Start NBD server')
+    p = subprocess.Popen(cmd)
+    try:
+        while not os.path.exists(pid_file):
+            if p.poll() is not None:
+                raise RuntimeError(
+                    "qemu-nbd terminated with exit code {}: {}"
+                    .format(p.returncode, ' '.join(cmd)))
+
+            time.sleep(0.01)
+        yield
+    finally:
+        log('Kill NBD server')
+        p.kill()
+        p.wait()

 def compare_images(img1, img2, fmt1=imgfmt, fmt2=imgfmt):
     '''Return True if two image files are identical'''
-- 
2.27.0


