Received: from eggs.gnu.org ([2001:4830:134:3::10]:46581)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eAiMp-0005La-Gp
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 16:15:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eAiMm-0007TY-Bz
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 16:15:03 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:52981)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1eAiMm-0007T0-0v
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 16:15:00 -0400
References: <20170920131823.16347-1-laurent@vivier.eu>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <c844ed50-badf-7b1e-f1b2-8f58d724880f@vivier.eu>
Date: Fri, 3 Nov 2017 21:14:38 +0100
MIME-Version: 1.0
In-Reply-To: <20170920131823.16347-1-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3] softfloat: rename
 make_float[x80|128]_init to const_float[x80|128]
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Aurelien Jarno <aurelien@aurel32.net>

Ping?

Laurent

Le 20/09/2017 à 15:18, Laurent Vivier a écrit :
> We already have const_float16(), const_float32() and const_float64(),
> so rename make_floatx80_init() and make_float128_init() to now be
> const_floatx80() and const_float128(), for consistency.
> 
> Redefine make_float16(), make_float32() and make_float64() to be like
> make_floatx80() and make_float128(), by using a compound literal.
> 
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> v3: update patch description
> v2: change float16(), make_float32() and make_float64()
>     instead of make_floatx80() and make_float128()
> 
>  include/fpu/softfloat.h  | 10 +++++-----
>  target/m68k/fpu_helper.c | 44 ++++++++++++++++++++++----------------------
>  2 files changed, 27 insertions(+), 27 deletions(-)
> 
> diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
> index 0f96a0edd1..cda6421b23 100644
> --- a/include/fpu/softfloat.h
> +++ b/include/fpu/softfloat.h
> @@ -113,20 +113,20 @@ typedef struct {
>      uint16_t v;
>  } float16;
>  #define float16_val(x) (((float16)(x)).v)
> -#define make_float16(x) __extension__ ({ float16 f16_val = {x}; f16_val; })
> +#define make_float16(x) ((float16) { x })
>  #define const_float16(x) { x }
>  typedef struct {
>      uint32_t v;
>  } float32;
>  /* The cast ensures an error if the wrong type is passed.  */
>  #define float32_val(x) (((float32)(x)).v)
> -#define make_float32(x) __extension__ ({ float32 f32_val = {x}; f32_val; })
> +#define make_float32(x) ((float32) { x })
>  #define const_float32(x) { x }
>  typedef struct {
>      uint64_t v;
>  } float64;
>  #define float64_val(x) (((float64)(x)).v)
> -#define make_float64(x) __extension__ ({ float64 f64_val = {x}; f64_val; })
> +#define make_float64(x) ((float64) { x })
>  #define const_float64(x) { x }
>  #else
>  typedef uint16_t float16;
> @@ -147,7 +147,7 @@ typedef struct {
>      uint16_t high;
>  } floatx80;
>  #define make_floatx80(exp, mant) ((floatx80) { mant, exp })
> -#define make_floatx80_init(exp, mant) { .low = mant, .high = exp }
> +#define const_floatx80(exp, mant) { .low = mant, .high = exp }
>  typedef struct {
>  #ifdef HOST_WORDS_BIGENDIAN
>      uint64_t high, low;
> @@ -156,7 +156,7 @@ typedef struct {
>  #endif
>  } float128;
>  #define make_float128(high_, low_) ((float128) { .high = high_, .low = low_ })
> -#define make_float128_init(high_, low_) { .high = high_, .low = low_ }
> +#define const_float128(high_, low_) { .high = high_, .low = low_ }
>  
>  /*----------------------------------------------------------------------------
>  | Software IEC/IEEE floating-point underflow tininess-detection mode.
> diff --git a/target/m68k/fpu_helper.c b/target/m68k/fpu_helper.c
> index 665e7609af..bf62cf8003 100644
> --- a/target/m68k/fpu_helper.c
> +++ b/target/m68k/fpu_helper.c
> @@ -29,28 +29,28 @@
>   */
>  
>  static const floatx80 fpu_rom[128] = {
> -    [0x00] = make_floatx80_init(0x4000, 0xc90fdaa22168c235ULL),  /* Pi       */
> -    [0x0b] = make_floatx80_init(0x3ffd, 0x9a209a84fbcff798ULL),  /* Log10(2) */
> -    [0x0c] = make_floatx80_init(0x4000, 0xadf85458a2bb4a9aULL),  /* e        */
> -    [0x0d] = make_floatx80_init(0x3fff, 0xb8aa3b295c17f0bcULL),  /* Log2(e)  */
> -    [0x0e] = make_floatx80_init(0x3ffd, 0xde5bd8a937287195ULL),  /* Log10(e) */
> -    [0x0f] = make_floatx80_init(0x0000, 0x0000000000000000ULL),  /* Zero     */
> -    [0x30] = make_floatx80_init(0x3ffe, 0xb17217f7d1cf79acULL),  /* ln(2)    */
> -    [0x31] = make_floatx80_init(0x4000, 0x935d8dddaaa8ac17ULL),  /* ln(10)   */
> -    [0x32] = make_floatx80_init(0x3fff, 0x8000000000000000ULL),  /* 10^0     */
> -    [0x33] = make_floatx80_init(0x4002, 0xa000000000000000ULL),  /* 10^1     */
> -    [0x34] = make_floatx80_init(0x4005, 0xc800000000000000ULL),  /* 10^2     */
> -    [0x35] = make_floatx80_init(0x400c, 0x9c40000000000000ULL),  /* 10^4     */
> -    [0x36] = make_floatx80_init(0x4019, 0xbebc200000000000ULL),  /* 10^8     */
> -    [0x37] = make_floatx80_init(0x4034, 0x8e1bc9bf04000000ULL),  /* 10^16    */
> -    [0x38] = make_floatx80_init(0x4069, 0x9dc5ada82b70b59eULL),  /* 10^32    */
> -    [0x39] = make_floatx80_init(0x40d3, 0xc2781f49ffcfa6d5ULL),  /* 10^64    */
> -    [0x3a] = make_floatx80_init(0x41a8, 0x93ba47c980e98ce0ULL),  /* 10^128   */
> -    [0x3b] = make_floatx80_init(0x4351, 0xaa7eebfb9df9de8eULL),  /* 10^256   */
> -    [0x3c] = make_floatx80_init(0x46a3, 0xe319a0aea60e91c7ULL),  /* 10^512   */
> -    [0x3d] = make_floatx80_init(0x4d48, 0xc976758681750c17ULL),  /* 10^1024  */
> -    [0x3e] = make_floatx80_init(0x5a92, 0x9e8b3b5dc53d5de5ULL),  /* 10^2048  */
> -    [0x3f] = make_floatx80_init(0x7525, 0xc46052028a20979bULL),  /* 10^4096  */
> +    [0x00] = const_floatx80(0x4000, 0xc90fdaa22168c235ULL),  /* Pi       */
> +    [0x0b] = const_floatx80(0x3ffd, 0x9a209a84fbcff798ULL),  /* Log10(2) */
> +    [0x0c] = const_floatx80(0x4000, 0xadf85458a2bb4a9aULL),  /* e        */
> +    [0x0d] = const_floatx80(0x3fff, 0xb8aa3b295c17f0bcULL),  /* Log2(e)  */
> +    [0x0e] = const_floatx80(0x3ffd, 0xde5bd8a937287195ULL),  /* Log10(e) */
> +    [0x0f] = const_floatx80(0x0000, 0x0000000000000000ULL),  /* Zero     */
> +    [0x30] = const_floatx80(0x3ffe, 0xb17217f7d1cf79acULL),  /* ln(2)    */
> +    [0x31] = const_floatx80(0x4000, 0x935d8dddaaa8ac17ULL),  /* ln(10)   */
> +    [0x32] = const_floatx80(0x3fff, 0x8000000000000000ULL),  /* 10^0     */
> +    [0x33] = const_floatx80(0x4002, 0xa000000000000000ULL),  /* 10^1     */
> +    [0x34] = const_floatx80(0x4005, 0xc800000000000000ULL),  /* 10^2     */
> +    [0x35] = const_floatx80(0x400c, 0x9c40000000000000ULL),  /* 10^4     */
> +    [0x36] = const_floatx80(0x4019, 0xbebc200000000000ULL),  /* 10^8     */
> +    [0x37] = const_floatx80(0x4034, 0x8e1bc9bf04000000ULL),  /* 10^16    */
> +    [0x38] = const_floatx80(0x4069, 0x9dc5ada82b70b59eULL),  /* 10^32    */
> +    [0x39] = const_floatx80(0x40d3, 0xc2781f49ffcfa6d5ULL),  /* 10^64    */
> +    [0x3a] = const_floatx80(0x41a8, 0x93ba47c980e98ce0ULL),  /* 10^128   */
> +    [0x3b] = const_floatx80(0x4351, 0xaa7eebfb9df9de8eULL),  /* 10^256   */
> +    [0x3c] = const_floatx80(0x46a3, 0xe319a0aea60e91c7ULL),  /* 10^512   */
> +    [0x3d] = const_floatx80(0x4d48, 0xc976758681750c17ULL),  /* 10^1024  */
> +    [0x3e] = const_floatx80(0x5a92, 0x9e8b3b5dc53d5de5ULL),  /* 10^2048  */
> +    [0x3f] = const_floatx80(0x7525, 0xc46052028a20979bULL),  /* 10^4096  */
>  };
>  
>  int32_t HELPER(reds32)(CPUM68KState *env, FPReg *val)
> 
