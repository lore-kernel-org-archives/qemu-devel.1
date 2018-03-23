Received: from eggs.gnu.org ([2001:4830:134:3::10]:33664)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ezQdW-0005Yq-NS
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 13:37:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ezQdV-0002JI-SV
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 13:37:54 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35488 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ezQdV-0002Iy-NG
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 13:37:53 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 53960813F699
	for <qemu-devel@nongnu.org>; Fri, 23 Mar 2018 17:37:53 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Fri, 23 Mar 2018 12:37:40 -0500
Message-Id: <20180323173741.1445744-4-eblake@redhat.com>
In-Reply-To: <20180323173741.1445744-1-eblake@redhat.com>
References: <20180323173741.1445744-1-eblake@redhat.com>
Subject: [Qemu-devel] [PULL 3/4] Revert "monitor: enable IO thread for (qmp
 & !mux) typed"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

From: Peter Xu <peterx@redhat.com>

This reverts commit 3fd2457d18edf5736f713dfe1ada9c87a9badab1.

Enabling OOB caused several iotests failures; due to the imminent
2.12 release, the safest action is to disable OOB for now.  If
other patches fix the issues that iotests exposed, it may be turned
back on in time for the release, otherwise it will be 2.13 material;
either way, the framework changes not reverted now do not hurt if
they remain as part of the 2.12 release.

Additionally, revert the tests in the patch 02130314d8 ("qmp: introduce
QMPCapability", 2018-03-19), as both parts must be reverted at once
to keep 'make check' passing.

Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <20180323140821.28957-2-peterx@redhat.com>
Tested-by: Christian Borntraeger <borntraeger@de.ibm.com>
[eblake: reorder/squash commits, enhance commit message]
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 monitor.c        |  5 +----
 tests/qmp-test.c | 10 +---------
 2 files changed, 2 insertions(+), 13 deletions(-)

diff --git a/monitor.c b/monitor.c
index 6ccd2fc0895..77f4c41cfa6 100644
--- a/monitor.c
+++ b/monitor.c
@@ -36,7 +36,6 @@
 #include "net/slirp.h"
 #include "chardev/char-fe.h"
 #include "chardev/char-io.h"
-#include "chardev/char-mux.h"
 #include "ui/qemu-spice.h"
 #include "sysemu/numa.h"
 #include "monitor/monitor.h"
@@ -4537,10 +4536,8 @@ static void monitor_qmp_setup_handlers_bh(void *opaque)
 void monitor_init(Chardev *chr, int flags)
 {
     Monitor *mon = g_malloc(sizeof(*mon));
-    /* Enable IOThread for QMPs that are not using MUX chardev backends. */
-    bool use_io_thr = (!CHARDEV_IS_MUX(chr)) && (flags & MONITOR_USE_CONTROL);

-    monitor_data_init(mon, false, use_io_thr);
+    monitor_data_init(mon, false, false);

     qemu_chr_fe_init(&mon->chr, chr, &error_abort);
     mon->flags = flags;
diff --git a/tests/qmp-test.c b/tests/qmp-test.c
index d1fa1cb2177..558e83540cc 100644
--- a/tests/qmp-test.c
+++ b/tests/qmp-test.c
@@ -80,8 +80,6 @@ static void test_qmp_protocol(void)
     QDict *resp, *q, *ret;
     QList *capabilities;
     QTestState *qts;
-    const QListEntry *entry;
-    QString *qstr;

     qts = qtest_init_without_qmp_handshake(common_args);

@@ -91,13 +89,7 @@ static void test_qmp_protocol(void)
     g_assert(q);
     test_version(qdict_get(q, "version"));
     capabilities = qdict_get_qlist(q, "capabilities");
-    g_assert(capabilities);
-    entry = qlist_first(capabilities);
-    g_assert(entry);
-    qstr = qobject_to(QString, entry->value);
-    g_assert(qstr);
-    g_assert_cmpstr(qstring_get_str(qstr), ==, "oob");
-    QDECREF(resp);
+    g_assert(capabilities && qlist_empty(capabilities));

     /* Test valid command before handshake */
     resp = qtest_qmp(qts, "{ 'execute': 'query-version' }");
-- 
2.14.3
