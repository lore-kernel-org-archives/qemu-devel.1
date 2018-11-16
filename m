Received: from eggs.gnu.org ([2001:4830:134:3::10]:57667)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gNV2s-0000j9-PU
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 22:43:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gNV2s-0007mM-4k
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 22:43:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47224)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1gNV2o-0007jn-B9
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 22:43:48 -0500
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 16 Nov 2018 11:43:31 +0800
Message-Id: <1542339811-18549-2-git-send-email-jasowang@redhat.com>
In-Reply-To: <1542339811-18549-1-git-send-email-jasowang@redhat.com>
References: <1542339811-18549-1-git-send-email-jasowang@redhat.com>
Subject: [Qemu-devel] [PULL] net/filter-rewriter.c: Fix coverity static
 analysis issue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: Zhang Chen <zhangckid@gmail.com>, Jason Wang <jasowang@redhat.com>

From: Zhang Chen <zhangckid@gmail.com>

The original code just follow the TCP state diagram,
but in this case, we can skip the TCPS_TIME_WAIT state to simplify
the implementation.

Signed-off-by: Zhang Chen <zhangckid@gmail.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 net/filter-rewriter.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/filter-rewriter.c b/net/filter-rewriter.c
index bb8f4d9..2e26839 100644
--- a/net/filter-rewriter.c
+++ b/net/filter-rewriter.c
@@ -155,12 +155,13 @@ static int handle_primary_tcp_pkt(RewriterState *rf,
          * Active close step 2.
          */
         if (conn->tcp_state == TCPS_FIN_WAIT_1) {
-            conn->tcp_state = TCPS_TIME_WAIT;
             /*
              * For simplify implementation, we needn't wait 2MSL time
              * in filter rewriter. Because guest kernel will track the
              * TCP status and wait 2MSL time, if client resend the FIN
              * packet, guest will apply the last ACK too.
+             * So, we skip the TCPS_TIME_WAIT state here and go straight
+             * to TCPS_CLOSED state.
              */
             conn->tcp_state = TCPS_CLOSED;
             g_hash_table_remove(rf->connection_track_table, key);
-- 
2.5.0
