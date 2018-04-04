Received: from eggs.gnu.org ([2001:4830:134:3::10]:46302)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f3hVA-00049Z-Vb
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 08:26:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f3hV6-0003Nu-NF
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 08:26:56 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:38801)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1f3hV6-0003N0-CH
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 08:26:52 -0400
Received: by mail-wm0-x242.google.com with SMTP id i3so18211901wmf.3
	for <qemu-devel@nongnu.org>; Wed, 04 Apr 2018 05:26:52 -0700 (PDT)
References: <1521034084-17344-1-git-send-email-abdallah.bouassida@lauterbach.com>
	<1521034084-17344-4-git-send-email-abdallah.bouassida@lauterbach.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <1521034084-17344-4-git-send-email-abdallah.bouassida@lauterbach.com>
Date: Wed, 04 Apr 2018 13:26:49 +0100
Message-ID: <87h8orcg3a.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v5 3/3] target/arm: Add the XML
 dynamic generation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Abdallah Bouassida <abdallah.bouassida@lauterbach.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, khaled.jmal@lauterbach.com, qemu-arm@nongnu.org


Abdallah Bouassida <abdallah.bouassida@lauterbach.com> writes:

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
>  target/arm/cpu.h     | 26 +++++++++++++++++++
>  target/arm/gdbstub.c | 71 ++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  target/arm/helper.c  | 27 ++++++++++++++++++++
>  6 files changed, 139 insertions(+), 1 deletion(-)
>
> diff --git a/gdbstub.c b/gdbstub.c
> index f1d5148..09065bc 100644
> --- a/gdbstub.c
> +++ b/gdbstub.c
> @@ -674,6 +674,16 @@ static const char *get_feature_xml(const char *p, co=
nst char **newp,
>          }
>          return target_xml;
>      }
> +    if (cc->gdb_get_dynamic_xml) {
> +        CPUState *cpu =3D first_cpu;
> +        char *xmlname =3D g_strndup(p, len);
> +        const char *xml =3D cc->gdb_get_dynamic_xml(cpu, xmlname);
> +
> +        free(xmlname);

g_free for a g_strndup'ed string please - although I'm confused as to
why you need to g_strdup the string. You already have p and its not like
gdb_get_dynamic_xml couldn't dup the string if it needed to (which it
doesn't seem to).

> +        if (xml) {
> +            return xml;
> +        }
> +    }
>      for (i =3D 0; ; i++) {
>          name =3D xml_builtin[i][0];
>          if (!name || (strncmp(name, p, len) =3D=3D 0 && strlen(name) =3D=
=3D len))
> diff --git a/include/qom/cpu.h b/include/qom/cpu.h
> index dc6d495..be6d84d 100644
> --- a/include/qom/cpu.h
> +++ b/include/qom/cpu.h
> @@ -132,6 +132,9 @@ struct TranslationBlock;
>   *           before the insn which triggers a watchpoint rather than aft=
er it.
>   * @gdb_arch_name: Optional callback that returns the architecture name =
known
>   * to GDB. The caller must free the returned string with g_free.
> + * @gdb_get_dynamic_xml: Callback to return dynamically generated XML fo=
r the
> + *   gdb stub. Returns a pointer to the XML contents for the specified X=
ML file
> + *   or NULL if the CPU doesn't have a dynamically generated content for=
 it.
>   * @cpu_exec_enter: Callback for cpu_exec preparation.
>   * @cpu_exec_exit: Callback for cpu_exec cleanup.
>   * @cpu_exec_interrupt: Callback for processing interrupts in cpu_exec.
> @@ -198,7 +201,7 @@ typedef struct CPUClass {
>      const struct VMStateDescription *vmsd;
>      const char *gdb_core_xml_file;
>      gchar * (*gdb_arch_name)(CPUState *cpu);
> -
> +    const char *(*gdb_get_dynamic_xml)(CPUState *cpu, const char *xmlnam=
e);
>      void (*cpu_exec_enter)(CPUState *cpu);
>      void (*cpu_exec_exit)(CPUState *cpu);
>      bool (*cpu_exec_interrupt)(CPUState *cpu, int interrupt_request);
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index 022d8c5..38b8b1c 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -1879,6 +1879,7 @@ static void arm_cpu_class_init(ObjectClass *oc, voi=
d *data)
>      cc->gdb_num_core_regs =3D 26;
>      cc->gdb_core_xml_file =3D "arm-core.xml";
>      cc->gdb_arch_name =3D arm_gdb_arch_name;
> +    cc->gdb_get_dynamic_xml =3D arm_gdb_get_dynamic_xml;
>      cc->gdb_stop_before_watchpoint =3D true;
>      cc->debug_excp_handler =3D arm_debug_excp_handler;
>      cc->debug_check_watchpoint =3D arm_debug_check_watchpoint;
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 5a6ea24..5664f58 100644
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
> @@ -863,6 +878,17 @@ hwaddr arm_cpu_get_phys_page_attrs_debug(CPUState *c=
pu, vaddr addr,
>  int arm_cpu_gdb_read_register(CPUState *cpu, uint8_t *buf, int reg);
>  int arm_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
>
> +/* Dynamically generates for gdb stub an XML description of the sysregs =
from
> + * the cp_regs hashtable. Returns the registered sysregs number.
> + */
> +int arm_gen_dynamic_xml(CPUState *cpu);
> +
> +/* Returns the dynamically generated XML for the gdb stub.
> + * Returns a pointer to the XML contents for the specified XML file or N=
ULL
> + * if the XML name doesn't match the predefined one.
> + */
> +const char *arm_gdb_get_dynamic_xml(CPUState *cpu, const char *xmlname);
> +
>  int arm_cpu_write_elf64_note(WriteCoreDumpFunction f, CPUState *cs,
>                               int cpuid, void *opaque);
>  int arm_cpu_write_elf32_note(WriteCoreDumpFunction f, CPUState *cs,
> diff --git a/target/arm/gdbstub.c b/target/arm/gdbstub.c
> index 04c1208..fafc08b 100644
> --- a/target/arm/gdbstub.c
> +++ b/target/arm/gdbstub.c
> @@ -101,3 +101,74 @@ int arm_cpu_gdb_write_register(CPUState *cs, uint8_t=
 *mem_buf, int n)
>      /* Unknown register.  */
>      return 0;
>  }
> +
> +static void arm_gen_one_xml_reg_tag(GString *s, DynamicGDBXMLInfo *dyn_x=
ml,
> +                                    ARMCPRegInfo *ri, uint32_t ri_key,
> +                                    int bitsize)
> +{
> +    g_string_append_printf(s, "<reg name=3D\"%s\"", ri->name);
> +    g_string_append_printf(s, " bitsize=3D\"%d\"", bitsize);
> +    g_string_append_printf(s, " group=3D\"cp_regs\"/>");
> +    dyn_xml->num_cpregs++;
> +    dyn_xml->cpregs_keys[dyn_xml->num_cpregs - 1] =3D ri_key;
> +}
> +
> +static void arm_register_sysreg_for_xml(gpointer key, gpointer value,
> +                                        gpointer p)
> +{
> +    uint32_t ri_key =3D *(uint32_t *)key;
> +    ARMCPRegInfo *ri =3D value;
> +    void **p_array =3D p;
> +    ARMCPU *cpu =3D ARM_CPU((CPUState *)(p_array[0]));

This comes across as a little clumsy compared to casting p to a
structure that contains the correctly typed parameters.

> +    CPUARMState *env =3D &cpu->env;
> +    DynamicGDBXMLInfo *dyn_xml =3D &cpu->dyn_xml;
> +    GString *s =3D (GString *)(p_array[1]);
> +
> +    if (!(ri->type & (ARM_CP_NO_RAW | ARM_CP_NO_GDB))) {
> +        if (arm_feature(env, ARM_FEATURE_AARCH64)) {
> +            if (ri->state =3D=3D ARM_CP_STATE_AA64) {
> +                arm_gen_one_xml_reg_tag(s , dyn_xml, ri, ri_key, 64);
> +            }
> +        } else {
> +            if (ri->state =3D=3D ARM_CP_STATE_AA32) {
> +                if (!arm_feature(env, ARM_FEATURE_EL3) &&
> +                    (ri->secure & ARM_CP_SECSTATE_S)) {
> +                    return;
> +                }
> +                if (ri->type & ARM_CP_64BIT) {
> +                    arm_gen_one_xml_reg_tag(s , dyn_xml, ri, ri_key, 64);
> +                } else {
> +                    arm_gen_one_xml_reg_tag(s , dyn_xml, ri, ri_key, 32);
> +                }
> +            }
> +        }
> +    }
> +}
> +
> +int arm_gen_dynamic_xml(CPUState *cs)
> +{
> +    ARMCPU *cpu =3D ARM_CPU(cs);
> +    GString *s =3D g_string_new(NULL);
> +    void *p_array[] =3D {cs, s};
> +
> +    cpu->dyn_xml.num_cpregs =3D 0;
> +    cpu->dyn_xml.cpregs_keys =3D g_malloc(sizeof(uint32_t *) *
> +                                        g_hash_table_size(cpu->cp_regs));
> +    g_string_printf(s, "<?xml version=3D\"1.0\"?>");
> +    g_string_append_printf(s, "<!DOCTYPE target SYSTEM \"gdb-target.dtd\=
">");
> +    g_string_append_printf(s, "<feature name=3D\"org.qemu.gdb.arm.sys.re=
gs\">");
> +    g_hash_table_foreach(cpu->cp_regs, arm_register_sysreg_for_xml, p_ar=
ray);
> +    g_string_append_printf(s, "</feature>");
> +    cpu->dyn_xml.desc =3D g_string_free(s, false);
> +    return cpu->dyn_xml.num_cpregs;
> +}
> +
> +const char *arm_gdb_get_dynamic_xml(CPUState *cs, const char *xmlname)
> +{
> +    ARMCPU *cpu =3D ARM_CPU(cs);
> +
> +    if (strcmp(xmlname, "system-registers.xml") =3D=3D 0) {
> +        return cpu->dyn_xml.desc;
> +    }
> +    return NULL;
> +}
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 1360a14..d3c40b7 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -220,6 +220,29 @@ static void write_raw_cp_reg(CPUARMState *env, const=
 ARMCPRegInfo *ri,
>      }
>  }
>
> +static int arm_gdb_get_sysreg(CPUARMState *env, uint8_t *buf, int reg)
> +{
> +    ARMCPU *cpu =3D arm_env_get_cpu(env);
> +    const ARMCPRegInfo *ri;
> +    uint32_t key;
> +
> +    key =3D cpu->dyn_xml.cpregs_keys[reg];
> +    ri =3D get_arm_cp_reginfo(cpu->cp_regs, key);
> +    if (ri) {
> +        if (cpreg_field_is_64bit(ri)) {
> +            return gdb_get_reg64(buf, (uint64_t)read_raw_cp_reg(env, ri)=
);
> +        } else {
> +            return gdb_get_reg32(buf, (uint32_t)read_raw_cp_reg(env, ri)=
);
> +        }
> +    }
> +    return 0;

There is something odd going on here because if I run a simple little
features binary
(https://github.com/stsquad/testcases/blob/master/aarch64/features.c) I
get:

  ID_AA64ISAR0_EL1    : 0x0000000000011120
  ID_AA64ISAR1_EL1    : 0x0000000000000000
  ID_AA64MMFR0_EL1    : 0x00000000ff000000
  ID_AA64MMFR1_EL1    : 0x0000000000000000
  ID_AA64PFR0_EL1     : 0x0000000000000011
  ID_AA64PFR1_EL1     : 0x0000000000000000
  ID_AA64DFR0_EL1     : 0x0000000000000006
  ID_AA64DFR1_EL1     : 0x0000000000000000
  MIDR_EL1            : 0x00000000411fd070
  MPIDR_EL1           : 0x0000000080000000
  REVIDR_EL1          : 0x0000000000000000

However in the gdb output we see:

  ID_AA64ISAR0_EL1           0x11120	69920
  ID_AA64ISAR1_EL1           0x0	0
  ID_AA64MMFR0_EL1           0x1124	4388  <-?
  ID_AA64MMFR1_EL1           0x0	0
  ID_PFR0                    0x131	305   <-name and value?
  ID_AA64PFR1_EL1            0x0	0
  ID_AA64DFR0_EL1            0x10305106	271601926 <-?
  ID_AA64DFR1_EL1            0x0	0
  REVIDR_EL1                 0x0	0

So why the discrepancies?

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
> @@ -5459,6 +5482,7 @@ void arm_cpu_register_gdb_regs_for_features(ARMCPU =
*cpu)
>  {
>      CPUState *cs =3D CPU(cpu);
>      CPUARMState *env =3D &cpu->env;
> +    int n;
>
>      if (arm_feature(env, ARM_FEATURE_AARCH64)) {
>          gdb_register_coprocessor(cs, aarch64_fpu_gdb_get_reg,
> @@ -5474,6 +5498,9 @@ void arm_cpu_register_gdb_regs_for_features(ARMCPU =
*cpu)
>          gdb_register_coprocessor(cs, vfp_gdb_get_reg, vfp_gdb_set_reg,
>                                   19, "arm-vfp.xml", 0);
>      }
> +    n =3D arm_gen_dynamic_xml(cs);
> +    gdb_register_coprocessor(cs, arm_gdb_get_sysreg, arm_gdb_set_sysreg,
> +                             n, "system-registers.xml", 0);

You could call arm_gen_dynamic_xml() direct when calling the register funct=
ion
to save the intermediate n.

>  }
>
>  /* Sort alphabetically by type name, except for "any". */


--
Alex Benn=C3=A9e
