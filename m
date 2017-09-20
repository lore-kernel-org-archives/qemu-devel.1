Received: from eggs.gnu.org ([2001:4830:134:3::10]:38923)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dujE8-0006l2-SU
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 13:56:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dujE4-0006gu-NJ
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 13:56:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39280)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1dujE4-0006Y7-FT
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 13:55:56 -0400
References: <20170916010330.10435-1-jsnow@redhat.com>
	<CAFEAcA8un6eescSDzd+P+jqEGuGkuQXgfjm+1=CPOydg6WQSnQ@mail.gmail.com>
	<fb54f008-2913-3cd2-df95-41b1fcf3f2ee@redhat.com>
	<CAFEAcA9=syrPXD5cAq_EHWre_NniO1kZiWVAQXMDEnRuk=20ew@mail.gmail.com>
	<CAFEAcA9XgboiDD3SYsaJLRVMr=onckWU3VN-3ogd4DwH5fV3zw@mail.gmail.com>
	<824faf32-38bc-f3b9-cafb-f60cbd7fd8a7@ilande.co.uk>
From: John Snow <jsnow@redhat.com>
Message-ID: <93915fa3-cadb-7639-79bf-e23c39129352@redhat.com>
Date: Wed, 20 Sep 2017 13:55:54 -0400
MIME-Version: 1.0
In-Reply-To: <824faf32-38bc-f3b9-cafb-f60cbd7fd8a7@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 00/11] Ide patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>



On 09/20/2017 01:02 PM, Mark Cave-Ayland wrote:
> On 18/09/17 19:14, Peter Maydell wrote:
>=20
>> On 18 September 2017 at 19:00, Peter Maydell <peter.maydell@linaro.org=
> wrote:
>>> On 18 September 2017 at 18:55, John Snow <jsnow@redhat.com> wrote:
>>>> On 09/16/2017 10:34 AM, Peter Maydell wrote:
>>>>> Hi; I'm afraid this doesn't build with clang:
>>>>>
>>>>> /home/petmay01/linaro/qemu-for-merges/hw/ide/core.c:70:15: error:
>>>>> comparison of unsigned enum expression >=3D 0 is always true
>>>>> [-Werror,-Wtautological-compare]
>>>>>     if (enval >=3D 0 && enval < IDE_DMA__COUNT) {
>>>>>         ~~~~~ ^  ~
>>>>> 1 error generated
>>
>>
>>> I think you could argue that it would at least be helpful
>>> if clang didn't warn about comparisons that only happen
>>> to be useless for this particular platform/impdef choice
>>> but are useful for the same code compiled with a different
>>> compiler.
>>
>> A bit of googling and some experimentation reveals that
>> clang deliberately suppresses this warning in the special
>> case of comparing against an enum value which happens to
>> be zero (but not for literal constant zero!). So this will
>> be fine:
>>    if (enval >=3D IDE_DMA_READ && enval < IDE_DMA__COUNT)
>>
>> (or more sensibly you'd want to define an enum constant
>> for IDE_DMA__FIRST or something rather than relying on
>> READ being 0.)
>>
>> (found here:
>> http://clang-developers.42468.n3.nabble.com/Possibly-invalid-enum-taut=
ology-warning-td3233140.html
>> )
>=20
> Doing a git pull and even with the applied version of this patch I get =
a
> build failure on my local gcc-4.7:
>=20
> cc -I/home/build/src/qemu/git/qemu/hw/ide -Ihw/ide
> -I/home/build/src/qemu/git/qemu/tcg
> -I/home/build/src/qemu/git/qemu/tcg/i386
> -I/home/build/src/qemu/git/qemu/linux-headers
> -I/home/build/src/qemu/git/qemu/linux-headers -I.
> -I/home/build/src/qemu/git/qemu
> -I/home/build/src/qemu/git/qemu/accel/tcg
> -I/home/build/src/qemu/git/qemu/include -I/usr/include/pixman-1
> -I/home/build/src/qemu/git/qemu/dtc/libfdt -Werror -pthread
> -I/usr/include/glib-2.0 -I/usr/lib/x86_64-linux-gnu/glib-2.0/include
> -m64 -mcx16 -D_GNU_SOURCE -D_FILE_OFFSET_BITS=3D64 -D_LARGEFILE_SOURCE
> -Wstrict-prototypes -Wredundant-decls -Wall -Wundef -Wwrite-strings
> -Wmissing-prototypes -fno-strict-aliasing -fno-common -fwrapv
> -Wendif-labels -Wno-missing-include-dirs -Wempty-body -Wnested-externs
> -Wformat-security -Wformat-y2k -Winit-self -Wignored-qualifiers
> -Wold-style-declaration -Wold-style-definition -Wtype-limits
> -fstack-protector-all -I/usr/include/p11-kit-1
> -I/usr/include/libpng12   -I/home/build/src/qemu/git/qemu/tests -MMD -M=
P
> -MT hw/ide/core.o -MF hw/ide/core.d -O2 -U_FORTIFY_SOURCE
> -D_FORTIFY_SOURCE=3D2 -g   -c -o hw/ide/core.o hw/ide/core.c
> hw/ide/core.c: In function =E2=80=98IDE_DMA_CMD_str=E2=80=99:
> hw/ide/core.c:71:5: error: comparison of unsigned expression >=3D 0 is
> always true [-Werror=3Dtype-limits]
> cc1: all warnings being treated as errors
> make: *** [hw/ide/core.o] Error 1
>=20
> Are there any other workarounds for this at all?
>=20
>=20
> ATB,
>=20
> Mark.
>=20

Guh. From which distro does your GCC 4.7 hail?

Regardless, I suppose I will revert to Eric's workaround, though I like
the way it reads an awful lot less.

--js
