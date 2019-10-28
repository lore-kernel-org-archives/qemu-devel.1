Return-Path: <SRS0=Szrt=YV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8548CA9EBC
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 10:20:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA801208C0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 10:20:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA801208C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52324 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iP28n-0000XD-VA
	for qemu-devel@archiver.kernel.org; Mon, 28 Oct 2019 06:20:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37375)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1iP26s-0006yn-9z
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 06:18:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1iP26q-0001w4-NH
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 06:18:50 -0400
Received: from relay.sw.ru ([185.231.240.75]:36864)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1iP26q-0001qS-FQ; Mon, 28 Oct 2019 06:18:48 -0400
Received: from [172.16.25.136] (helo=dhcp-172-16-25-136.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92.2)
 (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1iP26m-0004LE-S5; Mon, 28 Oct 2019 13:18:44 +0300
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Subject: [PATCH v2] iotests: Test NBD client reconnect
Date: Mon, 28 Oct 2019 13:18:34 +0300
Message-Id: <1572257914-721135-1-git-send-email-andrey.shinkevich@virtuozzo.com>
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
client write operation. The NBD client should reconnect and retry
the operation.

Suggested-by: Denis V. Lunev <den@openvz.org>
Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
---
 tests/qemu-iotests/277                   | 94 ++++++++++++++++++++++++++++++++
 tests/qemu-iotests/277.out               |  7 +++
 tests/qemu-iotests/group                 |  1 +
 tests/qemu-iotests/nbd-fault-injector.py |  3 +-
 4 files changed, 104 insertions(+), 1 deletion(-)
 create mode 100755 tests/qemu-iotests/277
 create mode 100644 tests/qemu-iotests/277.out

diff --git a/tests/qemu-iotests/277 b/tests/qemu-iotests/277
new file mode 100755
index 0000000..2fca565
--- /dev/null
+++ b/tests/qemu-iotests/277
@@ -0,0 +1,94 @@
+#!/usr/bin/env python
+#
+# Test nbd client reconnect
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
+import sys
+import subprocess
+import iotests
+from iotests import file_path, log
+
+
+def start_server_NBD(nbd_sock, conf_file):
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
+def check_server_NBD(srv):
+    exitcode = srv.wait(timeout=10)
+
+    if exitcode < 0:
+        sys.stderr.write('NBD server: ERROR %i\n' % (-exitcode))
+        log(srv.communicate()[0])
+    else:
+        line = srv.stdout.readline()
+        log('NBD server: ' + line.rstrip())
+
+    os.remove(nbd_sock)
+    os.remove(conf_file)
+
+
+def make_conf_file(conf_file, event):
+    if os.path.exists(conf_file):
+        os.remove(conf_file)
+
+    with open(conf_file, "w+") as conff:
+        conff.write("[inject-error]\nevent={}\nwhen=after".format(event))
+
+
+nbd_sock = file_path('nbd-sock')
+nbd_uri = 'nbd+unix:///?socket=' + nbd_sock
+if os.path.exists(nbd_sock):
+    os.remove(nbd_sock)
+
+conf_file = os.path.join(iotests.test_dir, "nbd-fault-injector.conf")
+make_conf_file(conf_file, "data")
+srv = start_server_NBD(nbd_sock, conf_file)
+
+log('NBD client: QEMU-IO write')
+args = iotests.qemu_io_args + ['-f', 'raw', '-c', 'write -P 0x7 0 3M', nbd_uri]
+clt = subprocess.Popen(args, stdout=subprocess.PIPE, stderr=subprocess.STDOUT,
+                       universal_newlines=True)
+
+check_server_NBD(srv)
+
+line = clt.stdout.readline()
+log('NBD client: ' + line.rstrip())
+
+make_conf_file(conf_file, "reply")
+srv = start_server_NBD(nbd_sock, conf_file)
+
+exitcode = clt.wait(timeout=10)
+if exitcode < 0:
+    sys.stderr.write('qemu-io received signal %i: %s\n' %
+                     (-exitcode, ' '.join(args)))
+    log(clt.communicate()[0])
+else:
+    line = clt.stdout.readline()
+    log('NBD client: ' + line.rstrip())
+
+check_server_NBD(srv)
diff --git a/tests/qemu-iotests/277.out b/tests/qemu-iotests/277.out
new file mode 100644
index 0000000..f899b6c
--- /dev/null
+++ b/tests/qemu-iotests/277.out
@@ -0,0 +1,7 @@
+NBD server: started
+NBD client: QEMU-IO write
+NBD server: Closing connection on rule match inject-error
+NBD client: Connection closed
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


