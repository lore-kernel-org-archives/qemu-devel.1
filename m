Received: from eggs.gnu.org ([2001:4830:134:3::10]:41809)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=4438c69fc=Ian.Jackson@citrix.com>)
	id 1dzlzB-00047O-E8
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 11:53:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=4438c69fc=Ian.Jackson@citrix.com>)
	id 1dzlzA-0006ww-Ho
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 11:53:25 -0400
Received: from smtp.citrix.com ([66.165.176.89]:37067)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=4438c69fc=Ian.Jackson@citrix.com>)
	id 1dzlzA-0006rl-At
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 11:53:24 -0400
From: Ian Jackson <ian.jackson@eu.citrix.com>
Date: Wed, 4 Oct 2017 16:53:10 +0100
Message-ID: <1507132392-25051-7-git-send-email-ian.jackson@eu.citrix.com>
In-Reply-To: <1507132392-25051-1-git-send-email-ian.jackson@eu.citrix.com>
References: <1507132392-25051-1-git-send-email-ian.jackson@eu.citrix.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 6/8] xen: destroy_hvm_domain: Try
 xendevicemodel_shutdown
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Ross Lagerwall <ross.lagerwall@citrix.com>, =Anthony PERARD <anthony.perard@citrix.com>, xen-devel@nongnu.org, Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, Ian Jackson <ian.jackson@eu.citrix.com>, Ian Jackson <Ian.Jackson@eu.citrix.com>

xc_interface_open etc. is not going to work if we have dropped
privilege, but xendevicemodel_shutdown will if everything is new
enough.

xendevicemodel_shutdown is only availabe in Xen 4.10 and later, so
provide a stub for earlier versions.

Signed-off-by: Ian Jackson <Ian.Jackson@eu.citrix.com>
---
v2: Add compatibility stub for Xen < 4.10.
    Fix coding style.

Signed-off-by: Ian Jackson <Ian.Jackson@eu.citrix.com>
---
 hw/i386/xen/xen-hvm.c       | 10 ++++++++++
 include/hw/xen/xen_common.h |  7 +++++++
 2 files changed, 17 insertions(+)

diff --git a/hw/i386/xen/xen-hvm.c b/hw/i386/xen/xen-hvm.c
index 83420cd..25b8b14 100644
--- a/hw/i386/xen/xen-hvm.c
+++ b/hw/i386/xen/xen-hvm.c
@@ -1386,9 +1386,19 @@ void destroy_hvm_domain(bool reboot)
 {
     xc_interface *xc_handle;
     int sts;
+    int rc;
 
     unsigned int reason = reboot ? SHUTDOWN_reboot : SHUTDOWN_poweroff;
 
+    if (xen_dmod) {
+        rc = xendevicemodel_shutdown(xen_dmod, xen_domid, reason);
+        if (!rc) {
+            return;
+        }
+        perror("xendevicemodel_shutdown failed");
+        /* well, try the old thing then */
+    }
+
     xc_handle = xc_interface_open(0, 0, 0);
     if (xc_handle == NULL) {
         fprintf(stderr, "Cannot acquire xenctrl handle\n");
diff --git a/include/hw/xen/xen_common.h b/include/hw/xen/xen_common.h
index 8efdb8a..1d6fb57 100644
--- a/include/hw/xen/xen_common.h
+++ b/include/hw/xen/xen_common.h
@@ -108,6 +108,13 @@ static inline int xentoolcore_restrict_all(domid_t domid)
     return -1;
 }
 
+static inline int xendevicemodel_shutdown(xendevicemodel_handle *dmod,
+                                          domid_t domid, unsigned int reason)
+{
+    errno = ENOTTY;
+    return -1;
+}
+
 #else /* CONFIG_XEN_CTRL_INTERFACE_VERSION >= 41000 */
 
 #include <xentoolcore.h>
-- 
2.1.4
