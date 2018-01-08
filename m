Received: from eggs.gnu.org ([2001:4830:134:3::10]:33822)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYbF2-0008PZ-LH
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 12:29:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYbF1-0000Y2-R4
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 12:29:44 -0500
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:36061)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYbF1-0000X9-Nv
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 12:29:43 -0500
Received: by mail-qk0-x244.google.com with SMTP id d21so4111676qkj.3
	for <qemu-devel@nongnu.org>; Mon, 08 Jan 2018 09:29:43 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon,  8 Jan 2018 14:29:02 -0300
Message-Id: <20180108172904.8772-11-f4bug@amsat.org>
In-Reply-To: <20180108172904.8772-1-f4bug@amsat.org>
References: <20180108172904.8772-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 10/12] configure: disable unaligned access
 warning on x86 arch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Thibault <samuel.thibault@ens-lyon.org>, Jan Kiszka <jan.kiszka@siemens.com>, "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 configure | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/configure b/configure
index 56f9716609..28cd073941 100755
--- a/configure
+++ b/configure
@@ -276,6 +276,7 @@ cc_i386=i386-pc-linux-gnu-gcc
 libs_qga=""
 debug_info="yes"
 stack_protector=""
+host_supports_unaligned_access="no"
 
 if test -e "$source_path/.git"
 then
@@ -692,6 +693,13 @@ if test -z "$ARCH"; then
   ARCH="$cpu"
 fi
 
+# ARCH specific
+case "$ARCH" in
+  i386|x86_64)
+    host_supports_unaligned_access="yes"
+  ;;
+esac
+
 # OS specific
 
 # host *BSD for user mode
@@ -4993,6 +5001,15 @@ if test "$fortify_source" != "no"; then
   fi
 fi
 
+#################################################
+# check if host supports unaligned access
+
+if test "$host_supports_unaligned_access" != "no"; then
+  if compile_prog "-Werror -Wno-address-of-packed-member" "" ; then
+    QEMU_CFLAGS="-Wno-address-of-packed-member $QEMU_CFLAGS"
+  fi
+fi
+
 ##########################################
 # check if struct fsxattr is available via linux/fs.h
 
-- 
2.15.1
