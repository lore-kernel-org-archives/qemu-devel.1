Received: from eggs.gnu.org ([2001:4830:134:3::10]:56576)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1e9zkV-0003z9-56
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 16:36:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1e9zkT-0000yN-RH
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 16:36:31 -0400
Date: Wed, 1 Nov 2017 16:36:20 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20171101203620.GA17963@flamenco>
References: <20171025093535.10175-1-richard.henderson@linaro.org>
	<4ab3bd81-925c-a281-614c-2cd87fce38b5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ab3bd81-925c-a281-614c-2cd87fce38b5@redhat.com>
Subject: Re: [Qemu-devel] [PULL 00/51] tcg queued patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org, peter.maydell@linaro.org, qemu-arm@nongnu.org

On Wed, Nov 01, 2017 at 18:34:23 +0100, Thomas Huth wrote:
> Seems like something in this patch series broke a couple of ARM boards
> (smdkc210, nuri, raspi2, xlnx-ep108 and xlnx-zcu102). With current
> master branch, I just get this error:
> 
> $ aarch64-softmmu/qemu-system-aarch64  -machine raspi2
> **
> ERROR:/home/thuth/devel/qemu/tcg/tcg.c:537:tcg_register_thread:
> assertion failed: (n < max_cpus)
> Aborted (core dumped)
> 
> Could you please have a look at this?

Turns out some boards initialize a fixed number of vcpus, which
can be > max_cpus.

The below fixes the issue for me, although I'm not entirely happy
with it because if -{smp,max}_cpus < machine_class->max_cpus, some
TCG regions will be wasted. Not a huge deal (in most cases it will be
2MB per unused vCPU), but a better fix might be to just honour -max_cpus
for these boards. We might just not care enough though.

		Emilio

---8<---

Subject: [PATCH] hw: define and use machine_class->max_cpus_override

max_cpus needs to be an upper bound on the number of vCPUs
initialized; otherwise TCG region initialization breaks.

Some boards initialize a hard-coded number of vCPUs; mark this
with machine_class->max_cpus_override so that max_cpus is
set to machine_class->max_cpus when set.

Update the ARM boards that hard-code max_cpus, thereby letting
them boot again.

Reported-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 hw/arm/exynos4_boards.c | 2 ++
 hw/arm/raspi.c          | 1 +
 hw/arm/xlnx-zcu102.c    | 3 +++
 include/hw/boards.h     | 3 ++-
 vl.c                    | 4 ++++
 5 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/hw/arm/exynos4_boards.c b/hw/arm/exynos4_boards.c
index f1441ec..7071505 100644
--- a/hw/arm/exynos4_boards.c
+++ b/hw/arm/exynos4_boards.c
@@ -189,6 +189,7 @@ static void nuri_class_init(ObjectClass *oc, void *data)
     mc->desc = "Samsung NURI board (Exynos4210)";
     mc->init = nuri_init;
     mc->max_cpus = EXYNOS4210_NCPUS;
+    mc->max_cpus_override = 1;
     mc->ignore_memory_transaction_failures = true;
 }
 
@@ -205,6 +206,7 @@ static void smdkc210_class_init(ObjectClass *oc, void *data)
     mc->desc = "Samsung SMDKC210 board (Exynos4210)";
     mc->init = smdkc210_init;
     mc->max_cpus = EXYNOS4210_NCPUS;
+    mc->max_cpus_override = 1;
     mc->ignore_memory_transaction_failures = true;
 }
 
diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
index 5941c9f..bf4eec3 100644
--- a/hw/arm/raspi.c
+++ b/hw/arm/raspi.c
@@ -167,6 +167,7 @@ static void raspi2_machine_init(MachineClass *mc)
     mc->no_floppy = 1;
     mc->no_cdrom = 1;
     mc->max_cpus = BCM2836_NCPUS;
+    mc->max_cpus_override = 1;
     mc->default_ram_size = 1024 * 1024 * 1024;
     mc->ignore_memory_transaction_failures = true;
 };
diff --git a/hw/arm/xlnx-zcu102.c b/hw/arm/xlnx-zcu102.c
index e2d15a1..f7e0004 100644
--- a/hw/arm/xlnx-zcu102.c
+++ b/hw/arm/xlnx-zcu102.c
@@ -185,6 +185,8 @@ static void xlnx_ep108_machine_class_init(ObjectClass *oc, void *data)
     mc->block_default_type = IF_IDE;
     mc->units_per_default_bus = 1;
     mc->ignore_memory_transaction_failures = true;
+    mc->max_cpus = XLNX_ZYNQMP_NUM_APU_CPUS + XLNX_ZYNQMP_NUM_RPU_CPUS;
+    mc->max_cpus_override = 1;
 }
 
 static const TypeInfo xlnx_ep108_machine_init_typeinfo = {
@@ -241,6 +243,7 @@ static void xlnx_zcu102_machine_class_init(ObjectClass *oc, void *data)
     mc->units_per_default_bus = 1;
     mc->ignore_memory_transaction_failures = true;
     mc->max_cpus = XLNX_ZYNQMP_NUM_APU_CPUS + XLNX_ZYNQMP_NUM_RPU_CPUS;
+    mc->max_cpus_override = 1;
 }
 
 static const TypeInfo xlnx_zcu102_machine_init_typeinfo = {
diff --git a/include/hw/boards.h b/include/hw/boards.h
index 191a5b3..724be45 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -176,7 +176,8 @@ struct MachineClass {
         no_sdcard:1,
         has_dynamic_sysbus:1,
         pci_allow_0_address:1,
-        legacy_fw_cfg_order:1;
+        legacy_fw_cfg_order:1,
+        max_cpus_override:1;
     int is_default;
     const char *default_machine_opts;
     const char *default_boot_order;
diff --git a/vl.c b/vl.c
index ec29909..b2f056a 100644
--- a/vl.c
+++ b/vl.c
@@ -4336,6 +4336,10 @@ int main(int argc, char **argv, char **envp)
                      machine_class->name, machine_class->max_cpus);
         exit(1);
     }
+    /* some machines initialize a hard-coded number of cpus */
+    if (machine_class->max_cpus_override) {
+        max_cpus = machine_class->max_cpus;
+    }
 
     /*
      * Get the default machine options from the machine if it is not already
-- 
2.7.4
