Received: from eggs.gnu.org ([2001:4830:134:3::10]:32800)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <abdallah.bouassida@lauterbach.com>)
	id 1eiy7g-0004fI-A0
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 02:57:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <abdallah.bouassida@lauterbach.com>)
	id 1eiy7b-0005HY-Q4
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 02:57:00 -0500
Received: from smtp1.lauterbach.com ([62.154.241.196]:51423)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <abdallah.bouassida@lauterbach.com>)
	id 1eiy7b-0005Ck-AL
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 02:56:55 -0500
Received: from unknown (HELO [192.168.187.23])
	(Authenticated_SSL:abouassida@[41.224.44.126])
	(envelope-sender <abdallah.bouassida@lauterbach.com>)
	by smtp1.lauterbach.com (qmail-ldap-1.03) with
	ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
	for <qemu-devel@nongnu.org>; 6 Feb 2018 07:56:35 -0000
From: Abdallah Bouassida <abdallah.bouassida@lauterbach.com>
References: <d23a2730-a103-6336-0658-e12fa9b0193f@lauterbach.com>
Message-ID: <54f41a72-7b70-e5a6-d65f-ccce8a93f948@lauterbach.com>
Date: Tue, 6 Feb 2018 08:56:36 +0100
MIME-Version: 1.0
In-Reply-To: <d23a2730-a103-6336-0658-e12fa9b0193f@lauterbach.com>
Content-Language: en-US
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] ping Re: [PATCH V2] target-arm:Add a dynamic
 XML-description of the cp-registers to GDB
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm <qemu-arm@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>
Cc: Khaled Jmal <khaled.jmal@lauterbach.com>, QEMU Developers <qemu-devel@nongnu.org>

ping
http://patchwork.ozlabs.org/patch/867467/


> [PATCH V2] target-arm:Add a dynamic XML-description of the 
> cp-registers to GDB
>
> This patch offers to GDB the ability to read/write all the coprocessor
> registers for ARM and ARM64 by generating dynamically an 
> XML-description for
> these registers.
>
> Signed-off-by: Abdallah Bouassida <abdallah.bouassida@lauterbach.com>
> ---
>
> Hello Peter,
>
> Thanks for reviewing the previous version of this patch!
> http://patchwork.ozlabs.org/patch/861374/
>>> *For the ARM64, should I differentiate the registers that have two views (32
>>> and 64)
>>> Maybe by adding in the XML description a "32" tag for the registers name for
>>> the
>>> 32bit view and a "64" for the 64bit view.
>>> *How to properly handle the secure and the non secure views?
>> I think it might be useful to approach it from the other end -- what
>> are we trying to achieve?
>>
>> For 32 vs 64 bit, it depends on what interface we're showing to the
>> debugger. If we're saying "this is a 64 bit CPU" then we should just
>> present the 64-bit sysregs, in the same way we only present the 64-bit
>> GPRs. If a 32-bit CPU, present the coprocessor regs only. (It's not
>> currently possible to have gdb switch between 32 and 64 bit views
>> as a 64-bit CPU changes from aarch32 to aarch64, though upstream gdb
>> are working on it.)
>>
>> For secure vs non-secure, follow how the architecture does it:
>>   * for a 64-bit CPU, there are no banked sysregs like this, so you
>>     just expose 1 register
>>   * for a 32-bit CPU, maybe banked registers should be exposed as 2 registers
>>
>> ...but this depends on what you're trying to do, and whether there's
>> existing practice in for instance how JTAG debugging presents these
>> sysregs to gdb.
> So, in this new patch I have did the following:
> - If the CPU is on the AARCH64 state (when connecting to GDB stub), I 
> only take the 64bit
> view of cpregs.
> - If we are on the AARCH32, I only take the 32bit view of cpregs and 
> in the XML description
> I add the tag "_S" to the cpreg's name if it is the secure view of 
> that register.
>> I'm pretty hesitant about allowing the user to modify system registers
>> in the debugger, that is unlikely to work in quite a lot of cases.
>> I'd rather we just made these registers all readonly.
> Some of our customers need to connect to Qemu using our tool TRACE32® 
> via GDB,
> and for some use case they need to have write access to some 
> particular cpregs.
> So, it will be nice to have this capability!
> Usually, a user won't modify these registers unless he knows what he 
> is doing!
>
>> What does the UI in gdb look like? What gdb commands display
>> the list of and values of system registers now? (Are there any
>> commands that used to be useful and are now swamped by lists of
>> hundreds of system registers?)
> To read a given register:
>    (gdb)  print/x $<cpreg_name>
> To write on a given register
>    (gdb) set $<cpreg_name>=<value>
> To get the list of all registers:
>    (gdb) info registers all
>     with this command the user get all the registers including the 
> cpregs that has been
>     described dynamically.
>     This command shows the registers page by page (depending on the 
> terminal window size)
>     and the cpregs goes at the end of the list so if user is really 
> interested on these cpregs he
>     should continue to read the register list or he simply type "q" to 
> quit.
>
> In the previous patch, the command "info registers" (without the 
> option "all") was swamped
> by the new big list. So, I fixed that by assigning these registers (in 
> the XML ) to a special
> group (group="cp_regs") and with that the cpregs won't appear with 
> this command.
>
> Otherwise, I don't think that there is another GDB command that could 
> be affected by
> this patch.
>> Don't we run into problems where this XML exceeds our gdbstub
>> MAX_PACKET_LENGTH (which is only 4K) ?
>>
>> This is a pre-existing bug (https://bugs.launchpad.net/qemu/+bug/1703147)
>> but I would expect that if we start autogenerating xml for all the
>> coprocessor registers we're going to hit the packet limit pretty
>> quickly.
> No, indeed I don't think that 
> (https://bugs.launchpad.net/qemu/+bug/1703147)
> is a bug!
> However, when the gdb request to get an XML description, it sends the 
> packet:
> qXfer:features:read:<xml_name>:<offset>,<length>
> for the first packet, the offset=0 and the length in our case is 0xFFB
> (= MAX_PACKET_LENGTH - 5)
>
> When the GDB stub gets this packet, it will send the corresponding XML 
> description and:
> - if the size of the XML is bigger than the length requested by qXfer, 
> GDB stub will
> add 'm' at the beginning of the response to inform GDB  that there is 
> still more data to be sent.
> - else, it will add 'l' which mean there is no more data.
>
>     if (len < total_len - addr) {
>         buf[0] = 'm';
>         len = memtox(buf + 1, xml + addr, len);
>     } else {
>         buf[0] = 'l';
>         len = memtox(buf + 1, xml + addr, total_len - addr);
>     }
>
> When GBD gets an answer with the header "m" it will send another qXfer 
> and this time
> the <offset> will be equal to (old_offset + the size of the data read 
> previously)
>
> With this, the XML description won't be truncated even if it is longer 
> than 2045.
>>>   /**
>>> + * XMLDynamicDescription:
>>> + * @desc: Contains the XML descriptions.
>>> + * @num_cpregs: Number of the Coprocessor registers seen by GDB.
>>> + * @xml_cpregs_ordred_keys: Array that contains the corresponding Key of
>>> + * a given cpreg with the same order of the cpreg in the XML description.
>>> + */
>>> +typedef struct XMLDynamicDescription {
>>> +    char * desc;
>>> +    int num_cpregs;
>>> +    uint32_t *xml_cpregs_ordred_keys;
>>> +} XMLDynamicDescription;
>> cpregs are an arm-specific concept so this data structure doesn't
>> belong in the for-all-cpus header.
> I moved this to /target/arm/cpu.h .
>>> +    char * (*get_feature_xml_dynamically)(CPUState *cpu);
>>> +    int (*gdb_read_cpregister)(CPUState *cpu, uint8_t *buf, int reg);
>>> +    int (*gdb_write_cpregister)(CPUState *cpu, uint8_t *buf, int reg);
>> Do we really need a new set of functions rather than just being
>> able to use the existing gdb_read_register/gdb_write_register ?
>> The API seems to be the same, so I was expecting to just have
>> the same functions be called, with the register number distinguishing
>> the existing regs from the new coprocessor ones.
> I'm using now the gdb_read_register/gdb_write_register instead.
>
> Best regards,
> Abdallah
>
>  gdbstub.c              | 18 +++++++++++
>  include/qom/cpu.h      |  3 ++
>  target/arm/cpu.c       |  3 ++
>  target/arm/cpu.h       | 18 +++++++++++
>  target/arm/gdbstub.c   | 87 
> ++++++++++++++++++++++++++++++++++++++++++++++++++
>  target/arm/gdbstub64.c | 25 +++++++++++++++
>  target/arm/helper.c    |  3 +-
>  7 files changed, 155 insertions(+), 2 deletions(-)
>
> diff --git a/gdbstub.c b/gdbstub.c
> index f1d5148..f54053f 100644
> --- a/gdbstub.c
> +++ b/gdbstub.c
> @@ -670,10 +670,20 @@ static const char *get_feature_xml(const char 
> *p, const char **newp,
>                  pstrcat(target_xml, sizeof(target_xml), r->xml);
>                  pstrcat(target_xml, sizeof(target_xml), "\"/>");
>              }
> +            if (cc->has_dynamic_xml) {
> +                cc->gen_dynamic_xml(cpu);
> +                pstrcat(target_xml, sizeof(target_xml), "<xi:include 
> href=\"");
> +                pstrcat(target_xml, sizeof(target_xml), 
> "dynamic_desc.xml");
> +                pstrcat(target_xml, sizeof(target_xml), "\"/>");
> +            }
>              pstrcat(target_xml, sizeof(target_xml), "</target>");
>          }
>          return target_xml;
>      }
> +    if (strncmp(p, "dynamic_desc.xml", len) == 0) {
> +        CPUState *cpu = first_cpu;
> +        return cc->get_dynamic_xml(cpu);
> +    }
>      for (i = 0; ; i++) {
>          name = xml_builtin[i][0];
>          if (!name || (strncmp(name, p, len) == 0 && strlen(name) == len))
> @@ -697,6 +707,10 @@ static int gdb_read_register(CPUState *cpu, 
> uint8_t *mem_buf, int reg)
>              return r->get_reg(env, mem_buf, reg - r->base_reg);
>          }
>      }
> +
> +    if (cc->has_dynamic_xml) {
> +        return cc->gdb_read_register(cpu, mem_buf, reg);
> +    }
>      return 0;
>  }
>
> @@ -715,6 +729,10 @@ static int gdb_write_register(CPUState *cpu, 
> uint8_t *mem_buf, int reg)
>              return r->set_reg(env, mem_buf, reg - r->base_reg);
>          }
>      }
> +
> +    if (cc->has_dynamic_xml) {
> +        return cc->gdb_write_register(cpu, mem_buf, reg);
> +    }
>      return 0;
>  }
>
> diff --git a/include/qom/cpu.h b/include/qom/cpu.h
> index 93bd546..a3105c0 100644
> --- a/include/qom/cpu.h
> +++ b/include/qom/cpu.h
> @@ -197,6 +197,9 @@ typedef struct CPUClass {
>      const struct VMStateDescription *vmsd;
>      const char *gdb_core_xml_file;
>      gchar * (*gdb_arch_name)(CPUState *cpu);
> +    bool has_dynamic_xml;
> +    void (*gen_dynamic_xml)(CPUState *cpu);
> +    char *(*get_dynamic_xml)(CPUState *cpu);
>
>      void (*cpu_exec_enter)(CPUState *cpu);
>      void (*cpu_exec_exit)(CPUState *cpu);
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index cc1856c..410e250 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -1752,6 +1752,9 @@ static void arm_cpu_class_init(ObjectClass *oc, 
> void *data)
>      cc->gdb_num_core_regs = 26;
>      cc->gdb_core_xml_file = "arm-core.xml";
>      cc->gdb_arch_name = arm_gdb_arch_name;
> +    cc->has_dynamic_xml = true;
> +    cc->gen_dynamic_xml = arm_gen_dynamic_xml;
> +    cc->get_dynamic_xml = arm_get_dynamic_xml;
>      cc->gdb_stop_before_watchpoint = true;
>      cc->debug_excp_handler = arm_debug_excp_handler;
>      cc->debug_check_watchpoint = arm_debug_check_watchpoint;
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 9631670..bcb567b 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -135,6 +135,19 @@ enum {
>     s<2n+1> maps to the most significant half of d<n>
>   */
>
> +/**
> + * XMLDynamicDescription:
> + * @desc: Contains the XML descriptions.
> + * @num_cpregs: Number of the Coprocessor registers seen by GDB.
> + * @cpregs_keys: Array that contains the corresponding Key of
> + * a given cpreg with the same order of the cpreg in the XML description.
> + */
> +typedef struct XMLDynamicDescription {
> +    char *desc;
> +    int num_cpregs;
> +    uint32_t *cpregs_keys;
> +} XMLDynamicDescription;
> +
>  /* CPU state for each instance of a generic timer (in cp15 c14) */
>  typedef struct ARMGenericTimer {
>      uint64_t cval; /* Timer CompareValue register */
> @@ -633,6 +646,8 @@ struct ARMCPU {
>      uint64_t *cpreg_vmstate_values;
>      int32_t cpreg_vmstate_array_len;
>
> +    XMLDynamicDescription dyn_xml;
> +
>      /* Timers used by the generic (architected) timer */
>      QEMUTimer *gt_timer[NUM_GTIMERS];
>      /* GPIO outputs for generic timer */
> @@ -797,6 +812,8 @@ hwaddr arm_cpu_get_phys_page_attrs_debug(CPUState 
> *cpu, vaddr addr,
>
>  int arm_cpu_gdb_read_register(CPUState *cpu, uint8_t *buf, int reg);
>  int arm_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
> +void arm_gen_dynamic_xml(CPUState *cpu);
> +char *arm_get_dynamic_xml(CPUState *cpu);
>
>  int arm_cpu_write_elf64_note(WriteCoreDumpFunction f, CPUState *cs,
>                               int cpuid, void *opaque);
> @@ -2005,6 +2022,7 @@ static inline bool cp_access_ok(int current_el,
>
>  /* Raw read of a coprocessor register (as needed for migration, etc) */
>  uint64_t read_raw_cp_reg(CPUARMState *env, const ARMCPRegInfo *ri);
> +void write_raw_cp_reg(CPUARMState *env, const ARMCPRegInfo *ri, 
> uint64_t v);
>
>  /**
>   * write_list_to_cpustate
> diff --git a/target/arm/gdbstub.c b/target/arm/gdbstub.c
> index 04c1208..7cffe87 100644
> --- a/target/arm/gdbstub.c
> +++ b/target/arm/gdbstub.c
> @@ -56,6 +56,17 @@ int arm_cpu_gdb_read_register(CPUState *cs, uint8_t 
> *mem_buf, int n)
>          /* CPSR */
>          return gdb_get_reg32(mem_buf, cpsr_read(env));
>      }
> +    if (n >= cs->gdb_num_regs &&
> +        n < cs->gdb_num_regs + cpu->dyn_xml.num_cpregs) {
> +        const ARMCPRegInfo *ri;
> +        uint32_t key;
> +
> +        key = cpu->dyn_xml.cpregs_keys[n - cs->gdb_num_regs];
> +        ri = get_arm_cp_reginfo(arm_env_get_cpu(env)->cp_regs, key);
> +        if (ri) {
> +            return gdb_get_reg32(mem_buf, 
> (uint32_t)read_raw_cp_reg(env, ri));
> +        }
> +    }
>      /* Unknown register.  */
>      return 0;
>  }
> @@ -98,6 +109,82 @@ int arm_cpu_gdb_write_register(CPUState *cs, 
> uint8_t *mem_buf, int n)
>          cpsr_write(env, tmp, 0xffffffff, CPSRWriteByGDBStub);
>          return 4;
>      }
> +    if (n >= cs->gdb_num_regs &&
> +        n < cs->gdb_num_regs + cpu->dyn_xml.num_cpregs) {
> +        const ARMCPRegInfo *ri;
> +        uint32_t key;
> +
> +        key = cpu->dyn_xml.cpregs_keys[n - cs->gdb_num_regs];
> +        ri = get_arm_cp_reginfo(arm_env_get_cpu(env)->cp_regs, key);
> +        if (ri) {
> +            if (!(ri->type & ARM_CP_CONST)) {
> +                write_raw_cp_reg(env, ri, tmp);
> +                return 4;
> +            }
> +        }
> +    }
>      /* Unknown register.  */
>      return 0;
>  }
> +
> +static void arm_gen_xml_reg(gpointer key, gpointer value, gpointer cs)
> +{
> +    ARMCPU *cpu = ARM_CPU(cs);
> +    XMLDynamicDescription *dyn_xml = &cpu->dyn_xml;
> +    ARMCPRegInfo *ri = value;
> +    uint32_t ri_key = *(uint32_t *)key;
> +    CPUARMState *env = &cpu->env;
> +    char **target_xml = (char **)&(dyn_xml->desc);
> +    char *tmp_xml = *target_xml;
> +
> +    if (!(ri->type & (ARM_CP_NO_RAW | ARM_CP_ALIAS))) {
> +        if (env->aarch64) {
> +            if (cpreg_field_is_64bit(ri)) {
> +                *target_xml = g_strconcat(*target_xml,
> +                                        "<reg name=\"", ri->name, "\" ",
> +                                        "bitsize=\"64\" 
> group=\"cp_regs\"/>",
> +                                        NULL);
> +            } else {
> +                return;
> +            }
> +        } else {
> +            if (ri->secure & ARM_CP_SECSTATE_S) {
> +                *target_xml = g_strconcat(*target_xml,
> +                                          "<reg name=\"", ri->name, 
> "_S\" ",
> +                                          "bitsize=\"32\" 
> group=\"cp_regs\"/>",
> +                                          NULL);
> +            } else {
> +                *target_xml = g_strconcat(*target_xml,
> +                                          "<reg name=\"", ri->name, 
> "\" ",
> +                                          "bitsize=\"32\" 
> group=\"cp_regs\"/>",
> +                                          NULL);
> +            }
> +        }
> +        g_free(tmp_xml);
> +        dyn_xml->num_cpregs++;
> +        dyn_xml->cpregs_keys = g_renew(uint32_t,
> +                                       dyn_xml->cpregs_keys,
> +                                       dyn_xml->num_cpregs);
> +        dyn_xml->cpregs_keys[dyn_xml->num_cpregs - 1] = ri_key;
> +    }
> +}
> +
> +void arm_gen_dynamic_xml(CPUState *cs)
> +{
> +    ARMCPU *cpu = ARM_CPU(cs);
> +
> +    cpu->dyn_xml.num_cpregs = 0;
> +    cpu->dyn_xml.desc = g_strconcat("<?xml version=\"1.0\"?>",
> +                                 "<!DOCTYPE target SYSTEM 
> \"gdb-target.dtd\">",
> +                                   "<feature 
> name=\"org.gnu.gdb.dynamic.cp\">",
> +                                   NULL);
> +    g_hash_table_foreach(cpu->cp_regs, arm_gen_xml_reg, cs);
> +    cpu->dyn_xml.desc = g_strconcat(cpu->dyn_xml.desc, "</feature>", 
> NULL);
> +}
> +
> +char *arm_get_dynamic_xml(CPUState *cs)
> +{
> +    ARMCPU *cpu = ARM_CPU(cs);
> +
> +    return cpu->dyn_xml.desc;
> +}
> diff --git a/target/arm/gdbstub64.c b/target/arm/gdbstub64.c
> index 49bc3fc..6cf302f 100644
> --- a/target/arm/gdbstub64.c
> +++ b/target/arm/gdbstub64.c
> @@ -38,6 +38,17 @@ int aarch64_cpu_gdb_read_register(CPUState *cs, 
> uint8_t *mem_buf, int n)
>      case 33:
>          return gdb_get_reg32(mem_buf, pstate_read(env));
>      }
> +    if (n >= cs->gdb_num_regs &&
> +        n < cs->gdb_num_regs + cpu->dyn_xml.num_cpregs) {
> +        const ARMCPRegInfo *ri;
> +        uint32_t key;
> +
> +        key = cpu->dyn_xml.cpregs_keys[n - cs->gdb_num_regs];
> +        ri = get_arm_cp_reginfo(arm_env_get_cpu(env)->cp_regs, key);
> +        if (ri) {
> +            return gdb_get_reg64(mem_buf, 
> (uint64_t)read_raw_cp_reg(env, ri));
> +        }
> +    }
>      /* Unknown register.  */
>      return 0;
>  }
> @@ -67,6 +78,20 @@ int aarch64_cpu_gdb_write_register(CPUState *cs, 
> uint8_t *mem_buf, int n)
>          pstate_write(env, tmp);
>          return 4;
>      }
> +    if (n >= cs->gdb_num_regs &&
> +        n < cs->gdb_num_regs + cpu->dyn_xml.num_cpregs) {
> +        const ARMCPRegInfo *ri;
> +        uint32_t key;
> +
> +        key = cpu->dyn_xml.cpregs_keys[n - cs->gdb_num_regs];
> +        ri = get_arm_cp_reginfo(arm_env_get_cpu(env)->cp_regs, key);
> +        if (ri) {
> +            if (!(ri->type & ARM_CP_CONST)) {
> +                write_raw_cp_reg(env, ri, tmp);
> +                return 8;
> +            }
> +        }
> +    }
>      /* Unknown register.  */
>      return 0;
>  }
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index c83c901..223372f 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -191,8 +191,7 @@ uint64_t read_raw_cp_reg(CPUARMState *env, const 
> ARMCPRegInfo *ri)
>      }
>  }
>
> -static void write_raw_cp_reg(CPUARMState *env, const ARMCPRegInfo *ri,
> -                             uint64_t v)
> +void write_raw_cp_reg(CPUARMState *env, const ARMCPRegInfo *ri, 
> uint64_t v)
>  {
>      /* Raw write of a coprocessor register (as needed for migration, 
> etc).
>       * Note that constant registers are treated as write-ignored; the
> -- 
> 1.9.1
