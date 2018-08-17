Received: from eggs.gnu.org ([2001:4830:134:3::10]:60220)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fqZEv-0006Om-Vk
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 03:32:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fqZEs-0007rB-P5
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 03:32:09 -0400
References: <CABLmASE2HTZPBVFM=grds+9RmPyh2naJ2KwNjb81LD0+E+yrtA@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <b897eaf6-9504-ddfc-ae60-1ac4a865d12e@redhat.com>
Date: Fri, 17 Aug 2018 09:32:03 +0200
MIME-Version: 1.0
In-Reply-To: <CABLmASE2HTZPBVFM=grds+9RmPyh2naJ2KwNjb81LD0+E+yrtA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
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
To: Howard Spoelstra <hsp.cat7@gmail.com>, qemu-ppc <qemu-ppc@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Stefan Weil <sw@weilnetz.de>

On 18.07.2018 08:33, Howard Spoelstra wrote:
> Hi all,
>=20
> I have two issues when cross compiling current master for Windows with
> mingw 8.1. Host is Fedora29. See further below for gcc and mingw
> versions.
>=20
> Reproduce with:
> ./configure --cross-prefix=3Dx86_64-w64-mingw32-
> --target-list=3D"ppc-softmmu" --enable-gtk --with-gtkabi=3D3.0
> --enable-sdl --with-sdlabi=3D2.0
>=20
> Issue 1: Two bugs show up during compilation related to strncpy.
> Replacing the offenders with memcpy seems to fix this.
>=20
> First time:
> block/sheepdog.c: In function 'find_vdi_name':
> block/sheepdog.c:1239:5: error: 'strncpy' specified bound 256 equals
> destination size [-Werror=3Dstringop-truncation]
>      strncpy(buf + SD_MAX_VDI_LEN, tag, SD_MAX_VDI_TAG_LEN);
>      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>=20
> Second time:
> migration/global_state.c: In function 'global_state_store_running':
> migration/global_state.c:45:5: error: 'strncpy' specified bound 100
> equals destination size [-Werror=3Dstringop-truncation]
>      strncpy((char *)global_state.runstate,
>      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>             state, sizeof(global_state.runstate));
>             ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>=20

These two reports should be independent of general functionality
(sheepdog, migration). So what you see is most likely unrelated to this.

> Issue 2: once strncpy has been replaced with memcpy in these two
> instances, I can successfully compile, but the executable doesn't run
> in Windows.
> I tried to debug, and this is what gdb told me:
>=20
> (gdb) run
> Starting program: c:\qemu-fedora29beta\qemu-system-ppc-debug.exe -L
> c:\qemu-fedora29beta\pc-bios -boot c -m 256 -M "mac99,via=3Dpmu"
> -prom-env "boot-args=3D-v" -prom-env "auto-boot?=3Dtrue" -prom-env
> "vga-ndrv?=3Dtrue" -hda c:\Mac-disks\9.2.qcow2 -netdev
> "user,id=3Dnetwork01" -device "sungem,netdev=3Dnetwork01" -sdl -d int
> [New Thread 948.0x6d8]
> [New Thread 948.0x2778]
> [New Thread 948.0x286c]
> [New Thread 948.0x3d0]
>=20
> Program received signal SIGSEGV, Segmentation fault.
> getpagesize () at util/oslib-win32.c:535
> 535     util/oslib-win32.c: No such file or directory.

This warning is just from GDB, not able to locate you sources I guess.

> (gdb) bt full
> #0  getpagesize () at util/oslib-win32.c:535

Wonder why we should get a SEGFAULT in that simple function. As
discussed offline, the functionality in general seems to work (if this
function is compiled and run independently in your environment).

But maybe this backtrace is just misleading.

>         system_info =3D {{dwOemId =3D 56491488, {wProcessorArchitecture=
 =3D
> 64992, wReserved =3D 861}}, dwPageSize =3D 0,
>           lpMinimumApplicationAddress =3D 0x99cca4
> <register_module_init+60>, lpMaximumApplicationAddress =3D 0x3,
>           dwActiveProcessorMask =3D 11102192, dwNumberOfProcessors =3D
> 56584576, dwProcessorType =3D 0,
>           dwAllocationGranularity =3D 200, wProcessorLevel =3D 0,
> wProcessorRevision =3D 0}

dwPageSize =3D 0, I assume this is some random data on the stack and
GetSystemInfo never got executed. I wonder where this segfault comes from=
.

> #1  0x00000000009b7fcd in init_real_host_page_size () at util/pagesize.=
c:16
> No locals.
> #2  0x00000000009bc5f2 in __do_global_ctors ()
> No symbol table info available.
> #3  0x00000000004013ca in __tmainCRTStartup () at ../crt/crtexe.c:324
>         lock_free =3D <optimized out>
>         fiberid =3D <optimized out>
>         nested =3D <optimized out>
>         lpszCommandLine =3D <optimized out>
>         StartupInfo =3D {cb =3D 104, lpReserved =3D 0x3778e00 "", lpDes=
ktop
> =3D 0x377f440 "Winsta0\\Default",
>           lpTitle =3D 0x3786280
> "c:\\qemu-fedora29beta\\qemu-system-ppc-debug.exe", dwX =3D 0, dwY =3D =
0,
> dwXSize =3D 0,
>           dwYSize =3D 0, dwXCountChars =3D 0, dwYCountChars =3D 0,
> dwFillAttribute =3D 0, dwFlags =3D 0, wShowWindow =3D 0,
>           cbReserved2 =3D 0, lpReserved2 =3D 0x0, hStdInput =3D
> 0xffffffffffffffff, hStdOutput =3D 0xffffffffffffffff,
>           hStdError =3D 0xffffffffffffffff}
>         inDoubleQuote =3D <optimized out>
> #4  0x00000000004014fb in WinMainCRTStartup () at ../crt/crtexe.c:184
>         ret =3D 255
> (gdb)
>=20
>=20
> Gcc and mingw versions used:
>=20
> [hsp@localhost qemu-master]$ gcc -v
> Using built-in specs.
> COLLECT_GCC=3Dgcc
> COLLECT_LTO_WRAPPER=3D/usr/libexec/gcc/x86_64-redhat-linux/8/lto-wrappe=
r
> OFFLOAD_TARGET_NAMES=3Dnvptx-none
> OFFLOAD_TARGET_DEFAULT=3D1
> Target: x86_64-redhat-linux
> Configured with: ../configure --enable-bootstrap
> --enable-languages=3Dc,c++,fortran,objc,obj-c++,ada,go,lto --prefix=3D/=
usr
> --mandir=3D/usr/share/man --infodir=3D/usr/share/info
> --with-bugurl=3Dhttp://bugzilla.redhat.com/bugzilla --enable-shared
> --enable-threads=3Dposix --enable-checking=3Drelease --enable-multilib
> --with-system-zlib --enable-__cxa_atexit
> --disable-libunwind-exceptions --enable-gnu-unique-object
> --enable-linker-build-id --with-gcc-major-version-only
> --with-linker-hash-style=3Dgnu --enable-plugin --enable-initfini-array
> --with-isl --enable-libmpx --enable-offload-targets=3Dnvptx-none
> --without-cuda-driver --enable-gnu-indirect-function --enable-cet
> --with-tune=3Dgeneric --with-arch_32=3Di686 --build=3Dx86_64-redhat-lin=
ux
> Thread model: posix
> gcc version 8.1.1 20180626 (Red Hat 8.1.1-4) (GCC)
>=20
> [hsp@localhost qemu-master]$ x86_64-w64-mingw32-gcc -v
> Using built-in specs.
> COLLECT_GCC=3Dx86_64-w64-mingw32-gcc
> COLLECT_LTO_WRAPPER=3D/usr/libexec/gcc/x86_64-w64-mingw32/8.1.0/lto-wra=
pper
> Target: x86_64-w64-mingw32
> Configured with: ../configure --prefix=3D/usr --bindir=3D/usr/bin
> --includedir=3D/usr/include --mandir=3D/usr/share/man
> --infodir=3D/usr/share/info --datadir=3D/usr/share
> --build=3Dx86_64-redhat-linux-gnu --host=3Dx86_64-redhat-linux-gnu
> --with-gnu-as --with-gnu-ld --verbose --without-newlib
> --disable-multilib --disable-plugin --with-system-zlib --disable-nls
> --without-included-gettext --disable-win32-registry
> --enable-languages=3Dc,c++,objc,obj-c++,fortran
> --with-bugurl=3Dhttp://bugzilla.redhat.com/bugzilla --with-cloog
> --enable-threads=3Dposix --enable-libgomp --target=3Dx86_64-w64-mingw32
> --with-sysroot=3D/usr/x86_64-w64-mingw32/sys-root
> --with-gxx-include-dir=3D/usr/x86_64-w64-mingw32/sys-root/mingw/include=
/c++
> Thread model: posix
> gcc version 8.1.0 20180502 (Fedora MinGW 8.1.0-1.fc29) (GCC)
>=20
> Thanks for looking into this,
>=20
> Best,
> Howard
>=20

No being a win32/mingw expert, Stefan any idea?

--=20

Thanks,

David / dhildenb
