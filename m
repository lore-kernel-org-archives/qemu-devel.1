Received: from eggs.gnu.org ([2001:4830:134:3::10]:57239)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dpszZ-0001Fa-Ci
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 05:21:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dpszU-0007ev-QZ
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 05:20:57 -0400
Received: from ozlabs.ru ([107.173.13.209]:51572)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dpszU-0007e8-Kl
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 05:20:52 -0400
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Thu,  7 Sep 2017 19:20:07 +1000
Message-Id: <20170907092010.3605-2-aik@ozlabs.ru>
In-Reply-To: <20170907092010.3605-1-aik@ozlabs.ru>
References: <20170907092010.3605-1-aik@ozlabs.ru>
Subject: [Qemu-devel] [RFC PATCH qemu 1/4] memory: Postpone flatview and
 dispatch tree building till all devices are added
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, David Gibson <david@gibson.dropbear.id.au>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, Peter Maydell <peter.maydell@linaro.org>

Most devices use at least one address space and every time a new address
space is added, flat views and dispatch trees are rebuild for all address
spaces. This is not a problem for a relatively small amount of devices but
even 50 virtio-pci devices use more than 8GB of RAM.

What happens that on every flatview/dispatch rebuild, new arrays are
allocated and old ones release but the release is done via RCU so until
an entire machine is build, they are not released.

This wraps devices creation into memory_region_transaction_begin/commit
to massively reduce amount of flat view/dispatch tree (re)allocations.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 vl.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/vl.c b/vl.c
index 8e247cc2a2..3c39cc8b3a 100644
--- a/vl.c
+++ b/vl.c
@@ -4655,12 +4655,16 @@ int main(int argc, char **argv, char **envp)
     igd_gfx_passthru();
 
     /* init generic devices */
+    memory_region_transaction_begin();
+
     rom_set_order_override(FW_CFG_ORDER_OVERRIDE_DEVICE);
     if (qemu_opts_foreach(qemu_find_opts("device"),
                           device_init_func, NULL, NULL)) {
         exit(1);
     }
 
+    memory_region_transaction_commit();
+
     cpu_synchronize_all_post_init();
 
     rom_reset_order_override();
-- 
2.11.0
