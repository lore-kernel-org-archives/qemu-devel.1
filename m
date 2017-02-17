Received: from eggs.gnu.org ([2001:4830:134:3::10]:50324)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1ceeL8-00040D-Rh
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 03:56:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1ceeL7-0000rU-T4
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 03:56:30 -0500
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <CABHMSTVDnAxAvpp81+z_2fkAFO7tazLJs3cFXpuDuuGQj-Ek-A@mail.gmail.com>
	<1933406e-2576-e687-3545-a72f3b999310@redhat.com>
	<bf1410bc-bc6d-bb29-5591-55634f25d487@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e19aed34-77c2-f588-351d-2daa8a099ae9@redhat.com>
Date: Fri, 17 Feb 2017 09:56:27 +0100
MIME-Version: 1.0
In-Reply-To: <bf1410bc-bc6d-bb29-5591-55634f25d487@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
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
To: Laszlo Ersek <lersek@redhat.com>, Chad Joan <chadjoan@gmail.com>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org



On 16/02/2017 18:23, Laszlo Ersek wrote:
> On 02/16/17 17:58, Paolo Bonzini wrote:
>>
>>
>> On 16/02/2017 17:30, Chad Joan wrote:
>>> Hello,
>>>
>>> This is a one-line patch to the configure script that will allow QEMU to be
>>> built on musl-libc based Linux systems.  This problem is only noticeable
>>> when QEMU is built with --enable-curses.
>>>
>>> Detailed reading material if you want to know where this came from:
>>> https://bugs.gentoo.org/show_bug.cgi?id=609364
>>
>> Hi,
>>
>> can you explain exactly which function is missing without
>> -D_XOPEN_SOURCE=500?  If it is curses' wide-char functions, why does it
>> fail with musl but not with glibc?  Is _XOPEN_SOURCE always defined by
>> glibc if you have _D_GNU_SOURCE?
> 
> It is not necessarily auto-defined, but the effect is "as if".

Ok, so the bug is that glibc _does_ auto-define _XOPEN_SOURCE:

#ifdef _GNU_SOURCE
# undef  _ISOC95_SOURCE
# define _ISOC95_SOURCE 1
# undef  _ISOC99_SOURCE
# define _ISOC99_SOURCE 1
# undef  _ISOC11_SOURCE
# define _ISOC11_SOURCE 1
# undef  _POSIX_SOURCE
# define _POSIX_SOURCE  1
# undef  _POSIX_C_SOURCE
# define _POSIX_C_SOURCE        200809L
# undef  _XOPEN_SOURCE
# define _XOPEN_SOURCE  700
# undef  _XOPEN_SOURCE_EXTENDED
# define _XOPEN_SOURCE_EXTENDED 1
# undef  _LARGEFILE64_SOURCE
# define _LARGEFILE64_SOURCE    1
# undef  _DEFAULT_SOURCE
# define _DEFAULT_SOURCE        1
# undef  _ATFILE_SOURCE
# define _ATFILE_SOURCE 1
#endif

and ncursesw looks for _XOPEN_SOURCE exclusively:

#ifndef NCURSES_WIDECHAR
#if defined(_XOPEN_SOURCE_EXTENDED) || (defined(_XOPEN_SOURCE) && (_XOPEN_SOURCE - 0 >= 500))
#define NCURSES_WIDECHAR 1
#else
#define NCURSES_WIDECHAR 0
#endif
#endif /* NCURSES_WIDECHAR */


So I do think that if musl wants to support _GNU_SOURCE, it should also auto-define;
however it doesn't, see https://git.musl-libc.org/cgit/musl/tree/include/features.h.

Alternatively, ncurses should be patched to look at _GNU_SOURCE in addition to
_XOPEN_SOURCE and _XOPEN_SOURCE_EXTENDED.

In any case, it's not a QEMU bug.  Other packages likely are going to have the same
issue, and fixing all of them is the wrong course of action.

Paolo
