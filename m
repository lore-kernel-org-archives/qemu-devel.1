Received: from eggs.gnu.org ([2001:4830:134:3::10]:39227)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=4248f5c51=Ian.Jackson@citrix.com>)
	id 1dsv4H-0000rC-1C
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 14:10:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=4248f5c51=Ian.Jackson@citrix.com>)
	id 1dsv4C-0006z3-8W
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 14:10:20 -0400
Received: from smtp.citrix.com ([66.165.176.89]:59596)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=4248f5c51=Ian.Jackson@citrix.com>)
	id 1dsv4C-0006yi-1W
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 14:10:16 -0400
From: Ian Jackson <ian.jackson@eu.citrix.com>
Date: Fri, 15 Sep 2017 19:09:55 +0100
Message-ID: <1505498999-17427-3-git-send-email-ian.jackson@eu.citrix.com>
In-Reply-To: <1505498999-17427-1-git-send-email-ian.jackson@eu.citrix.com>
References: <1505498999-17427-1-git-send-email-ian.jackson@eu.citrix.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH RFC 2/6] xen: defer call to xen_restrict until
 running
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: xen-devel@nongnu.org, Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, Ian Jackson <ian.jackson@eu.citrix.com>, Ian Jackson <Ian.Jackson@eu.citrix.com>

Signed-off-by: Ian Jackson <Ian.Jackson@eu.citrix.com>
---
 hw/i386/xen/xen-hvm.c |  8 --------
 hw/xen/xen-common.c   | 10 ++++++++++
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/hw/i386/xen/xen-hvm.c b/hw/i386/xen/xen-hvm.c
index d9ccd5d..7b60ec6 100644
--- a/hw/i386/xen/xen-hvm.c
+++ b/hw/i386/xen/xen-hvm.c
@@ -1254,14 +1254,6 @@ void xen_hvm_init(PCMachineState *pcms, MemoryRegion **ram_memory)
         goto err;
     }
 
-    if (xen_domid_restrict) {
-        rc = xen_restrict(xen_domid);
-        if (rc < 0) {
-            error_report("failed to restrict: error %d", errno);
-            goto err;
-        }
-    }
-
     xen_create_ioreq_server(xen_domid, &state->ioservid);
 
     state->exit.notify = xen_exit_notifier;
diff --git a/hw/xen/xen-common.c b/hw/xen/xen-common.c
index 632a938..dfee53e 100644
--- a/hw/xen/xen-common.c
+++ b/hw/xen/xen-common.c
@@ -111,9 +111,19 @@ static void xenstore_record_dm_state(struct xs_handle *xs, const char *state)
 static void xen_change_state_handler(void *opaque, int running,
                                      RunState state)
 {
+    int rc;
+
     if (running) {
         /* record state running */
         xenstore_record_dm_state(xenstore, "running");
+
+        if (xen_domid_restrict) {
+            rc = xen_restrict(xen_domid);
+            if (rc < 0) {
+                perror("xen: failed to restrict");
+                exit(1);
+            }
+        }
     }
 }
 
-- 
2.1.4
