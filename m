Received: from eggs.gnu.org ([209.51.188.92]:39928)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hsp.cat7@gmail.com>) id 1gr4J5-0001Jk-3u
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 12:14:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hsp.cat7@gmail.com>) id 1gr4It-0003pZ-V4
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 12:14:39 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:44678)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <hsp.cat7@gmail.com>) id 1gr4Io-0003nk-Rb
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 12:14:31 -0500
Received: by mail-ot1-x342.google.com with SMTP id g16so6911460otg.11
	for <qemu-devel@nongnu.org>; Tue, 05 Feb 2019 09:14:29 -0800 (PST)
MIME-Version: 1.0
References: <20190205151810.571-1-peter.maydell@linaro.org>
	<dda9f210-6f40-ad6e-f309-665856bf54f6@ilande.co.uk>
In-Reply-To: <dda9f210-6f40-ad6e-f309-665856bf54f6@ilande.co.uk>
From: Howard Spoelstra <hsp.cat7@gmail.com>
Date: Tue, 5 Feb 2019 18:14:17 +0100
Message-ID: <CABLmASGDKTf87d2RRcyC=-cU-Ri12sgOmkmUmV5=cGU3pbXfzA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] accel/tcg: Consider cluster index in
 tb_lookup__cpu_state()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel qemu-devel <qemu-devel@nongnu.org>, patches@linaro.org, Richard Henderson <richard.henderson@linaro.org>, "Emilio G . Cota" <cota@braap.org>, Cleber Rosa <crosa@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>

On Tue, Feb 5, 2019 at 6:09 PM Mark Cave-Ayland <
mark.cave-ayland@ilande.co.uk> wrote:

> On 05/02/2019 15:18, Peter Maydell wrote:
>
> > In commit f7b78602fdc6c6e4be we added the CPU cluster number to the
> > cflags field of the TB hash; this included adding it to the value
> > kept in tb->cflags, since we pass that field directly into the hash
> > calculation in some places. Unfortunately we forgot to check whether
> > other parts of the code were doing comparisons against tb->cflags
> > that would need to be updated.
> >
> > It turns out that there is exactly one such place: the
> > tb_lookup__cpu_state() function checks whether the TB it has
> > found in the tb_jmp_cache has a tb->cflags matching the cf_mask
> > that is passed in. The tb->cflags has the cluster_index in it
> > but the cf_mask does not.
> >
> > Hoist the "add cluster index to the cf_mask" code up from
> > tb_htable_lookup() to tb_lookup__cpu_state() so it can be considered
> > in the "did this TB match in the jmp cache" condition, as well as
> > when we do the full hash lookup by physical PC, flags, etc.
> > (tb_htable_lookup() is only called from tb_lookup__cpu_state(),
> > so this change doesn't require any further knock-on changes.)
> >
> > Fixes: f7b78602fdc6c6e4be ("accel/tcg: Add cluster number to TCG TB
> hash")
> > Reported-by: Howard Spoelstra <hsp.cat7@gmail.com>
> > Reported-by: Cleber Rosa <crosa@redhat.com>
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> > Does anybody know why tb_lookup__cpu_state() has that odd
> > double-underscore in the middle of its name?
> >
> > Since the jmp_cache is per-vcpu we know that we're always going
> > to match on the cluster_index, so the other option would be to
> > leave the cluster_index bits out of the comparison, and leave the
> > "fold in cluster index to cf_mask" code in tb_htable_lookup().
> > Or we could require the callers of tb_lookup__cpu_state() to all
> > provide the cluster index, but that's more places to change,
> > so I prefer this.
> > ---
> >  include/exec/tb-lookup.h | 4 ++++
> >  accel/tcg/cpu-exec.c     | 3 ---
> >  2 files changed, 4 insertions(+), 3 deletions(-)
> >
> > diff --git a/include/exec/tb-lookup.h b/include/exec/tb-lookup.h
> > index 492cb682894..26921b6dafd 100644
> > --- a/include/exec/tb-lookup.h
> > +++ b/include/exec/tb-lookup.h
> > @@ -28,6 +28,10 @@ tb_lookup__cpu_state(CPUState *cpu, target_ulong *pc,
> target_ulong *cs_base,
> >      cpu_get_tb_cpu_state(env, pc, cs_base, flags);
> >      hash = tb_jmp_cache_hash_func(*pc);
> >      tb = atomic_rcu_read(&cpu->tb_jmp_cache[hash]);
> > +
> > +    cf_mask &= ~CF_CLUSTER_MASK;
> > +    cf_mask |= cpu->cluster_index << CF_CLUSTER_SHIFT;
> > +
> >      if (likely(tb &&
> >                 tb->pc == *pc &&
> >                 tb->cs_base == *cs_base &&
> > diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
> > index 7cf1292546f..60d87d5a19b 100644
> > --- a/accel/tcg/cpu-exec.c
> > +++ b/accel/tcg/cpu-exec.c
> > @@ -325,9 +325,6 @@ TranslationBlock *tb_htable_lookup(CPUState *cpu,
> target_ulong pc,
> >      struct tb_desc desc;
> >      uint32_t h;
> >
> > -    cf_mask &= ~CF_CLUSTER_MASK;
> > -    cf_mask |= cpu->cluster_index << CF_CLUSTER_SHIFT;
> > -
> >      desc.env = (CPUArchState *)cpu->env_ptr;
> >      desc.cs_base = cs_base;
> >      desc.flags = flags;
> >
>
>
Confirmed, both Mac OS 9.2 and OS X 10.4 running with qemu-system-ppc are
back to their old performance levels.

Best, and thanks,
Howard
