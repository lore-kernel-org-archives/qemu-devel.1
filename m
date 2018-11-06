Received: from eggs.gnu.org ([2001:4830:134:3::10]:53021)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gK5L6-0006CI-6m
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 12:40:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gK5Kk-0008Na-5j
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 12:40:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34192)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gK5Kh-0007IN-UH
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 12:40:08 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Tue,  6 Nov 2018 18:39:39 +0100
Message-Id: <20181106173941.9449-2-armbru@redhat.com>
In-Reply-To: <20181106173941.9449-1-armbru@redhat.com>
References: <20181106173941.9449-1-armbru@redhat.com>
Subject: [Qemu-devel] [PULL v2 1/3] monitor: guard iothread access by
 mon->use_io_thread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Wolfgang Bumiller <w.bumiller@proxmox.com>

From: Wolfgang Bumiller <w.bumiller@proxmox.com>

monitor_resume() and monitor_suspend() both want to
"kick" the I/O thread if it is there, but in
monitor_suspend() lacked the use_io_thread flag condition.
This is required when we later only spawn the thread on
first use.

Signed-off-by: Wolfgang Bumiller <w.bumiller@proxmox.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Message-Id: <20180925081507.11873-2-w.bumiller@proxmox.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 monitor.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/monitor.c b/monitor.c
index 823b5a1099..66f149c1dc 100644
--- a/monitor.c
+++ b/monitor.c
@@ -4292,7 +4292,7 @@ int monitor_suspend(Monitor *mon)
 
     atomic_inc(&mon->suspend_cnt);
 
-    if (monitor_is_qmp(mon)) {
+    if (monitor_is_qmp(mon) && mon->use_io_thread) {
         /*
          * Kick I/O thread to make sure this takes effect.  It'll be
          * evaluated again in prepare() of the watch object.
-- 
2.17.2
