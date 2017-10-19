Received: from eggs.gnu.org ([2001:4830:134:3::10]:38817)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=4589aa1ec=Ian.Jackson@citrix.com>)
	id 1e5E3H-0006TC-9u
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 12:52:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=4589aa1ec=Ian.Jackson@citrix.com>)
	id 1e5E3G-0006JK-JC
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 12:52:11 -0400
Received: from smtp.citrix.com ([66.165.176.89]:55845)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=4589aa1ec=Ian.Jackson@citrix.com>)
	id 1e5E3G-0006GC-E6
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 12:52:10 -0400
From: Ian Jackson <ian.jackson@eu.citrix.com>
Date: Thu, 19 Oct 2017 17:51:52 +0100
Message-ID: <1508431916-9412-5-git-send-email-ian.jackson@eu.citrix.com>
In-Reply-To: <1508431916-9412-1-git-send-email-ian.jackson@eu.citrix.com>
References: <1508431916-9412-1-git-send-email-ian.jackson@eu.citrix.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 4/8] xen: destroy_hvm_domain: Move reason into
 a variable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Ross Lagerwall <ross.lagerwall@citrix.com>, Anthony PERARD <anthony.perard@citrix.com>, Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, xen-devel@lists.xenproject.org, Ian Jackson <ian.jackson@eu.citrix.com>, Ian Jackson <Ian.Jackson@eu.citrix.com>

We are going to want to reuse this.

No functional change.

Signed-off-by: Ian Jackson <Ian.Jackson@eu.citrix.com>
Reviewed-by: Anthony PERARD <anthony.perard@citrix.com>
---
 hw/i386/xen/xen-hvm.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/i386/xen/xen-hvm.c b/hw/i386/xen/xen-hvm.c
index 7b60ec6..83420cd 100644
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
