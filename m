Received: from eggs.gnu.org ([2001:4830:134:3::10]:41639)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fGAtH-0003Hx-JQ
	for qemu-devel@nongnu.org; Tue, 08 May 2018 18:15:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fGAtG-0001cW-LO
	for qemu-devel@nongnu.org; Tue, 08 May 2018 18:15:23 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:36518)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fGAtG-0001c8-Dp
	for qemu-devel@nongnu.org; Tue, 08 May 2018 18:15:22 -0400
Received: by mail-wm0-x242.google.com with SMTP id n10-v6so24095714wmc.1
	for <qemu-devel@nongnu.org>; Tue, 08 May 2018 15:15:22 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed,  9 May 2018 00:14:44 +0200
Message-Id: <1525817687-34620-28-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1525817687-34620-1-git-send-email-pbonzini@redhat.com>
References: <1525817687-34620-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 27/30] shippable: Remove Debian 8 libfdt kludge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

This kludge was added in a825ca06137, but a cleaner and more generic
fix is now available (see ##COMMIT_CONFIGURE_LIBFDT_LDFLAGS_SHA##).

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20180415230522.24404-4-f4bug@amsat.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 .shippable.yml | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/.shippable.yml b/.shippable.yml
index 60f2ce9..f74a3de 100644
--- a/.shippable.yml
+++ b/.shippable.yml
@@ -35,13 +35,5 @@ build:
     options: "-e HOME=/root"
   ci:
     - unset CC
-    # some targets require newer up to date packages, for example TARGET_LIST matching
-    # aarch64*-softmmu|arm*-softmmu|ppc*-softmmu|microblaze*-softmmu|mips64el-softmmu)
-    # see the configure script:
-    #    error_exit "DTC (libfdt) version >= 1.4.2 not present. Your options:"
-    #    "  (1) Preferred: Install the DTC (libfdt) devel package"
-    #    "  (2) Fetch the DTC submodule, using:"
-    #    "      git submodule update --init dtc"
-    - dpkg --compare-versions `dpkg-query --showformat='${Version}' --show libfdt-dev` ge 1.4.2 || git submodule update --init dtc
     - ./configure ${QEMU_CONFIGURE_OPTS} --target-list=${TARGET_LIST}
     - make -j$(($(getconf _NPROCESSORS_ONLN) + 1))
-- 
1.8.3.1
