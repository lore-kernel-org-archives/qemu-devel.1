Received: from eggs.gnu.org ([2001:4830:134:3::10]:35024)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eAjsE-0005ZZ-4k
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 17:51:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eAjsD-0007wL-9S
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 17:51:34 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
References: <20171103202624.5956-1-laurent@vivier.eu>
	<db255c93-a4c6-216d-8ea3-10f340a916f6@amsat.org>
Message-ID: <257f2a30-6607-cb14-3bbf-27b95d962cf4@amsat.org>
Date: Fri, 3 Nov 2017 18:51:19 -0300
MIME-Version: 1.0
In-Reply-To: <db255c93-a4c6-216d-8ea3-10f340a916f6@amsat.org>
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
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, qemu-arm@nongnu.org, Stafford Horne <shorne@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>

> On 11/03/2017 05:26 PM, Laurent Vivier wrote:
>> This series fixes some errors found by
>> enabling USE_SOFTFLOAT_STRUCT_TYPES.
[...]
>
> I'm getting those errors:
> 
> $ make subdir-arm-softmmu -j2
> 
> /source/qemu/migration/vmstate-types.c:430:5: error: conversion to
> non-scalar type requested
>      qemu_put_be64(f, float64_val(*v));
>      ^~~~~~~~~~~~~
> make: *** [migration/vmstate-types.o] Error 1
> 
> In file included from /source/qemu/fpu/softfloat.c:87:0:
> /source/qemu/fpu/softfloat-specialize.h: In function ‘float16_default_nan’:
> /source/qemu/include/fpu/softfloat.h:117:26: error: expected expression
> before ‘{’ token
>  #define const_float16(x) { x }
>                           ^
> /source/qemu/fpu/softfloat-specialize.h:95:12: note: in expansion of
> macro ‘const_float16’
>      return const_float16(0x7E00);
>             ^~~~~~~~~~~~~
> make: *** [fpu/softfloat.o] Error 1
> 

Also:

$ make subdir-armeb-linux-user -j2

  CC      linux-user/signal.o
In file included from /source/qemu/linux-user/signal.c:24:0:
/source/qemu/linux-user/signal.c: In function ‘restore_sigframe_v2_vfp’:
/source/qemu/linux-user/qemu.h:472:8: error: lvalue required as left
operand of assignment
   ((x) = (typeof(*hptr))(                                             \
        ^
/source/qemu/linux-user/qemu.h:481:31: note: in expansion of macro
‘__get_user_e’
 # define __get_user(x, hptr)  __get_user_e(x, hptr, be)
                               ^~~~~~~~~~~~
/source/qemu/linux-user/signal.c:2209:9: note: in expansion of macro
‘__get_user’
         __get_user(float64_val(env->vfp.regs[i]),
&vfpframe->ufp.fpregs[i]);
         ^~~~~~~~~~
/source/qemu/linux-user/qemu.h:477:13: error: left-hand operand of comma
expression has no effect [-Werror=unused-value]
      (hptr)), (void)0)
             ^
/source/qemu/linux-user/qemu.h:481:31: note: in expansion of macro
‘__get_user_e’
 # define __get_user(x, hptr)  __get_user_e(x, hptr, be)
                               ^~~~~~~~~~~~
/source/qemu/linux-user/signal.c:2209:9: note: in expansion of macro
‘__get_user’
         __get_user(float64_val(env->vfp.regs[i]),
&vfpframe->ufp.fpregs[i]);
         ^~~~~~~~~~
cc1: all warnings being treated as errors
/source/qemu/rules.mak:66: recipe for target 'linux-user/signal.o' failed

  CC      linux-user/arm/nwfpe/fpa11_cpdt.o
...
/source/qemu/linux-user/arm/nwfpe/fpa11_cpdt.c:37:4: note: in expansion
of macro ‘get_user_u32’
    get_user_u32(float32_val(fpa11->fpreg[Fn].fSingle), addr);
    ^~~~~~~~~~~~
/source/qemu/linux-user/qemu.h:515:13: error: lvalue required as left
operand of assignment
         (x) = 0;       \
             ^
/source/qemu/linux-user/qemu.h:536:32: note: in expansion of macro
‘get_user’
 #define get_user_u32(x, gaddr) get_user((x), (gaddr), uint32_t)
                                ^~~~~~~~
/source/qemu/linux-user/arm/nwfpe/fpa11_cpdt.c:37:4: note: in expansion
of macro ‘get_user_u32’
    get_user_u32(float32_val(fpa11->fpreg[Fn].fSingle), addr);
    ^~~~~~~~~~~~
