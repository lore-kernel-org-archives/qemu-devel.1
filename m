Received: from eggs.gnu.org ([2001:4830:134:3::10]:38939)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eN0hd-00007o-F2
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 13:15:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eN0hU-0006td-IL
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 13:15:16 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu,  7 Dec 2017 18:14:48 +0000
Message-Id: <1512670493-18114-2-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1512670493-18114-1-git-send-email-peter.maydell@linaro.org>
References: <1512670493-18114-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 1/6] hw/arm/virt: Check that the CPU realize
 method succeeded
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, Eduardo Habkost <ehabkost@redhat.com>, "Richard W . M . Jones" <rjones@redhat.com>

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
index 151592b..62af013 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1402,7 +1402,7 @@ static void machvirt_init(MachineState *machine)
                                      "secure-memory", &error_abort);
         }
 
-        object_property_set_bool(cpuobj, true, "realized", NULL);
+        object_property_set_bool(cpuobj, true, "realized", &error_fatal);
         object_unref(cpuobj);
     }
     fdt_add_timer_nodes(vms);
-- 
2.7.4
