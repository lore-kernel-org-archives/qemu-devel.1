Received: from eggs.gnu.org ([2001:4830:134:3::10]:48785)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cdqer-000272-0v
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 22:53:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cdqeo-0008OW-BW
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 22:53:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36174)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1cdqeo-0008No-5w
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 22:53:30 -0500
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 15 Feb 2017 11:53:18 +0800
Message-Id: <1487130802-27953-2-git-send-email-jasowang@redhat.com>
In-Reply-To: <1487130802-27953-1-git-send-email-jasowang@redhat.com>
References: <1487130802-27953-1-git-send-email-jasowang@redhat.com>
Subject: [Qemu-devel] [PULL 1/5] net: Mark 'vlan' parameter as deprecated
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, Jason Wang <jasowang@redhat.com>

From: Thomas Huth <thuth@redhat.com>

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
Signed-off-by: Jason Wang <jasowang@redhat.com>
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
2.7.4
