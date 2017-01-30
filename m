Received: from eggs.gnu.org ([2001:4830:134:3::10]:53706)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ashijeetacharya@gmail.com>) id 1cYD9H-00018X-6M
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 09:41:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ashijeetacharya@gmail.com>) id 1cYD9C-0000tX-Bi
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 09:41:39 -0500
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:33273)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ashijeetacharya@gmail.com>)
	id 1cYD9C-0000sO-6m
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 09:41:34 -0500
Received: by mail-pf0-x242.google.com with SMTP id e4so23365482pfg.0
	for <qemu-devel@nongnu.org>; Mon, 30 Jan 2017 06:41:32 -0800 (PST)
From: Ashijeet Acharya <ashijeetacharya@gmail.com>
Date: Mon, 30 Jan 2017 20:11:11 +0530
Message-Id: <1485787271-8754-1-git-send-email-ashijeetacharya@gmail.com>
Subject: [Qemu-devel] [PATCH] migrate: Introduce a 'dc->vmsd' check to avoid
 segfault for --only-migratable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: dgilbert@redhat.com
Cc: quintela@redhat.com, amit.shah@redhat.com, qemu-devel@nongnu.org, Ashijeet Acharya <ashijeetacharya@gmail.com>

Commit a3a3d8c7 introduced a segfault bug while checking for
'dc->vmsd->unmigratable' which caused QEMU to crash when trying to add
devices which do no set their 'dc->vmsd' yet while initialization.
Place a 'dc->vmsd' check prior to it so that we do not segfault for
such devices.

NOTE: This doesn't compromise the functioning of --only-migratable
option as all the unmigratable devices do set their 'dc->vmsd'.

Signed-off-by: Ashijeet Acharya <ashijeetacharya@gmail.com>
---
 qdev-monitor.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qdev-monitor.c b/qdev-monitor.c
index 81d01df..a1106fd 100644
--- a/qdev-monitor.c
+++ b/qdev-monitor.c
@@ -578,7 +578,7 @@ DeviceState *qdev_device_add(QemuOpts *opts, Error **errp)
         return NULL;
     }
 
-    if (only_migratable) {
+    if (only_migratable && dc->vmsd) {
         if (dc->vmsd->unmigratable) {
             error_setg(errp, "Device %s is not migratable, but "
                        "--only-migratable was specified", driver);
-- 
2.6.2
