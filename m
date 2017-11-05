Received: from eggs.gnu.org ([2001:4830:134:3::10]:47016)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eBMLk-0002jI-GB
	for qemu-devel@nongnu.org; Sun, 05 Nov 2017 09:56:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eBMLj-0007KM-Jg
	for qemu-devel@nongnu.org; Sun, 05 Nov 2017 09:56:36 -0500
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:52977)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1eBMLj-0007JQ-CQ
	for qemu-devel@nongnu.org; Sun, 05 Nov 2017 09:56:35 -0500
Received: by mail-wr0-x243.google.com with SMTP id j23so2125862wra.9
	for <qemu-devel@nongnu.org>; Sun, 05 Nov 2017 06:56:35 -0800 (PST)
Received: from donizetti.lan (94-39-170-107.adsl-ull.clienti.tiscali.it.
	[94.39.170.107]) by smtp.gmail.com with ESMTPSA id
	b15sm13030903wrh.35.2017.11.05.06.56.32 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Sun, 05 Nov 2017 06:56:33 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sun,  5 Nov 2017 15:56:25 +0100
Message-Id: <20171105145625.7817-3-pbonzini@redhat.com>
In-Reply-To: <20171105145625.7817-1-pbonzini@redhat.com>
References: <20171105145625.7817-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 2/2] build: disable -Wmissing-braces on older
 compilers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

GCC 4.9 and newer stopped warning for missing braces around the
"universal" C zero initializer {0}.  One such initializer sneaked
into scsi/qemu-pr-helper.c and is breaking the build with such
older GCC versions.

Detect the lack of support for the idiom, and disable the warning
in that case.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/configure b/configure
index 285d123dbf..e31d6a7fee 100755
--- a/configure
+++ b/configure
@@ -1669,6 +1669,19 @@ EOF
   fi
 fi
 
+# Disable -Wmissing-braces on older compilers that warn even for
+# the "universal" C zero initializer {0}.
+cat > $TMPC << EOF
+struct {
+  int a[2];
+} x = {0};
+EOF
+if compile_object "-Werror" "" ; then
+  :
+else
+  QEMU_CFLAGS="$QEMU_CFLAGS -Wno-missing-braces"
+fi
+
 # Workaround for http://gcc.gnu.org/PR55489.  Happens with -fPIE/-fPIC and
 # large functions that use global variables.  The bug is in all releases of
 # GCC, but it became particularly acute in 4.6.x and 4.7.x.  It is fixed in
-- 
2.14.3
