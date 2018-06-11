Received: from eggs.gnu.org ([2001:4830:134:3::10]:60841)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fSQqz-0002TW-5O
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 13:43:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fSQqv-0000Ul-1t
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 13:43:41 -0400
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:33327)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fSQqu-0000UU-Sw
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 13:43:36 -0400
Received: by mail-qk0-x244.google.com with SMTP id c131-v6so4854886qkb.0
	for <qemu-devel@nongnu.org>; Mon, 11 Jun 2018 10:43:36 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180611171007.4165-1-peter.maydell@linaro.org>
	<20180611171007.4165-2-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <7e8f8e98-3023-12af-900c-2ad1d97492be@amsat.org>
Date: Mon, 11 Jun 2018 14:43:31 -0300
MIME-Version: 1.0
In-Reply-To: <20180611171007.4165-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 1/3] bswap: Add new stn_*_p() and ldn_*_p()
 memory access functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, patches@linaro.org

Hi Peter,

On 06/11/2018 02:10 PM, Peter Maydell wrote:
> There's a common pattern in QEMU where a function needs to perform
> a data load or store of an N byte integer in a particular endianness.
> At the moment this is handled by doing a switch() on the size and
> calling the appropriate ld*_p or st*_p function for each size.
> 
> Provide a new family of functions ldn_*_p() and stn_*_p() which
> take the size as an argument and do the switch() themselves.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  include/exec/cpu-all.h      |  4 +++
>  include/qemu/bswap.h        | 52 +++++++++++++++++++++++++++++++++++++
>  docs/devel/loads-stores.rst | 15 +++++++++++
>  3 files changed, 71 insertions(+)
> 
> diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
> index a635f532f97..07ec3808342 100644
> --- a/include/exec/cpu-all.h
> +++ b/include/exec/cpu-all.h
> @@ -133,6 +133,8 @@ static inline void tswap64s(uint64_t *s)
>  #define stq_p(p, v) stq_be_p(p, v)
>  #define stfl_p(p, v) stfl_be_p(p, v)
>  #define stfq_p(p, v) stfq_be_p(p, v)
> +#define ldn_p(p, sz ldn_be_p(p, sz)
> +#define stn_p(p, sz, v) stn_be_p(p, sz, v)
>  #else
>  #define lduw_p(p) lduw_le_p(p)
>  #define ldsw_p(p) ldsw_le_p(p)
> @@ -145,6 +147,8 @@ static inline void tswap64s(uint64_t *s)
>  #define stq_p(p, v) stq_le_p(p, v)
>  #define stfl_p(p, v) stfl_le_p(p, v)
>  #define stfq_p(p, v) stfq_le_p(p, v)
> +#define ldn_p(p, sz) ldn_le_p(p, sz)
> +#define stn_p(p, sz, v) stn_le_p(p, sz, v)
>  #endif
>  
>  /* MMU memory access macros */
> diff --git a/include/qemu/bswap.h b/include/qemu/bswap.h
> index 3f28f661b15..a684c1a7a29 100644
> --- a/include/qemu/bswap.h
> +++ b/include/qemu/bswap.h
> @@ -290,6 +290,15 @@ typedef union {
>   * For accessors that take a guest address rather than a
>   * host address, see the cpu_{ld,st}_* accessors defined in
>   * cpu_ldst.h.
> + *
> + * For cases where the size to be used is not fixed at compile time,
> + * there are
> + *  stn{endian}_p(ptr, sz, val)
> + * which stores @val to @ptr as an @endian-order number @sz bytes in size
> + * and
> + *  ldn{endian}_p(ptr, sz)
> + * which loads @sz bytes from @ptr as an unsigned @endian-order number
> + * and returns it in a uint64_t.
>   */
>  
>  static inline int ldub_p(const void *ptr)
> @@ -495,6 +504,49 @@ static inline unsigned long leul_to_cpu(unsigned long v)
>  #endif
>  }
>  
> +/* Store v to p as a sz byte value in host order */
> +#define DO_STN_LDN_P(END) \
> +    static inline void stn_## END ## _p(void *ptr, int sz, uint64_t v)  \
> +    {                                                                   \
> +        switch (sz) {                                                   \
> +        case 1:                                                         \
> +            stb_p(ptr, v);                                              \
> +            break;                                                      \
> +        case 2:                                                         \
> +            stw_ ## END ## _p(ptr, v);                                  \
> +            break;                                                      \
> +        case 4:                                                         \
> +            stl_ ## END ## _p(ptr, v);                                  \
> +            break;                                                      \
> +        case 8:                                                         \
> +            stq_ ## END ## _p(ptr, v);                                  \
> +            break;                                                      \
> +        default:                                                        \
> +            g_assert_not_reached();                                     \

As with the recent discussion with Markus about whether using abort() or
g_assert_not_reached(), I'd prefer to keep abort() here (which is what
exec.c currently uses).

[http://lists.nongnu.org/archive/html/qemu-devel/2018-06/msg01869.html]

> +        }                                                               \
> +    }                                                                   \
> +    static inline uint64_t ldn_## END ## _p(const void *ptr, int sz)    \
> +    {                                                                   \
> +        switch (sz) {                                                   \
> +        case 1:                                                         \
> +            return ldub_p(ptr);                                         \
> +        case 2:                                                         \
> +            return lduw_ ## END ## _p(ptr);                             \
> +        case 4:                                                         \
> +            return (uint32_t)ldl_ ## END ## _p(ptr);                    \
> +        case 8:                                                         \
> +            return ldq_ ## END ## _p(ptr);                              \
> +        default:                                                        \
> +            g_assert_not_reached();                                     \

Ditto.

> +        }                                                               \
> +    }
> +
> +DO_STN_LDN_P(he)
> +DO_STN_LDN_P(le)
> +DO_STN_LDN_P(be)
> +
> +#undef DO_STN_LDN_P
> +
>  #undef le_bswap
>  #undef be_bswap
>  #undef le_bswaps
> diff --git a/docs/devel/loads-stores.rst b/docs/devel/loads-stores.rst
> index 6a990cc2438..57d8c524bfe 100644
> --- a/docs/devel/loads-stores.rst
> +++ b/docs/devel/loads-stores.rst
> @@ -53,9 +53,24 @@ The ``_{endian}`` infix is omitted for target-endian accesses.
>  The target endian accessors are only available to source
>  files which are built per-target.
>  
> +There are also functions which take the size as an argument:
> +
> +load: ``ldn{endian}_p(ptr, sz)``
> +
> +which performs an unsigned load of ``sz`` bytes from ``ptr``
> +as an ``{endian}`` order value and returns it in a uint64_t.
> +
> +store: ``stn{endian}_p(ptr, sz, val)``
> +
> +which stores ``val`` to ``ptr`` as an ``{endian}`` order value
> +of size ``sz`` bytes.
> +
> +
>  Regexes for git grep
>   - ``\<ldf\?[us]\?[bwlq]\(_[hbl]e\)\?_p\>``
>   - ``\<stf\?[bwlq]\(_[hbl]e\)\?_p\>``
> + - ``\<ldn_\([hbl]e\)?_p\>``
> + - ``\<stn_\([hbl]e\)?_p\>``
>  
>  ``cpu_{ld,st}_*``
>  ~~~~~~~~~~~~~~~~~
> 

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
