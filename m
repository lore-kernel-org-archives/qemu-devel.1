Received: from eggs.gnu.org ([2001:4830:134:3::10]:37770)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fUuq5-00010x-4x
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 10:09:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fUuq3-0000VC-Rf
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 10:09:01 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36318 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fUuq3-0000Ui-MU
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 10:08:59 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2241781A4E99
	for <qemu-devel@nongnu.org>; Mon, 18 Jun 2018 14:08:59 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 18 Jun 2018 16:08:53 +0200
Message-Id: <20180618140854.17824-7-armbru@redhat.com>
In-Reply-To: <20180618140854.17824-1-armbru@redhat.com>
References: <20180618140854.17824-1-armbru@redhat.com>
Subject: [Qemu-devel] [PULL 6/7] monitor: move init global earlier
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>

From: Peter Xu <peterx@redhat.com>

Before this patch, monitor fd helpers might be called even earlier than
monitor_init_globals().  This can be problematic.

After previous work, now monitor_init_globals() does not depend on
accelerator initialization any more.  Call it earlier (before CLI
parsing; that's where the monitor APIs might be called) to make sure it
is called before any of the monitor APIs.

Suggested-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <20180608035511.7439-7-peterx@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 vl.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/vl.c b/vl.c
index 6e34fb348d..b3426e03d0 100644
--- a/vl.c
+++ b/vl.c
@@ -2978,6 +2978,7 @@ int main(int argc, char **argv, char **envp)
 
     runstate_init();
     postcopy_infrastructure_init();
+    monitor_init_globals();
 
     if (qcrypto_init(&err) < 0) {
         error_reportf_err(err, "cannot initialize crypto: ");
@@ -4412,12 +4413,6 @@ int main(int argc, char **argv, char **envp)
     default_drive(default_floppy, snapshot, IF_FLOPPY, 0, FD_OPTS);
     default_drive(default_sdcard, snapshot, IF_SD, 0, SD_OPTS);
 
-    /*
-     * Note: qtest_enabled() (which is used in monitor_qapi_event_init())
-     * depends on configure_accelerator() above.
-     */
-    monitor_init_globals();
-
     if (qemu_opts_foreach(qemu_find_opts("mon"),
                           mon_init_func, NULL, NULL)) {
         exit(1);
-- 
2.17.1
