Received: from eggs.gnu.org ([2001:4830:134:3::10]:35052)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marc@brightwise.de>) id 1ciGWh-00068Y-19
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 03:19:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marc@brightwise.de>) id 1ciGWb-00006F-Vn
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 03:19:22 -0500
Received: from mo6-p00-ob.smtp.rzone.de ([2a01:238:20a:202:5300::5]:36983)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marc@brightwise.de>) id 1ciGWb-00005z-Lo
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 03:19:17 -0500
Date: Mon, 27 Feb 2017 09:15:55 +0100 (CET)
From: Marc Bommert <marc@brightwise.de>
Message-ID: <492427237.68231.1488183356160@communicator.strato.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH] pl190: Fix off-by-one error in priority
 handling when reading VECTADDR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

The "current" priority bit (1 << i) should also be set in s->prio_mask[i], if the interrupt is enabled. This will in turn cause the read operation of VECTADDR to return the correct vector of the pending interrupt.

---
hw/intc/pl190.c | 2 +-
1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/intc/pl190.c b/hw/intc/pl190.c
index 55ea15d..0369da8 100644
--- a/hw/intc/pl190.c
+++ b/hw/intc/pl190.c
@@ -80,12 +80,12 @@ static void pl190_update_vectors(PL190State *s)
mask = 0;
for (i = 0; i < 16; i++)
{
- s->prio_mask[i] = mask;
if (s->vect_control[i] & 0x20)
{
n = s->vect_control[i] & 0x1f;
mask |= 1 << n;
}
+ s->prio_mask[i] = mask;
}
s->prio_mask[16] = mask;
pl190_update(s);
--
2.5.0
