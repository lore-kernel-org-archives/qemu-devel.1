Received: from eggs.gnu.org ([2001:4830:134:3::10]:50953)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eAuEw-0004Ec-86
	for qemu-devel@nongnu.org; Sat, 04 Nov 2017 04:55:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eAuEr-0000X1-Ce
	for qemu-devel@nongnu.org; Sat, 04 Nov 2017 04:55:42 -0400
References: <20171103202624.5956-1-laurent@vivier.eu>
	<db255c93-a4c6-216d-8ea3-10f340a916f6@amsat.org>
	<257f2a30-6607-cb14-3bbf-27b95d962cf4@amsat.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <89487dfd-f941-871f-e822-68a6fbace6fe@vivier.eu>
Date: Sat, 4 Nov 2017 09:55:17 +0100
MIME-Version: 1.0
In-Reply-To: <257f2a30-6607-cb14-3bbf-27b95d962cf4@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 0/4] softfloat: fix some helper
 definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, qemu-arm@nongnu.org, Stafford Horne <shorne@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>

Le 03/11/2017 à 22:51, Philippe Mathieu-Daudé a écrit :
>> On 11/03/2017 05:26 PM, Laurent Vivier wrote:
>>> This series fixes some errors found by
>>> enabling USE_SOFTFLOAT_STRUCT_TYPES.
> [...]
>>
>> I'm getting those errors:
>>
>> $ make subdir-arm-softmmu -j2
>>
>> /source/qemu/migration/vmstate-types.c:430:5: error: conversion to
>> non-scalar type requested
>>      qemu_put_be64(f, float64_val(*v));
>>      ^~~~~~~~~~~~~
>> make: *** [migration/vmstate-types.o] Error 1
>>
>> In file included from /source/qemu/fpu/softfloat.c:87:0:
>> /source/qemu/fpu/softfloat-specialize.h: In function ‘float16_default_nan’:
>> /source/qemu/include/fpu/softfloat.h:117:26: error: expected expression
>> before ‘{’ token
>>  #define const_float16(x) { x }
>>                           ^
>> /source/qemu/fpu/softfloat-specialize.h:95:12: note: in expansion of
>> macro ‘const_float16’
>>      return const_float16(0x7E00);
>>             ^~~~~~~~~~~~~
>> make: *** [fpu/softfloat.o] Error 1
>>
> 
> Also:
> 
> $ make subdir-armeb-linux-user -j2
> 
>   CC      linux-user/signal.o
> In file included from /source/qemu/linux-user/signal.c:24:0:
> /source/qemu/linux-user/signal.c: In function ‘restore_sigframe_v2_vfp’:
> /source/qemu/linux-user/qemu.h:472:8: error: lvalue required as left
> operand of assignment
>    ((x) = (typeof(*hptr))(                                             \
>         ^
> /source/qemu/linux-user/qemu.h:481:31: note: in expansion of macro
> ‘__get_user_e’
>  # define __get_user(x, hptr)  __get_user_e(x, hptr, be)
>                                ^~~~~~~~~~~~
> /source/qemu/linux-user/signal.c:2209:9: note: in expansion of macro
> ‘__get_user’
>          __get_user(float64_val(env->vfp.regs[i]),
> &vfpframe->ufp.fpregs[i]);
>          ^~~~~~~~~~
> /source/qemu/linux-user/qemu.h:477:13: error: left-hand operand of comma
> expression has no effect [-Werror=unused-value]
>       (hptr)), (void)0)
>              ^
> /source/qemu/linux-user/qemu.h:481:31: note: in expansion of macro
> ‘__get_user_e’
>  # define __get_user(x, hptr)  __get_user_e(x, hptr, be)
>                                ^~~~~~~~~~~~
> /source/qemu/linux-user/signal.c:2209:9: note: in expansion of macro
> ‘__get_user’
>          __get_user(float64_val(env->vfp.regs[i]),
> &vfpframe->ufp.fpregs[i]);
>          ^~~~~~~~~~
> cc1: all warnings being treated as errors
> /source/qemu/rules.mak:66: recipe for target 'linux-user/signal.o' failed
> 
>   CC      linux-user/arm/nwfpe/fpa11_cpdt.o
> ...
> /source/qemu/linux-user/arm/nwfpe/fpa11_cpdt.c:37:4: note: in expansion
> of macro ‘get_user_u32’
>     get_user_u32(float32_val(fpa11->fpreg[Fn].fSingle), addr);
>     ^~~~~~~~~~~~
> /source/qemu/linux-user/qemu.h:515:13: error: lvalue required as left
> operand of assignment
>          (x) = 0;       \
>              ^
> /source/qemu/linux-user/qemu.h:536:32: note: in expansion of macro
> ‘get_user’
>  #define get_user_u32(x, gaddr) get_user((x), (gaddr), uint32_t)
>                                 ^~~~~~~~
> /source/qemu/linux-user/arm/nwfpe/fpa11_cpdt.c:37:4: note: in expansion
> of macro ‘get_user_u32’
>     get_user_u32(float32_val(fpa11->fpreg[Fn].fSingle), addr);
>     ^~~~~~~~~~~~
> 

These series doesn't fix all the problems, only the easiest to fix...

for this one, you need:

diff --git a/migration/vmstate-types.c b/migration/vmstate-types.c
index 48184c380d..0c273d616a 100644
--- a/migration/vmstate-types.c
+++ b/migration/vmstate-types.c
@@ -425,7 +425,7 @@ static int get_float64(QEMUFile *f, void *pv, size_t
size,
 static int put_float64(QEMUFile *f, void *pv, size_t size, VMStateField
*field,
                        QJSON *vmdesc)
 {
-    uint64_t *v = pv;
+    float64 *v = pv;

     qemu_put_be64(f, float64_val(*v));
     return 0;

Thanks,
Laurent
