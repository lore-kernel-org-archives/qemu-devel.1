Received: from eggs.gnu.org ([2001:4830:134:3::10]:46894)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dinZN-000409-7v
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 16:08:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dinZK-0002f0-2u
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 16:08:37 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:33078)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dinZJ-0002eo-TQ
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 16:08:34 -0400
Received: by mail-qt0-x243.google.com with SMTP id 57so352075qtu.0
	for <qemu-devel@nongnu.org>; Fri, 18 Aug 2017 13:08:33 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170817043102.6322-1-f4bug@amsat.org>
	<20170817172249.31cf5e3d@nial.brq.redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <e3552801-588d-a192-1da4-0cefee5aa483@amsat.org>
Date: Fri, 18 Aug 2017 17:08:29 -0300
MIME-Version: 1.0
In-Reply-To: <20170817172249.31cf5e3d@nial.brq.redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 0/8] QOMify MIPS cpu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, James Hogan <james.hogan@imgtec.com>, Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org, =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>, Yongbok Kim <yongbok.kim@imgtec.com>, Aurelien Jarno <aurelien@aurel32.net>James Hogan <james.hogan@imgtec.com>

On 08/17/2017 12:22 PM, Igor Mammedov wrote:
> On Thu, 17 Aug 2017 01:30:54 -0300
> Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
[...]
>> Also I couldn't test it with KVM.
> Tested in TCG mode (boots debian mips/mips64 kernel with different cpu types),
> and new CPU leaf types show up on QOM tree as expected (QOMifycation is done as expected)

you mean the "info qom-tree" output?

> and '-cpu help' also works as expected,
> so with checkpatch issues fixed you may add to patches my
> 
> Tested-by: Igor Mammedov <imammedo@redhat.com>

ok thanks for the testing!

I'll wait to see if there is some KVM feedback from imgtec folks before 
spaming a v2.

>> Igor Mammedov (2):
>>    mips: MIPSCPU model subclasses
>>    mips: replace cpu_mips_init() with cpu_generic_init()
>>
>> Philippe Mathieu-Daudé (6):
>>    mips: move hw/mips/cputimer.c to target/mips/
>>    mips: introduce internal.h and cleanup cpu.h
>>    mips: split cpu_mips_realize_env() out of cpu_mips_init()
>>    mips: call cpu_mips_realize_env() from mips_cpu_realizefn()
>>    mips: now than MIPSCPU is QOMified, mark it abstract
>>    mips: update mips_cpu_list() to use object_class_get_list()
>>
>>   target/mips/cpu-qom.h                         |   1 +
>>   target/mips/cpu.h                             | 357 +---------------------
>>   target/mips/internal.h                        | 422 ++++++++++++++++++++++++++
>>   hw/mips/cps.c                                 |   2 +-
>>   hw/mips/mips_fulong2e.c                       |   2 +-
>>   hw/mips/mips_jazz.c                           |   2 +-
>>   hw/mips/mips_malta.c                          |   2 +-
>>   hw/mips/mips_mipssim.c                        |   2 +-
>>   hw/mips/mips_r4k.c                            |   2 +-
>>   hw/mips/cputimer.c => target/mips/cp0_timer.c |   2 +-
>>   target/mips/cpu.c                             |  57 +++-
>>   target/mips/gdbstub.c                         |   1 +
>>   target/mips/helper.c                          |  47 +++
>>   target/mips/kvm.c                             |   1 +
>>   target/mips/machine.c                         |   1 +
>>   target/mips/msa_helper.c                      |   1 +
>>   target/mips/op_helper.c                       |   1 +
>>   target/mips/translate.c                       |  23 +-
>>   target/mips/translate_init.c                  |  68 +----
>>   hw/mips/Makefile.objs                         |   2 +-
>>   target/mips/Makefile.objs                     |   2 +-
>>   21 files changed, 549 insertions(+), 449 deletions(-)
>>   create mode 100644 target/mips/internal.h
>>   rename hw/mips/cputimer.c => target/mips/cp0_timer.c (99%)
