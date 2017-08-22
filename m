Received: from eggs.gnu.org ([2001:4830:134:3::10]:39375)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dk662-00046m-TA
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 06:07:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dk661-0001Ou-Sp
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 06:07:42 -0400
References: <1503076096-14220-1-git-send-email-thuth@redhat.com>
	<CAFEAcA_F1iFu8cbKCyxnjZP+hVY9DkrJZXHqZ65G10BqzcapQw@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <f7b75c78-1db3-7e82-d5cb-9cd8266077a9@redhat.com>
Date: Tue, 22 Aug 2017 12:07:29 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_F1iFu8cbKCyxnjZP+hVY9DkrJZXHqZ65G10BqzcapQw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] hw/arm/allwinner: Fix crash with
 -nodefaults -M cubieboard
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Beniamino Galvani <b.galvani@gmail.com>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Li Guang <lig.fnst@cn.fujitsu.com>

On 18.08.2017 19:14, Peter Maydell wrote:
> On 18 August 2017 at 18:08, Thomas Huth <thuth@redhat.com> wrote:
>> The allwinner-a10 device uses serial_hds[0] without checking whether
>> it is available or not. So using the cubieboard with -nodefaults
>> currently results in a segmentation fault. Fix it by adding a
>> proper check here.
>> And while we're at it, mark the device as "user_creatable = false"
>> since this apparently can not directly be used by the users but has
>> to be wired up in code instead.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  hw/arm/allwinner-a10.c | 8 ++++++--
>>  1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/arm/allwinner-a10.c b/hw/arm/allwinner-a10.c
>> index f62a9a3..e152566 100644
>> --- a/hw/arm/allwinner-a10.c
>> +++ b/hw/arm/allwinner-a10.c
>> @@ -109,8 +109,10 @@ static void aw_a10_realize(DeviceState *dev, Error **errp)
>>      sysbus_connect_irq(SYS_BUS_DEVICE(&s->sata), 0, s->irq[56]);
>>
>>      /* FIXME use a qdev chardev prop instead of serial_hds[] */
>> -    serial_mm_init(get_system_memory(), AW_A10_UART0_REG_BASE, 2, s->irq[1],
>> -                   115200, serial_hds[0], DEVICE_NATIVE_ENDIAN);
>> +    if (serial_hds[0]) {
>> +        serial_mm_init(get_system_memory(), AW_A10_UART0_REG_BASE, 2, s->irq[1],
>> +                       115200, serial_hds[0], DEVICE_NATIVE_ENDIAN);
>> +    }
> 
> This doesn't look like the right fix, because it means that
> there won't be a UART device at that point in system memory
> at all. What you want is for there to be a UART device there
> but not connected to anything, ie serial_mm_init() should cope
> with being passed a NULL Chardev*.

OK, makes sense. ... but I guess the patch to fix serial_mm_init() is
going to be a bigger patch, since serial_realize_core() currently
expects a char device, too, and thus needs to be reworked, too ... I'll
try to come up with something when I've got some more spare time...

 Thomas
