Received: from eggs.gnu.org ([2001:4830:134:3::10]:38098)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1epdVx-00031i-Qf
	for qemu-devel@nongnu.org; Sat, 24 Feb 2018 12:21:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1epdVt-0003D4-Os
	for qemu-devel@nongnu.org; Sat, 24 Feb 2018 12:21:37 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:34135)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1epdVt-0003BQ-EZ
	for qemu-devel@nongnu.org; Sat, 24 Feb 2018 12:21:33 -0500
References: <20180223145959.18761-1-laurent@vivier.eu>
	<20180223145959.18761-4-laurent@vivier.eu>
	<94ca7b93-4c6e-015e-6c7b-afec3884e212@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <e25dcf61-9230-6a2c-13b6-5cb979b70e44@vivier.eu>
Date: Sat, 24 Feb 2018 18:21:11 +0100
MIME-Version: 1.0
In-Reply-To: <94ca7b93-4c6e-015e-6c7b-afec3884e212@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 3/4] softfloat: use floatx80_infinity in
 softfloat
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Thomas Huth <huth@tuxfamily.org>, Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>

Le 24/02/2018 à 03:26, Richard Henderson a écrit :
> On 02/23/2018 06:59 AM, Laurent Vivier wrote:
>> @@ -4550,8 +4556,8 @@ int64_t floatx80_to_int64(floatx80 a, float_status *status)
>>          if ( shiftCount ) {
>>              float_raise(float_flag_invalid, status);
>>              if (    ! aSign
>> -                 || (    ( aExp == 0x7FFF )
>> -                      && ( aSig != LIT64( 0x8000000000000000 ) ) )
>> +                 || ((aExp == floatx80_infinity_high)
>> +                     && (aSig != floatx80_infinity_low))
>>                 ) {
> 
> As long as you're cleaning this up, m68k ignores the explicit integer bit when
> considering an infinity.  However, Intel doesn't ignore the bit -- it appears
> to treat 7fff.0* as a NaN.

According to the comment above the function:

"... If `a' is a NaN, the largest positive integer is returned.
Otherwise, if the conversion overflows, the largest integer with the
same sign as `a' is returned."

I think the change should be in fact:

@@ -4549,10 +4555,7 @@ int64_t floatx80_to_int64(floatx80 a,
float_status *status)
     if ( shiftCount <= 0 ) {
         if ( shiftCount ) {
             float_raise(float_flag_invalid, status);
-            if (    ! aSign
-                 || (    ( aExp == 0x7FFF )
-                      && ( aSig != LIT64( 0x8000000000000000 ) ) )
-               ) {
+            if (!aSign || floatx80_is_any_nan(a)) {
                 return LIT64( 0x7FFFFFFFFFFFFFFF );
             }
             return (int64_t) LIT64( 0x8000000000000000 );

Do you agree?

Thanks,
Laurent
