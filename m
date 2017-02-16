Received: from eggs.gnu.org ([2001:4830:134:3::10]:52032)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1ceN6s-00042s-Hy
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 09:32:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1ceN6r-0008Jw-Hn
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 09:32:38 -0500
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:32886)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1ceN6r-0008JT-B5
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 09:32:37 -0500
Received: by mail-wm0-x244.google.com with SMTP id v77so3430019wmv.0
	for <qemu-devel@nongnu.org>; Thu, 16 Feb 2017 06:32:37 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 16 Feb 2017 15:31:42 +0100
Message-Id: <1487255507-106654-19-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1487255507-106654-1-git-send-email-pbonzini@redhat.com>
References: <1487255507-106654-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 18/23] vl: Move the
 cpu_synchronize_all_post_init() after generic devices initialization
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Dou Liyang <douly.fnst@cn.fujitsu.com>

From: Dou Liyang <douly.fnst@cn.fujitsu.com>

At the Qemu initialization, we call the cpu_synchronize_all_post_init()
to synchronize All CPU states to KVM in the ./vl.c::main().

Currently, it is called before we initialize the CPUs, which is created
by "-device" command and parsed by generic devices initialization, So,
these CPUs may be ignored to synchronize.

The patch moves the cpu_synchronize_all_post_init func after generic
devices initialization to make sure that all the CPUs can be included.

Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
Message-Id: <1485916178-17838-1-git-send-email-douly.fnst@cn.fujitsu.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Acked-by: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 vl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/vl.c b/vl.c
index 0d866ad..a05671d 100644
--- a/vl.c
+++ b/vl.c
@@ -4462,8 +4462,6 @@ int main(int argc, char **argv, char **envp)
 
     audio_init();
 
-    cpu_synchronize_all_post_init();
-
     if (hax_enabled()) {
         hax_sync_vcpus();
     }
@@ -4489,6 +4487,8 @@ int main(int argc, char **argv, char **envp)
         exit(1);
     }
 
+    cpu_synchronize_all_post_init();
+
     numa_post_machine_init();
 
     rom_reset_order_override();
-- 
1.8.3.1
