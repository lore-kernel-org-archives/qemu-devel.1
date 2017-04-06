Received: from eggs.gnu.org ([2001:4830:134:3::10]:36324)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gceq-qemu-devel@m.gmane.org>) id 1cwBwU-0007dY-Td
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 14:15:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gceq-qemu-devel@m.gmane.org>) id 1cwBwR-0001Gu-PV
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 14:15:34 -0400
Received: from [195.159.176.226] (port=57444 helo=blaine.gmane.org)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <gceq-qemu-devel@m.gmane.org>)
	id 1cwBwR-0001GX-Ig
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 14:15:31 -0400
Received: from list by blaine.gmane.org with local (Exim 4.84_2)
	(envelope-from <gceq-qemu-devel@m.gmane.org>) id 1cwBw9-0004Bg-1X
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 20:15:13 +0200
From: =?UTF-8?Q?Rainer_M=c3=bcller?= <raimue@codingfarm.de>
Date: Thu, 6 Apr 2017 20:15:19 +0200
Message-ID: <oc60j5$ceq$1@blaine.gmane.org>
References: <CABHMSTVDnAxAvpp81+z_2fkAFO7tazLJs3cFXpuDuuGQj-Ek-A@mail.gmail.com>
	<1933406e-2576-e687-3545-a72f3b999310@redhat.com>
	<bf1410bc-bc6d-bb29-5591-55634f25d487@redhat.com>
	<e19aed34-77c2-f588-351d-2daa8a099ae9@redhat.com>
	<CAFEAcA-3TkmaJXpG2RpzBPKmj+JKGK5EBwPvXWkwR=Qkobq-Sg@mail.gmail.com>
	<7c4d6c25-3b1c-61ec-1eda-6c5e7cee8755@redhat.com>
	<CAFEAcA_3jE9F92F6+p6eDfmPwV2LL=fKV-htfTHpCoCOAgJAMg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
In-Reply-To: <CAFEAcA_3jE9F92F6+p6eDfmPwV2LL=fKV-htfTHpCoCOAgJAMg@mail.gmail.com>
Subject: Re: [Qemu-devel] Fix build break during configuration on musl-libc
 based Linux systems.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

On 2017-02-17 17:57, Peter Maydell wrote:
> On 17 February 2017 at 11:20, Paolo Bonzini <pbonzini@redhat.com> wrote:
>>
>>
>> On 17/02/2017 11:18, Peter Maydell wrote:
>>> Defining _XOPEN_SOURCE is easy enough, and I think we should
>>> do it unconditionally. We should check what effect this has
>>> on the BSD hosts though I guess. (You could argue that we
>>> should be defining _XOPEN_SOURCE anyway for the benefit of
>>> the non-glibc BSD/Solaris/etc platforms.)
>>
>> Sounds good, then I think we should define it to 700 just like glibc does.
> 
> Unfortunately this idea turns out to break OSX compiles,
> because on OSX saying _XOPEN_SOURCE=anything disables
> all the non-X/Open APIs (which you get by default, and
> some of which like mkdtemp we use).

A bit late to this thread, but the original problem was also reported
for Mac OS X with --enable-curses in MacPorts. The build fails with the
same symptoms as in the original report.

https://trac.macports.org/ticket/53929

As you identified, the problem is that ncurses expects the define
_XOPEN_SOURCE >= 500 to enable the wide-char function declarations.

The solution to retain access to non-standard API on Mac OS X would be
to also define _DARWIN_C_SOURCE which enables extensions.

$ cat foo.c
#include <unistd.h>
int main() {
    mkdtemp("/tmp/test-XXXXXX");
}
$ cc -D_XOPEN_SOURCE=500 -c foo.c
foo.c:4:5: warning: implicit declaration of function 'mkdtemp' is
invalid in C99 [-Wimplicit-function-declaration]
    mkdtemp("/tmp/test-XXXXXX");
    ^
1 warning generated.
$ cc -D_XOPEN_SOURCE=500 -D_DARWIN_C_SOURCE -c foo.c
$

A quick test on current master with configure patched to define
  QEMU_CFLAGS="-D_XOPEN_SOURCE=500 -D_DARWIN_C_SOURCE $QEMU_CFLAGS"
compiled fine for both a default configure and with --enable-curses.

Rainer
