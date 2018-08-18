Received: from eggs.gnu.org ([2001:4830:134:3::10]:42027)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ben@curlybracket.co.uk>) id 1frA4M-000670-0K
	for qemu-devel@nongnu.org; Sat, 18 Aug 2018 18:51:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ben@curlybracket.co.uk>) id 1frA4I-0006qY-Q7
	for qemu-devel@nongnu.org; Sat, 18 Aug 2018 18:51:41 -0400
Date: Sat, 18 Aug 2018 23:51:34 +0100
In-Reply-To: <CABLmASEbeVBJRczqvMVvL4wPtJ38oayHOF0FUWK+Ap9Jfd182g@mail.gmail.com>
References: <CABLmASE2HTZPBVFM=grds+9RmPyh2naJ2KwNjb81LD0+E+yrtA@mail.gmail.com>
	<b897eaf6-9504-ddfc-ae60-1ac4a865d12e@redhat.com>
	<de02ae3c-3355-eb83-3216-5c87c3e917ff@weilnetz.de>
	<CABLmASEbeVBJRczqvMVvL4wPtJ38oayHOF0FUWK+Ap9Jfd182g@mail.gmail.com>
MIME-Version: 1.0
From: Ben Pye <ben@curlybracket.co.uk>
Message-ID: <ED055A64-5BE5-4257-8FA9-EEA0FDDD4EB4@curlybracket.co.uk>
Content-Type: text/plain;
 charset=utf-8
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
To: qemu-devel@nongnu.org, Howard Spoelstra <hsp.cat7@gmail.com>, Stefan Weil <sw@weilnetz.de>
Cc: qemu-ppc <qemu-ppc@nongnu.org>, David Hildenbrand <david@redhat.com>

I'm also seeing this behaviour using the MSYS2 packaged mingw64 compiler, G=
CC 8=2E2=2E I have managed to cross compile QEMU successfully under Fedora =
28 however and the resulting binary works=2E Certainly seems like a tool ch=
ain issue, unfortunately MSYS2 doesn't package any older versions of GCC=2E

Ben=2E

On 18 August 2018 21:51:35 BST, Howard Spoelstra <hsp=2Ecat7@gmail=2Ecom> =
wrote:
>On Sat, Aug 18, 2018 at 9:09 PM, Stefan Weil <sw@weilnetz=2Ede> wrote:
>> Am 17=2E08=2E2018 um 09:32 schrieb David Hildenbrand:
>>> On 18=2E07=2E2018 08:33, Howard Spoelstra wrote:
>>>> Hi all,
>>>>
>>>> I have two issues when cross compiling current master for Windows
>with
>>>> mingw 8=2E1=2E Host is Fedora29=2E See further below for gcc and ming=
w
>>>> versions=2E
>>>>
>>>> Reproduce with:
>>>> =2E/configure --cross-prefix=3Dx86_64-w64-mingw32-
>>>> --target-list=3D"ppc-softmmu" --enable-gtk --with-gtkabi=3D3=2E0
>>>> --enable-sdl --with-sdlabi=3D2=2E0
>>>>
>>>> Issue 1: Two bugs show up during compilation related to strncpy=2E
>>>> Replacing the offenders with memcpy seems to fix this=2E
>>>>
>>>> First time:
>>>> block/sheepdog=2Ec: In function 'find_vdi_name':
>>>> block/sheepdog=2Ec:1239:5: error: 'strncpy' specified bound 256
>equals
>>>> destination size [-Werror=3Dstringop-truncation]
>>>>      strncpy(buf + SD_MAX_VDI_LEN, tag, SD_MAX_VDI_TAG_LEN);
>>>>      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>>
>>>> Second time:
>>>> migration/global_state=2Ec: In function 'global_state_store_running':
>>>> migration/global_state=2Ec:45:5: error: 'strncpy' specified bound 100
>>>> equals destination size [-Werror=3Dstringop-truncation]
>>>>      strncpy((char *)global_state=2Erunstate,
>>>>      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>>             state, sizeof(global_state=2Erunstate));
>>>>             ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>>
>>>
>>> These two reports should be independent of general functionality
>>> (sheepdog, migration)=2E So what you see is most likely unrelated to
>this=2E
>>>
>>>> Issue 2: once strncpy has been replaced with memcpy in these two
>>>> instances, I can successfully compile, but the executable doesn't
>run
>>>> in Windows=2E
>>>> I tried to debug, and this is what gdb told me:
>>>>
>>>> (gdb) run
>>>> Starting program: c:\qemu-fedora29beta\qemu-system-ppc-debug=2Eexe -L
>>>> c:\qemu-fedora29beta\pc-bios -boot c -m 256 -M "mac99,via=3Dpmu"
>>>> -prom-env "boot-args=3D-v" -prom-env "auto-boot?=3Dtrue" -prom-env
>>>> "vga-ndrv?=3Dtrue" -hda c:\Mac-disks\9=2E2=2Eqcow2 -netdev
>>>> "user,id=3Dnetwork01" -device "sungem,netdev=3Dnetwork01" -sdl -d int
>>>> [New Thread 948=2E0x6d8]
>>>> [New Thread 948=2E0x2778]
>>>> [New Thread 948=2E0x286c]
>>>> [New Thread 948=2E0x3d0]
>>>>
>>>> Program received signal SIGSEGV, Segmentation fault=2E
>>>> getpagesize () at util/oslib-win32=2Ec:535
>>>> 535     util/oslib-win32=2Ec: No such file or directory=2E
>>>
>>> This warning is just from GDB, not able to locate you sources I
>guess=2E
>>>
>>>> (gdb) bt full
>>>> #0  getpagesize () at util/oslib-win32=2Ec:535
>>>
>>> Wonder why we should get a SEGFAULT in that simple function=2E As
>>> discussed offline, the functionality in general seems to work (if
>this
>>> function is compiled and run independently in your environment)=2E
>>>
>>> But maybe this backtrace is just misleading=2E
>>>
>>>>         system_info =3D {{dwOemId =3D 56491488, {wProcessorArchitectu=
re
>=3D
>>>> 64992, wReserved =3D 861}}, dwPageSize =3D 0,
>>>>           lpMinimumApplicationAddress =3D 0x99cca4
>>>> <register_module_init+60>, lpMaximumApplicationAddress =3D 0x3,
>>>>           dwActiveProcessorMask =3D 11102192, dwNumberOfProcessors =
=3D
>>>> 56584576, dwProcessorType =3D 0,
>>>>           dwAllocationGranularity =3D 200, wProcessorLevel =3D 0,
>>>> wProcessorRevision =3D 0}
>>>
>>> dwPageSize =3D 0, I assume this is some random data on the stack and
>>> GetSystemInfo never got executed=2E I wonder where this segfault comes
>from=2E
>>>
>>>> #1  0x00000000009b7fcd in init_real_host_page_size () at
>util/pagesize=2Ec:16
>>>> No locals=2E
>>>> #2  0x00000000009bc5f2 in __do_global_ctors ()
>>>> No symbol table info available=2E
>>>> #3  0x00000000004013ca in __tmainCRTStartup () at
>=2E=2E/crt/crtexe=2Ec:324
>>>>         lock_free =3D <optimized out>
>>>>         fiberid =3D <optimized out>
>>>>         nested =3D <optimized out>
>>>>         lpszCommandLine =3D <optimized out>
>>>>         StartupInfo =3D {cb =3D 104, lpReserved =3D 0x3778e00 "",
>lpDesktop
>>>> =3D 0x377f440 "Winsta0\\Default",
>>>>           lpTitle =3D 0x3786280
>>>> "c:\\qemu-fedora29beta\\qemu-system-ppc-debug=2Eexe", dwX =3D 0, dwY =
=3D
>0,
>>>> dwXSize =3D 0,
>>>>           dwYSize =3D 0, dwXCountChars =3D 0, dwYCountChars =3D 0,
>>>> dwFillAttribute =3D 0, dwFlags =3D 0, wShowWindow =3D 0,
>>>>           cbReserved2 =3D 0, lpReserved2 =3D 0x0, hStdInput =3D
>>>> 0xffffffffffffffff, hStdOutput =3D 0xffffffffffffffff,
>>>>           hStdError =3D 0xffffffffffffffff}
>>>>         inDoubleQuote =3D <optimized out>
>>>> #4  0x00000000004014fb in WinMainCRTStartup () at
>=2E=2E/crt/crtexe=2Ec:184
>>>>         ret =3D 255
>>>> (gdb)
>>>>
>>>>
>>>> Gcc and mingw versions used:
>>>>
>>>> [hsp@localhost qemu-master]$ gcc -v
>>>> Using built-in specs=2E
>>>> COLLECT_GCC=3Dgcc
>>>>
>COLLECT_LTO_WRAPPER=3D/usr/libexec/gcc/x86_64-redhat-linux/8/lto-wrapper
>>>> OFFLOAD_TARGET_NAMES=3Dnvptx-none
>>>> OFFLOAD_TARGET_DEFAULT=3D1
>>>> Target: x86_64-redhat-linux
>>>> Configured with: =2E=2E/configure --enable-bootstrap
>>>> --enable-languages=3Dc,c++,fortran,objc,obj-c++,ada,go,lto
>--prefix=3D/usr
>>>> --mandir=3D/usr/share/man --infodir=3D/usr/share/info
>>>> --with-bugurl=3Dhttp://bugzilla=2Eredhat=2Ecom/bugzilla --enable-shar=
ed
>>>> --enable-threads=3Dposix --enable-checking=3Drelease --enable-multili=
b
>>>> --with-system-zlib --enable-__cxa_atexit
>>>> --disable-libunwind-exceptions --enable-gnu-unique-object
>>>> --enable-linker-build-id --with-gcc-major-version-only
>>>> --with-linker-hash-style=3Dgnu --enable-plugin
>--enable-initfini-array
>>>> --with-isl --enable-libmpx --enable-offload-targets=3Dnvptx-none
>>>> --without-cuda-driver --enable-gnu-indirect-function --enable-cet
>>>> --with-tune=3Dgeneric --with-arch_32=3Di686 --build=3Dx86_64-redhat-l=
inux
>>>> Thread model: posix
>>>> gcc version 8=2E1=2E1 20180626 (Red Hat 8=2E1=2E1-4) (GCC)
>>>>
>>>> [hsp@localhost qemu-master]$ x86_64-w64-mingw32-gcc -v
>>>> Using built-in specs=2E
>>>> COLLECT_GCC=3Dx86_64-w64-mingw32-gcc
>>>>
>COLLECT_LTO_WRAPPER=3D/usr/libexec/gcc/x86_64-w64-mingw32/8=2E1=2E0/lto-w=
rapper
>>>> Target: x86_64-w64-mingw32
>>>> Configured with: =2E=2E/configure --prefix=3D/usr --bindir=3D/usr/bin
>>>> --includedir=3D/usr/include --mandir=3D/usr/share/man
>>>> --infodir=3D/usr/share/info --datadir=3D/usr/share
>>>> --build=3Dx86_64-redhat-linux-gnu --host=3Dx86_64-redhat-linux-gnu
>>>> --with-gnu-as --with-gnu-ld --verbose --without-newlib
>>>> --disable-multilib --disable-plugin --with-system-zlib
>--disable-nls
>>>> --without-included-gettext --disable-win32-registry
>>>> --enable-languages=3Dc,c++,objc,obj-c++,fortran
>>>> --with-bugurl=3Dhttp://bugzilla=2Eredhat=2Ecom/bugzilla --with-cloog
>>>> --enable-threads=3Dposix --enable-libgomp --target=3Dx86_64-w64-mingw=
32
>>>> --with-sysroot=3D/usr/x86_64-w64-mingw32/sys-root
>>>>
>--with-gxx-include-dir=3D/usr/x86_64-w64-mingw32/sys-root/mingw/include/c=
++
>>>> Thread model: posix
>>>> gcc version 8=2E1=2E0 20180502 (Fedora MinGW 8=2E1=2E0-1=2Efc29) (GCC=
)
>>>>
>>>> Thanks for looking into this,
>>>>
>>>> Best,
>>>> Howard
>>>>
>>>
>>> No being a win32/mingw expert, Stefan any idea?
>>
>>
>> I'd try a debug build (configure [=2E=2E=2E] --enable-debug)=2E
>>
>> My installers (https://qemu=2Eweilnetz=2Ede/w64/) were built with
>> x86_64-w64-mingw32-gcc (GCC) 6=2E3=2E0 20170516 (from Debian Stretch)=
=2E
>> Howard, perhaps you can try whether they show the same runtime
>SIGSEGV=2E
>> When I run your command line with a dummy disk image, OpenBIOS boots
>fine=2E
>>
>> Kind regards,
>> Stefan
>
>The error I reported already came from a debug build=2E
>Other builds with less recent mingw (7=2E3 in Fedora 28) do not SIGSEGV,
>neither do Stefan's=2E
>I can confirm the strncpy warnings are gone using Philippe's patches=2E
>
>Best,
>Howard
