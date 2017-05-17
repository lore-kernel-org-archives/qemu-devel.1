Received: from eggs.gnu.org ([2001:4830:134:3::10]:54060)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dAwGj-0002Jw-Gp
	for qemu-devel@nongnu.org; Wed, 17 May 2017 06:33:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dAwGh-00044a-7X
	for qemu-devel@nongnu.org; Wed, 17 May 2017 06:33:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46634)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dAwGg-00044S-Ul
	for qemu-devel@nongnu.org; Wed, 17 May 2017 06:33:23 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C60443B46B
	for <qemu-devel@nongnu.org>; Wed, 17 May 2017 10:33:21 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 17 May 2017 12:33:12 +0200
Message-Id: <20170517103313.8459-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 1/2] xhci: split into multiple files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

Moved structs and defines to hcd-xhci.h.
Move nec controller variant to hcd-xhci-nec.c.
No functional changes.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/usb/hcd-xhci.h     | 226 +++++++++++++++++++++++++++++++++++++++++++++++
 hw/usb/hcd-xhci-nec.c |  63 +++++++++++++
 hw/usb/hcd-xhci.c     | 238 +-------------------------------------------------
 hw/usb/Makefile.objs  |   1 +
 4 files changed, 292 insertions(+), 236 deletions(-)
 create mode 100644 hw/usb/hcd-xhci.h
 create mode 100644 hw/usb/hcd-xhci-nec.c

diff --git a/hw/usb/hcd-xhci.h b/hw/usb/hcd-xhci.h
new file mode 100644
index 0000000000..fc36a4c787
--- /dev/null
+++ b/hw/usb/hcd-xhci.h
@@ -0,0 +1,226 @@
+/*
+ * USB xHCI controller emulation
+ *
+ * Copyright (c) 2011 Securiforest
+ * Date: 2011-05-11 ;  Author: Hector Martin <hector@marcansoft.com>
+ * Based on usb-ohci.c, emulates Renesas NEC USB 3.0
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#define TYPE_XHCI "base-xhci"
+#define TYPE_NEC_XHCI "nec-usb-xhci"
+#define TYPE_QEMU_XHCI "qemu-xhci"
+
+#define XHCI(obj) \
+    OBJECT_CHECK(XHCIState, (obj), TYPE_XHCI)
+
+#define MAXPORTS_2 15
+#define MAXPORTS_3 15
+
+#define MAXPORTS (MAXPORTS_2 + MAXPORTS_3)
+#define MAXSLOTS 64
+#define MAXINTRS 16
+
+/* Very pessimistic, let's hope it's enough for all cases */
+#define EV_QUEUE (((3 * 24) + 16) * MAXSLOTS)
+
+typedef struct XHCIState XHCIState;
+typedef struct XHCIStreamContext XHCIStreamContext;
+typedef struct XHCIEPContext XHCIEPContext;
+
+enum xhci_flags {
+    XHCI_FLAG_SS_FIRST = 1,
+    XHCI_FLAG_FORCE_PCIE_ENDCAP,
+    XHCI_FLAG_ENABLE_STREAMS,
+};
+
+typedef enum TRBType {
+    TRB_RESERVED = 0,
+    TR_NORMAL,
+    TR_SETUP,
+    TR_DATA,
+    TR_STATUS,
+    TR_ISOCH,
+    TR_LINK,
+    TR_EVDATA,
+    TR_NOOP,
+    CR_ENABLE_SLOT,
+    CR_DISABLE_SLOT,
+    CR_ADDRESS_DEVICE,
+    CR_CONFIGURE_ENDPOINT,
+    CR_EVALUATE_CONTEXT,
+    CR_RESET_ENDPOINT,
+    CR_STOP_ENDPOINT,
+    CR_SET_TR_DEQUEUE,
+    CR_RESET_DEVICE,
+    CR_FORCE_EVENT,
+    CR_NEGOTIATE_BW,
+    CR_SET_LATENCY_TOLERANCE,
+    CR_GET_PORT_BANDWIDTH,
+    CR_FORCE_HEADER,
+    CR_NOOP,
+    ER_TRANSFER = 32,
+    ER_COMMAND_COMPLETE,
+    ER_PORT_STATUS_CHANGE,
+    ER_BANDWIDTH_REQUEST,
+    ER_DOORBELL,
+    ER_HOST_CONTROLLER,
+    ER_DEVICE_NOTIFICATION,
+    ER_MFINDEX_WRAP,
+    /* vendor specific bits */
+    CR_VENDOR_NEC_FIRMWARE_REVISION  = 49,
+    CR_VENDOR_NEC_CHALLENGE_RESPONSE = 50,
+} TRBType;
+
+typedef enum TRBCCode {
+    CC_INVALID = 0,
+    CC_SUCCESS,
+    CC_DATA_BUFFER_ERROR,
+    CC_BABBLE_DETECTED,
+    CC_USB_TRANSACTION_ERROR,
+    CC_TRB_ERROR,
+    CC_STALL_ERROR,
+    CC_RESOURCE_ERROR,
+    CC_BANDWIDTH_ERROR,
+    CC_NO_SLOTS_ERROR,
+    CC_INVALID_STREAM_TYPE_ERROR,
+    CC_SLOT_NOT_ENABLED_ERROR,
+    CC_EP_NOT_ENABLED_ERROR,
+    CC_SHORT_PACKET,
+    CC_RING_UNDERRUN,
+    CC_RING_OVERRUN,
+    CC_VF_ER_FULL,
+    CC_PARAMETER_ERROR,
+    CC_BANDWIDTH_OVERRUN,
+    CC_CONTEXT_STATE_ERROR,
+    CC_NO_PING_RESPONSE_ERROR,
+    CC_EVENT_RING_FULL_ERROR,
+    CC_INCOMPATIBLE_DEVICE_ERROR,
+    CC_MISSED_SERVICE_ERROR,
+    CC_COMMAND_RING_STOPPED,
+    CC_COMMAND_ABORTED,
+    CC_STOPPED,
+    CC_STOPPED_LENGTH_INVALID,
+    CC_MAX_EXIT_LATENCY_TOO_LARGE_ERROR = 29,
+    CC_ISOCH_BUFFER_OVERRUN = 31,
+    CC_EVENT_LOST_ERROR,
+    CC_UNDEFINED_ERROR,
+    CC_INVALID_STREAM_ID_ERROR,
+    CC_SECONDARY_BANDWIDTH_ERROR,
+    CC_SPLIT_TRANSACTION_ERROR
+} TRBCCode;
+
+typedef struct XHCIRing {
+    dma_addr_t dequeue;
+    bool ccs;
+} XHCIRing;
+
+typedef struct XHCIPort {
+    XHCIState *xhci;
+    uint32_t portsc;
+    uint32_t portnr;
+    USBPort  *uport;
+    uint32_t speedmask;
+    char name[16];
+    MemoryRegion mem;
+} XHCIPort;
+
+typedef struct XHCISlot {
+    bool enabled;
+    bool addressed;
+    dma_addr_t ctx;
+    USBPort *uport;
+    XHCIEPContext *eps[31];
+} XHCISlot;
+
+typedef struct XHCIEvent {
+    TRBType type;
+    TRBCCode ccode;
+    uint64_t ptr;
+    uint32_t length;
+    uint32_t flags;
+    uint8_t slotid;
+    uint8_t epid;
+} XHCIEvent;
+
+typedef struct XHCIInterrupter {
+    uint32_t iman;
+    uint32_t imod;
+    uint32_t erstsz;
+    uint32_t erstba_low;
+    uint32_t erstba_high;
+    uint32_t erdp_low;
+    uint32_t erdp_high;
+
+    bool msix_used, er_pcs;
+
+    dma_addr_t er_start;
+    uint32_t er_size;
+    unsigned int er_ep_idx;
+
+    /* kept for live migration compat only */
+    bool er_full_unused;
+    XHCIEvent ev_buffer[EV_QUEUE];
+    unsigned int ev_buffer_put;
+    unsigned int ev_buffer_get;
+
+} XHCIInterrupter;
+
+struct XHCIState {
+    /*< private >*/
+    PCIDevice parent_obj;
+    /*< public >*/
+
+    USBBus bus;
+    MemoryRegion mem;
+    MemoryRegion mem_cap;
+    MemoryRegion mem_oper;
+    MemoryRegion mem_runtime;
+    MemoryRegion mem_doorbell;
+
+    /* properties */
+    uint32_t numports_2;
+    uint32_t numports_3;
+    uint32_t numintrs;
+    uint32_t numslots;
+    uint32_t flags;
+    uint32_t max_pstreams_mask;
+    OnOffAuto msi;
+    OnOffAuto msix;
+
+    /* Operational Registers */
+    uint32_t usbcmd;
+    uint32_t usbsts;
+    uint32_t dnctrl;
+    uint32_t crcr_low;
+    uint32_t crcr_high;
+    uint32_t dcbaap_low;
+    uint32_t dcbaap_high;
+    uint32_t config;
+
+    USBPort  uports[MAX(MAXPORTS_2, MAXPORTS_3)];
+    XHCIPort ports[MAXPORTS];
+    XHCISlot slots[MAXSLOTS];
+    uint32_t numports;
+
+    /* Runtime Registers */
+    int64_t mfindex_start;
+    QEMUTimer *mfwrap_timer;
+    XHCIInterrupter intr[MAXINTRS];
+
+    XHCIRing cmd_ring;
+
+    bool nec_quirks;
+};
diff --git a/hw/usb/hcd-xhci-nec.c b/hw/usb/hcd-xhci-nec.c
new file mode 100644
index 0000000000..75715a048a
--- /dev/null
+++ b/hw/usb/hcd-xhci-nec.c
@@ -0,0 +1,63 @@
+/*
+ * USB xHCI controller emulation
+ *
+ * Copyright (c) 2011 Securiforest
+ * Date: 2011-05-11 ;  Author: Hector Martin <hector@marcansoft.com>
+ * Based on usb-ohci.c, emulates Renesas NEC USB 3.0
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "hw/hw.h"
+#include "hw/usb.h"
+#include "hw/pci/pci.h"
+
+#include "hcd-xhci.h"
+
+static Property nec_xhci_properties[] = {
+    DEFINE_PROP_ON_OFF_AUTO("msi", XHCIState, msi, ON_OFF_AUTO_AUTO),
+    DEFINE_PROP_ON_OFF_AUTO("msix", XHCIState, msix, ON_OFF_AUTO_AUTO),
+    DEFINE_PROP_BIT("superspeed-ports-first",
+                    XHCIState, flags, XHCI_FLAG_SS_FIRST, true),
+    DEFINE_PROP_BIT("force-pcie-endcap", XHCIState, flags,
+                    XHCI_FLAG_FORCE_PCIE_ENDCAP, false),
+    DEFINE_PROP_UINT32("intrs", XHCIState, numintrs, MAXINTRS),
+    DEFINE_PROP_UINT32("slots", XHCIState, numslots, MAXSLOTS),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void nec_xhci_class_init(ObjectClass *klass, void *data)
+{
+    PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->props       = nec_xhci_properties;
+    k->vendor_id    = PCI_VENDOR_ID_NEC;
+    k->device_id    = PCI_DEVICE_ID_NEC_UPD720200;
+    k->revision     = 0x03;
+}
+
+static const TypeInfo nec_xhci_info = {
+    .name          = TYPE_NEC_XHCI,
+    .parent        = TYPE_XHCI,
+    .class_init    = nec_xhci_class_init,
+};
+
+static void nec_xhci_register_types(void)
+{
+    type_register_static(&nec_xhci_info);
+}
+
+type_init(nec_xhci_register_types)
diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
index 77d8e1137a..a0c7960a7b 100644
--- a/hw/usb/hcd-xhci.c
+++ b/hw/usb/hcd-xhci.c
@@ -29,6 +29,8 @@
 #include "trace.h"
 #include "qapi/error.h"
 
+#include "hcd-xhci.h"
+
 //#define DEBUG_XHCI
 //#define DEBUG_DATA
 
@@ -40,16 +42,6 @@
 #define FIXME(_msg) do { fprintf(stderr, "FIXME %s:%d %s\n", \
                                  __func__, __LINE__, _msg); abort(); } while (0)
 
-#define MAXPORTS_2 15
-#define MAXPORTS_3 15
-
-#define MAXPORTS (MAXPORTS_2+MAXPORTS_3)
-#define MAXSLOTS 64
-#define MAXINTRS 16
-
-/* Very pessimistic, let's hope it's enough for all cases */
-#define EV_QUEUE (((3 * 24) + 16) * MAXSLOTS)
-
 #define TRB_LINK_LIMIT  32
 #define COMMAND_LIMIT   256
 #define TRANSFER_LIMIT  256
@@ -164,84 +156,8 @@ enum {
     PLS_RESUME          = 15,
 };
 
-typedef enum TRBType {
-    TRB_RESERVED = 0,
-    TR_NORMAL,
-    TR_SETUP,
-    TR_DATA,
-    TR_STATUS,
-    TR_ISOCH,
-    TR_LINK,
-    TR_EVDATA,
-    TR_NOOP,
-    CR_ENABLE_SLOT,
-    CR_DISABLE_SLOT,
-    CR_ADDRESS_DEVICE,
-    CR_CONFIGURE_ENDPOINT,
-    CR_EVALUATE_CONTEXT,
-    CR_RESET_ENDPOINT,
-    CR_STOP_ENDPOINT,
-    CR_SET_TR_DEQUEUE,
-    CR_RESET_DEVICE,
-    CR_FORCE_EVENT,
-    CR_NEGOTIATE_BW,
-    CR_SET_LATENCY_TOLERANCE,
-    CR_GET_PORT_BANDWIDTH,
-    CR_FORCE_HEADER,
-    CR_NOOP,
-    ER_TRANSFER = 32,
-    ER_COMMAND_COMPLETE,
-    ER_PORT_STATUS_CHANGE,
-    ER_BANDWIDTH_REQUEST,
-    ER_DOORBELL,
-    ER_HOST_CONTROLLER,
-    ER_DEVICE_NOTIFICATION,
-    ER_MFINDEX_WRAP,
-    /* vendor specific bits */
-    CR_VENDOR_NEC_FIRMWARE_REVISION  = 49,
-    CR_VENDOR_NEC_CHALLENGE_RESPONSE = 50,
-} TRBType;
-
 #define CR_LINK TR_LINK
 
-typedef enum TRBCCode {
-    CC_INVALID = 0,
-    CC_SUCCESS,
-    CC_DATA_BUFFER_ERROR,
-    CC_BABBLE_DETECTED,
-    CC_USB_TRANSACTION_ERROR,
-    CC_TRB_ERROR,
-    CC_STALL_ERROR,
-    CC_RESOURCE_ERROR,
-    CC_BANDWIDTH_ERROR,
-    CC_NO_SLOTS_ERROR,
-    CC_INVALID_STREAM_TYPE_ERROR,
-    CC_SLOT_NOT_ENABLED_ERROR,
-    CC_EP_NOT_ENABLED_ERROR,
-    CC_SHORT_PACKET,
-    CC_RING_UNDERRUN,
-    CC_RING_OVERRUN,
-    CC_VF_ER_FULL,
-    CC_PARAMETER_ERROR,
-    CC_BANDWIDTH_OVERRUN,
-    CC_CONTEXT_STATE_ERROR,
-    CC_NO_PING_RESPONSE_ERROR,
-    CC_EVENT_RING_FULL_ERROR,
-    CC_INCOMPATIBLE_DEVICE_ERROR,
-    CC_MISSED_SERVICE_ERROR,
-    CC_COMMAND_RING_STOPPED,
-    CC_COMMAND_ABORTED,
-    CC_STOPPED,
-    CC_STOPPED_LENGTH_INVALID,
-    CC_MAX_EXIT_LATENCY_TOO_LARGE_ERROR = 29,
-    CC_ISOCH_BUFFER_OVERRUN = 31,
-    CC_EVENT_LOST_ERROR,
-    CC_UNDEFINED_ERROR,
-    CC_INVALID_STREAM_ID_ERROR,
-    CC_SECONDARY_BANDWIDTH_ERROR,
-    CC_SPLIT_TRANSACTION_ERROR
-} TRBCCode;
-
 #define TRB_C               (1<<0)
 #define TRB_TYPE_SHIFT          10
 #define TRB_TYPE_MASK       0x3f
@@ -301,10 +217,6 @@ typedef enum TRBCCode {
 #define SLOT_CONTEXT_ENTRIES_MASK 0x1f
 #define SLOT_CONTEXT_ENTRIES_SHIFT 27
 
-typedef struct XHCIState XHCIState;
-typedef struct XHCIStreamContext XHCIStreamContext;
-typedef struct XHCIEPContext XHCIEPContext;
-
 #define get_field(data, field)                  \
     (((data) >> field##_SHIFT) & field##_MASK)
 
@@ -326,21 +238,6 @@ typedef enum EPType {
     ET_INTR_IN,
 } EPType;
 
-typedef struct XHCIRing {
-    dma_addr_t dequeue;
-    bool ccs;
-} XHCIRing;
-
-typedef struct XHCIPort {
-    XHCIState *xhci;
-    uint32_t portsc;
-    uint32_t portnr;
-    USBPort  *uport;
-    uint32_t speedmask;
-    char name[16];
-    MemoryRegion mem;
-} XHCIPort;
-
 typedef struct XHCITransfer {
     XHCIEPContext *epctx;
     USBPacket packet;
@@ -402,101 +299,6 @@ struct XHCIEPContext {
     QEMUTimer *kick_timer;
 };
 
-typedef struct XHCISlot {
-    bool enabled;
-    bool addressed;
-    dma_addr_t ctx;
-    USBPort *uport;
-    XHCIEPContext * eps[31];
-} XHCISlot;
-
-typedef struct XHCIEvent {
-    TRBType type;
-    TRBCCode ccode;
-    uint64_t ptr;
-    uint32_t length;
-    uint32_t flags;
-    uint8_t slotid;
-    uint8_t epid;
-} XHCIEvent;
-
-typedef struct XHCIInterrupter {
-    uint32_t iman;
-    uint32_t imod;
-    uint32_t erstsz;
-    uint32_t erstba_low;
-    uint32_t erstba_high;
-    uint32_t erdp_low;
-    uint32_t erdp_high;
-
-    bool msix_used, er_pcs;
-
-    dma_addr_t er_start;
-    uint32_t er_size;
-    unsigned int er_ep_idx;
-
-    /* kept for live migration compat only */
-    bool er_full_unused;
-    XHCIEvent ev_buffer[EV_QUEUE];
-    unsigned int ev_buffer_put;
-    unsigned int ev_buffer_get;
-
-} XHCIInterrupter;
-
-struct XHCIState {
-    /*< private >*/
-    PCIDevice parent_obj;
-    /*< public >*/
-
-    USBBus bus;
-    MemoryRegion mem;
-    MemoryRegion mem_cap;
-    MemoryRegion mem_oper;
-    MemoryRegion mem_runtime;
-    MemoryRegion mem_doorbell;
-
-    /* properties */
-    uint32_t numports_2;
-    uint32_t numports_3;
-    uint32_t numintrs;
-    uint32_t numslots;
-    uint32_t flags;
-    uint32_t max_pstreams_mask;
-    OnOffAuto msi;
-    OnOffAuto msix;
-
-    /* Operational Registers */
-    uint32_t usbcmd;
-    uint32_t usbsts;
-    uint32_t dnctrl;
-    uint32_t crcr_low;
-    uint32_t crcr_high;
-    uint32_t dcbaap_low;
-    uint32_t dcbaap_high;
-    uint32_t config;
-
-    USBPort  uports[MAX(MAXPORTS_2, MAXPORTS_3)];
-    XHCIPort ports[MAXPORTS];
-    XHCISlot slots[MAXSLOTS];
-    uint32_t numports;
-
-    /* Runtime Registers */
-    int64_t mfindex_start;
-    QEMUTimer *mfwrap_timer;
-    XHCIInterrupter intr[MAXINTRS];
-
-    XHCIRing cmd_ring;
-
-    bool nec_quirks;
-};
-
-#define TYPE_XHCI "base-xhci"
-#define TYPE_NEC_XHCI "nec-usb-xhci"
-#define TYPE_QEMU_XHCI "qemu-xhci"
-
-#define XHCI(obj) \
-    OBJECT_CHECK(XHCIState, (obj), TYPE_XHCI)
-
 typedef struct XHCIEvRingSeg {
     uint32_t addr_low;
     uint32_t addr_high;
@@ -504,12 +306,6 @@ typedef struct XHCIEvRingSeg {
     uint32_t rsvd;
 } XHCIEvRingSeg;
 
-enum xhci_flags {
-    XHCI_FLAG_SS_FIRST = 1,
-    XHCI_FLAG_FORCE_PCIE_ENDCAP,
-    XHCI_FLAG_ENABLE_STREAMS,
-};
-
 static void xhci_kick_ep(XHCIState *xhci, unsigned int slotid,
                          unsigned int epid, unsigned int streamid);
 static void xhci_kick_epctx(XHCIEPContext *epctx, unsigned int streamid);
@@ -3843,18 +3639,6 @@ static const VMStateDescription vmstate_xhci = {
     }
 };
 
-static Property nec_xhci_properties[] = {
-    DEFINE_PROP_ON_OFF_AUTO("msi", XHCIState, msi, ON_OFF_AUTO_AUTO),
-    DEFINE_PROP_ON_OFF_AUTO("msix", XHCIState, msix, ON_OFF_AUTO_AUTO),
-    DEFINE_PROP_BIT("superspeed-ports-first",
-                    XHCIState, flags, XHCI_FLAG_SS_FIRST, true),
-    DEFINE_PROP_BIT("force-pcie-endcap", XHCIState, flags,
-                    XHCI_FLAG_FORCE_PCIE_ENDCAP, false),
-    DEFINE_PROP_UINT32("intrs", XHCIState, numintrs, MAXINTRS),
-    DEFINE_PROP_UINT32("slots", XHCIState, numslots, MAXSLOTS),
-    DEFINE_PROP_END_OF_LIST(),
-};
-
 static Property xhci_properties[] = {
     DEFINE_PROP_BIT("streams", XHCIState, flags,
                     XHCI_FLAG_ENABLE_STREAMS, true),
@@ -3886,23 +3670,6 @@ static const TypeInfo xhci_info = {
     .abstract      = true,
 };
 
-static void nec_xhci_class_init(ObjectClass *klass, void *data)
-{
-    PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
-    DeviceClass *dc = DEVICE_CLASS(klass);
-
-    dc->props       = nec_xhci_properties;
-    k->vendor_id    = PCI_VENDOR_ID_NEC;
-    k->device_id    = PCI_DEVICE_ID_NEC_UPD720200;
-    k->revision     = 0x03;
-}
-
-static const TypeInfo nec_xhci_info = {
-    .name          = TYPE_NEC_XHCI,
-    .parent        = TYPE_XHCI,
-    .class_init    = nec_xhci_class_init,
-};
-
 static void qemu_xhci_class_init(ObjectClass *klass, void *data)
 {
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
@@ -3933,7 +3700,6 @@ static const TypeInfo qemu_xhci_info = {
 static void xhci_register_types(void)
 {
     type_register_static(&xhci_info);
-    type_register_static(&nec_xhci_info);
     type_register_static(&qemu_xhci_info);
 }
 
diff --git a/hw/usb/Makefile.objs b/hw/usb/Makefile.objs
index 5958be8ce3..249106f32d 100644
--- a/hw/usb/Makefile.objs
+++ b/hw/usb/Makefile.objs
@@ -8,6 +8,7 @@ common-obj-$(CONFIG_USB_OHCI) += hcd-ohci.o
 common-obj-$(CONFIG_USB_EHCI) += hcd-ehci.o hcd-ehci-pci.o
 common-obj-$(CONFIG_USB_EHCI_SYSBUS) += hcd-ehci-sysbus.o
 common-obj-$(CONFIG_USB_XHCI) += hcd-xhci.o
+common-obj-$(CONFIG_USB_XHCI) += hcd-xhci-nec.o
 common-obj-$(CONFIG_USB_MUSB) += hcd-musb.o
 
 obj-$(CONFIG_TUSB6010) += tusb6010.o
-- 
2.9.3
