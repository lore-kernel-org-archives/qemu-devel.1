Received: from eggs.gnu.org ([209.51.188.92]:44420)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1gti59-00024w-7C
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 19:07:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1gthxy-0001Lf-8U
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 18:59:56 -0500
Received: from zero.eik.bme.hu ([152.66.115.2]:53884)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1gthxw-00019V-Cx
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 18:59:54 -0500
Date: Wed, 13 Feb 2019 00:59:40 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <8962bd1d-267d-2edf-b5ce-9b67896a2b2e@redhat.com>
Message-ID: <alpine.BSF.2.21.9999.1902122354210.68636@zero.eik.bme.hu>
References: <20190211040434.1C98674569F@zero.eik.bme.hu>
	<8962bd1d-267d-2edf-b5ce-9b67896a2b2e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] hw/display: Add basic ATI VGA emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>

Hello,

On Tue, 12 Feb 2019, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi Zoltan,

Thanks for the quick review and testing. I'll use your suggestions for th=
e=20
other (mips) patches in a v2. For this one I'm not convinced.

> On 2/11/19 4:19 AM, BALATON Zoltan wrote:
[...]
>> +
>> +static void ati_reg_write_offs(uint32_t *reg, int offs,
>> +                               uint64_t data, unsigned int size)
>> +{
>> +    int shift, i;
>> +    uint32_t mask;
>> +
>> +    for (i =3D 0; i < size; i++) {
>> +        shift =3D (offs + i) * 8;
>> +        mask =3D 0xffUL << shift;
>> +        *reg &=3D ~mask;
>> +        *reg |=3D (data & 0xff) << shift;
>> +        data >>=3D 8;
>
> I'd have use a pair of extract32/deposit32 but this is probably easier
> to singlestep.

You've told me that before but I have concerns about the asserts in those=
=20
functions which to me seem like unnecessary overhead in such low level=20
functions so unless these are removed or *_noassert versions introduced=20
I'll stay away from them.

But I'm also not too happy about these *_offs functions but some register=
s=20
support 8/16/32 bit access and guest code seems to actually do this to=20
update bits in the middle of the register at an odd address. Best would b=
e=20
if I could just set .impl.min =3D 4, .impl.max =3D 4 and .valid.min =3D 1=
=20
.valid.max =3D 4 for the mem region ops but I'm not sure that would work =
or=20
would it? If that's working maybe I should just go with that instead.

[...]
>> diff --git a/hw/display/ati_int.h b/hw/display/ati_int.h
>> new file mode 100644
>> index 0000000000..85d045517c
>> --- /dev/null
>> +++ b/hw/display/ati_int.h
>> @@ -0,0 +1,67 @@
>> +/*
>> + * QEMU ATI SVGA emulation
>> + *
>> + * Copyright (c) 2019 BALATON Zoltan
>> + *
>> + * This work is licensed under the GNU GPL license version 2 or later=
.
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "hw/pci/pci.h"
>> +#include "vga_int.h"
>> +
>> +#undef DEBUG_ATI
>> +
>> +#ifdef DEBUG_ATI
>> +#define DPRINTF(fmt, ...) printf("%s: " fmt, __func__, ## __VA_ARGS__=
)
>> +#else
>> +#define DPRINTF(fmt, ...) do {} while (0)
>
> Please use tracepoints (you already add some!).

I won't and here's why: This is not a finished device model and I expect=20
to need to add debug logs and change them frequently during further=20
development and for such ad-hoc debugging DPRINF is still easier to use=20
because I don't have to define the format string at one file and use them=
=20
somewhere else. With DPRINTF I can just add a debug log at one place and=20
change it easily without editing it at two unrelated places so it's easie=
r=20
to work with. Once development is finished those that we intend to leave=20
in for later tracing can be converted to trace points (for which trace=20
point is better) and at that point remove the DPRINTF macro. We still hav=
e=20
enough DPRINTFs in QEMU so this should be OK. I've already added trace=20
points to two such places but even for those I almost considered ditching=
=20
them when checkpatch insisted I have to add 0x prefix to hex numbers (I=20
don't like this because I know these are hex and printing e.g. 0x8 instea=
d=20
of 8 is just distracting from the actual important value which is what=20
counts when I'm looking at a lot of these during debugging. Anything that=
=20
distracts from actual values and makes it harder to read (such as=20
timestamps and pids added by trace) is bad so I've considered going back=20
to DPRINTF even for those trace points but will see if I can live with=20
these for now.) But those that are still DPRINTFs won't be converted to=20
trace but supposed to be removed when no longer needed.

[...]
> I don't understand well the display code, but the result works very
> well, nice work :)
>
> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Thanks, it's a start and currently only targeting Linux console with a lo=
t=20
more to do for it to be more useful. But I have limited time for this so=20
since it's already useful to get mips_fulong2e working I thought that=20
justifies including it now so others have a chance to look at it and mayb=
e=20
even help to improve it which can't happen if it's only sitting on my=20
machine.

Regards,
BALATON Zoltan
