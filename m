Received: from eggs.gnu.org ([2001:4830:134:3::10]:55415)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1ebpuK-0005BZ-8S
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 10:45:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1ebpuH-0008EM-5Q
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 10:45:44 -0500
From: Igor Mammedov <imammedo@redhat.com>
Date: Wed, 17 Jan 2018 16:43:23 +0100
Message-Id: <1516203816-19374-12-git-send-email-imammedo@redhat.com>
In-Reply-To: <1516203816-19374-1-git-send-email-imammedo@redhat.com>
References: <1516203816-19374-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH 11/24] ppc: cpu: add TARGET_DEFAULT_CPU_TYPE
 macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Riku Voipio <riku.voipio@iki.fi>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org

it will be used for for 2 purposes, 1st is to
provide to cpu name resolving class for machine 'none'
  cpu_parse_cpu_model(machine_class->default_cpu_type, cpu_model)
and later to drop a bunch of ifdefs *-user/main.c that
set default cpu_model.

Use default values from linux-user for TARGET_DEFAULT_CPU_TYPE.
While at it fixup linux-user to use corresponding cpu models
instead of aliases.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
CC: Riku Voipio <riku.voipio@iki.fi>
CC: Laurent Vivier <laurent@vivier.eu>
CC: David Gibson <david@gibson.dropbear.id.au>
CC: Alexander Graf <agraf@suse.de>
CC: qemu-ppc@nongnu.org
---
 target/ppc/cpu.h  | 6 ++++++
 linux-user/main.c | 4 ++--
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index a5e49f2..4af4aff 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1377,6 +1377,12 @@ int ppc_dcr_write (ppc_dcr_t *dcr_env, int dcrn, uint32_t val);
 #define POWERPC_CPU_TYPE_SUFFIX "-" TYPE_POWERPC_CPU
 #define POWERPC_CPU_TYPE_NAME(model) model POWERPC_CPU_TYPE_SUFFIX
 
+#ifdef TARGET_PPC64
+#define TARGET_DEFAULT_CPU_TYPE POWERPC_CPU_TYPE_NAME("power8_v2.0")
+#else
+#define TARGET_DEFAULT_CPU_TYPE POWERPC_CPU_TYPE_NAME("750_v3.1")
+#endif
+
 #define cpu_signal_handler cpu_ppc_signal_handler
 #define cpu_list ppc_cpu_list
 
diff --git a/linux-user/main.c b/linux-user/main.c
index 54e8aac..279cd97 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -4343,9 +4343,9 @@ int main(int argc, char **argv, char **envp)
         cpu_model = "or1200";
 #elif defined(TARGET_PPC)
 # ifdef TARGET_PPC64
-        cpu_model = "POWER8";
+        cpu_model = "power8_v2.0";
 # else
-        cpu_model = "750";
+        cpu_model = "750_v3.1";
 # endif
 #elif defined TARGET_SH4
         cpu_model = "sh7785";
-- 
2.7.4
