Received: from eggs.gnu.org ([2001:4830:134:3::10]:57220)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1fSz5h-0003SW-Ar
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 02:17:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1fSz5c-00040p-C8
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 02:17:09 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46444 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1fSz5c-00040V-77
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 02:17:04 -0400
From: P J P <ppandit@redhat.com>
Date: Wed, 13 Jun 2018 11:46:57 +0530
Message-Id: <20180613061657.13632-1-ppandit@redhat.com>
Subject: [Qemu-devel] [PATCH] qga: check bytes count read by guest-file-read
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Qemu Developers <qemu-devel@nongnu.org>
Cc: Stefan Weil <sw@weilnetz.de>, Michael Roth <mdroth@linux.vnet.ibm.com>, Prasad J Pandit <pjp@fedoraproject.org>

From: Prasad J Pandit <pjp@fedoraproject.org>

While reading file content via 'guest-file-read' command,
'qmp_guest_file_read' routine allocates buffer of count+1
bytes. It could overflow for large values of 'count'.
Add check to avoid it.

Reported-by: Fakhri Zulkifli <mohdfakhrizulkifli@gmail.com>
Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
---
 qga/commands-posix.c | 2 +-
 qga/commands-win32.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index eae817191b..068c0f0bd9 100644
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
2.17.1
