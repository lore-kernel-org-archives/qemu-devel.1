Received: from eggs.gnu.org ([2001:4830:134:3::10]:40327)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dZIEx-0001w6-4u
	for qemu-devel@nongnu.org; Sun, 23 Jul 2017 10:52:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dZIEu-0005ib-38
	for qemu-devel@nongnu.org; Sun, 23 Jul 2017 10:52:15 -0400
References: <20170718061005.29518-1-f4bug@amsat.org>
	<20170718061005.29518-20-f4bug@amsat.org>
	<CAJ+F1CJL8krrmFwCgqx6qZepkNZbcvTJrkOEVcsWiHurCBcUZw@mail.gmail.com>
	<3b25ec9f-5711-de4c-eade-eecef96b6379@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a49428cc-88e9-dbd8-3d2f-207acbef68f9@redhat.com>
Date: Sun, 23 Jul 2017 16:52:05 +0200
MIME-Version: 1.0
In-Reply-To: <3b25ec9f-5711-de4c-eade-eecef96b6379@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 19/29] disas: use QEMU_IS_ALIGNED macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, qemu trival <qemu-trivial@nongnu.org>, Michael Tokarev <mjt@tls.msk.ru>, QEMU <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>

On 18/07/2017 16:43, Thomas Huth wrote:
> On 18.07.2017 13:07, Marc-Andr=C3=A9 Lureau wrote:
>> Hi
>>
>> On Mon, Jul 17, 2017 at 11:09 PM, Philippe Mathieu-Daud=C3=A9
>> <f4bug@amsat.org> wrote:
>>> Applied using the Coccinelle semantic patch scripts/coccinelle/use_os=
dep.cocci
> [...]
>>> diff --git a/disas.c b/disas.c
>>> index d335c55bbf..8b59448286 100644
>>> --- a/disas.c
>>> +++ b/disas.c
>>> @@ -151,7 +151,7 @@ static int print_insn_objdump(bfd_vma pc, disasse=
mble_info *info,
>>>      info->read_memory_func(pc, buf, n, info);
>>>
>>>      for (i =3D 0; i < n; ++i) {
>>> -        if (i % 32 =3D=3D 0) {
>>> +        if (QEMU_IS_ALIGNED(i, 32)) {
>>>              info->fprintf_func(info->stream, "\n%s: ", prefix);
>>>          }
>>>          info->fprintf_func(info->stream, "%02x", buf[i]);
>=20
> This looks wrong to me. QEMU_IS_ALIGNED should be used for addresses an=
d
> similar things. This part here is about pretty printing a hex dump.
>=20
> The code should likely be converted to use qemu_hexdump() instead, I gu=
ess.

qemu_hexdump only works with FILE*.

But I agree that QEMU_IS_ALIGNED looks weird here.  I think it should
mostly be used when the argument is a pointer, to hide the cast.  Uses
for non-pointer arguments should be decided on a one-by-one basis; "is
the first argument an address" is definitely a good thing to consider.
Another might be "is the second argument a variable", because "i % n =3D=3D
0" is less efficient than "(i & (n - 1)) =3D=3D 0".

Paolo


Paolo
