Received: from eggs.gnu.org ([2001:4830:134:3::10]:59186)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1g7e0g-0006Ey-NL
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 06:04:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1g7e0d-0005Yv-E5
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 06:04:02 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45898)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1g7e0d-0005YW-3p
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 06:03:59 -0400
Received: by mail-wr1-f68.google.com with SMTP id q5-v6so5395196wrw.12
	for <qemu-devel@nongnu.org>; Wed, 03 Oct 2018 03:03:59 -0700 (PDT)
References: <1538118095-7003-1-git-send-email-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <c7fa34b9-7ec7-f2f9-eaf7-78c4f36f13aa@redhat.com>
Date: Wed, 3 Oct 2018 12:03:56 +0200
MIME-Version: 1.0
In-Reply-To: <1538118095-7003-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] fpu/softfloat: Replace
 countLeadingZeros32/64 with clz32/64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>

On 28/09/2018 09:01, Thomas Huth wrote:
> Our minimum required compiler for compiling QEMU is GCC 4.1 these days,
> so we can drop the support for compilers which do not provide the
> __builtin_clz*() functions yet. Since the countLeadingZeros32/64 are
> then identical to the clz32/64 functions, and we do not have to sync
> the softloat 2 codebase with upstream anymore (softloat 3 is a complete
> rewrite) we can simply replace the functions with our QEMU versions.
> 
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  fpu/softfloat.c                | 26 ++++++-------
>  include/fpu/softfloat-macros.h | 87 ------------------------------------------
>  2 files changed, 13 insertions(+), 100 deletions(-)
> 
> diff --git a/fpu/softfloat.c b/fpu/softfloat.c
> index 8b91cd6..25a8dd9 100644
> --- a/fpu/softfloat.c
> +++ b/fpu/softfloat.c
> @@ -2681,7 +2681,7 @@ static void
>  {
>      int8_t shiftCount;
>  
> -    shiftCount = countLeadingZeros32( aSig ) - 8;
> +    shiftCount = clz32(aSig) - 8;
>      *zSigPtr = aSig<<shiftCount;
>      *zExpPtr = 1 - shiftCount;
>  
> @@ -2789,7 +2789,7 @@ static float32
>  {
>      int8_t shiftCount;
>  
> -    shiftCount = countLeadingZeros32( zSig ) - 1;
> +    shiftCount = clz32(zSig) - 1;
>      return roundAndPackFloat32(zSign, zExp - shiftCount, zSig<<shiftCount,
>                                 status);
>  
> @@ -2822,7 +2822,7 @@ static void
>  {
>      int8_t shiftCount;
>  
> -    shiftCount = countLeadingZeros64( aSig ) - 11;
> +    shiftCount = clz64(aSig) - 11;
>      *zSigPtr = aSig<<shiftCount;
>      *zExpPtr = 1 - shiftCount;
>  
> @@ -2960,7 +2960,7 @@ static float64
>  {
>      int8_t shiftCount;
>  
> -    shiftCount = countLeadingZeros64( zSig ) - 1;
> +    shiftCount = clz64(zSig) - 1;
>      return roundAndPackFloat64(zSign, zExp - shiftCount, zSig<<shiftCount,
>                                 status);
>  
> @@ -2978,7 +2978,7 @@ void normalizeFloatx80Subnormal(uint64_t aSig, int32_t *zExpPtr,
>  {
>      int8_t shiftCount;
>  
> -    shiftCount = countLeadingZeros64( aSig );
> +    shiftCount = clz64(aSig);
>      *zSigPtr = aSig<<shiftCount;
>      *zExpPtr = 1 - shiftCount;
>  }
> @@ -3217,7 +3217,7 @@ floatx80 normalizeRoundAndPackFloatx80(int8_t roundingPrecision,
>          zSig1 = 0;
>          zExp -= 64;
>      }
> -    shiftCount = countLeadingZeros64( zSig0 );
> +    shiftCount = clz64(zSig0);
>      shortShift128Left( zSig0, zSig1, shiftCount, &zSig0, &zSig1 );
>      zExp -= shiftCount;
>      return roundAndPackFloatx80(roundingPrecision, zSign, zExp,
> @@ -3294,7 +3294,7 @@ static void
>      int8_t shiftCount;
>  
>      if ( aSig0 == 0 ) {
> -        shiftCount = countLeadingZeros64( aSig1 ) - 15;
> +        shiftCount = clz64(aSig1) - 15;
>          if ( shiftCount < 0 ) {
>              *zSig0Ptr = aSig1>>( - shiftCount );
>              *zSig1Ptr = aSig1<<( shiftCount & 63 );
> @@ -3306,7 +3306,7 @@ static void
>          *zExpPtr = - shiftCount - 63;
>      }
>      else {
> -        shiftCount = countLeadingZeros64( aSig0 ) - 15;
> +        shiftCount = clz64(aSig0) - 15;
>          shortShift128Left( aSig0, aSig1, shiftCount, zSig0Ptr, zSig1Ptr );
>          *zExpPtr = 1 - shiftCount;
>      }
> @@ -3495,7 +3495,7 @@ static float128 normalizeRoundAndPackFloat128(flag zSign, int32_t zExp,
>          zSig1 = 0;
>          zExp -= 64;
>      }
> -    shiftCount = countLeadingZeros64( zSig0 ) - 15;
> +    shiftCount = clz64(zSig0) - 15;
>      if ( 0 <= shiftCount ) {
>          zSig2 = 0;
>          shortShift128Left( zSig0, zSig1, shiftCount, &zSig0, &zSig1 );
> @@ -3527,7 +3527,7 @@ floatx80 int32_to_floatx80(int32_t a, float_status *status)
>      if ( a == 0 ) return packFloatx80( 0, 0, 0 );
>      zSign = ( a < 0 );
>      absA = zSign ? - a : a;
> -    shiftCount = countLeadingZeros32( absA ) + 32;
> +    shiftCount = clz32(absA) + 32;
>      zSig = absA;
>      return packFloatx80( zSign, 0x403E - shiftCount, zSig<<shiftCount );
>  
> @@ -3549,7 +3549,7 @@ float128 int32_to_float128(int32_t a, float_status *status)
>      if ( a == 0 ) return packFloat128( 0, 0, 0, 0 );
>      zSign = ( a < 0 );
>      absA = zSign ? - a : a;
> -    shiftCount = countLeadingZeros32( absA ) + 17;
> +    shiftCount = clz32(absA) + 17;
>      zSig0 = absA;
>      return packFloat128( zSign, 0x402E - shiftCount, zSig0<<shiftCount, 0 );
>  
> @@ -3571,7 +3571,7 @@ floatx80 int64_to_floatx80(int64_t a, float_status *status)
>      if ( a == 0 ) return packFloatx80( 0, 0, 0 );
>      zSign = ( a < 0 );
>      absA = zSign ? - a : a;
> -    shiftCount = countLeadingZeros64( absA );
> +    shiftCount = clz64(absA);
>      return packFloatx80( zSign, 0x403E - shiftCount, absA<<shiftCount );
>  
>  }
> @@ -3593,7 +3593,7 @@ float128 int64_to_float128(int64_t a, float_status *status)
>      if ( a == 0 ) return packFloat128( 0, 0, 0, 0 );
>      zSign = ( a < 0 );
>      absA = zSign ? - a : a;
> -    shiftCount = countLeadingZeros64( absA ) + 49;
> +    shiftCount = clz64(absA) + 49;
>      zExp = 0x406E - shiftCount;
>      if ( 64 <= shiftCount ) {
>          zSig1 = 0;
> diff --git a/include/fpu/softfloat-macros.h b/include/fpu/softfloat-macros.h
> index 35e1603..edc6821 100644
> --- a/include/fpu/softfloat-macros.h
> +++ b/include/fpu/softfloat-macros.h
> @@ -80,17 +80,6 @@ this code that are retained.
>   */
>  
>  /*----------------------------------------------------------------------------
> -| This macro tests for minimum version of the GNU C compiler.
> -*----------------------------------------------------------------------------*/
> -#if defined(__GNUC__) && defined(__GNUC_MINOR__)
> -# define SOFTFLOAT_GNUC_PREREQ(maj, min) \
> -         ((__GNUC__ << 16) + __GNUC_MINOR__ >= ((maj) << 16) + (min))
> -#else
> -# define SOFTFLOAT_GNUC_PREREQ(maj, min) 0
> -#endif
> -
> -
> -/*----------------------------------------------------------------------------
>  | Shifts `a' right by the number of bits given in `count'.  If any nonzero
>  | bits are shifted off, they are ``jammed'' into the least significant bit of
>  | the result by setting the least significant bit to 1.  The value of `count'
> @@ -713,82 +702,6 @@ static inline uint32_t estimateSqrt32(int aExp, uint32_t a)
>  }
>  
>  /*----------------------------------------------------------------------------
> -| Returns the number of leading 0 bits before the most-significant 1 bit of
> -| `a'.  If `a' is zero, 32 is returned.
> -*----------------------------------------------------------------------------*/
> -
> -static inline int8_t countLeadingZeros32(uint32_t a)
> -{
> -#if SOFTFLOAT_GNUC_PREREQ(3, 4)
> -    if (a) {
> -        return __builtin_clz(a);
> -    } else {
> -        return 32;
> -    }
> -#else
> -    static const int8_t countLeadingZerosHigh[] = {
> -        8, 7, 6, 6, 5, 5, 5, 5, 4, 4, 4, 4, 4, 4, 4, 4,
> -        3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3,
> -        2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2,
> -        2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2,
> -        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
> -        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
> -        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
> -        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
> -        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
> -        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
> -        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
> -        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
> -        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
> -        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
> -        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
> -        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
> -    };
> -    int8_t shiftCount;
> -
> -    shiftCount = 0;
> -    if ( a < 0x10000 ) {
> -        shiftCount += 16;
> -        a <<= 16;
> -    }
> -    if ( a < 0x1000000 ) {
> -        shiftCount += 8;
> -        a <<= 8;
> -    }
> -    shiftCount += countLeadingZerosHigh[ a>>24 ];
> -    return shiftCount;
> -#endif
> -}
> -
> -/*----------------------------------------------------------------------------
> -| Returns the number of leading 0 bits before the most-significant 1 bit of
> -| `a'.  If `a' is zero, 64 is returned.
> -*----------------------------------------------------------------------------*/
> -
> -static inline int8_t countLeadingZeros64(uint64_t a)
> -{
> -#if SOFTFLOAT_GNUC_PREREQ(3, 4)
> -    if (a) {
> -        return __builtin_clzll(a);
> -    } else {
> -        return 64;
> -    }
> -#else
> -    int8_t shiftCount;
> -
> -    shiftCount = 0;
> -    if ( a < ( (uint64_t) 1 )<<32 ) {
> -        shiftCount += 32;
> -    }
> -    else {
> -        a >>= 32;
> -    }
> -    shiftCount += countLeadingZeros32( a );
> -    return shiftCount;
> -#endif
> -}
> -
> -/*----------------------------------------------------------------------------
>  | Returns 1 if the 128-bit value formed by concatenating `a0' and `a1'
>  | is equal to the 128-bit value formed by concatenating `b0' and `b1'.
>  | Otherwise, returns 0.
> 
