Received: from eggs.gnu.org ([2001:4830:134:3::10]:51106)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gChAd-000863-Dj
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 04:27:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gChAb-00014U-As
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 04:27:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36052)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gChAb-00011d-2Y
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 04:27:09 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Wed, 17 Oct 2018 10:26:40 +0200
Message-Id: <20181017082702.5581-17-armbru@redhat.com>
In-Reply-To: <20181017082702.5581-1-armbru@redhat.com>
References: <20181017082702.5581-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v4 16/38] xen/pt: Fix incomplete conversion to
 realize()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>

The conversion of "xen-pci-passthrough" to realize() (commit
5a11d0f7549, v2.6.0) neglected to convert the xen_pt_config_init()
error path.  If xen_pt_config_init() fails, xen_pt_realize() reports
the error, then returns success without completing its job.  I don't
know the exact impact, but it can't be good.

Belatedly convert the error path.

Fixes: 5a11d0f7549e24a10e178a9dc8ff5e698031d9a6
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Anthony Perard <anthony.perard@citrix.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Acked-by: Anthony PERARD <anthony.perard@citrix.com>
---
 hw/xen/xen_pt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/xen/xen_pt.c b/hw/xen/xen_pt.c
index e5a6eff44f..f1f3a3727c 100644
--- a/hw/xen/xen_pt.c
+++ b/hw/xen/xen_pt.c
@@ -830,7 +830,7 @@ static void xen_pt_realize(PCIDevice *d, Error **errp)
     xen_pt_config_init(s, &err);
     if (err) {
         error_append_hint(&err, "PCI Config space initialisation failed");
-        error_report_err(err);
+        error_propagate(errp, err);
         rc = -1;
         goto err_out;
     }
-- 
2.17.1
