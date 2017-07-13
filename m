Received: from eggs.gnu.org ([2001:4830:134:3::10]:41357)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dVfq8-00064Z-Sk
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 11:15:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dVfq4-0005tn-Hw
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 11:15:40 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 13 Jul 2017 16:15:32 +0100
Message-Id: <1499958932-23839-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH] configure: Never use 'uname' to identify
 target OS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Cc: patches@linaro.org

For a very long time we have used 'uname -s' as our fallback if
we don't identify the target OS using a compiler #define. This
obviously doesn't work for cross-compilation, and we've had
a comment suggesting we fix this in configure for a long time.
Since we now have an exhaustive list of which OSes we can run
on (thanks to commit 898be3e0415 making an unrecognized OS
be a fatal error), we know which ones we're missing.

Add check_define tests for the remaining OSes we support.  The
defines checked are based on ones we already use in the codebase for
identifying the host OS (with the exception of GNU/kFreeBSD).
We can now set bogus_os immediately rather than doing it later.

We leave the comment about uname being bad untouched, since
there is still a use of it for the fallback for unrecognized
host CPU type.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---

All of these OSes except OSX are on the "not actually supported"
list, so I don't care very much if we break them.  I did sanity check
FreeBSD and NetBSD which are the two most plausible ones to
get back into supported status.

 configure | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/configure b/configure
index 5096cbc..d733a05 100755
--- a/configure
+++ b/configure
@@ -536,8 +536,24 @@ elif check_define __sun__ ; then
   targetos='SunOS'
 elif check_define __HAIKU__ ; then
   targetos='Haiku'
+elif check_define __FreeBSD__ ; then
+  targetos='FreeBSD'
+elif check_define __FreeBSD_kernel__ && check_define __GLIBC__; then
+  targetos='GNU/kFreeBSD'
+elif check_define __DragonFly__ ; then
+  targetos='DragonFly'
+elif check_define __NetBSD__; then
+  targetos='NetBSD'
+elif check_define __APPLE__; then
+  targetos='Darwin'
+elif check_define _AIX; then
+  targetos='AIX'
 else
-  targetos=$(uname -s)
+  # This is a fatal error, but don't report it yet, because we
+  # might be going to just print the --help text, or it might
+  # be the result of a missing compiler.
+  targetos='bogus'
+  bogus_os='yes'
 fi
 
 # Some host OSes need non-standard checks for which CPU to use.
@@ -781,12 +797,6 @@ Linux)
   QEMU_INCLUDES="-I\$(SRC_PATH)/linux-headers -I$(pwd)/linux-headers $QEMU_INCLUDES"
   supported_os="yes"
 ;;
-*)
-  # This is a fatal error, but don't report it yet, because we
-  # might be going to just print the --help text, or it might
-  # be the result of a missing compiler.
-  bogus_os="yes"
-;;
 esac
 
 if [ "$bsd" = "yes" ] ; then
@@ -1576,7 +1586,7 @@ if test "$bogus_os" = "yes"; then
     # the compiler works (so the results of the check_defines we used
     # to identify the OS are reliable), if we didn't recognize the
     # host OS we should stop now.
-    error_exit "Unrecognized host OS $targetos"
+    error_exit "Unrecognized host OS (uname -s reports '$(uname -s)')"
 fi
 
 gcc_flags="-Wold-style-declaration -Wold-style-definition -Wtype-limits"
-- 
2.7.4
