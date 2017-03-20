Received: from eggs.gnu.org ([2001:4830:134:3::10]:45719)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1cpwvZ-0003wy-9i
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 09:00:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1cpwvT-00071M-Bc
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 09:00:49 -0400
Received: from mailapp01.imgtec.com ([195.59.15.196]:28683)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1cpwvT-000715-5c
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 09:00:43 -0400
From: Yongbok Kim <yongbok.kim@imgtec.com>
Date: Mon, 20 Mar 2017 13:00:23 +0000
Message-ID: <1490014826-4472-8-git-send-email-yongbok.kim@imgtec.com>
In-Reply-To: <1490014826-4472-1-git-send-email-yongbok.kim@imgtec.com>
References: <1490014826-4472-1-git-send-email-yongbok.kim@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL for v2.9 07/10] dma: rc4030: limit interval
 timer reload value
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Prasad J Pandit <pjp@fedoraproject.org>

From: Prasad J Pandit <pjp@fedoraproject.org>

The JAZZ RC4030 chipset emulator has a periodic timer and
associated interval reload register. The reload value is used
as divider when computing timer's next tick value. If reload
value is large, it could lead to divide by zero error. Limit
the interval reload value to avoid it.

Reported-by: Huawei PSIRT <psirt@huawei.com>
Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
Tested-by: Herv=C3=A9 Poussineau <hpoussin@reactos.org>
Signed-off-by: Yongbok Kim <yongbok.kim@imgtec.com>
---
 hw/dma/rc4030.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/dma/rc4030.c b/hw/dma/rc4030.c
index 17c8518..41fc043 100644
--- a/hw/dma/rc4030.c
+++ b/hw/dma/rc4030.c
@@ -460,7 +460,7 @@ static void rc4030_write(void *opaque, hwaddr addr, u=
int64_t data,
         break;
     /* Interval timer reload */
     case 0x0228:
-        s->itr =3D val;
+        s->itr =3D val & 0x01FF;
         qemu_irq_lower(s->timer_irq);
         set_next_tick(s);
         break;
--=20
2.7.4
