Received: from eggs.gnu.org ([209.51.188.92]:47736)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jandryuk@gmail.com>) id 1h3PHA-0003Ah-Vy
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 14:03:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jandryuk@gmail.com>) id 1h3PH9-0002hq-W6
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 14:03:48 -0400
Received: from mail-qk1-x744.google.com ([2607:f8b0:4864:20::744]:34643)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jandryuk@gmail.com>) id 1h3PH6-0002Wv-4x
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 14:03:46 -0400
Received: by mail-qk1-x744.google.com with SMTP id n6so3279391qkf.1
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 11:03:31 -0700 (PDT)
From: Jason Andryuk <jandryuk@gmail.com>
Date: Mon, 11 Mar 2019 14:02:16 -0400
Message-Id: <20190311180216.18811-7-jandryuk@gmail.com>
In-Reply-To: <20190311180216.18811-1-jandryuk@gmail.com>
References: <20190311180216.18811-1-jandryuk@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 6/6] xen-pt: Round pci regions sizes to
 XEN_PAGE_SIZE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: xen-devel@lists.xenproject.org, marmarek@invisiblethingslab.com, Simon Gaiser <simon@invisiblethingslab.com>, Jason Andryuk <jandryuk@gmail.com>, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul.durrant@citrix.com>

From: Simon Gaiser <simon@invisiblethingslab.com>

If a pci memory region has a size < XEN_PAGE_SIZE it can get located at
an address which is not page aligned. This breaks the memory mapping via
xc_domain_memory_mapping since this function is page based and the
"offset" is therefore lost.

Without this patch you will see error like this in the stubdom log:

  [00:05.0] xen_pt_bar_read: Error: Should not read BAR through QEMU. @0x0000000000000004

QubesOS/qubes-issues#2849

Signed-off-by: Simon Gaiser <simon@invisiblethingslab.com>
Signed-off-by: Jason Andryuk <jandryuk@gmail.com>
---
 hw/xen/xen_pt.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/hw/xen/xen_pt.c b/hw/xen/xen_pt.c
index 5539d56c3a..7f680442ee 100644
--- a/hw/xen/xen_pt.c
+++ b/hw/xen/xen_pt.c
@@ -449,9 +449,10 @@ static int xen_pt_register_regions(XenPCIPassthroughState *s, uint16_t *cmd)
     /* Register PIO/MMIO BARs */
     for (i = 0; i < PCI_ROM_SLOT; i++) {
         XenHostPCIIORegion *r = &d->io_regions[i];
+        pcibus_t r_size = r->size;
         uint8_t type;
 
-        if (r->base_addr == 0 || r->size == 0) {
+        if (r->base_addr == 0 || r_size == 0) {
             continue;
         }
 
@@ -469,15 +470,18 @@ static int xen_pt_register_regions(XenPCIPassthroughState *s, uint16_t *cmd)
                 type |= PCI_BASE_ADDRESS_MEM_TYPE_64;
             }
             *cmd |= PCI_COMMAND_MEMORY;
+
+            /* Round up to a full page for the hypercall. */
+            r_size = (r_size + XC_PAGE_SIZE - 1) & XC_PAGE_MASK;
         }
 
         memory_region_init_io(&s->bar[i], OBJECT(s), &ops, &s->dev,
-                              "xen-pci-pt-bar", r->size);
+                              "xen-pci-pt-bar", r_size);
         pci_register_bar(&s->dev, i, type, &s->bar[i]);
 
         XEN_PT_LOG(&s->dev, "IO region %i registered (size=0x%08"PRIx64
                    " base_addr=0x%08"PRIx64" type: %#x)\n",
-                   i, r->size, r->base_addr, type);
+                   i, r_size, r->base_addr, type);
     }
 
     /* Register expansion ROM address */
-- 
2.20.1
