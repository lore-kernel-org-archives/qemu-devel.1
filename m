Received: from eggs.gnu.org ([2001:4830:134:3::10]:41849)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1e6q9w-0007ZE-F7
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 23:45:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1e6q9t-0004Ql-D3
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 23:45:44 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
From: Programmingkid <programmingkidx@gmail.com>
In-Reply-To: <CAFEAcA_13y2-uM11Ko_79TpEsfpFWMTz2-mAiwFseHfAM5CPgA@mail.gmail.com>
Date: Mon, 23 Oct 2017 23:45:38 -0400
Content-Transfer-Encoding: quoted-printable
Message-Id: <FC571E15-495F-4D4D-9001-7FF76A74D162@gmail.com>
References: <20171023025016.3088-1-programmingkidx@gmail.com>
	<20171023160959.GC10220@stefanha-x1.localdomain>
	<CAFEAcA_13y2-uM11Ko_79TpEsfpFWMTz2-mAiwFseHfAM5CPgA@mail.gmail.com>
Subject: Re: [Qemu-devel] [libfdt][PATCH v3] implement strnlen for systems
 that need it
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, Richard Henderson <richard.henderson@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, devicetree-compiler@vger.kernel.org, ian@freebsd.org


> On Oct 23, 2017, at 12:27 PM, Peter Maydell <peter.maydell@linaro.org> =
wrote:
>=20
> On 23 October 2017 at 17:09, Stefan Hajnoczi <stefanha@gmail.com> =
wrote:
>>> +/* strnlen() is not available on Mac OS < 10.7 */
>>> +# if (MAC_OS_X_VERSION_MAX_ALLOWED < MAC_OS_X_VERSION_10_7)
>>=20
>> Does this cover the case where MAC_OS_X_VERSION_MAX_ALLOWED is set to
>> <1070 on a 10.7+ build machine?  It's possible that the <string.h>
>> header would define strnlen() and your code redefines the function
>> (compiler error).
>=20

I was operating under the assumption that MAC_OS_X_VERSION_MAX_ALLOWED =
would equal the version of the host. After making this little test =
program:

#include <stdio.h>
#include <AvailabilityMacros.h>

int main(int argc, char *argv[])
{
    printf("value =3D %d\n", MAC_OS_X_VERSION_MAX_ALLOWED);
}

It reports:
"value =3D 101204" on Mac OS 10.12.6 (I'm not sure why there is a 04)
and
"Value =3D 1068" on Mac OS 10.6.8

Is using MAC_OS_X_VERSION_MAX_ALLOWED not a reliable macro to use to =
test for the version of the Mac OS? The ui/cocoa.m file seems to use it =
and have no problems. I don't think we have to worry about =
MAC_OS_X_VERSION_MAX_ALLOWED being set to less than 1070 on Mac OS 10.7 =
and up.=20

> In that case you don't want to use the strnlen() declaration
> from the header, you want the inline somehow, because even if
> the declaration is present and using it doesn't fail compile
> the definition won't be around at runtime.
>=20
>> It would be best to check how <string.h>, <Availability.h>, and
>> <AvailabilityMacros.h> work to make sure that all cases are handled.  =
I
>> don't have access to a Mac right now, sorry.
>=20
> It uses the clang 'attribute availability' syntax:
> https://clang.llvm.org/docs/AttributeReference.html#availability

This feature appears to be a clang/gcc-only feature. Using it would mean =
making this code compiler locked. The Device Tree Compiler project (that =
this code belongs to) is made by IBM personnel. They might want to be =
able to use other compilers including their own IBM XL C compiler to =
compile this project. Even if that part of the code is only to run on =
Mac OS X I still would like to keep the code generic enough for any =
compiler to be able to build the Device Tree Compiler project.
