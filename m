Received: from eggs.gnu.org ([209.51.188.92]:42183)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hC3P0-0004mp-SY
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 10:31:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hC3De-000283-6F
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 10:19:55 -0400
References: <20190404071421.4891-1-thuth@redhat.com>
	<298ccbd7-9af5-8303-e42b-33dd1cb94b9e@redhat.com>
	<158fe22a-5781-73e5-5955-2fe9db019236@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <3ba3c765-589f-4c0a-38dc-d9126f515e7b@redhat.com>
Date: Thu, 4 Apr 2019 16:19:27 +0200
MIME-Version: 1.0
In-Reply-To: <158fe22a-5781-73e5-5955-2fe9db019236@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
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
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-trivial@nongnu.org

On 04/04/2019 15.29, Philippe Mathieu-Daud=C3=A9 wrote:
> On 4/4/19 12:07 PM, Paolo Bonzini wrote:
>> On 04/04/19 09:14, Thomas Huth wrote:
>>> The i8042 PS/2 controller is part of the chipset on the motherboard.
>>> It is instantiated by the machine init code, and it does not make sen=
se
>>> to allow the user to plug an additional i8042 in any of the free ISA =
slots.
>>> Thus let's mark the device with user_creatable =3D false.
>>>
>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>> ---
>>>  hw/input/pckbd.c | 2 ++
>>>  1 file changed, 2 insertions(+)
>>
>> user_creatable is not for devices that are not pluggable in real life;
>> it is for devices that crash QEMU (!) or always fail if plugged by the=
 user.

... hmm, but presenting devices to the user that are clearly not
intended for direct use is also not very nice, is it?

>> So the question to ask is: would it make sense, and especially work, t=
o
>> add an i8042 to machines that do have an ISA bridge (for example the A=
lpha?)

I don't think so. It is a device that is supposed to be part of the
chipset on the motherboard, so operating systems certainly don't know
how to use this device on other machines.

And at least some part of the device have to be set up in source code
(see e.g. i8042_setup_a20_line() ...).

> Correct me if I'm wrong but it seems no machine directly use a 8042 on =
a
> ISA bus, it is always part of a SuperIO chipset. It is not reflected in
> the code (in particular the X86 machines, but I'm working on cleaning t=
his).

What about the "isa_create_simple(isa_bus, TYPE_I8042)" in mips_r4k.c ?

>>> diff --git a/hw/input/pckbd.c b/hw/input/pckbd.c
>>> index 47a606f5e3..af393818fc 100644
>>> --- a/hw/input/pckbd.c
>>> +++ b/hw/input/pckbd.c
>>> @@ -568,6 +568,8 @@ static void i8042_class_initfn(ObjectClass *klass=
, void *data)
>>>      dc->realize =3D i8042_realizefn;
>>>      dc->vmsd =3D &vmstate_kbd_isa;
>>>      set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
>>> +    /* i8042 is a device on the motherboard, and not pluggable by th=
e user */
>=20
> I'm not sure the comment is accurate, maybe "ISA i8042 are provided by
> Super I/O devices"?

Fine for me, too ... but what about mips_r4k in that case?

 Thomas
