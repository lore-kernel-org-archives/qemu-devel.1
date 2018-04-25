Received: from eggs.gnu.org ([2001:4830:134:3::10]:50041)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fBEAE-0007vg-Gw
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 02:44:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fBEAA-0001Qp-St
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 02:44:26 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180424214550.32549-1-lersek@redhat.com>
	<20180424214550.32549-3-lersek@redhat.com>
Date: Wed, 25 Apr 2018 08:44:15 +0200
In-Reply-To: <20180424214550.32549-3-lersek@redhat.com> (Laszlo Ersek's
	message of "Tue, 24 Apr 2018 23:45:46 +0200")
Message-ID: <87muxraips.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 2/6] qapi: handle the riscv CpuInfoArch in
 query-cpus-fast
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: qemu-devel@nongnu.org, Riku Voipio <riku.voipio@iki.fi>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, qemu-stable@nongnu.org, Palmer Dabbelt <palmer@sifive.com>, Laurent Vivier <laurent@vivier.eu>, Michael Clark <mjc@sifive.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Luiz Capitulino <lcapitulino@redhat.com>, Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>

Laszlo Ersek <lersek@redhat.com> writes:

> Commit 25fa194b7b11 added the @riscv enum constant to @CpuInfoArch (used
> in both @CpuInfo and @CpuInfoFast -- the return types of the @query-cpus
> and @query-cpus-fast commands, respectively), and assigned, in both return
> structures, the @CpuInfoRISCV sub-structure to the new enum value.
>
> However, qmp_query_cpus_fast() would not populate either the @arch field
> or the @CpuInfoRISCV sub-structure, when TARGET_RISCV was defined; only
> qmp_query_cpus() would.
>
> In theory, there are two ways to fix this:
>
> (a) Fill in both the @arch field and the @CpuInfoRISCV sub-structure in
>     qmp_query_cpus_fast(), by copying the logic from qmp_query_cpus().
>
> (b) Assign @CpuInfoOther to the @riscv enum constant in @CpuInfoFast, and
>     populate only the @arch field in qmp_query_cpus_fast().
>
> Approach (b) seems more robust, because:
>
> - clearly there has never been an attempt to get actual RISV CPU state
>   from qmp_query_cpus_fast(), so its lack of RISCV support is not actually
>   a problem,
>
> - getting CPU state without interrupting KVM looks like an exceptional
>   thing to do (only S390X does it currently).
>
> Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> Cc: Eric Blake <eblake@redhat.com>
> Cc: Laurent Vivier <laurent@vivier.eu>
> Cc: Markus Armbruster <armbru@redhat.com>
> Cc: Michael Clark <mjc@sifive.com>
> Cc: Palmer Dabbelt <palmer@sifive.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Peter Crosthwaite <crosthwaite.peter@gmail.com>
> Cc: Richard Henderson <rth@twiddle.net>
> Cc: Riku Voipio <riku.voipio@iki.fi>
> Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
> Cc: qemu-stable@nongnu.org
> Fixes: 25fa194b7b11901561532e435beb83d046899f7a
> Signed-off-by: Laszlo Ersek <lersek@redhat.com>
> ---
>
> Notes:
>     PATCHv1:
>     
>     - new patch
>
>  qapi/misc.json | 2 +-
>  cpus.c         | 2 ++
>  2 files changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/qapi/misc.json b/qapi/misc.json
> index 5636f4a14997..104d013adba6 100644
> --- a/qapi/misc.json
> +++ b/qapi/misc.json
> @@ -565,23 +565,23 @@
>  { 'union': 'CpuInfoFast',
>    'base': {'cpu-index': 'int', 'qom-path': 'str',
>             'thread-id': 'int', '*props': 'CpuInstanceProperties',
>             'arch': 'CpuInfoArch' },
>    'discriminator': 'arch',
>    'data': { 'x86': 'CpuInfoOther',
>              'sparc': 'CpuInfoOther',
>              'ppc': 'CpuInfoOther',
>              'mips': 'CpuInfoOther',
>              'tricore': 'CpuInfoOther',
>              's390': 'CpuInfoS390',
> -            'riscv': 'CpuInfoRISCV',
> +            'riscv': 'CpuInfoOther',
>              'other': 'CpuInfoOther' } }

Why do CpuInfoFast's variants match CpuInfo's for s390, but not the
others?  Your commit message has an educated guess: "looks like an
exceptional thing to do (only S390X does it currently)".  But why guess
when we can ask authors of commit ce74ee3dea6?  Luiz and Victor, please
advise.

>  ##
>  # @query-cpus-fast:
>  #
>  # Returns information about all virtual CPUs. This command does not
>  # incur a performance penalty and should be used in production
>  # instead of query-cpus.
>  #
>  # Returns: list of @CpuInfoFast
>  #
> diff --git a/cpus.c b/cpus.c
> index 1a9a2edee1f2..60563a6d54ec 100644
> --- a/cpus.c
> +++ b/cpus.c
> @@ -2225,22 +2225,24 @@ CpuInfoFastList *qmp_query_cpus_fast(Error **errp)
>  #elif defined(TARGET_SPARC)
>          info->value->arch = CPU_INFO_ARCH_SPARC;
>  #elif defined(TARGET_MIPS)
>          info->value->arch = CPU_INFO_ARCH_MIPS;
>  #elif defined(TARGET_TRICORE)
>          info->value->arch = CPU_INFO_ARCH_TRICORE;
>  #elif defined(TARGET_S390X)
>          s390_cpu = S390_CPU(cpu);
>          env = &s390_cpu->env;
>          info->value->arch = CPU_INFO_ARCH_S390;
>          info->value->u.s390.cpu_state = env->cpu_state;
> +#elif defined(TARGET_RISCV)
> +        info->value->arch = CPU_INFO_ARCH_RISCV;
>  #else
>          info->value->arch = CPU_INFO_ARCH_OTHER;
>  #endif
>          if (!cur_item) {
>              head = cur_item = info;
>          } else {
>              cur_item->next = info;
>              cur_item = info;
>          }
>      }
