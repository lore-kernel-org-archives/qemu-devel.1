Received: from eggs.gnu.org ([209.51.188.92]:59555)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1hJmAk-0002Do-1n
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 17:44:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1hJmAi-00075n-9X
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 17:44:49 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:40474)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@sifive.com>) id 1hJmAh-00074f-Sf
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 17:44:48 -0400
Received: by mail-pg1-x541.google.com with SMTP id d31so492682pgl.7
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 14:44:47 -0700 (PDT)
Date: Thu, 25 Apr 2019 14:44:45 -0700 (PDT)
In-Reply-To: <CAKmqyKOZ2Dfhk1HgnJqG1hSHHSpm0bpuE-MK8A0aHNjmcT9=ug@mail.gmail.com>
From: Palmer Dabbelt <palmer@sifive.com>
Message-ID: <mhng-54197190-bad4-4193-8ccc-f07679f414ef@palmer-si-x1e>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] target/riscv: Expose time CSRs when
 allowed by [m|s]counteren
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: alistair23@gmail.com
Cc: fintelia@gmail.com, qemu-devel@nongnu.org, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Alistair Francis <Alistair.Francis@wdc.com>, qemu-riscv@nongnu.org, sagark@eecs.berkeley.edu

On Fri, 19 Apr 2019 16:05:35 PDT (-0700), alistair23@gmail.com wrote:
> On Mon, Apr 15, 2019 at 5:46 PM Jonathan Behrens <fintelia@gmail.com> wrote:
>>
>> For any chip that has a CLINT, we want the frequency of the time register and the frequency of the CLINT to match. That frequency, SIFIVE_CLINT_TIMEBASE_FREQ (=10MHz) is currently defined in hw/riscv/sifive_clint.h and so isn't visible to target/riscv/cpu.c where the CPURISCVState is first created. Instead, I first initialize the frequency to a reasonable default (1GHz) and then let the CLINT override the value if one is attached. Phrased differently, the values produced by the `sifive_clint.c: cpu_riscv_read_rtc()` and `csr.c: read_time()` must match, and this is one way of doing that.
>
> Ah that seems fine. Can you add a comment in the code to indicate that
> it will be overwritten later?

I don't see a v2, did I miss something?

>
> Alistair
>
>>
>> I'd be open to other suggestions.
>>
>> Jonathan
>>
>> On Mon, Apr 15, 2019 at 8:23 PM Alistair Francis <alistair23@gmail.com> wrote:
>>>
>>> On Fri, Apr 12, 2019 at 12:04 PM Jonathan Behrens <fintelia@gmail.com> wrote:
>>> >
>>> > Currently mcounteren.TM acts as though it is hardwired to zero, even though
>>> > QEMU
>>> > allows it to be set. This change resolves the issue by allowing reads to the
>>> > time and timeh control registers when running in a privileged mode where
>>> > such
>>> > accesses are allowed.
>>> >
>>> > Signed-off-by: Jonathan Behrens <fintelia@gmail.com>
>>> > ---
>>> >  hw/riscv/sifive_clint.c |  1 +
>>> >  target/riscv/cpu.c      | 14 ++++++++++++++
>>> >  target/riscv/cpu.h      |  2 ++
>>> >  target/riscv/csr.c      | 17 +++++++++++------
>>> >  4 files changed, 28 insertions(+), 6 deletions(-)
>>> >
>>> > diff --git a/hw/riscv/sifive_clint.c b/hw/riscv/sifive_clint.c
>>> > index d4c159e937..3ad4fe6139 100644
>>> > --- a/hw/riscv/sifive_clint.c
>>> > +++ b/hw/riscv/sifive_clint.c
>>> > @@ -237,6 +237,7 @@ DeviceState *sifive_clint_create(hwaddr addr, hwaddr
>>> > size, uint32_t num_harts,
>>> >          env->timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
>>> >                                    &sifive_clint_timer_cb, cpu);
>>> >          env->timecmp = 0;
>>> > +        env->time_freq = SIFIVE_CLINT_TIMEBASE_FREQ;
>>>
>>> Why do you need to set this here?
>>>
>>> Alistair
>>>
>>> >      }
>>> >
>>> >      DeviceState *dev = qdev_create(NULL, TYPE_SIFIVE_CLINT);
>>> > diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
>>> > index d61bce6d55..ff17d54691 100644
>>> > --- a/target/riscv/cpu.c
>>> > +++ b/target/riscv/cpu.c
>>> > @@ -103,12 +103,20 @@ static void set_resetvec(CPURISCVState *env, int
>>> > resetvec)
>>> >  #endif
>>> >  }
>>> >
>>> > +static void set_time_freq(CPURISCVState *env, uint64_t freq)
>>> > +{
>>> > +#ifndef CONFIG_USER_ONLY
>>> > +    env->time_freq = freq;
>>> > +#endif
>>> > +}
>>> > +
>>> >  static void riscv_any_cpu_init(Object *obj)
>>> >  {
>>> >      CPURISCVState *env = &RISCV_CPU(obj)->env;
>>> >      set_misa(env, RVXLEN | RVI | RVM | RVA | RVF | RVD | RVC | RVU);
>>> >      set_versions(env, USER_VERSION_2_02_0, PRIV_VERSION_1_10_0);
>>> >      set_resetvec(env, DEFAULT_RSTVEC);
>>> > +    set_time_freq(env, NANOSECONDS_PER_SECOND);
>>> >  }
>>> >
>>> >  #if defined(TARGET_RISCV32)
>>> > @@ -121,6 +129,7 @@ static void rv32gcsu_priv1_09_1_cpu_init(Object *obj)
>>> >      set_resetvec(env, DEFAULT_RSTVEC);
>>> >      set_feature(env, RISCV_FEATURE_MMU);
>>> >      set_feature(env, RISCV_FEATURE_PMP);
>>> > +    set_time_freq(env, NANOSECONDS_PER_SECOND);
>>> >  }
>>> >
>>> >  static void rv32gcsu_priv1_10_0_cpu_init(Object *obj)
>>> > @@ -131,6 +140,7 @@ static void rv32gcsu_priv1_10_0_cpu_init(Object *obj)
>>> >      set_resetvec(env, DEFAULT_RSTVEC);
>>> >      set_feature(env, RISCV_FEATURE_MMU);
>>> >      set_feature(env, RISCV_FEATURE_PMP);
>>> > +    set_time_freq(env, NANOSECONDS_PER_SECOND);
>>> >  }
>>> >
>>> >  static void rv32imacu_nommu_cpu_init(Object *obj)
>>> > @@ -140,6 +150,7 @@ static void rv32imacu_nommu_cpu_init(Object *obj)
>>> >      set_versions(env, USER_VERSION_2_02_0, PRIV_VERSION_1_10_0);
>>> >      set_resetvec(env, DEFAULT_RSTVEC);
>>> >      set_feature(env, RISCV_FEATURE_PMP);
>>> > +    set_time_freq(env, NANOSECONDS_PER_SECOND);
>>> >  }
>>> >
>>> >  #elif defined(TARGET_RISCV64)
>>> > @@ -152,6 +163,7 @@ static void rv64gcsu_priv1_09_1_cpu_init(Object *obj)
>>> >      set_resetvec(env, DEFAULT_RSTVEC);
>>> >      set_feature(env, RISCV_FEATURE_MMU);
>>> >      set_feature(env, RISCV_FEATURE_PMP);
>>> > +    set_time_freq(env, NANOSECONDS_PER_SECOND);
>>> >  }
>>> >
>>> >  static void rv64gcsu_priv1_10_0_cpu_init(Object *obj)
>>> > @@ -162,6 +174,7 @@ static void rv64gcsu_priv1_10_0_cpu_init(Object *obj)
>>> >      set_resetvec(env, DEFAULT_RSTVEC);
>>> >      set_feature(env, RISCV_FEATURE_MMU);
>>> >      set_feature(env, RISCV_FEATURE_PMP);
>>> > +    set_time_freq(env, NANOSECONDS_PER_SECOND);
>>> >  }
>>> >
>>> >  static void rv64imacu_nommu_cpu_init(Object *obj)
>>> > @@ -171,6 +184,7 @@ static void rv64imacu_nommu_cpu_init(Object *obj)
>>> >      set_versions(env, USER_VERSION_2_02_0, PRIV_VERSION_1_10_0);
>>> >      set_resetvec(env, DEFAULT_RSTVEC);
>>> >      set_feature(env, RISCV_FEATURE_PMP);
>>> > +    set_time_freq(env, NANOSECONDS_PER_SECOND);
>>> >  }
>>> >
>>> >  #endif
>>> > diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
>>> > index 20bce8742e..67b1769ad3 100644
>>> > --- a/target/riscv/cpu.h
>>> > +++ b/target/riscv/cpu.h
>>> > @@ -173,7 +173,9 @@ struct CPURISCVState {
>>> >      /* temporary htif regs */
>>> >      uint64_t mfromhost;
>>> >      uint64_t mtohost;
>>> > +
>>> >      uint64_t timecmp;
>>> > +    uint64_t time_freq;
>>> >
>>> >      /* physical memory protection */
>>> >      pmp_table_t pmp_state;
>>> > diff --git a/target/riscv/csr.c b/target/riscv/csr.c
>>> > index e1d91b6c60..6083c782a1 100644
>>> > --- a/target/riscv/csr.c
>>> > +++ b/target/riscv/csr.c
>>> > @@ -191,22 +191,31 @@ static int read_instreth(CPURISCVState *env, int
>>> > csrno, target_ulong *val)
>>> >  }
>>> >  #endif /* TARGET_RISCV32 */
>>> >
>>> > -#if defined(CONFIG_USER_ONLY)
>>> >  static int read_time(CPURISCVState *env, int csrno, target_ulong *val)
>>> >  {
>>> > +#if !defined(CONFIG_USER_ONLY)
>>> > +    *val = muldiv64(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL),
>>> > +                    env->time_freq, NANOSECONDS_PER_SECOND);
>>> > +#else
>>> >      *val = cpu_get_host_ticks();
>>> > +#endif
>>> >      return 0;
>>> >  }
>>> >
>>> >  #if defined(TARGET_RISCV32)
>>> >  static int read_timeh(CPURISCVState *env, int csrno, target_ulong *val)
>>> >  {
>>> > +#if !defined(CONFIG_USER_ONLY)
>>> > +    *val = muldiv64(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL),
>>> > +                    env->time_freq, NANOSECONDS_PER_SECOND) >> 32;
>>> > +#else
>>> >      *val = cpu_get_host_ticks() >> 32;
>>> > +#endif
>>> >      return 0;
>>> >  }
>>> >  #endif
>>> >
>>> > -#else /* CONFIG_USER_ONLY */
>>> > +#if !defined(CONFIG_USER_ONLY)
>>> >
>>> >  /* Machine constants */
>>> >
>>> > @@ -854,14 +863,10 @@ static riscv_csr_operations csr_ops[CSR_TABLE_SIZE] =
>>> > {
>>> >      [CSR_INSTRETH] =            { ctr,
>>> > read_instreth                       },
>>> >  #endif
>>> >
>>> > -    /* User-level time CSRs are only available in linux-user
>>> > -     * In privileged mode, the monitor emulates these CSRs */
>>> > -#if defined(CONFIG_USER_ONLY)
>>> >      [CSR_TIME] =                { ctr,
>>> > read_time                           },
>>> >  #if defined(TARGET_RISCV32)
>>> >      [CSR_TIMEH] =               { ctr,
>>> > read_timeh                          },
>>> >  #endif
>>> > -#endif
>>> >
>>> >  #if !defined(CONFIG_USER_ONLY)
>>> >      /* Machine Timers and Counters */
>>> > --
>>> > 2.20.1
