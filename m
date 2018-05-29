Received: from eggs.gnu.org ([2001:4830:134:3::10]:58807)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fNXeU-0004XD-21
	for qemu-devel@nongnu.org; Tue, 29 May 2018 01:58:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fNXeT-0001SS-Am
	for qemu-devel@nongnu.org; Tue, 29 May 2018 01:58:34 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:27721 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fNXeT-0001SB-68
	for qemu-devel@nongnu.org; Tue, 29 May 2018 01:58:33 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B1EF04022905
	for <qemu-devel@nongnu.org>; Tue, 29 May 2018 05:58:32 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Tue, 29 May 2018 13:57:54 +0800
Message-Id: <20180529055755.12404-7-peterx@redhat.com>
In-Reply-To: <20180529055755.12404-1-peterx@redhat.com>
References: <20180529055755.12404-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v9 6/7] monitor: move init global earlier
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com

Before this patch, monitor fd helpers might be called even earlier than
monitor_init_globals().  This can be problematic.

After previous work, now monitor_init_globals() does not depend on
accelerator initialization any more.  Call it earlier (before CLI
parsing; that's where the monitor APIs might be called) to make sure it
is called before any of the monitor APIs.

Suggested-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 vl.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/vl.c b/vl.c
index 038d7f8042..97b43b399f 100644
--- a/vl.c
+++ b/vl.c
@@ -3074,6 +3074,7 @@ int main(int argc, char **argv, char **envp)
 
     runstate_init();
     postcopy_infrastructure_init();
+    monitor_init_globals();
 
     if (qcrypto_init(&err) < 0) {
         error_reportf_err(err, "cannot initialize crypto: ");
@@ -4490,12 +4491,6 @@ int main(int argc, char **argv, char **envp)
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
2.17.0
