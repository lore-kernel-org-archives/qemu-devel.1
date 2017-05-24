Received: from eggs.gnu.org ([2001:4830:134:3::10]:52165)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vyasevic@redhat.com>) id 1dDafQ-0003og-Tb
	for qemu-devel@nongnu.org; Wed, 24 May 2017 14:05:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vyasevic@redhat.com>) id 1dDafP-0001Ki-SD
	for qemu-devel@nongnu.org; Wed, 24 May 2017 14:05:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35006)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vyasevic@redhat.com>) id 1dDafP-0001KR-Mn
	for qemu-devel@nongnu.org; Wed, 24 May 2017 14:05:51 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B905F448D83
	for <qemu-devel@nongnu.org>; Wed, 24 May 2017 18:05:50 +0000 (UTC)
From: Vladislav Yasevich <vyasevic@redhat.com>
Date: Wed, 24 May 2017 14:05:20 -0400
Message-Id: <1495649128-10529-5-git-send-email-vyasevic@redhat.com>
In-Reply-To: <1495649128-10529-1-git-send-email-vyasevic@redhat.com>
References: <1495649128-10529-1-git-send-email-vyasevic@redhat.com>
Subject: [Qemu-devel] [PATCH 04/12] net: Add a network device specific
 self-announcement ability
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, dgilbert@redhat.com, quintela@redhat.com
Cc: germano@redhat.com, lvivier@redhat.com, jasowang@redhat.com, jdenemar@redhat.com, kashyap@redhat.com, armbru@redhat.com, mst@redhat.com, Vladislav Yasevich <vyasevic@redhat.com>

Some network devices have a capability to do self annoucements
(ex: virtio-new).  Add infrustrcture that would allow devices
to expose this ability.

Signed-off-by: Vladislav Yasevich <vyasevic@redhat.com>
---
 include/net/net.h  | 2 ++
 migration/savevm.c | 6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/include/net/net.h b/include/net/net.h
index 99b28d5..598f523 100644
--- a/include/net/net.h
+++ b/include/net/net.h
@@ -64,6 +64,7 @@ typedef int (SetVnetLE)(NetClientState *, bool);
 typedef int (SetVnetBE)(NetClientState *, bool);
 typedef struct SocketReadState SocketReadState;
 typedef void (SocketReadStateFinalize)(SocketReadState *rs);
+typedef void (NetAnnounce)(NetClientState *);
 
 typedef struct NetClientInfo {
     NetClientDriver type;
@@ -84,6 +85,7 @@ typedef struct NetClientInfo {
     SetVnetHdrLen *set_vnet_hdr_len;
     SetVnetLE *set_vnet_le;
     SetVnetBE *set_vnet_be;
+    NetAnnounce *announce;
 } NetClientInfo;
 
 struct NetClientState {
diff --git a/migration/savevm.c b/migration/savevm.c
index 555157a..a4097c9 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -207,9 +207,15 @@ static void qemu_announce_self_iter(NICState *nic, void *opaque)
     int len;
 
     trace_qemu_announce_self_iter(qemu_ether_ntoa(&nic->conf->macaddr));
+
     len = announce_self_create(buf, nic->conf->macaddr.a);
 
     qemu_send_packet_raw(qemu_get_queue(nic), buf, len);
+
+    /* if the NIC provides it's own announcement support, use it as well */
+    if (nic->ncs->info->announce) {
+        nic->ncs->info->announce(nic->ncs);
+    }
 }
 
 static void qemu_announce_self_once(void *opaque)
-- 
2.7.4
