Received: from eggs.gnu.org ([2001:4830:134:3::10]:54799)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1e7rcU-0000hU-8y
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 19:31:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1e7rcQ-0005R7-8R
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 19:31:26 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48022)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1e7rcQ-0005QE-01
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 19:31:22 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9QNTc2O004487
	for <qemu-devel@nongnu.org>; Thu, 26 Oct 2017 19:31:21 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2dur20bg1f-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 26 Oct 2017 19:31:20 -0400
Received: from localhost
	by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Thu, 26 Oct 2017 19:31:19 -0400
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Thu, 26 Oct 2017 18:30:54 -0500
In-Reply-To: <20171026233054.21133-1-mdroth@linux.vnet.ibm.com>
References: <20171026233054.21133-1-mdroth@linux.vnet.ibm.com>
Message-Id: <20171026233054.21133-7-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 6/6] qga-win: report specific error when
 failing to open channel
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: sameeh@daynix.com, yan@daynix.com, daniel@daynix.com

Useful in general, but especially now that errors might occur more
frequently with --retry-path set.

Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 qga/channel-win32.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/qga/channel-win32.c b/qga/channel-win32.c
index 7e6dc4d26f..335542f748 100644
--- a/qga/channel-win32.c
+++ b/qga/channel-win32.c
@@ -302,7 +302,8 @@ static gboolean ga_channel_open(GAChannel *c, GAChannelMethod method,
                            OPEN_EXISTING,
                            FILE_FLAG_NO_BUFFERING | FILE_FLAG_OVERLAPPED, NULL);
     if (c->handle == INVALID_HANDLE_VALUE) {
-        g_critical("error opening path %s", newpath);
+        g_critical("error opening path %s: %s", newpath,
+                   g_win32_error_message(GetLastError()));
         return false;
     }
 
-- 
2.11.0
