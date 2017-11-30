Received: from eggs.gnu.org ([2001:4830:134:3::10]:52127)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eKOJk-0005AP-3u
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 07:51:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eKOJj-0007dj-5X
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 07:51:52 -0500
References: <1512031988-32490-1-git-send-email-thuth@redhat.com>
	<1512031988-32490-4-git-send-email-thuth@redhat.com>
	<CAFEAcA-LBOm=kHja3QJqOw-TT3GF9-i+wJfXdL-FU5NKimknzQ@mail.gmail.com>
	<22aa483a-ede3-482d-88a9-ca1c03c37420@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <34115e36-ab8c-d828-d1a1-3ac7f32ae80b@redhat.com>
Date: Thu, 30 Nov 2017 13:51:42 +0100
MIME-Version: 1.0
In-Reply-To: <22aa483a-ede3-482d-88a9-ca1c03c37420@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-2.12 3/7] tests/boot-serial-test: Add
 support for the mcf5208evb board
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Anthony Green <green@moxielogic.com>, Laurent Vivier <laurent@vivier.eu>, qemu-arm <qemu-arm@nongnu.org>, Edgar Iglesias <edgar.iglesias@gmail.com>, Richard Henderson <rth@twiddle.net>

On 30.11.2017 13:40, Paolo Bonzini wrote:
> On 30/11/2017 13:14, Peter Maydell wrote:
>> On 30 November 2017 at 08:53, Thomas Huth <thuth@redhat.com> wrote:
>>> +static const uint8_t kernel_mcf5208[] =3D {
>>> +    0x41, 0xf9, 0xfc, 0x06, 0x00, 0x00,     /* lea 0xfc060000,%a0 */
>>> +    0x10, 0x3c, 0x00, 0x54,                 /* move.b #'T',%d0 */
>>> +    0x11, 0x7c, 0x00, 0x04, 0x00, 0x08,     /* move.b #4,8(%a0)     =
Enable TX */
>>> +    0x11, 0x40, 0x00, 0x0c,                 /* move.b %d0,12(%a0)   =
Print 'T' */
>>> +    0x60, 0xfa                              /* bra.s  loop */
>>> +};
>>
>> This approach doesn't seem to be scalable to me -- are we
>> really going to have 50 or more fragments of hand-coded hex in
>> this file to cover the various board models?
>>
>> I'd much rather see us have a framework for being able
>> to build test blobs from source using a cross compiler
>> setup (and docker or similar so anybody can rebuild
>> the test blobs). That will be much easier to maintain
>> and easier to extend to having tests that test other
>> parts of the board or other aspects of TCG emulation.
>=20
> It seems a bit overkill, as these snippets are ~16 bytes long.
>=20
> However, it would be useful to have a basic patching mechanism so that
> board descriptions could include a common hand-coded const array and
> place an address at a given offset.  So you'd have
>=20
>     struct HexFirmware {
>         int     patch_offset;
>         short   patch_size;
>         bool    patch_bigendian;
>         uint8_t data[32];
>     }
>=20
> and microblaze boards could have:
>=20
> struct HexFirmware kernel_microblaze =3D {
>     .patch_offset    =3D 0,
>     .patch_size      =3D 2,
>     .patch_bigendian =3D false,
>     .data =3D {
>         0xaa, 0xaa, 0x00, 0xb0,                 /* imm   0x???? */
>         0x00, 0x10, 0x60, 0x30,                 /* addik r3,r0,0x1000 *=
/
>         0x54, 0x00, 0x80, 0x30,                 /* addik r4,r0,'T' */
>         0x00, 0x00, 0x83, 0xf0,                 /* sbi   r4,r3,0 */
>         0xfc, 0xff, 0x00, 0xb8,                 /* bri   -4  loop */
>     }
> };
>=20
> ...
>=20
>     { "microblaze", "petalogix-s3adsp1800", "", "TT",
>       kernel_microblaze, 0x8400 },
>     { "microblazeel", "petalogix-ml605", "", "TT",
>       kernel_microblaze, 0x83a0 },

The two micrablaze data arrays are completely different, since one is
big endian, the other is little, so I'd need to byte-swap the whole
array on the fly, too. Not sure whether it makes sense to add such
complex code just to safe 16 bytes of blob data...?

> Likewise, you could have just two copies of the code for all ARM boards
> that have a pl011 (or any other UART with a simple byte-long transmit
> register), one 32-bit and one 64-bit.

OK, having a patching mechanism in place likely makes sense as soon as
we want to include multiple ARM boards here. I can do that, but I'd
rather like to do it as a second step. It was already quite hard work to
come up with all these assembler snippets (from CPUs where I don't have
a clue of) and to determine which machines could be tested this way at
all, so I'd first like to wait and see whether this patch series is
acceptable at all or not, since Peter has objections.

 Thomas
