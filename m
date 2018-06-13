Received: from eggs.gnu.org ([2001:4830:134:3::10]:50348)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fT5Jp-0002aa-C2
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 08:56:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fT5Jm-00051z-MC
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 08:56:09 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:56059)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fT5Jm-00050b-F9
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 08:56:06 -0400
Received: by mail-wm0-x243.google.com with SMTP id v16-v6so4521524wmh.5
	for <qemu-devel@nongnu.org>; Wed, 13 Jun 2018 05:56:06 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Wed, 13 Jun 2018 13:55:43 +0100
Message-Id: <20180613125601.14371-5-alex.bennee@linaro.org>
In-Reply-To: <20180613125601.14371-1-alex.bennee@linaro.org>
References: <20180613125601.14371-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RISU PATCH v3 04/22] build-all-arches: do a distclean
 $(SRC) configured
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, richard.henderson@linaro.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

This can cause much confusion when you have been building in your
source tree. I've added a distclean so we don't unexpectedly drop the
config for normal make clean invocations.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 Makefile        |  3 +++
 build-all-archs | 10 ++++++++++
 2 files changed, 13 insertions(+)

diff --git a/Makefile b/Makefile
index ca80eef..16e48a0 100644
--- a/Makefile
+++ b/Makefile
@@ -51,3 +51,6 @@ $(PROG): $(OBJS)
 
 clean:
 	rm -f $(PROG) $(OBJS) $(BINS)
+
+distclean: clean
+	rm -f config.h Makefile.in
diff --git a/build-all-archs b/build-all-archs
index a2f5cff..a7cd7c2 100755
--- a/build-all-archs
+++ b/build-all-archs
@@ -54,6 +54,16 @@ while [[ "$1" = -* ]]; do
     esac
 done
 
+#
+# If you are developing your primary architecture directly out of the
+# source tree you can confuse any out-of-tree builds thanks to random
+# crap in your VPATH. Let's detect that and save some hair pulling.
+#
+if [ -e Makefile.in ]; then
+    echo "Cleaning in-src-tree build"
+    make distclean
+fi
+
 # Debian stretch and Ubuntu Xenial have cross compiler packages for
 # all of these:
 #   gcc-arm-linux-gnueabihf gcc-aarch64-linux-gnu gcc-m68k-linux-gnu
-- 
2.17.1
