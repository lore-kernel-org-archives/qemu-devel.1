Received: from eggs.gnu.org ([2001:4830:134:3::10]:43444)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hsp.cat7@gmail.com>) id 1fr8CC-0001gQ-J6
	for qemu-devel@nongnu.org; Sat, 18 Aug 2018 16:51:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hsp.cat7@gmail.com>) id 1fr8CB-0004yc-Di
	for qemu-devel@nongnu.org; Sat, 18 Aug 2018 16:51:40 -0400
MIME-Version: 1.0
In-Reply-To: <de02ae3c-3355-eb83-3216-5c87c3e917ff@weilnetz.de>
References: <CABLmASE2HTZPBVFM=grds+9RmPyh2naJ2KwNjb81LD0+E+yrtA@mail.gmail.com>
	<b897eaf6-9504-ddfc-ae60-1ac4a865d12e@redhat.com>
	<de02ae3c-3355-eb83-3216-5c87c3e917ff@weilnetz.de>
From: Howard Spoelstra <hsp.cat7@gmail.com>
Date: Sat, 18 Aug 2018 22:51:35 +0200
Message-ID: <CABLmASEbeVBJRczqvMVvL4wPtJ38oayHOF0FUWK+Ap9Jfd182g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Stefan Weil <sw@weilnetz.de>
Cc: David Hildenbrand <david@redhat.com>, qemu-ppc <qemu-ppc@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On Sat, Aug 18, 2018 at 9:09 PM, Stefan Weil <sw@weilnetz.de> wrote:
> Am 17.08.2018 um 09:32 schrieb David Hildenbrand:
>> On 18.07.2018 08:33, Howard Spoelstra wrote:
>>> Hi all,
>>>
>>> I have two issues when cross compiling current master for Windows with
>>> mingw 8.1. Host is Fedora29. See further below for gcc and mingw
>>> versions.
>>>
>>> Reproduce with:
>>> ./configure --cross-prefix=x86_64-w64-mingw32-
>>> --target-list="ppc-softmmu" --enable-gtk --with-gtkabi=3.0
>>> --enable-sdl --with-sdlabi=2.0
>>>
>>> Issue 1: Two bugs show up during compilation related to strncpy.
>>> Replacing the offenders with memcpy seems to fix this.
>>>
>>> First time:
>>> block/sheepdog.c: In function 'find_vdi_name':
>>> block/sheepdog.c:1239:5: error: 'strncpy' specified bound 256 equals
>>> destination size [-Werror=stringop-truncation]
>>>      strncpy(buf + SD_MAX_VDI_LEN, tag, SD_MAX_VDI_TAG_LEN);
>>>      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>
>>> Second time:
>>> migration/global_state.c: In function 'global_state_store_running':
>>> migration/global_state.c:45:5: error: 'strncpy' specified bound 100
>>> equals destination size [-Werror=stringop-truncation]
>>>      strncpy((char *)global_state.runstate,
>>>      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>             state, sizeof(global_state.runstate));
>>>             ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>
>>
>> These two reports should be independent of general functionality
>> (sheepdog, migration). So what you see is most likely unrelated to this.
>>
>>> Issue 2: once strncpy has been replaced with memcpy in these two
>>> instances, I can successfully compile, but the executable doesn't run
>>> in Windows.
>>> I tried to debug, and this is what gdb told me:
>>>
>>> (gdb) run
>>> Starting program: c:\qemu-fedora29beta\qemu-system-ppc-debug.exe -L
>>> c:\qemu-fedora29beta\pc-bios -boot c -m 256 -M "mac99,via=pmu"
>>> -prom-env "boot-args=-v" -prom-env "auto-boot?=true" -prom-env
>>> "vga-ndrv?=true" -hda c:\Mac-disks\9.2.qcow2 -netdev
>>> "user,id=network01" -device "sungem,netdev=network01" -sdl -d int
>>> [New Thread 948.0x6d8]
>>> [New Thread 948.0x2778]
>>> [New Thread 948.0x286c]
>>> [New Thread 948.0x3d0]
>>>
>>> Program received signal SIGSEGV, Segmentation fault.
>>> getpagesize () at util/oslib-win32.c:535
>>> 535     util/oslib-win32.c: No such file or directory.
>>
>> This warning is just from GDB, not able to locate you sources I guess.
>>
>>> (gdb) bt full
>>> #0  getpagesize () at util/oslib-win32.c:535
>>
>> Wonder why we should get a SEGFAULT in that simple function. As
>> discussed offline, the functionality in general seems to work (if this
>> function is compiled and run independently in your environment).
>>
>> But maybe this backtrace is just misleading.
>>
>>>         system_info = {{dwOemId = 56491488, {wProcessorArchitecture =
>>> 64992, wReserved = 861}}, dwPageSize = 0,
>>>           lpMinimumApplicationAddress = 0x99cca4
>>> <register_module_init+60>, lpMaximumApplicationAddress = 0x3,
>>>           dwActiveProcessorMask = 11102192, dwNumberOfProcessors =
>>> 56584576, dwProcessorType = 0,
>>>           dwAllocationGranularity = 200, wProcessorLevel = 0,
>>> wProcessorRevision = 0}
>>
>> dwPageSize = 0, I assume this is some random data on the stack and
>> GetSystemInfo never got executed. I wonder where this segfault comes from.
>>
>>> #1  0x00000000009b7fcd in init_real_host_page_size () at util/pagesize.c:16
>>> No locals.
>>> #2  0x00000000009bc5f2 in __do_global_ctors ()
>>> No symbol table info available.
>>> #3  0x00000000004013ca in __tmainCRTStartup () at ../crt/crtexe.c:324
>>>         lock_free = <optimized out>
>>>         fiberid = <optimized out>
>>>         nested = <optimized out>
>>>         lpszCommandLine = <optimized out>
>>>         StartupInfo = {cb = 104, lpReserved = 0x3778e00 "", lpDesktop
>>> = 0x377f440 "Winsta0\\Default",
>>>           lpTitle = 0x3786280
>>> "c:\\qemu-fedora29beta\\qemu-system-ppc-debug.exe", dwX = 0, dwY = 0,
>>> dwXSize = 0,
>>>           dwYSize = 0, dwXCountChars = 0, dwYCountChars = 0,
>>> dwFillAttribute = 0, dwFlags = 0, wShowWindow = 0,
>>>           cbReserved2 = 0, lpReserved2 = 0x0, hStdInput =
>>> 0xffffffffffffffff, hStdOutput = 0xffffffffffffffff,
>>>           hStdError = 0xffffffffffffffff}
>>>         inDoubleQuote = <optimized out>
>>> #4  0x00000000004014fb in WinMainCRTStartup () at ../crt/crtexe.c:184
>>>         ret = 255
>>> (gdb)
>>>
>>>
>>> Gcc and mingw versions used:
>>>
>>> [hsp@localhost qemu-master]$ gcc -v
>>> Using built-in specs.
>>> COLLECT_GCC=gcc
>>> COLLECT_LTO_WRAPPER=/usr/libexec/gcc/x86_64-redhat-linux/8/lto-wrapper
>>> OFFLOAD_TARGET_NAMES=nvptx-none
>>> OFFLOAD_TARGET_DEFAULT=1
>>> Target: x86_64-redhat-linux
>>> Configured with: ../configure --enable-bootstrap
>>> --enable-languages=c,c++,fortran,objc,obj-c++,ada,go,lto --prefix=/usr
>>> --mandir=/usr/share/man --infodir=/usr/share/info
>>> --with-bugurl=http://bugzilla.redhat.com/bugzilla --enable-shared
>>> --enable-threads=posix --enable-checking=release --enable-multilib
>>> --with-system-zlib --enable-__cxa_atexit
>>> --disable-libunwind-exceptions --enable-gnu-unique-object
>>> --enable-linker-build-id --with-gcc-major-version-only
>>> --with-linker-hash-style=gnu --enable-plugin --enable-initfini-array
>>> --with-isl --enable-libmpx --enable-offload-targets=nvptx-none
>>> --without-cuda-driver --enable-gnu-indirect-function --enable-cet
>>> --with-tune=generic --with-arch_32=i686 --build=x86_64-redhat-linux
>>> Thread model: posix
>>> gcc version 8.1.1 20180626 (Red Hat 8.1.1-4) (GCC)
>>>
>>> [hsp@localhost qemu-master]$ x86_64-w64-mingw32-gcc -v
>>> Using built-in specs.
>>> COLLECT_GCC=x86_64-w64-mingw32-gcc
>>> COLLECT_LTO_WRAPPER=/usr/libexec/gcc/x86_64-w64-mingw32/8.1.0/lto-wrapper
>>> Target: x86_64-w64-mingw32
>>> Configured with: ../configure --prefix=/usr --bindir=/usr/bin
>>> --includedir=/usr/include --mandir=/usr/share/man
>>> --infodir=/usr/share/info --datadir=/usr/share
>>> --build=x86_64-redhat-linux-gnu --host=x86_64-redhat-linux-gnu
>>> --with-gnu-as --with-gnu-ld --verbose --without-newlib
>>> --disable-multilib --disable-plugin --with-system-zlib --disable-nls
>>> --without-included-gettext --disable-win32-registry
>>> --enable-languages=c,c++,objc,obj-c++,fortran
>>> --with-bugurl=http://bugzilla.redhat.com/bugzilla --with-cloog
>>> --enable-threads=posix --enable-libgomp --target=x86_64-w64-mingw32
>>> --with-sysroot=/usr/x86_64-w64-mingw32/sys-root
>>> --with-gxx-include-dir=/usr/x86_64-w64-mingw32/sys-root/mingw/include/c++
>>> Thread model: posix
>>> gcc version 8.1.0 20180502 (Fedora MinGW 8.1.0-1.fc29) (GCC)
>>>
>>> Thanks for looking into this,
>>>
>>> Best,
>>> Howard
>>>
>>
>> No being a win32/mingw expert, Stefan any idea?
>
>
> I'd try a debug build (configure [...] --enable-debug).
>
> My installers (https://qemu.weilnetz.de/w64/) were built with
> x86_64-w64-mingw32-gcc (GCC) 6.3.0 20170516 (from Debian Stretch).
> Howard, perhaps you can try whether they show the same runtime SIGSEGV.
> When I run your command line with a dummy disk image, OpenBIOS boots fine.
>
> Kind regards,
> Stefan

The error I reported already came from a debug build.
Other builds with less recent mingw (7.3 in Fedora 28) do not SIGSEGV,
neither do Stefan's.
I can confirm the strncpy warnings are gone using Philippe's patches.

Best,
Howard
