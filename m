Received: from eggs.gnu.org ([2001:4830:134:3::10]:36775)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1fNcCs-0001B2-W7
	for qemu-devel@nongnu.org; Tue, 29 May 2018 06:50:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1fNcCs-0003mY-AX
	for qemu-devel@nongnu.org; Tue, 29 May 2018 06:50:23 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:55101)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
	id 1fNcCs-0003m2-3X
	for qemu-devel@nongnu.org; Tue, 29 May 2018 06:50:22 -0400
Received: by mail-wm0-x243.google.com with SMTP id f6-v6so39200773wmc.4
	for <qemu-devel@nongnu.org>; Tue, 29 May 2018 03:50:21 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Tue, 29 May 2018 12:49:37 +0200
Message-Id: <20180529105011.1914-5-edgar.iglesias@gmail.com>
In-Reply-To: <20180529105011.1914-1-edgar.iglesias@gmail.com>
References: <20180529105011.1914-1-edgar.iglesias@gmail.com>
Subject: [Qemu-devel] [PULL v1 04/38] target-microblaze: Fallback to our
 latest CPU version
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, edgar.iglesias@xilinx.com

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

Today, when running QEMU in linux-user or with boards that don't
select a specific CPU version, we treat it as an invalid version
and log a message.

Instead, if no specific version was selected, fallback to our
latest CPU version.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 target/microblaze/cpu.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
index 4dc1404800..06476f6efc 100644
--- a/target/microblaze/cpu.c
+++ b/target/microblaze/cpu.c
@@ -72,6 +72,9 @@ static const struct {
     {NULL, 0},
 };
 
+/* If no specific version gets selected, default to the following.  */
+#define DEFAULT_CPU_VERSION "10.0"
+
 static void mb_cpu_set_pc(CPUState *cs, vaddr value)
 {
     MicroBlazeCPU *cpu = MICROBLAZE_CPU(cs);
@@ -141,6 +144,7 @@ static void mb_cpu_realizefn(DeviceState *dev, Error **errp)
     MicroBlazeCPU *cpu = MICROBLAZE_CPU(cs);
     CPUMBState *env = &cpu->env;
     uint8_t version_code = 0;
+    const char *version;
     int i = 0;
     Error *local_err = NULL;
 
@@ -162,8 +166,9 @@ static void mb_cpu_realizefn(DeviceState *dev, Error **errp)
                         | PVR2_FPU_EXC_MASK \
                         | 0;
 
-    for (i = 0; mb_cpu_lookup[i].name && cpu->cfg.version; i++) {
-        if (strcmp(mb_cpu_lookup[i].name, cpu->cfg.version) == 0) {
+    version = cpu->cfg.version ? cpu->cfg.version : DEFAULT_CPU_VERSION;
+    for (i = 0; mb_cpu_lookup[i].name && version; i++) {
+        if (strcmp(mb_cpu_lookup[i].name, version) == 0) {
             version_code = mb_cpu_lookup[i].version_id;
             break;
         }
-- 
2.14.1
