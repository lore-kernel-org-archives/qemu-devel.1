Received: from eggs.gnu.org ([2001:4830:134:3::10]:59652)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1drqGJ-0005eo-Hj
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 14:50:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1drqGG-0006no-DY
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 14:50:19 -0400
Received: from mail-qk0-x236.google.com ([2607:f8b0:400d:c09::236]:38243)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1drqGG-0006mp-8Z
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 14:50:16 -0400
Received: by mail-qk0-x236.google.com with SMTP id a128so27084808qkc.5
	for <qemu-devel@nongnu.org>; Tue, 12 Sep 2017 11:50:14 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170912162513.21694-1-richard.henderson@linaro.org>
	<20170912162513.21694-8-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <d1f97f10-921e-1c50-9407-2007b1cbe169@amsat.org>
Date: Tue, 12 Sep 2017 15:50:11 -0300
MIME-Version: 1.0
In-Reply-To: <20170912162513.21694-8-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 07/16] target/arm: Align vector registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org

Hi Richard,

On 09/12/2017 01:25 PM, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/cpu.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 98b9b26fd3..419f008277 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -486,7 +486,7 @@ typedef struct CPUARMState {
>            * the two execution states, and means we do not need to explicitly
>            * map these registers when changing states.
>            */
> -        float64 regs[64];
> +        float64 regs[64] __attribute__((aligned(16)));

I understand this should be aligned to the biggest vector register the 
host support, i.e. for AVX-512 this would be QEMU_ALIGNED(64), is it 
correct?

I'd rather use a #define such HOST_VECTOR_LENGTH_BITS_MAX and 
QEMU_ALIGNED(HOST_VECTOR_LENGTH_BITS_MAX / BITS_PER_BYTE) or directly 
QEMU_ALIGNED(HOST_VECTOR_LENGTH_MAX), using the define makes it 
self-explanatory. Or shorter:

         float64 regs[64] QEMU_ALIGNED(HOST_VECTOR_SIZE);

What do you think?

Regards,

Phil.

>   
>           uint32_t xregs[16];
>           /* We store these fpcsr fields separately for convenience.  */
> 
