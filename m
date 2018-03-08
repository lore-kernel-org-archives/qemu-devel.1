Received: from eggs.gnu.org ([2001:4830:134:3::10]:56958)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=5980b9d75=Ian.Jackson@citrix.com>)
	id 1eu0pP-0000mN-Dm
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 14:03:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=5980b9d75=Ian.Jackson@citrix.com>)
	id 1eu0pN-0002dQ-Ia
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 14:03:47 -0500
Received: from smtp.citrix.com ([66.165.176.89]:27694)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=5980b9d75=Ian.Jackson@citrix.com>)
	id 1eu0pN-0002cK-Bg
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 14:03:45 -0500
From: Ian Jackson <ian.jackson@eu.citrix.com>
Date: Thu, 8 Mar 2018 19:03:06 +0000
Message-ID: <1520535787-6223-12-git-send-email-ian.jackson@eu.citrix.com>
In-Reply-To: <1520535787-6223-1-git-send-email-ian.jackson@eu.citrix.com>
References: <1520535787-6223-1-git-send-email-ian.jackson@eu.citrix.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 11/12] xen: Expect xenstore write to fail when
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
Cc: Ross Lagerwall <ross.lagerwall@citrix.com>, Anthony PERARD <anthony.perard@citrix.com>, Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, xen-devel@lists.xenproject.org, Ian Jackson <ian.jackson@eu.citrix.com>

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
