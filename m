Received: from eggs.gnu.org ([2001:4830:134:3::10]:49555)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dQi1n-0004TH-Vp
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 18:35:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dQi1k-0000UZ-Q8
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 18:35:12 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:45277)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dQi1k-0000Sj-BG
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 18:35:08 -0400
Date: Thu, 29 Jun 2017 18:35:05 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20170629223505.GD9797@flamenco>
References: <149873841036.9180.16600465902334229930.stgit@frigg.lan>
	<149873937840.9180.2571251407615859104.stgit@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <149873937840.9180.2571251407615859104.stgit@frigg.lan>
Subject: Re: [Qemu-devel] [PATCH v10 4/7] exec: [tcg] Use different TBs
 according to the vCPU's dynamic tracing state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Llu=EDs?= Vilanova <vilanova@ac.upc.edu>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>

On Thu, Jun 29, 2017 at 15:29:38 +0300, Lluís Vilanova wrote:
> Every vCPU now uses a separate set of TBs for each set of dynamic
> tracing event state values. Each set of TBs can be used by any number of
> vCPUs to maximize TB reuse when vCPUs have the same tracing state.
> 
> This feature is later used by tracetool to optimize tracing of guest
> code events.
(snip)
> diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
> index 03820e3aeb..71badaaa6b 100644
> --- a/accel/tcg/translate-all.c
> +++ b/accel/tcg/translate-all.c
(snip)
> @@ -112,6 +113,11 @@ typedef struct PageDesc {
>  #define V_L2_BITS 10
>  #define V_L2_SIZE (1 << V_L2_BITS)
>  
> +/* Make sure all possible CPU event bits fit in tb->trace_ds */
> +QEMU_BUILD_BUG_ON(CPU_TRACE_DSTATE_MAX_EVENTS >
> +                  sizeof(((TranslationBlock *)0)->trace_vcpu_dstate)
> +                  * BITS_PER_BYTE);

The above comment still uses tb->trace_ds instead of tb->trace_vcpu_dstate.

FWIW I still prefer the much shorter trace_ds field name =)

(snip)
> diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
> index b0281b000f..d918410944 100644
> --- a/include/exec/exec-all.h
> +++ b/include/exec/exec-all.h
> @@ -310,6 +310,10 @@ static inline void tlb_flush_by_mmuidx_all_cpus_synced(CPUState *cpu,
>  #define USE_DIRECT_JUMP
>  #endif
>  
> +/**
> + * TranslationBlock:
> + * @trace_vcpu_dstate: Per-vCPU dynamic tracing state used to generate this TB.
> + */
>  struct TranslationBlock {
>      target_ulong pc;   /* simulated PC corresponding to this block (EIP + CS base) */
>      target_ulong cs_base; /* CS base for this block */
> @@ -324,6 +328,8 @@ struct TranslationBlock {
>  #define CF_USE_ICOUNT  0x20000
>  #define CF_IGNORE_ICOUNT 0x40000 /* Do not generate icount code */
>  
> +    uint32_t trace_vcpu_dstate;
> +
>      uint16_t invalid;

I'd just add the comment above the field, instead of partially
kernel-doc'ing the struct.

(snip)
> diff --git a/trace/control-target.c b/trace/control-target.c
> index d30fa5df75..bc4308021a 100644
> --- a/trace/control-target.c
> +++ b/trace/control-target.c
> @@ -62,6 +62,7 @@ static void trace_event_synchronize_vcpu_state_dynamic(
>  {
>      bitmap_copy(vcpu->trace_dstate, vcpu->trace_dstate_delayed,
>                  CPU_TRACE_DSTATE_MAX_EVENTS);
> +    tb_flush_jmp_cache_all(vcpu);

Remember to update this as I mentioned re: patch 1.

Other than that,
Reviewed-by: Emilio G. Cota <cota@braap.org>

		E.
