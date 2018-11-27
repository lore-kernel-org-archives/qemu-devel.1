Received: from eggs.gnu.org ([2001:4830:134:3::10]:57283)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1gRcwy-0006Vm-L7
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 07:58:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1gRcwu-0005jz-Rn
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 07:58:48 -0500
Received: from smtp.mail.uni-mannheim.de ([134.155.96.80]:46048)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sw@weilnetz.de>) id 1gRcwu-0005id-FS
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 07:58:44 -0500
References: <20181127121724.19755-1-sw@weilnetz.de>
	<CAFEAcA_gWYGnD2cAdGRWKKZRfddPvgQoS89nxM8=ro++fO+Gmw@mail.gmail.com>
From: Stefan Weil <sw@weilnetz.de>
Message-ID: <72c3ce85-a7a0-62a2-2add-41834b6fe1e4@weilnetz.de>
Date: Tue, 27 Nov 2018 13:58:53 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_gWYGnD2cAdGRWKKZRfddPvgQoS89nxM8=ro++fO+Gmw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-3.1 0/2] Fix disas/nanomips
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Aurelien Jarno <aurelien@aurel32.net>, Aleksandar Markovic <amarkovic@wavecomp.com>, Stefan Markovic <smarkovic@wavecomp.com>

Am 27.11.2018 um 13:36 schrieb Peter Maydell:
> On Tue, 27 Nov 2018 at 12:17, Stefan Weil <sw@weilnetz.de> wrote:
>> These two patches fix wrong format strings used in disas/nanomips.
>>
>> The first patch replaces proprietary data types by POSIX data types,
>> because otherwise the PRI... macros cannot be used in the second patch=
.
> I think this is a good idea, but that first patch is a huge patch for
> this point in the 3.1 release cycle. Can we fix the warnings
> by just casting the arguments to the img::format() function ?


Casting would be possible, but I try to avoid it if there are other
solutions.

The patch is huge, but the changes are purely mechanical. I used
commands like "perl -pi -e s/int64/int64_t/g nanomips.*" to make them.


>> Those patches are only relevant for 3.1 if full nanomips support is co=
nsidered
>> important enought and if QEMU is used on big endian machines (I think
>> the old code will work on little endian hosts even with wrong format
>> strings).
> It only affects the disassembler, which is a debug tool.
> A week ago this would have been a fairly definite "yes, fix it"
> issue; at this point, with rc3 due to go out today, it's a bit
> trickier to justify. (rc3 will be the last rc unless any showstopper
> issues turn up.)


Yes.


>> I use those patches for QEMU for Windows because that is compiled with
>> more compiler warnings, so compilation would fail without the fix.
> My Windows cross-compiler builds work OK, FWIW, and -Werror is
> only enabled by default for Linux builds, so warnings shouldn't
> result in build failures.


I forgot to mention another potential portability issue: the proprietary
data types which I removed in the first patch work on all relevant hosts
/ compilers which I know, but there might also be platforms where the
definitions are wrong:

-typedef unsigned short uint16;
-typedef unsigned int uint32;
-typedef long long int64;
-typedef unsigned long long uint64;

Nevertheless I think that 3.1 can also be released without changing disas=
/nanomips.

Stefan
=C2=A0
