Received: from eggs.gnu.org ([2001:4830:134:3::10]:43081)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <JBeulich@suse.com>) id 1dnolR-0004Nq-Sq
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 12:25:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <JBeulich@suse.com>) id 1dnolO-0000vz-Og
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 12:25:49 -0400
Received: from prv-mh.provo.novell.com ([137.65.248.74]:33405)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <JBeulich@suse.com>) id 1dnolO-0000v2-7R
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 12:25:46 -0400
Message-Id: <59A9A6260200007800176A6A@prv-mh.provo.novell.com>
Date: Fri, 01 Sep 2017 10:25:42 -0600
From: "Jan Beulich" <JBeulich@suse.com>
References: <59A9A6260200007800176A6A@prv-mh.provo.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Subject: [Qemu-devel] [PATCH] xen: use vMSI related #define-s from public
 interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefano Stabellini <sstabellini@kernel.org>, xen-devel <xen-devel@lists.xenproject.org>

Xen and qemu having identical #define-s (with different names) is a
strong hint that these should have been part of the public interface
from the very start. Use them if they're available, falling back to
privately defined values only when using older headers.

Signed-off-by: Jan Beulich <jbeulich@suse.com>

--- a/hw/xen/xen_pt_msi.c
+++ b/hw/xen/xen_pt_msi.c
@@ -18,6 +18,11 @@
=20
 #define XEN_PT_AUTO_ASSIGN -1
=20
+#ifndef XEN_DOMCTL_VMSI_X86_DEST_ID_MASK
+#if XEN_DOMCTL_INTERFACE_VERSION >=3D 0x0000000e
+#error vMSI defines missing from domctl.h
+#endif
+
 /* shift count for gflags */
 #define XEN_PT_GFLAGS_SHIFT_DEST_ID        0
 #define XEN_PT_GFLAGS_SHIFT_RH             8
@@ -26,6 +31,16 @@
 #define XEN_PT_GFLAGSSHIFT_TRG_MODE       15
 #define XEN_PT_GFLAGSSHIFT_UNMASKED       16
=20
+#define XEN_DOMCTL_VMSI_X86_DEST_ID_MASK (0xffU << XEN_PT_GFLAGS_SHIFT_DES=
T_ID)
+#define XEN_DOMCTL_VMSI_X86_RH_MASK      (1U << XEN_PT_GFLAGS_SHIFT_RH)
+#define XEN_DOMCTL_VMSI_X86_DM_MASK      (1U << XEN_PT_GFLAGS_SHIFT_DM)
+#define XEN_DOMCTL_VMSI_X86_DELIV_MASK   (7U << XEN_PT_GFLAGSSHIFT_DELIV_M=
ODE)
+#define XEN_DOMCTL_VMSI_X86_TRIG_MASK    (1U << XEN_PT_GFLAGSSHIFT_TRG_MOD=
E)
+#define XEN_DOMCTL_VMSI_X86_UNMASKED     (1U << XEN_PT_GFLAGSSHIFT_UNMASKE=
D)
+#endif
+
+#define MASK_INSR(v, m) (((v) * ((m) & -(m))) & (m))
+
 #define latch(fld) latch[PCI_MSIX_ENTRY_##fld / sizeof(uint32_t)]
=20
 /*
@@ -49,21 +64,18 @@ static inline uint32_t msi_ext_dest_id(u
=20
 static uint32_t msi_gflags(uint32_t data, uint64_t addr)
 {
-    uint32_t result =3D 0;
-    int rh, dm, dest_id, deliv_mode, trig_mode;
+    int rh, dm, deliv_mode, trig_mode;
=20
     rh =3D (addr >> MSI_ADDR_REDIRECTION_SHIFT) & 0x1;
     dm =3D (addr >> MSI_ADDR_DEST_MODE_SHIFT) & 0x1;
-    dest_id =3D msi_dest_id(addr);
     deliv_mode =3D (data >> MSI_DATA_DELIVERY_MODE_SHIFT) & 0x7;
     trig_mode =3D (data >> MSI_DATA_TRIGGER_SHIFT) & 0x1;
=20
-    result =3D dest_id | (rh << XEN_PT_GFLAGS_SHIFT_RH)
-        | (dm << XEN_PT_GFLAGS_SHIFT_DM)
-        | (deliv_mode << XEN_PT_GFLAGSSHIFT_DELIV_MODE)
-        | (trig_mode << XEN_PT_GFLAGSSHIFT_TRG_MODE);
-
-    return result;
+    return MASK_INSR(msi_dest_id(addr), XEN_DOMCTL_VMSI_X86_DEST_ID_MASK) =
|
+           MASK_INSR(rh, XEN_DOMCTL_VMSI_X86_RH_MASK) |
+           MASK_INSR(dm, XEN_DOMCTL_VMSI_X86_DM_MASK) |
+           MASK_INSR(deliv_mode, XEN_DOMCTL_VMSI_X86_DELIV_MASK) |
+           MASK_INSR(trig_mode, XEN_DOMCTL_VMSI_X86_TRIG_MASK);
 }
=20
 static inline uint64_t msi_addr64(XenPTMSI *msi)
@@ -173,7 +185,7 @@ static int msi_msix_update(XenPCIPassthr
         table_addr =3D s->msix->mmio_base_addr;
     }
=20
-    gflags |=3D masked ? 0 : (1u << XEN_PT_GFLAGSSHIFT_UNMASKED);
+    gflags |=3D masked ? 0 : XEN_DOMCTL_VMSI_X86_UNMASKED;
=20
     rc =3D xc_domain_update_msi_irq(xen_xc, xen_domid, gvec,
                                   pirq, gflags, table_addr);
