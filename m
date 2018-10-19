Received: from eggs.gnu.org ([2001:4830:134:3::10]:41445)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gDN9r-0001k0-Sv
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 01:17:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gDN9n-0003rQ-N7
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 01:17:11 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33010)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gDN9n-0003nY-5w
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 01:17:07 -0400
Received: by mail-wm1-f68.google.com with SMTP id y140-v6so3251310wmd.0
	for <qemu-devel@nongnu.org>; Thu, 18 Oct 2018 22:17:06 -0700 (PDT)
References: <20181011205206.3552-1-richard.henderson@linaro.org>
	<20181011205206.3552-20-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <b8520f0a-a549-a333-c7b9-dbe38ee25d41@redhat.com>
Date: Fri, 19 Oct 2018 07:17:01 +0200
MIME-Version: 1.0
In-Reply-To: <20181011205206.3552-20-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 19/20] target/arm: Promote consecutive
 memory ops for aa32
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

On 11/10/2018 22:52, Richard Henderson wrote:
> For a sequence of loads or stores from a single register,
> little-endian operations can be promoted to an 8-byte op.
> This can reduce the number of operations by a factor of 8.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  target/arm/translate.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/target/arm/translate.c b/target/arm/translate.c
> index 12a744b3c3..09f2d648b7 100644
> --- a/target/arm/translate.c
> +++ b/target/arm/translate.c
> @@ -5011,6 +5011,16 @@ static int disas_neon_ls_insn(DisasContext *s, uint32_t insn)
>          if (size == 3 && (interleave | spacing) != 1) {
>              return 1;
>          }
> +        /* For our purposes, bytes are always little-endian.  */
> +        if (size == 0) {
> +            endian = MO_LE;
> +        }
> +        /* Consecutive little-endian elements from a single register
> +         * can be promoted to a larger little-endian operation.
> +         */
> +        if (interleave == 1 && endian == MO_LE) {
> +            size = 3;
> +        }
>          tmp64 = tcg_temp_new_i64();
>          addr = tcg_temp_new_i32();
>          tmp2 = tcg_const_i32(1 << size);
> 
