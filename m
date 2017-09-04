Received: from eggs.gnu.org ([2001:4830:134:3::10]:50813)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dou4O-0005bI-1U
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 12:17:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dou4J-0004n7-D8
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 12:17:52 -0400
Received: from mail-wr0-x22c.google.com ([2a00:1450:400c:c0c::22c]:32910)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dou4J-0004mJ-6M
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 12:17:47 -0400
Received: by mail-wr0-x22c.google.com with SMTP id a43so2916799wrc.0
	for <qemu-devel@nongnu.org>; Mon, 04 Sep 2017 09:17:47 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <a91359d6-457c-7164-18f9-050193f2d419@vivier.eu>
References: <20170903163130.14288-1-n54@gmx.com>
	<9f33a768-77d1-191b-8be3-35d625752cbf@vivier.eu>
	<1257d6ba-9ca1-0940-af9e-a9ea7dea0287@amsat.org>
	<941d403b-7413-517f-23af-2c0c88a3ec57@gmx.com>
	<c1c4d90a-380f-4bd1-8aa4-8a970241020d@vivier.eu>
	<CAFEAcA-RUoY5X1KsS2eAkte6G3g2CC_YYMg1e1XxxWd420LBow@mail.gmail.com>
	<a91359d6-457c-7164-18f9-050193f2d419@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 4 Sep 2017 17:17:25 +0100
Message-ID: <CAFEAcA8VYnJgru6bV7_tNkPoJSKm3pwTH=8oJRdpTEW9PXycug@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] target/m68k: Change fpu_rom from const
 static array to switch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: Kamil Rytarowski <n54@gmx.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, QEMU Developers <qemu-devel@nongnu.org>

On 4 September 2017 at 16:53, Laurent Vivier <laurent@vivier.eu> wrote:
> Le 04/09/2017 =C3=A0 17:02, Peter Maydell a =C3=A9crit :
>> On 4 September 2017 at 15:09, Laurent Vivier <laurent@vivier.eu> wrote:
>>> You can:
>>>
>>> either replace the "#define floatx80_pi make_floatx80(...)" by a "const
>>> floatx80 floatx80_pi =3D make_floatx80_init(...)"
>>>
>>> or replace all the macros in the m68k/fpu_helper.c array by
>>> make_floatx80_init(...)
>>
>> Taking a step back, what's different about floatx80 and float12
>> that means they need separate _init and non-init versions of
>> the macros, when for float16/float32/float64 we instead have
>> #define make_float32(x) __extension__ ({ float32 f32_val =3D {x}; f32_va=
l; })
>> #define const_float32(x) { x }
>
> floatx80/float128 are structureq while float16/float32/float64 are
> native data types.

If USE_SOFTFLOAT_STRUCT_TYPES is defined then float16/32/64 are
also struct types and use the make_ and const_ macros as above.

(We should check whether USE_SOFTFLOAT_STRUCT_TYPES still builds,
it tends to bitrot. If it does then maybe we should use it by default
since gcc 3 is now just a memory...)

>> ? Could we move to consistency for the macro naming we're using?
>
> Do you mean "s/make_floatx80_init/const_floatx80/"?

Yes (and the same implementation would be nice too).

thanks
-- PMM
