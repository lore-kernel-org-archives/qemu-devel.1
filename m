Received: from eggs.gnu.org ([209.51.188.92]:38272)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gk6Z2-0002Rc-NU
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 07:14:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gk6Yz-0000N5-3Y
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 07:14:27 -0500
Received: from 9.mo178.mail-out.ovh.net ([46.105.75.45]:50095)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1gk6Yt-0000D2-Q0
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 07:14:24 -0500
Received: from player791.ha.ovh.net (unknown [10.109.143.208])
	by mo178.mail-out.ovh.net (Postfix) with ESMTP id B330C45BCF
	for <qemu-devel@nongnu.org>; Thu, 17 Jan 2019 13:14:11 +0100 (CET)
Date: Thu, 17 Jan 2019 13:14:01 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20190117131401.64bbd52d@bahia.lan>
In-Reply-To: <20190115193750.17234-2-farosas@linux.ibm.com>
References: <20190115193750.17234-1-farosas@linux.ibm.com>
	<20190115193750.17234-2-farosas@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v3 1/3] target/ppc: Add SPRs XML
 generation code for gdbstub
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fabiano Rosas <farosas@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

On Tue, 15 Jan 2019 17:37:48 -0200
Fabiano Rosas <farosas@linux.ibm.com> wrote:

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
>  target/ppc/cpu.h     |  8 +++++++
>  target/ppc/gdbstub.c | 54 ++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 62 insertions(+)
> 
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index 486abaf99b..34f0d2d419 100644
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
> @@ -1053,6 +1054,9 @@ struct CPUPPCState {
>      /* Special purpose registers */
>      target_ulong spr[1024];
>      ppc_spr_t spr_cb[1024];
> +#if !defined(CONFIG_USER_ONLY)
> +    const char *gdb_spr_xml;
> +#endif
>      /* Vector status and control register */
>      uint32_t vscr;
>      /* VSX registers (including FP and AVR) */
> @@ -1267,6 +1271,10 @@ int ppc_cpu_gdb_read_register(CPUState *cpu, uint8_t *buf, int reg);
>  int ppc_cpu_gdb_read_register_apple(CPUState *cpu, uint8_t *buf, int reg);
>  int ppc_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
>  int ppc_cpu_gdb_write_register_apple(CPUState *cpu, uint8_t *buf, int reg);
> +#ifndef CONFIG_USER_ONLY
> +int ppc_gdb_gen_spr_xml(CPUState *cpu);
> +const char *ppc_gdb_get_dynamic_xml(CPUState *cs, const char *xml_name);
> +#endif
>  int ppc64_cpu_write_elf64_note(WriteCoreDumpFunction f, CPUState *cs,
>                                 int cpuid, void *opaque);
>  int ppc32_cpu_write_elf32_note(WriteCoreDumpFunction f, CPUState *cs,
> diff --git a/target/ppc/gdbstub.c b/target/ppc/gdbstub.c
> index 19565b584d..ce4b728028 100644
> --- a/target/ppc/gdbstub.c
> +++ b/target/ppc/gdbstub.c
> @@ -319,3 +319,57 @@ int ppc_cpu_gdb_write_register_apple(CPUState *cs, uint8_t *mem_buf, int n)
>      }
>      return r;
>  }
> +
> +#ifndef CONFIG_USER_ONLY
> +int ppc_gdb_gen_spr_xml(CPUState *cs)
> +{
> +    PowerPCCPU *cpu = POWERPC_CPU(cs);
> +    CPUPPCState *env = &cpu->env;
> +    GString *s = g_string_new(NULL);
> +    unsigned int num_regs = 0;
> +    int i;
> +
> +    g_string_printf(s, "<?xml version=\"1.0\"?>");
> +    g_string_append_printf(s, "<!DOCTYPE target SYSTEM \"gdb-target.dtd\">");
> +    g_string_append_printf(s, "<feature name=\"org.qemu.power.spr\">");
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
> +    }
> +
> +    g_string_append_printf(s, "</feature>");
> +    env->gdb_spr_xml = g_string_free(s, false);

The g_string_free() documentation says that its up to the caller to g_free()
the character data in this case. If the CPU gets hot-unplugged at some point,
gdb_spr_xml is leaked since I see no g_free(env->gdb_spr_xml) in this patch.

This makes me think that all CPUs are supposed to have the same set of SPRs.
What about moving gdb_spr_xml to PowerPCCPUClass and have the first CPU
to set it once and far all ?

> +    return num_regs;
> +}
> +
> +const char *ppc_gdb_get_dynamic_xml(CPUState *cs, const char *xml_name)
> +{
> +    PowerPCCPU *cpu = POWERPC_CPU(cs);
> +    CPUPPCState *env = &cpu->env;
> +
> +    if (strcmp(xml_name, "power-spr.xml") == 0) {
> +        return env->gdb_spr_xml;
> +    }
> +    return NULL;
> +}
> +#endif
