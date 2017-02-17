Received: from eggs.gnu.org ([2001:4830:134:3::10]:58111)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cegSG-0004ZU-1b
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 06:12:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cegSF-0000Kq-2d
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 06:12:00 -0500
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <CABHMSTVDnAxAvpp81+z_2fkAFO7tazLJs3cFXpuDuuGQj-Ek-A@mail.gmail.com>
	<1933406e-2576-e687-3545-a72f3b999310@redhat.com>
	<bf1410bc-bc6d-bb29-5591-55634f25d487@redhat.com>
	<e19aed34-77c2-f588-351d-2daa8a099ae9@redhat.com>
	<279d2ba8-dabc-0c50-ea7e-1cecccc22291@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6e37308a-5d95-8795-fd1a-25e4ace2158f@redhat.com>
Date: Fri, 17 Feb 2017 12:11:54 +0100
MIME-Version: 1.0
In-Reply-To: <279d2ba8-dabc-0c50-ea7e-1cecccc22291@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
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



On 17/02/2017 10:17, Laszlo Ersek wrote:
> Of course, *if* that other C library, and the Curses implementation,
> claim compatibility with glibc as far as _GNU_SOURCE goes, *then* I
> fully agree with you. (IOW, it depends on the condition that you
> formulated above, "if musl wants to support _GNU_SOURCE".)

They at least try, since their features.h supports it.

> Same for ncurses -- do they aim at SUSv2 conformance, or do they intend
> to consider _GNU_SOURCE specifically?

Well, ncurses is a GNU project so I suppose they mostly care about
whatever Autoconf does.  And indeed Autoconf does have some special
casing for -D_XOPEN_SOURCE=500:

  AC_CACHE_CHECK([whether _XOPEN_SOURCE should be defined],
    [ac_cv_should_define__xopen_source],
    [ac_cv_should_define__xopen_source=no
     AC_COMPILE_IFELSE(
       [AC_LANG_PROGRAM([[
          #include <wchar.h>
          mbstate_t x;]])],
       [],
       [AC_COMPILE_IFELSE(
          [AC_LANG_PROGRAM([[
             #define _XOPEN_SOURCE 500
             #include <wchar.h>
             mbstate_t x;]])],
          [ac_cv_should_define__xopen_source=yes])])])
  test $ac_cv_should_define__xopen_source = yes &&
    AC_DEFINE([_XOPEN_SOURCE], [500])

If musl needs _XOPEN_SOURCE for wchar.h, then it would be worth working
around in QEMU.  If it's just happening with ncurses, however, it'd be a
musl bug, which should be fixed in musl or worked around in ncurses.

Chad, can you check whether the programs below fails with musl:

/* First program */
#define _GNU_SOURCE
#include <wchar.h>
mbstate_t x;

/* Second program */
#include <wchar.h>
mbstate_t x;

/* Third program */
#define _XOPEN_SOURCE 500
#include <wchar.h>
mbstate_t x;

Just compile them with "gcc foo.c -O2".

Thanks,

Paolo
