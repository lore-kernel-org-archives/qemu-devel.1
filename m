Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84057C432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 20:19:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E9CA20640
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 20:19:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E9CA20640
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50654 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCrHO-0002XI-Sr
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 16:19:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43739)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iCr8A-0000X6-Vn
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 16:09:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iCr89-0002s1-3M
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 16:09:50 -0400
Received: from relay.sw.ru ([185.231.240.75]:38052)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iCr88-0002r6-PV
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 16:09:48 -0400
Received: from [10.94.3.0] (helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92.2)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1iCr87-0001Mk-G8; Tue, 24 Sep 2019 23:09:47 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 06/25] python: add commit-per-subsystem.py
Date: Tue, 24 Sep 2019 23:08:43 +0300
Message-Id: <20190924200902.4703-7-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190924200902.4703-1-vsementsov@virtuozzo.com>
References: <20190924200902.4703-1-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
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
Cc: vsementsov@virtuozzo.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add script to automatically commit tree-wide changes per-subsystem.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 python/commit-per-subsystem.py | 69 ++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)
 create mode 100755 python/commit-per-subsystem.py

diff --git a/python/commit-per-subsystem.py b/python/commit-per-subsystem.py
new file mode 100755
index 0000000000..d8442d9ea3
--- /dev/null
+++ b/python/commit-per-subsystem.py
@@ -0,0 +1,69 @@
+#!/usr/bin/env python3
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
+import subprocess
+import sys
+
+
+def git_add(pattern):
+    subprocess.run(['git', 'add', pattern])
+
+
+def git_commit(msg):
+    subprocess.run(['git', 'commit', '-m', msg], capture_output=True)
+
+
+maintainers = sys.argv[1]
+message = sys.argv[2].strip()
+
+subsystem = None
+
+shortnames = {
+    'Block layer core': 'block',
+    'ARM cores': 'arm',
+    'Network Block Device (NBD)': 'nbd',
+    'Command line option argument parsing': 'cmdline',
+    'Character device backends': 'chardev',
+    'S390 general architecture support': 's390'
+}
+
+
+def commit():
+    if subsystem:
+        msg = subsystem
+        if msg in shortnames:
+            msg = shortnames[msg]
+        msg += ': ' + message
+        git_commit(msg)
+
+
+with open(maintainers) as f:
+    for line in f:
+        line = line.rstrip()
+        if not line:
+            continue
+        if len(line) >= 2 and line[1] == ':':
+            if line[0] == 'F' and line[3:] not in ['*', '*/']:
+                git_add(line[3:])
+        else:
+            # new subsystem start
+            commit()
+
+            subsystem = line
+
+commit()
-- 
2.21.0


