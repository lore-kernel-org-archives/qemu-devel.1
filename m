Received: from eggs.gnu.org ([2001:4830:134:3::10]:39924)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1eAkNr-0003rM-IM
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 18:24:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1eAkNq-0001Og-8h
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 18:24:15 -0400
Date: Fri, 3 Nov 2017 18:24:07 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20171103222407.GA22411@flamenco>
References: <1509734853-3014-1-git-send-email-cota@braap.org>
	<20171103185610.GA3907@flamenco>
	<20171103200233.GI3111@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171103200233.GI3111@localhost.localdomain>
Subject: Re: [Qemu-devel] [PATCH] hw: add .min_cpus and .default_cpus fields
 to machine_class
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org, Igor Mitsyanko <i.mitsyanko@gmail.com>, Alistair Francis <alistair.francis@xilinx.com>, "Edgar E . Iglesias" <edgar.iglesias@gmail.com>, Marcel Apfelbaum <marcel@redhat.com>

On Fri, Nov 03, 2017 at 21:02:33 +0100, Eduardo Habkost wrote:
> On Fri, Nov 03, 2017 at 02:56:10PM -0400, Emilio G. Cota wrote:
> > On Fri, Nov 03, 2017 at 14:47:33 -0400, Emilio G. Cota wrote:
> > > diff --git a/hw/arm/xlnx-zcu102.c b/hw/arm/xlnx-zcu102.c
> > > index e2d15a1..395d1b5 100644
> > > --- a/hw/arm/xlnx-zcu102.c
> > > +++ b/hw/arm/xlnx-zcu102.c
(snip)
> > 
> > Should we update max_cpus to just NUM_APU_CPUS as well for these boards?
> > -smp 5 or 6 (NUM_APU + NUM_RPU) still gets us 4 vCPUs.
> > 
> > I see there's code for RPU cpus but it seems disabled at compile-time
> > at xlnx-zynqmp.c:431:
> >    DEFINE_PROP_BOOL("has_rpu", XlnxZynqMPState, has_rpu, false)
> > Or is there a run-time way to override this?
> 
> Device properties can be overridden using -global, e.g.:
> 
>   -global driver=xlnx,,zynqmp,property=has_rpu,value=on
> 
> (",," is how commas are escaped in QEMU options)

Very interesting! This raises two separate issues.

1. Using this feature breaks 55c3cee ("qom: Introduce CPUClass.tcg_initialize",
  2017-10-24). For instance:
	qemu-system-aarch64 -machine xlnx-zcu102 \
	 -global driver=xlnx,,zynqmp,property=has_rpu,value=on
  This will try to initialize TCG twice. The reason is that the second
  set of CPUs (the "RPUs") is of a different "object type name", which ends
  up as a different CPUClass. In xlnx-zynqmp.c:

    for (i = 0; i < XLNX_ZYNQMP_NUM_RPU_CPUS; i++) {
        char *name;

        object_initialize(&s->rpu_cpu[i], sizeof(s->rpu_cpu[i]),
                          "cortex-r5-" TYPE_ARM_CPU);
  This hunk only runs when we use the -global override.

  This other hunk always runs. It initializes the "APUs":
      for (i = 0; i < XLNX_ZYNQMP_NUM_APU_CPUS; i++) {
        object_initialize(&s->apu_cpu[i], sizeof(s->apu_cpu[i]),
                          "cortex-a53-" TYPE_ARM_CPU);

  A trivial, ugly fix would be to either use the same "object name"
  for both sets of CPUs or (re)introduce a static variable in
  arm_translate_init.
  I'd prefer to be able to set tcg_initialized field directly for
  the RPU's CPUClass. Is that possible? I don't know much about
  qom/object code, so any good suggestion here would be appreciated.

2. Coming back to the original problem: given that we can get
  additional vCPUs, I think we need an additional flag to signal
  this. Otherwise we'll have to always do "max_cpus = mc.max_cpus",
  which for most machines would be a huge waste of TCG regions.
  See delta below.

Thanks,

		Emilio

diff --git a/include/hw/boards.h b/include/hw/boards.h
index 62f160e..8c8ce51 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -103,6 +103,7 @@ typedef struct {
 /**
  * MachineClass:
  * @max_cpus: maximum number of CPUs supported. Default: 1
+ * @force_max_cpus: if set, force the global max_cpus to match @max_cpus
  * @min_cpus: minimum number of CPUs supported. Default: 1
  * @default_cpus: number of CPUs instantiated if none are specified. Default: 1
  * @get_hotplug_handler: this function is called during bus-less
@@ -181,7 +182,8 @@ struct MachineClass {
         no_sdcard:1,
         has_dynamic_sysbus:1,
         pci_allow_0_address:1,
-        legacy_fw_cfg_order:1;
+        legacy_fw_cfg_order:1,
+        force_max_cpus;
     int is_default;
     const char *default_machine_opts;
     const char *default_boot_order;
diff --git a/hw/arm/xlnx-zcu102.c b/hw/arm/xlnx-zcu102.c
index 395d1b5..e406dc3 100644
--- a/hw/arm/xlnx-zcu102.c
+++ b/hw/arm/xlnx-zcu102.c
@@ -186,6 +186,7 @@ static void xlnx_ep108_machine_class_init(ObjectClass *oc, void *data)
     mc->units_per_default_bus = 1;
     mc->ignore_memory_transaction_failures = true;
     mc->max_cpus = XLNX_ZYNQMP_NUM_APU_CPUS + XLNX_ZYNQMP_NUM_RPU_CPUS;
+    mc->force_max_cpus = 1;
     mc->min_cpus = XLNX_ZYNQMP_NUM_APU_CPUS;
     mc->default_cpus = XLNX_ZYNQMP_NUM_APU_CPUS;
 }
@@ -244,6 +245,7 @@ static void xlnx_zcu102_machine_class_init(ObjectClass *oc, void *data)
     mc->units_per_default_bus = 1;
     mc->ignore_memory_transaction_failures = true;
     mc->max_cpus = XLNX_ZYNQMP_NUM_APU_CPUS + XLNX_ZYNQMP_NUM_RPU_CPUS;
+    mc->force_max_cpus = 1;
     mc->min_cpus = XLNX_ZYNQMP_NUM_APU_CPUS;
     mc->default_cpus = XLNX_ZYNQMP_NUM_APU_CPUS;
 }
diff --git a/vl.c b/vl.c
index 3ca5ee8..a21183d 100644
--- a/vl.c
+++ b/vl.c
@@ -4339,6 +4339,15 @@ int main(int argc, char **argv, char **envp)
         max_cpus = machine_class->default_cpus;
     }
 
+    /*
+     * Some boards can instantiate additional CPUs, e.g. by overriding
+     * device params via -global arguments, so they enforce the value
+     * that max_cpus should take.
+     */
+    if (machine_class->force_max_cpus) {
+        max_cpus = machine_class->max_cpus;
+    }
+
     /* sanity-check smp_cpus and max_cpus */
     if (smp_cpus < machine_class->min_cpus) {
         error_report("Invalid SMP CPUs %d. The min CPUs "
