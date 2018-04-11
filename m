Received: from eggs.gnu.org ([2001:4830:134:3::10]:49110)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f6OBc-0001b5-DJ
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 18:25:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f6OBY-0003t6-Ly
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 18:25:52 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34186 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1f6OBY-0003lo-6F
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 18:25:48 -0400
References: <1519998711-73430-1-git-send-email-mjc@sifive.com>
	<1519998711-73430-20-git-send-email-mjc@sifive.com>
	<20180410062157.0f5876180d0ff5c89dd80393@gmail.com>
	<949f3787-7899-73ba-6c80-d3c20af68fda@redhat.com>
	<20180410110417.554bc8911fb2e2f0a3d99b2d@gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d888e75b-57a7-7188-82e9-013f8fe8f255@redhat.com>
Date: Wed, 11 Apr 2018 17:25:38 -0500
MIME-Version: 1.0
In-Reply-To: <20180410110417.554bc8911fb2e2f0a3d99b2d@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="1X3sVAMTBYQ6HqilwmjluCUlefLBeAJ1H"
Subject: Re: [Qemu-devel] [PATCH v8 19/23] SiFive RISC-V UART Device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Antony Pavlov <antonynpavlov@gmail.com>, Thomas Huth <thuth@redhat.com>
Cc: Michael Clark <mjc@sifive.com>, Stefan O'Rear <sorear2@gmail.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, qemu-devel@nongnu.org, RISC-V Patches <patches@groups.riscv.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1X3sVAMTBYQ6HqilwmjluCUlefLBeAJ1H
From: Eric Blake <eblake@redhat.com>
To: Antony Pavlov <antonynpavlov@gmail.com>, Thomas Huth <thuth@redhat.com>
Cc: Michael Clark <mjc@sifive.com>, Stefan O'Rear <sorear2@gmail.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmer@sifive.com>, qemu-devel@nongnu.org,
 RISC-V Patches <patches@groups.riscv.org>
Message-ID: <d888e75b-57a7-7188-82e9-013f8fe8f255@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v8 19/23] SiFive RISC-V UART Device
References: <1519998711-73430-1-git-send-email-mjc@sifive.com>
 <1519998711-73430-20-git-send-email-mjc@sifive.com>
 <20180410062157.0f5876180d0ff5c89dd80393@gmail.com>
 <949f3787-7899-73ba-6c80-d3c20af68fda@redhat.com>
 <20180410110417.554bc8911fb2e2f0a3d99b2d@gmail.com>
In-Reply-To: <20180410110417.554bc8911fb2e2f0a3d99b2d@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/10/2018 03:04 AM, Antony Pavlov wrote:

>>>> +++ b/include/hw/riscv/sifive_uart.h

>>>> +
>>>> +typedef struct SiFiveUARTState {
>>>> +    /*< private >*/
>>>> +    SysBusDevice parent_obj;
>>>
>>>
>>> You use SysBusDevive in this header file but there is no 'include "hw=
/sysbus.h"' in the header file itself.

That is, this header is not standalone; a .c file can't use the header
unless it first includes hw/sysbus.h prior to sifive_uart.h.

>>>
>>> Please see my comment https://github.com/riscv/riscv-qemu/pull/130#is=
suecomment-379640538
>>>
>>>
>>>> +    /*< public >*/
>>>> +    qemu_irq irq;
>>>> +    MemoryRegion mmio;
>>>> +    CharBackend chr;
>>>
>>> Just the same thing. CharBackend is defined in "chardev/char-fe.h" pl=
ease include it.

If you were to use a CharBackend*, you could get by with just the
typedef.  Since all .c files include osdeps.h, which in turn includes
typedefs.h, you wouldn't have to include anything if you only refer to
the type via a pointer.  But here, you are including a full object, so
the compiler has to know the size of the type, which means this header
DOES depend on "chardev/char-fe.h" being included first (either in this
=2Eh to keep it standalone, or in all .c files prior to the point where
they include sifive_uart.h).

>>
>> Honestly, I rather prefer to *not* add more includes to header files
>> than we already have. We already have got lots of "touch this header a=
nd
>> you have to recompile almost the whole QEMU" conditions, so to avoid
>> that this situation gets worse, we should rather avoid including heade=
rs
>> from headers if it is not necessary. Thus if the current sources build=

>> fine, no need to change anything here. Just my 0.02 =E2=82=AC.
>=20
> Adding ONLY NECESSARY header files inclusions to header file __can't pr=
oduce__
> additional recompile efforts.
> Moreover this can decrease number of include directives in c-files.

My personal preference: if your header only refers to a type via a
pointer where the header is still standalone with just the appropriate
typedefs, then DON'T include another .h from your header.  But if your
header has a hard dependency on something not already included by
osdeps.h, where failing to include that other header first creates a
compile error, then including the .h in your header is appropriate, as
it is less work for all .c clients that use your header.

The art of reducing compile-time dependencies is figuring out which
structs must be included inline (requiring .h in headers), and where you
can use pointers, or opaque types that live in .c, or whatever other
solutions, so that the headers become lighter-weight.  But it is NOT
designed to break standalone use of a header (other than the one
exception that headers DON'T include osdeps.h because that had to
already be included first by all .c files).

>=20
> I __rebased__ my RISC-V board in my out-of tree qemu branch (https://gi=
thub.com/miet-riscv-workgroup/riscv-qemu/tree/20180409.erizo). I faced wi=
th problem: I have to track dependencies of
> header files from include/hw/riscv/ which I use.
>=20
> So your "not-add-more-includes-to-header-files" approach has an disadva=
ntage:
> if a header file required header list changes, each c-file that include=
s that header file
> must be edited to update the #include statement list.

Indeed, that's why I argue that include statements in .h files that are
necessary for standalone compilation of that header is a good idea, and
not something to burden every .c file with.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--1X3sVAMTBYQ6HqilwmjluCUlefLBeAJ1H
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlrOi2IACgkQp6FrSiUn
Q2rupwf+PvewptqBN6skRO2Zw9oQFrMIj+UH3ugwaaB2BMyTPVaMAp7oGvvuvbEq
7RAl8i7KIoFwo44vC2QRiEP+LnteOMIzts4cTx7us8omYYXqB8kLjnEJaBxaWbTI
wXNii1GLvx8RO0T78PrjU1M2qA8N0S+PtINP4PXKH1LcYpjWB/mfgiPjWPt1Xa2H
xgt7olQsgldI+JtSzYEXtpjXEzTkRDN4ms+mM+gc+VRUjJjP08VyHIhrp+CV5RDk
JU46pQZE8hblToDxjqDoMBJCmPq6oUPCZ7Foum9i02PbZZ7kTGUwF24HYT9iQxfv
qxS0fPW+Y2s6Z/cpcQXGJ7Sl+6Ir3g==
=HheI
-----END PGP SIGNATURE-----

--1X3sVAMTBYQ6HqilwmjluCUlefLBeAJ1H--
