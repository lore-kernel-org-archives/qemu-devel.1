Received: from eggs.gnu.org ([2001:4830:134:3::10]:41264)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1faSIz-0008QJ-KC
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 16:53:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1faSIv-0000yV-Jo
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 16:53:45 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45494
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1faSIv-0000yL-EJ
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 16:53:41 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w63KnGAw095182
	for <qemu-devel@nongnu.org>; Tue, 3 Jul 2018 16:53:40 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2k0dpdpdmg-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 03 Jul 2018 16:53:40 -0400
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Tue, 3 Jul 2018 14:53:40 -0600
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Tue,  3 Jul 2018 15:52:09 -0500
In-Reply-To: <20180703205221.24788-1-mdroth@linux.vnet.ibm.com>
References: <20180703205221.24788-1-mdroth@linux.vnet.ibm.com>
Message-Id: <20180703205221.24788-3-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PULL 02/14] qga: check bytes count read by
 guest-file-read
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Prasad J Pandit <pjp@fedoraproject.org>, qemu-stable@nongnu.org

From: Prasad J Pandit <pjp@fedoraproject.org>

While reading file content via 'guest-file-read' command,
'qmp_guest_file_read' routine allocates buffer of count+1
bytes. It could overflow for large values of 'count'.
Add check to avoid it.

Reported-by: Fakhri Zulkifli <mohdfakhrizulkifli@gmail.com>
Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
Cc: qemu-stable@nongnu.org
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 qga/commands-posix.c | 2 +-
 qga/commands-win32.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index 594d21ef3e..9284e71666 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -458,7 +458,7 @@ struct GuestFileRead *qmp_guest_file_read(int64_t handle, bool has_count,
 
     if (!has_count) {
         count = QGA_READ_COUNT_DEFAULT;
-    } else if (count < 0) {
+    } else if (count < 0 || count >= UINT32_MAX) {
         error_setg(errp, "value '%" PRId64 "' is invalid for argument count",
                    count);
         return NULL;
diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index 70ee5379f6..73f31fa8c2 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -318,7 +318,7 @@ GuestFileRead *qmp_guest_file_read(int64_t handle, bool has_count,
     }
     if (!has_count) {
         count = QGA_READ_COUNT_DEFAULT;
-    } else if (count < 0) {
+    } else if (count < 0 || count >= UINT32_MAX) {
         error_setg(errp, "value '%" PRId64
                    "' is invalid for argument count", count);
         return NULL;
-- 
2.11.0
