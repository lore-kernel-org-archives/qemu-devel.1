Received: from eggs.gnu.org ([2001:4830:134:3::10]:45724)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cePmM-0000X1-52
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 12:23:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cePmJ-00038N-1S
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 12:23:38 -0500
References: <CABHMSTVDnAxAvpp81+z_2fkAFO7tazLJs3cFXpuDuuGQj-Ek-A@mail.gmail.com>
	<1933406e-2576-e687-3545-a72f3b999310@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <bf1410bc-bc6d-bb29-5591-55634f25d487@redhat.com>
Date: Thu, 16 Feb 2017 18:23:31 +0100
MIME-Version: 1.0
In-Reply-To: <1933406e-2576-e687-3545-a72f3b999310@redhat.com>
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
To: Paolo Bonzini <pbonzini@redhat.com>, Chad Joan <chadjoan@gmail.com>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org

On 02/16/17 17:58, Paolo Bonzini wrote:
> 
> 
> On 16/02/2017 17:30, Chad Joan wrote:
>> Hello,
>>
>> This is a one-line patch to the configure script that will allow QEMU to be
>> built on musl-libc based Linux systems.  This problem is only noticeable
>> when QEMU is built with --enable-curses.
>>
>> Detailed reading material if you want to know where this came from:
>> https://bugs.gentoo.org/show_bug.cgi?id=609364
> 
> Hi,
> 
> can you explain exactly which function is missing without
> -D_XOPEN_SOURCE=500?  If it is curses' wide-char functions, why does it
> fail with musl but not with glibc?  Is _XOPEN_SOURCE always defined by
> glibc if you have _D_GNU_SOURCE?

It is not necessarily auto-defined, but the effect is "as if".

It is documented in the libc info:

https://www.gnu.org/software/libc/manual/html_node/Feature-Test-Macros.html#index-_005fXOPEN_005fSOURCE

> Macro: _XOPEN_SOURCE
> Macro: _XOPEN_SOURCE_EXTENDED
>
>     If you define this macro, functionality described in the X/Open
>     Portability Guide is included. This is a superset of the POSIX.1
>     and POSIX.2 functionality and in fact _POSIX_SOURCE and
>     _POSIX_C_SOURCE are automatically defined.
>
>     As the unification of all Unices, functionality only available in
>     BSD and SVID is also included.
>
>     If the macro _XOPEN_SOURCE_EXTENDED is also defined, even more
>     functionality is available. The extra functions will make all
>     functions available which are necessary for the X/Open Unix brand.
>
>     If the macro _XOPEN_SOURCE has the value 500 this includes all
>     functionality described so far plus some new definitions from the
>     Single Unix Specification, version 2.

https://www.gnu.org/software/libc/manual/html_node/Feature-Test-Macros.html#index-_005fGNU_005fSOURCE

> Macro: _GNU_SOURCE
>
>     If you define this macro, everything is included: ISO C89, ISO
>     C99, POSIX.1, POSIX.2, BSD, SVID, X/Open, LFS, and GNU extensions.
>     In the cases where POSIX.1 conflicts with BSD, the POSIX
>     definitions take precedence.

Curiously, I managed to recall this from years ago, when I was still
living and breathing the SUS (and looking frequently at the glibc info too).

Laszlo
