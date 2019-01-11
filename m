Received: from eggs.gnu.org ([209.51.188.92]:56650)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.m.mail@gmail.com>) id 1ghwFZ-0007bN-JB
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 07:49:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.m.mail@gmail.com>) id 1ghwFW-0008BB-Eb
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 07:49:25 -0500
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9xd-MJ7QHgYCyh0D+x_ooXYDCnKYTXELoxz3LbYO4SJw@mail.gmail.com>
References: <20190108163008.7006-1-peter.maydell@linaro.org>
	<20190108163008.7006-4-peter.maydell@linaro.org>
	<CAFEAcA9xd-MJ7QHgYCyh0D+x_ooXYDCnKYTXELoxz3LbYO4SJw@mail.gmail.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Fri, 11 Jan 2019 13:49:15 +0100
Message-ID: <CAL1e-=gKA9dnfgcJ2QuvbWxjgHya1DfUz4VPRxqakyDVKzH1SA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] [PATCH 3/4] accel/tcg: Add cluster number to TCG TB
 hash
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Alistair Francis <alistair@alistair23.me>, Richard Henderson <richard.henderson@linaro.org>, "Emilio G . Cota" <cota@braap.org>, "patches@linaro.org" <patches@linaro.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>

Hello, Peter.

First of all, I want to tell you that I support this series and I salute
efforts in this and related areas. It is known that there have been strong
trends towards asymmetric multi-core systems now for some longish time -
and that QEMU support in that area will greately enhance QEMU itself.

However, being unfamilliar with relevant parts of QEMU internals, allow me
to ask a couple of basic questions:

1. What would be, in more detail, if possible in layman terms, the "bad
case" that this series fixes?

2. Let's suppose, hypothetically, and based on your example from one of
commit messages from this series, that we want to support two multicore
systems:
    A. Cluster 1: 1 core with FPU; cluster 2: 3 cores without FPU
    B. Cluster 1: 2 cores with FPU; cluster 2: 1 core without FPU
Is there an apparatus that would allow the end user specify these and
similar cpnfigurations through command line or acsimilar mean (so, without
QEMU explicitely supporting such core organization, but supporting the
single core in question, of course)? If not, would that be a desirable QEMU
feature?

3. Is there a possibility to have two layer clustering sheme, instead of
one layer? Cluster/subcluster/core instead of cluster/core? For MIPS, there
is a need for such organization. It looks to me 8 bits for cluster id, and
3 bits for subcluster id would be sufficient. In such scheme, the only
change for TCG would be to check both cluster and subcluster id rather than
only cluster id.

Regards,
Aleksandar


On Thursday, January 10, 2019, Peter Maydell <peter.maydell@linaro.org>
wrote:

> On Tue, 8 Jan 2019 at 16:30, Peter Maydell <peter.maydell@linaro.org>
> wrote:
> >
> > Include the cluster number in the hash we use to look
> > up TBs. This is important because a TB that is valid
> > for one cluster at a given physical address and set
> > of CPU flags is not necessarily valid for another:
> > the two clusters may have different views of physical
> > memory, or may have different CPU features (eg FPU
> > present or absent).
> >
> > We put the cluster number in the high 8 bits of the
> > TB cflags. This gives us up to 256 clusters, which should
> > be enough for anybody. If we ever need more, or need
> > more bits in cflags for other purposes, we could make
> > tb_hash_func() take more data (and expand qemu_xxhash7()
> > to qemu_xxhash8()).
> >
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> >  include/exec/exec-all.h   | 4 +++-
> >  accel/tcg/cpu-exec.c      | 4 ++++
> >  accel/tcg/translate-all.c | 3 +++
> >  3 files changed, 10 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
> > index 815e5b1e838..aa7b81aaf01 100644
> > --- a/include/exec/exec-all.h
> > +++ b/include/exec/exec-all.h
> > @@ -351,9 +351,11 @@ struct TranslationBlock {
> >  #define CF_USE_ICOUNT  0x00020000
> >  #define CF_INVALID     0x00040000 /* TB is stale. Set with @jmp_lock
> held */
> >  #define CF_PARALLEL    0x00080000 /* Generate code for a parallel
> context */
> > +#define CF_CLUSTER_MASK 0xff000000 /* Top 8 bits are cluster ID */
> > +#define CF_CLUSTER_SHIFT 24
> >  /* cflags' mask for hashing/comparison */
> >  #define CF_HASH_MASK   \
> > -    (CF_COUNT_MASK | CF_LAST_IO | CF_USE_ICOUNT | CF_PARALLEL)
> > +    (CF_COUNT_MASK | CF_LAST_IO | CF_USE_ICOUNT | CF_PARALLEL |
> CF_CLUSTER_MASK)
> >
> >      /* Per-vCPU dynamic tracing state used to generate this TB */
> >      uint32_t trace_vcpu_dstate;
> > diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
> > index 870027d4359..e578a1a3aee 100644
> > --- a/accel/tcg/cpu-exec.c
> > +++ b/accel/tcg/cpu-exec.c
> > @@ -336,6 +336,10 @@ TranslationBlock *tb_htable_lookup(CPUState *cpu,
> target_ulong pc,
> >          return NULL;
> >      }
> >      desc.phys_page1 = phys_pc & TARGET_PAGE_MASK;
> > +
> > +    cf_mask &= ~CF_CLUSTER_MASK;
> > +    cf_mask |= cpu->cluster_index << CF_CLUSTER_SHIFT;
> > +
>
> This hunk turns out not to be quite right -- it needs to move
> to the top of the function, before the assignment
> "desc.flags = flags;". Otherwise tb_lookup_cmp() will
> spuriously fail, and execution becomes somewhat slower because
> we have to keep retranslating TBs rather than reusing them.
> (Surprisingly this is only noticeable in an ARM TFM image
> I happen to have, not in Linux kernel boot...)
>
> thanks
> -- PMM
>
>
