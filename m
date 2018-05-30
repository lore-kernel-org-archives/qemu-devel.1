Received: from eggs.gnu.org ([2001:4830:134:3::10]:41202)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fli@suse.com>) id 1fO0bw-0001xs-Uj
	for qemu-devel@nongnu.org; Wed, 30 May 2018 08:53:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fli@suse.com>) id 1fO0bs-00043j-Q7
	for qemu-devel@nongnu.org; Wed, 30 May 2018 08:53:53 -0400
Received: from smtp.nue.novell.com ([195.135.221.5]:51678)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <fli@suse.com>) id 1fO0bs-00042O-JJ
	for qemu-devel@nongnu.org; Wed, 30 May 2018 08:53:48 -0400
From: Fei Li <fli@suse.com>
Date: Wed, 30 May 2018 20:53:14 +0800
Message-Id: <20180530125314.11677-1-fli@suse.com>
Subject: [Qemu-devel] [PATCH] fix Segmentation fault when emulating a
 bluetooth device 'dev'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The current code bt_hid_send_data() did not check whether its first
parameter *ch is NULL, which will cause a "Segmentation fault" when
*ch is NULL as ch->remote_mtu will be directly referenced later in
this function. E.g. when called by bt_hid_datain() and hid->interrupt
is NULL with "qemu-system-x86_64 ... \ -bt device:keyboard,vlan=3".

Thus add a judgement to avoid such error.

Signed-off-by: Fei Li <fli@suse.com>
---
 hw/bt/hid.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/bt/hid.c b/hw/bt/hid.c
index 056291f9b5..dfb0ea9c9b 100644
--- a/hw/bt/hid.c
+++ b/hw/bt/hid.c
@@ -174,6 +174,9 @@ static void bt_hid_send_data(struct bt_l2cap_conn_params_s *ch, int type,
     uint8_t *pkt, hdr = (BT_DATA << 4) | type;
     int plen;
 
+    if (!ch)
+        return;
+
     do {
         plen = MIN(len, ch->remote_mtu - 1);
         pkt = ch->sdu_out(ch, plen + 1);
-- 
2.13.6
