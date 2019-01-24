Received: from eggs.gnu.org ([209.51.188.92]:56354)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1gmYqI-0008RM-BE
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 01:50:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1gmYb0-0005yg-Gy
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 01:34:39 -0500
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:36311)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1gmYaz-0005eB-CR
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 01:34:38 -0500
Received: by mail-pf1-x442.google.com with SMTP id b85so2515880pfc.3
	for <qemu-devel@nongnu.org>; Wed, 23 Jan 2019 22:34:33 -0800 (PST)
References: <20190122170112.8706-1-farosas@linux.ibm.com>
	<20190122170112.8706-2-farosas@linux.ibm.com>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <ffad50f7-0791-a574-e569-f96565cea1c3@ozlabs.ru>
Date: Thu, 24 Jan 2019 17:34:26 +1100
MIME-Version: 1.0
In-Reply-To: <20190122170112.8706-2-farosas@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v4 1/3] target/ppc: Add SPRs XML generation
 code for gdbstub
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fabiano Rosas <farosas@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, groug@kaod.org, david@gibson.dropbear.id.au



On 23/01/2019 04:01, Fabiano Rosas wrote:
> A following patch will add support for handling the Special Purpose
> Registers (SPR) in GDB via gdbstub. For that purpose, GDB needs to be
> provided with an XML description of the registers (see gdb-xml
> directory).
> 
> This patch adds the code that generates the XML dynamically based on
> the SPRs already defined in the machine. This eliminates the need for
> several XML files to match each possible ppc machine.
>
> A "group" is defined so that the GDB command `info registers spr` can
> be used.
> 
> Signed-off-by: Fabiano Rosas <farosas@linux.ibm.com>
> ---
>  target/ppc/cpu-qom.h            |  4 +++
>  target/ppc/cpu.h                |  5 +++
>  target/ppc/gdbstub.c            | 60 +++++++++++++++++++++++++++++++++
>  target/ppc/translate_init.inc.c |  4 +++
>  4 files changed, 73 insertions(+)
> 
> diff --git a/target/ppc/cpu-qom.h b/target/ppc/cpu-qom.h
> index 4ea67692e2..3130802304 100644
> --- a/target/ppc/cpu-qom.h
> +++ b/target/ppc/cpu-qom.h
> @@ -179,6 +179,10 @@ typedef struct PowerPCCPUClass {
>      uint32_t flags;
>      int bfd_mach;
>      uint32_t l1_dcache_size, l1_icache_size;
> +#ifndef CONFIG_USER_ONLY
> +    unsigned int gdb_num_sprs;
> +    const char *gdb_spr_xml;
> +#endif
>      const PPCHash64Options *hash64_opts;
>      struct ppc_radix_page_info *radix_page_info;
>      void (*init_proc)(CPUPPCState *env);
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index a62ff60414..850c5ba278 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -230,6 +230,7 @@ struct ppc_spr_t {
>      void (*oea_write)(DisasContext *ctx, int spr_num, int gpr_num);
>      void (*hea_read)(DisasContext *ctx, int gpr_num, int spr_num);
>      void (*hea_write)(DisasContext *ctx, int spr_num, int gpr_num);
> +    unsigned int gdb_id;
>  #endif
>      const char *name;
>      target_ulong default_value;
> @@ -1268,6 +1269,10 @@ int ppc_cpu_gdb_read_register(CPUState *cpu, uint8_t *buf, int reg);
>  int ppc_cpu_gdb_read_register_apple(CPUState *cpu, uint8_t *buf, int reg);
>  int ppc_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
>  int ppc_cpu_gdb_write_register_apple(CPUState *cpu, uint8_t *buf, int reg);
> +#ifndef CONFIG_USER_ONLY
> +void ppc_gdb_gen_spr_xml(PowerPCCPU *cpu);
> +const char *ppc_gdb_get_dynamic_xml(CPUState *cs, const char *xml_name);
> +#endif
>  int ppc64_cpu_write_elf64_note(WriteCoreDumpFunction f, CPUState *cs,
>                                 int cpuid, void *opaque);
>  int ppc32_cpu_write_elf32_note(WriteCoreDumpFunction f, CPUState *cs,
> diff --git a/target/ppc/gdbstub.c b/target/ppc/gdbstub.c
> index 19565b584d..b2bb765506 100644
> --- a/target/ppc/gdbstub.c
> +++ b/target/ppc/gdbstub.c
> @@ -319,3 +319,63 @@ int ppc_cpu_gdb_write_register_apple(CPUState *cs, uint8_t *mem_buf, int n)
>      }
>      return r;
>  }
> +
> +#ifndef CONFIG_USER_ONLY
> +void ppc_gdb_gen_spr_xml(PowerPCCPU *cpu)
> +{
> +    PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cpu);
> +    CPUPPCState *env = &cpu->env;
> +    GString *s;
> +    unsigned int num_regs;
> +    int i;
> +
> +    if (pcc->gdb_spr_xml) {
> +        return;
> +    }
> +
> +    s = g_string_new(NULL);
> +    g_string_printf(s, "<?xml version=\"1.0\"?>");
> +    g_string_append_printf(s, "<!DOCTYPE target SYSTEM \"gdb-target.dtd\">");
> +    g_string_append_printf(s, "<feature name=\"org.qemu.power.spr\">");


nit: most of g_string_append_printf() in this patch can easily be
g_string_append().


> +
> +    for (i = 0; i < ARRAY_SIZE(env->spr_cb); i++) {
> +        ppc_spr_t *spr = &env->spr_cb[i];
> +
> +        if (!spr->name) {
> +            continue;
> +        }
> +
> +        g_string_append_printf(s, "<reg name=\"%s\"",
> +                               g_ascii_strdown(spr->name, -1));

This leaks memory as g_ascii_strdown() returns a newly-allocated string:
https://developer.gnome.org/glib/stable/glib-String-Utility-Functions.html#g-ascii-strdown


> +        g_string_append_printf(s, " bitsize=\"%d\"", TARGET_LONG_BITS);
> +        g_string_append_printf(s, " group=\"spr\"/>");
> +
> +        /*
> +         * GDB identifies registers based on the order they are
> +         * presented in the XML. These ids will not match QEMU's
> +         * representation (which follows the PowerISA).
> +         *
> +         * Store the position of the current register description so
> +         * we can make the correspondence later.
> +         */
> +        spr->gdb_id = num_regs;
> +        num_regs++;



/home/aik/p/qemu/target/ppc/gdbstub.c: In function ‘ppc_gdb_gen_spr_xml’:
/home/aik/p/qemu/target/ppc/gdbstub.c:362:17: warning: ‘num_regs’ may be
used uninitialized in this function [-Wmaybe-uninitialized]
         num_regs++;
                 ^

as num_regs is uninitialized indeed.


> +    }
> +
> +    g_string_append_printf(s, "</feature>");
> +
> +    pcc->gdb_num_sprs = num_regs;
> +    pcc->gdb_spr_xml = g_string_free(s, false);
> +}
> +
> +const char *ppc_gdb_get_dynamic_xml(CPUState *cs, const char *xml_name)
> +{
> +    PowerPCCPU *cpu = POWERPC_CPU(cs);
> +    PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cpu);

nit: you could do POWERPC_CPU_GET_CLASS(cs) and ditch @cpu.


> +
> +    if (strcmp(xml_name, "power-spr.xml") == 0) {
> +        return pcc->gdb_spr_xml;
> +    }
> +    return NULL;
> +}
> +#endif
> diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.inc.c
> index ade06cc773..710064a25d 100644
> --- a/target/ppc/translate_init.inc.c
> +++ b/target/ppc/translate_init.inc.c
> @@ -8987,6 +8987,10 @@ static void init_ppc_proc(PowerPCCPU *cpu)
>      /* PowerPC implementation specific initialisations (SPRs, timers, ...) */
>      (*pcc->init_proc)(env);
>  
> +#if !defined(CONFIG_USER_ONLY)
> +    ppc_gdb_gen_spr_xml(cpu);
> +#endif
> +
>      /* MSR bits & flags consistency checks */
>      if (env->msr_mask & (1 << 25)) {
>          switch (env->flags & (POWERPC_FLAG_SPE | POWERPC_FLAG_VRE)) {
> 

-- 
Alexey
