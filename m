Received: from eggs.gnu.org ([2001:4830:134:3::10]:54873)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent.desnogues@gmail.com>) id 1fdCvJ-0006wn-Fk
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 07:04:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent.desnogues@gmail.com>) id 1fdCvI-0000Ka-2x
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 07:04:41 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:43336)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent.desnogues@gmail.com>)
	id 1fdCvH-0000KN-Ub
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 07:04:40 -0400
Received: by mail-oi0-x241.google.com with SMTP id b15-v6so48424044oib.10
	for <qemu-devel@nongnu.org>; Wed, 11 Jul 2018 04:04:39 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180711103957.3040-1-richard.henderson@linaro.org>
References: <20180711103957.3040-1-richard.henderson@linaro.org>
From: Laurent Desnogues <laurent.desnogues@gmail.com>
Date: Wed, 11 Jul 2018 13:04:38 +0200
Message-ID: <CABoDooMcGmex9s58D=bH-GTM0jkCUTNyx5A+JXE_Hyd--kBgbg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH for-3.0] target/arm: Fix LD1W and LDFF1W
 (scalar plus vector)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>

Hello,

On Wed, Jul 11, 2018 at 12:39 PM, Richard Henderson
<richard.henderson@linaro.org> wrote:
> 'I' was being double-incremented; correctly within the inner loop
> and incorrectly within the outer loop.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

I didn't try to apply the patch but line numbers look wrong.

I guess this should apply to DO_LD1_ZPZ_S and DO_LDFF1_ZPZ macros, in
which case you get my review:

Reviewed-by: Laurent Desnogues <laurent.desnogues@gmail.com>

Thanks,

Laurent

> ---
>
> Fixes a SIGSEGV within one of these generated helpers,
> exposed by an armclang vectorized code sample.
>
>
> r~
>
> ---
>  target/arm/sve_helper.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
> index cec0d3ee54..ddc592ff79 100644
> --- a/target/arm/sve_helper.c
> +++ b/target/arm/sve_helper.c
> @@ -4855,7 +4855,7 @@ void HELPER(NAME)(CPUARMState *env, void *vd, void *vg, void *vm,       \
>      intptr_t i, oprsz = simd_oprsz(desc);                               \
>      unsigned scale = simd_data(desc);                                   \
>      uintptr_t ra = GETPC();                                             \
> -    for (i = 0; i < oprsz; i++) {                                       \
> +    for (i = 0; i < oprsz; ) {                                          \
>          uint16_t pg = *(uint16_t *)(vg + H1_2(i >> 3));                 \
>          do {                                                            \
>              TYPEM m = 0;                                                \
> @@ -4936,7 +4936,7 @@ void HELPER(NAME)(CPUARMState *env, void *vd, void *vg, void *vm,       \
>      uintptr_t ra = GETPC();                                             \
>      bool first = true;                                                  \
>      mmap_lock();                                                        \
> -    for (i = 0; i < oprsz; i++) {                                       \
> +    for (i = 0; i < oprsz; ) {                                          \
>          uint16_t pg = *(uint16_t *)(vg + H1_2(i >> 3));                 \
>          do {                                                            \
>              TYPEM m = 0;                                                \
> --
> 2.17.1
>
>
