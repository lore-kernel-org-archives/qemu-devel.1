Received: from eggs.gnu.org ([2001:4830:134:3::10]:39022)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dwl4F-0003hL-0i
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 04:18:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dwl4A-0008Qf-1B
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 04:18:10 -0400
Received: from roura.ac.upc.edu ([147.83.33.10]:39947 helo=roura.ac.upc.es)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dwl49-0008QH-Hy
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 04:18:05 -0400
From: =?utf-8?Q?Llu=C3=ADs_Vilanova?= <vilanova@ac.upc.edu>
References: <150529642278.10902.18234057937634437857.stgit@frigg.lan>
	<20170922224855.GA6905@flamenco> <87fubawt1q.fsf@frigg.lan>
	<20170925185507.GA11022@flamenco>
Date: Tue, 26 Sep 2017 11:17:50 +0300
In-Reply-To: <20170925185507.GA11022@flamenco> (Emilio G. Cota's message of
	"Mon, 25 Sep 2017 14:55:07 -0400")
Message-ID: <87ing5vpox.fsf@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 00/22] instrument: Add basic event
 instrumentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Markus Armbruster <armbru@redhat.com>

Emilio G Cota writes:

> On Mon, Sep 25, 2017 at 21:07:45 +0300, Llu=C3=ADs Vilanova wrote:
>> You're doing it right, and I've checked that the branch is properly push=
ed. Can
>> you compile with V=3D1 to show me the failing cmdline?

> $ make V=3D1
> (cd /data/src/qemu2; printf '#define QEMU_PKGVERSION '; if test -n ""; th=
en
> printf '""\n'; else if test -d .git; then printf '" ('; git describe --ma=
tch
> 'v*' 2>/dev/null | tr -d '\n'; if ! git diff-index --quiet HEAD &>/dev/nu=
ll;
> then printf -- '-dirty'; fi; printf ')"\n'; else printf '""\n'; fi; fi) >
> qemu-version.h.tmp
> if ! cmp -s qemu-version.h qemu-version.h.tmp; then mv qemu-version.h.tmp=
 qemu-version.h; else rm qemu-version.h.tmp; fi
> make -I/data/src/qemu2/dtc VPATH=3D/data/src/qemu2/dtc -C dtc V=3D"1"
> LIBFDT_srcdir=3D/data/src/qemu2/dtc/libfdt CPPFLAGS=3D"-I/data/src/qemu2/=
build/dtc
> -I/data/src/qemu2/dtc -I/data/src/qemu2/dtc/libfdt" CFLAGS=3D"-O2
> -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=3D2 -g -fvisibility=3Dhidden
> -I/usr/include/pixman-1 -I/data/src/qemu2/dtc/libfdt -Werror -pthread
> -I/usr/include/glib-2.0 -I/usr/lib/x86_64-linux-gnu/glib-2.0/include -fPI=
E -DPIE
> -m64 -mcx16 -D_GNU_SOURCE -D_FILE_OFFSET_BITS=3D64 -D_LARGEFILE_SOURCE
> -Wstrict-prototypes -Wredundant-decls -Wall -Wundef -Wwrite-strings
> -Wmissing-prototypes -fno-strict-aliasing -fno-common -fwrapv -Wendif-lab=
els
> -Wno-missing-include-dirs -Wempty-body -Wnested-externs -Wformat-security
> -Wformat-y2k -Winit-self -Wignored-qualifiers -Wold-style-declaration
> -Wold-style-definition -Wtype-limits -fstack-protector-strong
> -I/usr/include/libpng12 -I/data/src/qemu2/tests" LDFLAGS=3D"-rdynamic
> -Wl,--warn-common -Wl,-z,relro -Wl,-z,now -pie -m64 -g " ARFLAGS=3D"rv" C=
C=3D"cc"
> AR=3D"ar" LD=3D"ld" BUILD_DIR=3D/data/src/qemu2/build libfdt/libfdt.a
> make[1]: Entering directory '/data/src/qemu2/build/dtc'
> make[1]: 'libfdt/libfdt.a' is up to date.
> make[1]: Leaving directory '/data/src/qemu2/build/dtc'
> make  BUILD_DIR=3D/data/src/qemu2/build -C x86_64-linux-user V=3D"1" TARG=
ET_DIR=3D"x86_64-linux-user/" all
> make[1]: Entering directory '/data/src/qemu2/build/x86_64-linux-user'
> cc -I/data/src/qemu2/build/. -I. -I/data/src/qemu2/tcg
> -I/data/src/qemu2/tcg/i386 -I/data/src/qemu2/instrument
> -I/data/src/qemu2/linux-headers -I/data/src/qemu2/build/linux-headers
> -I. -I/data/src/qemu2 -I/data/src/qemu2/accel/tcg -I/data/src/qemu2/inclu=
de
> -fvisibility=3Dhidden -I/usr/include/pixman-1 -I/data/src/qemu2/dtc/libfd=
t -Werror
> -pthread -I/usr/include/glib-2.0 -I/usr/lib/x86_64-linux-gnu/glib-2.0/inc=
lude
> -fPIE -DPIE -m64 -mcx16 -D_GNU_SOURCE -D_FILE_OFFSET_BITS=3D64 -D_LARGEFI=
LE_SOURCE
> -Wstrict-prototypes -Wredundant-decls -Wall -Wundef -Wwrite-strings
> -Wmissing-prototypes -fno-strict-aliasing -fno-common -fwrapv -Wendif-lab=
els
> -Wno-missing-include-dirs -Wempty-body -Wnested-externs -Wformat-security
> -Wformat-y2k -Winit-self -Wignored-qualifiers -Wold-style-declaration
> -Wold-style-definition -Wtype-limits -fstack-protector-strong
> -I/usr/include/libpng12 -I../linux-headers -I.. -I/data/src/qemu2/target/=
i386
> -DNEED_CPU_H -I/data/src/qemu2/include -I/data/src/qemu2/linux-user/x86_64
> -I/data/src/qemu2/linux-user/host/x86_64 -I/data/src/qemu2/linux-user -MM=
D -MP
> -MT gdbstub-xml.o -MF ./gdbstub-xml.d -O2 -U_FORTIFY_SOURCE -D_FORTIFY_SO=
URCE=3D2
> -g -DQEMU_TARGET_BUILD=3D1 -c -o gdbstub-xml.o gdbstub-xml.c
> cc -I/data/src/qemu2/build/instrument -Iinstrument -I/data/src/qemu2/tcg
> -I/data/src/qemu2/tcg/i386 -I/data/src/qemu2/instrument
> -I/data/src/qemu2/linux-headers -I/data/src/qemu2/build/linux-headers
> -I. -I/data/src/qemu2 -I/data/src/qemu2/accel/tcg -I/data/src/qemu2/inclu=
de
> -fvisibility=3Dhidden -I/usr/include/pixman-1 -I/data/src/qemu2/dtc/libfd=
t -Werror
> -pthread -I/usr/include/glib-2.0 -I/usr/lib/x86_64-linux-gnu/glib-2.0/inc=
lude
> -fPIE -DPIE -m64 -mcx16 -D_GNU_SOURCE -D_FILE_OFFSET_BITS=3D64 -D_LARGEFI=
LE_SOURCE
> -Wstrict-prototypes -Wredundant-decls -Wall -Wundef -Wwrite-strings
> -Wmissing-prototypes -fno-strict-aliasing -fno-common -fwrapv -Wendif-lab=
els
> -Wno-missing-include-dirs -Wempty-body -Wnested-externs -Wformat-security
> -Wformat-y2k -Winit-self -Wignored-qualifiers -Wold-style-declaration
> -Wold-style-definition -Wtype-limits -fstack-protector-strong
> -I/usr/include/libpng12 -I../linux-headers -I.. -I/data/src/qemu2/target/=
i386
> -DNEED_CPU_H -I/data/src/qemu2/include -I/data/src/qemu2/linux-user/x86_64
> -I/data/src/qemu2/linux-user/host/x86_64 -I/data/src/qemu2/linux-user -MM=
D -MP
> -MT instrument/trace.o -MF instrument/trace.d -O2 -U_FORTIFY_SOURCE
> -D_FORTIFY_SOURCE=3D2 -g -DQEMU_TARGET_BUILD=3D1 -c -o instrument/trace.o
> /data/src/qemu2/instrument/trace.c
> /data/src/qemu2/instrument/trace.c:13:30: fatal error: qemu-instr/trace.h=
: No such file or directory
> compilation terminated.
> /data/src/qemu2/rules.mak:66: recipe for target 'instrument/trace.o' fail=
ed
> make[1]: *** [instrument/trace.o] Error 1
> make[1]: Leaving directory '/data/src/qemu2/build/x86_64-linux-user'
> Makefile:326: recipe for target 'subdir-x86_64-linux-user' failed
> make: *** [subdir-x86_64-linux-user] Error 2

The includes look fine to me... (there's "-I/data/src/qemu2/instrument"). C=
an
you paste the result of "find /data/src/qemu2/instrument"? You should have a
"/data/src/qemu2/instrument/qemu-instr/trace.h" file there.

In any case, I was planning to drop the tracing API for the next series.


Thanks,
  Lluis
