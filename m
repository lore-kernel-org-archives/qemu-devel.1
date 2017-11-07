Received: from eggs.gnu.org ([2001:4830:134:3::10]:59055)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eC5FE-0000QO-17
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 09:52:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eC5F9-0001OD-61
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 09:52:52 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
References: <20171103202624.5956-1-laurent@vivier.eu>
	<db255c93-a4c6-216d-8ea3-10f340a916f6@amsat.org>
	<257f2a30-6607-cb14-3bbf-27b95d962cf4@amsat.org>
	<89487dfd-f941-871f-e822-68a6fbace6fe@vivier.eu>
	<23b10dc0-2bb6-b53d-dfaa-a641630f8aaf@amsat.org>
Message-ID: <8fdc98d4-edea-4239-a32f-23882fbff9d2@amsat.org>
Date: Tue, 7 Nov 2017 11:52:27 -0300
MIME-Version: 1.0
In-Reply-To: <23b10dc0-2bb6-b53d-dfaa-a641630f8aaf@amsat.org>
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

On 11/04/2017 01:18 PM, Philippe Mathieu-Daudé wrote:
> On 11/04/2017 05:55 AM, Laurent Vivier wrote:
>> Le 03/11/2017 à 22:51, Philippe Mathieu-Daudé a écrit :
>>>> On 11/03/2017 05:26 PM, Laurent Vivier wrote:
>>>>> This series fixes some errors found by
>>>>> enabling USE_SOFTFLOAT_STRUCT_TYPES.
>>> [...]
>>>>
>>>> I'm getting those errors:
>>>>
>>>> $ make subdir-arm-softmmu -j2
>>>>
>>>> /source/qemu/migration/vmstate-types.c:430:5: error: conversion to
>>>> non-scalar type requested
>>>>      qemu_put_be64(f, float64_val(*v));
>>>>      ^~~~~~~~~~~~~
>>>> make: *** [migration/vmstate-types.o] Error 1
> [...]
>>
>> These series doesn't fix all the problems, only the easiest to fix...
>>
>> for this one, you need:
>>
>> diff --git a/migration/vmstate-types.c b/migration/vmstate-types.c
>> index 48184c380d..0c273d616a 100644
>> --- a/migration/vmstate-types.c
>> +++ b/migration/vmstate-types.c
>> @@ -425,7 +425,7 @@ static int get_float64(QEMUFile *f, void *pv, size_t
>> size,
>>  static int put_float64(QEMUFile *f, void *pv, size_t size, VMStateField
>> *field,
>>                         QJSON *vmdesc)
>>  {
>> -    uint64_t *v = pv;
>> +    float64 *v = pv;
>>
>>      qemu_put_be64(f, float64_val(*v));
>>      return 0;
> 
> If you respin with this one you can add my Reviewed-by + Tested-by.
> 
> Another error:
> 
> $ make subdir-aarch64-softmmu
> [...]
>   CC      target/arm/helper-a64.o
> /source/qemu/target/arm/helper-a64.c: In function ‘helper_simd_tbl’:
> /source/qemu/target/arm/helper-a64.c:162:38: error: incompatible type
> for argument 1 of ‘extract64’
>              uint64_t val = extract64(env->vfp.regs[elt], bitidx, 8);
>                                       ^~~
> In file included from /source/qemu/include/qemu/bitmap.h:16:0,
>                  from /source/qemu/include/hw/qdev-core.h:6,
>                  from /source/qemu/include/qom/cpu.h:23,
>                  from /source/qemu/target/arm/cpu-qom.h:23,
>                  from /source/qemu/target/arm/cpu.h:39,
>                  from /source/qemu/target/arm/helper-a64.c:21:
> /source/qemu/include/qemu/bitops.h:316:24: note: expected ‘uint64_t {aka
> long unsigned int}’ but argument is of type ‘float64 {aka struct
> <anonymous>}’
>  static inline uint64_t extract64(uint64_t value, int start, int length)
>                         ^~~~~~~~~
> make: *** [target/arm/helper-a64.o] Error 1

OK with:

- uint64_t val = extract64(env->vfp.regs[elt], bitidx, 8);
+ uint64_t val = extract64(float64_val(env->vfp.regs[elt]), bitidx, 8);
