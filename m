Received: from eggs.gnu.org ([2001:4830:134:3::10]:49085)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eBe2l-0005rb-OK
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 04:50:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eBe2g-0004pN-Qb
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 04:50:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60386)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eBe2g-0004pC-KZ
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 04:50:06 -0500
From: Peter Xu <peterx@redhat.com>
Date: Mon,  6 Nov 2017 17:46:32 +0800
Message-Id: <20171106094643.14881-17-peterx@redhat.com>
In-Reply-To: <20171106094643.14881-1-peterx@redhat.com>
References: <20171106094643.14881-1-peterx@redhat.com>
Subject: [Qemu-devel] [RFC v3 16/27] monitor: let monitor_{suspend|resume}
 thread safe
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <shajnocz@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Jiri Denemark <jdenemar@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, peterx@redhat.com, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, marcandre.lureau@redhat.com, Markus Armbruster <armbru@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

Monitor code now can be run in more than one thread.  Let the suspend
and resume code for thread safety.
---
 monitor.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/monitor.c b/monitor.c
index 1e87de87f8..47e969244d 100644
--- a/monitor.c
+++ b/monitor.c
@@ -4003,7 +4003,7 @@ int monitor_suspend(Monitor *mon)
 {
     if (!mon->rs)
         return -ENOTTY;
-    mon->suspend_cnt++;
+    atomic_inc(&mon->suspend_cnt);
     return 0;
 }
 
@@ -4011,7 +4011,7 @@ void monitor_resume(Monitor *mon)
 {
     if (!mon->rs)
         return;
-    if (--mon->suspend_cnt == 0)
+    if (atomic_dec_fetch(&mon->suspend_cnt) == 0)
         readline_show_prompt(mon->rs);
 }
 
-- 
2.13.5
