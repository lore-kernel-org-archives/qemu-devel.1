Received: from eggs.gnu.org ([2001:4830:134:3::10]:43611)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1f1E46-0005vD-4c
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 12:36:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1f1E42-0007ls-W4
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 12:36:46 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53864 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1f1E42-0007lW-RH
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 12:36:42 -0400
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Wed, 28 Mar 2018 17:36:26 +0100
Message-Id: <20180328163630.48576-3-dgilbert@redhat.com>
In-Reply-To: <20180328163630.48576-1-dgilbert@redhat.com>
References: <20180328163630.48576-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH v2 2/6] e1000: Dupe offload data on reading old
 stream
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

Old QEMUs only had one set of offload data;  when we only receive
one lot, dupe the received data - that should give us about the
same bug level as the old version.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 hw/net/e1000.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/hw/net/e1000.c b/hw/net/e1000.c
index 24e9a4ab40..d399ce3e4f 100644
--- a/hw/net/e1000.c
+++ b/hw/net/e1000.c
@@ -127,6 +127,7 @@ typedef struct E1000State_st {
 #define E1000_FLAG_MIT (1 << E1000_FLAG_MIT_BIT)
 #define E1000_FLAG_MAC (1 << E1000_FLAG_MAC_BIT)
     uint32_t compat_flags;
+    bool received_tx_tso;
 } E1000State;
 
 #define chkflag(x)     (s->compat_flags & E1000_FLAG_##x)
@@ -1390,6 +1391,20 @@ static int e1000_post_load(void *opaque, int version_id)
                   qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) + 500);
     }
 
+    if (!s->received_tx_tso) {
+        /* We received only one set of offload data (tx.props)
+         * and haven't got tx.tso_props.  The best we can do
+         * is dupe the data.
+         */
+        s->tx.tso_props = s->tx.props;
+    }
+    return 0;
+}
+
+static int e1000_tx_tso_post_load(void *opaque, int version_id)
+{
+    E1000State *s = opaque;
+    s->received_tx_tso = true;
     return 0;
 }
 
@@ -1437,6 +1452,7 @@ static const VMStateDescription vmstate_e1000_tx_tso_state = {
     .name = "e1000/tx_tso_state",
     .version_id = 1,
     .minimum_version_id = 1,
+    .post_load = e1000_tx_tso_post_load,
     .fields = (VMStateField[]) {
         VMSTATE_UINT8(tx.tso_props.ipcss, E1000State),
         VMSTATE_UINT8(tx.tso_props.ipcso, E1000State),
-- 
2.14.3
