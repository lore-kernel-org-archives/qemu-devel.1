Received: from eggs.gnu.org ([2001:4830:134:3::10]:43502)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1daJUd-0005Bu-Nw
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 06:24:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1daJUc-0001z7-IG
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 06:24:39 -0400
Received: from mail-wm0-x235.google.com ([2a00:1450:400c:c09::235]:37685)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1daJUc-0001yl-9W
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 06:24:38 -0400
Received: by mail-wm0-x235.google.com with SMTP id c184so77463029wmd.0
	for <qemu-devel@nongnu.org>; Wed, 26 Jul 2017 03:24:38 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <D06632B7-4405-47C8-BCF6-3C90274923E4@gmail.com>
References: <65ED9743-B53C-4E6A-866F-C883650914CE@gmail.com>
	<91ba54de-b2eb-f3a9-eb0f-a697b7698149@amsat.org>
	<D06632B7-4405-47C8-BCF6-3C90274923E4@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 26 Jul 2017 11:24:16 +0100
Message-ID: <CAFEAcA_BRPRAmA5cJEtsY8zn0K358peX5PzvD05vZys1swo0EQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] hw/core/loader-fit.c:105:41: error: expected
 expression
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Programmingkid <programmingkidx@gmail.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>

On 26 July 2017 at 06:15, Programmingkid <programmingkidx@gmail.com> wrote:
>
>> On Jul 26, 2017, at 12:13 AM, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg> wrote:
>>
>> Hi John,
>>
>> On 07/25/2017 07:55 PM, Programmingkid wrote:
>>> While compiling the mips64el-softmmu target I encountered these errors:
>>>   CC      hw/display/g364fb.o
>>> hw/core/loader-fit.c:105:41: error: expected expression
>>>         *addr =3D fdt32_to_cpu(*(fdt32_t *)prop);
>>>                                         ^
>>> hw/core/loader-fit.c:105:32: error: use of undeclared identifier 'fdt32=
_t'
>>
>> It seems you are missing the libfdt headers, so indeed you found bug.

Configure requires libfdt to exist to enable mips64el-softmmu,
so something is going wrong with our configure test compared
to how QEMU itself is being built.

> That appears to help make things move past the loader-fit.c file. Here ar=
e the new errors:
>
>   CC      hw/core/loader-fit.o
>   CC      hw/dma/rc4030.o
>   CC      hw/ide/via.o
> hw/core/loader-fit.c:105:41: error: expected expression
>         *addr =3D fdt32_to_cpu(*(fdt32_t *)prop);
>                                         ^

...this is still failing on loader-fit.c in the same way.

>> And also the ./configure output, I'm interested by:
>>
>> "fdt support       no=E2=80=9D
>
> Actually it was "fdt support       yes=E2=80=9D.

Configure thinks the fdt headers are available...

> ./configure --target-list=3Dmips64el-softmmu
> Install prefix    /usr/local
> BIOS directory    /usr/local/share/qemu
> binary directory  /usr/local/bin
> library directory /usr/local/lib
> module directory  /usr/local/lib/qemu
> libexec directory /usr/local/libexec
> include directory /usr/local/include
> config directory  /usr/local/etc
> local state directory   /usr/local/var
> Manual directory  /usr/local/share/man
> ELF interp prefix /usr/gnemul/qemu-%M
> Source path       /Users/john/Documents/Development/Projects/Qemu/qemu-gi=
t
> C compiler        cc
> Host C compiler   cc
> C++ compiler      c++
> Objective-C compiler clang
> ARFLAGS           rv
> CFLAGS            -O2 -g
> QEMU_CFLAGS       -I/usr/local/Cellar/pixman/0.34.0/include/pixman-1 -I$(=
SRC_PATH)/dtc/libfdt -D_REENTRANT -I/usr/local/Cellar/glib/2.46.2/include

...and it's put our local copy of libfdt on the include path.

The fdt32_t type that the compiler is complaining
about ought to be defined in the header in
dtc/libfdt/libfdt_env.h.

I wonder if you have an old copy of that submodule;
if so then "git submodule update" ought to fix it.

thanks
-- PMM
