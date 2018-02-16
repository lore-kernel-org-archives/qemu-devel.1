Received: from eggs.gnu.org ([2001:4830:134:3::10]:48451)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1emk5v-0008Ex-FP
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 12:46:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1emk5s-0000lT-BX
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 12:46:47 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43974 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1emk5s-0000lM-6U
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 12:46:44 -0500
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Fri, 16 Feb 2018 17:46:40 +0000
Message-Id: <20180216174640.21765-3-dgilbert@redhat.com>
In-Reply-To: <20180216174640.21765-1-dgilbert@redhat.com>
References: <20180216174640.21765-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PULL 2/2] monitor.c: Fix infinite loop in monitor's
 auto-complete
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, thuth@redhat.com, t.pagef.lt@gmail.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

The QEMU monitor enters an infinite loop when trying to auto-complete commands
that accept only optional parameters. The commands currently affected by this
issue are 'info registers' and 'info mtree'.

Reported-by: Dimitris Karagkasidis <t.pagef.lt@gmail.com>
Fixes: 48fe86f6400574165979e0db6f5937ad487b6888
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Message-Id: <20180213125143.23488-1-dgilbert@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 monitor.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/monitor.c b/monitor.c
index 9a0d480c53..373bb8d1c3 100644
--- a/monitor.c
+++ b/monitor.c
@@ -3696,7 +3696,7 @@ static void monitor_find_completion_by_table(Monitor *mon,
 {
     const char *cmdname;
     int i;
-    const char *ptype, *str, *name;
+    const char *ptype, *old_ptype, *str, *name;
     const mon_cmd_t *cmd;
     BlockBackend *blk = NULL;
 
@@ -3741,7 +3741,9 @@ static void monitor_find_completion_by_table(Monitor *mon,
             }
         }
         str = args[nb_args - 1];
-        while (*ptype == '-' && ptype[1] != '\0') {
+        old_ptype = NULL;
+        while (*ptype == '-' && old_ptype != ptype) {
+            old_ptype = ptype;
             ptype = next_arg_type(ptype);
         }
         switch(*ptype) {
-- 
2.14.3
