Received: from eggs.gnu.org ([2001:4830:134:3::10]:45442)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cdmNE-0004AH-Bk
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 18:19:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cdmNA-0001O8-Ab
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 18:19:04 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <B5737074-2342-45C9-A7A3-339599F8CB9B@gtri.gatech.edu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <583af3e1-f5cb-d14d-449b-c460840b73d0@amsat.org>
Date: Tue, 14 Feb 2017 20:18:55 -0300
MIME-Version: 1.0
In-Reply-To: <B5737074-2342-45C9-A7A3-339599F8CB9B@gtri.gatech.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] Add PowerPC 32-bit guest memory dump
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Nawrocki, Michael" <Michael.Nawrocki@gtri.gatech.edu>
Cc: "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "agraf@suse.de" <agraf@suse.de>, "david@gibson.dropbear.id.au" <david@gibson.dropbear.id.au>

Hi Mike,

I failed to apply your patch on master:

error: patch failed: target/ppc/Makefile.objs:1
error: target/ppc/Makefile.objs: patch does not apply
error: patch failed: target/ppc/arch_dump.c:1
error: target/ppc/arch_dump.c: patch does not apply
error: patch failed: target/ppc/cpu.h:1225
error: target/ppc/cpu.h: patch does not apply
error: patch failed: target/ppc/translate_init.c:10478
error: target/ppc/translate_init.c: patch does not apply
Patch failed at 0001 Add PowerPC 32-bit guest memory dump support

Can you rebase/fix?

Thanks

On 02/08/2017 05:39 PM, Nawrocki, Michael wrote:
> This patch extends support for the `dump-guest-memory` command to the 32-bit PowerPC architecture. It relies on the assumption that a 64-bit guest will not dump a 32-bit core file (and vice versa); if this assumption is invalid, please let me know.
>
> Signed-off-by: Mike Nawrocki <michael.nawrocki@gtri.gatech.edu>
> ---
>  target/ppc/Makefile.objs    |   4 +-
>  target/ppc/arch_dump.c      | 154 ++++++++++++++++++++++++--------------------
>  target/ppc/cpu.h            |   2 +
>  target/ppc/translate_init.c |   5 +-
>  4 files changed, 91 insertions(+), 74 deletions(-)
>
> diff --git a/target/ppc/Makefile.objs b/target/ppc/Makefile.objs
> index a8c7a30..f50ffac 100644
> --- a/target/ppc/Makefile.objs
> +++ b/target/ppc/Makefile.objs
> @@ -1,8 +1,8 @@
>  obj-y += cpu-models.o
>  obj-y += translate.o
>  ifeq ($(CONFIG_SOFTMMU),y)
> -obj-y += machine.o mmu_helper.o mmu-hash32.o monitor.o
> -obj-$(TARGET_PPC64) += mmu-hash64.o arch_dump.o compat.o
> +obj-y += machine.o mmu_helper.o mmu-hash32.o monitor.o arch_dump.o
> +obj-$(TARGET_PPC64) += mmu-hash64.o compat.o
>  endif
>  obj-$(CONFIG_KVM) += kvm.o
>  obj-$(call lnot,$(CONFIG_KVM)) += kvm-stub.o
> diff --git a/target/ppc/arch_dump.c b/target/ppc/arch_dump.c
> index 40282a1..28d9cc7 100644
> --- a/target/ppc/arch_dump.c
> +++ b/target/ppc/arch_dump.c
> @@ -1,5 +1,5 @@
>  /*
> - * writing ELF notes for ppc64 arch
> + * writing ELF notes for ppc{64,} arch
>   *
>   *
>   * Copyright IBM, Corp. 2013
> @@ -19,36 +19,48 @@
>  #include "sysemu/dump.h"
>  #include "sysemu/kvm.h"
>
> -struct PPC64UserRegStruct {
> -    uint64_t gpr[32];
> -    uint64_t nip;
> -    uint64_t msr;
> -    uint64_t orig_gpr3;
> -    uint64_t ctr;
> -    uint64_t link;
> -    uint64_t xer;
> -    uint64_t ccr;
> -    uint64_t softe;
> -    uint64_t trap;
> -    uint64_t dar;
> -    uint64_t dsisr;
> -    uint64_t result;
> +#ifdef TARGET_PPC64
> +#define ELFCLASS ELFCLASS64
> +#define cpu_to_dump_reg cpu_to_dump64
> +typedef uint64_t reg_t;
> +typedef Elf64_Nhdr Elf_Nhdr;
> +#else
> +#define ELFCLASS ELFCLASS32
> +#define cpu_to_dump_reg cpu_to_dump32
> +typedef uint32_t reg_t;
> +typedef Elf32_Nhdr Elf_Nhdr;
> +#endif /* TARGET_PPC64 */
> +
> +struct PPCUserRegStruct {
> +    reg_t gpr[32];
> +    reg_t nip;
> +    reg_t msr;
> +    reg_t orig_gpr3;
> +    reg_t ctr;
> +    reg_t link;
> +    reg_t xer;
> +    reg_t ccr;
> +    reg_t softe;
> +    reg_t trap;
> +    reg_t dar;
> +    reg_t dsisr;
> +    reg_t result;
>  } QEMU_PACKED;
>
> -struct PPC64ElfPrstatus {
> +struct PPCElfPrstatus {
>      char pad1[112];
> -    struct PPC64UserRegStruct pr_reg;
> -    uint64_t pad2[4];
> +    struct PPCUserRegStruct pr_reg;
> +    reg_t pad2[4];
>  } QEMU_PACKED;
>
>
> -struct PPC64ElfFpregset {
> +struct PPCElfFpregset {
>      uint64_t fpr[32];
> -    uint64_t fpscr;
> +    reg_t fpscr;
>  }  QEMU_PACKED;
>
>
> -struct PPC64ElfVmxregset {
> +struct PPCElfVmxregset {
>      ppc_avr_t avr[32];
>      ppc_avr_t vscr;
>      union {
> @@ -57,26 +69,26 @@ struct PPC64ElfVmxregset {
>      } vrsave;
>  }  QEMU_PACKED;
>
> -struct PPC64ElfVsxregset {
> +struct PPCElfVsxregset {
>      uint64_t vsr[32];
>  }  QEMU_PACKED;
>
> -struct PPC64ElfSperegset {
> +struct PPCElfSperegset {
>      uint32_t evr[32];
>      uint64_t spe_acc;
>      uint32_t spe_fscr;
>  }  QEMU_PACKED;
>
>  typedef struct noteStruct {
> -    Elf64_Nhdr hdr;
> +    Elf_Nhdr hdr;
>      char name[5];
>      char pad3[3];
>      union {
> -        struct PPC64ElfPrstatus  prstatus;
> -        struct PPC64ElfFpregset  fpregset;
> -        struct PPC64ElfVmxregset vmxregset;
> -        struct PPC64ElfVsxregset vsxregset;
> -        struct PPC64ElfSperegset speregset;
> +        struct PPCElfPrstatus  prstatus;
> +        struct PPCElfFpregset  fpregset;
> +        struct PPCElfVmxregset vmxregset;
> +        struct PPCElfVsxregset vsxregset;
> +        struct PPCElfSperegset speregset;
>      } contents;
>  } QEMU_PACKED Note;
>
> @@ -85,12 +97,12 @@ typedef struct NoteFuncArg {
>      DumpState *state;
>  } NoteFuncArg;
>
> -static void ppc64_write_elf64_prstatus(NoteFuncArg *arg, PowerPCCPU *cpu)
> +static void ppc_write_elf_prstatus(NoteFuncArg *arg, PowerPCCPU *cpu)
>  {
>      int i;
> -    uint64_t cr;
> -    struct PPC64ElfPrstatus *prstatus;
> -    struct PPC64UserRegStruct *reg;
> +    reg_t cr;
> +    struct PPCElfPrstatus *prstatus;
> +    struct PPCUserRegStruct *reg;
>      Note *note = &arg->note;
>      DumpState *s = arg->state;
>
> @@ -101,25 +113,25 @@ static void ppc64_write_elf64_prstatus(NoteFuncArg *arg, PowerPCCPU *cpu)
>      reg = &prstatus->pr_reg;
>
>      for (i = 0; i < 32; i++) {
> -        reg->gpr[i] = cpu_to_dump64(s, cpu->env.gpr[i]);
> +        reg->gpr[i] = cpu_to_dump_reg(s, cpu->env.gpr[i]);
>      }
> -    reg->nip = cpu_to_dump64(s, cpu->env.nip);
> -    reg->msr = cpu_to_dump64(s, cpu->env.msr);
> -    reg->ctr = cpu_to_dump64(s, cpu->env.ctr);
> -    reg->link = cpu_to_dump64(s, cpu->env.lr);
> -    reg->xer = cpu_to_dump64(s, cpu_read_xer(&cpu->env));
> +    reg->nip = cpu_to_dump_reg(s, cpu->env.nip);
> +    reg->msr = cpu_to_dump_reg(s, cpu->env.msr);
> +    reg->ctr = cpu_to_dump_reg(s, cpu->env.ctr);
> +    reg->link = cpu_to_dump_reg(s, cpu->env.lr);
> +    reg->xer = cpu_to_dump_reg(s, cpu_read_xer(&cpu->env));
>
>      cr = 0;
>      for (i = 0; i < 8; i++) {
>          cr |= (cpu->env.crf[i] & 15) << (4 * (7 - i));
>      }
> -    reg->ccr = cpu_to_dump64(s, cr);
> +    reg->ccr = cpu_to_dump_reg(s, cr);
>  }
>
> -static void ppc64_write_elf64_fpregset(NoteFuncArg *arg, PowerPCCPU *cpu)
> +static void ppc_write_elf_fpregset(NoteFuncArg *arg, PowerPCCPU *cpu)
>  {
>      int i;
> -    struct PPC64ElfFpregset  *fpregset;
> +    struct PPCElfFpregset  *fpregset;
>      Note *note = &arg->note;
>      DumpState *s = arg->state;
>
> @@ -131,13 +143,13 @@ static void ppc64_write_elf64_fpregset(NoteFuncArg *arg, PowerPCCPU *cpu)
>      for (i = 0; i < 32; i++) {
>          fpregset->fpr[i] = cpu_to_dump64(s, cpu->env.fpr[i]);
>      }
> -    fpregset->fpscr = cpu_to_dump64(s, cpu->env.fpscr);
> +    fpregset->fpscr = cpu_to_dump_reg(s, cpu->env.fpscr);
>  }
>
> -static void ppc64_write_elf64_vmxregset(NoteFuncArg *arg, PowerPCCPU *cpu)
> +static void ppc_write_elf_vmxregset(NoteFuncArg *arg, PowerPCCPU *cpu)
>  {
>      int i;
> -    struct PPC64ElfVmxregset *vmxregset;
> +    struct PPCElfVmxregset *vmxregset;
>      Note *note = &arg->note;
>      DumpState *s = arg->state;
>
> @@ -164,10 +176,11 @@ static void ppc64_write_elf64_vmxregset(NoteFuncArg *arg, PowerPCCPU *cpu)
>      }
>      vmxregset->vscr.u32[3] = cpu_to_dump32(s, cpu->env.vscr);
>  }
> -static void ppc64_write_elf64_vsxregset(NoteFuncArg *arg, PowerPCCPU *cpu)
> +
> +static void ppc_write_elf_vsxregset(NoteFuncArg *arg, PowerPCCPU *cpu)
>  {
>      int i;
> -    struct PPC64ElfVsxregset *vsxregset;
> +    struct PPCElfVsxregset *vsxregset;
>      Note *note = &arg->note;
>      DumpState *s = arg->state;
>
> @@ -179,9 +192,10 @@ static void ppc64_write_elf64_vsxregset(NoteFuncArg *arg, PowerPCCPU *cpu)
>          vsxregset->vsr[i] = cpu_to_dump64(s, cpu->env.vsr[i]);
>      }
>  }
> -static void ppc64_write_elf64_speregset(NoteFuncArg *arg, PowerPCCPU *cpu)
> +
> +static void ppc_write_elf_speregset(NoteFuncArg *arg, PowerPCCPU *cpu)
>  {
> -    struct PPC64ElfSperegset *speregset;
> +    struct PPCElfSperegset *speregset;
>      Note *note = &arg->note;
>      DumpState *s = arg->state;
>
> @@ -197,11 +211,11 @@ static const struct NoteFuncDescStruct {
>      int contents_size;
>      void (*note_contents_func)(NoteFuncArg *arg, PowerPCCPU *cpu);
>  } note_func[] = {
> -    {sizeof(((Note *)0)->contents.prstatus),  ppc64_write_elf64_prstatus},
> -    {sizeof(((Note *)0)->contents.fpregset),  ppc64_write_elf64_fpregset},
> -    {sizeof(((Note *)0)->contents.vmxregset), ppc64_write_elf64_vmxregset},
> -    {sizeof(((Note *)0)->contents.vsxregset), ppc64_write_elf64_vsxregset},
> -    {sizeof(((Note *)0)->contents.speregset), ppc64_write_elf64_speregset},
> +    {sizeof(((Note *)0)->contents.prstatus),  ppc_write_elf_prstatus},
> +    {sizeof(((Note *)0)->contents.fpregset),  ppc_write_elf_fpregset},
> +    {sizeof(((Note *)0)->contents.vmxregset), ppc_write_elf_vmxregset},
> +    {sizeof(((Note *)0)->contents.vsxregset), ppc_write_elf_vsxregset},
> +    {sizeof(((Note *)0)->contents.speregset), ppc_write_elf_speregset},
>      { 0, NULL}
>  };
>
> @@ -213,8 +227,9 @@ int cpu_get_dump_info(ArchDumpInfo *info,
>      PowerPCCPU *cpu = POWERPC_CPU(first_cpu);
>      PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cpu);
>
> -    info->d_machine = EM_PPC64;
> -    info->d_class = ELFCLASS64;
> +    info->d_machine = PPC_ELF_MACHINE;
> +    info->d_class = ELFCLASS;
> +
>      if ((*pcc->interrupts_big_endian)(cpu)) {
>          info->d_endian = ELFDATA2MSB;
>      } else {
> @@ -236,25 +251,19 @@ ssize_t cpu_get_note_size(int class, int machine, int nr_cpus)
>      int note_head_size;
>      const NoteFuncDesc *nf;
>
> -    if (class != ELFCLASS64) {
> -        return -1;
> -    }
> -    assert(machine == EM_PPC64);
> -
> -    note_head_size = sizeof(Elf64_Nhdr);
> -
> +    note_head_size = sizeof(Elf_Nhdr);
>      for (nf = note_func; nf->note_contents_func; nf++) {
>          elf_note_size = elf_note_size + note_head_size + name_size +
> -                        nf->contents_size;
> +            nf->contents_size;
>      }
>
>      return (elf_note_size) * nr_cpus;
>  }
>
> -static int ppc64_write_all_elf64_notes(const char *note_name,
> -                                       WriteCoreDumpFunction f,
> -                                       PowerPCCPU *cpu, int id,
> -                                       void *opaque)
> +static int ppc_write_all_elf_notes(const char *note_name,
> +                                   WriteCoreDumpFunction f,
> +                                   PowerPCCPU *cpu, int id,
> +                                   void *opaque)
>  {
>      NoteFuncArg arg = { .state = opaque };
>      int ret = -1;
> @@ -282,5 +291,12 @@ int ppc64_cpu_write_elf64_note(WriteCoreDumpFunction f, CPUState *cs,
>                                 int cpuid, void *opaque)
>  {
>      PowerPCCPU *cpu = POWERPC_CPU(cs);
> -    return ppc64_write_all_elf64_notes("CORE", f, cpu, cpuid, opaque);
> +    return ppc_write_all_elf_notes("CORE", f, cpu, cpuid, opaque);
> +}
> +
> +int ppc32_cpu_write_elf32_note(WriteCoreDumpFunction f, CPUState *cs,
> +                               int cpuid, void *opaque)
> +{
> +    PowerPCCPU *cpu = POWERPC_CPU(cs);
> +    return ppc_write_all_elf_notes("CORE", f, cpu, cpuid, opaque);
>  }
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index bc2a2ce..61efd7b 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -1225,6 +1225,8 @@ int ppc_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
>  int ppc_cpu_gdb_write_register_apple(CPUState *cpu, uint8_t *buf, int reg);
>  int ppc64_cpu_write_elf64_note(WriteCoreDumpFunction f, CPUState *cs,
>                                 int cpuid, void *opaque);
> +int ppc32_cpu_write_elf32_note(WriteCoreDumpFunction f, CPUState *cs,
> +                               int cpuid, void *opaque);
>  #ifndef CONFIG_USER_ONLY
>  void ppc_cpu_do_system_reset(CPUState *cs);
>  extern const struct VMStateDescription vmstate_ppc_cpu;
> diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
> index 76f79fa..ebb3d8a 100644
> --- a/target/ppc/translate_init.c
> +++ b/target/ppc/translate_init.c
> @@ -10478,11 +10478,10 @@ static void ppc_cpu_class_init(ObjectClass *oc, void *data)
>  #else
>      cc->get_phys_page_debug = ppc_cpu_get_phys_page_debug;
>      cc->vmsd = &vmstate_ppc_cpu;
> -#if defined(TARGET_PPC64)
> -    cc->write_elf64_note = ppc64_cpu_write_elf64_note;
> -#endif
>  #endif
>      cc->cpu_exec_enter = ppc_cpu_exec_enter;
> +    cc->write_elf64_note = ppc64_cpu_write_elf64_note;
> +    cc->write_elf32_note = ppc32_cpu_write_elf32_note;
>
>      cc->gdb_num_core_regs = 71;
>
>
