Received: from eggs.gnu.org ([209.51.188.92]:41941)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1gw4FQ-0003yM-7W
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 07:11:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1gw4FO-0004B7-NK
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 07:11:39 -0500
Received: from zero.eik.bme.hu ([152.66.115.2]:20105)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1gw4FM-00045t-Lm
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 07:11:38 -0500
Date: Tue, 19 Feb 2019 13:11:23 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <CAFEAcA84=uU8XTy=4jXdM80XBnn3CS0gJxspakhZpdxWnvo_+A@mail.gmail.com>
Message-ID: <alpine.BSF.2.21.9999.1902191300340.87875@zero.eik.bme.hu>
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
Cc: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>

On Tue, 19 Feb 2019, Peter Maydell wrote:
> On Tue, 12 Feb 2019 at 23:59, BALATON Zoltan <balaton@eik.bme.hu> wrote=
:
>> On Tue, 12 Feb 2019, Philippe Mathieu-Daud=C3=A9 wrote:
>>> On 2/11/19 4:19 AM, BALATON Zoltan wrote:
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

OK, I'll try this and if it works that should be the best until a w1tc re=
g=20
is found.

>> I won't and here's why: This is not a finished device model and I expe=
ct
>> to need to add debug logs and change them frequently during further
>> development and for such ad-hoc debugging DPRINF is still easier to us=
e
>> because I don't have to define the format string at one file and use t=
hem
>> somewhere else.
>
> If you want to use local debug printfs for your convenience that's fine=
.
> You don't have to submit them in the patches you send. (I use them
> quite a bit in development, and my stack of patches usually has a
> patch at the end called "debug junk" with that kind of thing in it.)
> But new code we take into upstream should be preferring trace events
> over ad-hoc DPRINTF.

I could do that but that wouldn't help anyone but me. Since the device=20
model is far from finished at the moment I expect anyone who tries it wit=
h=20
anything more complex than Linux framebuffer and maybe X driver will need=
=20
to debug and fix it to add more features their drivers need and I'd like=20
to make their job easier because I'd like to encourage people to help=20
finishing this. (It would probably take me alone about 2 years=20
otherwise with the current rate of effort I can put in this.) So not=20
having any debug facilities to help this is counterproductive at this=20
stage. Once the model is more finished these can be removed or turned int=
o=20
trace points but not yet I think. This wouldn't be the only device with=20
DPRINTFs in QEMU so as a special case I think this makes sense to allow i=
t=20
to use DPRINTF as well for development.

>> Anything that
>> distracts from actual values and makes it harder to read (such as
>> timestamps and pids added by trace)
>
> -d trace:your_trace_event doesn't add timestamps or PIDs, FWIW.

Thanks, I was looking for that option but couldn't find yet.

Regards,
BALATON Zoltan
