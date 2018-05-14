Received: from eggs.gnu.org ([2001:4830:134:3::10]:40883)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fIFbU-0000QJ-5N
	for qemu-devel@nongnu.org; Mon, 14 May 2018 11:41:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fIFbQ-0007Zk-2I
	for qemu-devel@nongnu.org; Mon, 14 May 2018 11:41:36 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Mon, 14 May 2018 17:41:14 +0200
Message-Id: <20180514154114.2558-7-cohuck@redhat.com>
In-Reply-To: <20180514154114.2558-1-cohuck@redhat.com>
References: <20180514154114.2558-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 6/6] target/s390x: Fix brace Werror with clang
 6.0.0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, Cornelia Huck <cohuck@redhat.com>

From: Richard Henderson <richard.henderson@linaro.org>

The warning is

target/s390x/misc_helper.c:209:21: error: suggest
      braces around initialization of subobject [-Werror,-Wmissing-braces]
    SysIB sysib = { 0 };
                    ^
                    {}

While the original code is correct, and technically exactly correct
as per ISO C89, both GCC and Clang support plain empty set of braces
as an extension.

Cc: Alexander Graf <agraf@suse.de>
Cc: David Hildenbrand <david@redhat.com>
Cc: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20180512045950.12386-5-richard.henderson@linaro.org>
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/misc_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/s390x/misc_helper.c b/target/s390x/misc_helper.c
index e0b23c1fd1..1f834f35ef 100644
--- a/target/s390x/misc_helper.c
+++ b/target/s390x/misc_helper.c
@@ -206,7 +206,7 @@ uint32_t HELPER(stsi)(CPUS390XState *env, uint64_t a0, uint64_t r0, uint64_t r1)
     const MachineState *ms = MACHINE(qdev_get_machine());
     uint16_t total_cpus = 0, conf_cpus = 0, reserved_cpus = 0;
     S390CPU *cpu = s390_env_get_cpu(env);
-    SysIB sysib = { 0 };
+    SysIB sysib = { };
     int i, cc = 0;
 
     if ((r0 & STSI_R0_FC_MASK) > STSI_R0_FC_LEVEL_3) {
-- 
2.14.3
