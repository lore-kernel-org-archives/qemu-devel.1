Received: from eggs.gnu.org ([2001:4830:134:3::10]:40964)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fr7xS-0006d5-QR
	for qemu-devel@nongnu.org; Sat, 18 Aug 2018 16:36:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fr7xP-0004Ae-MV
	for qemu-devel@nongnu.org; Sat, 18 Aug 2018 16:36:26 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:51693)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1fr7xP-00049y-Cg
	for qemu-devel@nongnu.org; Sat, 18 Aug 2018 16:36:23 -0400
Date: Sat, 18 Aug 2018 16:36:19 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20180818203619.GA13678@flamenco>
References: <20180816025452.21358-1-richard.henderson@linaro.org>
	<20180816025452.21358-2-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180816025452.21358-2-richard.henderson@linaro.org>
Subject: Re: [Qemu-devel] [PATCH 1/5] tcg: Split CONFIG_ATOMIC128
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com

On Wed, Aug 15, 2018 at 19:54:48 -0700, Richard Henderson wrote:
> GCC7+ will no longer advertise support for 16-byte __atomic operations
> if only cmpxchg is supported, as for x86_64.  Fortunately, x86_64 still
> has support for __sync_compare_and_swap_16 and we can make use of that.
> AArch64 does not have, nor ever has had such support, so open-code it.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

I just looked through patchew's mingw error messages. Fixes below.

> diff --git a/accel/tcg/atomic_template.h b/accel/tcg/atomic_template.h
> index d751bcba48..a056b7b408 100644
> --- a/accel/tcg/atomic_template.h
> +++ b/accel/tcg/atomic_template.h
> @@ -100,19 +100,24 @@ ABI_TYPE ATOMIC_NAME(cmpxchg)(CPUArchState *env, target_ulong addr,
>      DATA_TYPE ret;
>  
>      ATOMIC_TRACE_RMW;
> -    ret = atomic_cmpxchg__nocheck(haddr, cmpv, newv);
> +#if DATA_SIZE == 16
> +    ret = atomic16_cmpxchg(haddr, cmpv, newv);
> +#else
> +    ret = atomic_cmpxchg(haddr, cmpv, newv);

Keep the __nocheck here.

(snip)
> +#if DATA_SIZE == 16
> +    ret = atomic16_cmpxchg(haddr, BSWAP(cmpv), BSWAP(newv));
> +#else
>      ret = atomic_cmpxchg__nocheck(haddr, BSWAP(cmpv), BSWAP(newv));

(As done here.)

(snip)
> diff --git a/include/qemu/atomic128.h b/include/qemu/atomic128.h
> new file mode 100644
> index 0000000000..2613ebd352
> --- /dev/null
> +++ b/include/qemu/atomic128.h
(snip)
> +#elif !defined(CONFIG_USER_ONLY)
> +# ifdef __aarch64__
> +/* We can do better than cmpxchg for AArch64.  */
> +static inline Int128 atomic16_read(Int128 *ptr)
> +{
> +    uint64_t l, h;
> +    uint32_t tmp;
> +
> +    /* The load must be paired with the store to guarantee not tearing.  */
> +    asm("0: ldxp %[l], %[h], %[mem]\n\t"
> +        "stxp %w[tmp], %[l], %[h], %[mem]\n\t"
> +        "cbz %w[tmp], 0b"
> +        : [mem] "+m"(*ptr), [tmp] "=r"(tmp), [l] "=r"(l), [h] "=r"(h));
> +
> +    return int128_make128(l, h);
> +}
> +
> +static inline void atomic16_set(Int128 *ptr, Int128 val)
> +{
> +    uint64_t l = val, h = val >> 64, t1, t2;
> +
> +    /* Load into temporaries to acquire the exclusive access lock.  */
> +    asm("0: ldxp %[t1], %[t2], %[mem]\n\t"
> +        "stxp %w[t1], %[l], %[h], %[mem]\n\t"
> +        "cbz %w[t1], 0b"
> +        : [mem] "+m"(*ptr), [t1] "=&r"(t1), [t2] "=&r"(t2)
> +        : [l] "r"(l), [h] "r"(h));
> +}
> +
> +#  define HAVE_ATOMIC128 1
> +# elif HAVE_CMPXCHG128

# elif defined(HAVE_CMPXCHG128) && HAVE_CMPXCHG128
or similar.

Thanks,

		Emilio
