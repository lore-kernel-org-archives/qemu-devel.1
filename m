Received: from eggs.gnu.org ([2001:4830:134:3::10]:39231)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=4248f5c51=Ian.Jackson@citrix.com>)
	id 1dsv4H-0000rV-9i
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 14:10:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=4248f5c51=Ian.Jackson@citrix.com>)
	id 1dsv4D-0006zu-1e
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 14:10:21 -0400
Received: from smtp.citrix.com ([66.165.176.89]:59596)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=4248f5c51=Ian.Jackson@citrix.com>)
	id 1dsv4C-0006yi-Rr
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 14:10:16 -0400
From: Ian Jackson <ian.jackson@eu.citrix.com>
Date: Fri, 15 Sep 2017 19:09:58 +0100
Message-ID: <1505498999-17427-6-git-send-email-ian.jackson@eu.citrix.com>
In-Reply-To: <1505498999-17427-1-git-send-email-ian.jackson@eu.citrix.com>
References: <1505498999-17427-1-git-send-email-ian.jackson@eu.citrix.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH RFC 5/6] xen: destroy_hvm_domain: Try
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
Cc: xen-devel@nongnu.org, Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, Ian Jackson <ian.jackson@eu.citrix.com>, Ian Jackson <Ian.Jackson@eu.citrix.com>

xc_interface_open etc. is not going to work if we have dropped
privilege, but xendevicemodel_shutdown will if everything is new
enough.

Signed-off-by: Ian Jackson <Ian.Jackson@eu.citrix.com>
---
 hw/i386/xen/xen-hvm.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/hw/i386/xen/xen-hvm.c b/hw/i386/xen/xen-hvm.c
index 83420cd..639425a 100644
--- a/hw/i386/xen/xen-hvm.c
+++ b/hw/i386/xen/xen-hvm.c
@@ -1386,9 +1386,18 @@ void destroy_hvm_domain(bool reboot)
 {
     xc_interface *xc_handle;
     int sts;
+    int rc;
 
     unsigned int reason = reboot ? SHUTDOWN_reboot : SHUTDOWN_poweroff;
 
+    if (xen_dmod) {
+        rc = xendevicemodel_shutdown(xen_dmod, xen_domid, reason);
+        if (!rc)
+            return;
+        perror("xendevicemodel_shutdown failed");
+        /* well, try the old thing then */
+    }
+
     xc_handle = xc_interface_open(0, 0, 0);
     if (xc_handle == NULL) {
         fprintf(stderr, "Cannot acquire xenctrl handle\n");
-- 
2.1.4
