Received: from eggs.gnu.org ([2001:4830:134:3::10]:47558)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cPWtD-0005Mm-VM
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 10:57:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cPWtA-0005XJ-L8
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 10:57:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43492)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cPWtA-0005Wx-Fx
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 10:57:08 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8EB1C8124A
	for <qemu-devel@nongnu.org>; Fri,  6 Jan 2017 15:57:08 +0000 (UTC)
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Fri,  6 Jan 2017 15:55:43 +0000
Message-Id: <20170106155543.12827-48-berrange@redhat.com>
In-Reply-To: <20170106155543.12827-1-berrange@redhat.com>
References: <20170106155543.12827-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v2 47/47] trace: improve error reporting when
 parsing simpletrace header
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

When loading a simpletrace binary file we just report
"Not a valid trace file!" which is not very helpful. Report
exactly which field we found to be invalid.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 scripts/simpletrace.py | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/scripts/simpletrace.py b/scripts/simpletrace.py
index 4ca903d..4c99004 100755
--- a/scripts/simpletrace.py
+++ b/scripts/simpletrace.py
@@ -73,10 +73,14 @@ def read_record(edict, idtoname, fobj):
 def read_trace_header(fobj):
     """Read and verify trace file header"""
     header = read_header(fobj, log_header_fmt)
-    if header is None or \
-       header[0] != header_event_id or \
-       header[1] != header_magic:
+    if header is None:
         raise ValueError('Not a valid trace file!')
+    if header[0] != header_event_id:
+        raise ValueError('Not a valid trace file, header id %d != %d' %
+                         (header[0], header_event_id))
+    if header[1] != header_magic:
+        raise ValueError('Not a valid trace file, header magic %d != %d' %
+                         (header[1], header_magic))
 
     log_version = header[2]
     if log_version not in [0, 2, 3, 4]:
-- 
2.9.3
