Received: from eggs.gnu.org ([2001:4830:134:3::10]:38174)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cVo1u-0003H9-S7
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 18:28:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cVo1r-0005yR-Pv
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 18:28:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52824)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cVo1r-0005yJ-KH
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 18:28:03 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon, 23 Jan 2017 21:27:29 -0200
Message-Id: <20170123232738.20796-5-ehabkost@redhat.com>
In-Reply-To: <20170123232738.20796-1-ehabkost@redhat.com>
References: <20170123232738.20796-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 04/13] vl: Ensure the numa_post_machine_init
 func in the appropriate location
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Marcel Apfelbaum <marcel@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Dou Liyang <douly.fnst@cn.fujitsu.com>

From: Dou Liyang <douly.fnst@cn.fujitsu.com>

In the numa_post_machine_init(), we use CPU_FOREACH macro to set all
CPUs' namu_node. So, we should make sure that we call it after Qemu
has already initialied all the CPUs.

As we all know, the CPUs can be created by "-smp"(pc_new_cpu) or
"-device"(qdev_device_add) command. But, before the device init,
Qemu execute the numa_post_machine_init earlier. It makes the mapping
of NUMA nodes and CPUs incorrect.

The patch move the numa_post_machine_init func in the appropriate
location.

Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
Message-Id: <1484664152-24446-2-git-send-email-douly.fnst@cn.fujitsu.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 vl.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/vl.c b/vl.c
index a260f30974..ed1cbe9c73 100644
--- a/vl.c
+++ b/vl.c
@@ -4513,8 +4513,6 @@ int main(int argc, char **argv, char **envp)
 
     cpu_synchronize_all_post_init();
 
-    numa_post_machine_init();
-
     if (hax_enabled()) {
         hax_sync_vcpus();
     }
@@ -4539,6 +4537,9 @@ int main(int argc, char **argv, char **envp)
                           device_init_func, NULL, NULL)) {
         exit(1);
     }
+
+    numa_post_machine_init();
+
     rom_reset_order_override();
 
     /* Did we create any drives that we failed to create a device for? */
-- 
2.11.0.259.g40922b1
