Received: from eggs.gnu.org ([2001:4830:134:3::10]:39068)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1evn27-0007BV-TT
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 12:44:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1evn26-0007p4-47
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 12:44:15 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:43965)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1evn25-0007ok-TT
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 12:44:14 -0400
Received: by mail-oi0-x241.google.com with SMTP id a207so211189oii.10
	for <qemu-devel@nongnu.org>; Tue, 13 Mar 2018 09:44:13 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1520850690-23245-4-git-send-email-abdallah.bouassida@lauterbach.com>
References: <1520850690-23245-1-git-send-email-abdallah.bouassida@lauterbach.com>
	<1520850690-23245-4-git-send-email-abdallah.bouassida@lauterbach.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 13 Mar 2018 16:43:52 +0000
Message-ID: <CAFEAcA-i2H6whiA0=jofb2jRHeYFTwOsuvnz+iyfgcznmyVyxA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v4 3/4] target/arm: Add the XML dynamic
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

On 12 March 2018 at 10:31, Abdallah Bouassida
<abdallah.bouassida@lauterbach.com> wrote:
> Generate an XML description for the cp-regs.
> Register these regs with the gdb_register_coprocessor().
> Add arm_gdb_get_sysreg() to use it as a callback to read those regs.
> Add a dummy arm_gdb_set_sysreg().
>
> Signed-off-by: Abdallah Bouassida <abdallah.bouassida@lauterbach.com>
> ---
>  gdbstub.c            | 10 ++++++++
>  include/qom/cpu.h    |  5 +++-
>  target/arm/cpu.c     |  1 +
>  target/arm/cpu.h     | 17 +++++++++++++
>  target/arm/gdbstub.c | 71 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  target/arm/helper.c  | 27 ++++++++++++++++++++
>  6 files changed, 130 insertions(+), 1 deletion(-)
>
> diff --git a/gdbstub.c b/gdbstub.c
> index f1d5148..160bdbd 100644
> --- a/gdbstub.c
> +++ b/gdbstub.c
> @@ -674,6 +674,16 @@ static const char *get_feature_xml(const char *p, const char **newp,
>          }
>          return target_xml;
>      }
> +    if (cc->gdb_get_dynamic_xml) {
> +        CPUState *cpu = first_cpu;
> +        char *xmlname = g_strndup(p, len);
> +        const char *xml = cc->gdb_get_dynamic_xml(cpu, xmlname, len);

You've just turned the string name into a properly NUL terminated
string, so you don't need to pass len to the hook.

> +
> +        free(xmlname);
> +        if (xml) {
> +            return xml;
> +        }
> +    }
>      for (i = 0; ; i++) {
>          name = xml_builtin[i][0];
>          if (!name || (strncmp(name, p, len) == 0 && strlen(name) == len))
> diff --git a/include/qom/cpu.h b/include/qom/cpu.h
> index aff88fa..3f53da7 100644
> --- a/include/qom/cpu.h
> +++ b/include/qom/cpu.h
> @@ -131,6 +131,9 @@ struct TranslationBlock;
>   *           before the insn which triggers a watchpoint rather than after it.
>   * @gdb_arch_name: Optional callback that returns the architecture name known
>   * to GDB. The caller must free the returned string with g_free.
> + * @gdb_get_dynamic_xml: Callback to return dynamically generated XML for the
> + *   gdb stub. Returns a pointer to the XML contents for the specified XML file
> + *   or NULL if the CPU doesn't have a dynamically generated content for it.
>   * @cpu_exec_enter: Callback for cpu_exec preparation.
>   * @cpu_exec_exit: Callback for cpu_exec cleanup.
>   * @cpu_exec_interrupt: Callback for processing interrupts in cpu_exec.
> @@ -197,7 +200,7 @@ typedef struct CPUClass {
>      const struct VMStateDescription *vmsd;
>      const char *gdb_core_xml_file;
>      gchar * (*gdb_arch_name)(CPUState *cpu);
> -
> +    char *(*gdb_get_dynamic_xml)(CPUState *cpu, char *xmlname, size_t len);

This would be better to return a 'const char *' and for xmlname
to be 'const char *'. Drop the len parameter.

>      void (*cpu_exec_enter)(CPUState *cpu);
>      void (*cpu_exec_exit)(CPUState *cpu);
>      bool (*cpu_exec_interrupt)(CPUState *cpu, int interrupt_request);
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index 1b3ae62..4fdda2f 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -1781,6 +1781,7 @@ static void arm_cpu_class_init(ObjectClass *oc, void *data)
>      cc->gdb_num_core_regs = 26;
>      cc->gdb_core_xml_file = "arm-core.xml";
>      cc->gdb_arch_name = arm_gdb_arch_name;
> +    cc->gdb_get_dynamic_xml = arm_gdb_get_dynamic_xml;
>      cc->gdb_stop_before_watchpoint = true;
>      cc->debug_excp_handler = arm_debug_excp_handler;
>      cc->debug_check_watchpoint = arm_debug_check_watchpoint;
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 818a98a..39b4f3a 100644
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
> @@ -682,6 +695,8 @@ struct ARMCPU {
>      uint64_t *cpreg_vmstate_values;
>      int32_t cpreg_vmstate_array_len;
>
> +    DynamicGDBXMLInfo dyn_xml;
> +
>      /* Timers used by the generic (architected) timer */
>      QEMUTimer *gt_timer[NUM_GTIMERS];
>      /* GPIO outputs for generic timer */
> @@ -846,6 +861,8 @@ hwaddr arm_cpu_get_phys_page_attrs_debug(CPUState *cpu, vaddr addr,
>
>  int arm_cpu_gdb_read_register(CPUState *cpu, uint8_t *buf, int reg);
>  int arm_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
> +int arm_gen_dynamic_xml(CPUState *cpu);
> +char *arm_gdb_get_dynamic_xml(CPUState *cpu, char *xmlname, size_t len);

New function prototypes in header files should have at least a brief
documentation comment, please.

>  int arm_cpu_write_elf64_note(WriteCoreDumpFunction f, CPUState *cs,
>                               int cpuid, void *opaque);
> diff --git a/target/arm/gdbstub.c b/target/arm/gdbstub.c
> index 04c1208..debd873 100644
> --- a/target/arm/gdbstub.c
> +++ b/target/arm/gdbstub.c
> @@ -101,3 +101,74 @@ int arm_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
>      /* Unknown register.  */
>      return 0;
>  }
> +
> +static void arm_gen_one_xml_reg_tag(GString *s, DynamicGDBXMLInfo *dyn_xml,
> +                                    ARMCPRegInfo *ri, uint32_t ri_key,
> +                                    bool is64)
> +{
> +    g_string_append_printf(s, "<reg name=\"%s\"", ri->name);
> +    g_string_append_printf(s, " bitsize=\"%s\"", is64 ? "64" : "32");

If you make the 'bool is64' argument instead be "int bitsize", then you
can have this be (..., "bitsize=\"%d\"", bitsize), and your
callsites are easier to read because it's more obvious they're correct
when they're passing in 32 or 64 rather than 0 or 1 or true or false.

> +    g_string_append_printf(s, " group=\"cp_regs\"/>");
> +    dyn_xml->num_cpregs++;
> +    dyn_xml->cpregs_keys = g_renew(uint32_t, dyn_xml->cpregs_keys,
> +                                   dyn_xml->num_cpregs);

This does a memory reallocation for every register we add to the array,
which is pretty expensive. You have a reasonable upper bound on the
size you need by calling g_hash_table_size() before you start
iterating through it, so just allocate the array that big to start with.

> +    dyn_xml->cpregs_keys[dyn_xml->num_cpregs - 1] = ri_key;
> +}
> +
> +static void arm_register_sysreg_for_xml(gpointer key, gpointer value,
> +                                        gpointer p)
> +{
> +    uint32_t ri_key = *(uint32_t *)key;
> +    ARMCPRegInfo *ri = value;
> +    void **p_array = p;
> +    ARMCPU *cpu = ARM_CPU((CPUState *)(p_array[0]));
> +    CPUARMState *env = &cpu->env;
> +    DynamicGDBXMLInfo *dyn_xml = &cpu->dyn_xml;
> +    GString *s = (GString *)(p_array[1]);
> +
> +    if (!(ri->type & (ARM_CP_NO_RAW | ARM_CP_NO_GDB))) {
> +        if (env->aarch64) {

This is wrong, because env->aarch64 is the current state of the
CPU. You want to check arm_feature(env, ARM_FEATURE_AARCH64),
which tells you whether the CPU is 64-bit or not.

> +            if (ri->state == ARM_CP_STATE_AA64) {
> +                arm_gen_one_xml_reg_tag(s , dyn_xml, ri, ri_key, 1);
> +            }
> +        } else {
> +            if (ri->state == ARM_CP_STATE_AA32) {
> +                if (!arm_feature(env, ARM_FEATURE_EL3) &&
> +                    (ri->secure & ARM_CP_SECSTATE_S)) {
> +                    return;
> +                }
> +                if (ri->type & ARM_CP_64BIT) {
> +                    arm_gen_one_xml_reg_tag(s , dyn_xml, ri, ri_key, 1);
> +                } else {
> +                    arm_gen_one_xml_reg_tag(s , dyn_xml, ri, ri_key, 0);
> +                }
> +            }
> +        }
> +    }
> +}
> +
> +int arm_gen_dynamic_xml(CPUState *cs)
> +{
> +    ARMCPU *cpu = ARM_CPU(cs);
> +    GString *s = g_string_new(NULL);
> +    void *p_array[] = {cs, s};
> +
> +    cpu->dyn_xml.num_cpregs = 0;
> +    g_string_printf(s, "<?xml version=\"1.0\"?>");
> +    g_string_append_printf(s, "<!DOCTYPE target SYSTEM \"gdb-target.dtd\">");
> +    g_string_append_printf(s, "<feature name=\"org.gnu.gdb.sys.regs\">");

What's the process for deciding what the feature name is in a gdb
protocol XML declaration? Are we allowed to claim to be gdb.gnu.org,
or should this be "org.qemu.something"? Should we have something in
here that says "arm" ?

> +    g_hash_table_foreach(cpu->cp_regs, arm_register_sysreg_for_xml, p_array);
> +    g_string_append_printf(s, "</feature>");
> +    cpu->dyn_xml.desc = g_string_free(s, false);
> +    return  cpu->dyn_xml.num_cpregs;

Stray double space after "return".

> +}
> +
> +char *arm_gdb_get_dynamic_xml(CPUState *cs, char *xmlname, size_t len)
> +{
> +    ARMCPU *cpu = ARM_CPU(cs);
> +
> +    if (strncmp(xmlname, "system-registers.xml", len) == 0) {

Just strcmp() will do.

> +        return cpu->dyn_xml.desc;
> +    }
> +    return NULL;
> +}
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 3b31f71..5929e0b 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -219,6 +219,29 @@ static void write_raw_cp_reg(CPUARMState *env, const ARMCPRegInfo *ri,
>      }
>  }
>
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
> +static int arm_gdb_set_sysreg(CPUARMState *env, uint8_t *buf, int reg)
> +{
> +    return 0;
> +}
> +
>  static bool raw_accessors_invalid(const ARMCPRegInfo *ri)
>  {
>     /* Return true if the regdef would cause an assertion if you called
> @@ -5458,6 +5481,7 @@ void arm_cpu_register_gdb_regs_for_features(ARMCPU *cpu)
>  {
>      CPUState *cs = CPU(cpu);
>      CPUARMState *env = &cpu->env;
> +    int n;
>
>      if (arm_feature(env, ARM_FEATURE_AARCH64)) {
>          gdb_register_coprocessor(cs, aarch64_fpu_gdb_get_reg,
> @@ -5473,6 +5497,9 @@ void arm_cpu_register_gdb_regs_for_features(ARMCPU *cpu)
>          gdb_register_coprocessor(cs, vfp_gdb_get_reg, vfp_gdb_set_reg,
>                                   19, "arm-vfp.xml", 0);
>      }
> +    n = arm_gen_dynamic_xml(cs);
> +    gdb_register_coprocessor(cs, arm_gdb_get_sysreg, arm_gdb_set_sysreg,
> +                             n, "system-registers.xml", 0);
>  }
>
>  /* Sort alphabetically by type name, except for "any". */
> --
> 2.7.4


thanks
-- PMM
