Received: from eggs.gnu.org ([2001:4830:134:3::10]:59437)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eRvjc-0004b4-Gm
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 02:57:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eRvjZ-0003vd-BT
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 02:57:44 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:52876)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1eRvjZ-0003v9-13
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 02:57:41 -0500
References: <20171220203528.21334-1-laurent@vivier.eu>
	<CAAdtpL73-1-vSqe+A59Tu_-tT-CSnVy0b1VbsAVSmGYVxBcALQ@mail.gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <37c5db22-72cf-c409-4257-8d44f4d24416@vivier.eu>
Date: Thu, 21 Dec 2017 08:57:34 +0100
MIME-Version: 1.0
In-Reply-To: <CAAdtpL73-1-vSqe+A59Tu_-tT-CSnVy0b1VbsAVSmGYVxBcALQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] target/m68k: add monitor.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Thomas Huth <huth@tuxfamily.org>

Le 20/12/2017 à 21:54, Philippe Mathieu-Daudé a écrit :
> On Wed, Dec 20, 2017 at 5:35 PM, Laurent Vivier <laurent@vivier.eu> wrote:
>> This allows to use registers content in the monitor.
>>
>> Example:
>>
>>  BEFORE:
>>   (qemu) print $d0
>>   unknown register
>>
>>  AFTER:
>>   (qemu) print $d0
>>   0
>>   (qemu) print $sr
>>   0x2000
>>   (qemu) x/10i $pc
>>   0x40010a2a:  movew %sr,%d0
>>   0x40010a2c:  oril #1792,%d0
>>   0x40010a32:  movew %d0,%sr
>>   0x40010a34:  movel %a0@,%d0
>>   0x40010a36:  btst #3,%d0
>>   0x40010a3a:  beqs 0x40010a26
>>   0x40010a3c:  movew %sr,%d0
>>   0x40010a3e:  andil #63743,%d0
>>   0x40010a44:  movew %d0,%sr
>>   0x40010a46:  rts
>>
>> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
>> ---
>>  target/m68k/Makefile.objs |  1 +
>>  target/m68k/monitor.c     | 55 +++++++++++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 56 insertions(+)
>>  create mode 100644 target/m68k/monitor.c
>>
>> diff --git a/target/m68k/Makefile.objs b/target/m68k/Makefile.objs
>> index 39141ab93d..d143f20270 100644
>> --- a/target/m68k/Makefile.objs
>> +++ b/target/m68k/Makefile.objs
>> @@ -1,3 +1,4 @@
>>  obj-y += m68k-semi.o
>>  obj-y += translate.o op_helper.o helper.o cpu.o fpu_helper.o
>>  obj-y += gdbstub.o
>> +obj-$(CONFIG_SOFTMMU) += monitor.o
>> diff --git a/target/m68k/monitor.c b/target/m68k/monitor.c
>> new file mode 100644
>> index 0000000000..03d037ccab
>> --- /dev/null
>> +++ b/target/m68k/monitor.c
>> @@ -0,0 +1,55 @@
>> +/*
>> + * QEMU monitor
>> + *
>> + * Copyright (c) 2003-2004 Fabrice Bellard
>> + *
>> + * Permission is hereby granted, free of charge, to any person obtaining a copy
>> + * of this software and associated documentation files (the "Software"), to deal
>> + * in the Software without restriction, including without limitation the rights
>> + * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
>> + * copies of the Software, and to permit persons to whom the Software is
>> + * furnished to do so, subject to the following conditions:
>> + *
>> + * The above copyright notice and this permission notice shall be included in
>> + * all copies or substantial portions of the Software.
>> + *
>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
>> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
>> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
>> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
>> + * THE SOFTWARE.
>> + */
>> +#include "qemu/osdep.h"
>> +#include "cpu.h"
>> +#include "monitor/hmp-target.h"
>> +
>> +const MonitorDef monitor_defs[] = {
> 
> adding 'static':

ok

> Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

Thanks,
Laurent
