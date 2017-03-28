Received: from eggs.gnu.org ([2001:4830:134:3::10]:53960)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1csr1U-0004f4-UO
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 09:18:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1csr1Q-0004bG-Oh
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 09:18:56 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:48958)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1csr1Q-0004aZ-Hy
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 09:18:52 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Mar 2017 14:18:49 +0100
Message-Id: <1490707129-12622-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH for-2.9] configure: Don't claim 'unsupported
 host OS' when better message available
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, Stefan Weil <sw@weilnetz.de>

The change in commit 898be3e0415c6d which made completely
unrecognized OSes cause an error_exit "Unsupported host OS"
has some unfortunate unintended effects:
 * if you run 'configure --help' on an unsupported host OS
   (eg if intending to use it as a build machine for a
   cross compile to a supported host) then the message
   is printed instead of --help
 * if the C compiler doesn't work or is missing (eg if
   you passed an incorrect --cross-prefix by mistake)
   the message is printed instead of the more useful
   'compiler does not exist or does not work' message

Fix this by postponing the error_exit in this situation
until later, when we have already identified the more
useful cases for this.

The long term fix for this would be to move handling
of --help much further up in the configure script,
and make its output not dependent on checks that configure
runs. However for 2.9 this would be too invasive.

Reported-by: Stefan Weil <sw@weilnetz.de>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 configure | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/configure b/configure
index 82966f7..8820036 100755
--- a/configure
+++ b/configure
@@ -323,6 +323,7 @@ replication="yes"
 
 supported_cpu="no"
 supported_os="no"
+bogus_os="no"
 
 # parse CC options first
 for opt do
@@ -695,7 +696,10 @@ Linux)
   supported_os="yes"
 ;;
 *)
-  error_exit "Unsupported host OS $targetos"
+  # This is a fatal error, but don't report it yet, because we
+  # might be going to just print the --help text, or it might
+  # be the result of a missing compiler.
+  bogus_os="yes"
 ;;
 esac
 
@@ -1461,6 +1465,14 @@ if ! compile_prog ; then
     error_exit "\"$cc\" cannot build an executable (is your linker broken?)"
 fi
 
+if test "$bogus_os" = "yes"; then
+    # Now that we know that we're not printing the help and that
+    # the compiler works (so the results of the check_defines we used
+    # to identify the OS are reliable), if we didn't recognize the
+    # host OS we should stop now.
+    error_exit "Unsupported host OS $targetos"
+fi
+
 # Check that the C++ compiler exists and works with the C compiler
 if has $cxx; then
     cat > $TMPC <<EOF
-- 
2.7.4
