Received: from eggs.gnu.org ([2001:4830:134:3::10]:49331)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fdbGT-0002Or-Ri
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 09:04:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fdbGQ-0001BJ-OJ
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 09:04:09 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e]:43611)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fdbGQ-0001Au-Ec
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 09:04:06 -0400
Received: by mail-wr1-x42e.google.com with SMTP id b15-v6so21662753wrv.10
	for <qemu-devel@nongnu.org>; Thu, 12 Jul 2018 06:04:06 -0700 (PDT)
References: <20180711103957.3040-1-richard.henderson@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180711103957.3040-1-richard.henderson@linaro.org>
Date: Thu, 12 Jul 2018 14:04:04 +0100
Message-ID: <87lgagd2rf.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org


Richard Henderson <richard.henderson@linaro.org> writes:

> 'I' was being double-incremented; correctly within the inner loop
> and incorrectly within the outer loop.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

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
> @@ -4855,7 +4855,7 @@ void HELPER(NAME)(CPUARMState *env, void *vd, void =
*vg, void *vm,       \
>      intptr_t i, oprsz =3D simd_oprsz(desc);                             =
  \
>      unsigned scale =3D simd_data(desc);                                 =
  \
>      uintptr_t ra =3D GETPC();                                           =
  \
> -    for (i =3D 0; i < oprsz; i++) {                                     =
  \
> +    for (i =3D 0; i < oprsz; ) {                                        =
  \
>          uint16_t pg =3D *(uint16_t *)(vg + H1_2(i >> 3));               =
  \
>          do {                                                            \
>              TYPEM m =3D 0;                                              =
  \
> @@ -4936,7 +4936,7 @@ void HELPER(NAME)(CPUARMState *env, void *vd, void =
*vg, void *vm,       \
>      uintptr_t ra =3D GETPC();                                           =
  \
>      bool first =3D true;                                                =
  \
>      mmap_lock();                                                        \
> -    for (i =3D 0; i < oprsz; i++) {                                     =
  \
> +    for (i =3D 0; i < oprsz; ) {                                        =
  \
>          uint16_t pg =3D *(uint16_t *)(vg + H1_2(i >> 3));               =
  \
>          do {                                                            \
>              TYPEM m =3D 0;                                              =
  \


--
Alex Benn=C3=A9e
