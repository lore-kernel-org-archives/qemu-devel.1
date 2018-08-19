Received: from eggs.gnu.org ([2001:4830:134:3::10]:54210)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1frJPH-0003WD-3Y
	for qemu-devel@nongnu.org; Sun, 19 Aug 2018 04:49:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1frJPD-0008MD-WF
	for qemu-devel@nongnu.org; Sun, 19 Aug 2018 04:49:55 -0400
References: <CABLmASE2HTZPBVFM=grds+9RmPyh2naJ2KwNjb81LD0+E+yrtA@mail.gmail.com>
	<b897eaf6-9504-ddfc-ae60-1ac4a865d12e@redhat.com>
	<de02ae3c-3355-eb83-3216-5c87c3e917ff@weilnetz.de>
	<CABLmASEbeVBJRczqvMVvL4wPtJ38oayHOF0FUWK+Ap9Jfd182g@mail.gmail.com>
From: Stefan Weil <sw@weilnetz.de>
Message-ID: <86c072e1-6439-9134-f96d-2663bb8a7c0d@weilnetz.de>
Date: Sun, 19 Aug 2018 10:49:22 +0200
MIME-Version: 1.0
In-Reply-To: <CABLmASEbeVBJRczqvMVvL4wPtJ38oayHOF0FUWK+Ap9Jfd182g@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="cNedf27EGDKv2e4pn2xKfurgNQj4fjjiX"
Subject: Re: [Qemu-devel] Bugs when cross-compiling qemu for Windows with
 mingw 8.1, executable doesn't run
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Howard Spoelstra <hsp.cat7@gmail.com>
Cc: David Hildenbrand <david@redhat.com>, qemu-ppc <qemu-ppc@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--cNedf27EGDKv2e4pn2xKfurgNQj4fjjiX
From: Stefan Weil <sw@weilnetz.de>
To: Howard Spoelstra <hsp.cat7@gmail.com>
Cc: David Hildenbrand <david@redhat.com>, qemu-ppc <qemu-ppc@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Message-ID: <86c072e1-6439-9134-f96d-2663bb8a7c0d@weilnetz.de>
Subject: Re: [Qemu-devel] Bugs when cross-compiling qemu for Windows with
 mingw 8.1, executable doesn't run
References: <CABLmASE2HTZPBVFM=grds+9RmPyh2naJ2KwNjb81LD0+E+yrtA@mail.gmail.com>
 <b897eaf6-9504-ddfc-ae60-1ac4a865d12e@redhat.com>
 <de02ae3c-3355-eb83-3216-5c87c3e917ff@weilnetz.de>
 <CABLmASEbeVBJRczqvMVvL4wPtJ38oayHOF0FUWK+Ap9Jfd182g@mail.gmail.com>
In-Reply-To: <CABLmASEbeVBJRczqvMVvL4wPtJ38oayHOF0FUWK+Ap9Jfd182g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Am 18.08.2018 um 22:51 schrieb Howard Spoelstra:
> On Sat, Aug 18, 2018 at 9:09 PM, Stefan Weil <sw@weilnetz.de> wrote:
>> Am 17.08.2018 um 09:32 schrieb David Hildenbrand:
>>> No being a win32/mingw expert, Stefan any idea?
>>
>>
>> I'd try a debug build (configure [...] --enable-debug).
>>
>> My installers (https://qemu.weilnetz.de/w64/) were built with
>> x86_64-w64-mingw32-gcc (GCC) 6.3.0 20170516 (from Debian Stretch).
>> Howard, perhaps you can try whether they show the same runtime SIGSEGV=
=2E
>> When I run your command line with a dummy disk image, OpenBIOS boots f=
ine.
>>
>> Kind regards,
>> Stefan
>=20
> The error I reported already came from a debug build.
> Other builds with less recent mingw (7.3 in Fedora 28) do not SIGSEGV,
> neither do Stefan's.
> I can confirm the strncpy warnings are gone using Philippe's patches.
>=20
> Best,
> Howard


I can now reproduce the runtime problem (although I get a different error=
):

Debian experimental provides x86_64-w64-mingw32-gcc (GCC) 8.2-win32
20180726. I now used that compiler for my build. In addition to the
compiler errors reported by Howard, I also get similar errors for
hw/acpi/core.c and hw/acpi/aml-build.c.

The resulting binary starts running OpenBIOS, but then it fails (tested
with wine):

=2E/configure --cross-prefix=3Dx86_64-w64-mingw32- && make

dd if=3D/dev/zero of=3D9.2.qcow2 bs=3D1M count=3D32

wine ppc-softmmu/qemu-system-ppc.exe -L pc-bios -boot c -m 256 -M
"mac99,via=3Dpmu" -prom-env "boot-args=3D-v" -prom-env "auto-boot?=3Dtrue=
"
-prom-env "vga-ndrv?=3Dtrue" -hda 9.2.qcow2 -netdev "user,id=3Dnetwork01"=

-device "sungem,netdev=3Dnetwork01" -d int

*** stack smashing detected ***:  terminated
wine: Unhandled illegal instruction at address 0x68ac2fe0 (thread 002c),

QEMU for Linux with gcc 8.2 works fine.

Stefan


--cNedf27EGDKv2e4pn2xKfurgNQj4fjjiX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEESSNv6nXJXWmOwreK4Iwh1Wd0UK0FAlt5LxgACgkQ4Iwh1Wd0
UK0ttRAAgaUiGR2r7e4+RULb7UYFAah12GvfHZEQXslLoGLnm6zaO7Ny2TXW32M7
tdLfFjl+FmtiuL+M6dV7iLqGwOPdyd2pb7KmnYqAJKb5dDFvQPZWIk4BUPFRf3+a
0ML1j+Q+FOlxhOlw8MVbU4rBIYbifHoCYkrhQ39dBtDCm0fbzBTLEmEiA7QKB0F/
mb+CJChkjzc+Ul0e8QUOZ3zOwew0gBNtFnJ8Z9REEmN1O62dETremBSc3PqL++dw
S+2Jb84XKUTdFGdxNj1iZ5aE5EgWQOs0pAcjZwJ0zApWyF3GSpApPb+5hq4mJ6Vp
9vuu1mBkUqMgv3Run6jvs9cEh52/B5r4efVICtpN2z1X/vsKienkJ2JfH7oZAsJs
WhKdaLI3adYLEVorayqHud4c4r+waUaiyDtASEX5zv7BpvTymLk56YQVcShlInqJ
jWJa986q2tZtlHvyKq7RV6M96qw8iRNeViePJIyAKVBrk8K45OedHKCrClpQQ7E8
wEQ0BvAf1shdn9WgjkqfAzcqePmJP+TlCySH0WDhpvVqZzsZRkz0mPyTpycWgFnU
16PI3K9hg64TC6E/f7MnTpkECrCS7blDwcfOrc+uN4j9S6l3p3alakXvKPhSGXkL
bijuP7/YcwOqvhVy4PbrDoB6eNUxsnv0M5Ycyoc+Lq1BjegCFRI=
=eoy4
-----END PGP SIGNATURE-----

--cNedf27EGDKv2e4pn2xKfurgNQj4fjjiX--
