Received: from eggs.gnu.org ([2001:4830:134:3::10]:46476)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cYvDj-0006Uh-L0
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 08:45:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cYvDi-0004pR-QL
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 08:45:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38144)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cYvDi-0004p9-Ku
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 08:45:10 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Wed,  1 Feb 2017 13:44:51 +0000
Message-Id: <20170201134453.11963-9-stefanha@redhat.com>
In-Reply-To: <20170201134453.11963-1-stefanha@redhat.com>
References: <20170201134453.11963-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PULL 08/10] trace: improve error reporting when
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
Cc: Peter Maydell <peter.maydell@linaro.org>, "Daniel P. Berrange" <berrange@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

From: "Daniel P. Berrange" <berrange@redhat.com>

When loading a simpletrace binary file we just report
"Not a valid trace file!" which is not very helpful. Report
exactly which field we found to be invalid.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
Message-id: 20170125161417.31949-9-berrange@redhat.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
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
