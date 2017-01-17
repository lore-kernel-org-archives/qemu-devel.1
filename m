Received: from eggs.gnu.org ([2001:4830:134:3::10]:48166)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1cTUya-000275-T8
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 09:43:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1cTUyX-0001ce-PD
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 09:43:08 -0500
Received: from [59.151.112.132] (port=11873 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1cTUyX-0001bB-Da
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 09:43:05 -0500
From: Dou Liyang <douly.fnst@cn.fujitsu.com>
Date: Tue, 17 Jan 2017 22:42:31 +0800
Message-ID: <1484664152-24446-2-git-send-email-douly.fnst@cn.fujitsu.com>
In-Reply-To: <1484664152-24446-1-git-send-email-douly.fnst@cn.fujitsu.com>
References: <1484664152-24446-1-git-send-email-douly.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 1/2] vl: Ensure the numa_post_machine_init func
 in the appropriate location
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: stefanha@redhat.com, ehabkost@redhat.com, pbonzini@redhat.com, armbru@redhat.com, eblake@redhat.com
Cc: qemu-devel@nongnu.org, izumi.taku@jp.fujitsu.com, caoj.fnst@cn.fujitsu.com, fanc.fnst@cn.fujitsu.com, Dou Liyang <douly.fnst@cn.fujitsu.com>

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
---
 vl.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/vl.c b/vl.c
index c643d3f..f38b0e2 100644
--- a/vl.c
+++ b/vl.c
@@ -4549,8 +4549,6 @@ int main(int argc, char **argv, char **envp)
 
     cpu_synchronize_all_post_init();
 
-    numa_post_machine_init();
-
     if (qemu_opts_foreach(qemu_find_opts("fw_cfg"),
                           parse_fw_cfg, fw_cfg_find(), NULL) != 0) {
         exit(1);
@@ -4571,6 +4569,9 @@ int main(int argc, char **argv, char **envp)
                           device_init_func, NULL, NULL)) {
         exit(1);
     }
+
+    numa_post_machine_init();
+
     rom_reset_order_override();
 
     /* Did we create any drives that we failed to create a device for? */
-- 
2.5.5
