Received: from eggs.gnu.org ([209.51.188.92]:34904)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gxCHH-0000SI-0B
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 09:58:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gxCF6-0007hd-Me
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 09:56:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58978)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1gxCF6-0006aq-Am
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 09:56:00 -0500
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 22 Feb 2019 22:55:13 +0800
Message-Id: <1550847320-25110-7-git-send-email-jasowang@redhat.com>
In-Reply-To: <1550847320-25110-1-git-send-email-jasowang@redhat.com>
References: <1550847320-25110-1-git-send-email-jasowang@redhat.com>
Subject: [Qemu-devel] [PULL 06/13] net: Add a network device specific
 self-announcement ability
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Vladislav Yasevich <vyasevic@redhat.com>, Jason Wang <jasowang@redhat.com>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Some network devices have a capability to do self announcements
(ex: virtio-net).  Add infrastructure that would allow devices
to expose this ability.

Signed-off-by: Vladislav Yasevich <vyasevic@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 include/net/net.h | 2 ++
 net/announce.c    | 5 +++++
 2 files changed, 7 insertions(+)

diff --git a/include/net/net.h b/include/net/net.h
index 075cc01..acf0451 100644
--- a/include/net/net.h
+++ b/include/net/net.h
@@ -60,6 +60,7 @@ typedef int (SetVnetLE)(NetClientState *, bool);
 typedef int (SetVnetBE)(NetClientState *, bool);
 typedef struct SocketReadState SocketReadState;
 typedef void (SocketReadStateFinalize)(SocketReadState *rs);
+typedef void (NetAnnounce)(NetClientState *);
 
 typedef struct NetClientInfo {
     NetClientDriver type;
@@ -80,6 +81,7 @@ typedef struct NetClientInfo {
     SetVnetHdrLen *set_vnet_hdr_len;
     SetVnetLE *set_vnet_le;
     SetVnetBE *set_vnet_be;
+    NetAnnounce *announce;
 } NetClientInfo;
 
 struct NetClientState {
diff --git a/net/announce.c b/net/announce.c
index 13ad9c2..070f37a 100644
--- a/net/announce.c
+++ b/net/announce.c
@@ -102,6 +102,11 @@ static void qemu_announce_self_iter(NICState *nic, void *opaque)
     len = announce_self_create(buf, nic->conf->macaddr.a);
 
     qemu_send_packet_raw(qemu_get_queue(nic), buf, len);
+
+    /* if the NIC provides it's own announcement support, use it as well */
+    if (nic->ncs->info->announce) {
+        nic->ncs->info->announce(nic->ncs);
+    }
 }
 static void qemu_announce_self_once(void *opaque)
 {
-- 
2.5.0
