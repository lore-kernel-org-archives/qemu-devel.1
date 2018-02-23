Received: from eggs.gnu.org ([2001:4830:134:3::10]:34779)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1epHum-0008GV-VQ
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 13:17:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1epHul-0005D2-SY
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 13:17:48 -0500
Received: from mail-pl0-x242.google.com ([2607:f8b0:400e:c01::242]:36197)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1epHul-0005CX-L0
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 13:17:47 -0500
Received: by mail-pl0-x242.google.com with SMTP id v3so5341528plg.3
	for <qemu-devel@nongnu.org>; Fri, 23 Feb 2018 10:17:47 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180223154613.2096-4-alex.bennee@linaro.org>
References: <20180223154613.2096-1-alex.bennee@linaro.org>
	<20180223154613.2096-4-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Feb 2018 18:17:26 +0000
Message-ID: <CAFEAcA-2OMtdNNbj-R_e-2vJ8vhLfiC5Uj8vFyjqFwVSn72k8g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 3/8] aarch64.risu: add cryptographic
 extensions for v8.2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <richard.henderson@linaro.org>

On 23 February 2018 at 15:46, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  aarch64.risu | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
>
> diff --git a/aarch64.risu b/aarch64.risu
> index 838bded..06a9f3c 100644
> --- a/aarch64.risu
> +++ b/aarch64.risu
> @@ -2937,3 +2937,35 @@ FCVTZUsi_RES A64_V sf:1 0011110 1 type:1 1 11 001 =
000000 rn:5 rd:5
>  # End of:
>  # Data processing - SIMD and floating point
>  # Data processing - Scalar Floating-Point and Advanced SIMD
> +
> +# These are optional ARMv8.2 cryptographic extensions
> +@v8.2,Cryptographic,CryptographicSHA
> +
> +# Cryptographic three-register SHA 512
> +# 31       21 20  16 15 14 13 12 11    10 9  5 4  0
> +# 11001110011   Rm    1  O  0 0   opcode   Rn   Rd
> +
> +SHA512H   A64_V 1100 1110 011 rm:5 1 0 00 00 rn:5 rd:5
> +SHA512H2  A64_V 1100 1110 011 rm:5 1 0 00 01 rn:5 rd:5
> +SHA512SUI A64_V 1100 1110 011 rm:5 1 0 00 10 rn:5 rd:5

"SHA512SU1"

> +RAX1      A64_V 1100 1110 011 rm:5 1 0 00 11 rn:5 rd:5
> +SM3PARTW1 A64_V 1100 1110 011 rm:5 1 1 00 00 rn:5 rd:5
> +SM3PARTW2 A64_V 1100 1110 011 rm:5 1 1 00 01 rn:5 rd:5
> +SM4       A64_V 1100 1110 011 rm:5 1 1 00 10 rn:5 rd:5

"SM4EKEY"

I also had a pattern for the unallocated encoding:
# unallocated encoding: O=3D1 opcode=3D11
SHA512_RES A64_C82 11001110011 rm:5 1 1 00 11 rn:5 rd:5

> +
> +# Cryptographic four-register
> +# 31       23 22 21 20  16 15 14  10 9  5 4  0
> +# 1100 1110 0  Op0    Rm    0   Ra    Rn   Rd
> +
> +EOR3      A64_V 1110 1110 0 00 rm:5 0 ra:5 rn:5 rd:5
> +BCAX      A64_V 1110 1110 0 01 rm:5 0 ra:5 rn:5 rd:5
> +SM3SS1    A64_V 1110 1110 0 10 rm:5 0 ra:5 rn:5 rd:5

and another unallocated pattern:
# unallocated: op0=3D11
C4REG_RES A64_C82 110011100 11 rm:5 0 ra:5 rn:5 rd:5

> +# Cryptographic two-register SHA 512
> +# 31                    12 11  10 9  5 4  0
> +# 1100 1110 1100 0000 1000   op    Rn   Rd
> +
> +SHA512SU0 A64_V 1100 1110 1100 0000 1000 00 rn:5 rd:5
> +SM4E      A64_V 1100 1110 1100 0000 1000 01 rn:5 rd:5

and again:
# unallocated: opcode =3D 1x
C2REG_RES A64_C82 1100 1110 1100 0000 1000 1 x:1 rn:5 rd:5

and I think you're missing these two lots of insns:

# Cryptographic three-register, imm2
SM3TT1A A64_C82 11001110010 rm:5 10 imm:2 00 rn:5 rd:5
SM3TT1B A64_C82 11001110010 rm:5 10 imm:2 01 rn:5 rd:5
SM3TT2A A64_C82 11001110010 rm:5 10 imm:2 10 rn:5 rd:5
SM3TT2B A64_C82 11001110010 rm:5 10 imm:2 11 rn:5 rd:5

# XAR
XAR A64_C82 1100 1110 100 rm:5 imm:6 rn:5 rd:5

thanks
-- PMM
