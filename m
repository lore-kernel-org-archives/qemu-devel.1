Received: from eggs.gnu.org ([2001:4830:134:3::10]:33422)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dUJMv-0001cg-Tq
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 17:03:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dUJMs-0005D4-Qw
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 17:03:53 -0400
Received: from mail-pg0-x22d.google.com ([2607:f8b0:400e:c05::22d]:35069)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dUJMs-0005Cr-Kv
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 17:03:50 -0400
Received: by mail-pg0-x22d.google.com with SMTP id j186so39393254pge.2
	for <qemu-devel@nongnu.org>; Sun, 09 Jul 2017 14:03:50 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1499586614-20507-1-git-send-email-cota@braap.org>
	<1499586614-20507-21-git-send-email-cota@braap.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <cc1ab7e3-518d-a4a0-8f22-93513e7ea006@twiddle.net>
Date: Sun, 9 Jul 2017 11:03:45 -1000
MIME-Version: 1.0
In-Reply-To: <1499586614-20507-21-git-send-email-cota@braap.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 20/22] tcg: dynamically allocate from
 code_gen_buffer using equally-sized regions
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
> +static void code_gen_set_region_size(TCGContext *s)
> +{
> +    size_t per_cpu = s->code_gen_buffer_size / smp_cpus;
> +    size_t div;
> +
> +    assert(per_cpu);
> +    /*
> +     * Use a single region if all we have is one vCPU.
> +     * We could also use a single region with !mttcg, but at this time we have
> +     * not yet processed the thread=single|multi flag.
> +     */
> +    if (smp_cpus == 1) {
> +        tcg_region_set_size(0);
> +        return;
> +    }
> +
> +    for (div = 8; div > 0; div--) {
> +        size_t region_size = per_cpu / div;
> +
> +        if (region_size >= 2 * MIN_CODE_GEN_BUFFER_SIZE) {
> +            tcg_region_set_size(region_size);
> +            return;
> +        }
> +    }
> +    tcg_region_set_size(per_cpu);
> +}

Is it worth setting a guard page after each of these regions?  The guard page 
on the main buffer has caught bugs before (although not in a while now).  If 
not, then we might drop the guard page on the main buffer too.

> +static void tcg_region_set_size__locked(size_t size)
> +{
> +    if (!size) {
> +        region.size = tcg_init_ctx->code_gen_buffer_size;
> +        region.n = 1;
> +    } else {
> +        region.size = size;
> +        region.n = tcg_init_ctx->code_gen_buffer_size / size;
> +    }
> +    if (unlikely(region.size < TCG_HIGHWATER)) {
> +        tcg_abort();
> +    }
> +}
> +
> +/*
> + * Call this function at init time (i.e. only once). Calling this function is
> + * optional: if no region size is set, a single region will be used.
> + *
> + * Note: calling this function *after* calling tcg_region_init() is a bug.
> + */
> +void tcg_region_set_size(size_t size)
> +{
> +    tcg_debug_assert(!region.size);
> +
> +    qemu_mutex_lock(&tcg_lock);
> +    tcg_region_set_size__locked(size);
> +    qemu_mutex_unlock(&tcg_lock);
> +}

If this is called during init, then why does it need a lock?  Surely this is 
before we spawn threads.

>      if (unlikely(next > s->code_gen_highwater)) {
> -        return NULL;
> +        if (!tcg_region_alloc(s)) {
> +            return NULL;
> +        }
> +        goto retry;
>      }

Nit: positive logic is almost always clearer: if (region_alloc) goto retry;


r~
