Received: from eggs.gnu.org ([2001:4830:134:3::10]:59869)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=5980b9d75=Ian.Jackson@citrix.com>)
	id 1etzW1-0007QD-U0
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 12:39:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=5980b9d75=Ian.Jackson@citrix.com>)
	id 1etzW0-0008LB-NM
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 12:39:41 -0500
Received: from smtp.citrix.com ([66.165.176.89]:42122)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=5980b9d75=Ian.Jackson@citrix.com>)
	id 1etzW0-0008JW-GC
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 12:39:40 -0500
From: Ian Jackson <ian.jackson@eu.citrix.com>
Date: Thu, 8 Mar 2018 17:39:10 +0000
Message-ID: <1520530757-4477-5-git-send-email-ian.jackson@eu.citrix.com>
In-Reply-To: <1520530757-4477-1-git-send-email-ian.jackson@eu.citrix.com>
References: <1520530757-4477-1-git-send-email-ian.jackson@eu.citrix.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 04/11] xen: destroy_hvm_domain: Move reason
 into a variable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: xen-devel@lists.xenproject.org, Ian Jackson <ian.jackson@eu.citrix.com>, Ross Lagerwall <ross.lagerwall@citrix.com>, Anthony PERARD <anthony.perard@citrix.com>, Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, Ian Jackson <Ian.Jackson@eu.citrix.com>

We are going to want to reuse this.

No functional change.

Signed-off-by: Ian Jackson <Ian.Jackson@eu.citrix.com>
Reviewed-by: Anthony PERARD <anthony.perard@citrix.com>
Acked-by: Stefano Stabellini <sstabellini@kernel.org>
---
 hw/i386/xen/xen-hvm.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/i386/xen/xen-hvm.c b/hw/i386/xen/xen-hvm.c
index 9c3b6b3..3590d99 100644
--- a/hw/i386/xen/xen-hvm.c
+++ b/hw/i386/xen/xen-hvm.c
@@ -1387,12 +1387,13 @@ void destroy_hvm_domain(bool reboot)
     xc_interface *xc_handle;
     int sts;
 
+    unsigned int reason = reboot ? SHUTDOWN_reboot : SHUTDOWN_poweroff;
+
     xc_handle = xc_interface_open(0, 0, 0);
     if (xc_handle == NULL) {
         fprintf(stderr, "Cannot acquire xenctrl handle\n");
     } else {
-        sts = xc_domain_shutdown(xc_handle, xen_domid,
-                                 reboot ? SHUTDOWN_reboot : SHUTDOWN_poweroff);
+        sts = xc_domain_shutdown(xc_handle, xen_domid, reason);
         if (sts != 0) {
             fprintf(stderr, "xc_domain_shutdown failed to issue %s, "
                     "sts %d, %s\n", reboot ? "reboot" : "poweroff",
-- 
2.1.4
