Received: from eggs.gnu.org ([2001:4830:134:3::10]:52535)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gX6Mh-0000zq-8u
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 10:24:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gX6Md-0000Nj-7V
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 10:23:59 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:54482)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gX6Mc-0000MS-U0
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 10:23:55 -0500
Received: by mail-wm1-x344.google.com with SMTP id a62so6179678wmh.4
	for <qemu-devel@nongnu.org>; Wed, 12 Dec 2018 07:23:54 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 12 Dec 2018 16:22:54 +0100
Message-Id: <1544628195-37728-34-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1544628195-37728-1-git-send-email-pbonzini@redhat.com>
References: <1544628195-37728-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 33/54] configure: Add a test for the minimum
 compiler version
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>

From: Thomas Huth <thuth@redhat.com>

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

Unfortunately Apple uses different version numbers for the Clang that is
included in their Xcode suite, so we need to check the version numbers
for Xcode separately. Xcode 5.1 seems to be the first one that has been
shipped with LLVM 3.4, so use this version as the minimum there.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <1543937577-28256-2-git-send-email-thuth@redhat.com>
---
 configure | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/configure b/configure
index 8c292ef..51150b1 100755
--- a/configure
+++ b/configure
@@ -1837,6 +1837,31 @@ if test "$bogus_os" = "yes"; then
     error_exit "Unrecognized host OS (uname -s reports '$(uname -s)')"
 fi
 
+# Check whether the compiler matches our minimum requirements:
+cat > $TMPC << EOF
+#if defined(__clang_major__) && defined(__clang_minor__)
+# ifdef __apple_build_version__
+#  if __clang_major__ < 5 || (__clang_major__ == 5 && __clang_minor__ < 1)
+#   error You need at least XCode Clang v5.1 to compile QEMU
+#  endif
+# else
+#  if __clang_major__ < 3 || (__clang_major__ == 3 && __clang_minor__ < 4)
+#   error You need at least Clang v3.4 to compile QEMU
+#  endif
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
+    error_exit "You need at least GCC v4.8 or Clang v3.4 (or XCode Clang v5.1)"
+fi
+
 gcc_flags="-Wold-style-declaration -Wold-style-definition -Wtype-limits"
 gcc_flags="-Wformat-security -Wformat-y2k -Winit-self -Wignored-qualifiers $gcc_flags"
 gcc_flags="-Wno-missing-include-dirs -Wempty-body -Wnested-externs $gcc_flags"
-- 
1.8.3.1
