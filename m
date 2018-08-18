Received: from eggs.gnu.org ([2001:4830:134:3::10]:55266)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fr6Tj-0005Ij-3w
	for qemu-devel@nongnu.org; Sat, 18 Aug 2018 15:01:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fr6Te-0007Ce-5C
	for qemu-devel@nongnu.org; Sat, 18 Aug 2018 15:01:39 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:44527)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fr6Td-0007CB-Vp
	for qemu-devel@nongnu.org; Sat, 18 Aug 2018 15:01:34 -0400
Received: by mail-pf1-x442.google.com with SMTP id k21-v6so4883781pff.11
	for <qemu-devel@nongnu.org>; Sat, 18 Aug 2018 12:01:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat, 18 Aug 2018 12:01:10 -0700
Message-Id: <20180818190118.12911-9-richard.henderson@linaro.org>
In-Reply-To: <20180818190118.12911-1-richard.henderson@linaro.org>
References: <20180818190118.12911-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v4 08/16] configure: Use -Wunused-const-variable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu

For the linux-user syscall split, we have static const structs
that must be matched up with a switch statement that uses them.
By default, gcc will not warn for such a variable, but silently
remove them.

For C++, such objects are sometimes declared for their constructor
side effects.  Do not propagate this flag into QEM_CXXFLAGS.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 configure | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/configure b/configure
index db97930314..86e6e18428 100755
--- a/configure
+++ b/configure
@@ -105,7 +105,8 @@ update_cxxflags() {
     for arg in $QEMU_CFLAGS; do
         case $arg in
             -Wstrict-prototypes|-Wmissing-prototypes|-Wnested-externs|\
-            -Wold-style-declaration|-Wold-style-definition|-Wredundant-decls)
+            -Wold-style-declaration|-Wold-style-definition|-Wredundant-decls|\
+            -Wunused-const-variable)
                 ;;
             *)
                 QEMU_CXXFLAGS=${QEMU_CXXFLAGS:+$QEMU_CXXFLAGS }$arg
@@ -1780,6 +1781,7 @@ gcc_flags="-Wendif-labels -Wno-shift-negative-value $gcc_flags"
 gcc_flags="-Wno-initializer-overrides -Wexpansion-to-defined $gcc_flags"
 gcc_flags="-Wno-string-plus-int $gcc_flags"
 gcc_flags="-Wno-error=address-of-packed-member $gcc_flags"
+gcc_flags="-Wunused-const-variable $gcc_flags"
 # Note that we do not add -Werror to gcc_flags here, because that would
 # enable it for all configure tests. If a configure test failed due
 # to -Werror this would just silently disable some features,
-- 
2.17.1
