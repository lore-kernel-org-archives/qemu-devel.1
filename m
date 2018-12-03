Received: from eggs.gnu.org ([2001:4830:134:3::10]:44192)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gTorf-0001u1-1x
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 09:06:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gTorP-00027A-2j
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 09:06:22 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48120)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gTorK-0001gc-S0
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 09:06:04 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Mon,  3 Dec 2018 15:05:31 +0100
Message-Id: <1543845937-300-2-git-send-email-thuth@redhat.com>
In-Reply-To: <1543845937-300-1-git-send-email-thuth@redhat.com>
References: <1543845937-300-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH for-4.0 1/7] configure: Add a test for the
 minimum compiler version
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, pbonzini@redhat.com, peter.maydell@linaro.org

So far we only had implicit requirements for the minimum compiler version,
e.g. we require at least GCC 4.1 for the support of atomics. However,
such old compiler versions are not tested anymore by the developers, so
they are not really supported anymore. Since we recently declared explicitly
what platforms we intend to support, we can also get more explicit on the
compiler version now. The supported distributions use the following version
of GCC:

      RHEL-7: 4.8.5
      Debian (Stretch): 6.3.0
      Debian (Jessie): 4.8.4
      OpenBSD (ports): 4.9.4
      FreeBSD (ports): 8.2.0
      OpenSUSE Leap 15: 7.3.1
      Ubuntu (Xenial): 5.3.1
      macOS (Homebrew): 8.2.0

So we can safely assume GCC 4.8 these days. For Clang, the situation is
a little bit more ambiguous, since it is sometimes not available in the
main distros but rather third party repositories. At least Debian Jessie
uses version 3.5, and EPEL7 for RHEL7 uses 3.4, so let's use 3.4 as
minimum Clang version now - we still can adjust this later if necessary.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 configure | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/configure b/configure
index 0a3c6a7..f1e305e 100755
--- a/configure
+++ b/configure
@@ -1840,6 +1840,25 @@ if test "$bogus_os" = "yes"; then
     error_exit "Unrecognized host OS (uname -s reports '$(uname -s)')"
 fi
 
+# Check whether the compiler matches our minimum requirements:
+cat > $TMPC << EOF
+#if defined(__clang_major__) && defined(__clang_minor__)
+# if __clang_major__ < 3 || (__clang_major__ == 3 && __clang_minor__ < 4)
+#  error You need at least Clang v3.4 to compile QEMU
+# endif
+#elif defined(__GNUC__) && defined(__GNUC_MINOR__)
+# if __GNUC__ < 4 || (__GNUC__ == 4 && __GNUC_MINOR__ < 8)
+#  error You need at least GCC v4.8 to compile QEMU
+# endif
+#else
+# error You either need GCC or Clang to compiler QEMU
+#endif
+int main (void) { return 0; }
+EOF
+if ! compile_prog "" "" ; then
+    error_exit "You need at least GCC v4.8 or Clang v3.4 to compiler QEMU"
+fi
+
 gcc_flags="-Wold-style-declaration -Wold-style-definition -Wtype-limits"
 gcc_flags="-Wformat-security -Wformat-y2k -Winit-self -Wignored-qualifiers $gcc_flags"
 gcc_flags="-Wno-missing-include-dirs -Wempty-body -Wnested-externs $gcc_flags"
-- 
1.8.3.1
