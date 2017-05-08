Received: from eggs.gnu.org ([2001:4830:134:3::10]:37087)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d7alE-0004G5-J4
	for qemu-devel@nongnu.org; Mon, 08 May 2017 00:59:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d7alA-0007ze-5r
	for qemu-devel@nongnu.org; Mon, 08 May 2017 00:59:04 -0400
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:35401)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d7alA-0007zY-1i
	for qemu-devel@nongnu.org; Mon, 08 May 2017 00:59:00 -0400
Received: by mail-qk0-x241.google.com with SMTP id k74so8663906qke.2
	for <qemu-devel@nongnu.org>; Sun, 07 May 2017 21:58:59 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon,  8 May 2017 01:57:09 -0300
Message-Id: <20170508045715.21770-18-f4bug@amsat.org>
In-Reply-To: <20170508045715.21770-1-f4bug@amsat.org>
References: <20170508045715.21770-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 17/23] shippable: use dtc submodule if distrib
 packages are too old
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, Aurelien Jarno <aurel32@debian.org>, Riku Voipio <riku.voipio@iki.fi>, Vagrant Cascadian <vagrant@debian.org>, Michael Tokarev <mjt@tls.msk.ru>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

shippable output:
----------------
  LINK    mips64el-softmmu/qemu-system-mips64el
../hw/core/loader-fit.o: In function `load_fit':
/root/src/github.com/philmd/qemu/hw/core/loader-fit.c:278: undefined reference to `fdt_first_subnode'
/root/src/github.com/philmd/qemu/hw/core/loader-fit.c:286: undefined reference to `fdt_next_subnode'
/root/src/github.com/philmd/qemu/hw/core/loader-fit.c:277: undefined reference to `fdt_first_subnode'
collect2: error: ld returned 1 exit status
Makefile:201: recipe for target 'qemu-system-mips64el' failed
make[1]: *** [qemu-system-mips64el] Error 1
Makefile:327: recipe for target 'subdir-mips64el-softmmu' failed
make: *** [subdir-mips64el-softmmu] Error 2

having this too old libfdt version (required version >= 1.4.2):
 # dpkg-query --showformat='${Version}\n' --show libfdt-dev
1.4.0+dfsg-1

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 .shippable.yml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/.shippable.yml b/.shippable.yml
index b3cbca458c..6601243060 100644
--- a/.shippable.yml
+++ b/.shippable.yml
@@ -27,5 +27,13 @@ build:
     options: "-e HOME=/root"
   ci:
     - unset CC
+    # some targets require newer up to date packages, for example TARGET_LIST matching
+    # aarch64*-softmmu|arm*-softmmu|ppc*-softmmu|microblaze*-softmmu|mips64el-softmmu)
+    # see the configure script:
+    #    error_exit "DTC (libfdt) version >= 1.4.2 not present. Your options:"
+    #    "  (1) Preferred: Install the DTC (libfdt) devel package"
+    #    "  (2) Fetch the DTC submodule, using:"
+    #    "      git submodule update --init dtc"
+    - dpkg --compare-versions `dpkg-query --showformat='${Version}' --show libfdt-dev` ge 1.4.2 || git submodule update --init dtc
     - ./configure ${QEMU_CONFIGURE_OPTS} --target-list=${TARGET_LIST}
     - make -j$(getconf _NPROCESSORS_ONLN)
-- 
2.11.0
