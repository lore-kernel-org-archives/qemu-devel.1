Received: from eggs.gnu.org ([209.51.188.92]:60471)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hJEue-0005E3-UN
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 06:14:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hJEi0-0005Ev-Dn
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 06:01:01 -0400
Received: from indium.canonical.com ([91.189.90.7]:48010)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hJEi0-0005Di-88
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 06:00:56 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hJEhz-0006Gx-C7
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 10:00:55 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 59FF32E80CE
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 10:00:55 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 Apr 2019 09:45:13 -0000
From: Gwendolyn Haller <1826172@bugs.launchpad.net>
Reply-To: Bug 1826172 <1826172@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <155609911336.14005.5630723939838624325.malonedeb@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1826172] [NEW] Compilation on MSYS2/MinGW-w64
 fails with error: "__USE_MINGW_ANSI_STDIO" redefined
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Public bug reported:

Compilation against GIT master fails at the following step:

=C2=A0=C2=A0CC      qga/commands.o
In file included from qga/commands.c:13:
C:/Tempy-chan/qemu/include/qemu/osdep.h:97: error: "__USE_MINGW_ANSI_STDIO"=
 redefined [-Werror]
=C2=A0#define __USE_MINGW_ANSI_STDIO 1

In file included from C:/msys64/mingw64/x86_64-w64-mingw32/include/vadefs.h=
:9,
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0from C:/msys64/mingw64/x86_64-w64-mingw32/includ=
e/_mingw_stdarg.h:14,
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0from C:/msys64/mingw64/x86_64-w64-mingw32/includ=
e/stdarg.h:140,
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0from C:/msys64/mingw64/lib/gcc/x86_64-w64-mingw3=
2/8.3.0/include/stdarg.h:1,
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0from C:/Tempy-chan/qemu/include/qemu/osdep.h:88,
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0from qga/commands.c:13:
C:/msys64/mingw64/x86_64-w64-mingw32/include/_mingw.h:431: note: this is th=
e location of the previous definition
=C2=A0#define __USE_MINGW_ANSI_STDIO 0      /* was not defined so it should=
 be 0 */

cc1.exe: all warnings being treated as errors
make: *** [/c/Tempy-chan/qemu/rules.mak:69: qga/commands.o] Error 1

Passing --extra-cflags=3D"-D__USE_MINGW_ANSI_STDIO" to configure resolves
the error. Digging deeper in x86_64-w64-mingw32/include/_mingw.h, it
looks like __USE_MINGW_ANSI_STDIO is only defined for _GNU_SOURCE in C++
compilation. With C only code it's ignored and doesn't define
__USE_MINGW_ANSI_STDIO as expected:

/* We are activating __USE_MINGW_ANSI_STDIO for various define indicators.
=C2=A0=C2=A0=C2=A0Note that we enable it also for _GNU_SOURCE in C++, but n=
ot for C case. */
#if (defined (_POSIX) || defined (_POSIX_SOURCE) || defined (_POSIX_C_SOURC=
E) \
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|| defined (_ISOC99_SOURCE) \
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|| defined (_XOPEN_SOURCE) || defined (_XOPEN=
_SOURCE_EXTENDED) \
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|| (defined (_GNU_SOURCE) && defined (__cplus=
plus)) \
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|| defined (_SVID_SOURCE)) \
=C2=A0=C2=A0=C2=A0=C2=A0&& !defined(__USE_MINGW_ANSI_STDIO)
/* Enable __USE_MINGW_ANSI_STDIO if _POSIX defined
=C2=A0* and If user did _not_ specify it explicitly... */
#  define __USE_MINGW_ANSI_STDIO			1
#endif

** Affects: qemu
     Importance: Undecided
         Status: New

** Description changed:

- Compilation against latest GIT version fails at the following step:
+ Compilation against GIT master fails at the following step:
  =

-   CC      qga/commands.o
+ =C2=A0=C2=A0CC      qga/commands.o
  In file included from qga/commands.c:13:
  C:/Tempy-chan/qemu/include/qemu/osdep.h:97: error: "__USE_MINGW_ANSI_STDI=
O" redefined [-Werror]
-  #define __USE_MINGW_ANSI_STDIO 1
+ =C2=A0#define __USE_MINGW_ANSI_STDIO 1
  =

  In file included from C:/msys64/mingw64/x86_64-w64-mingw32/include/vadefs=
.h:9,
-                  from C:/msys64/mingw64/x86_64-w64-mingw32/include/_mingw=
_stdarg.h:14,
-                  from C:/msys64/mingw64/x86_64-w64-mingw32/include/stdarg=
.h:140,
-                  from C:/msys64/mingw64/lib/gcc/x86_64-w64-mingw32/8.3.0/=
include/stdarg.h:1,
-                  from C:/Tempy-chan/qemu/include/qemu/osdep.h:88,
-                  from qga/commands.c:13:
+ =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0from C:/msys64/mingw64/x86_64-w64-mingw32/inc=
lude/_mingw_stdarg.h:14,
+ =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0from C:/msys64/mingw64/x86_64-w64-mingw32/inc=
lude/stdarg.h:140,
+ =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0from C:/msys64/mingw64/lib/gcc/x86_64-w64-min=
gw32/8.3.0/include/stdarg.h:1,
+ =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0from C:/Tempy-chan/qemu/include/qemu/osdep.h:=
88,
+ =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0from qga/commands.c:13:
  C:/msys64/mingw64/x86_64-w64-mingw32/include/_mingw.h:431: note: this is =
the location of the previous definition
-  #define __USE_MINGW_ANSI_STDIO 0      /* was not defined so it should be=
 0 */
+ =C2=A0#define __USE_MINGW_ANSI_STDIO 0      /* was not defined so it shou=
ld be 0 */
  =

  cc1.exe: all warnings being treated as errors
  make: *** [/c/Tempy-chan/qemu/rules.mak:69: qga/commands.o] Error 1
  =

  Passing --extra-cflags=3D"-D__USE_MINGW_ANSI_STDIO" to configure resolves
  the error. Digging deeper in x86_64-w64-mingw32/include/_mingw.h, it
  looks like __USE_MINGW_ANSI_STDIO is only defined for _GNU_SOURCE in C++
  compilation. With C only code it's ignored and doesn't define
  __USE_MINGW_ANSI_STDIO as expected:
  =

  /* We are activating __USE_MINGW_ANSI_STDIO for various define indicators.
-    Note that we enable it also for _GNU_SOURCE in C++, but not for C case=
. */
+ =C2=A0=C2=A0=C2=A0Note that we enable it also for _GNU_SOURCE in C++, but=
 not for C case. */
  #if (defined (_POSIX) || defined (_POSIX_SOURCE) || defined (_POSIX_C_SOU=
RCE) \
-      || defined (_ISOC99_SOURCE) \
-      || defined (_XOPEN_SOURCE) || defined (_XOPEN_SOURCE_EXTENDED) \
-      || (defined (_GNU_SOURCE) && defined (__cplusplus)) \
-      || defined (_SVID_SOURCE)) \
-     && !defined(__USE_MINGW_ANSI_STDIO)
+ =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|| defined (_ISOC99_SOURCE) \
+ =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|| defined (_XOPEN_SOURCE) || defined (_XOP=
EN_SOURCE_EXTENDED) \
+ =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|| (defined (_GNU_SOURCE) && defined (__cpl=
usplus)) \
+ =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|| defined (_SVID_SOURCE)) \
+ =C2=A0=C2=A0=C2=A0=C2=A0&& !defined(__USE_MINGW_ANSI_STDIO)
  /* Enable __USE_MINGW_ANSI_STDIO if _POSIX defined
-  * and If user did _not_ specify it explicitly... */
+ =C2=A0* and If user did _not_ specify it explicitly... */
  #  define __USE_MINGW_ANSI_STDIO			1
  #endif

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1826172

Title:
  Compilation on MSYS2/MinGW-w64 fails with error:
  "__USE_MINGW_ANSI_STDIO" redefined

Status in QEMU:
  New

Bug description:
  Compilation against GIT master fails at the following step:

  =C2=A0=C2=A0CC      qga/commands.o
  In file included from qga/commands.c:13:
  C:/Tempy-chan/qemu/include/qemu/osdep.h:97: error: "__USE_MINGW_ANSI_STDI=
O" redefined [-Werror]
  =C2=A0#define __USE_MINGW_ANSI_STDIO 1

  In file included from C:/msys64/mingw64/x86_64-w64-mingw32/include/vadefs=
.h:9,
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0from C:/msys64/mingw64/x86_64-w64-mingw32/inc=
lude/_mingw_stdarg.h:14,
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0from C:/msys64/mingw64/x86_64-w64-mingw32/inc=
lude/stdarg.h:140,
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0from C:/msys64/mingw64/lib/gcc/x86_64-w64-min=
gw32/8.3.0/include/stdarg.h:1,
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0from C:/Tempy-chan/qemu/include/qemu/osdep.h:=
88,
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0from qga/commands.c:13:
  C:/msys64/mingw64/x86_64-w64-mingw32/include/_mingw.h:431: note: this is =
the location of the previous definition
  =C2=A0#define __USE_MINGW_ANSI_STDIO 0      /* was not defined so it shou=
ld be 0 */

  cc1.exe: all warnings being treated as errors
  make: *** [/c/Tempy-chan/qemu/rules.mak:69: qga/commands.o] Error 1

  Passing --extra-cflags=3D"-D__USE_MINGW_ANSI_STDIO" to configure
  resolves the error. Digging deeper in
  x86_64-w64-mingw32/include/_mingw.h, it looks like
  __USE_MINGW_ANSI_STDIO is only defined for _GNU_SOURCE in C++
  compilation. With C only code it's ignored and doesn't define
  __USE_MINGW_ANSI_STDIO as expected:

  /* We are activating __USE_MINGW_ANSI_STDIO for various define indicators.
  =C2=A0=C2=A0=C2=A0Note that we enable it also for _GNU_SOURCE in C++, but=
 not for C case. */
  #if (defined (_POSIX) || defined (_POSIX_SOURCE) || defined (_POSIX_C_SOU=
RCE) \
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|| defined (_ISOC99_SOURCE) \
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|| defined (_XOPEN_SOURCE) || defined (_XOP=
EN_SOURCE_EXTENDED) \
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|| (defined (_GNU_SOURCE) && defined (__cpl=
usplus)) \
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|| defined (_SVID_SOURCE)) \
  =C2=A0=C2=A0=C2=A0=C2=A0&& !defined(__USE_MINGW_ANSI_STDIO)
  /* Enable __USE_MINGW_ANSI_STDIO if _POSIX defined
  =C2=A0* and If user did _not_ specify it explicitly... */
  #  define __USE_MINGW_ANSI_STDIO			1
  #endif

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1826172/+subscriptions
