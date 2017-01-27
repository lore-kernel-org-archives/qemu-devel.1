Received: from eggs.gnu.org ([2001:4830:134:3::10]:59596)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cX8Vr-00011o-2y
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 10:32:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cX8Vq-000572-7Q
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 10:32:31 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:48311)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1cX8Vq-00055y-1O
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 10:32:30 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1cX8Vn-0003Rq-Dg
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 15:32:27 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 27 Jan 2017 15:32:14 +0000
Message-Id: <1485531137-2362-20-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1485531137-2362-1-git-send-email-peter.maydell@linaro.org>
References: <1485531137-2362-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 19/22] arm: stellaris: make MII accesses
 complete immediately
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Michael Davidsaver <mdavidsaver@gmail.com>

When the guest attempts to start an MII register
access via the MCTL register, clear the START bit,
so that when the guest reads it back the register
transaction will be signalled as having completed.
This avoids the guest spinning as it polls the
START bit waiting for it to clear (which it
previously never would).

The  MII registers themselves still aren't implemented,
but at least we can avoid guests spending quite so much
time busy waiting.

Signed-off-by: Michael Davidsaver <mdavidsaver@gmail.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 1484938222-1423-1-git-send-email-peter.maydell@linaro.org
[PMM: expand commit message]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/net/stellaris_enet.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/net/stellaris_enet.c b/hw/net/stellaris_enet.c
index 957730e..04bd10a 100644
--- a/hw/net/stellaris_enet.c
+++ b/hw/net/stellaris_enet.c
@@ -416,7 +416,10 @@ static void stellaris_enet_write(void *opaque, hwaddr offset,
         s->thr = value;
         break;
     case 0x20: /* MCTL */
-        s->mctl = value;
+        /* TODO: MII registers aren't modelled.
+         * Clear START, indicating that the operation completes immediately.
+         */
+        s->mctl = value & ~1;
         break;
     case 0x24: /* MDV */
         s->mdv = value;
-- 
2.7.4
