Received: from eggs.gnu.org ([2001:4830:134:3::10]:39964)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fIXZ7-00036h-A3
	for qemu-devel@nongnu.org; Tue, 15 May 2018 06:52:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fIXZ3-000259-3L
	for qemu-devel@nongnu.org; Tue, 15 May 2018 06:52:21 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:43038)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fIXZ2-00024V-TA
	for qemu-devel@nongnu.org; Tue, 15 May 2018 06:52:17 -0400
Received: by mail-wr0-x241.google.com with SMTP id v15-v6so15505087wrm.10
	for <qemu-devel@nongnu.org>; Tue, 15 May 2018 03:52:16 -0700 (PDT)
References: <20180514221219.7091-1-richard.henderson@linaro.org>
	<20180514221219.7091-2-richard.henderson@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180514221219.7091-2-richard.henderson@linaro.org>
Date: Tue, 15 May 2018 11:52:14 +0100
Message-ID: <87r2mdfaxt.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 01/28] fpu/softfloat: Fix conversion
 from uint64 to float128
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, Petr Tesarik <ptesarik@suse.com>, qemu-stable@nongnu.org


Richard Henderson <richard.henderson@linaro.org> writes:

> From: Petr Tesarik <ptesarik@suse.com>
>
> The significand is passed to normalizeRoundAndPackFloat128() as high
> first, low second. The current code passes the integer first, so the
> result is incorrectly shifted left by 64 bits.
>
> This bug affects the emulation of s390x instruction CXLGBR (convert
> from logical 64-bit binary-integer operand to extended BFP result).
>
> Cc: qemu-stable@nongnu.org
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Petr Tesarik <ptesarik@suse.com>
> Message-Id: <20180511071052.1443-1-ptesarik@suse.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  fpu/softfloat.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fpu/softfloat.c b/fpu/softfloat.c
> index bc0f52fa54..d07419324a 100644
> --- a/fpu/softfloat.c
> +++ b/fpu/softfloat.c
> @@ -3147,7 +3147,7 @@ float128 uint64_to_float128(uint64_t a, float_statu=
s *status)
>      if (a =3D=3D 0) {
>          return float128_zero;
>      }
> -    return normalizeRoundAndPackFloat128(0, 0x406E, a, 0, status);
> +    return normalizeRoundAndPackFloat128(0, 0x406E, 0, a, status);

This brings back memories :-/

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--
Alex Benn=C3=A9e
