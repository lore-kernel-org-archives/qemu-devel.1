Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90B7FECE587
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 16:21:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D29A21A4A
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 16:21:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D29A21A4A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44316 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFKtg-0001zE-7h
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 12:21:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50409)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iFKU0-0000jI-B8
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 11:54:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iFKTy-0007Eu-97
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 11:54:36 -0400
Received: from relay.sw.ru ([185.231.240.75]:38482)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iFKTr-0006Zq-SI; Tue, 01 Oct 2019 11:54:34 -0400
Received: from [10.94.3.0] (helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92.2)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1iFKSx-0004xb-Aj; Tue, 01 Oct 2019 18:53:31 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 06/31] python: add commit-per-subsystem.py
Date: Tue,  1 Oct 2019 18:52:54 +0300
Message-Id: <20191001155319.8066-7-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191001155319.8066-1-vsementsov@virtuozzo.com>
References: <20191001155319.8066-1-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Cc: fam@euphon.net, pburton@wavecomp.com, peter.maydell@linaro.org,
 codyprime@gmail.com, jasowang@redhat.com, mark.cave-ayland@ilande.co.uk,
 mdroth@linux.vnet.ibm.com, kraxel@redhat.com, sundeep.lkml@gmail.com,
 qemu-block@nongnu.org, quintela@redhat.com, arikalo@wavecomp.com,
 mst@redhat.com, armbru@redhat.com, pasic@linux.ibm.com, borntraeger@de.ibm.com,
 joel@jms.id.au, marcandre.lureau@redhat.com, rth@twiddle.net,
 farman@linux.ibm.com, ehabkost@redhat.com, sw@weilnetz.de, groug@kaod.org,
 yuval.shaia@oracle.com, dgilbert@redhat.com, alex.williamson@redhat.com,
 integration@gluster.org, clg@kaod.org, stefanha@redhat.com, david@redhat.com,
 jsnow@redhat.com, david@gibson.dropbear.id.au, kwolf@redhat.com,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, berrange@redhat.com,
 andrew@aj.id.au, cohuck@redhat.com, qemu-s390x@nongnu.org, mreitz@redhat.com,
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add script to automatically commit tree-wide changes per-subsystem.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---

CC: kwolf@redhat.com
CC: mreitz@redhat.com
CC: jsnow@redhat.com
CC: fam@euphon.net
CC: sw@weilnetz.de
CC: codyprime@gmail.com
CC: marcandre.lureau@redhat.com
CC: pbonzini@redhat.com
CC: groug@kaod.org
CC: sundeep.lkml@gmail.com
CC: peter.maydell@linaro.org
CC: stefanha@redhat.com
CC: pburton@wavecomp.com
CC: arikalo@wavecomp.com
CC: berrange@redhat.com
CC: ehabkost@redhat.com
CC: david@gibson.dropbear.id.au
CC: clg@kaod.org
CC: mst@redhat.com
CC: marcel.apfelbaum@gmail.com
CC: mark.cave-ayland@ilande.co.uk
CC: yuval.shaia@oracle.com
CC: cohuck@redhat.com
CC: farman@linux.ibm.com
CC: rth@twiddle.net
CC: david@redhat.com
CC: pasic@linux.ibm.com
CC: borntraeger@de.ibm.com
CC: kraxel@redhat.com
CC: alex.williamson@redhat.com
CC: andrew@aj.id.au
CC: joel@jms.id.au
CC: eblake@redhat.com
CC: armbru@redhat.com
CC: mdroth@linux.vnet.ibm.com
CC: quintela@redhat.com
CC: dgilbert@redhat.com
CC: jasowang@redhat.com
CC: qemu-block@nongnu.org
CC: integration@gluster.org
CC: qemu-arm@nongnu.org
CC: qemu-ppc@nongnu.org
CC: qemu-s390x@nongnu.org


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


