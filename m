Received: from eggs.gnu.org ([2001:4830:134:3::10]:57007)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=5980b9d75=Ian.Jackson@citrix.com>)
	id 1eu0pQ-0000pT-Or
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 14:03:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=5980b9d75=Ian.Jackson@citrix.com>)
	id 1eu0pP-0002eg-R1
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 14:03:48 -0500
Received: from smtp.citrix.com ([66.165.176.89]:53118)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=5980b9d75=Ian.Jackson@citrix.com>)
	id 1eu0pP-0002dt-Kx
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 14:03:47 -0500
From: Ian Jackson <ian.jackson@eu.citrix.com>
Date: Thu, 8 Mar 2018 19:03:01 +0000
Message-ID: <1520535787-6223-7-git-send-email-ian.jackson@eu.citrix.com>
In-Reply-To: <1520535787-6223-1-git-send-email-ian.jackson@eu.citrix.com>
References: <1520535787-6223-1-git-send-email-ian.jackson@eu.citrix.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 06/12] xen: move xc_interface compatibility
 fallback further up the file
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

We are going to want to use the dummy xendevicemodel_handle type in
new stub functions in the CONFIG_XEN_CTRL_INTERFACE_VERSION < 41000
section.  So we need to provide that definition, or (as applicable)
include the appropriate header, earlier in the file.

(Ideally the newer compatibility layers would be at the bottom of the
file, so that they can naturally benefit from the compatibility layers
for earlier version.  But that's rather too much for this series.)

No functional change.

Signed-off-by: Ian Jackson <Ian.Jackson@eu.citrix.com>
Acked-by: Anthony PERARD <anthony.perard@citrix.com>
Acked-by: Stefano Stabellini <sstabellini@kernel.org>
---
v2: New patch in v2 of the series
---
 include/hw/xen/xen_common.h | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/include/hw/xen/xen_common.h b/include/hw/xen/xen_common.h
index 1766bb9..60c4ebb 100644
--- a/include/hw/xen/xen_common.h
+++ b/include/hw/xen/xen_common.h
@@ -78,6 +78,17 @@ static inline void *xenforeignmemory_map(xc_interface *h, uint32_t dom,
 
 extern xenforeignmemory_handle *xen_fmem;
 
+#if CONFIG_XEN_CTRL_INTERFACE_VERSION < 40900
+
+typedef xc_interface xendevicemodel_handle;
+
+#else /* CONFIG_XEN_CTRL_INTERFACE_VERSION >= 40900 */
+
+#undef XC_WANT_COMPAT_DEVICEMODEL_API
+#include <xendevicemodel.h>
+
+#endif
+
 #if CONFIG_XEN_CTRL_INTERFACE_VERSION < 41000
 
 #define XEN_COMPAT_PHYSMAP
@@ -105,8 +116,6 @@ static inline int xentoolcore_restrict_all(domid_t domid)
 
 #if CONFIG_XEN_CTRL_INTERFACE_VERSION < 40900
 
-typedef xc_interface xendevicemodel_handle;
-
 static inline xendevicemodel_handle *xendevicemodel_open(
     struct xentoollog_logger *logger, unsigned int open_flags)
 {
@@ -228,11 +237,6 @@ static inline int xendevicemodel_set_mem_type(
     return xc_hvm_set_mem_type(dmod, domid, mem_type, first_pfn, nr);
 }
 
-#else /* CONFIG_XEN_CTRL_INTERFACE_VERSION >= 40900 */
-
-#undef XC_WANT_COMPAT_DEVICEMODEL_API
-#include <xendevicemodel.h>
-
 #endif
 
 extern xendevicemodel_handle *xen_dmod;
-- 
2.1.4
