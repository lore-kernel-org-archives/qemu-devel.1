Received: from eggs.gnu.org ([2001:4830:134:3::10]:55323)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1ebpuF-00055k-13
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 10:45:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1ebpuE-0008A4-7E
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 10:45:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41738)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1ebpuE-00089R-2A
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 10:45:38 -0500
From: Igor Mammedov <imammedo@redhat.com>
Date: Wed, 17 Jan 2018 16:43:19 +0100
Message-Id: <1516203816-19374-8-git-send-email-imammedo@redhat.com>
In-Reply-To: <1516203816-19374-1-git-send-email-imammedo@redhat.com>
References: <1516203816-19374-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH 07/24] mips: cpu: add TARGET_DEFAULT_CPU_TYPE
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
Cc: Laurent Vivier <laurent@vivier.eu>, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@mips.com>

it will be used for for 2 purposes, 1st is to
provide to cpu name resolving class for machine 'none'
  cpu_parse_cpu_model(machine_class->default_cpu_type, cpu_model)
and later to drop a bunch of ifdefs *-user/main.c that
set default cpu_model.

Take defaults types from linux-user and use them as
TARGET_DEFAULT_CPU_TYPE, which should work for *-user targets.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
CC: Aurelien Jarno <aurelien@aurel32.net>
CC: Yongbok Kim <yongbok.kim@mips.com>
---
 target/mips/cpu.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index 7f8ba5f..c5ee894 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -744,6 +744,12 @@ int cpu_mips_signal_handler(int host_signum, void *pinfo, void *puc);
 #define MIPS_CPU_TYPE_SUFFIX "-" TYPE_MIPS_CPU
 #define MIPS_CPU_TYPE_NAME(model) model MIPS_CPU_TYPE_SUFFIX
 
+#if defined(TARGET_ABI_MIPSN32) || defined(TARGET_ABI_MIPSN64)
+#define TARGET_DEFAULT_CPU_TYPE MIPS_CPU_TYPE_NAME("5KEf")
+#else
+#define TARGET_DEFAULT_CPU_TYPE MIPS_CPU_TYPE_NAME("24Kf")
+#endif
+
 bool cpu_supports_cps_smp(const char *cpu_type);
 bool cpu_supports_isa(const char *cpu_type, unsigned int isa);
 void cpu_set_exception_base(int vp_index, target_ulong address);
-- 
2.7.4
