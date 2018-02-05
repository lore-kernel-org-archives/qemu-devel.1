Received: from eggs.gnu.org ([2001:4830:134:3::10]:48176)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eiiJw-00049i-9V
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 10:04:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eiiJq-0006wi-EY
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 10:04:36 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:46212)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1eiiJq-0006uY-7w
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 10:04:30 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon,  5 Feb 2018 15:04:26 +0000
Message-Id: <20180205150426.20542-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH] hw/core/generic-loader: Allow PC to be set on
 command line
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, Alistair Francis <alistair.francis@xilinx.com>

The documentation for the generic loader claims that you can
set the PC for a CPU with an option of the form
  -device loader,cpu-num=0,addr=0x10000004

However if you try this QEMU complains:
  cpu_num must be specified when setting a program counter

This is because we were testing against 0 rather than CPU_NONE.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
I've also noticed that you can't use this to specify that
the starting address should be in Thumb mode for Arm CPUs,
but I'm not so sure of the right way to fix that...

 hw/core/generic-loader.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/core/generic-loader.c b/hw/core/generic-loader.c
index 46012673c3..cb0e68486d 100644
--- a/hw/core/generic-loader.c
+++ b/hw/core/generic-loader.c
@@ -105,7 +105,7 @@ static void generic_loader_realize(DeviceState *dev, Error **errp)
             error_setg(errp, "data can not be specified when setting a "
                        "program counter");
             return;
-        } else if (!s->cpu_num) {
+        } else if (s->cpu_num == CPU_NONE) {
             error_setg(errp, "cpu_num must be specified when setting a "
                        "program counter");
             return;
-- 
2.16.1
