Received: from eggs.gnu.org ([209.51.188.92]:44598)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1gwbEd-0001Bf-AN
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 18:25:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1gwbEc-0006ZV-5E
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 18:25:03 -0500
Received: from zero.eik.bme.hu ([152.66.115.2]:50010)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1gwbEb-0006Vy-OG
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 18:25:02 -0500
Date: Thu, 21 Feb 2019 00:24:49 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <CAFEAcA84=uU8XTy=4jXdM80XBnn3CS0gJxspakhZpdxWnvo_+A@mail.gmail.com>
Message-ID: <alpine.BSF.2.21.9999.1902202345230.9479@zero.eik.bme.hu>
References: <20190211040434.1C98674569F@zero.eik.bme.hu>
	<8962bd1d-267d-2edf-b5ce-9b67896a2b2e@redhat.com>
	<alpine.BSF.2.21.9999.1902122354210.68636@zero.eik.bme.hu>
	<CAFEAcA84=uU8XTy=4jXdM80XBnn3CS0gJxspakhZpdxWnvo_+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

On Tue, 19 Feb 2019, Peter Maydell wrote:
> On Tue, 12 Feb 2019 at 23:59, BALATON Zoltan <balaton@eik.bme.hu> wrote=
:
>> On Tue, 12 Feb 2019, Philippe Mathieu-Daud=C3=A9 wrote:
>>> On 2/11/19 4:19 AM, BALATON Zoltan wrote:

This is where my question about valid/impl on mem ops started but I asked=
=20
separately again after not getting an answer here. Then Peter answered=20
here so I'm merging these threads again. I think for me this is solved=20
with that I can't use mem ops for this even if it was working so I'm only=
=20
recording here what I've found and will likely stay with implementing=20
this in the device model.

>> [...]
>>>> +
>>>> +static void ati_reg_write_offs(uint32_t *reg, int offs,
>>>> +                               uint64_t data, unsigned int size)
>>>> +{
>>>> +    int shift, i;
>>>> +    uint32_t mask;
>>>> +
>>>> +    for (i =3D 0; i < size; i++) {
>>>> +        shift =3D (offs + i) * 8;
>>>> +        mask =3D 0xffUL << shift;
>>>> +        *reg &=3D ~mask;
>>>> +        *reg |=3D (data & 0xff) << shift;
>>>> +        data >>=3D 8;
>>>
>>> I'd have use a pair of extract32/deposit32 but this is probably easie=
r
>>> to singlestep.
>>
>> You've told me that before but I have concerns about the asserts in th=
ose
>> functions which to me seem like unnecessary overhead in such low level
>> functions so unless these are removed or *_noassert versions introduce=
d
>> I'll stay away from them.
>
> The code above is IMHO pretty hard to read -- you have to
> think through all the shifts and masks to figure out exactly
> what is being done. I would definitely recommend extract32/deposit32,
> as they convey the intent much better. You're already inside a
> register accessor for a device model, there is much more overhead
> on this path than a few assert condition checks. (And they do
> catch bugs -- they found one in the arm code last month.)
>
> (Alternatively, if you believe the overhead of the asserts matters,
> then provide benchmarking demonstrating it, and we could look
> at restricting this assert to the case where start and length are
> compile-time constant, or to only the --enable-debug build.)
>
>> But I'm also not too happy about these *_offs functions but some regis=
ters
>> support 8/16/32 bit access and guest code seems to actually do this to
>> update bits in the middle of the register at an odd address. Best woul=
d be
>> if I could just set .impl.min =3D 4, .impl.max =3D 4 and .valid.min =3D=
 1
>> .valid.max =3D 4 for the mem region ops but I'm not sure that would wo=
rk or
>> would it? If that's working maybe I should just go with that instead.
>
> This will work, but only if all the registers in the memory region
> are happy with "read 32 bits, write back 32 bits", ie they have
> no "write-1-to-clear", "special behaviour on read", etc. (The
> memory system will implement byte reads as "read 32 bits, modify,
> write back".) If it does work then that's a nice way to do it.

Based on a quick try This does not seem to work. With setting=20
impl.{min,max}=3D4 and valid.min=3D1 valid.max=3D4 I get:

ati_mm_write 4 0x9c0  <- 0x0
ati_mm_write 4 0x55  <- 0x4
ati_mm_write 4 0x50  <- 0x3000200

where this was before:

ati_mm_write 4 0x9c0  <- 0x0
ati_mm_write 1 0x55  <- 0x4
ati_mm_write 4 0x50  <- 0x3000200

and should probably be something like:

ati_mm_read 4 0x54  -> 0x0
ati_mm_write 4 0x54  <- 0x400

if access was adjusted as expected. So only the size was adjusted but not=
=20
the address or value. Should I also add unaligned to either valid or impl=
?=20
But probably that would not help either, I see a comment saying:
/* FIXME: support unaligned access? */ in memory.c:access_with_adjusted_s=
ize().

But now I think that it would be a better idea to not use valid/impl for=20
this but keep a local function (maybe rewritten to use deposit/extract)=20
for now and use that explicitely. This is better for two reasons: no adde=
d=20
read before write which might have side effects and also can model device=
=20
better which only allows unaligned access to some registers but not all.=20
It's a bit more code but I think this cannot be correctly handled by the=20
memory subsystem anyway even if the above is fixed.

>> Anything that
>> distracts from actual values and makes it harder to read (such as
>> timestamps and pids added by trace)
>
> -d trace:your_trace_event doesn't add timestamps or PIDs, FWIW.

Neither this seems to work, I still get pid@timestamp: added to log lines=
=20
with this (same as with -trace enable=3Dpattern). Should I use something=20
else than "log" trace backend? (But I can live with this, it's only=20
slightly distracting as this is before the log line so I can just start=20
reading from the colon, the interesting info is at the end of the line=20
anyway.)

Regards,
BALATON Zoltan
