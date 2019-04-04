Received: from eggs.gnu.org ([209.51.188.92]:40235)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hC9Ia-0006tO-5P
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 16:49:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hC9IZ-00013v-0T
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 16:49:24 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53918)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hC9IY-00013O-OC
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 16:49:22 -0400
Received: by mail-wm1-f67.google.com with SMTP id q16so4547033wmj.3
	for <qemu-devel@nongnu.org>; Thu, 04 Apr 2019 13:49:22 -0700 (PDT)
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
References: <20190404071421.4891-1-thuth@redhat.com>
	<298ccbd7-9af5-8303-e42b-33dd1cb94b9e@redhat.com>
	<158fe22a-5781-73e5-5955-2fe9db019236@redhat.com>
	<3ba3c765-589f-4c0a-38dc-d9126f515e7b@redhat.com>
	<fda6bc0b-9ea0-2770-f104-568b3f16ab90@redhat.com>
Message-ID: <265f98b8-675c-99fb-0ef8-0dcc13c14a91@redhat.com>
Date: Thu, 4 Apr 2019 22:49:19 +0200
MIME-Version: 1.0
In-Reply-To: <fda6bc0b-9ea0-2770-f104-568b3f16ab90@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] hw/input/pckbd: The i8042 device should
 not be user_creatable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>

On 4/4/19 6:40 PM, Philippe Mathieu-Daudé wrote:
> On 4/4/19 4:19 PM, Thomas Huth wrote:
>> On 04/04/2019 15.29, Philippe Mathieu-Daudé wrote:
>>> On 4/4/19 12:07 PM, Paolo Bonzini wrote:
>>>> On 04/04/19 09:14, Thomas Huth wrote:
>>>>> The i8042 PS/2 controller is part of the chipset on the motherboard.
>>>>> It is instantiated by the machine init code, and it does not make sense
>>>>> to allow the user to plug an additional i8042 in any of the free ISA slots.
>>>>> Thus let's mark the device with user_creatable = false.
>>>>>
>>>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>>>> ---
>>>>>  hw/input/pckbd.c | 2 ++
>>>>>  1 file changed, 2 insertions(+)
>>>>
>>>> user_creatable is not for devices that are not pluggable in real life;
>>>> it is for devices that crash QEMU (!) or always fail if plugged by the user.
>>
>> ... hmm, but presenting devices to the user that are clearly not
>> intended for direct use is also not very nice, is it?
>>
>>>> So the question to ask is: would it make sense, and especially work, to
>>>> add an i8042 to machines that do have an ISA bridge (for example the Alpha?)
>>
>> I don't think so. It is a device that is supposed to be part of the
>> chipset on the motherboard, so operating systems certainly don't know
>> how to use this device on other machines.
>>
>> And at least some part of the device have to be set up in source code
>> (see e.g. i8042_setup_a20_line() ...).
>>
>>> Correct me if I'm wrong but it seems no machine directly use a 8042 on a
>>> ISA bus, it is always part of a SuperIO chipset. It is not reflected in
>>> the code (in particular the X86 machines, but I'm working on cleaning this).
>>
>> What about the "isa_create_simple(isa_bus, TYPE_I8042)" in mips_r4k.c ?
> 
> There is a comment at the top of the file:
> 
> " All peripherial devices are attached to this "bus" with the standard
> PC ISA addresses."
> 
> So IMO this setup is definitively modelable by an instance of the
> TYPE_ISA_SUPERIO abstract device.
> At a quick look the r4k has no parallel port and 4 uarts, so I'd add a
> such model internal to mips_r4k.c (see fdc37m81x_class_init()).

4 uarts because the code uses:

  serial_hds_isa_init(isa_bus, 0, MAX_ISA_SERIAL_PORTS);

which seems now an old API use where only instanciate/map uart device if
a -serial option is used (API changed in a8d78cd0a...b8846a4d6).

While I wonder if someone still use the r4k machine, I have more doubts
about users running with more the 2 -serial options...

Anyway I'll keep 4 for backward compatibility.

>>>>> diff --git a/hw/input/pckbd.c b/hw/input/pckbd.c
>>>>> index 47a606f5e3..af393818fc 100644
>>>>> --- a/hw/input/pckbd.c
>>>>> +++ b/hw/input/pckbd.c
>>>>> @@ -568,6 +568,8 @@ static void i8042_class_initfn(ObjectClass *klass, void *data)
>>>>>      dc->realize = i8042_realizefn;
>>>>>      dc->vmsd = &vmstate_kbd_isa;
>>>>>      set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
>>>>> +    /* i8042 is a device on the motherboard, and not pluggable by the user */
>>>
>>> I'm not sure the comment is accurate, maybe "ISA i8042 are provided by
>>> Super I/O devices"?
>>
>> Fine for me, too ... but what about mips_r4k in that case?
>>
>>  Thomas
>>
