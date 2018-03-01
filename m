Received: from eggs.gnu.org ([2001:4830:134:3::10]:48867)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1erRKW-0005Vu-Ke
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 11:45:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1erRKU-0008NH-Ol
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 11:45:16 -0500
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:41226)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1erRKU-0008MG-G2
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 11:45:14 -0500
Received: by mail-ot0-x244.google.com with SMTP id w38so6144090ota.8
	for <qemu-devel@nongnu.org>; Thu, 01 Mar 2018 08:45:14 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1519815685-29200-4-git-send-email-abdallah.bouassida@lauterbach.com>
References: <1519815685-29200-1-git-send-email-abdallah.bouassida@lauterbach.com>
	<1519815685-29200-4-git-send-email-abdallah.bouassida@lauterbach.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 1 Mar 2018 16:44:53 +0000
Message-ID: <CAFEAcA88s2X9qkFVYG6kmeeZj6-bp0uskXb8TJF0HMfUVVSf8A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 3/4] target/arm: Add the XML dynamic
 generation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Abdallah Bouassida <abdallah.bouassida@lauterbach.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Khaled Jmal <khaled.jmal@lauterbach.com>

On 28 February 2018 at 11:01, Abdallah Bouassida
<abdallah.bouassida@lauterbach.com> wrote:
> Generate an XML description for the cp-regs.
> Register these regs with the gdb_register_coprocessor().
> Add arm_gdb_get_sysreg() to use it as a callback to read those regs.
>
> Signed-off-by: Abdallah Bouassida <abdallah.bouassida@lauterbach.com>
> ---
>  gdbstub.c            |  7 ++++
>  include/qom/cpu.h    |  9 ++++-
>  target/arm/cpu.c     |  3 ++
>  target/arm/cpu.h     | 17 +++++++++
>  target/arm/gdbstub.c | 97 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 132 insertions(+), 1 deletion(-)
>
> diff --git a/gdbstub.c b/gdbstub.c
> index f1d5148..ffab30b 100644
> --- a/gdbstub.c
> +++ b/gdbstub.c
> @@ -665,6 +665,9 @@ static const char *get_feature_xml(const char *p, const char **newp,
>              pstrcat(target_xml, sizeof(target_xml), "<xi:include href=\"");
>              pstrcat(target_xml, sizeof(target_xml), cc->gdb_core_xml_file);
>              pstrcat(target_xml, sizeof(target_xml), "\"/>");
> +            if (cc->gdb_has_dynamic_xml) {
> +                cc->register_gdb_regs_for_features(cpu);
> +            }

I don't think we need a callback hook for this. You could just assume
the target code has already done whatever it needs. Specifically for
arm you can just make arm_cpu_register_gdb_regs_for_features() in helper.c
call gdb_register_coprocessor(..., "system-registers.xml",...) the
same way it already does for other xml files.

>              for (r = cpu->gdb_regs; r; r = r->next) {
>                  pstrcat(target_xml, sizeof(target_xml), "<xi:include href=\"");
>                  pstrcat(target_xml, sizeof(target_xml), r->xml);
> @@ -674,6 +677,10 @@ static const char *get_feature_xml(const char *p, const char **newp,
>          }
>          return target_xml;
>      }
> +    if (strncmp(p, "system-registers.xml", len) == 0) {
> +        CPUState *cpu = first_cpu;
> +        return cc->gdb_get_dynamic_xml(cpu);
> +    }

Rather than hardcoding that "system-registers.xml" is special, just
have the hook pass the xml filename to the CPU hook, and let it
decide whether it wants to handle the filename or not.

Also you must check whether the hook function is NULL before calling it,
or this will crash on CPUs that haven't implemented it.

>      for (i = 0; ; i++) {
>          name = xml_builtin[i][0];
>          if (!name || (strncmp(name, p, len) == 0 && strlen(name) == len))
> diff --git a/include/qom/cpu.h b/include/qom/cpu.h
> index aff88fa..04771b3 100644
> --- a/include/qom/cpu.h
> +++ b/include/qom/cpu.h
> @@ -131,6 +131,11 @@ struct TranslationBlock;
>   *           before the insn which triggers a watchpoint rather than after it.
>   * @gdb_arch_name: Optional callback that returns the architecture name known
>   * to GDB. The caller must free the returned string with g_free.
> + * @gdb_has_dynamic_xml: Indicates if GDB supports generating a dynamic XML
> + *                   description for the sysregs of this CPU.
> + * @register_gdb_regs_for_features: Callback for letting GDB create a dynamic
> + *       XML description for the sysregs and register those sysregs afterwards.
> + * @gdb_get_dynamic_xml: Callback for letting GDB get the dynamic XML.
>   * @cpu_exec_enter: Callback for cpu_exec preparation.
>   * @cpu_exec_exit: Callback for cpu_exec cleanup.
>   * @cpu_exec_interrupt: Callback for processing interrupts in cpu_exec.
> @@ -197,7 +202,9 @@ typedef struct CPUClass {
>      const struct VMStateDescription *vmsd;
>      const char *gdb_core_xml_file;
>      gchar * (*gdb_arch_name)(CPUState *cpu);
> -
> +    bool gdb_has_dynamic_xml;
> +    void (*register_gdb_regs_for_features)(CPUState *cpu);
> +    char *(*gdb_get_dynamic_xml)(CPUState *cpu);

You should only need one new field, something like
       char *(*gdb_get_dynamic_xml)(CPUState *cpu, const char *xmlname);
doc comment something like
    * gdb_get_dynamic_xml: Callback to return dynamically generated XML
      for the gdb stub. Returns a pointer to the XML contents for the
      specified XML file, or NULL if the CPU doesn't have dynamically
      generated contents for it.

>      void (*cpu_exec_enter)(CPUState *cpu);
>      void (*cpu_exec_exit)(CPUState *cpu);
>      bool (*cpu_exec_interrupt)(CPUState *cpu, int interrupt_request);
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index 1b3ae62..04c4d04 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -1781,6 +1781,9 @@ static void arm_cpu_class_init(ObjectClass *oc, void *data)
>      cc->gdb_num_core_regs = 26;
>      cc->gdb_core_xml_file = "arm-core.xml";
>      cc->gdb_arch_name = arm_gdb_arch_name;
> +    cc->gdb_has_dynamic_xml = true;
> +    cc->register_gdb_regs_for_features = arm_register_gdb_regs_for_features;
> +    cc->gdb_get_dynamic_xml = arm_gdb_get_dynamic_xml;
>      cc->gdb_stop_before_watchpoint = true;
>      cc->debug_excp_handler = arm_debug_excp_handler;
>      cc->debug_check_watchpoint = arm_debug_check_watchpoint;
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 92cfe4c..0e35f64 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -133,6 +133,19 @@ enum {
>     s<2n+1> maps to the most significant half of d<n>
>   */
>
> +/**
> + * DynamicGDBXMLInfo:
> + * @desc: Contains the XML descriptions.
> + * @num_cpregs: Number of the Coprocessor registers seen by GDB.
> + * @cpregs_keys: Array that contains the corresponding Key of
> + * a given cpreg with the same order of the cpreg in the XML description.
> + */
> +typedef struct DynamicGDBXMLInfo {
> +    char *desc;
> +    int num_cpregs;
> +    uint32_t *cpregs_keys;
> +} DynamicGDBXMLInfo;
> +
>  /* CPU state for each instance of a generic timer (in cp15 c14) */
>  typedef struct ARMGenericTimer {
>      uint64_t cval; /* Timer CompareValue register */
> @@ -671,6 +684,8 @@ struct ARMCPU {
>      uint64_t *cpreg_vmstate_values;
>      int32_t cpreg_vmstate_array_len;
>
> +    DynamicGDBXMLInfo dyn_xml;
> +
>      /* Timers used by the generic (architected) timer */
>      QEMUTimer *gt_timer[NUM_GTIMERS];
>      /* GPIO outputs for generic timer */
> @@ -835,6 +850,8 @@ hwaddr arm_cpu_get_phys_page_attrs_debug(CPUState *cpu, vaddr addr,
>
>  int arm_cpu_gdb_read_register(CPUState *cpu, uint8_t *buf, int reg);
>  int arm_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
> +void arm_register_gdb_regs_for_features(CPUState *cpu);
> +char *arm_gdb_get_dynamic_xml(CPUState *cpu);
>
>  int arm_cpu_write_elf64_note(WriteCoreDumpFunction f, CPUState *cs,
>                               int cpuid, void *opaque);
> diff --git a/target/arm/gdbstub.c b/target/arm/gdbstub.c
> index 04c1208..e08ad79 100644
> --- a/target/arm/gdbstub.c
> +++ b/target/arm/gdbstub.c
> @@ -101,3 +101,100 @@ int arm_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
>      /* Unknown register.  */
>      return 0;
>  }
> +
> +static void arm_gen_one_xml_reg_tag(DynamicGDBXMLInfo *dyn_xml,
> +                                    ARMCPRegInfo *ri, uint32_t ri_key,
> +                                    bool is64)
> +{
> +    GString *s = g_string_new(dyn_xml->desc);

Rather than creating a new GString here, use the one you
already had in arm_gen_dynamic_xml() to do all the appending,
and only convert it to an actual C string at the very end.

> +
> +    g_string_append_printf(s, "<reg name=\"%s\"", ri->name);
> +    g_string_append_printf(s, " bitsize=\"%s\"", is64 ? "64" : "32");
> +    g_string_append_printf(s, " group=\"cp_regs\"/>");
> +    dyn_xml->desc = g_string_free(s, false);
> +    dyn_xml->num_cpregs++;
> +    dyn_xml->cpregs_keys = g_renew(uint32_t,
> +                                       dyn_xml->cpregs_keys,
> +                                       dyn_xml->num_cpregs);
> +    dyn_xml->cpregs_keys[dyn_xml->num_cpregs - 1] = ri_key;
> +}
> +
> +static void arm_register_sysreg_for_xml(gpointer key, gpointer value,
> +                                        gpointer cs)
> +{
> +    ARMCPU *cpu = ARM_CPU(cs);
> +    CPUARMState *env = &cpu->env;
> +    ARMCPRegInfo *ri = value;
> +    uint32_t ri_key = *(uint32_t *)key;
> +
> +    if (!(ri->type & (ARM_CP_NO_RAW | ARM_CP_NO_GDB))) {
> +        if (env->aarch64) {
> +            if (ri->state == ARM_CP_STATE_AA64) {
> +                arm_gen_one_xml_reg_tag(&cpu->dyn_xml, ri, ri_key, 1);
> +            }
> +        } else {
> +            if (ri->state == ARM_CP_STATE_AA32) {
> +                if (!arm_feature(env, ARM_FEATURE_EL3) &&
> +                    (ri->secure & ARM_CP_SECSTATE_S)) {
> +                    return;
> +                }
> +                if (ri->type & ARM_CP_64BIT) {
> +                    arm_gen_one_xml_reg_tag(&cpu->dyn_xml, ri, ri_key, 1);
> +                } else {
> +                    arm_gen_one_xml_reg_tag(&cpu->dyn_xml, ri, ri_key, 0);
> +                }
> +            }
> +        }
> +    }
> +}
> +
> +static int arm_gen_dynamic_xml(CPUState *cs)
> +{
> +    ARMCPU *cpu = ARM_CPU(cs);
> +    GString *s = g_string_new(NULL);
> +
> +    cpu->dyn_xml.num_cpregs = 0;
> +    g_string_printf(s, "<?xml version=\"1.0\"?>");
> +    g_string_append_printf(s, "<!DOCTYPE target SYSTEM \"gdb-target.dtd\">");
> +    g_string_append_printf(s, "<feature name=\"org.gnu.gdb.sys.regs\">");
> +    cpu->dyn_xml.desc = g_string_free(s, false);
> +    g_hash_table_foreach(cpu->cp_regs, arm_register_sysreg_for_xml, cs);
> +    s = g_string_new(cpu->dyn_xml.desc);
> +    g_string_append_printf(s, "</feature>");
> +    cpu->dyn_xml.desc = g_string_free(s, false);
> +    return  cpu->dyn_xml.num_cpregs;
> +}
> +
> +static int arm_gdb_get_sysreg(CPUARMState *env, uint8_t *buf, int reg)
> +{
> +    ARMCPU *cpu = arm_env_get_cpu(env);
> +    const ARMCPRegInfo *ri;
> +    uint32_t key;
> +
> +    key = cpu->dyn_xml.cpregs_keys[reg];
> +    ri = get_arm_cp_reginfo(cpu->cp_regs, key);
> +    if (ri) {
> +        if (cpreg_field_is_64bit(ri)) {
> +            return gdb_get_reg64(buf, (uint64_t)read_raw_cp_reg(env, ri));
> +        } else {
> +            return gdb_get_reg32(buf, (uint32_t)read_raw_cp_reg(env, ri));
> +        }
> +    }
> +    return 0;
> +}
> +
> +void arm_register_gdb_regs_for_features(CPUState *cs)
> +{
> +    int n;
> +
> +    n = arm_gen_dynamic_xml(cs);
> +    gdb_register_coprocessor(cs, arm_gdb_get_sysreg, NULL,
> +                             n, "system-registers.xml", 0);
> +
> +}
> +
> +char *arm_gdb_get_dynamic_xml(CPUState *cs)
> +{
> +    ARMCPU *cpu = ARM_CPU(cs);
> +    return cpu->dyn_xml.desc;
> +}
> --

thanks
-- PMM
