Return-Path: <SRS0=V8KP=YZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA7F4CA9ECF
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2019 16:55:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E8AB2080F
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2019 16:55:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E8AB2080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41484 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iQaD6-0005KG-LD
	for qemu-devel@archiver.kernel.org; Fri, 01 Nov 2019 12:55:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38298)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1iQaCF-0004Xa-H5
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 12:54:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1iQaCD-0001SZ-Ub
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 12:54:47 -0400
Received: from relay.sw.ru ([185.231.240.75]:45004)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1iQaCD-0001Qh-ND; Fri, 01 Nov 2019 12:54:45 -0400
Received: from [172.16.25.136] (helo=dhcp-172-16-25-136.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92.3)
 (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1iQaC9-000771-FX; Fri, 01 Nov 2019 19:54:41 +0300
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Subject: [PATCH v3] iotests: Test NBD client reconnection
Date: Fri,  1 Nov 2019 19:54:32 +0300
Message-Id: <1572627272-23359-1-git-send-email-andrey.shinkevich@virtuozzo.com>
X-Mailer: git-send-email 1.8.3.1
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 185.231.240.75
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, mreitz@redhat.com,
 andrey.shinkevich@virtuozzo.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The test for an NBD client. The NBD server is disconnected after the
client write request. The NBD client should reconnect and complete
the write operation.

Suggested-by: Denis V. Lunev <den@openvz.org>
Suggested-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
---
 tests/qemu-iotests/277                   | 102 +++++++++++++++++++++++++++++++
 tests/qemu-iotests/277.out               |   6 ++
 tests/qemu-iotests/group                 |   1 +
 tests/qemu-iotests/iotests.py            |   5 ++
 tests/qemu-iotests/nbd-fault-injector.py |   3 +-
 5 files changed, 116 insertions(+), 1 deletion(-)
 create mode 100755 tests/qemu-iotests/277
 create mode 100644 tests/qemu-iotests/277.out

diff --git a/tests/qemu-iotests/277 b/tests/qemu-iotests/277
new file mode 100755
index 0000000..e4e6730
--- /dev/null
+++ b/tests/qemu-iotests/277
@@ -0,0 +1,102 @@
+#!/usr/bin/env python
+#
+# Test NBD client reconnection
+#
+# Copyright (c) 2019 Virtuozzo International GmbH
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
+import os
+import subprocess
+import iotests
+from iotests import file_path, log
+
+
+def make_conf_file(event):
+    """
+    Create configuration file for the nbd-fault-injector.py
+
+    :param event: which event the server should close a connection on
+    """
+    if os.path.exists(conf_file):
+        os.remove(conf_file)
+
+    with open(conf_file, "w+") as conff:
+        conff.write("[inject-error]\nevent={}\nwhen=after".format(event))
+
+
+def start_server_NBD(event):
+    make_conf_file(event)
+
+    srv = subprocess.Popen(["nbd-fault-injector.py", "--classic-negotiation",
+                           nbd_sock, conf_file], stdout=subprocess.PIPE,
+                           stderr=subprocess.STDOUT, universal_newlines=True)
+    line = srv.stdout.readline()
+    if "Listening on " in line:
+        log('NBD server: started')
+    else:
+        log('NBD server: ' + line.rstrip())
+
+    return srv
+
+
+def start_client_NBD():
+    log('NBD client: QEMU-IO write')
+    args = iotests.qemu_io_args_no_fmt + \
+        ['-c', 'write -P 0x7 0 3M', '--image-opts',
+         'driver=nbd,server.type=unix,server.path={},'
+         'reconnect-delay=7'.format(nbd_sock)]
+    clt = subprocess.Popen(args, stdout=subprocess.PIPE,
+                           stderr=subprocess.STDOUT,
+                           universal_newlines=True)
+    return clt
+
+
+def check_proc_NBD(proc, connector):
+    try:
+        exitcode = proc.wait(timeout=10)
+
+        if exitcode < 0:
+            log('NBD {}: EXIT SIGNAL {}\n'.format(connector, -exitcode))
+            log(proc.communicate()[0])
+        else:
+            line = proc.stdout.readline()
+            log('NBD {}: {}'.format(connector, line.rstrip()))
+
+    except subprocess.TimeoutExpired:
+        proc.kill()
+        log('NBD {}: ERROR timeout expired'.format(connector))
+    finally:
+        if connector == 'server':
+            os.remove(nbd_sock)
+            os.remove(conf_file)
+
+
+conf_file = os.path.join(iotests.test_dir, "nbd-fault-injector.conf")
+nbd_sock = file_path('nbd-sock')
+nbd_uri = 'nbd+unix:///?socket=' + nbd_sock
+if os.path.exists(nbd_sock):
+    os.remove(nbd_sock)
+
+srv = start_server_NBD('data')
+clt = start_client_NBD()
+# The server should close the connection after a client write request
+check_proc_NBD(srv, 'server')
+# Start the NBD server again
+srv = start_server_NBD('reply')
+# The client should reconnect and complete the write operation
+check_proc_NBD(clt, 'client')
+# Make it sure that server terminated
+check_proc_NBD(srv, 'server')
diff --git a/tests/qemu-iotests/277.out b/tests/qemu-iotests/277.out
new file mode 100644
index 0000000..45404b3
--- /dev/null
+++ b/tests/qemu-iotests/277.out
@@ -0,0 +1,6 @@
+NBD server: started
+NBD client: QEMU-IO write
+NBD server: Closing connection on rule match inject-error
+NBD server: started
+NBD client: wrote 3145728/3145728 bytes at offset 0
+NBD server: Closing connection on rule match inject-error
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index af322af..22ef1b8 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -282,3 +282,4 @@
 267 rw auto quick snapshot
 268 rw auto quick
 270 rw backing quick
+277 rw
diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index 709def4..0d16303 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -47,6 +47,11 @@ qemu_io_args = [os.environ.get('QEMU_IO_PROG', 'qemu-io')]
 if os.environ.get('QEMU_IO_OPTIONS'):
     qemu_io_args += os.environ['QEMU_IO_OPTIONS'].strip().split(' ')
 
+qemu_io_args_no_fmt = [os.environ.get('QEMU_IO_PROG', 'qemu-io')]
+if os.environ.get('QEMU_IO_OPTIONS_NO_FMT'):
+    qemu_io_args_no_fmt += \
+        os.environ['QEMU_IO_OPTIONS_NO_FMT'].strip().split(' ')
+
 qemu_nbd_args = [os.environ.get('QEMU_NBD_PROG', 'qemu-nbd')]
 if os.environ.get('QEMU_NBD_OPTIONS'):
     qemu_nbd_args += os.environ['QEMU_NBD_OPTIONS'].strip().split(' ')
diff --git a/tests/qemu-iotests/nbd-fault-injector.py b/tests/qemu-iotests/nbd-fault-injector.py
index 6b2d659..7e2dab6 100755
--- a/tests/qemu-iotests/nbd-fault-injector.py
+++ b/tests/qemu-iotests/nbd-fault-injector.py
@@ -115,7 +115,8 @@ class FaultInjectionSocket(object):
             if rule.match(event, io):
                 if rule.when == 0 or bufsize is None:
                     print('Closing connection on rule match %s' % rule.name)
-                    self.sock.flush()
+                    self.sock.close()
+                    sys.stdout.flush()
                     sys.exit(0)
                 if rule.when != -1:
                     return rule.when
-- 
1.8.3.1


