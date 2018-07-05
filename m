Received: from eggs.gnu.org ([2001:4830:134:3::10]:58102)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdavidsaver@gmail.com>) id 1fb8rp-0004UK-9r
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 14:20:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdavidsaver@gmail.com>) id 1fb8rn-0006Gv-U0
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 14:20:32 -0400
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:43483)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mdavidsaver@gmail.com>)
	id 1fb8rn-0006GX-N7
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 14:20:31 -0400
Received: by mail-pf0-x242.google.com with SMTP id y8-v6so6130019pfm.10
	for <qemu-devel@nongnu.org>; Thu, 05 Jul 2018 11:20:31 -0700 (PDT)
From: Michael Davidsaver <mdavidsaver@gmail.com>
Date: Thu,  5 Jul 2018 11:19:57 -0700
Message-Id: <20180705182001.16537-11-mdavidsaver@gmail.com>
In-Reply-To: <20180705182001.16537-1-mdavidsaver@gmail.com>
References: <20180705182001.16537-1-mdavidsaver@gmail.com>
Subject: [Qemu-devel] [PATCH 10/14] timer: ds1338 remove vestige of
 un-modeled OSF
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

Oscillator stop has never been modeled, so the
Oscillator Stop Flag can never be set.

Signed-off-by: Michael Davidsaver <mdavidsaver@gmail.com>
---
 hw/timer/ds-rtc.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/hw/timer/ds-rtc.c b/hw/timer/ds-rtc.c
index 3c5781d53c..126566ce1f 100644
--- a/hw/timer/ds-rtc.c
+++ b/hw/timer/ds-rtc.c
@@ -21,8 +21,6 @@
  */
 #define NVRAM_SIZE 64
 
-#define CTRL_OSF   0x20
-
 #define TYPE_DSRTC "ds1338"
 #define DSRTC(obj) OBJECT_CHECK(DSRTCState, (obj), TYPE_DSRTC)
 
@@ -216,13 +214,11 @@ static int dsrtc_send(I2CSlave *i2c, uint8_t data)
     if (s->ptr == R_CTRL) {
         /* Control register. */
 
-        /* Ensure bits 2, 3 and 6 will read back as zero. */
-        data &= 0xB3;
-
-        /* Attempting to write the OSF flag to logic 1 leaves the
-           value unchanged. */
-        data = (data & ~CTRL_OSF) | (data & s->nvram[s->ptr] & CTRL_OSF);
-
+        /* Allow guest to set no-op controls for clock out pin and
+         * rate select.  Ignore write 1 to clear OSF.  We don't model
+         * oscillator stop, so it is never set.
+         */
+        data = data & 0x93;
     }
     s->nvram[s->ptr] = data;
     if (s->ptr <= R_YEAR) {
-- 
2.11.0
