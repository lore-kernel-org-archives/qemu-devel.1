Received: from eggs.gnu.org ([2001:4830:134:3::10]:56009)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dUItr-0002yT-Jq
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 16:33:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dUIto-0000AF-G3
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 16:33:51 -0400
Received: from mail-pf0-x233.google.com ([2607:f8b0:400e:c00::233]:35610)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dUIto-0000A7-9k
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 16:33:48 -0400
Received: by mail-pf0-x233.google.com with SMTP id c73so39744667pfk.2
	for <qemu-devel@nongnu.org>; Sun, 09 Jul 2017 13:33:48 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1499586614-20507-1-git-send-email-cota@braap.org>
	<1499586614-20507-12-git-send-email-cota@braap.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <5c33bb26-0f55-3362-525b-bed041e163b9@twiddle.net>
Date: Sun, 9 Jul 2017 10:33:41 -1000
MIME-Version: 1.0
In-Reply-To: <1499586614-20507-12-git-send-email-cota@braap.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 11/22] translate-all: use a binary search
 tree to track TBs in TBContext
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org

On 07/08/2017 09:50 PM, Emilio G. Cota wrote:
> In order to use glib's binary search tree we embed a helper struct
> in TranslationBlock to allow us to compare tb's based on their
> tc_ptr as well as their tc_size fields.

Using an anon struct really doesn't help.  You're effectively using two 
different structs when you pass them in.  It "works" simply because in both 
cases we happen to know that a given pointer is followed by a uint32_t.

But with that in mind, and knowing that qemu builds with -fno-strict-aliasing, 
you could just as well *not* use the anon struct and address the pointer and 
the uint32_t within the un-partitioned TranslationBlock.  With appropriate 
comments in both places, of course.

> +    /*
> +     * When both sizes are set, we know this isn't a lookup and therefore
> +     * the two buffers are non-overlapping: a pointer comparison will do.
> +     * This is the most likely case: every TB must be inserted; lookups
> +     * are a lot less frequent.
> +     */
> +    if (likely(a->size && b->size)) {
> +        return a->ptr - b->ptr;
> +    }

sizeof(gint) < sizeof(ptrdiff_t) on 64-bit hosts.  You wouldn't have seen a 
problem on x86_64 because of MAX_CODE_GEN_BUFFER_SIZE.  I think it would be 
better to reduce this to -1/0/1.

>  static void do_tb_flush(CPUState *cpu, run_on_cpu_data tb_flush_count)
>  {
> +    int nb_tbs __attribute__((unused));
> +
>      tb_lock();
>  
>      /* If it is already been done on request of another CPU,
> @@ -894,11 +913,12 @@ static void do_tb_flush(CPUState *cpu, run_on_cpu_data tb_flush_count)
>      }
>  
>  #if defined(DEBUG_TB_FLUSH)
> +    nb_tbs = g_tree_nnodes(tcg_ctx.tb_ctx.tb_tree);
>      printf("qemu: flush code_size=%ld nb_tbs=%d avg_tb_size=%ld\n",
>             (unsigned long)(tcg_ctx.code_gen_ptr - tcg_ctx.code_gen_buffer),
> -           tcg_ctx.tb_ctx.nb_tbs, tcg_ctx.tb_ctx.nb_tbs > 0 ?
> +           nb_tbs, nb_tbs > 0 ?
>             ((unsigned long)(tcg_ctx.code_gen_ptr - tcg_ctx.code_gen_buffer)) /
> -           tcg_ctx.tb_ctx.nb_tbs : 0);
> +           nb_tbs : 0);
>  #endif

Variable declaration within braces within the ifdef.  Better as size_t or 
unsigned long.  Using int to count thing on 64-bit hosts always seems like a bug.


r~
