Received: from eggs.gnu.org ([2001:4830:134:3::10]:50276)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1g0PZU-0006Ck-SW
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 07:14:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1g0PZT-0006eC-6k
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 07:14:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60516)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1g0PZT-0006dq-0P
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 07:14:03 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5DF0980F75
	for <qemu-devel@nongnu.org>; Thu, 13 Sep 2018 11:14:02 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
Date: Thu, 13 Sep 2018 13:06:02 +0200
Message-Id: <1536836762-273036-3-git-send-email-imammedo@redhat.com>
In-Reply-To: <1536836762-273036-1-git-send-email-imammedo@redhat.com>
References: <1536836762-273036-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH v8 2/2] vl:c: make sure that sockets are
 calculated correctly in '-smp X' case
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, ehabkost@redhat.com

commit
  (5cdc9b76e3 vl.c: Remove dead assignment)
removed sockets calculation when 'sockets' weren't provided on CLI
since there wasn't any users for it back then. Exiting checks
are neither reachable
   } else if (sockets * cores * threads < cpus) {
or nor triggerable
   if (sockets * cores * threads > max_cpus)
so we weren't noticing wrong topology since then, since users
recalculate sockets adhoc on their own.

However with deprecation check it becomes noticable, for example
  -smp 2
will start printing warning:
  "warning: Invalid CPU topology deprecated: sockets (1) * cores (1) * threads (1) != maxcpus (2)"
calculating sockets if they weren't specified.

Fix it by returning back sockets calculation if it's omitted on CLI.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Andrew Jones <drjones@redhat.com>
---
v8:
  - spelling fixes in commit message (Eric Blake <eblake@redhat.com>)
---
 vl.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/vl.c b/vl.c
index 7fd700e..9e56696 100644
--- a/vl.c
+++ b/vl.c
@@ -1210,11 +1210,14 @@ static void smp_parse(QemuOpts *opts)
 
         /* compute missing values, prefer sockets over cores over threads */
         if (cpus == 0 || sockets == 0) {
-            sockets = sockets > 0 ? sockets : 1;
             cores = cores > 0 ? cores : 1;
             threads = threads > 0 ? threads : 1;
             if (cpus == 0) {
+                sockets = sockets > 0 ? sockets : 1;
                 cpus = cores * threads * sockets;
+            } else {
+                max_cpus = qemu_opt_get_number(opts, "maxcpus", cpus);
+                sockets = max_cpus / (cores * threads);
             }
         } else if (cores == 0) {
             threads = threads > 0 ? threads : 1;
-- 
2.7.4
