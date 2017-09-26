Received: from eggs.gnu.org ([2001:4830:134:3::10]:50549)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dwrgE-00074c-Lq
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 11:21:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dwrgD-0000FB-Kj
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 11:21:50 -0400
Sender: Richard Henderson <rth7680@gmail.com>
References: <cover.1506384414.git.alistair.francis@xilinx.com>
	<5ad72536402da2879d49b58753cc709a8ff22de9.1506384415.git.alistair.francis@xilinx.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <d591fe76-6305-e082-3dc3-b53178c0ee5d@twiddle.net>
Date: Tue, 26 Sep 2017 08:21:24 -0700
MIME-Version: 1.0
In-Reply-To: <5ad72536402da2879d49b58753cc709a8ff22de9.1506384415.git.alistair.francis@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 8/8] target: Replace fprintf(stderr,
 "*\n" with error_report()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, qemu-devel@nongnu.org
Cc: alistair23@gmail.com, armbru@redhat.com, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Michael Walle <michael@walle.cc>, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@imgtec.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org

On 09/25/2017 05:09 PM, Alistair Francis wrote:
> diff --git a/target/cris/translate.c b/target/cris/translate.c
> index 38a999e6f1..8847005984 100644
> --- a/target/cris/translate.c
> +++ b/target/cris/translate.c
> @@ -138,7 +138,7 @@ typedef struct DisasContext {
>  
>  static void gen_BUG(DisasContext *dc, const char *file, int line)
>  {
> -    fprintf(stderr, "BUG: pc=%x %s %d\n", dc->pc, file, line);
> +    error_report("BUG: pc=%x %s %d", dc->pc, file, line);
>      if (qemu_log_separate()) {
>          qemu_log("BUG: pc=%x %s %d\n", dc->pc, file, line);
>      }

Eh, no, this should simply use qemu_log.

> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index 606b605ba0..a3da22580e 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -3943,8 +3943,8 @@ static inline void gen_op_mfspr(DisasContext *ctx)
>               * allowing userland application to read the PVR
>               */
>              if (sprn != SPR_PVR) {
> -                fprintf(stderr, "Trying to read privileged spr %d (0x%03x) at "
> -                        TARGET_FMT_lx "\n", sprn, sprn, ctx->nip - 4);
> +                error_report("Trying to read privileged spr %d (0x%03x) at "
> +                        TARGET_FMT_lx "", sprn, sprn, ctx->nip - 4);
>                  if (qemu_log_separate()) {
>                      qemu_log("Trying to read privileged spr %d (0x%03x) at "
>                               TARGET_FMT_lx "\n", sprn, sprn, ctx->nip - 4);

Likewise.  And all the others.
Perhaps we should kill qemu_log_separate as a bad idea?

> diff --git a/target/sh4/translate.c b/target/sh4/translate.c
> index 10191073b2..9f95410e53 100644
> --- a/target/sh4/translate.c
> +++ b/target/sh4/translate.c
> @@ -438,7 +438,7 @@ static void _decode_opc(DisasContext * ctx)
>  	}
>  
>  #if 0
> -    fprintf(stderr, "Translating opcode 0x%04x\n", ctx->opcode);
> +    error_report("Translating opcode 0x%04x", ctx->opcode);
>  #endif

qemu_log.

>  
>      switch (ctx->opcode) {
> @@ -1799,7 +1799,7 @@ static void _decode_opc(DisasContext * ctx)
>          break;
>      }
>  #if 0
> -    fprintf(stderr, "unknown instruction 0x%04x at pc 0x%08x\n",
> +    error_report("unknown instruction 0x%04x at pc 0x%08x",
>  	    ctx->opcode, ctx->pc);
>      fflush(stderr);
>  #endif

qemu_log_mask(LOG_UNIMP, ...)

> @@ -1940,7 +1940,7 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
>          disas_uc32_insn(env, dc);
>  
>          if (num_temps) {
> -            fprintf(stderr, "Internal resource leak before %08x\n", dc->pc);
> +            error_report("Internal resource leak before %08x", dc->pc);
>              num_temps = 0;
>          }
>  
> 

qemu_log.


r~
