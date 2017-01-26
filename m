Received: from eggs.gnu.org ([2001:4830:134:3::10]:43751)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cWh0T-0005GN-V9
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 05:10:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cWh0P-0003QG-0U
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 05:10:17 -0500
Received: from mail-wj0-x244.google.com ([2a00:1450:400c:c01::244]:35124)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cWh0O-0003Pz-QD
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 05:10:12 -0500
Received: by mail-wj0-x244.google.com with SMTP id i7so4293593wjf.2
	for <qemu-devel@nongnu.org>; Thu, 26 Jan 2017 02:10:12 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 26 Jan 2017 11:10:10 +0100
Message-Id: <20170126101010.6375-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH] net: e1000e: fix dead code in
 e1000e_write_packet_to_guest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dmitry@daynix.com, jasowang@redhat.com

Because is_first is declared inside a loop, it is always true.  The store
is dead, and so is the "else" branch of "if (is_first)".  is_last is
okay though.

Reported by Coverity.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
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
2.9.3
