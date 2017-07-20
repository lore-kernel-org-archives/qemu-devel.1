Received: from eggs.gnu.org ([2001:4830:134:3::10]:48288)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dYIhP-0000jb-J6
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 17:09:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dYIhO-0005TE-3J
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 17:09:31 -0400
Received: from mail-wm0-x235.google.com ([2a00:1450:400c:c09::235]:37458)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dYIhN-0005SN-TI
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 17:09:30 -0400
Received: by mail-wm0-x235.google.com with SMTP id g127so37255441wmd.0
	for <qemu-devel@nongnu.org>; Thu, 20 Jul 2017 14:09:29 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <7ca287e3-c496-b58f-7df6-e0e82ea56ff0@ilande.co.uk>
References: <768886e5-c27a-a6d9-b5f1-b6712c76b7a0@ilande.co.uk>
	<7ca287e3-c496-b58f-7df6-e0e82ea56ff0@ilande.co.uk>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 20 Jul 2017 22:09:08 +0100
Message-ID: <CAFEAcA9=Rs1iB9kns0rAg-dTatho0Pa+yELFxGvYyvmEBPF-sg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Build failure on git master
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel <qemu-devel@nongnu.org>

On 20 July 2017 at 20:29, Mark Cave-Ayland
<mark.cave-ayland@ilande.co.uk> wrote:
> On 19/07/17 18:09, Mark Cave-Ayland wrote:
>
>> Hi all,
>>
>> I see the following build failure here on git master with gcc 4.7.2:
>>
>> cc -I/home/build/src/qemu/git/qemu/block -Iblock
>> -I/home/build/src/qemu/git/qemu/tcg
>> -I/home/build/src/qemu/git/qemu/tcg/i386
>> -I/home/build/src/qemu/git/qemu/linux-headers
>> -I/home/build/src/qemu/git/qemu/linux-headers -I.
>> -I/home/build/src/qemu/git/qemu
>> -I/home/build/src/qemu/git/qemu/accel/tcg
>> -I/home/build/src/qemu/git/qemu/include -I/usr/include/pixman-1
>> -I/home/build/src/qemu/git/qemu/dtc/libfdt -Werror -pthread
>> -I/usr/include/glib-2.0 -I/usr/lib/x86_64-linux-gnu/glib-2.0/include
>> -m64 -mcx16 -D_GNU_SOURCE -D_FILE_OFFSET_BITS=3D64 -D_LARGEFILE_SOURCE
>> -Wstrict-prototypes -Wredundant-decls -Wall -Wundef -Wwrite-strings
>> -Wmissing-prototypes -fno-strict-aliasing -fno-common -fwrapv
>> -Wendif-labels -Wno-missing-include-dirs -Wempty-body -Wnested-externs
>> -Wformat-security -Wformat-y2k -Winit-self -Wignored-qualifiers
>> -Wold-style-declaration -Wold-style-definition -Wtype-limits
>> -fstack-protector-all -I/usr/include/p11-kit-1
>> -I/usr/include/libpng12   -I/home/build/src/qemu/git/qemu/tests -MMD -MP
>> -MT block/vpc.o -MF block/vpc.d -O2 -U_FORTIFY_SOURCE
>> -D_FORTIFY_SOURCE=3D2 -g   -c -o block/vpc.o block/vpc.c
>> block/vpc.c: In function =E2=80=98vpc_co_pwritev=E2=80=99:
>> block/vpc.c:652:9: error: =E2=80=98ret=E2=80=99 may be used uninitialize=
d in this
>> function [-Werror=3Dmaybe-uninitialized]
>> cc1: all warnings being treated as errors
>> make: *** [block/vpc.o] Error 1
>>
>> At a quick glance it looks as if this is being caused by commit cfc87e00
>> "block/vpc.c: Handle write failures in get_image_offset()".
>
> The fix is seemingly quite simple:
>
> diff --git a/block/vpc.c b/block/vpc.c
> index 10e6519..574879b 100644
> --- a/block/vpc.c
> +++ b/block/vpc.c
> @@ -649,7 +649,7 @@ vpc_co_pwritev(BlockDriverState *bs, uint64_t
> offset, uint64_t bytes,
>      int64_t image_offset;
>      int64_t n_bytes;
>      int64_t bytes_done =3D 0;
> -    int ret;
> +    int ret =3D 0;
>      VHDFooter *footer =3D  (VHDFooter *) s->footer_buf;

Yeah, I think 4.7.2 isn't smart enough to realize this is
a false positive (and that compiler is getting old enough
that it's not in the set I usually test with).

Do you want to send a proper patch?

thanks
-- PMM
