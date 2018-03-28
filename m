Received: from eggs.gnu.org ([2001:4830:134:3::10]:43641)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1f1E48-0005vz-9x
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 12:36:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1f1E47-0007nn-B9
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 12:36:48 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33662 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1f1E47-0007na-6A
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 12:36:47 -0400
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Wed, 28 Mar 2018 17:36:28 +0100
Message-Id: <20180328163630.48576-5-dgilbert@redhat.com>
In-Reply-To: <20180328163630.48576-1-dgilbert@redhat.com>
References: <20180328163630.48576-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH v2 4/6] e1000: Migrate props via a temporary
 structure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, eswierk@skyportsystems.com, jasowang@redhat.com, pbonzini@redhat.com
Cc: quintela@redhat.com, peterx@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Swing the tx.props out via a temporary structure, so in future patches
we can select what we're going to send.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 hw/net/e1000.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/hw/net/e1000.c b/hw/net/e1000.c
index bb8ee2acb0..4e606d4b2a 100644
--- a/hw/net/e1000.c
+++ b/hw/net/e1000.c
@@ -130,6 +130,7 @@ typedef struct E1000State_st {
 #define E1000_FLAG_TSO (1 << E1000_FLAG_TSO_BIT)
     uint32_t compat_flags;
     bool received_tx_tso;
+    e1000x_txd_props mig_props;
 } E1000State;
 
 #define chkflag(x)     (s->compat_flags & E1000_FLAG_##x)
@@ -1365,6 +1366,7 @@ static int e1000_pre_save(void *opaque)
         s->phy_reg[PHY_STATUS] |= MII_SR_AUTONEG_COMPLETE;
     }
 
+    s->mig_props = s->tx.props;
     return 0;
 }
 
@@ -1393,12 +1395,13 @@ static int e1000_post_load(void *opaque, int version_id)
                   qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) + 500);
     }
 
+    s->tx.props = s->mig_props;
     if (!s->received_tx_tso) {
         /* We received only one set of offload data (tx.props)
          * and haven't got tx.tso_props.  The best we can do
          * is dupe the data.
          */
-        s->tx.tso_props = s->tx.props;
+        s->tx.tso_props = s->mig_props;
     }
     return 0;
 }
@@ -1496,20 +1499,20 @@ static const VMStateDescription vmstate_e1000 = {
         VMSTATE_UINT16(eecd_state.bitnum_out, E1000State),
         VMSTATE_UINT16(eecd_state.reading, E1000State),
         VMSTATE_UINT32(eecd_state.old_eecd, E1000State),
-        VMSTATE_UINT8(tx.props.ipcss, E1000State),
-        VMSTATE_UINT8(tx.props.ipcso, E1000State),
-        VMSTATE_UINT16(tx.props.ipcse, E1000State),
-        VMSTATE_UINT8(tx.props.tucss, E1000State),
-        VMSTATE_UINT8(tx.props.tucso, E1000State),
-        VMSTATE_UINT16(tx.props.tucse, E1000State),
-        VMSTATE_UINT32(tx.props.paylen, E1000State),
-        VMSTATE_UINT8(tx.props.hdr_len, E1000State),
-        VMSTATE_UINT16(tx.props.mss, E1000State),
+        VMSTATE_UINT8(mig_props.ipcss, E1000State),
+        VMSTATE_UINT8(mig_props.ipcso, E1000State),
+        VMSTATE_UINT16(mig_props.ipcse, E1000State),
+        VMSTATE_UINT8(mig_props.tucss, E1000State),
+        VMSTATE_UINT8(mig_props.tucso, E1000State),
+        VMSTATE_UINT16(mig_props.tucse, E1000State),
+        VMSTATE_UINT32(mig_props.paylen, E1000State),
+        VMSTATE_UINT8(mig_props.hdr_len, E1000State),
+        VMSTATE_UINT16(mig_props.mss, E1000State),
         VMSTATE_UINT16(tx.size, E1000State),
         VMSTATE_UINT16(tx.tso_frames, E1000State),
         VMSTATE_UINT8(tx.sum_needed, E1000State),
-        VMSTATE_INT8(tx.props.ip, E1000State),
-        VMSTATE_INT8(tx.props.tcp, E1000State),
+        VMSTATE_INT8(mig_props.ip, E1000State),
+        VMSTATE_INT8(mig_props.tcp, E1000State),
         VMSTATE_BUFFER(tx.header, E1000State),
         VMSTATE_BUFFER(tx.data, E1000State),
         VMSTATE_UINT16_ARRAY(eeprom_data, E1000State, 64),
-- 
2.14.3
