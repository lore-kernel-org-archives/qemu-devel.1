Received: from eggs.gnu.org ([2001:4830:134:3::10]:34386)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1csrQH-0007FF-Rc
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 09:44:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1csrQD-0008FM-5d
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 09:44:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47900)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1csrQC-0008FI-TI
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 09:44:29 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Tue, 28 Mar 2017 14:44:18 +0100
Message-Id: <20170328134418.3426-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PATCH v2] configure: eliminate Python dependency for
 --help
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>

The ./configure script should produce --help output even if Python is
not installed.

Listing trace backends is simple: show the names of all Python modules
in scripts/tracetool/backend/ whose source code contains 'PUBLIC =
True'.

Perform the backend enumeration in shell instead of Python so that we
can move the Python check until after ./configure --help.

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
v2:
 * Make grep regex portable [Peter]
 * Enumerate trace backends outside help text [Peter]

 configure | 35 +++++++++++++++++++----------------
 1 file changed, 19 insertions(+), 16 deletions(-)

diff --git a/configure b/configure
index d1ce33b..2c31665 100755
--- a/configure
+++ b/configure
@@ -1186,21 +1186,6 @@ for opt do
   esac
 done
 
-if ! has $python; then
-  error_exit "Python not found. Use --python=/path/to/python"
-fi
-
-# Note that if the Python conditional here evaluates True we will exit
-# with status 1 which is a shell 'false' value.
-if ! $python -c 'import sys; sys.exit(sys.version_info < (2,6) or sys.version_info >= (3,))'; then
-  error_exit "Cannot use '$python', Python 2.6 or later is required." \
-      "Note that Python 3 or later is not yet supported." \
-      "Use --python=/path/to/python to specify a supported Python."
-fi
-
-# Suppress writing compiled files
-python="$python -B"
-
 case "$cpu" in
     ppc)
            CPU_CFLAGS="-m32"
@@ -1275,6 +1260,9 @@ for config in $mak_wilds; do
     default_target_list="${default_target_list} $(basename "$config" .mak)"
 done
 
+# Enumerate public trace backends for --help output
+trace_backend_list=$(echo $(grep -le '^PUBLIC = True$' scripts/tracetool/backend/*.py | sed -e 's/^.*\/\(.*\)\.py$/\1/'))
+
 if test x"$show_help" = x"yes" ; then
 cat << EOF
 
@@ -1328,7 +1316,7 @@ Advanced options (experts only):
                            set block driver read-only whitelist
                            (affects only QEMU, not qemu-img)
   --enable-trace-backends=B Set trace backend
-                           Available backends: $($python $source_path/scripts/tracetool.py --list-backends)
+                           Available backends: $trace_backend_list
   --with-trace-file=NAME   Full PATH,NAME of file to store traces
                            Default:trace-<pid>
   --disable-slirp          disable SLIRP userspace network connectivity
@@ -1428,6 +1416,21 @@ EOF
 exit 0
 fi
 
+if ! has $python; then
+  error_exit "Python not found. Use --python=/path/to/python"
+fi
+
+# Note that if the Python conditional here evaluates True we will exit
+# with status 1 which is a shell 'false' value.
+if ! $python -c 'import sys; sys.exit(sys.version_info < (2,6) or sys.version_info >= (3,))'; then
+  error_exit "Cannot use '$python', Python 2.6 or later is required." \
+      "Note that Python 3 or later is not yet supported." \
+      "Use --python=/path/to/python to specify a supported Python."
+fi
+
+# Suppress writing compiled files
+python="$python -B"
+
 # Now we have handled --enable-tcg-interpreter and know we're not just
 # printing the help message, bail out if the host CPU isn't supported.
 if test "$ARCH" = "unknown"; then
-- 
2.9.3
