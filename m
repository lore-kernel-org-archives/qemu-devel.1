Received: from eggs.gnu.org ([2001:4830:134:3::10]:47932)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cUeGd-0007UK-9s
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 13:50:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cUeGc-00056r-Ga
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 13:50:31 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 20 Jan 2017 18:50:22 +0000
Message-Id: <1484938222-1423-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH] arm: stellaris: make MII accesses complete
 immediately
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, Michael Davidsaver <mdavidsaver@gmail.com>

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
[PMM: expand commit message]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
This is a minor bugfix that was lurking in Michael's
git tree from his unfinished work on a v3 of the NVIC
patchset.

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
