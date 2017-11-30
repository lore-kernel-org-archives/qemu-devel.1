Received: from eggs.gnu.org ([2001:4830:134:3::10]:48512)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eKO5g-0007cE-8H
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 07:37:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eKO5f-00019T-50
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 07:37:20 -0500
References: <1512031988-32490-1-git-send-email-thuth@redhat.com>
	<1512031988-32490-4-git-send-email-thuth@redhat.com>
	<CAFEAcA-LBOm=kHja3QJqOw-TT3GF9-i+wJfXdL-FU5NKimknzQ@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <e56ccc1b-17fd-fc44-cc11-d63de2952c79@redhat.com>
Date: Thu, 30 Nov 2017 13:37:09 +0100
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Anthony Green <green@moxielogic.com>, Laurent Vivier <laurent@vivier.eu>, qemu-arm <qemu-arm@nongnu.org>, Edgar Iglesias <edgar.iglesias@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On 30.11.2017 13:14, Peter Maydell wrote:
> On 30 November 2017 at 08:53, Thomas Huth <thuth@redhat.com> wrote:
>> We can output a character quite easily here with some few lines of
>> assembly that we provide as a mini-kernel for this board.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  tests/boot-serial-test.c | 10 ++++++++++
>>  1 file changed, 10 insertions(+)
>>
>> diff --git a/tests/boot-serial-test.c b/tests/boot-serial-test.c
>> index d997269..dd3828c 100644
>> --- a/tests/boot-serial-test.c
>> +++ b/tests/boot-serial-test.c
>> @@ -16,6 +16,14 @@
>>  #include "qemu/osdep.h"
>>  #include "libqtest.h"
>>
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

No, since this only works for certain few boards with these criteria:

1) There must be a way to load such small blobs either with -kernel or
-bios. Many boards only support loading kernels in the ELF format, and
we certainly don't want to encode the hex-dump of such a kernel here.
Or some boards / CPUs also support -bios, but the entry point must be at
the end of a large image, so that also does not make sense to include
them here.

2) The UART must be usable with some few lines of assembly. That's also
not always the case.

So no, this is really not meant to scale to all boards, it's just meant
to get at least some few more test coverage, especially while we're not
having other test mechanisms in place yet. (e.g. how long are we talking
about reviving tests/tcg/ again already? ... some attempts have been
made to make it compilable again, but non of the patch series has been
included yet so far)

> I'd much rather see us have a framework for being able
> to build test blobs from source using a cross compiler
> setup (and docker or similar so anybody can rebuild
> the test blobs). That will be much easier to maintain
> and easier to extend to having tests that test other
> parts of the board or other aspects of TCG emulation.

I agree that this idea is way more flexible and could cover many more
boards, but there are also things that need to be solved first:
Not everybody has docker / cross-compilers installed or can use them, so
we likely need a set of pre-build binary images somewhere. But we
certainly don't want to include megabytes of blobs in the git repository
... so this would need to go into an external repository instead. Then
you likely can not include this in "make check" so easily anymore
(unless you force everybody to check out the external repository with
the git-submodule.sh script - but I really dislike this idea) ...

So yes, we should have better test coverage for almost all machines if
possible, but I don't see that this is happening soon or could be really
tightly integrated into "make check". I.e. the boot-serial tester could
fill at least parts of this gap, I think.

 Thomas
