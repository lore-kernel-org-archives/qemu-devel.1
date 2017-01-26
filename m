Received: from eggs.gnu.org ([2001:4830:134:3::10]:33206)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ashijeetacharya@gmail.com>) id 1cWgB6-00035J-GS
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 04:17:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ashijeetacharya@gmail.com>) id 1cWgB3-00020N-9Y
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 04:17:12 -0500
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:33132)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ashijeetacharya@gmail.com>)
	id 1cWgB3-000201-1W
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 04:17:09 -0500
Received: by mail-pg0-x244.google.com with SMTP id 194so22010049pgd.0
	for <qemu-devel@nongnu.org>; Thu, 26 Jan 2017 01:17:09 -0800 (PST)
From: Ashijeet Acharya <ashijeetacharya@gmail.com>
Date: Thu, 26 Jan 2017 14:46:52 +0530
Message-Id: <1485422212-31546-1-git-send-email-ashijeetacharya@gmail.com>
Subject: [Qemu-devel] [PATCH] migrate: Migration aborts abruptly for machine
 "none"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: thuth@redhat.com
Cc: quintela@redhat.com, dgilbert@redhat.com, berrange@redhat.com, qemu-devel@nongnu.org, Ashijeet Acharya <ashijeetacharya@gmail.com>

Migration of a "none" machine with no RAM crashes abruptly as
bitmap_new() fails and thus aborts. Instead, place a check for
last_ram_offset() being '0' at the start of ram_save_setup() and
error out with a meaningful error message.

Signed-off-by: Ashijeet Acharya <ashijeetacharya@gmail.com>
---
 migration/ram.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/migration/ram.c b/migration/ram.c
index ef8fadf..bf05d69 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1947,6 +1947,11 @@ static int ram_save_setup(QEMUFile *f, void *opaque)
 {
     RAMBlock *block;
 
+    if (last_ram_offset() == 0) {
+        error_report("Failed to migrate: No RAM available!");
+        return -1;
+    }
+
     /* migration has already setup the bitmap, reuse it. */
     if (!migration_in_colo_state()) {
         if (ram_save_init_globals() < 0) {
-- 
2.6.2
