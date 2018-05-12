Received: from eggs.gnu.org ([2001:4830:134:3::10]:44315)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fHJdp-00031y-Gc
	for qemu-devel@nongnu.org; Fri, 11 May 2018 21:48:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fHJdn-0007GS-M5
	for qemu-devel@nongnu.org; Fri, 11 May 2018 21:48:09 -0400
Received: from mail-pl0-x242.google.com ([2607:f8b0:400e:c01::242]:35343)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fHJdn-0007Fp-Fl
	for qemu-devel@nongnu.org; Fri, 11 May 2018 21:48:07 -0400
Received: by mail-pl0-x242.google.com with SMTP id i5-v6so4204991plt.2
	for <qemu-devel@nongnu.org>; Fri, 11 May 2018 18:48:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri, 11 May 2018 18:48:01 -0700
Message-Id: <20180512014801.17566-2-richard.henderson@linaro.org>
In-Reply-To: <20180512014801.17566-1-richard.henderson@linaro.org>
References: <20180512014801.17566-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 2/2] target/s390x: Fix brace Werror with clang
 6.0.0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@suse.de>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>

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
2.17.0
