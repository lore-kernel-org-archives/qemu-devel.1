Received: from eggs.gnu.org ([209.51.188.92]:45796)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1gkR7i-0003Nz-VB
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 05:11:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1gkR7g-0000e8-Tc
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 05:11:38 -0500
From: "Richard W.M. Jones" <rjones@redhat.com>
Date: Fri, 18 Jan 2019 10:11:14 +0000
Message-Id: <20190118101114.11759-2-rjones@redhat.com>
In-Reply-To: <20190118101114.11759-1-rjones@redhat.com>
References: <20190118101114.11759-1-rjones@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4] qemu-io: Add generic function for
 reinitializing optind.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: kwolf@redhat.com
Cc: mreitz@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org, eblake@redhat.com, berrange@redhat.com

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
on FreeBSD and platforms that use optreset, while keeping it the same
as now on other platforms.

Note that the qemu codebase sets optind in many other places, but in
those other places it's setting a local variable and not using getopt.
This change is only needed in places where we are using getopt and the
associated global variable optind.

Signed-off-by: Richard W.M. Jones <rjones@redhat.com>
---
 configure            | 14 ++++++++++++++
 include/qemu/osdep.h | 16 ++++++++++++++++
 qemu-img.c           |  2 +-
 qemu-io-cmds.c       |  2 +-
 4 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/configure b/configure
index 3eee3fcf70..3d46df1517 100755
--- a/configure
+++ b/configure
@@ -4215,6 +4215,17 @@ if compile_prog "" "" ; then
   signalfd=3Dyes
 fi
=20
+# check if optreset global is declared by <getopt.h>
+optreset=3D"no"
+cat > $TMPC << EOF
+#include <getopt.h>
+int main(void) { return optreset; }
+EOF
+
+if compile_prog "" "" ; then
+  optreset=3Dyes
+fi
+
 # check if eventfd is supported
 eventfd=3Dno
 cat > $TMPC << EOF
@@ -6577,6 +6588,9 @@ fi
 if test "$signalfd" =3D "yes" ; then
   echo "CONFIG_SIGNALFD=3Dy" >> $config_host_mak
 fi
+if test "$optreset" =3D "yes" ; then
+  echo "HAVE_OPTRESET=3Dy" >> $config_host_mak
+fi
 if test "$tcg" =3D "yes"; then
   echo "CONFIG_TCG=3Dy" >> $config_host_mak
   if test "$tcg_interpreter" =3D "yes" ; then
diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index 80df7253db..840af09cb0 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -109,6 +109,7 @@ extern int daemon(int, int);
 #include <ctype.h>
 #include <errno.h>
 #include <fcntl.h>
+#include <getopt.h>
 #include <sys/stat.h>
 #include <sys/time.h>
 #include <assert.h>
@@ -604,4 +605,19 @@ extern int qemu_icache_linesize_log;
 extern int qemu_dcache_linesize;
 extern int qemu_dcache_linesize_log;
=20
+/*
+ * After using getopt or getopt_long, if you need to parse another set
+ * of options, then you must reset optind.  Unfortunately the way to
+ * do this varies between implementations of getopt.
+ */
+static inline void qemu_reset_optind(void)
+{
+#ifdef HAVE_OPTRESET
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
