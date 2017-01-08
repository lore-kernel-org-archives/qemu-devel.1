Received: from eggs.gnu.org ([2001:4830:134:3::10]:50325)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gerhard@wiesinger.com>) id 1cQC54-0001ug-Ih
	for qemu-devel@nongnu.org; Sun, 08 Jan 2017 06:56:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gerhard@wiesinger.com>) id 1cQC51-0001fT-Ct
	for qemu-devel@nongnu.org; Sun, 08 Jan 2017 06:56:10 -0500
Received: from vps01.wiesinger.com ([46.36.37.179]:33316)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <gerhard@wiesinger.com>)
	id 1cQC50-0000gL-Lt
	for qemu-devel@nongnu.org; Sun, 08 Jan 2017 06:56:07 -0500
Received: from wiesinger.com (wiesinger.com [62.178.20.44])
	by vps01.wiesinger.com (Postfix) with ESMTPS id 0364F9F241
	for <qemu-devel@nongnu.org>; Sun,  8 Jan 2017 12:54:56 +0100 (CET)
Received: from [192.168.0.14] ([192.168.0.14]) (authenticated bits=0)
	by wiesinger.com (8.15.2/8.15.2) with ESMTPSA id v08BshnD010944
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO)
	for <qemu-devel@nongnu.org>; Sun, 8 Jan 2017 12:54:54 +0100
From: Gerhard Wiesinger <lists@wiesinger.com>
Message-ID: <efe171ec-dc45-885c-a7a1-b24e1ec48973@wiesinger.com>
Date: Sun, 8 Jan 2017 12:54:43 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH] Add DOS support for RTL8139
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Signed-off-by: Gerhard Wiesinger <lists@wiesinger.com>
---
  hw/net/rtl8139.c | 288 
++++++++++++++++++++++++++++++++++++++++++++++++++-----
  1 file changed, 264 insertions(+), 24 deletions(-)

diff --git a/hw/net/rtl8139.c b/hw/net/rtl8139.c
index f05e59c..5241fea 100644
--- a/hw/net/rtl8139.c
+++ b/hw/net/rtl8139.c
@@ -48,6 +48,17 @@
   *  2011-Mar-22  Benjamin Poirier:  Implemented VLAN offloading
   */
  +/*
+ * Testcases and successful regression tests:
+ * 1.) DOS RSET8139.EXE: EEPROM Test successful
+ * 2.) DOS RSET8139.EXE: Local loopback Test (Run Diagnostics On Board)
+ * 3.) DOS RSET8139.EXE: Remote loopback Test as Initiator (Run 
Diagnostics On Network)
+ * 4.) DOS RSET8139.EXE: Remote loopback Test as Responder (Run 
Diagnostics On Network)
+ * 5.) DOS driver: Loads and works
+ * 6.) Linux tests
+ * 7.) Windows tests
+ */
+
  /* For crc32 */
  #include "qemu/osdep.h"
  #include <zlib.h>
@@ -130,6 +141,7 @@ enum RTL8139_registers {
      NWayExpansion = 0x6A,
      /* Undocumented registers, but required for proper operation. */
      FIFOTMS = 0x70,        /* FIFO Control and test. */
+    RX_ER = 0x72,       /* RX_ER Counter */
      CSCR = 0x74,        /* Chip Status and Configuration Register. */
      PARA78 = 0x78,
      PARA7c = 0x7c,        /* Magic transceiver parameter register. */
@@ -472,6 +484,8 @@ typedef struct RTL8139State {
      uint16_t NWayLPAR;
      uint16_t NWayExpansion;
  +    uint16_t Fifo_TMS;
+
      uint16_t CpCmd;
      uint8_t  TxThresh;
  @@ -757,15 +771,27 @@ static void rtl8139_write_buffer(RTL8139State 
*s, const void *buf, int size)
               if (size > wrapped)
              {
+                DPRINTF(">>> rx packet pci dma write "
+                        "RxBuf=0x%x, RxBufAddr=0x%x, 
RxBuf+RxBufAddr=0x%x, "
+                        "buf=%p, size=%i, wrapped=%i, size-wrapped=%i\n",
+                        s->RxBuf, s->RxBufAddr, s->RxBuf + s->RxBufAddr,
+                        buf, size, wrapped, size - wrapped
+                       );
                  pci_dma_write(d, s->RxBuf + s->RxBufAddr,
-                              buf, size-wrapped);
+                              buf, size - wrapped);
              }
               /* reset buffer pointer */
              s->RxBufAddr = 0;
  +            DPRINTF(">>> rx packet pci dma write "
+                    "RxBuf=0x%x, RxBufAddr=0x%x, RxBuf+RxBufAddr=0x%x, "
+                    "buf=%p, size=%i, wrapped=%i, size-wrapped=%i\n",
+                    s->RxBuf, s->RxBufAddr, s->RxBuf + s->RxBufAddr,
+                    buf, size, wrapped, size - wrapped
+                   );
              pci_dma_write(d, s->RxBuf + s->RxBufAddr,
-                          buf + (size-wrapped), wrapped);
+                          buf + (size - wrapped), wrapped);
               s->RxBufAddr = wrapped;
  @@ -774,6 +800,13 @@ static void rtl8139_write_buffer(RTL8139State *s, 
const void *buf, int size)
      }
       /* non-wrapping path or overwrapping enabled */
+    DPRINTF(">>> rx packet pci dma write "
+            "RxBuf=0x%x, RxBufAddr=0x%x, RxBuf+RxBufAddr=0x%x, "
+            "buf=%p, size=%i\n",
+            s->RxBuf, s->RxBufAddr, s->RxBuf + s->RxBufAddr,
+            buf, size
+           );
+
      pci_dma_write(d, s->RxBuf + s->RxBufAddr, buf, size);
       s->RxBufAddr += size;
@@ -1201,15 +1234,18 @@ static ssize_t rtl8139_receive(NetClientState 
*nc, const uint8_t *buf, size_t si
  static void rtl8139_reset_rxring(RTL8139State *s, uint32_t bufferSize)
  {
      s->RxBufferSize = bufferSize;
+    /* Why not 0xFFF0? */
      s->RxBufPtr  = 0;
      s->RxBufAddr = 0;
  }
  -static void rtl8139_reset(DeviceState *d)
+static void rtl8139_reset_delegate(DeviceState *d, int hard_reset)
  {
      RTL8139State *s = RTL8139(d);
      int i;
  +    DPRINTF("rtl8139_reset_delegate, hard_reset=%i\n", hard_reset);
+
      /* restore MAC address */
      memcpy(s->phys, s->conf.macaddr.a, 6);
      qemu_format_nic_info_str(qemu_get_queue(s->nic), s->phys);
@@ -1233,7 +1269,19 @@ static void rtl8139_reset(DeviceState *d)
      s->RxRingAddrLO = 0;
      s->RxRingAddrHI = 0;
  -    s->RxBuf = 0;
+    /*
+     * DOS driver sets the RxBuf and then resets again.
+     * Afterwards RxBuf is not set anymore. Looks like real hardware
+     * also doesn't reset RxBuf on reset.
+     * When set to 0 DOS OS crashed because of adress 0 is overwritten ...
+     *
+     * On the other hand this must be done on a hardware triggered
+     * reset (a DMA enabled receiver might overwrite some areas!).
+     */
+
+    if (hard_reset) {
+        s->RxBuf = 0;
+    }
       rtl8139_reset_rxring(s, 8192);
  @@ -1264,7 +1312,8 @@ static void rtl8139_reset(DeviceState *d)
   //    s->BasicModeCtrl = 0x3100; // 100Mbps, full duplex, autonegotiation
  //    s->BasicModeCtrl = 0x2100; // 100Mbps, full duplex
-    s->BasicModeCtrl = 0x1000; // autonegotiation
+//    s->BasicModeCtrl = 0x1000; // autonegotiation
+    s->BasicModeCtrl = 0x3100; // 100Mbps, full duplex, autonegotiation
       s->BasicModeStatus  = 0x7809;
      //s->BasicModeStatus |= 0x0040; /* UTP medium */
@@ -1276,6 +1325,8 @@ static void rtl8139_reset(DeviceState *d)
      s->NWayLPAR      = 0x05e1; /* all modes, full duplex */
      s->NWayExpansion = 0x0001; /* autonegotiation supported */
  +    s->Fifo_TMS      = 0x0000; /* Phy N-Way Test Register */
+
      /* also reset timer and disable timer interrupt */
      s->TCTR = 0;
      s->TimerInt = 0;
@@ -1286,6 +1337,11 @@ static void rtl8139_reset(DeviceState *d)
      RTL8139TallyCounters_clear(&s->tally_counters);
  }
  +static void rtl8139_reset(DeviceState *d)
+{
+    rtl8139_reset_delegate(d, 1);
+}
+
  static void RTL8139TallyCounters_clear(RTL8139TallyCounters* counters)
  {
      counters->TxOk = 0;
@@ -1362,7 +1418,7 @@ static void rtl8139_ChipCmd_write(RTL8139State *s, 
uint32_t val)
      if (val & CmdReset)
      {
          DPRINTF("ChipCmd reset\n");
-        rtl8139_reset(d);
+        rtl8139_reset_delegate(d, 0);
      }
      if (val & CmdRxEnb)
      {
@@ -1537,7 +1593,7 @@ static void rtl8139_Cfg9346_write(RTL8139State *s, 
uint32_t val)
      } else if (opmode == 0x40) {
          /* Reset.  */
          val = 0;
-        rtl8139_reset(d);
+        rtl8139_reset_delegate(d, 0);
      }
       s->Cfg9346 = val;
@@ -1702,6 +1758,8 @@ static void rtl8139_TxConfig_write(RTL8139State 
*s, uint32_t val)
      val = SET_MASKED(val, TxVersionMask | 0x8070f80f, s->TxConfig);
       s->TxConfig = val;
+
+    s->currTxDesc = 0;
  }
   static void rtl8139_TxConfig_writeb(RTL8139State *s, uint32_t val)
@@ -1784,7 +1842,8 @@ static void rtl8139_transfer_frame(RTL8139State 
*s, uint8_t *buf, int size,
          }
           DPRINTF("+++ transmit loopback mode\n");
-        rtl8139_do_receive(qemu_get_queue(s->nic), buf, size, 
do_interrupt);
+        /* Interrupt must be triggered here! */
+        rtl8139_do_receive(qemu_get_queue(s->nic), buf, size, 1);
           if (iov) {
              g_free(buf2);
@@ -1827,12 +1886,14 @@ static int rtl8139_transmit_one(RTL8139State *s, 
int descriptor)
       pci_dma_read(d, s->TxAddr[descriptor], txbuffer, txsize);
  -    /* Mark descriptor as transferred */
+    /* Send frame */
+    rtl8139_transfer_frame(s, txbuffer, txsize, 0, NULL);
+
+    /* Mark descriptor as transferred but after sending */
+    /* (now correct and avoids race conditions!) */
      s->TxStatus[descriptor] |= TxHostOwns;
      s->TxStatus[descriptor] |= TxStatOK;
  -    rtl8139_transfer_frame(s, txbuffer, txsize, 0, NULL);
-
      DPRINTF("+++ transmitted %d bytes from descriptor %d\n", txsize,
          descriptor);
  @@ -2420,12 +2481,16 @@ static void 
rtl8139_TxStatus_write(RTL8139State *s, uint32_t txRegOffset, uint32
       DPRINTF("TxStatus write offset=0x%x val=0x%08x descriptor=%d\n",
          txRegOffset, val, descriptor);
+    DPRINTF("TxStatus write old value=0x%08x descriptor=%d\n",
+        s->TxStatus[descriptor], descriptor);
       /* mask only reserved bits */
      val &= ~0xff00c000; /* these bits are reset on write */
      val = SET_MASKED(val, 0x00c00000, s->TxStatus[descriptor]);
       s->TxStatus[descriptor] = val;
+    DPRINTF("TxStatus write new value=0x%08x descriptor=%d\n",
+        s->TxStatus[descriptor], descriptor);
       /* attempt to start transmission */
      rtl8139_transmit(s);
@@ -2596,6 +2661,16 @@ static void rtl8139_IntrStatus_write(RTL8139State 
*s, uint32_t val)
  {
      DPRINTF("IntrStatus write(w) val=0x%04x\n", val);
  +    /*
+     * According to the specification writing to ISR must
+     * have no effect: "Writing to the ISR has no effect."
+     * http://www.cs.usfca.edu/~cruse/cs326/RTL8139D_DataSheet.pdf
+     *
+     * According to the newer specification writing to ISR clears
+     * ones bits!!
+     * http://realtek.info/pdf/rtl8139cp.pdf
+     * See also: http://www.lowlevel.eu/wiki/RTL8139
+     */
  #if 0
       /* writing to ISR has no effect */
@@ -2625,6 +2700,16 @@ static uint32_t 
rtl8139_IntrStatus_read(RTL8139State *s)
       DPRINTF("IntrStatus read(w) val=0x%04x\n", ret);
  +    /*
+     * According to the specification interrupts have to be cleared.
+     * "Reading the ISR clears all interrupts"
+     * http://www.cs.usfca.edu/~cruse/cs326/RTL8139D_DataSheet.pdf
+     *
+     * But according to newer specifications all interrupt bits
+     * are not cleared!!!
+     * http://realtek.info/pdf/rtl8139cp.pdf
+     * See also: http://www.lowlevel.eu/wiki/RTL8139
+     */
  #if 0
       /* reading ISR clears all interrupts */
@@ -2662,22 +2747,28 @@ static void rtl8139_io_writeb(void *opaque, 
uint8_t addr, uint32_t val)
       switch (addr)
      {
-        case MAC0 ... MAC0+4:
+        case MAC0 ... MAC0 + 4:
              s->phys[addr - MAC0] = val;
              break;
-        case MAC0+5:
+        case MAC0 + 5:
              s->phys[addr - MAC0] = val;
              qemu_format_nic_info_str(qemu_get_queue(s->nic), s->phys);
              break;
-        case MAC0+6 ... MAC0+7:
+        case MAC0 + 6 ... MAC0 + 7:
              /* reserved */
              break;
-        case MAR0 ... MAR0+7:
+        case MAR0 ... MAR0 + 7:
              s->mult[addr - MAR0] = val;
              break;
          case ChipCmd:
              rtl8139_ChipCmd_write(s, val);
              break;
+        case IntrMask:
+            s->IntrMask = (s->IntrMask & 0xFF00) | (val & 0xFF);
+            break;
+        case IntrStatus:
+            rtl8139_IntrStatus_write(s, val & 0xFF);
+            break;
          case Cfg9346:
              rtl8139_Cfg9346_write(s, val);
              break;
@@ -2699,6 +2790,29 @@ static void rtl8139_io_writeb(void *opaque, 
uint8_t addr, uint32_t val)
          case Config5:
              rtl8139_Config5_write(s, val);
              break;
+        case RX_ER:
+            s->tally_counters.RxERR = (s->tally_counters.RxERR & 
0xFF00) | (val & 0xFF);
+            break;
+        case RX_ER + 1:
+            s->tally_counters.RxERR = ((val & 0xFF) << 8) | 
(s->tally_counters.RxERR & 0xFF);
+            break;
+        case FIFOTMS:
+            s->Fifo_TMS = (s->Fifo_TMS & 0xFF00) | (val & 0xFF);
+            break;
+        case FIFOTMS + 1:
+            s->Fifo_TMS = ((val & 0xFF) << 8) | (s->Fifo_TMS & 0xFF);
+            break;
+        case PARA78:
+        case PARA78 + 1:
+        case PARA78 + 2:
+        case PARA78 + 3:
+        case PARA7c:
+        case PARA7c + 1:
+        case PARA7c + 2:
+        case PARA7c + 3:
+            DPRINTF("not implemented write(b) to PARA%02x val=0x%02x\n",
+                addr, val);
+            break;
          case MediaStatus:
              /* ignore */
              DPRINTF("not implemented write(b) to MediaStatus 
val=0x%02x\n",
@@ -2785,6 +2899,10 @@ static void rtl8139_io_writew(void *opaque, 
uint8_t addr, uint32_t val)
              s->NWayExpansion = val;
              break;
  +        case FIFOTMS:
+            DPRINTF("Fifo_TMS write(w) val=0x%04x\n", val);
+            s->Fifo_TMS = val;
+            break;
          case CpCmd:
              rtl8139_CpCmd_write(s, val);
              break;
@@ -2904,22 +3022,41 @@ static uint32_t rtl8139_io_readb(void *opaque, 
uint8_t addr)
       switch (addr)
      {
-        case MAC0 ... MAC0+5:
+        case MAC0 ... MAC0 + 5:
              ret = s->phys[addr - MAC0];
              break;
-        case MAC0+6 ... MAC0+7:
+        case MAC0 + 6 ... MAC0 + 7:
              ret = 0;
              break;
-        case MAR0 ... MAR0+7:
+        case MAR0 ... MAR0 + 7:
              ret = s->mult[addr - MAR0];
              break;
-        case TxStatus0 ... TxStatus0+4*4-1:
+        case TxStatus0 ... TxStatus0 + 4 * 4 - 1:
              ret = rtl8139_TxStatus_TxAddr_read(s, s->TxStatus, TxStatus0,
                                                 addr, 1);
              break;
+        case TxAddr0 ... TxAddr0 + 4 * 4 - 1:
+            {
+                int offset = (addr - TxAddr0) / 4;
+                int shift = ((addr - TxAddr0) % 4) << 3;
+                ret = (s->TxAddr[offset] >> shift) & 0xFF;
+            }
+            break;
          case ChipCmd:
              ret = rtl8139_ChipCmd_read(s);
              break;
+        case RxBufPtr:
+            ret = s->RxBufPtr & 0xFF;
+            break;
+        case RxBufAddr:
+            ret = s->RxBufAddr & 0xFF;
+            break;
+        case IntrMask:
+            ret = s->IntrMask & 0xFF;
+            break;
+        case IntrStatus:
+            ret = s->IntrStatus & 0xFF;
+            break;
          case Cfg9346:
              ret = rtl8139_Cfg9346_read(s);
              break;
@@ -2927,7 +3064,10 @@ static uint32_t rtl8139_io_readb(void *opaque, 
uint8_t addr)
              ret = rtl8139_Config0_read(s);
              break;
          case Config1:
-            ret = rtl8139_Config1_read(s);
+            ret = rtl8139_Config1_read(s) & 0xFF;
+            break;
+        case Config1 + 1:
+            ret = (rtl8139_Config1_read(s) >> 8) & 0xFF;
              break;
          case Config3:
              ret = rtl8139_Config3_read(s);
@@ -2938,7 +3078,30 @@ static uint32_t rtl8139_io_readb(void *opaque, 
uint8_t addr)
          case Config5:
              ret = rtl8139_Config5_read(s);
              break;
-
+        case RX_ER:
+            ret = s->tally_counters.RxERR & 0xFF;
+            break;
+        case RX_ER + 1:
+            ret = (s->tally_counters.RxERR >> 8) & 0xFF;
+            break;
+        case RxConfig:
+            ret = s->RxConfig & 0xFF;
+            break;
+        case RxConfig + 1:
+            ret = (s->RxConfig >> 8) & 0xFF;
+            break;
+        case FIFOTMS:
+            ret = s->Fifo_TMS & 0xFF;
+            break;
+        case FIFOTMS + 1:
+            ret = (s->Fifo_TMS >> 8) & 0xFF;
+            break;
+        case BasicModeCtrl:
+            ret = s->BasicModeCtrl & 0xFF;
+            break;
+        case BasicModeCtrl + 1:
+            ret = (s->BasicModeCtrl >> 8) & 0xFF;
+            break;
          case MediaStatus:
              /* The LinkDown bit of MediaStatus is inverse with link 
status */
              ret = 0xd0 | (~s->BasicModeStatus & 0x04);
@@ -2981,7 +3144,7 @@ static uint32_t rtl8139_io_readw(void *opaque, 
uint8_t addr)
       switch (addr)
      {
-        case TxAddr0 ... TxAddr0+4*4-1:
+        case TxAddr0 ... TxAddr0 + 4 * 4 - 1:
              ret = rtl8139_TxStatus_TxAddr_read(s, s->TxAddr, TxAddr0, 
addr, 2);
              break;
          case IntrMask:
@@ -3022,6 +3185,10 @@ static uint32_t rtl8139_io_readw(void *opaque, 
uint8_t addr)
              ret = s->NWayExpansion;
              DPRINTF("NWayExpansion read(w) val=0x%04x\n", ret);
              break;
+        case FIFOTMS:
+            ret = s->Fifo_TMS;
+            DPRINTF("Fifo_TMS read(w) val=0x%04x\n", ret);
+            break;
           case CpCmd:
              ret = rtl8139_CpCmd_read(s);
@@ -3073,12 +3240,12 @@ static uint32_t rtl8139_io_readl(void *opaque, 
uint8_t addr)
              ret = rtl8139_RxConfig_read(s);
              break;
  -        case TxStatus0 ... TxStatus0+4*4-1:
+        case TxStatus0 ... TxStatus0 + 4 * 4 - 1:
              ret = rtl8139_TxStatus_TxAddr_read(s, s->TxStatus, TxStatus0,
                                                 addr, 4);
              break;
  -        case TxAddr0 ... TxAddr0+4*4-1:
+        case TxAddr0 ... TxAddr0 + 4 * 4 - 1:
              ret = rtl8139_TxAddr_read(s, addr-TxAddr0);
              break;
  @@ -3239,6 +3406,7 @@ static const VMStateDescription vmstate_rtl8139 = {
          VMSTATE_UINT16(NWayAdvert, RTL8139State),
          VMSTATE_UINT16(NWayLPAR, RTL8139State),
          VMSTATE_UINT16(NWayExpansion, RTL8139State),
+        VMSTATE_UINT16(Fifo_TMS, RTL8139State),
           VMSTATE_UINT16(CpCmd, RTL8139State),
          VMSTATE_UINT8(TxThresh, RTL8139State),
@@ -3405,6 +3573,8 @@ static void pci_rtl8139_realize(PCIDevice *dev, 
Error **errp)
      RTL8139State *s = RTL8139(dev);
      DeviceState *d = DEVICE(dev);
      uint8_t *pci_conf;
+    int i = 0;
+    uint16_t checksum = 0;
       pci_conf = dev->config;
      pci_conf[PCI_INTERRUPT_PIN] = 1;    /* interrupt pin A */
@@ -3428,10 +3598,73 @@ static void pci_rtl8139_realize(PCIDevice *dev, 
Error **errp)
      s->eeprom.contents[1] = PCI_VENDOR_ID_REALTEK;
      s->eeprom.contents[2] = PCI_DEVICE_ID_REALTEK_8139;
  #endif
+
+#define ALTERNATE_EEPROM_CONTENTS
+#ifndef ALTERNATE_EEPROM_CONTENTS
+    /* PCI subsystem vendor and device ID should be mirrored here */
+    s->eeprom.contents[3] = PCI_VENDOR_ID_REALTEK;
+    s->eeprom.contents[4] = PCI_DEVICE_ID_REALTEK_8139;
+    s->eeprom.contents[5] = 0x4020;
+    s->eeprom.contents[6] = 0xE110;
      s->eeprom.contents[7] = s->conf.macaddr.a[0] | 
s->conf.macaddr.a[1] << 8;
      s->eeprom.contents[8] = s->conf.macaddr.a[2] | 
s->conf.macaddr.a[3] << 8;
      s->eeprom.contents[9] = s->conf.macaddr.a[4] | 
s->conf.macaddr.a[5] << 8;
  +    s->eeprom.contents[10] = 0x4D10;
+    s->eeprom.contents[11] = 0xF7C2;
+    s->eeprom.contents[12] = 0x8001;
+    s->eeprom.contents[13] = 0xB388;
+    s->eeprom.contents[14] = 0x58FA;
+    s->eeprom.contents[15] = 0x0708;
+    s->eeprom.contents[16] = 0xD843;
+    s->eeprom.contents[17] = 0xA438;
+    s->eeprom.contents[18] = 0xD843;
+    s->eeprom.contents[19] = 0xA438;
+    s->eeprom.contents[20] = 0xD843;
+    s->eeprom.contents[21] = 0xA438;
+    s->eeprom.contents[22] = 0xD843;
+    s->eeprom.contents[23] = 0xA438;
+
+    s->eeprom.contents[31] = 0x2000;
+#else
+    /* PCI subsystem vendor and device ID should be mirrored here */
+    s->eeprom.contents[3] = 0x10BD;
+    s->eeprom.contents[4] = 0x0320;
+    s->eeprom.contents[5] = 0x4020;
+    s->eeprom.contents[6] = 0xE512;
+    s->eeprom.contents[7] = s->conf.macaddr.a[0] | s->conf.macaddr.a[1] 
<< 8;
+    s->eeprom.contents[8] = s->conf.macaddr.a[2] | s->conf.macaddr.a[3] 
<< 8;
+    s->eeprom.contents[9] = s->conf.macaddr.a[4] | s->conf.macaddr.a[5] 
<< 8;
+    s->eeprom.contents[10] = 0x4D10;
+    s->eeprom.contents[11] = 0xF7C2;
+    s->eeprom.contents[12] = 0x8801;
+    s->eeprom.contents[13] = 0x03B9;
+    s->eeprom.contents[14] = 0x60F4;
+    s->eeprom.contents[15] = 0x071A;
+    s->eeprom.contents[16] = 0xDFA3;
+    s->eeprom.contents[17] = 0x9836;
+    s->eeprom.contents[18] = 0xDFA3;
+    s->eeprom.contents[19] = 0x9836;
+    s->eeprom.contents[20] = 0x03B9;
+    s->eeprom.contents[21] = 0x60F4;
+    s->eeprom.contents[22] = 0x1A1A;
+    s->eeprom.contents[23] = 0x1A1A;
+
+    s->eeprom.contents[31] = 0x2000;
+#endif
+
+    for (i = 0; i < 24; i++) {
+        checksum += s->eeprom.contents[i];
+    }
+    checksum = (~checksum + 1) & 0xFFFF;
+    DPRINTF("EEPROM checksum=0x%04X\n", checksum);
+    s->eeprom.contents[25] = checksum; /* Checksum */
+
+    DPRINTF("EEPROM contents\n");
+    for (i = 0; i < 64; i++) {
+        DPRINTF("0x%04X,%s", s->eeprom.contents[i], ((i + 1) % 8) == 0 
? "\n" : " ");
+    }
+
      s->nic = qemu_new_nic(&net_rtl8139_info, &s->conf,
                            object_get_typename(OBJECT(dev)), d->id, s);
      qemu_format_nic_info_str(qemu_get_queue(s->nic), s->conf.macaddr.a);
@@ -3467,6 +3700,13 @@ static void rtl8139_class_init(ObjectClass 
*klass, void *data)
      k->romfile = "efi-rtl8139.rom";
      k->vendor_id = PCI_VENDOR_ID_REALTEK;
      k->device_id = PCI_DEVICE_ID_REALTEK_8139;
+#ifndef ALTERNATE_EEPROM_CONTENTS
+    k->subsystem_vendor_id = PCI_VENDOR_ID_REALTEK;
+    k->subsystem_id = PCI_DEVICE_ID_REALTEK_8139;
+#else
+    k->subsystem_vendor_id = 0x10BD;
+    k->subsystem_id = 0x0320;
+#endif
      k->revision = RTL8139_PCI_REVID; /* >=0x20 is for 8139C+ */
      k->class_id = PCI_CLASS_NETWORK_ETHERNET;
      dc->reset = rtl8139_reset;
-- 
2.9.3
