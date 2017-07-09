Received: from eggs.gnu.org ([2001:4830:134:3::10]:39067)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dUJvq-0005UO-SL
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 17:39:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dUJvn-00051O-QC
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 17:39:58 -0400
Received: from mail-pg0-f45.google.com ([74.125.83.45]:36688)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dUJvn-00050y-JF
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 17:39:55 -0400
Received: by mail-pg0-f45.google.com with SMTP id u62so39551492pgb.3
	for <qemu-devel@nongnu.org>; Sun, 09 Jul 2017 14:39:55 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1499586614-20507-1-git-send-email-cota@braap.org>
	<1499586614-20507-23-git-send-email-cota@braap.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <5b3531bf-5e06-f5d3-6ba0-6a0baa810cee@twiddle.net>
Date: Sun, 9 Jul 2017 11:38:50 -1000
MIME-Version: 1.0
In-Reply-To: <1499586614-20507-23-git-send-email-cota@braap.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 22/22] translate-all: do not hold tb_lock
 during code generation in softmmu
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
> +    if (!have_tb_lock) {
> +        TranslationBlock *t;
> +
> +        tb_lock();
> +        /*
> +         * There's a chance that our desired tb has been translated while
> +         * we were translating it.
> +         */
> +        t = tb_htable_lookup(cpu, pc, cs_base, flags);
> +        if (unlikely(t)) {
> +            /* discard what we just translated */
> +            uintptr_t orig_aligned = (uintptr_t)gen_code_buf;
> +
> +            orig_aligned -= ROUND_UP(sizeof(*tb), qemu_icache_linesize);
> +            atomic_set(&tcg_ctx.code_gen_ptr, orig_aligned);
> +            return t;
> +        }
> +    }
>       /* As long as consistency of the TB stuff is provided by tb_lock in user
>        * mode and is implicit in single-threaded softmmu emulation, no explicit
>        * memory barrier is required before tb_link_page() makes the TB visible

I think it would be better to have a tb_htable_lookup_or_insert function, which 
performs the insert iff a matching object isn't already there, returning the 
entry which *is* there in either case.

The hash table already has per-bucket locking.  So here you're taking 3 locks 
(tb_lock, bucket lock for lookup, bucket lock for insert) instead of just 
taking the bucket lock once.  And, recall, the htable is designed such that the 
buckets do not contend often, so you ought to be eliminating most of the 
contention that you're seeing on tb_lock.

It might also be helpful to merge tb_link_page into its one caller in order to 
make the locking issues within that subroutine less muddled.

Anyway, you'd wind up with

   TranslationBlock *ret;

   ret = tb_htable_lookup_or_insert(arguments);
   if (unlikely(ret != tb)) {
      /* discard what we just translated */
   }

   return ret;


r~
