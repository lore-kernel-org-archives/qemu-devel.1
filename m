Received: from eggs.gnu.org ([2001:4830:134:3::10]:40619)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e0cOV-00072T-Jk
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 19:51:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e0cOU-0004r7-HN
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 19:51:03 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri,  6 Oct 2017 20:49:03 -0300
Message-Id: <20171006235023.11952-9-f4bug@amsat.org>
In-Reply-To: <20171006235023.11952-1-f4bug@amsat.org>
References: <20171006235023.11952-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 08/88] BT: use g_new() family of functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu trival <qemu-trivial@nongnu.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
[PMD: another use in hw/bt/l2cap.c]
---
 bt-host.c     | 2 +-
 bt-vhci.c     | 2 +-
 hw/bt/core.c  | 4 ++--
 hw/bt/hci.c   | 4 ++--
 hw/bt/l2cap.c | 6 +++---
 5 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/bt-host.c b/bt-host.c
index 2f8f631c25..ad9e45ea43 100644
--- a/bt-host.c
+++ b/bt-host.c
@@ -177,7 +177,7 @@ struct HCIInfo *bt_host_hci(const char *id)
     }
 # endif
 
-    s = g_malloc0(sizeof(struct bt_host_hci_s));
+    s = g_new0(struct bt_host_hci_s, 1);
     s->fd = fd;
     s->hci.cmd_send = bt_host_cmd;
     s->hci.sco_send = bt_host_sco;
diff --git a/bt-vhci.c b/bt-vhci.c
index 9d277c32bf..a885e2b8b9 100644
--- a/bt-vhci.c
+++ b/bt-vhci.c
@@ -157,7 +157,7 @@ void bt_vhci_init(struct HCIInfo *info)
         exit(-1);
     }
 
-    s = g_malloc0(sizeof(struct bt_vhci_s));
+    s = g_new0(struct bt_vhci_s, 1);
     s->fd = fd;
     s->info = info ?: qemu_next_hci();
     s->info->opaque = s;
diff --git a/hw/bt/core.c b/hw/bt/core.c
index 615f0af073..281bb40501 100644
--- a/hw/bt/core.c
+++ b/hw/bt/core.c
@@ -55,7 +55,7 @@ static void bt_dummy_lmp_acl_resp(struct bt_link_s *link,
 /* Slaves that don't hold any additional per link state can use these */
 static void bt_dummy_lmp_connection_request(struct bt_link_s *req)
 {
-    struct bt_link_s *link = g_malloc0(sizeof(struct bt_link_s));
+    struct bt_link_s *link = g_new0(struct bt_link_s, 1);
 
     link->slave = req->slave;
     link->host = req->host;
@@ -135,7 +135,7 @@ struct bt_scatternet_s *qemu_find_bt_vlan(int id)
         if (vlan->id == id)
             return &vlan->net;
     }
-    vlan = g_malloc0(sizeof(struct bt_vlan_s));
+    vlan = g_new0(struct bt_vlan_s, 1);
     vlan->id = id;
     pvlan = &first_bt_vlan;
     while (*pvlan != NULL)
diff --git a/hw/bt/hci.c b/hw/bt/hci.c
index 476ebec0ab..08e65eb62e 100644
--- a/hw/bt/hci.c
+++ b/hw/bt/hci.c
@@ -742,7 +742,7 @@ static void bt_hci_connection_reject_event(struct bt_hci_s *hci,
 static void bt_hci_connection_accept(struct bt_hci_s *hci,
                 struct bt_device_s *host)
 {
-    struct bt_hci_link_s *link = g_malloc0(sizeof(struct bt_hci_link_s));
+    struct bt_hci_link_s *link = g_new0(struct bt_hci_link_s, 1);
     evt_conn_complete params;
     uint16_t handle;
     uint8_t status = HCI_SUCCESS;
@@ -2158,7 +2158,7 @@ static void bt_hci_destroy(struct bt_device_s *dev)
 
 struct HCIInfo *bt_new_hci(struct bt_scatternet_s *net)
 {
-    struct bt_hci_s *s = g_malloc0(sizeof(struct bt_hci_s));
+    struct bt_hci_s *s = g_new0(struct bt_hci_s, 1);
 
     s->lm.inquiry_done = timer_new_ns(QEMU_CLOCK_VIRTUAL, bt_hci_inquiry_done, s);
     s->lm.inquiry_next = timer_new_ns(QEMU_CLOCK_VIRTUAL, bt_hci_inquiry_next, s);
diff --git a/hw/bt/l2cap.c b/hw/bt/l2cap.c
index e342045140..94f5067d6e 100644
--- a/hw/bt/l2cap.c
+++ b/hw/bt/l2cap.c
@@ -1241,7 +1241,7 @@ static void l2cap_lmp_connection_request(struct bt_link_s *link)
 
     /* Always accept - we only get called if (dev->device->page_scan).  */
 
-    l2cap = g_malloc0(sizeof(struct slave_l2cap_instance_s));
+    l2cap = g_new0(struct slave_l2cap_instance_s, 1);
     l2cap->link.slave = &dev->device;
     l2cap->link.host = link->host;
     l2cap_init(&l2cap->l2cap, &l2cap->link, 0);
@@ -1262,7 +1262,7 @@ static void l2cap_lmp_connection_complete(struct bt_link_s *link)
         return;
     }
 
-    l2cap = g_malloc0(sizeof(struct l2cap_instance_s));
+    l2cap = g_new0(struct l2cap_instance_s, 1);
     l2cap_init(l2cap, link, 1);
 
     link->acl_mode = acl_active;
@@ -1358,7 +1358,7 @@ void bt_l2cap_psm_register(struct bt_l2cap_device_s *dev, int psm, int min_mtu,
         exit(-1);
     }
 
-    new_psm = g_malloc0(sizeof(*new_psm));
+    new_psm = g_new0(struct bt_l2cap_psm_s, 1);
     new_psm->psm = psm;
     new_psm->min_mtu = min_mtu;
     new_psm->new_channel = new_channel;
-- 
2.14.2
