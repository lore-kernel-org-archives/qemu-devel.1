Received: from eggs.gnu.org ([209.51.188.92]:52581)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1goAKA-0008Ut-TQ
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 12:03:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1goAKA-0004eN-3T
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 12:03:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48508)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1goAK7-0003uL-8P
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 12:03:53 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6643EDD9C9
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 17:03:34 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Mon, 28 Jan 2019 17:03:17 +0000
Message-Id: <20190128170321.16936-6-dgilbert@redhat.com>
In-Reply-To: <20190128170321.16936-1-dgilbert@redhat.com>
References: <20190128170321.16936-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 5/9] net: Add a network device specific
 self-announcement ability
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, quintela@redhat.com, jasowang@redhat.com, mst@redhat.com, eblake@redhat.com, armbru@redhat.com, berrange@redhat.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Some network devices have a capability to do self announcements
(ex: virtio-net).  Add infrastructure that would allow devices
to expose this ability.

Signed-off-by: Vladislav Yasevich <vyasevic@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 include/net/net.h | 2 ++
 net/announce.c    | 5 +++++
 2 files changed, 7 insertions(+)

diff --git a/include/net/net.h b/include/net/net.h
index 643295d163..f888cc3019 100644
--- a/include/net/net.h
+++ b/include/net/net.h
@@ -60,6 +60,7 @@ typedef int (SetVnetLE)(NetClientState *, bool);
 typedef int (SetVnetBE)(NetClientState *, bool);
 typedef struct SocketReadState SocketReadState;
 typedef void (SocketReadStateFinalize)(SocketReadState *rs);
+typedef void (NetAnnounce)(NetClientState *);
=20
 typedef struct NetClientInfo {
     NetClientDriver type;
@@ -80,6 +81,7 @@ typedef struct NetClientInfo {
     SetVnetHdrLen *set_vnet_hdr_len;
     SetVnetLE *set_vnet_le;
     SetVnetBE *set_vnet_be;
+    NetAnnounce *announce;
 } NetClientInfo;
=20
 struct NetClientState {
diff --git a/net/announce.c b/net/announce.c
index 13ad9c2ba8..070f37a7fa 100644
--- a/net/announce.c
+++ b/net/announce.c
@@ -102,6 +102,11 @@ static void qemu_announce_self_iter(NICState *nic, v=
oid *opaque)
     len =3D announce_self_create(buf, nic->conf->macaddr.a);
=20
     qemu_send_packet_raw(qemu_get_queue(nic), buf, len);
+
+    /* if the NIC provides it's own announcement support, use it as well=
 */
+    if (nic->ncs->info->announce) {
+        nic->ncs->info->announce(nic->ncs);
+    }
 }
 static void qemu_announce_self_once(void *opaque)
 {
--=20
2.20.1
