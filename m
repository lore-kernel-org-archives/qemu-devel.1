Received: from eggs.gnu.org ([209.51.188.92]:53281)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1gnjE0-0002td-3X
	for qemu-devel@nongnu.org; Sun, 27 Jan 2019 07:07:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1gnjDy-0000jO-7L
	for qemu-devel@nongnu.org; Sun, 27 Jan 2019 07:07:44 -0500
Date: Sun, 27 Jan 2019 13:07:31 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <20190127090306.30826-3-mark.cave-ayland@ilande.co.uk>
Message-ID: <alpine.BSF.2.21.9999.1901271251060.35973@zero.eik.bme.hu>
References: <20190127090306.30826-1-mark.cave-ayland@ilande.co.uk>
	<20190127090306.30826-3-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v3 2/8] target/ppc: rework
 vmrg{l, h}{b, h, w} instructions to use Vsr* macros
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, richard.henderson@linaro.org, david@gibson.dropbear.id.au

On Sun, 27 Jan 2019, Mark Cave-Ayland wrote:
> The current implementations make use of the endian-specific macros MRGLO/MRGHI
> and also reference HI_IDX and LO_IDX directly to calculate array offsets.
>
> Rework the implementation to use the Vsr* macros so that these per-endian
> references can be removed.
>
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
> target/ppc/int_helper.c | 52 ++++++++++++++++++++++++-------------------------
> 1 file changed, 25 insertions(+), 27 deletions(-)
>
> diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
> index 598731d47a..f084a706ee 100644
> --- a/target/ppc/int_helper.c
> +++ b/target/ppc/int_helper.c
> @@ -976,43 +976,41 @@ void helper_vmladduhm(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b, ppc_avr_t *c)
>     }
> }
>
> -#define VMRG_DO(name, element, highp)                                   \
> +#define VMRG_DOLO(name, element, access)                                \
>     void helper_v##name(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)       \
>     {                                                                   \
>         ppc_avr_t result;                                               \
>         int i;                                                          \
> -        size_t n_elems = ARRAY_SIZE(r->element);                        \
> +        int m = ARRAY_SIZE(r->element) - 1;                             \
>                                                                         \
> -        for (i = 0; i < n_elems / 2; i++) {                             \
> -            if (highp) {                                                \
> -                result.element[i*2+HI_IDX] = a->element[i];             \
> -                result.element[i*2+LO_IDX] = b->element[i];             \
> -            } else {                                                    \
> -                result.element[n_elems - i * 2 - (1 + HI_IDX)] =        \
> -                    b->element[n_elems - i - 1];                        \
> -                result.element[n_elems - i * 2 - (1 + LO_IDX)] =        \
> -                    a->element[n_elems - i - 1];                        \
> -            }                                                           \
> +        for (i = 0; i < ARRAY_SIZE(r->element); i++) {                  \

Isn't this a performance hit? You seem to do twice as many iterations now:

- before, the loop was to ARRAY_SIZE/2 and was called twice so it 
executed ARRAY_SIZE times

- after you have a loop to ARRAY_SIZE but still called twice so it 
executes 2*ARRAY_SIZE times

Or do I miss something? If these are replaced with hardware vector 
instructions at the end then it may not matter to those who have CPU with 
needed vector instructions but for others this may be slower than the 
previous hand optimised version. But I haven't tested it, just guessing.

Regrads,
BALATON Zoltan

> +            result.access(m - i) = (i & 1) ? a->access(m - (i >> 1))    \
> +                                           : b->access(m - (i >> 1));   \
>         }                                                               \
>         *r = result;                                                    \
>     }
> -#if defined(HOST_WORDS_BIGENDIAN)
> -#define MRGHI 0
> -#define MRGLO 1
> -#else
> -#define MRGHI 1
> -#define MRGLO 0
> -#endif
> -#define VMRG(suffix, element)                   \
> -    VMRG_DO(mrgl##suffix, element, MRGHI)       \
> -    VMRG_DO(mrgh##suffix, element, MRGLO)
> -VMRG(b, u8)
> -VMRG(h, u16)
> -VMRG(w, u32)
> +
> +#define VMRG_DOHI(name, element, access)                                \
> +    void helper_v##name(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)       \
> +    {                                                                   \
> +        ppc_avr_t result;                                               \
> +        int i;                                                          \
> +                                                                        \
> +        for (i = 0; i < ARRAY_SIZE(r->element); i++) {                  \
> +            result.access(i) = (i & 1) ? b->access(i >> 1)              \
> +                                       : a->access(i >> 1);             \
> +        }                                                               \
> +        *r = result;                                                    \
> +    }
> +
> +#define VMRG(suffix, element, access)                  \
> +    VMRG_DOLO(mrgl##suffix, element, access)           \
> +    VMRG_DOHI(mrgh##suffix, element, access)
> +VMRG(b, u8, VsrB)
> +VMRG(h, u16, VsrH)
> +VMRG(w, u32, VsrW)
> #undef VMRG_DO
> #undef VMRG
> -#undef MRGHI
> -#undef MRGLO
>
> void helper_vmsummbm(CPUPPCState *env, ppc_avr_t *r, ppc_avr_t *a,
>                      ppc_avr_t *b, ppc_avr_t *c)
>
