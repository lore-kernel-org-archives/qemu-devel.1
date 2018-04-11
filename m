Received: from eggs.gnu.org ([2001:4830:134:3::10]:37238)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1f67yM-0006VL-PY
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 01:07:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1f67yI-0000Rh-2a
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 01:07:06 -0400
References: <1523377186-32578-1-git-send-email-cota@braap.org>
	<1523377186-32578-10-git-send-email-cota@braap.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <699750ea-36a4-97d9-ac40-d7bc6edc8d7e@redhat.com>
Date: Wed, 11 Apr 2018 07:06:42 +0200
MIME-Version: 1.0
In-Reply-To: <1523377186-32578-10-git-send-email-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH 09/10] target/s390x: avoid
 integer overflow in next_page PC check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>, Richard Henderson <richard.henderson@linaro.org>, Alexander Graf <agraf@suse.de>, David Hildenbrand <david@redhat.com>

On 10.04.2018 18:19, Emilio G. Cota wrote:
> If the PC is in the last page of the address space, next_page_start
> overflows to 0. Fix it.
> 
> Cc: Cornelia Huck <cohuck@redhat.com>
> Cc: Alexander Graf <agraf@suse.de>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: qemu-s390x@nongnu.org
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  target/s390x/translate.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/target/s390x/translate.c b/target/s390x/translate.c
> index 7d39ab3..44449f1 100644
> --- a/target/s390x/translate.c
> +++ b/target/s390x/translate.c
> @@ -6163,7 +6163,7 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
>      CPUS390XState *env = cs->env_ptr;
>      DisasContext dc;
>      target_ulong pc_start;
> -    uint64_t next_page_start;
> +    uint64_t page_start;
>      int num_insns, max_insns;
>      ExitStatus status;
>      bool do_debug;
> @@ -6181,7 +6181,7 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
>      dc.ex_value = tb->cs_base;
>      do_debug = dc.singlestep_enabled = cs->singlestep_enabled;
>  
> -    next_page_start = (pc_start & TARGET_PAGE_MASK) + TARGET_PAGE_SIZE;
> +    page_start = pc_start & TARGET_PAGE_MASK;
>  
>      num_insns = 0;
>      max_insns = tb_cflags(tb) & CF_COUNT_MASK;
> @@ -6218,7 +6218,7 @@ void gen_intermediate_code(CPUState *cs, struct TranslationBlock *tb)
>          /* If we reach a page boundary, are single stepping,
>             or exhaust instruction count, stop generation.  */
>          if (status == NO_EXIT
> -            && (dc.pc >= next_page_start
> +            && (dc.pc - page_start >= TARGET_PAGE_SIZE
>                  || tcg_op_buf_full()
>                  || num_insns >= max_insns
>                  || singlestep
> 

Reviewed-by: Thomas Huth <thuth@redhat.com>
