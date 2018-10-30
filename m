Received: from eggs.gnu.org ([2001:4830:134:3::10]:58907)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1gHL3N-0003OM-VI
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 23:50:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1gHL3K-0006gY-83
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 23:50:53 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:34088)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <zhangckid@gmail.com>) id 1gHL3K-0006fp-0f
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 23:50:50 -0400
Received: by mail-pl1-x641.google.com with SMTP id f10-v6so4847710plr.1
	for <qemu-devel@nongnu.org>; Mon, 29 Oct 2018 20:50:49 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
Date: Tue, 30 Oct 2018 11:50:30 +0800
Message-Id: <20181030035030.4542-1-zhangckid@gmail.com>
Subject: [Qemu-devel] [PATCH] net/filter-rewirter.c: Fix coverity static
 analysis issue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>
Cc: Zhang Chen <zhangckid@gmail.com>, Zhang Chen <chen.zhang@intel.com>

The original code just follow the TCP state diagram,
but in this case, we can skip the TCPS_TIME_WAIT state to simplify
the implementation.

Signed-off-by: Zhang Chen <zhangckid@gmail.com>
---
 net/filter-rewriter.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/filter-rewriter.c b/net/filter-rewriter.c
index bb8f4d93b1..2e26839bc2 100644
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
2.17.GIT
