Received: from eggs.gnu.org ([209.51.188.92]:46418)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <deller@gmx.de>) id 1hC7YO-0005ye-Ga
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 14:57:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <deller@gmx.de>) id 1hC7YN-0001zF-Iu
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 14:57:36 -0400
Received: from mout.gmx.net ([212.227.17.22]:52979)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <deller@gmx.de>) id 1hC7YN-0001uo-4z
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 14:57:35 -0400
Date: Thu, 4 Apr 2019 20:57:30 +0200
From: Helge Deller <deller@gmx.de>
Message-ID: <20190404185730.GA22512@ls3530.dellerweb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] configure: Automatically fall back to TCI on
 non-release architectures
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

If a non-release architecture is found, and it's known that there is no
native TCG support for that CPU, automatically fall back to the TCI
implementation instead of requesting the user to run configure again
with the --enable-tcg-interpreter option.

This change simplifies building qemu in automatic build environments
(like in my case the debian buildds) because one does not need to
special case on the architectures.

Signed-off-by: Helge Deller <deller@gmx.de>

diff --git a/configure b/configure
index 1c563a7027..8fe4fc84d8 100755
=2D-- a/configure
+++ b/configure
@@ -769,8 +769,10 @@ case "$cpu" in
     cross_cc_sparc=3D$host_cc
   ;;
   *)
-    # This will result in either an error or falling back to TCI later
+    # Fall back to TCI on unsupported CPUs
     ARCH=3Dunknown
+    echo "Unsupported '$cpu' CPU found. Will use TCG with TCI (experiment=
al)."
+    tcg_interpreter=3D"yes"
   ;;
 esac
 if test -z "$ARCH"; then
@@ -1855,16 +1857,6 @@ if ! compile_prog ; then
     error_exit "\"$cc\" cannot build an executable (is your linker broken=
?)"
 fi

-# Now we have handled --enable-tcg-interpreter and know we're not just
-# printing the help message, bail out if the host CPU isn't supported.
-if test "$ARCH" =3D "unknown"; then
-    if test "$tcg_interpreter" =3D "yes" ; then
-        echo "Unsupported CPU =3D $cpu, will use TCG with TCI (experiment=
al)"
-    else
-        error_exit "Unsupported CPU =3D $cpu, try --enable-tcg-interprete=
r"
-    fi
-fi
-
 # Consult white-list to determine whether to enable werror
 # by default.  Only enable by default for git builds
 if test -z "$werror" ; then
