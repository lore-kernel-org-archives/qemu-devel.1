Received: from eggs.gnu.org ([2001:4830:134:3::10]:35644)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1f0msd-0005aS-7H
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 07:35:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1f0msY-0007HJ-Bz
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 07:35:07 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42838 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1f0msY-0007Gt-7B
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 07:35:02 -0400
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Tue, 27 Mar 2018 12:34:50 +0100
Message-Id: <20180327113452.19613-2-dgilbert@redhat.com>
In-Reply-To: <20180327113452.19613-1-dgilbert@redhat.com>
References: <20180327113452.19613-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PATCH 1/3] e1000: Convert v3 fields to subsection
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

A bunch of new TSO fields were introduced by d62644b4 and this bumped
the VMState version; however it's easier for those trying to keep
backwards migration compatibility if these fields are added in a
subsection instead.

Move the new fields to a subsection.

Since this was added after 2.11, this change will only affect
compatbility with 2.12-rc0.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 hw/net/e1000.c | 34 ++++++++++++++++++++++------------
 1 file changed, 22 insertions(+), 12 deletions(-)

diff --git a/hw/net/e1000.c b/hw/net/e1000.c
index c7f1695f57..24e9a4ab40 100644
--- a/hw/net/e1000.c
+++ b/hw/net/e1000.c
@@ -1433,9 +1433,29 @@ static const VMStateDescription vmstate_e1000_full_mac_state = {
     }
 };
 
+static const VMStateDescription vmstate_e1000_tx_tso_state = {
+    .name = "e1000/tx_tso_state",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT8(tx.tso_props.ipcss, E1000State),
+        VMSTATE_UINT8(tx.tso_props.ipcso, E1000State),
+        VMSTATE_UINT16(tx.tso_props.ipcse, E1000State),
+        VMSTATE_UINT8(tx.tso_props.tucss, E1000State),
+        VMSTATE_UINT8(tx.tso_props.tucso, E1000State),
+        VMSTATE_UINT16(tx.tso_props.tucse, E1000State),
+        VMSTATE_UINT32(tx.tso_props.paylen, E1000State),
+        VMSTATE_UINT8(tx.tso_props.hdr_len, E1000State),
+        VMSTATE_UINT16(tx.tso_props.mss, E1000State),
+        VMSTATE_INT8(tx.tso_props.ip, E1000State),
+        VMSTATE_INT8(tx.tso_props.tcp, E1000State),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static const VMStateDescription vmstate_e1000 = {
     .name = "e1000",
-    .version_id = 3,
+    .version_id = 2,
     .minimum_version_id = 1,
     .pre_save = e1000_pre_save,
     .post_load = e1000_post_load,
@@ -1508,22 +1528,12 @@ static const VMStateDescription vmstate_e1000 = {
         VMSTATE_UINT32_SUB_ARRAY(mac_reg, E1000State, RA, 32),
         VMSTATE_UINT32_SUB_ARRAY(mac_reg, E1000State, MTA, 128),
         VMSTATE_UINT32_SUB_ARRAY(mac_reg, E1000State, VFTA, 128),
-        VMSTATE_UINT8_V(tx.tso_props.ipcss, E1000State, 3),
-        VMSTATE_UINT8_V(tx.tso_props.ipcso, E1000State, 3),
-        VMSTATE_UINT16_V(tx.tso_props.ipcse, E1000State, 3),
-        VMSTATE_UINT8_V(tx.tso_props.tucss, E1000State, 3),
-        VMSTATE_UINT8_V(tx.tso_props.tucso, E1000State, 3),
-        VMSTATE_UINT16_V(tx.tso_props.tucse, E1000State, 3),
-        VMSTATE_UINT32_V(tx.tso_props.paylen, E1000State, 3),
-        VMSTATE_UINT8_V(tx.tso_props.hdr_len, E1000State, 3),
-        VMSTATE_UINT16_V(tx.tso_props.mss, E1000State, 3),
-        VMSTATE_INT8_V(tx.tso_props.ip, E1000State, 3),
-        VMSTATE_INT8_V(tx.tso_props.tcp, E1000State, 3),
         VMSTATE_END_OF_LIST()
     },
     .subsections = (const VMStateDescription*[]) {
         &vmstate_e1000_mit_state,
         &vmstate_e1000_full_mac_state,
+        &vmstate_e1000_tx_tso_state,
         NULL
     }
 };
-- 
2.14.3
