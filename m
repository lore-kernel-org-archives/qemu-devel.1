Received: from eggs.gnu.org ([2001:4830:134:3::10]:60942)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1d3qnt-0005VT-9u
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 17:18:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1d3qnq-00023h-4f
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 17:18:21 -0400
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:34733)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <shorne@gmail.com>) id 1d3qnp-00023H-SC
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 17:18:18 -0400
Received: by mail-pf0-x243.google.com with SMTP id g23so13960722pfj.1
	for <qemu-devel@nongnu.org>; Thu, 27 Apr 2017 14:18:17 -0700 (PDT)
Date: Fri, 28 Apr 2017 06:18:13 +0900
From: Stafford Horne <shorne@gmail.com>
Message-ID: <20170427211813.GD2724@lianli.shorne-pla.net>
References: <20170418061551.196582-1-mithro@mithis.com>
	<20170418061551.196582-2-mithro@mithis.com>
	<20170418124711.GB2471@lianli.shorne-pla.net>
	<CAHLUNMwOL5UgaDZZA1s8UFodfm9pmhzxp=rt6wzsjPW2+dy3Sg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHLUNMwOL5UgaDZZA1s8UFodfm9pmhzxp=rt6wzsjPW2+dy3Sg@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH 1/2] target/openrisc: Implement EVBAR
 register
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Tim Ansell <mithro@mithis.com>
Cc: qemu-devel@nongnu.org, Jia Liu <proljc@gmail.com>, rth@twiddle.net

On Thu, Apr 27, 2017 at 10:55:28AM +1000, Tim Ansell wrote:
> I'm about to add support for disabling the inbuilt or1k timer peripheral
> (as our SoC does not have it enabled). That isn't really a CPU feature so I
> think it still makes sense to have some type of feature field? Maybe CPU
> features should just be a separate category and set directly on that
> register?
> 
> I also thinks it makes sense to maybe define a couple of new CPU
> configurations. I think we might want,
> 
>  * or1k-all - OpenRISC CPU with all emulated features enabled.
>  * or1k-minimal - Only features enabled which can't be disabled.
>  * mor1k-default - Configured to match the defaults in the mor1k verilog
> repo.
> 
> Then I think we also want configs for the "major users" of mor1k like,
> 
>  * mor1k-litex - Configured to match the default config used by litex/misoc
> (maybe mor1k-misoc as an alias?)
>  * mor1k-fusesoc - Configured to match the default of FuseSoC
>  * mor1k-minsoc - Configured to match the default of minsoc (which is
> different to misoc)
> 
> Thoughts?

I think this makes sense, we have the UPR and CPUCFGR read only SPR's to
track many of these features.  Currently specifying a different model will
change the cpucfgr.  We could expand to also define UPR as well to give
something like like below.

static void or1200_initfn(Object *obj)
{
    OpenRISCCPU *cpu = OPENRISC_CPU(obj);

    cpu->env.cpucfgr = CPUCFGR_NSGF | CPUCFGR_OB32S | CPUCFGR_OF32S |
                       CPUCFGR_EVBARP;

    cpu->env.upr = UPR_UP | UPR_DMP | UPR_IMP | UPR_PICP | UPR_TTP |
                   UPR_PMP;

    /* Features not supported in SPR config */
    cpu->env.features = /* Any examples? */
}

static void or1k_minimal_initfn(Object *obj)
{
    OpenRISCCPU *cpu = OPENRISC_CPU(obj);

    /* Nothing Enabled? */
}


static const OpenRISCCPUInfo openrisc_cpus[] = {
    { .name = "or1200",      .initfn = or1200_initfn },
    { .name = "or1k-all",    .initfn = or1200_initfn },
    { .name = "or1k-minimal",.initfn = or1k_miniamal_initfn },
    ...
    { .name = "any",         .initfn = openrisc_any_initfn },
};


These could then be used in different parts of the code to track if we
actually enable those features or not.  i.e:

    if (cpu->env.upr & UPR_PICP) {
        cpu_openrisc_pic_init(cpu);
    }
    if (cpu->env.upr & UPR_TTP) {
        cpu_openrisc_clock_init(cpu);
    }

I think its possible and it will be a bit of work to get done.

Thoughts?

-Stafford

> Tim 'mithro' Ansell
> 
> On Apr 18, 2017 10:47 PM, "Stafford Horne" <shorne@gmail.com> wrote:
> 
> On Tue, Apr 18, 2017 at 04:15:50PM +1000, Tim 'mithro' Ansell wrote:
> > Exception Vector Base Address Register (EVBAR) - This optional register
> > can be used to apply an offset to the exception vector addresses.
> >
> > The significant bits (31-12) of the vector offset address for each
> > exception depend on the setting of the Supervision Register (SR)'s EPH
> > bit and the Exception Vector Base Address Register (EVBAR).
> >
> > Its presence is indicated by the EVBARP bit in the CPU Configuration
> > Register (CPUCFGR).
> >
> > Signed-off-by: Tim 'mithro' Ansell <mithro@mithis.com>
> > ---
> >  target/openrisc/cpu.c        | 2 ++
> >  target/openrisc/cpu.h        | 7 +++++++
> >  target/openrisc/interrupt.c  | 6 +++++-
> >  target/openrisc/sys_helper.c | 7 +++++++
> >  4 files changed, 21 insertions(+), 1 deletion(-)
> >
> > diff --git a/target/openrisc/cpu.c b/target/openrisc/cpu.c
> > index 7fd2b9a216..1524ed981a 100644
> > --- a/target/openrisc/cpu.c
> > +++ b/target/openrisc/cpu.c
> > @@ -134,6 +134,7 @@ static void or1200_initfn(Object *obj)
> >
> >      set_feature(cpu, OPENRISC_FEATURE_OB32S);
> >      set_feature(cpu, OPENRISC_FEATURE_OF32S);
> > +    set_feature(cpu, OPENRISC_FEATURE_EVBAR);
> >  }
> >
> >  static void openrisc_any_initfn(Object *obj)
> > @@ -141,6 +142,7 @@ static void openrisc_any_initfn(Object *obj)
> >      OpenRISCCPU *cpu = OPENRISC_CPU(obj);
> >
> >      set_feature(cpu, OPENRISC_FEATURE_OB32S);
> > +    set_feature(cpu, OPENRISC_FEATURE_EVBAR);
> >  }
> >
> >  typedef struct OpenRISCCPUInfo {
> > diff --git a/target/openrisc/cpu.h b/target/openrisc/cpu.h
> > index 418a0e6960..1958b72718 100644
> > --- a/target/openrisc/cpu.h
> > +++ b/target/openrisc/cpu.h
> > @@ -111,6 +111,11 @@ enum {
> >      CPUCFGR_OF32S = (1 << 7),
> >      CPUCFGR_OF64S = (1 << 8),
> >      CPUCFGR_OV64S = (1 << 9),
> > +    /* CPUCFGR_ND = (1 << 10), */
> > +    /* CPUCFGR_AVRP = (1 << 11), */
> > +    CPUCFGR_EVBARP = (1 << 12),
> > +    /* CPUCFGR_ISRP = (1 << 13), */
> > +    /* CPUCFGR_AECSRP = (1 << 14), */
> >  };
> >
> >  /* DMMU configure register */
> > @@ -200,6 +205,7 @@ enum {
> >      OPENRISC_FEATURE_OF32S = (1 << 7),
> >      OPENRISC_FEATURE_OF64S = (1 << 8),
> >      OPENRISC_FEATURE_OV64S = (1 << 9),
> > +    OPENRISC_FEATURE_EVBAR = (1 << 12),
> 
> Does anyone know why we have to add both Features and CPUCFG bits?
> 
> It seems like duplication to me.
> 
> >  };
> >
> >  /* Tick Timer Mode Register */
> > @@ -289,6 +295,7 @@ typedef struct CPUOpenRISCState {
> >      uint32_t dmmucfgr;        /* DMMU configure register */
> >      uint32_t immucfgr;        /* IMMU configure register */
> >      uint32_t esr;             /* Exception supervisor register */
> > +    uint32_t evbar;           /* Exception vector base address register
> */
> 
> If we add something to CPUOpenRISCState, we ideally need to also add it to
> machine.c vmstate definition.  However, I currently have a patch out to
> rework the vmstate serialization.  I can add this to that patch.
> 
> >      uint32_t fpcsr;           /* Float register */
> >      float_status fp_status;
> >
> > diff --git a/target/openrisc/interrupt.c b/target/openrisc/interrupt.c
> > index a2eec6fb32..78f0ba9421 100644
> > --- a/target/openrisc/interrupt.c
> > +++ b/target/openrisc/interrupt.c
> > @@ -65,7 +65,11 @@ void openrisc_cpu_do_interrupt(CPUState *cs)
> >      env->lock_addr = -1;
> >
> >      if (cs->exception_index > 0 && cs->exception_index < EXCP_NR) {
> > -        env->pc = (cs->exception_index << 8);
> > +        hwaddr vect_pc = cs->exception_index << 8;
> > +        if (env->cpucfgr & CPUCFGR_EVBARP) {
> > +            vect_pc |= env->evbar;
> > +        }
> > +        env->pc = vect_pc;
> >      } else {
> >          cpu_abort(cs, "Unhandled exception 0x%x\n", cs->exception_index);
> >      }
> > diff --git a/target/openrisc/sys_helper.c b/target/openrisc/sys_helper.c
> > index 60c3193656..6ba816249b 100644
> > --- a/target/openrisc/sys_helper.c
> > +++ b/target/openrisc/sys_helper.c
> > @@ -39,6 +39,10 @@ void HELPER(mtspr)(CPUOpenRISCState *env,
> >          env->vr = rb;
> >          break;
> >
> > +    case TO_SPR(0, 11): /* EVBAR */
> > +        env->evbar = rb;
> > +        break;
> > +
> >      case TO_SPR(0, 16): /* NPC */
> >          cpu_restore_state(cs, GETPC());
> >          /* ??? Mirror or1ksim in not trashing delayed branch state
> > @@ -206,6 +210,9 @@ target_ulong HELPER(mfspr)(CPUOpenRISCState *env,
> >      case TO_SPR(0, 4): /* IMMUCFGR */
> >          return env->immucfgr;
> >
> > +    case TO_SPR(0, 11): /* EVBAR */
> > +        return env->evbar;
> > +
> >      case TO_SPR(0, 16): /* NPC (equals PC) */
> >          cpu_restore_state(cs, GETPC());
> >          return env->pc;
> 
> Reviewed-by: Stafford Horne <shorne@gmail.com>
> 
> I will pull into my branch and send PR as is unless someone has more to
> say.
> 
> -Stafford
> 
> > --
> > 2.12.1
> >
