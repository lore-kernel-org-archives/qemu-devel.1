Received: from eggs.gnu.org ([208.118.235.92]:45943)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gbtZL-0005l7-Sz
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 15:44:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gbtZI-00084Y-7j
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 15:44:51 -0500
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:46593)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gbtZE-00081K-O4
	for qemu-devel@nongnu.org; Tue, 25 Dec 2018 15:44:46 -0500
Received: by mail-pf1-x441.google.com with SMTP id c73so7059801pfe.13
	for <qemu-devel@nongnu.org>; Tue, 25 Dec 2018 12:44:43 -0800 (PST)
References: <20181223113859.3675-1-mark.cave-ayland@ilande.co.uk>
	<20181223113859.3675-7-mark.cave-ayland@ilande.co.uk>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <78e34f8d-6c89-1e72-e7f6-a007543303cf@linaro.org>
Date: Wed, 26 Dec 2018 07:44:27 +1100
MIME-Version: 1.0
In-Reply-To: <20181223113859.3675-7-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 6/6] target/ppc: remove various
 HOST_WORDS_BIGENDIAN hacks in int_helper.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

On 12/23/18 10:38 PM, Mark Cave-Ayland wrote:
> -#define VEXT_SIGNED(name, element, mask, cast, recast)              \
> +#define VEXT_SIGNED(name, element, access, mask, cast, recast)      \
>  void helper_##name(ppc_avr_t *r, ppc_avr_t *b)                      \
>  {                                                                   \
>      int i;                                                          \
> -    VECTOR_FOR_INORDER_I(i, element) {                              \
> -        r->element[i] = (recast)((cast)(b->element[i] & mask));     \
> +    for (i = 0; i < ARRAY_SIZE(r->element); i++) {                  \
> +        r->access(i) = (recast)((cast)(b->access(i) & mask));       \
>      }                                                               \
>  }
> -VEXT_SIGNED(vextsb2w, s32, UINT8_MAX, int8_t, int32_t)
> -VEXT_SIGNED(vextsb2d, s64, UINT8_MAX, int8_t, int64_t)
> -VEXT_SIGNED(vextsh2w, s32, UINT16_MAX, int16_t, int32_t)
> -VEXT_SIGNED(vextsh2d, s64, UINT16_MAX, int16_t, int64_t)
> -VEXT_SIGNED(vextsw2d, s64, UINT32_MAX, int32_t, int64_t)
> +VEXT_SIGNED(vextsb2w, s32, VsrSW, UINT8_MAX, int8_t, int32_t)
> +VEXT_SIGNED(vextsb2d, s64, VsrSD, UINT8_MAX, int8_t, int64_t)
> +VEXT_SIGNED(vextsh2w, s32, VsrSW, UINT16_MAX, int16_t, int32_t)
> +VEXT_SIGNED(vextsh2d, s64, VsrSD, UINT16_MAX, int16_t, int64_t)
> +VEXT_SIGNED(vextsw2d, s64, VsrSD, UINT32_MAX, int32_t, int64_t)

Your conversion is technically fine, but this macro is just confused.

It does not need the mask argument, nor does it need the recast argument.
The masking is implied by the cast argument, and the recast is implied by the
assignment.

Nor, really, does it need the access argument.  The data is handled in strict
lanes, and it does not matter in which order the lanes are processed.

> -#define VNEG(name, element)                                         \
> +#define VNEG(name, element, access)                                 \
>  void helper_##name(ppc_avr_t *r, ppc_avr_t *b)                      \
>  {                                                                   \
>      int i;                                                          \
> -    VECTOR_FOR_INORDER_I(i, element) {                              \
> -        r->element[i] = -b->element[i];                             \
> +    for (i = 0; i < ARRAY_SIZE(r->element); i++) {                  \
> +        r->access(i) = -b->access(i);                               \
>      }                                                               \
>  }
> -VNEG(vnegw, s32)
> -VNEG(vnegd, s64)
> +VNEG(vnegw, s32, VsrSW)
> +VNEG(vnegd, s64, VsrSD)

Similarly, this does not require access nor in-order processing.

> -#define VGENERIC_DO(name, element)                                      \
> +#define VGENERIC_DO(name, element, access)                              \
>      void helper_v##name(ppc_avr_t *r, ppc_avr_t *b)                     \
>      {                                                                   \
>          int i;                                                          \
>                                                                          \
> -        VECTOR_FOR_INORDER_I(i, element) {                              \
> -            r->element[i] = name(b->element[i]);                        \
> +        for (i = 0; i < ARRAY_SIZE(r->element); i++) {                  \
> +            r->access(i) = name(b->access(i));                          \
>          }                                                               \
>      }

Likewise.


r~
