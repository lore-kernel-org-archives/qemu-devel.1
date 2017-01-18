Received: from eggs.gnu.org ([2001:4830:134:3::10]:59424)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1cTqTs-0002Ja-LM
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 08:40:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1cTqTq-0001cw-1x
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 08:40:52 -0500
Received: from [59.151.112.132] (port=11603 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1cTqTp-0001bp-JQ
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 08:40:49 -0500
From: Dou Liyang <douly.fnst@cn.fujitsu.com>
Date: Wed, 18 Jan 2017 21:39:55 +0800
Message-ID: <1484746795-19523-1-git-send-email-douly.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2] vl: Ensure the
 cpu_synchronize_all_post_init() in the appropriate location
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, alex.bennee@linaro.org, rth@twiddle.net, sergey.fedorov@linaro.org, izumi.taku@jp.fujitsu.com, caoj.fnst@cn.fujitsu.com, fanc.fnst@cn.fujitsu.com, Dou Liyang <douly.fnst@cn.fujitsu.com>

At the Qemu initialization, we call the cpu_synchronize_all_post_init()
to synchronize All CPU states to KVM in the ./vl.c::main().

Currently, it is called before we initialize the CPUs, which created by
"-device" command, So, these CPUs may be ignored to synchronize.

The patch moves the numa_post_machine_init func in the appropriate
location to make sure that all the CPUs has already been created
when it is called.

Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
---

Change log v1-> v2:
1. Split it from 
https://lists.nongnu.org/archive/html/qemu-devel/2017-01/msg03354.html
2. Rewrite the log.

 vl.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/vl.c b/vl.c
index c643d3f..38269be 100644
--- a/vl.c
+++ b/vl.c
@@ -4547,8 +4547,6 @@ int main(int argc, char **argv, char **envp)
 
     audio_init();
 
-    cpu_synchronize_all_post_init();
-
     numa_post_machine_init();
 
     if (qemu_opts_foreach(qemu_find_opts("fw_cfg"),
@@ -4571,6 +4569,9 @@ int main(int argc, char **argv, char **envp)
                           device_init_func, NULL, NULL)) {
         exit(1);
     }
+
+    cpu_synchronize_all_post_init();
+
     rom_reset_order_override();
 
     /* Did we create any drives that we failed to create a device for? */
-- 
2.5.5
