Received: from eggs.gnu.org ([2001:4830:134:3::10]:49371)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eKO8k-0008SG-D4
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 07:40:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eKO8i-00032h-PS
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 07:40:30 -0500
References: <1512031988-32490-1-git-send-email-thuth@redhat.com>
	<1512031988-32490-4-git-send-email-thuth@redhat.com>
	<CAFEAcA-LBOm=kHja3QJqOw-TT3GF9-i+wJfXdL-FU5NKimknzQ@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <22aa483a-ede3-482d-88a9-ca1c03c37420@redhat.com>
Date: Thu, 30 Nov 2017 13:40:18 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-LBOm=kHja3QJqOw-TT3GF9-i+wJfXdL-FU5NKimknzQ@mail.gmail.com>
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
To: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Anthony Green <green@moxielogic.com>, Laurent Vivier <laurent@vivier.eu>, qemu-arm <qemu-arm@nongnu.org>, Edgar Iglesias <edgar.iglesias@gmail.com>, Richard Henderson <rth@twiddle.net>

On 30/11/2017 13:14, Peter Maydell wrote:
> On 30 November 2017 at 08:53, Thomas Huth <thuth@redhat.com> wrote:
>> +static const uint8_t kernel_mcf5208[] =3D {
>> +    0x41, 0xf9, 0xfc, 0x06, 0x00, 0x00,     /* lea 0xfc060000,%a0 */
>> +    0x10, 0x3c, 0x00, 0x54,                 /* move.b #'T',%d0 */
>> +    0x11, 0x7c, 0x00, 0x04, 0x00, 0x08,     /* move.b #4,8(%a0)     E=
nable TX */
>> +    0x11, 0x40, 0x00, 0x0c,                 /* move.b %d0,12(%a0)   P=
rint 'T' */
>> +    0x60, 0xfa                              /* bra.s  loop */
>> +};
>=20
> This approach doesn't seem to be scalable to me -- are we
> really going to have 50 or more fragments of hand-coded hex in
> this file to cover the various board models?
>=20
> I'd much rather see us have a framework for being able
> to build test blobs from source using a cross compiler
> setup (and docker or similar so anybody can rebuild
> the test blobs). That will be much easier to maintain
> and easier to extend to having tests that test other
> parts of the board or other aspects of TCG emulation.

It seems a bit overkill, as these snippets are ~16 bytes long.

However, it would be useful to have a basic patching mechanism so that
board descriptions could include a common hand-coded const array and
place an address at a given offset.  So you'd have

    struct HexFirmware {
        int     patch_offset;
        short   patch_size;
        bool    patch_bigendian;
        uint8_t data[32];
    }

and microblaze boards could have:

struct HexFirmware kernel_microblaze =3D {
    .patch_offset    =3D 0,
    .patch_size      =3D 2,
    .patch_bigendian =3D false,
    .data =3D {
        0xaa, 0xaa, 0x00, 0xb0,                 /* imm   0x???? */
        0x00, 0x10, 0x60, 0x30,                 /* addik r3,r0,0x1000 */
        0x54, 0x00, 0x80, 0x30,                 /* addik r4,r0,'T' */
        0x00, 0x00, 0x83, 0xf0,                 /* sbi   r4,r3,0 */
        0xfc, 0xff, 0x00, 0xb8,                 /* bri   -4  loop */
    }
};

...

    { "microblaze", "petalogix-s3adsp1800", "", "TT",
      kernel_microblaze, 0x8400 },
    { "microblazeel", "petalogix-ml605", "", "TT",
      kernel_microblaze, 0x83a0 },

Likewise, you could have just two copies of the code for all ARM boards
that have a pl011 (or any other UART with a simple byte-long transmit
register), one 32-bit and one 64-bit.

Thanks,

Paolo
