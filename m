Received: from eggs.gnu.org ([208.118.235.92]:42355)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdavidsaver@gmail.com>) id 1ezqXO-0004ku-FP
	for qemu-devel@nongnu.org; Sat, 24 Mar 2018 17:18:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdavidsaver@gmail.com>) id 1ezqRU-0003zh-EG
	for qemu-devel@nongnu.org; Sat, 24 Mar 2018 17:12:18 -0400
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:38759)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mdavidsaver@gmail.com>)
	id 1ezomt-0005kV-1a
	for qemu-devel@nongnu.org; Sat, 24 Mar 2018 15:25:11 -0400
Received: by mail-pg0-x243.google.com with SMTP id a15so5799807pgn.5
	for <qemu-devel@nongnu.org>; Sat, 24 Mar 2018 12:25:10 -0700 (PDT)
From: Michael Davidsaver <mdavidsaver@gmail.com>
Date: Sat, 24 Mar 2018 12:24:44 -0700
Message-Id: <20180324192455.12254-4-mdavidsaver@gmail.com>
In-Reply-To: <20180324192455.12254-1-mdavidsaver@gmail.com>
References: <20180324192455.12254-1-mdavidsaver@gmail.com>
Subject: [Qemu-devel] [PATCH 03/14] timer: ds1338 persist 12-hour mode
 selection
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>
Cc: Antoine Mathys <barsamin@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, qemu-devel@nongnu.org, Michael Davidsaver <mdavidsaver@gmail.com>

Need to save HOUR[HOUR12] bit to keep
track of guest selection of 12-hour mode.
Write through current time registers to
achieve this.  Will be overwritten
by the next read/latch.

Signed-off-by: Michael Davidsaver <mdavidsaver@gmail.com>
---
 hw/timer/ds1338.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/hw/timer/ds1338.c b/hw/timer/ds1338.c
index b5630e214a..72a4692d60 100644
--- a/hw/timer/ds1338.c
+++ b/hw/timer/ds1338.c
@@ -224,10 +224,8 @@ static int ds1338_send(I2CSlave *i2c, uint8_t data)
            value unchanged. */
         data = (data & ~CTRL_OSF) | (data & s->nvram[s->ptr] & CTRL_OSF);
 
-        s->nvram[s->ptr] = data;
-    } else {
-        s->nvram[s->ptr] = data;
     }
+    s->nvram[s->ptr] = data;
     inc_regptr(s);
     return 0;
 }
-- 
2.11.0
