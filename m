Received: from eggs.gnu.org ([2001:4830:134:3::10]:35664)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1f0msd-0005b6-TJ
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 07:35:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1f0msY-0007HM-C6
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 07:35:07 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54154 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1f0msY-0007Gv-83
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 07:35:02 -0400
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Tue, 27 Mar 2018 12:34:51 +0100
Message-Id: <20180327113452.19613-3-dgilbert@redhat.com>
In-Reply-To: <20180327113452.19613-1-dgilbert@redhat.com>
References: <20180327113452.19613-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH 2/3] e1000: wire new subsection to property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, eswierk@skyportsystems.com, jasowang@redhat.com
Cc: quintela@redhat.com, peterx@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Wire the new subsection from the previous commit to a property
so we can turn it off easily.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 hw/net/e1000.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/hw/net/e1000.c b/hw/net/e1000.c
index 24e9a4ab40..0562b8c547 100644
--- a/hw/net/e1000.c
+++ b/hw/net/e1000.c
@@ -123,9 +123,11 @@ typedef struct E1000State_st {
 #define E1000_FLAG_AUTONEG_BIT 0
 #define E1000_FLAG_MIT_BIT 1
 #define E1000_FLAG_MAC_BIT 2
+#define E1000_FLAG_TSO_BIT 3
 #define E1000_FLAG_AUTONEG (1 << E1000_FLAG_AUTONEG_BIT)
 #define E1000_FLAG_MIT (1 << E1000_FLAG_MIT_BIT)
 #define E1000_FLAG_MAC (1 << E1000_FLAG_MAC_BIT)
+#define E1000_FLAG_TSO (1 << E1000_FLAG_TSO_BIT)
     uint32_t compat_flags;
 } E1000State;
 
@@ -1407,6 +1409,13 @@ static bool e1000_full_mac_needed(void *opaque)
     return chkflag(MAC);
 }
 
+static bool e1000_tso_state_needed(void *opaque)
+{
+    E1000State *s = opaque;
+
+    return chkflag(TSO);
+}
+
 static const VMStateDescription vmstate_e1000_mit_state = {
     .name = "e1000/mit_state",
     .version_id = 1,
@@ -1437,6 +1446,7 @@ static const VMStateDescription vmstate_e1000_tx_tso_state = {
     .name = "e1000/tx_tso_state",
     .version_id = 1,
     .minimum_version_id = 1,
+    .needed = e1000_tso_state_needed,
     .fields = (VMStateField[]) {
         VMSTATE_UINT8(tx.tso_props.ipcss, E1000State),
         VMSTATE_UINT8(tx.tso_props.ipcso, E1000State),
@@ -1661,6 +1671,8 @@ static Property e1000_properties[] = {
                     compat_flags, E1000_FLAG_MIT_BIT, true),
     DEFINE_PROP_BIT("extra_mac_registers", E1000State,
                     compat_flags, E1000_FLAG_MAC_BIT, true),
+    DEFINE_PROP_BIT("migrate_tso_props", E1000State,
+                    compat_flags, E1000_FLAG_TSO_BIT, true),
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
2.14.3
