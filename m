Received: from eggs.gnu.org ([2001:4830:134:3::10]:47348)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gIHBf-0005PG-9f
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 13:55:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gIHBb-0006HF-4p
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 13:55:19 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:33827)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1gIHBa-0006Gk-RN
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 13:55:15 -0400
References: <20181101173852.27257-1-laurent@vivier.eu>
	<CAFEAcA9+gSUHW++EKtuqWL4ofWAKqO0H5JUGUoyyAhY7h24o0Q@mail.gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <dcc24ea9-676f-8276-fe54-49bf67f20e56@vivier.eu>
Date: Thu, 1 Nov 2018 18:54:59 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9+gSUHW++EKtuqWL4ofWAKqO0H5JUGUoyyAhY7h24o0Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] softfloat: don't execute ppc64 ISA 3.0B
 instruction if it is not supported
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>, David Gibson <david@gibson.dropbear.id.au>, Richard Henderson <richard.henderson@linaro.org>

On 01/11/2018 18:49, Peter Maydell wrote:
> On 1 November 2018 at 17:38, Laurent Vivier <laurent@vivier.eu> wrote:
>> commit 27ae5109a2 has introduced an assembly instruction only supported
>> by ISA 3.0B and it fails to execute on previous versions of the POWER
>> CPU (like PowerPC G5).
>>
>> This patch fixes that by checking the ISA level, and falls back to
>> the default C function if the instruction is not supported.
>>
>> Fixes: 27ae5109a2ba8b6b679cce3e03e16570a34390a0
>>        (softfloat: Specialize udiv_qrnnd for ppc64)
>> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
>> ---
>>  include/fpu/softfloat-macros.h | 39 ++++++++++++++++++++--------------
>>  1 file changed, 23 insertions(+), 16 deletions(-)
>>
>> diff --git a/include/fpu/softfloat-macros.h b/include/fpu/softfloat-macros.h
>> index c86687fa5e..fe98b33df9 100644
>> --- a/include/fpu/softfloat-macros.h
>> +++ b/include/fpu/softfloat-macros.h
>> @@ -78,6 +78,9 @@ this code that are retained.
>>  /* Portions of this work are licensed under the terms of the GNU GPL,
>>   * version 2 or later. See the COPYING file in the top-level directory.
>>   */
>> +#if defined(_ARCH_PPC64)
>> +extern bool have_isa_3_00;
>> +#endif
> 
> I was wondering where this bool came from. The answer is
> that it's defined in tcg/ppc/tcg-target.inc.c. It's ok to
> use it here because fpu/softfloat.c is only compiled if
> CONFIG_TCG is true, so the tcg code will be present. The
> other user of this include file is target/m68k/softfloat.c,
> which also will only be compiled for a ppc host if CONFIG_TCG.
> 
> It's a little awkward to be borrowing this tcg/ppc internal
> flag into the softfloat code, though.

I agree, I was hopping Richard can advice another way to do that.

Thanks,
Laurent
