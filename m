Received: from eggs.gnu.org ([2001:4830:134:3::10]:48797)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cdqer-000273-UY
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 22:53:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cdqeq-0008Pi-PB
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 22:53:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55344)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1cdqeq-0008PB-Jv
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 22:53:32 -0500
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 15 Feb 2017 11:53:19 +0800
Message-Id: <1487130802-27953-3-git-send-email-jasowang@redhat.com>
In-Reply-To: <1487130802-27953-1-git-send-email-jasowang@redhat.com>
References: <1487130802-27953-1-git-send-email-jasowang@redhat.com>
Subject: [Qemu-devel] [PULL 2/5] net: e1000e: fix dead code in
 e1000e_write_packet_to_guest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>

From: Paolo Bonzini <pbonzini@redhat.com>

Because is_first is declared inside a loop, it is always true.  The store
is dead, and so is the "else" branch of "if (is_first)".  is_last is
okay though.

Reported by Coverity.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Dmitry Fleytman <dmitry@daynix.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/net/e1000e_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
index 2b11499..c99e2fb 100644
--- a/hw/net/e1000e_core.c
+++ b/hw/net/e1000e_core.c
@@ -1507,6 +1507,7 @@ e1000e_write_packet_to_guest(E1000ECore *core, struct NetRxPkt *pkt,
     const E1000E_RingInfo *rxi;
     size_t ps_hdr_len = 0;
     bool do_ps = e1000e_do_ps(core, pkt, &ps_hdr_len);
+    bool is_first = true;
 
     rxi = rxr->i;
 
@@ -1514,7 +1515,6 @@ e1000e_write_packet_to_guest(E1000ECore *core, struct NetRxPkt *pkt,
         hwaddr ba[MAX_PS_BUFFERS];
         e1000e_ba_state bastate = { { 0 } };
         bool is_last = false;
-        bool is_first = true;
 
         desc_size = total_size - desc_offset;
 
-- 
2.7.4
