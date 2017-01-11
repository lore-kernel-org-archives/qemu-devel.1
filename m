Received: from eggs.gnu.org ([2001:4830:134:3::10]:51208)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gerg@uclinux.org>) id 1cRH6p-0007o3-RI
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 06:30:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gerg@uclinux.org>) id 1cRH6m-0007sD-MR
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 06:30:27 -0500
Received: from icp-osb-irony-out4.external.iinet.net.au ([203.59.1.220]:62810)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gerg@uclinux.org>) id 1cRH6l-0007ps-Ny
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 06:30:24 -0500
From: Greg Ungerer <gerg@uclinux.org>
Date: Wed, 11 Jan 2017 21:30:14 +1000
Message-Id: <1484134214-32640-1-git-send-email-gerg@uclinux.org>
Subject: [Qemu-devel] [PATCHv2] hw/net: implement MIB counters in mcf_fec
 driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Greg Ungerer <gerg@uclinux.org>

The FEC ethernet hardware module used on ColdFire SoC parts contains a
block of RAM used to maintain hardware counters. This block is accessible
via the usual FEC register address space. There is currently no support
for this in the QEMU mcf_fec driver.

Add support for storing a MIB RAM block, and provide register level
access to it. Also implement a basic set of stats collection functions
to populate MIB data fields.

This support tested running a Linux target and using the net-tools
"ethtool -S" option. As of linux-4.9 the kernels FEC driver makes
accesses to the MIB counters during its initialization (which it never
did before), and so this version of Linux will now fail with the QEMU
error:

    qemu: hardware error: mcf_fec_read: Bad address 0x200

This MIB counter support fixes this problem.

Signed-off-by: Greg Ungerer <gerg@uclinux.org>
---

v2: fixed formatting problems picked up by checkpatch

 hw/net/mcf_fec.c | 115 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 115 insertions(+)

diff --git a/hw/net/mcf_fec.c b/hw/net/mcf_fec.c
index 4025eb3..c74804b 100644
--- a/hw/net/mcf_fec.c
+++ b/hw/net/mcf_fec.c
@@ -25,6 +25,7 @@ do { printf("mcf_fec: " fmt , ## __VA_ARGS__); } while (0)
 
 #define FEC_MAX_DESC 1024
 #define FEC_MAX_FRAME_SIZE 2032
+#define FEC_MIB_SIZE 64
 
 typedef struct {
     MemoryRegion *sysmem;
@@ -48,6 +49,7 @@ typedef struct {
     uint32_t erdsr;
     uint32_t etdsr;
     uint32_t emrbr;
+    uint32_t mib[FEC_MIB_SIZE];
 } mcf_fec_state;
 
 #define FEC_INT_HB   0x80000000
@@ -109,6 +111,63 @@ typedef struct {
 #define FEC_BD_OV   0x0002
 #define FEC_BD_TR   0x0001
 
+#define MIB_RMON_T_DROP         0
+#define MIB_RMON_T_PACKETS      1
+#define MIB_RMON_T_BC_PKT       2
+#define MIB_RMON_T_MC_PKT       3
+#define MIB_RMON_T_CRC_ALIGN    4
+#define MIB_RMON_T_UNDERSIZE    5
+#define MIB_RMON_T_OVERSIZE     6
+#define MIB_RMON_T_FRAG         7
+#define MIB_RMON_T_JAB          8
+#define MIB_RMON_T_COL          9
+#define MIB_RMON_T_P64          10
+#define MIB_RMON_T_P65TO127     11
+#define MIB_RMON_T_P128TO255    12
+#define MIB_RMON_T_P256TO511    13
+#define MIB_RMON_T_P512TO1023   14
+#define MIB_RMON_T_P1024TO2047  15
+#define MIB_RMON_T_P_GTE2048    16
+#define MIB_RMON_T_OCTETS       17
+#define MIB_IEEE_T_DROP         18
+#define MIB_IEEE_T_FRAME_OK     19
+#define MIB_IEEE_T_1COL         20
+#define MIB_IEEE_T_MCOL         21
+#define MIB_IEEE_T_DEF          22
+#define MIB_IEEE_T_LCOL         23
+#define MIB_IEEE_T_EXCOL        24
+#define MIB_IEEE_T_MACERR       25
+#define MIB_IEEE_T_CSERR        26
+#define MIB_IEEE_T_SQE          27
+#define MIB_IEEE_T_FDXFC        28
+#define MIB_IEEE_T_OCTETS_OK    29
+
+#define MIB_RMON_R_DROP         32
+#define MIB_RMON_R_PACKETS      33
+#define MIB_RMON_R_BC_PKT       34
+#define MIB_RMON_R_MC_PKT       35
+#define MIB_RMON_R_CRC_ALIGN    36
+#define MIB_RMON_R_UNDERSIZE    37
+#define MIB_RMON_R_OVERSIZE     38
+#define MIB_RMON_R_FRAG         39
+#define MIB_RMON_R_JAB          40
+#define MIB_RMON_R_RESVD_0      41
+#define MIB_RMON_R_P64          42
+#define MIB_RMON_R_P65TO127     43
+#define MIB_RMON_R_P128TO255    44
+#define MIB_RMON_R_P256TO511    45
+#define MIB_RMON_R_P512TO1023   46
+#define MIB_RMON_R_P1024TO2047  47
+#define MIB_RMON_R_P_GTE2048    48
+#define MIB_RMON_R_OCTETS       49
+#define MIB_IEEE_R_DROP         50
+#define MIB_IEEE_R_FRAME_OK     51
+#define MIB_IEEE_R_CRC          52
+#define MIB_IEEE_R_ALIGN        53
+#define MIB_IEEE_R_MACERR       54
+#define MIB_IEEE_R_FDXFC        55
+#define MIB_IEEE_R_OCTETS_OK    56
+
 static void mcf_fec_read_bd(mcf_fec_bd *bd, uint32_t addr)
 {
     cpu_physical_memory_read(addr, bd, sizeof(*bd));
@@ -145,6 +204,31 @@ static void mcf_fec_update(mcf_fec_state *s)
     s->irq_state = active;
 }
 
+static void mcf_fec_tx_stats(mcf_fec_state *s, int size)
+{
+    s->mib[MIB_RMON_T_PACKETS]++;
+    s->mib[MIB_RMON_T_OCTETS] += size;
+    if (size < 64) {
+        s->mib[MIB_RMON_T_FRAG]++;
+    } else if (size == 64) {
+        s->mib[MIB_RMON_T_P64]++;
+    } else if (size < 128) {
+        s->mib[MIB_RMON_T_P65TO127]++;
+    } else if (size < 256) {
+        s->mib[MIB_RMON_T_P128TO255]++;
+    } else if (size < 512) {
+        s->mib[MIB_RMON_T_P256TO511]++;
+    } else if (size < 1024) {
+        s->mib[MIB_RMON_T_P512TO1023]++;
+    } else if (size < 2048) {
+        s->mib[MIB_RMON_T_P1024TO2047]++;
+    } else {
+        s->mib[MIB_RMON_T_P_GTE2048]++;
+    }
+    s->mib[MIB_IEEE_T_FRAME_OK]++;
+    s->mib[MIB_IEEE_T_OCTETS_OK] += size;
+}
+
 static void mcf_fec_do_tx(mcf_fec_state *s)
 {
     uint32_t addr;
@@ -178,6 +262,7 @@ static void mcf_fec_do_tx(mcf_fec_state *s)
             /* Last buffer in frame.  */
             DPRINTF("Sending packet\n");
             qemu_send_packet(qemu_get_queue(s->nic), frame, frame_size);
+            mcf_fec_tx_stats(s, frame_size);
             ptr = frame;
             frame_size = 0;
             s->eir |= FEC_INT_TXF;
@@ -298,6 +383,7 @@ static uint64_t mcf_fec_read(void *opaque, hwaddr addr,
     case 0x180: return s->erdsr;
     case 0x184: return s->etdsr;
     case 0x188: return s->emrbr;
+    case 0x200 ... 0x2e0: return s->mib[(addr & 0x1ff) / 4];
     default:
         hw_error("mcf_fec_read: Bad address 0x%x\n", (int)addr);
         return 0;
@@ -395,12 +481,40 @@ static void mcf_fec_write(void *opaque, hwaddr addr,
     case 0x188:
         s->emrbr = value > 0 ? value & 0x7F0 : 0x7F0;
         break;
+    case 0x200 ... 0x2e0:
+        s->mib[(addr & 0x1ff) / 4] = value;
+        break;
     default:
         hw_error("mcf_fec_write Bad address 0x%x\n", (int)addr);
     }
     mcf_fec_update(s);
 }
 
+static void mcf_fec_rx_stats(mcf_fec_state *s, int size)
+{
+    s->mib[MIB_RMON_R_PACKETS]++;
+    s->mib[MIB_RMON_R_OCTETS] += size;
+    if (size < 64) {
+        s->mib[MIB_RMON_R_FRAG]++;
+    } else if (size == 64) {
+        s->mib[MIB_RMON_R_P64]++;
+    } else if (size < 128) {
+        s->mib[MIB_RMON_R_P65TO127]++;
+    } else if (size < 256) {
+        s->mib[MIB_RMON_R_P128TO255]++;
+    } else if (size < 512) {
+        s->mib[MIB_RMON_R_P256TO511]++;
+    } else if (size < 1024) {
+        s->mib[MIB_RMON_R_P512TO1023]++;
+    } else if (size < 2048) {
+        s->mib[MIB_RMON_R_P1024TO2047]++;
+    } else {
+        s->mib[MIB_RMON_R_P_GTE2048]++;
+    }
+    s->mib[MIB_IEEE_R_FRAME_OK]++;
+    s->mib[MIB_IEEE_R_OCTETS_OK] += size;
+}
+
 static int mcf_fec_have_receive_space(mcf_fec_state *s, size_t want)
 {
     mcf_fec_bd bd;
@@ -496,6 +610,7 @@ static ssize_t mcf_fec_receive(NetClientState *nc, const uint8_t *buf, size_t si
         }
     }
     s->rx_descriptor = addr;
+    mcf_fec_rx_stats(s, retsize);
     mcf_fec_enable_rx(s);
     mcf_fec_update(s);
     return retsize;
-- 
1.9.1
