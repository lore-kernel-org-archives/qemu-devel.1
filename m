Received: from eggs.gnu.org ([2001:4830:134:3::10]:59641)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=5995bc012=Ian.Jackson@citrix.com>)
	id 1euKeH-0005ZJ-LK
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 11:13:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=5995bc012=Ian.Jackson@citrix.com>)
	id 1euKeE-0003aP-QB
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 11:13:37 -0500
Received: from smtp.citrix.com ([66.165.176.89]:30309)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=5995bc012=Ian.Jackson@citrix.com>)
	id 1euKeE-0003Zt-Eu
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 11:13:34 -0500
From: Ian Jackson <ian.jackson@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-ID: <23202.45739.128643.206532@mariner.uk.xensource.com>
Date: Fri, 9 Mar 2018 16:13:31 +0000
In-Reply-To: <23202.45661.318179.372531@mariner.uk.xensource.com>
References: <1520535787-6223-1-git-send-email-ian.jackson@eu.citrix.com>
	<1520535787-6223-11-git-send-email-ian.jackson@eu.citrix.com>
	<20180309154431.GJ1921@perard.uk.xensource.com>
	<23202.45661.318179.372531@mariner.uk.xensource.com>
Subject: Re: [Qemu-devel] [PATCH 10/12] xen: Use newly added dmops for
 mapping VGA memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anthony PERARD <anthony.perard@citrix.com>, qemu-devel@nongnu.org, Ross Lagerwall <ross.lagerwall@citrix.com>, Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, xen-devel@lists.xenproject.org

Ian Jackson writes ("Re: [PATCH 10/12] xen: Use newly added dmops for mapping VGA memory"):
> Anthony PERARD writes ("Re: [PATCH 10/12] xen: Use newly added dmops for mapping VGA memory"):
> > This patch seems to remove the last users of
> > xen_xc_domain_add_to_physmap(). Can it be remove from xen_common.h?
> > 
> > With that:
> > Acked-by: Anthony PERARD <anthony.perard@citrix.com>
> 
> Have added a separate patch for that.

Wrong patch.  Gah!

>From 8794b90b82612665d1e3f9f96ab73579a271c3be Mon Sep 17 00:00:00 2001
From: Ian Jackson <ian.jackson@eu.citrix.com>
Date: Fri, 9 Mar 2018 16:08:55 +0000
Subject: [PATCH 3/5] xen: Remove now-obsolete xen_xc_domain_add_to_physmap

The last user was just removed; remove this function, accordingly.

Signed-off-by: Ian Jackson <Ian.Jackson@eu.citrix.com>
---
 include/hw/xen/xen_common.h | 22 ----------------------
 1 file changed, 22 deletions(-)

diff --git a/include/hw/xen/xen_common.h b/include/hw/xen/xen_common.h
index 2eed6fc..5f1402b 100644
--- a/include/hw/xen/xen_common.h
+++ b/include/hw/xen/xen_common.h
@@ -645,28 +645,6 @@ static inline int xen_set_ioreq_server_state(domid_t dom,
 
 #endif
 
-#if CONFIG_XEN_CTRL_INTERFACE_VERSION < 40600
-static inline int xen_xc_domain_add_to_physmap(xc_interface *xch, uint32_t domid,
-                                               unsigned int space,
-                                               unsigned long idx,
-                                               xen_pfn_t gpfn)
-{
-    return xc_domain_add_to_physmap(xch, domid, space, idx, gpfn);
-}
-#else
-static inline int xen_xc_domain_add_to_physmap(xc_interface *xch, uint32_t domid,
-                                               unsigned int space,
-                                               unsigned long idx,
-                                               xen_pfn_t gpfn)
-{
-    /* In Xen 4.6 rc is -1 and errno contains the error value. */
-    int rc = xc_domain_add_to_physmap(xch, domid, space, idx, gpfn);
-    if (rc == -1)
-        return errno;
-    return rc;
-}
-#endif
-
 #ifdef CONFIG_XEN_PV_DOMAIN_BUILD
 #if CONFIG_XEN_CTRL_INTERFACE_VERSION < 40700
 static inline int xen_domain_create(xc_interface *xc, uint32_t ssidref,
-- 
2.1.4
