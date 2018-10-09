Received: from eggs.gnu.org ([2001:4830:134:3::10]:47992)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1g9q5I-0002kX-DM
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 07:21:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1g9q5F-000448-9L
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 07:21:52 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:38318)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1g9q5E-00043R-O5
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 07:21:49 -0400
Received: by mail-wr1-x42a.google.com with SMTP id a13-v6so1390056wrt.5
	for <qemu-devel@nongnu.org>; Tue, 09 Oct 2018 04:21:48 -0700 (PDT)
References: <D5741445-7EFD-4AF1-8DB2-E4AFA93CBB1A@icloud.com>
	<43AE448E-B7B2-490F-8ADB-DC1361512608@icloud.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <43AE448E-B7B2-490F-8ADB-DC1361512608@icloud.com>
Date: Tue, 09 Oct 2018 12:21:45 +0100
Message-ID: <87pnwjmkl2.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] test-i386: Make x86 test program compile
 on clang
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Theodore Dubois <tblodt@icloud.com>
Cc: qemu-devel@nongnu.org


Theodore Dubois <tblodt@icloud.com> writes:

> ping http://patchwork.ozlabs.org/patch/786393/

Applied to tct-tests/next with another patch to work around enterq.
Sorry for the delay.

>
> ~Theodore
>
>> On Jul 10, 2017, at 1:57 PM, Theodore Dubois <tblodt@icloud.com> wrote:
>>
>> Clang's assembler is slightly incompatible with GCC's assembler, which
>> caused the program to not compile on Clang for these reasons:
>>
>>  - The "q" constraint was specified for an argument to the set
>>    instruction, which didn't work because Clang chose the esi register,
>>    which has no 8-bit form on i386.
>>  - Clang doesn't support size suffixes on the loop instructions.
>>  - Clang requires a size suffix on the fist instruction.
>>  - Clang doesn't support specifying segment prefixes before the
>>    instruction, and requires specifying them on the address.
>>  - The arguments to the bound instruction are in the wrong order on
>>    Clang. https://bugs.llvm.org/show_bug.cgi?id=3D27653
>>
>> Signed-off-by: Theodore Dubois <tblodt@icloud.com>
>> ---
>> tests/tcg/test-i386.c | 20 ++++++++++++++++----
>> 1 file changed, 16 insertions(+), 4 deletions(-)
>>
>> diff --git a/tests/tcg/test-i386.c b/tests/tcg/test-i386.c
>> index 0f7b943b0c..dcb8e4876e 100644
>> --- a/tests/tcg/test-i386.c
>> +++ b/tests/tcg/test-i386.c
>> @@ -369,7 +369,7 @@ void test_lea(void)
>>     asm("movl $0, %0\n\t"\
>>         "cmpl %2, %1\n\t"\
>>         "set" JCC " %b0\n\t"\
>> -        : "=3Dr" (res)\
>> +        : "=3Dq" (res)\
>>         : "r" (v1), "r" (v2));\
>>     printf("%-10s %d\n", "set" JCC, res);\
>>  if (TEST_CMOV) {\
>> @@ -491,15 +491,23 @@ void test_loop(void)
>>
>> #if !defined(__x86_64__)
>>     TEST_LOOP("jcxz");
>> +#if !defined(__clang__)
>>     TEST_LOOP("loopw");
>>     TEST_LOOP("loopzw");
>>     TEST_LOOP("loopnzw");
>> #endif
>> +#endif
>>
>>     TEST_LOOP("jecxz");
>> +#if !defined(__clang__)
>>     TEST_LOOP("loopl");
>>     TEST_LOOP("loopzl");
>>     TEST_LOOP("loopnzl");
>> +#else
>> +    TEST_LOOP("loop");
>> +    TEST_LOOP("loopz");
>> +    TEST_LOOP("loopnz");
>> +#endif
>> }
>>
>> #undef CC_MASK
>> @@ -867,7 +875,7 @@ void test_fcvt(double a)
>>         uint16_t val16;
>>         val16 =3D (fpuc & ~0x0c00) | (i << 10);
>>         asm volatile ("fldcw %0" : : "m" (val16));
>> -        asm volatile ("fist %0" : "=3Dm" (wa) : "t" (a));
>> +        asm volatile ("fists %0" : "=3Dm" (wa) : "t" (a));
>>         asm volatile ("fistl %0" : "=3Dm" (ia) : "t" (a));
>>         asm volatile ("fistpll %0" : "=3Dm" (lla) : "t" (a) : "st");
>>         asm volatile ("frndint ; fstl %0" : "=3Dm" (ra) : "t" (a));
>> @@ -1318,12 +1326,12 @@ void test_segs(void)
>>     seg_data1[1] =3D 0xaa;
>>     seg_data2[1] =3D 0x55;
>>
>> -    asm volatile ("fs movzbl 0x1, %0" : "=3Dr" (res));
>> +    asm volatile ("movzbl %%fs:0x1, %0" : "=3Dr" (res));
>>     printf("FS[1] =3D %02x\n", res);
>>
>>     asm volatile ("pushl %%gs\n"
>>                   "movl %1, %%gs\n"
>> -                  "gs movzbl 0x1, %0\n"
>> +                  "movzbl %%gs:0x1, %0\n"
>>                   "popl %%gs\n"
>>                   : "=3Dr" (res)
>>                   : "r" (MK_SEL(2)));
>> @@ -1764,7 +1772,11 @@ void test_exceptions(void)
>>         /* bound exception */
>>         tab[0] =3D 1;
>>         tab[1] =3D 10;
>> +#if defined(__clang__)
>> +        asm volatile ("bound %1, %0" : : "r" (11), "m" (tab[0]));
>> +#else
>>         asm volatile ("bound %0, %1" : : "r" (11), "m" (tab[0]));
>> +#endif
>>     }
>> #endif
>>
>> --
>> 2.13.2
>>
>>
>>
>> ~Theodore
>>
>>


--
Alex Benn=C3=A9e
