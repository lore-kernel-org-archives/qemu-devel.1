Received: from eggs.gnu.org ([2001:4830:134:3::10]:58361)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1cYkgs-0008VY-UR
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 21:30:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1cYkgp-0002gh-2C
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 21:30:34 -0500
Received: from [59.151.112.132] (port=46623 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1cYkgo-0002g2-Hi
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 21:30:30 -0500
From: Dou Liyang <douly.fnst@cn.fujitsu.com>
Date: Wed, 1 Feb 2017 10:29:38 +0800
Message-ID: <1485916178-17838-1-git-send-email-douly.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v3] vl: Move the
 cpu_synchronize_all_post_init() after generic devices initialization
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, alex.bennee@linaro.org, rth@twiddle.net, crosthwaite.peter@gmail.com
Cc: qemu-devel@nongnu.org, izumi.taku@jp.fujitsu.com, caoj.fnst@cn.fujitsu.com, fanc.fnst@cn.fujitsu.com, Dou Liyang <douly.fnst@cn.fujitsu.com>

At the Qemu initialization, we call the cpu_synchronize_all_post_init()
to synchronize All CPU states to KVM in the ./vl.c::main().

Currently, it is called before we initialize the CPUs, which is created
by "-device" command and parsed by generic devices initialization, So,
these CPUs may be ignored to synchronize.

The patch moves the cpu_synchronize_all_post_init func after generic
devices initialization to make sure that all the CPUs can be included.

Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
---
Change log:
v2-> v3:
1. Rebase the patch.
2. Rewrite the log
v1-> v2:
1. Split it from
https://lists.nongnu.org/archive/html/qemu-devel/2017-01/msg03354.html
2. Rewrite the log.

 vl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/vl.c b/vl.c
index 0b72b12..bceb835 100644
--- a/vl.c
+++ b/vl.c
@@ -4490,8 +4490,6 @@ int main(int argc, char **argv, char **envp)
 
     audio_init();
 
-    cpu_synchronize_all_post_init();
-
     if (hax_enabled()) {
         hax_sync_vcpus();
     }
@@ -4517,6 +4515,8 @@ int main(int argc, char **argv, char **envp)
         exit(1);
     }
 
+    cpu_synchronize_all_post_init();
+
     numa_post_machine_init();
 
     rom_reset_order_override();
-- 
2.5.5
