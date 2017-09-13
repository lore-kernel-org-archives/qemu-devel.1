Received: from eggs.gnu.org ([2001:4830:134:3::10]:35599)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1ds8XD-0004eq-5U
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 10:21:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1ds8XC-0003Xj-6o
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 10:20:59 -0400
From: Laurent Vivier <lvivier@redhat.com>
Date: Wed, 13 Sep 2017 16:20:34 +0200
Message-Id: <20170913142036.2469-3-lvivier@redhat.com>
In-Reply-To: <20170913142036.2469-1-lvivier@redhat.com>
References: <20170913142036.2469-1-lvivier@redhat.com>
Subject: [Qemu-devel] [PATCH v4 2/4] hmp: fix "dump-quest-memory" segfault
 (arm)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr . David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org
Cc: "Daniel P . Berrange" <berrange@redhat.com>, Cornelia Huck <cohuck@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Greg Kurz <groug@kaod.org>, Laurent Vivier <lvivier@redhat.com>

Running QEMU with
    qemu-system-aarch64 -M none -nographic -m 256
and executing
    dump-guest-memory /dev/null 0 8192
results in segfault

Fix by checking if we have CPU, and exit with
error if there is no CPU:

    (qemu) dump-guest-memory /dev/null
    this feature or command is not currently supported

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
---
 target/arm/arch_dump.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/target/arm/arch_dump.c b/target/arm/arch_dump.c
index 1a9861f69b..9e5b2fb31c 100644
--- a/target/arm/arch_dump.c
+++ b/target/arm/arch_dump.c
@@ -273,11 +273,18 @@ int arm_cpu_write_elf32_note(WriteCoreDumpFunction f, CPUState *cs,
 int cpu_get_dump_info(ArchDumpInfo *info,
                       const GuestPhysBlockList *guest_phys_blocks)
 {
-    ARMCPU *cpu = ARM_CPU(first_cpu);
-    CPUARMState *env = &cpu->env;
+    ARMCPU *cpu;
+    CPUARMState *env;
     GuestPhysBlock *block;
     hwaddr lowest_addr = ULLONG_MAX;
 
+    if (first_cpu == NULL) {
+        return -1;
+    }
+
+    cpu = ARM_CPU(first_cpu);
+    env = &cpu->env;
+
     /* Take a best guess at the phys_base. If we get it wrong then crash
      * will need '--machdep phys_offset=<phys-offset>' added to its command
      * line, which isn't any worse than assuming we can use zero, but being
-- 
2.13.5
