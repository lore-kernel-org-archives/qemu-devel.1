Received: from eggs.gnu.org ([2001:4830:134:3::10]:41828)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cVxct-00004q-In
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 04:42:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cVxcp-0001qk-C6
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 04:42:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46364)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1cVxcp-0001qP-5y
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 04:42:51 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4F71F80508
	for <qemu-devel@nongnu.org>; Tue, 24 Jan 2017 09:42:51 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
Date: Tue, 24 Jan 2017 10:42:49 +0100
Message-Id: <1485250969-5472-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH] net: Mark 'vlan' parameter as deprecated
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org

The 'vlan' parameter is a continuous source of confusion for the users,
many people mix it up with the more common term VLAN (the link layer
packet encapsulation), and even if they realize that the QEMU 'vlan' is
rather some kind of network hub emulation, there is still a high risk
that they configure their QEMU networking in a wrong way with this
parameter (e.g. by hooking NICs together, so they get a 'loopback'
between one and the other NIC).
Thus at one point in time, we should finally get rid of the 'vlan'
feature in QEMU. Let's do a first step in this direction by declaring
the 'vlan' parameter as deprecated and informing the users to use the
'netdev' parameter instead.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 net/net.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/net.c b/net/net.c
index 939fe31..fb7af3a 100644
--- a/net/net.c
+++ b/net/net.c
@@ -970,6 +970,7 @@ static int net_client_init1(const void *object, bool is_netdev, Error **errp)
     const Netdev *netdev;
     const char *name;
     NetClientState *peer = NULL;
+    static bool vlan_warned;
 
     if (is_netdev) {
         netdev = object;
@@ -1050,6 +1051,11 @@ static int net_client_init1(const void *object, bool is_netdev, Error **errp)
             !opts->u.nic.data->has_netdev) {
             peer = net_hub_add_port(net->has_vlan ? net->vlan : 0, NULL);
         }
+
+        if (net->has_vlan && !vlan_warned) {
+            error_report("'vlan' is deprecated. Please use 'netdev' instead.");
+            vlan_warned = true;
+        }
     }
 
     if (net_client_init_fun[netdev->type](netdev, name, peer, errp) < 0) {
-- 
1.8.3.1
