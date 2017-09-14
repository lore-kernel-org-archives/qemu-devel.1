Received: from eggs.gnu.org ([2001:4830:134:3::10]:60149)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dsVhL-0006G3-NM
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 11:05:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dsVhK-0002Bq-NY
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 11:04:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33868)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dsVhK-0002B3-Hp
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 11:04:58 -0400
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Thu, 14 Sep 2017 16:04:42 +0100
Message-Id: <20170914150447.19352-3-dgilbert@redhat.com>
In-Reply-To: <20170914150447.19352-1-dgilbert@redhat.com>
References: <20170914150447.19352-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PULL 2/7] hmp: fix "dump-quest-memory" segfault (arm)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, lvivier@redhat.com, cohuck@redhat.com, vadim.galitsyn@profitbricks.com
Cc: imammedo@redhat.com, thuth@redhat.com, peterx@redhat.com, groug@kaod.org

From: Laurent Vivier <lvivier@redhat.com>

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
Message-Id: <20170913142036.2469-3-lvivier@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
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
