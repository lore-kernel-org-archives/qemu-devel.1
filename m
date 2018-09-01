Received: from eggs.gnu.org ([2001:4830:134:3::10]:50800)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fw3u7-0003St-FR
	for qemu-devel@nongnu.org; Sat, 01 Sep 2018 07:17:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fw3u6-0000ji-0W
	for qemu-devel@nongnu.org; Sat, 01 Sep 2018 07:17:23 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48026 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fw3u5-0000jN-QF
	for qemu-devel@nongnu.org; Sat, 01 Sep 2018 07:17:21 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 79A4787A70
	for <qemu-devel@nongnu.org>; Sat,  1 Sep 2018 11:17:21 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Sat,  1 Sep 2018 13:17:11 +0200
Message-Id: <20180901111716.1675-2-armbru@redhat.com>
In-Reply-To: <20180901111716.1675-1-armbru@redhat.com>
References: <20180901111716.1675-1-armbru@redhat.com>
Subject: [Qemu-devel] [PULL 1/6] monitor: simplify
 monitor_qmp_setup_handlers_bh
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

When we reach monitor_qmp_setup_handlers_bh() we must be using the
IOThread then, so no need to check against it any more.  Instead, we
assert.

Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <20180815133747.25032-2-peterx@redhat.com>
[Insufficiently useful comment dropped]
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 monitor.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/monitor.c b/monitor.c
index 021c11b1bf..c049776603 100644
--- a/monitor.c
+++ b/monitor.c
@@ -4631,15 +4631,9 @@ static void monitor_qmp_setup_handlers_bh(void *opaque)
     Monitor *mon = opaque;
     GMainContext *context;
 
-    if (mon->use_io_thread) {
-        /* Use @mon_iothread context */
-        context = monitor_get_io_context();
-        assert(context);
-    } else {
-        /* Use default main loop context */
-        context = NULL;
-    }
-
+    assert(mon->use_io_thread);
+    context = monitor_get_io_context();
+    assert(context);
     qemu_chr_fe_set_handlers(&mon->chr, monitor_can_read, monitor_qmp_read,
                              monitor_qmp_event, NULL, mon, context, true);
     monitor_list_append(mon);
-- 
2.17.1
