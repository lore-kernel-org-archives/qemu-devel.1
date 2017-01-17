Received: from eggs.gnu.org ([2001:4830:134:3::10]:48167)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1cTUya-000276-TC
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 09:43:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1cTUyW-0001bo-Uw
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 09:43:08 -0500
Received: from [59.151.112.132] (port=22898 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1cTUyW-0001RO-IX
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 09:43:04 -0500
From: Dou Liyang <douly.fnst@cn.fujitsu.com>
Date: Tue, 17 Jan 2017 22:42:32 +0800
Message-ID: <1484664152-24446-3-git-send-email-douly.fnst@cn.fujitsu.com>
In-Reply-To: <1484664152-24446-1-git-send-email-douly.fnst@cn.fujitsu.com>
References: <1484664152-24446-1-git-send-email-douly.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 2/2] vl: Ensure the
 cpu_synchronize_all_post_init func in the appropriate location
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

As the commit a4088c3eecb5f said, In the cpu_synchronize_all_post_init(),
we also use CPU_FOREACH macro to set all CPUs' namu_node. So, we should
make sure that we call it after Qemu has already initialied all the CPUs.

The patch move the numa_post_machine_init func in the appropriate
location.

Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
---
 vl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/vl.c b/vl.c
index f38b0e2..75adc2a 100644
--- a/vl.c
+++ b/vl.c
@@ -4547,8 +4547,6 @@ int main(int argc, char **argv, char **envp)
 
     audio_init();
 
-    cpu_synchronize_all_post_init();
-
     if (qemu_opts_foreach(qemu_find_opts("fw_cfg"),
                           parse_fw_cfg, fw_cfg_find(), NULL) != 0) {
         exit(1);
@@ -4570,6 +4568,8 @@ int main(int argc, char **argv, char **envp)
         exit(1);
     }
 
+    cpu_synchronize_all_post_init();
+
     numa_post_machine_init();
 
     rom_reset_order_override();
-- 
2.5.5
