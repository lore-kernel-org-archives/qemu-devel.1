Received: from eggs.gnu.org ([208.118.235.92]:52335)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fg8b3-00057H-CR
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 09:05:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fg8ZH-0000K9-45
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 09:03:53 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43890 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fg8ZG-0000JT-Oy
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 09:02:02 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Thu, 19 Jul 2018 15:02:00 +0200
Message-Id: <1532005320-17794-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH] target/xtensa/cpu: Set owner of memory region
 in xtensa_cpu_initfn
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Max Filippov <jcmvbkbc@gmail.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>

The instance_init function of the xtensa CPUs creates a memory region,
but does not set an owner, so the memory region is not destroyed
correctly when the CPU object is removed. This can happen when
introspecting the CPU devices, so introspecting the CPU device will
leave a dangling memory region object in the QOM tree. Make sure to
set the right owner here to fix this issue.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 target/xtensa/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/xtensa/cpu.c b/target/xtensa/cpu.c
index b50c840..590813d 100644
--- a/target/xtensa/cpu.c
+++ b/target/xtensa/cpu.c
@@ -149,7 +149,7 @@ static void xtensa_cpu_initfn(Object *obj)
 #ifndef CONFIG_USER_ONLY
     env->address_space_er = g_malloc(sizeof(*env->address_space_er));
     env->system_er = g_malloc(sizeof(*env->system_er));
-    memory_region_init_io(env->system_er, NULL, NULL, env, "er",
+    memory_region_init_io(env->system_er, obj, NULL, env, "er",
                           UINT64_C(0x100000000));
     address_space_init(env->address_space_er, env->system_er, "ER");
 #endif
-- 
1.8.3.1
