Received: from eggs.gnu.org ([2001:4830:134:3::10]:54753)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1frq3R-0000nx-Tp
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 15:41:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1frq3G-0002fD-HP
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 15:41:28 -0400
From: Stefan Weil <sw@weilnetz.de>
References: <CABLmASE2HTZPBVFM=grds+9RmPyh2naJ2KwNjb81LD0+E+yrtA@mail.gmail.com>
	<c350ae62-2712-79cc-e7e6-b88ae3fbc044@weilnetz.de>
Message-ID: <008c57ea-0050-b5f0-4d68-db660cba269e@weilnetz.de>
Date: Mon, 20 Aug 2018 21:41:16 +0200
MIME-Version: 1.0
In-Reply-To: <c350ae62-2712-79cc-e7e6-b88ae3fbc044@weilnetz.de>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
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
To: Howard Spoelstra <hsp.cat7@gmail.com>, qemu-ppc <qemu-ppc@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, David Hildenbrand <david@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Ben Pye <ben@curlybracket.co.uk>

> Am 18.07.2018 um 08:33 schrieb Howard Spoelstra:
> [...]> Issue 2: once strncpy has been replaced with memcpy in these two
>> instances, I can successfully compile, but the executable doesn't run
>> in Windows.
>> I tried to debug, and this is what gdb told me:
>>
>> (gdb) run
>> Starting program: c:\qemu-fedora29beta\qemu-system-ppc-debug.exe -L
>> c:\qemu-fedora29beta\pc-bios -boot c -m 256 -M "mac99,via=pmu"
>> -prom-env "boot-args=-v" -prom-env "auto-boot?=true" -prom-env
>> "vga-ndrv?=true" -hda c:\Mac-disks\9.2.qcow2 -netdev
>> "user,id=network01" -device "sungem,netdev=network01" -sdl -d int
>> [New Thread 948.0x6d8]
>> [New Thread 948.0x2778]
>> [New Thread 948.0x286c]
>> [New Thread 948.0x3d0]
>>
>> Program received signal SIGSEGV, Segmentation fault.
>> getpagesize () at util/oslib-win32.c:535
>> 535     util/oslib-win32.c: No such file or directory.


That's a problem triggered by gcc 8 for Mingw-w64 with compiler options
-fstack-protector-all and -fstack-protector-strong. With any of those
options this simple test program also fails with SIGSEGV:

#include <windows.h>
int main(void) {
  SYSTEM_INFO system_info;
  GetSystemInfo(&system_info);
  return system_info.dwPageSize;
}

With configure option --disable-stack-protector, the resulting binary
should work.

Regards
Stefan
