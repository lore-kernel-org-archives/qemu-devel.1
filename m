Received: from eggs.gnu.org ([2001:4830:134:3::10]:43573)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1f9XPW-0006VJ-QY
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 10:53:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1f9XPW-0007xa-0t
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 10:53:14 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:40996)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1f9XPV-0007mN-PT
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 10:53:13 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 20 Apr 2018 15:52:37 +0100
Message-Id: <20180420145249.32435-2-peter.maydell@linaro.org>
In-Reply-To: <20180420145249.32435-1-peter.maydell@linaro.org>
References: <20180420145249.32435-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 01/13] hw/char/serial: Allow disconnected
 chardevs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Currently the serial.c realize code has an explicit check that it is not
connected to a disconnected backend (ie one with a NULL chardev).
This isn't what we want -- you should be able to create a serial device
even if it isn't attached to anything. Remove the check.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/char/serial.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/hw/char/serial.c b/hw/char/serial.c
index eb72191ee7..2c080c9862 100644
--- a/hw/char/serial.c
+++ b/hw/char/serial.c
@@ -923,11 +923,6 @@ static int serial_be_change(void *opaque)
 
 void serial_realize_core(SerialState *s, Error **errp)
 {
-    if (!qemu_chr_fe_backend_connected(&s->chr)) {
-        error_setg(errp, "Can't create serial device, empty char device");
-        return;
-    }
-
     s->modem_status_poll = timer_new_ns(QEMU_CLOCK_VIRTUAL, (QEMUTimerCB *) serial_update_msl, s);
 
     s->fifo_timeout_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, (QEMUTimerCB *) fifo_timeout_int, s);
-- 
2.17.0
