Received: from eggs.gnu.org ([2001:4830:134:3::10]:43307)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cHKCJ-0004eQ-QE
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:47:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cHKCG-0001cV-LT
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:46:59 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43713)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1cHKCG-0001bs-1b
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:46:56 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	uBF0hahd064456
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 19:46:55 -0500
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	by mx0a-001b2d01.pphosted.com with ESMTP id 27bgh8h3yw-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 19:46:54 -0500
Received: from localhost
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Wed, 14 Dec 2016 17:46:54 -0700
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Wed, 14 Dec 2016 18:44:49 -0600
In-Reply-To: <1481762701-4587-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1481762701-4587-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1481762701-4587-56-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 55/67] block/curl: Fix return value from
 curl_read_cb
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Max Reitz <mreitz@redhat.com>, Jeff Cody <jcody@redhat.com>

From: Max Reitz <mreitz@redhat.com>

While commit 38bbc0a580f9f10570b1d1b5d3e92f0e6feb2970 is correct in that
the callback is supposed to return the number of bytes handled; what it
does not mention is that libcurl will throw an error if the callback did
not "handle" all of the data passed to it.

Therefore, if the callback receives some data that it cannot handle
(either because the receive buffer has not been set up yet or because it
would not fit into the receive buffer) and we have to ignore it, we
still have to report that the data has been handled.

Obviously, this should not happen normally. But it does happen at least
for FTP connections where some data (that we do not expect) may be
generated when the connection is established.

Cc: qemu-stable@nongnu.org
Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-id: 20161025025431.24714-3-mreitz@redhat.com
Signed-off-by: Jeff Cody <jcody@redhat.com>
(cherry picked from commit 4e7676571bccb42dd49b5efbb91ac49077ea5197)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 block/curl.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/block/curl.c b/block/curl.c
index a764e32..f47f4e6 100644
--- a/block/curl.c
+++ b/block/curl.c
@@ -213,12 +213,13 @@ static size_t curl_read_cb(void *ptr, size_t size, size_t nmemb, void *opaque)
 
     DPRINTF("CURL: Just reading %zd bytes\n", realsize);
 
-    if (!s || !s->orig_buf)
-        return 0;
+    if (!s || !s->orig_buf) {
+        goto read_end;
+    }
 
     if (s->buf_off >= s->buf_len) {
         /* buffer full, read nothing */
-        return 0;
+        goto read_end;
     }
     realsize = MIN(realsize, s->buf_len - s->buf_off);
     memcpy(s->orig_buf + s->buf_off, ptr, realsize);
@@ -239,7 +240,9 @@ static size_t curl_read_cb(void *ptr, size_t size, size_t nmemb, void *opaque)
         }
     }
 
-    return realsize;
+read_end:
+    /* curl will error out if we do not return this value */
+    return size * nmemb;
 }
 
 static int curl_find_buf(BDRVCURLState *s, size_t start, size_t len,
-- 
1.9.1
