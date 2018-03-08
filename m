Received: from eggs.gnu.org ([2001:4830:134:3::10]:59840)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=5980b9d75=Ian.Jackson@citrix.com>)
	id 1etzW1-0007Q7-2s
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 12:39:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=5980b9d75=Ian.Jackson@citrix.com>)
	id 1etzVw-0008HH-Do
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 12:39:41 -0500
Received: from smtp.citrix.com ([66.165.176.89]:44779)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=5980b9d75=Ian.Jackson@citrix.com>)
	id 1etzVw-0008GN-7L
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 12:39:36 -0500
From: Ian Jackson <ian.jackson@eu.citrix.com>
Date: Thu, 8 Mar 2018 17:39:16 +0000
Message-ID: <1520530757-4477-11-git-send-email-ian.jackson@eu.citrix.com>
In-Reply-To: <1520530757-4477-1-git-send-email-ian.jackson@eu.citrix.com>
References: <1520530757-4477-1-git-send-email-ian.jackson@eu.citrix.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 10/11] xen: Expect xenstore write to fail when
 restricted
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: xen-devel@lists.xenproject.org, Ross Lagerwall <ross.lagerwall@citrix.com>, Anthony PERARD <anthony.perard@citrix.com>, Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, Ian Jackson <ian.jackson@eu.citrix.com>

From: Ross Lagerwall <ross.lagerwall@citrix.com>

Saving the current state to xenstore may fail when running restricted
(in particular, after a migration). Therefore, don't report the error or
exit when running restricted.  Toolstacks that want to allow running
QEMU restricted should instead make use of QMP events to listen for
state changes.

CC: Ian Jackson <ian.jackson@eu.citrix.com>
Signed-off-by: Ross Lagerwall <ross.lagerwall@citrix.com>
Reviewed-by: Ian Jackson <ian.jackson@eu.citrix.com>

---
v6: New patch in this version of the series
---
 hw/xen/xen-common.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/hw/xen/xen-common.c b/hw/xen/xen-common.c
index f73b416..8ede246 100644
--- a/hw/xen/xen-common.c
+++ b/hw/xen/xen-common.c
@@ -101,7 +101,12 @@ static void xenstore_record_dm_state(struct xs_handle *xs, const char *state)
     }
 
     snprintf(path, sizeof (path), "device-model/%u/state", xen_domid);
-    if (!xs_write(xs, XBT_NULL, path, state, strlen(state))) {
+    /*
+     * This call may fail when running restricted so don't make it fatal in
+     * that case. Toolstacks should instead use QMP to listen for state changes.
+     */
+    if (!xs_write(xs, XBT_NULL, path, state, strlen(state)) &&
+            !xen_domid_restrict) {
         error_report("error recording dm state");
         exit(1);
     }
-- 
2.1.4
