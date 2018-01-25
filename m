Received: from eggs.gnu.org ([2001:4830:134:3::10]:33765)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eehok-0003Jm-Vb
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 08:43:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eehok-0003C0-6H
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 08:43:51 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:45994)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1eehoj-0003BN-Vn
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 08:43:50 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1eehoi-0006xO-Bp
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 13:43:48 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 Jan 2018 13:43:26 +0000
Message-Id: <1516887809-6265-19-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1516887809-6265-1-git-send-email-peter.maydell@linaro.org>
References: <1516887809-6265-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 18/21] hw/arm/virt: Check that the CPU realize
 method succeeded
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

We were passing a NULL error pointer to the object_property_set_bool()
call that realizes the CPU object. This meant that we wouldn't detect
failure, and would plough blindly on to crash later trying to use a
NULL CPU object pointer. Detect errors and fail instead.

In particular, this will be necessary to detect the user error
of using "-cpu host" without "-enable-kvm" once we make the host
CPU type be registered unconditionally rather than only in
kvm_arch_init().

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/virt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index a4537af..b334c82 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1404,7 +1404,7 @@ static void machvirt_init(MachineState *machine)
                                      "secure-memory", &error_abort);
         }
 
-        object_property_set_bool(cpuobj, true, "realized", NULL);
+        object_property_set_bool(cpuobj, true, "realized", &error_fatal);
         object_unref(cpuobj);
     }
     fdt_add_timer_nodes(vms);
-- 
2.7.4
