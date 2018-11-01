Received: from eggs.gnu.org ([2001:4830:134:3::10]:60404)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gIGMA-0006Nh-Hv
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 13:02:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gIGM7-0006J4-AE
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 13:02:06 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:36965)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1gIGM7-0006HA-07
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 13:02:03 -0400
From: Laurent Vivier <laurent@vivier.eu>
References: <20181005180201.11387-1-richard.henderson@linaro.org>
	<20181005180201.11387-9-richard.henderson@linaro.org>
	<e2f0cc3d-ef03-0d03-cef5-d53369e93122@vivier.eu>
Message-ID: <ce7d84f9-1560-43f8-0c59-097a4162ec63@vivier.eu>
Date: Thu, 1 Nov 2018 18:01:56 +0100
MIME-Version: 1.0
In-Reply-To: <e2f0cc3d-ef03-0d03-cef5-d53369e93122@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PULL 8/8] softfloat: Specialize udiv_qrnnd for
 ppc64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, David Gibson <david@gibson.dropbear.id.au>

On 31/10/2018 19:46, Laurent Vivier wrote:
> On 05/10/2018 20:02, Richard Henderson wrote:
>> The ISA has a 128/64-bit division instruction, though it assumes the
>> low 64-bits of the numerator are 0, and so requires a bit more fixup
>> than a full 128-bit division insn.
>>
>> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>  include/fpu/softfloat-macros.h | 16 ++++++++++++++++
>>  1 file changed, 16 insertions(+)
>>
>> diff --git a/include/fpu/softfloat-macros.h b/include/fpu/softfloat-macros.h
>> index eafc68932b..c86687fa5e 100644
>> --- a/include/fpu/softfloat-macros.h
>> +++ b/include/fpu/softfloat-macros.h
>> @@ -647,6 +647,22 @@ static inline uint64_t udiv_qrnnd(uint64_t *r, uint64_t n1,
>>      asm("dlgr %0, %1" : "+r"(n) : "r"(d));
>>      *r = n >> 64;
>>      return n;
>> +#elif defined(_ARCH_PPC64)
>> +    /* From Power ISA 3.0B, programming note for divdeu.  */

So it fails because my PowerMac G5 is not Power ISA 3.0B...

Something like this fixes the problem. I'm not sure it's the cleanest way:

diff --git a/include/fpu/softfloat-macros.h b/include/fpu/softfloat-macros.h
index c86687fa5e..5a724da2ea 100644
--- a/include/fpu/softfloat-macros.h
+++ b/include/fpu/softfloat-macros.h
@@ -79,6 +79,10 @@ this code that are retained.
  * version 2 or later. See the COPYING file in the top-level directory.
  */

+#if defined(_ARCH_PPC64)
+extern bool have_isa_3_00;
+#endif
+
 /*----------------------------------------------------------------------------
 | Shifts `a' right by the number of bits given in `count'.  If any nonzero
 | bits are shifted off, they are ``jammed'' into the least significant
bit of
@@ -647,7 +651,9 @@ static inline uint64_t udiv_qrnnd(uint64_t *r,
uint64_t n1,
     asm("dlgr %0, %1" : "+r"(n) : "r"(d));
     *r = n >> 64;
     return n;
-#elif defined(_ARCH_PPC64)
+#else
+#if defined(_ARCH_PPC64)
+    if (have_isa_3_00) {
         /* From Power ISA 3.0B, programming note for divdeu.  */
         uint64_t q1, q2, Q, r1, r2, R;
         asm("divdeu %0,%2,%4; divdu %1,%3,%4"
@@ -663,7 +669,8 @@ static inline uint64_t udiv_qrnnd(uint64_t *r,
uint64_t n1,
         }
         *r = R;
         return Q;
-#else
+    }
+#endif
     uint64_t d0, d1, q0, q1, r1, r0, m;

     d0 = (uint32_t)d;

Thanks,
Laurent
