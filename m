Received: from eggs.gnu.org ([2001:4830:134:3::10]:55217)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1ebpu9-00050C-NG
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 10:45:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1ebpu5-0007xq-Ea
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 10:45:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41608)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1ebpu5-0007xH-9D
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 10:45:29 -0500
From: Igor Mammedov <imammedo@redhat.com>
Date: Wed, 17 Jan 2018 16:43:17 +0100
Message-Id: <1516203816-19374-6-git-send-email-imammedo@redhat.com>
In-Reply-To: <1516203816-19374-1-git-send-email-imammedo@redhat.com>
References: <1516203816-19374-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH 05/24] m68k: cpu: add TARGET_DEFAULT_CPU_TYPE
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
Cc: Laurent Vivier <laurent@vivier.eu>, Riku Voipio <riku.voipio@iki.fi>

it will be used for for 2 purposes, 1st is to
provide to cpu name resolving class for machine 'none'
  cpu_parse_cpu_model(machine_class->default_cpu_type, cpu_model)
and later to drop a bunch of ifdefs *-user/main.c that
set default cpu_model.

With the later in mind set it to 'any', which is current
default for M68K targets.

While at it, drop redundant ifdef in linux-user, as catch
all #else sets default to the same 'any' model.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
CC: Riku Voipio <riku.voipio@iki.fi>
CC: Laurent Vivier <laurent@vivier.eu>
---
 target/m68k/cpu.h | 1 +
 linux-user/main.c | 2 --
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
index 2985b03..193e8f8 100644
--- a/target/m68k/cpu.h
+++ b/target/m68k/cpu.h
@@ -405,6 +405,7 @@ void register_m68k_insns (CPUM68KState *env);
 
 #define M68K_CPU_TYPE_SUFFIX "-" TYPE_M68K_CPU
 #define M68K_CPU_TYPE_NAME(model) model M68K_CPU_TYPE_SUFFIX
+#define TARGET_DEFAULT_CPU_TYPE M68K_CPU_TYPE_NAME("any")
 
 #define cpu_signal_handler cpu_m68k_signal_handler
 #define cpu_list m68k_cpu_list
diff --git a/linux-user/main.c b/linux-user/main.c
index a35477e..54e8aac 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -4327,8 +4327,6 @@ int main(int argc, char **argv, char **envp)
 #endif
 #elif defined(TARGET_UNICORE32)
         cpu_model = "any";
-#elif defined(TARGET_M68K)
-        cpu_model = "any";
 #elif defined(TARGET_SPARC)
 #ifdef TARGET_SPARC64
         cpu_model = "TI UltraSparc II";
-- 
2.7.4
