Received: from eggs.gnu.org ([2001:4830:134:3::10]:49800)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hw42@ipsumj.de>) id 1e8HHk-0005DU-3D
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 22:55:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hw42@ipsumj.de>) id 1e8HHf-0002ra-8k
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 22:55:44 -0400
Received: from ipsumj.de ([109.75.177.107]:36440)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <hw42@ipsumj.de>) id 1e8HHe-0002mN-Sw
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 22:55:39 -0400
From: Simon Gaiser <hw42@ipsumj.de>
Date: Sat, 28 Oct 2017 04:53:15 +0200
Message-Id: <20171028025315.13500-1-hw42@ipsumj.de>
Subject: [Qemu-devel] [PATCH] xen/pt: Set is_express to avoid out-of-bounds
 write
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Simon Gaiser <hw42@ipsumj.de>, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org

The passed-through device might be an express device. In this case the
old code allocated a too small emulated config space in
pci_config_alloc() since pci_config_size() returned the size for a
non-express device. This leads to an out-of-bound write in
xen_pt_config_reg_init(), which sometimes results in crashes. So set
is_express as already done for KVM in vfio-pci.

Shortened ASan report:

==17512==ERROR: AddressSanitizer: heap-buffer-overflow on address 0x611000041648 at pc 0x55e0fdac51ff bp 0x7ffe4af07410 sp 0x7ffe4af07408
WRITE of size 2 at 0x611000041648 thread T0
    #0 0x55e0fdac51fe in memcpy /usr/include/x86_64-linux-gnu/bits/string3.h:53
    #1 0x55e0fdac51fe in stw_he_p include/qemu/bswap.h:330
    #2 0x55e0fdac51fe in stw_le_p include/qemu/bswap.h:379
    #3 0x55e0fdac51fe in pci_set_word include/hw/pci/pci.h:490
    #4 0x55e0fdac51fe in xen_pt_config_reg_init hw/xen/xen_pt_config_init.c:1991
    #5 0x55e0fdac51fe in xen_pt_config_init hw/xen/xen_pt_config_init.c:2067
    #6 0x55e0fdabcf4d in xen_pt_realize hw/xen/xen_pt.c:830
    #7 0x55e0fdf59666 in pci_qdev_realize hw/pci/pci.c:2034
    #8 0x55e0fdda7d3d in device_set_realized hw/core/qdev.c:914
[...]

0x611000041648 is located 8 bytes to the right of 256-byte region [0x611000041540,0x611000041640)
allocated by thread T0 here:
    #0 0x7ff596a94bb8 in __interceptor_calloc (/usr/lib/x86_64-linux-gnu/libasan.so.4+0xd9bb8)
    #1 0x7ff57da66580 in g_malloc0 (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x50580)
    #2 0x55e0fdda7d3d in device_set_realized hw/core/qdev.c:914
[...]

Signed-off-by: Simon Gaiser <hw42@ipsumj.de>
---

I found this by debugging crashes and I'm not familiar with this code,
so I'm not sure if this has no unintended side effects.

 hw/xen/xen_pt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/xen/xen_pt.c b/hw/xen/xen_pt.c
index b6d71bb52a..90ffd45e7d 100644
--- a/hw/xen/xen_pt.c
+++ b/hw/xen/xen_pt.c
@@ -946,6 +946,7 @@ static void xen_pci_passthrough_class_init(ObjectClass *klass, void *data)
     k->exit = xen_pt_unregister_device;
     k->config_read = xen_pt_pci_read_config;
     k->config_write = xen_pt_pci_write_config;
+    k->is_express = 1; /* We might be */
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
     dc->desc = "Assign an host PCI device with Xen";
     dc->props = xen_pci_passthrough_properties;
-- 
2.15.0.rc1
