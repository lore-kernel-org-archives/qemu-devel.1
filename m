Received: from eggs.gnu.org ([2001:4830:134:3::10]:55627)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dgAUg-0007Li-WB
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 10:01:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dgAUd-0007SC-Nj
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 10:00:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51740)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dgAUd-0007RW-9j
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 10:00:51 -0400
References: <20170811074652.31474-1-david@redhat.com>
	<20170811074652.31474-2-david@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <c9bb3167-3de8-42a3-2815-0851b56f49a5@redhat.com>
Date: Fri, 11 Aug 2017 16:00:46 +0200
MIME-Version: 1.0
In-Reply-To: <20170811074652.31474-2-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH RFC 1/5] target/s390x: introduce internal.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: rth@twiddle.net, Aurelien Jarno <aurelien@aurel32.net>, cohuck@redhat.com, borntraeger@de.ibm.com

On 11.08.2017 09:46, David Hildenbrand wrote:
> cpu.h should only contain what really has to be accessed outside of
> target/s390x/. Add internal.h which can only be used inside target/s390=
x/.
>=20
> Move everything that isn't fast enough to run away and restructure it
> right away.
>=20
> Minor style fixes to avoid checkpatch warning to:
> - struct Lowcore: "{" goes into same line as typedef
> - struct LowCore: add spaces around "-" in array length calculations
> - time2tod() and tod2time(): move "{" to separate line
> - get_per_atmid(): add space between ")" and "?". Move cases by one cha=
r.
> - get_per_atmid(): drop extra paremthesis around (1 << 6)
>=20
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
[...]
> diff --git a/target/s390x/internal.h b/target/s390x/internal.h
> new file mode 100644
> index 0000000..9a55271
> --- /dev/null
> +++ b/target/s390x/internal.h
> @@ -0,0 +1,560 @@
> +/*
> + * s390x internal definitions and helpers
> + *
> + *  Copyright (c) 2009 Ulrich Hecht
> + *
> + * This library is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU Lesser General Public
> + * License as published by the Free Software Foundation; either
> + * version 2 of the License, or (at your option) any later version.
> + *
> + * This library is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * Lesser General Public License for more details.
> + *
> + * Contributions after 2012-10-29 are licensed under the terms of the
> + * GNU GPL, version 2 or (at your option) any later version.

Slightly off-topic to your patch, but since you're at it anyway: AFAIK
the above sentence effectively means that we should update the copyright
boiler plate to GPL2+ nowadays. See
https://www.gnu.org/licenses/old-licenses/lgpl-2.1.html section 3.

> + * You should have received a copy of the GNU (Lesser) General Public
> + * License along with this library; if not, see <http://www.gnu.org/li=
censes/>.
> + */
> +
> +#ifndef S390X_INTERNAL_H
> +#define S390X_INTERNAL_H
> +
> +#include "cpu.h"
> +
> +#ifndef CONFIG_USER_ONLY
> +typedef struct LowCore {
> +    /* prefix area: defined by architecture */
> +    uint32_t        ccw1[2];                  /* 0x000 */
> +    uint32_t        ccw2[4];                  /* 0x008 */
> +    uint8_t         pad1[0x80 - 0x18];        /* 0x018 */
> +    uint32_t        ext_params;               /* 0x080 */
> +    uint16_t        cpu_addr;                 /* 0x084 */
> +    uint16_t        ext_int_code;             /* 0x086 */
> +    uint16_t        svc_ilen;                 /* 0x088 */
> +    uint16_t        svc_code;                 /* 0x08a */
> +    uint16_t        pgm_ilen;                 /* 0x08c */
> +    uint16_t        pgm_code;                 /* 0x08e */
> +    uint32_t        data_exc_code;            /* 0x090 */
> +    uint16_t        mon_class_num;            /* 0x094 */
> +    uint16_t        per_perc_atmid;           /* 0x096 */
> +    uint64_t        per_address;              /* 0x098 */
> +    uint8_t         exc_access_id;            /* 0x0a0 */
> +    uint8_t         per_access_id;            /* 0x0a1 */
> +    uint8_t         op_access_id;             /* 0x0a2 */
> +    uint8_t         ar_access_id;             /* 0x0a3 */
> +    uint8_t         pad2[0xA8 - 0xA4];        /* 0x0a4 */
> +    uint64_t        trans_exc_code;           /* 0x0a8 */
> +    uint64_t        monitor_code;             /* 0x0b0 */
> +    uint16_t        subchannel_id;            /* 0x0b8 */
> +    uint16_t        subchannel_nr;            /* 0x0ba */
> +    uint32_t        io_int_parm;              /* 0x0bc */
> +    uint32_t        io_int_word;              /* 0x0c0 */
> +    uint8_t         pad3[0xc8 - 0xc4];        /* 0x0c4 */
> +    uint32_t        stfl_fac_list;            /* 0x0c8 */
> +    uint8_t         pad4[0xe8 - 0xcc];        /* 0x0cc */
> +    uint32_t        mcck_interruption_code[2]; /* 0x0e8 */
> +    uint8_t         pad5[0xf4 - 0xf0];        /* 0x0f0 */
> +    uint32_t        external_damage_code;     /* 0x0f4 */
> +    uint64_t        failing_storage_address;  /* 0x0f8 */
> +    uint8_t         pad6[0x110 - 0x100];      /* 0x100 */
> +    uint64_t        per_breaking_event_addr;  /* 0x110 */
> +    uint8_t         pad7[0x120 - 0x118];      /* 0x118 */
> +    PSW             restart_old_psw;          /* 0x120 */
> +    PSW             external_old_psw;         /* 0x130 */
> +    PSW             svc_old_psw;              /* 0x140 */
> +    PSW             program_old_psw;          /* 0x150 */
> +    PSW             mcck_old_psw;             /* 0x160 */
> +    PSW             io_old_psw;               /* 0x170 */
> +    uint8_t         pad8[0x1a0 - 0x180];      /* 0x180 */
> +    PSW             restart_new_psw;          /* 0x1a0 */
> +    PSW             external_new_psw;         /* 0x1b0 */
> +    PSW             svc_new_psw;              /* 0x1c0 */
> +    PSW             program_new_psw;          /* 0x1d0 */
> +    PSW             mcck_new_psw;             /* 0x1e0 */
> +    PSW             io_new_psw;               /* 0x1f0 */
> +    PSW             return_psw;               /* 0x200 */
> +    uint8_t         irb[64];                  /* 0x210 */
> +    uint64_t        sync_enter_timer;         /* 0x250 */
> +    uint64_t        async_enter_timer;        /* 0x258 */
> +    uint64_t        exit_timer;               /* 0x260 */
> +    uint64_t        last_update_timer;        /* 0x268 */
> +    uint64_t        user_timer;               /* 0x270 */
> +    uint64_t        system_timer;             /* 0x278 */
> +    uint64_t        last_update_clock;        /* 0x280 */
> +    uint64_t        steal_clock;              /* 0x288 */
> +    PSW             return_mcck_psw;          /* 0x290 */
> +    uint8_t         pad9[0xc00 - 0x2a0];      /* 0x2a0 */
> +    /* System info area */
> +    uint64_t        save_area[16];            /* 0xc00 */
> +    uint8_t         pad10[0xd40 - 0xc80];     /* 0xc80 */
> +    uint64_t        kernel_stack;             /* 0xd40 */
> +    uint64_t        thread_info;              /* 0xd48 */
> +    uint64_t        async_stack;              /* 0xd50 */
> +    uint64_t        kernel_asce;              /* 0xd58 */
> +    uint64_t        user_asce;                /* 0xd60 */
> +    uint64_t        panic_stack;              /* 0xd68 */
> +    uint64_t        user_exec_asce;           /* 0xd70 */
> +    uint8_t         pad11[0xdc0 - 0xd78];     /* 0xd78 */
> +
> +    /* SMP info area: defined by DJB */
> +    uint64_t        clock_comparator;         /* 0xdc0 */
> +    uint64_t        ext_call_fast;            /* 0xdc8 */
> +    uint64_t        percpu_offset;            /* 0xdd0 */
> +    uint64_t        current_task;             /* 0xdd8 */
> +    uint32_t        softirq_pending;          /* 0xde0 */
> +    uint32_t        pad_0x0de4;               /* 0xde4 */
> +    uint64_t        int_clock;                /* 0xde8 */
> +    uint8_t         pad12[0xe00 - 0xdf0];     /* 0xdf0 */
> +
> +    /* 0xe00 is used as indicator for dump tools */
> +    /* whether the kernel died with panic() or not */
> +    uint32_t        panic_magic;              /* 0xe00 */
> +
> +    uint8_t         pad13[0x11b8 - 0xe04];    /* 0xe04 */
> +
> +    /* 64 bit extparam used for pfault, diag 250 etc  */
> +    uint64_t        ext_params2;               /* 0x11B8 */
> +
> +    uint8_t         pad14[0x1200 - 0x11C0];    /* 0x11C0 */
> +
> +    /* System info area */
> +
> +    uint64_t        floating_pt_save_area[16]; /* 0x1200 */
> +    uint64_t        gpregs_save_area[16];      /* 0x1280 */
> +    uint32_t        st_status_fixed_logout[4]; /* 0x1300 */
> +    uint8_t         pad15[0x1318 - 0x1310];    /* 0x1310 */
> +    uint32_t        prefixreg_save_area;       /* 0x1318 */
> +    uint32_t        fpt_creg_save_area;        /* 0x131c */
> +    uint8_t         pad16[0x1324 - 0x1320];    /* 0x1320 */
> +    uint32_t        tod_progreg_save_area;     /* 0x1324 */
> +    uint32_t        cpu_timer_save_area[2];    /* 0x1328 */
> +    uint32_t        clock_comp_save_area[2];   /* 0x1330 */
> +    uint8_t         pad17[0x1340 - 0x1338];    /* 0x1338 */
> +    uint32_t        access_regs_save_area[16]; /* 0x1340 */
> +    uint64_t        cregs_save_area[16];       /* 0x1380 */
> +
> +    /* align to the top of the prefix area */
> +
> +    uint8_t         pad18[0x2000 - 0x1400];    /* 0x1400 */
> +} QEMU_PACKED LowCore;
> +#endif /* CONFIG_USER_ONLY */

Maybe you could move the cpu_map_lowcore() below into the same #ifdef
now? Or maybe move everything related to lowcore into a separate header
file called "lowcore.h" instead? ... just ideas, I've got not a strong
opinion about that yet.

> +static inline uint64_t cpu_mmu_idx_to_asc(int mmu_idx)
> +{
> +    switch (mmu_idx) {
> +    case MMU_PRIMARY_IDX:
> +        return PSW_ASC_PRIMARY;
> +    case MMU_SECONDARY_IDX:
> +        return PSW_ASC_SECONDARY;
> +    case MMU_HOME_IDX:
> +        return PSW_ASC_HOME;
> +    default:
> +        abort();
> +    }
> +}

Only used in excp_helper.c =3D=3D=3D> move it there?

> +static inline bool psw_key_valid(CPUS390XState *env, uint8_t psw_key)
> +{
> +    uint16_t pkm =3D env->cregs[3] >> 16;
> +
> +    if (env->psw.mask & PSW_MASK_PSTATE) {
> +        /* PSW key has range 0..15, it is valid if the bit is 1 in the=
 PKM */
> +        return pkm & (0x80 >> psw_key);
> +    }
> +    return true;
> +}

Only used in mem_helper.c =3D=3D> suggest to move it there.

[...]
> +/* Check if an address is within the PER starting address and the PER
> +   ending address.  The address range might loop.  */
> +static inline bool get_per_in_range(CPUS390XState *env, uint64_t addr)
> +{
> +    if (env->cregs[10] <=3D env->cregs[11]) {
> +        return env->cregs[10] <=3D addr && addr <=3D env->cregs[11];
> +    } else {
> +        return env->cregs[10] <=3D addr || addr <=3D env->cregs[11];
> +    }
> +}

Only used in misc_helper.c =3D=3D> move it there?

[...]
> +/* helper functions for run_on_cpu() */
> +static inline void s390_do_cpu_reset(CPUState *cs, run_on_cpu_data arg=
)
> +{
> +    S390CPUClass *scc =3D S390_CPU_GET_CLASS(cs);
> +
> +    scc->cpu_reset(cs);
> +}

This function seems to be used in diag.c only, so you could also move it
there instead.


> +/* arch_dump.c */
> +int s390_cpu_write_elf64_note(WriteCoreDumpFunction f, CPUState *cs,
> +                              int cpuid, void *opaque);
> +
> +
> +/* cc_helper.c */
> +void load_psw(CPUS390XState *env, uint64_t mask, uint64_t addr);
> +uint32_t calc_cc(CPUS390XState *env, uint32_t cc_op, uint64_t src, uin=
t64_t dst,
> +                 uint64_t vr);
> +
> +
> +/* cpu.c */
> +#ifndef CONFIG_USER_ONLY
> +unsigned int s390_cpu_halt(S390CPU *cpu);
> +void s390_cpu_unhalt(S390CPU *cpu);
> +#else
> +static inline unsigned int s390_cpu_halt(S390CPU *cpu)
> +{
> +    return 0;
> +}
> +
> +static inline void s390_cpu_unhalt(S390CPU *cpu)
> +{
> +}
> +#endif
> +
> +
> +/* cpu_models.c */
> +void s390_cpu_model_register_props(Object *obj);
> +void s390_cpu_model_class_register_props(ObjectClass *oc);
> +void s390_realize_cpu_model(CPUState *cs, Error **errp);
> +ObjectClass *s390_cpu_class_by_name(const char *name);
> +
> +
> +/* excp_helper.c */
> +void s390x_cpu_debug_excp_handler(CPUState *cs);
> +void s390_cpu_do_interrupt(CPUState *cpu);
> +bool s390_cpu_exec_interrupt(CPUState *cpu, int int_req);
> +int s390_cpu_handle_mmu_fault(CPUState *cpu, vaddr address, int rw,
> +                              int mmu_idx);
> +void s390x_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
> +                                   MMUAccessType access_type,
> +                                   int mmu_idx, uintptr_t retaddr);
> +
> +
> +/* fpu_helper.c */
> +uint32_t set_cc_nz_f32(float32 v);
> +uint32_t set_cc_nz_f64(float64 v);
> +uint32_t set_cc_nz_f128(float128 v);
> +
> +
> +/* gdbstub.c */
> +int s390_cpu_gdb_read_register(CPUState *cpu, uint8_t *buf, int reg);
> +int s390_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
> +void s390_cpu_gdb_init(CPUState *cs);
> +
> +
> +/* helper.c */
> +void s390_cpu_dump_state(CPUState *cpu, FILE *f, fprintf_function cpu_=
fprintf,
> +                         int flags);
> +hwaddr s390_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
> +hwaddr s390_cpu_get_phys_addr_debug(CPUState *cpu, vaddr addr);
> +uint64_t get_psw_mask(CPUS390XState *env);
> +void s390_cpu_recompute_watchpoints(CPUState *cs);
> +void s390x_tod_timer(void *opaque);
> +void s390x_cpu_timer(void *opaque);
> +S390CPU *cpu_s390x_create(const char *cpu_model, Error **errp);
> +void do_restart_interrupt(CPUS390XState *env);
> +#ifndef CONFIG_USER_ONLY
> +LowCore *cpu_map_lowcore(CPUS390XState *env);
> +void cpu_unmap_lowcore(LowCore *lowcore);
> +#endif /* CONFIG_USER_ONLY */
> +
> +
> +/* interrupt.c */
> +void trigger_pgm_exception(CPUS390XState *env, uint32_t code, uint32_t=
 ilen);
> +void cpu_inject_ext(S390CPU *cpu, uint32_t code, uint32_t param,
> +                    uint64_t param64);
> +
> +
> +/* ioinst.c */
> +void ioinst_handle_xsch(S390CPU *cpu, uint64_t reg1);
> +void ioinst_handle_csch(S390CPU *cpu, uint64_t reg1);
> +void ioinst_handle_hsch(S390CPU *cpu, uint64_t reg1);
> +void ioinst_handle_msch(S390CPU *cpu, uint64_t reg1, uint32_t ipb);
> +void ioinst_handle_ssch(S390CPU *cpu, uint64_t reg1, uint32_t ipb);
> +void ioinst_handle_stcrw(S390CPU *cpu, uint32_t ipb);
> +void ioinst_handle_stsch(S390CPU *cpu, uint64_t reg1, uint32_t ipb);
> +int ioinst_handle_tsch(S390CPU *cpu, uint64_t reg1, uint32_t ipb);
> +void ioinst_handle_chsc(S390CPU *cpu, uint32_t ipb);
> +int ioinst_handle_tpi(S390CPU *cpu, uint32_t ipb);
> +void ioinst_handle_schm(S390CPU *cpu, uint64_t reg1, uint64_t reg2,
> +                        uint32_t ipb);
> +void ioinst_handle_rsch(S390CPU *cpu, uint64_t reg1);
> +void ioinst_handle_rchp(S390CPU *cpu, uint64_t reg1);
> +void ioinst_handle_sal(S390CPU *cpu, uint64_t reg1);
> +
> +
> +/* kvm.c */
> +#ifdef CONFIG_KVM
> +void kvm_s390_floating_interrupt(struct kvm_s390_irq *irq);
> +void kvm_s390_service_interrupt(uint32_t parm);
> +void kvm_s390_vcpu_interrupt(S390CPU *cpu, struct kvm_s390_irq *irq);
> +void kvm_s390_access_exception(S390CPU *cpu, uint16_t code, uint64_t t=
e_code);
> +int kvm_s390_mem_op(S390CPU *cpu, vaddr addr, uint8_t ar, void *hostbu=
f,
> +                    int len, bool is_write);
> +void kvm_s390_program_interrupt(S390CPU *cpu, uint16_t code);
> +void kvm_s390_io_interrupt(uint16_t subchannel_id,
> +                           uint16_t subchannel_nr, uint32_t io_int_par=
m,
> +                           uint32_t io_int_word);
> +void kvm_s390_crw_mchk(void);
> +int kvm_s390_set_cpu_state(S390CPU *cpu, uint8_t cpu_state);
> +void kvm_s390_vcpu_interrupt_pre_save(S390CPU *cpu);
> +int kvm_s390_vcpu_interrupt_post_load(S390CPU *cpu);
> +int kvm_s390_get_ri(void);
> +int kvm_s390_get_gs(void);
> +#else
> +static inline void kvm_s390_service_interrupt(uint32_t parm)
> +{
> +}
> +static inline void kvm_s390_access_exception(S390CPU *cpu, uint16_t co=
de,
> +                                             uint64_t te_code)
> +{
> +}
> +static inline int kvm_s390_mem_op(S390CPU *cpu, vaddr addr, uint8_t ar=
,
> +                                  void *hostbuf, int len, bool is_writ=
e)
> +{
> +    return -ENOSYS;
> +}
> +static inline void kvm_s390_program_interrupt(S390CPU *cpu, uint16_t c=
ode)
> +{
> +}
> +static inline void kvm_s390_io_interrupt(uint16_t subchannel_id,
> +                                        uint16_t subchannel_nr,
> +                                        uint32_t io_int_parm,
> +                                        uint32_t io_int_word)
> +{
> +}
> +static inline void kvm_s390_crw_mchk(void)
> +{
> +}
> +static inline int kvm_s390_set_cpu_state(S390CPU *cpu, uint8_t cpu_sta=
te)
> +{
> +    return -ENOSYS;
> +}
> +static inline void kvm_s390_vcpu_interrupt_pre_save(S390CPU *cpu)
> +{
> +}
> +static inline int kvm_s390_vcpu_interrupt_post_load(S390CPU *cpu)
> +{
> +    return 0;
> +}
> +static inline int kvm_s390_get_ri(void)
> +{
> +    return 0;
> +}
> +static inline int kvm_s390_get_gs(void)
> +{
> +    return 0;
> +}
> +#endif /* CONFIG_KVM */
> +
> +
> +/* mem_helper.c */
> +target_ulong mmu_real2abs(CPUS390XState *env, target_ulong raddr);
> +
> +
> +/* mmu_helper.c */
> +int mmu_translate(CPUS390XState *env, target_ulong vaddr, int rw, uint=
64_t asc,
> +                  target_ulong *raddr, int *flags, bool exc);
> +
> +
> +/* misc_helper.c */
> +void QEMU_NORETURN runtime_exception(CPUS390XState *env, int excp,
> +                                     uintptr_t retaddr);
> +int handle_diag_288(CPUS390XState *env, uint64_t r1, uint64_t r3);
> +void handle_diag_308(CPUS390XState *env, uint64_t r1, uint64_t r3);
> +
> +
> +/* translate.c */
> +void s390x_translate_init(void);

I wonder whether we maybe want to have separate headers for all these
prototypes, at least for the files that would have a lot of them, e.g.
ioinst.h ?

 Thomas
