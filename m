Received: from eggs.gnu.org ([2001:4830:134:3::10]:57955)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdavidsaver@gmail.com>) id 1fb8rd-0004Kb-Ne
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 14:20:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdavidsaver@gmail.com>) id 1fb8rc-0006Ae-HW
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 14:20:21 -0400
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:34135)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mdavidsaver@gmail.com>)
	id 1fb8rc-0006AG-AN
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 14:20:20 -0400
Received: by mail-pf0-x242.google.com with SMTP id e10-v6so6140225pfn.1
	for <qemu-devel@nongnu.org>; Thu, 05 Jul 2018 11:20:20 -0700 (PDT)
From: Michael Davidsaver <mdavidsaver@gmail.com>
Date: Thu,  5 Jul 2018 11:19:50 -0700
Message-Id: <20180705182001.16537-4-mdavidsaver@gmail.com>
In-Reply-To: <20180705182001.16537-1-mdavidsaver@gmail.com>
References: <20180705182001.16537-1-mdavidsaver@gmail.com>
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
To: Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, Antoine Mathys <barsamin@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, qemu-devel@nongnu.org, Michael Davidsaver <mdavidsaver@gmail.com>

Need to save HOUR[HOUR12] bit to keep
track of guest selection of 12-hour mode.
Write through current time registers to
achieve this.  Will be overwritten
by the next read/latch.

This was only being done in two of three
arms of this conditional block.

Signed-off-by: Michael Davidsaver <mdavidsaver@gmail.com>
---
 hw/timer/ds1338.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/hw/timer/ds1338.c b/hw/timer/ds1338.c
index 7298c5af43..b56db5852e 100644
--- a/hw/timer/ds1338.c
+++ b/hw/timer/ds1338.c
@@ -220,10 +220,8 @@ static int ds1338_send(I2CSlave *i2c, uint8_t data)
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
