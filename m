Received: from eggs.gnu.org ([209.51.188.92]:50203)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1ghDpV-0003PP-5m
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 08:23:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1ghDpQ-0000zd-BJ
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 08:23:30 -0500
From: "Richard W.M. Jones" <rjones@redhat.com>
Date: Wed,  9 Jan 2019 13:23:02 +0000
Message-Id: <20190109132302.22634-2-rjones@redhat.com>
In-Reply-To: <20190109132302.22634-1-rjones@redhat.com>
References: <20190109132302.22634-1-rjones@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3] qemu-io: Add generic function for
 reinitializing optind.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eblake@redhat.com
Cc: kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org

On FreeBSD 11.2:

  $ nbdkit memory size=3D1M --run './qemu-io -f raw -c "aio_write 0 512" =
$nbd'
  Parsing error: non-numeric argument, or extraneous/unrecognized suffix =
-- aio_write

After main option parsing, we reinitialize optind so we can parse each
command.  However reinitializing optind to 0 does not work on FreeBSD.
What happens when you do this is optind remains 0 after the option
parsing loop, and the result is we try to parse argv[optind] =3D=3D
argv[0] =3D=3D "aio_write" as if it was the first parameter.

The FreeBSD manual page says:

  In order to use getopt() to evaluate multiple sets of arguments, or to
  evaluate a single set of arguments multiple times, the variable optrese=
t
  must be set to 1 before the second and each additional set of calls to
  getopt(), and the variable optind must be reinitialized.

(From the rest of the man page it is clear that optind must be
reinitialized to 1).

The glibc man page says:

  A program that scans multiple argument vectors,  or  rescans  the  same
  vector  more than once, and wants to make use of GNU extensions such as
  '+' and '-' at  the  start  of  optstring,  or  changes  the  value  of
  POSIXLY_CORRECT  between scans, must reinitialize getopt() by resetting
  optind to 0, rather than the traditional value of 1.  (Resetting  to  0
  forces  the  invocation  of  an  internal  initialization  routine that
  rechecks POSIXLY_CORRECT and checks for GNU extensions in optstring.)

This commit introduces an OS-portability function called
qemu_reset_optind which provides a way of resetting optind that works
on FreeBSD, while keeping it the same on other OSes.

Note that the qemu codebase sets optind in many other places, but in
those other places it's setting a local variable and not using getopt.
This change is only needed in places where we are using getopt and the
associated global variable optind.

Signed-off-by: Richard W.M. Jones <rjones@redhat.com>
---
 include/qemu/osdep.h | 18 ++++++++++++++++++
 qemu-img.c           |  2 +-
 qemu-io-cmds.c       |  2 +-
 3 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index 3bf48bcdec..ea4ce4db9e 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -92,6 +92,7 @@ extern int daemon(int, int);
 #include <ctype.h>
 #include <errno.h>
 #include <fcntl.h>
+#include <getopt.h>
 #include <sys/stat.h>
 #include <sys/time.h>
 #include <assert.h>
@@ -587,4 +588,21 @@ extern int qemu_icache_linesize_log;
 extern int qemu_dcache_linesize;
 extern int qemu_dcache_linesize_log;
=20
+/**
+ * qemu_reset_optind:
+ *
+ * After using getopt or getopt_long, if you need to parse another set
+ * of options, then you must reset optind.  Unfortunately the way to
+ * do this varies between implementations of getopt.
+ */
+static inline void qemu_reset_optind(void)
+{
+#ifdef __FreeBSD__
+    optind =3D 1;
+    optreset =3D 1;
+#else
+    optind =3D 0;
+#endif
+}
+
 #endif
diff --git a/qemu-img.c b/qemu-img.c
index ad04f59565..25288c4d18 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -4962,7 +4962,7 @@ int main(int argc, char **argv)
         return 0;
     }
     argv +=3D optind;
-    optind =3D 0;
+    qemu_reset_optind();
=20
     if (!trace_init_backends()) {
         exit(1);
diff --git a/qemu-io-cmds.c b/qemu-io-cmds.c
index 2c39124036..ee8f56e46a 100644
--- a/qemu-io-cmds.c
+++ b/qemu-io-cmds.c
@@ -114,7 +114,7 @@ static int command(BlockBackend *blk, const cmdinfo_t=
 *ct, int argc,
         }
     }
=20
-    optind =3D 0;
+    qemu_reset_optind();
     return ct->cfunc(blk, argc, argv);
 }
=20
--=20
2.20.1
