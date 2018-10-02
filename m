Received: from eggs.gnu.org ([2001:4830:134:3::10]:48836)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1g7QXU-0003Ad-0b
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 15:41:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1g7QXQ-0007fn-17
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 15:40:59 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:39617)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1g7QXP-0007fb-QH
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 15:40:55 -0400
Received: by mail-wr1-x443.google.com with SMTP id 61-v6so2805565wrb.6
	for <qemu-devel@nongnu.org>; Tue, 02 Oct 2018 12:40:55 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20181001220942.2382-1-f4bug@amsat.org>
	<20181001220942.2382-10-f4bug@amsat.org>
	<CAFEAcA_DBU6-_EqZP2-bh+JkWeP3s9kcrtJSHLmeziPYcU0nnQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <7f9534ac-0c7f-51da-1b0a-b8b43fe38178@amsat.org>
Date: Tue, 2 Oct 2018 21:40:52 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_DBU6-_EqZP2-bh+JkWeP3s9kcrtJSHLmeziPYcU0nnQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 09/15] hw/mips/malta: Replace 'empty_slot'
 by 'unimplemented_device'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?C=c3=a9dric_Le_Goate?= =?UTF-8?Q?r?= <clg@kaod.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Aleksandar Markovic <amarkovic@wavecomp.com>, Andrew Jeffery <andrew@aj.id.au>

On 10/2/18 3:23 PM, Peter Maydell wrote:
> On 1 October 2018 at 23:09, Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>> The TYPE_EMPTY_SLOT and TYPE_UNIMPLEMENTED_DEVICE are identical devices,
>> however the later use more recent APIs and is more widely used.
>>
>> Replace 'empty_slot' by 'unimplemented_device' to simplify devices code
>> maintenance.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>>  default-configs/mips-softmmu-common.mak | 1 -
>>  hw/mips/mips_malta.c                    | 4 ++--
>>  2 files changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git a/default-configs/mips-softmmu-common.mak b/default-configs/mips-softmmu-common.mak
>> index fae2347ee7..f9d664e120 100644
>> --- a/default-configs/mips-softmmu-common.mak
>> +++ b/default-configs/mips-softmmu-common.mak
>> @@ -32,7 +32,6 @@ CONFIG_PFLASH_CFI01=y
>>  CONFIG_I8259=y
>>  CONFIG_MC146818RTC=y
>>  CONFIG_ISA_TESTDEV=y
>> -CONFIG_EMPTY_SLOT=y
>>  CONFIG_MIPS_CPS=y
>>  CONFIG_MIPS_ITU=y
>>  CONFIG_I2C=y
>> diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
>> index 40041d5ec0..4ccfa87c35 100644
>> --- a/hw/mips/mips_malta.c
>> +++ b/hw/mips/mips_malta.c
>> @@ -53,7 +53,7 @@
>>  #include "sysemu/qtest.h"
>>  #include "qapi/error.h"
>>  #include "qemu/error-report.h"
>> -#include "hw/empty_slot.h"
>> +#include "hw/misc/unimp.h"
>>  #include "sysemu/kvm.h"
>>  #include "exec/semihost.h"
>>  #include "hw/mips/cps.h"
>> @@ -1216,7 +1216,7 @@ void mips_malta_init(MachineState *machine)
>>      /* The whole address space decoded by the GT-64120A doesn't generate
>>         exception when accessing invalid memory. Create an empty slot to
>>         emulate this feature. */
>> -    empty_slot_init(0, 0x20000000);
>> +    create_unimplemented_device("gt64120-SysAD", 0, 0x20000000);
>>
>>      qdev_init_nofail(dev);
> 
> Not sure about this one. unimplemented_device means "there should
> be something here, but QEMU's model is incomplete", and if the user
> asks for 'unimp' warnings via the -d option then all accesses will
> generate logging. In this MIPS board, we're modelling the hardware's
> actual behaviour, and we shouldn't generate debug messages that
> imply that QEMU has unimplemented functionality here.
> 
> If we were writing a model of the Malta board from scratch we'd
> probably do it by having the GT-64120A be modelled as a device
> which was a container object that instantiated all its various
> bits and pieces and mapped them into a MemoryRegion that spanned
> the whole 1GB size of that part of the address space. We could
> then give that MR a background region with the "RAZ/WI" behaviour
> the hardware requires.

Is 'git revert c7c3c9f8' a good example of your explanation?
