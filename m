Return-Path: <SRS0=q9Vo=YU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4CDCCA9EAF
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Oct 2019 14:52:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 939B9214AF
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Oct 2019 14:52:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 939B9214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45546 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iOjty-00022T-Pk
	for qemu-devel@archiver.kernel.org; Sun, 27 Oct 2019 10:52:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35047)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1iOjqq-0006qM-L6
 for qemu-devel@nongnu.org; Sun, 27 Oct 2019 10:49:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1iOjqo-0005BL-7z
 for qemu-devel@nongnu.org; Sun, 27 Oct 2019 10:49:04 -0400
Received: from relay.sw.ru ([185.231.240.75]:55256)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1iOjqm-00057P-In; Sun, 27 Oct 2019 10:49:00 -0400
Received: from [172.16.25.136] (helo=dhcp-172-16-25-136.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92.2)
 (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1iOjqh-0000Zq-Rh; Sun, 27 Oct 2019 17:48:55 +0300
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Subject: [PATCH] iotests: Test nbd client reconnect
Date: Sun, 27 Oct 2019 17:48:45 +0300
Message-Id: <1572187725-685325-1-git-send-email-andrey.shinkevich@virtuozzo.com>
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

The stress test for an NBD client. The NBD server is disconnected after
a client write operation. The NBD client should reconnect and retry the
operation.

Suggested-by: Denis V. Lunev <den@openvz.org>
Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
---
 tests/qemu-iotests/277     | 91 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/277.out |  7 ++++
 tests/qemu-iotests/group   |  1 +
 3 files changed, 99 insertions(+)
 create mode 100755 tests/qemu-iotests/277
 create mode 100644 tests/qemu-iotests/277.out

diff --git a/tests/qemu-iotests/277 b/tests/qemu-iotests/277
new file mode 100755
index 0000000..46a29b7
--- /dev/null
+++ b/tests/qemu-iotests/277
@@ -0,0 +1,91 @@
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
+import io
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
+        log('NBD server: {}'.format(line.rstrip()))
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
+disk, nbd_sock = file_path('disk', 'nbd-sock')
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
+clt = subprocess.Popen(args, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
+
+check_server_NBD(srv)
+
+make_conf_file(conf_file, "reply")
+srv = start_server_NBD(nbd_sock, conf_file)
+
+exitcode = clt.wait(timeout=10)
+if exitcode < 0:
+    sys.stderr.write('qemu-io received signal %i: %s\n' %
+                     (-exitcode, ' '.join(args)))
+
+for line in io.TextIOWrapper(clt.stdout, encoding="utf-8"):
+    if "3 MiB" not in line:
+        log('NBD client: ' + line.rstrip())
+
+check_server_NBD(srv)
diff --git a/tests/qemu-iotests/277.out b/tests/qemu-iotests/277.out
new file mode 100644
index 0000000..07e6e82
--- /dev/null
+++ b/tests/qemu-iotests/277.out
@@ -0,0 +1,7 @@
+NBD server: started
+NBD client: QEMU-IO write
+NBD server: Closing connection on rule match inject-error
+NBD server: started
+NBD client: Connection closed
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
-- 
1.8.3.1


