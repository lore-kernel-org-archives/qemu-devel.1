Received: from eggs.gnu.org ([2001:4830:134:3::10]:49671)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fwqTL-0007G8-7e
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 11:09:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fwqTH-0001No-A4
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 11:08:59 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49988 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fwqTH-0001Mw-3T
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 11:08:55 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Mon,  3 Sep 2018 17:08:46 +0200
Message-Id: <1535987326-16222-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH] Add a gitlab-ci file for Continuous
 Integration testing on Gitlab
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

This is very convenient for people who store their QEMU git trees on
gitlab.com: Automatic CI pipelines are now run for each branch that is
pushed to the server. Since the runtime of the jobs is limited to 1h
we distribute the targets into multiple pipelines - this way the jobs
finish within 30 minutes.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 In case somebody is interested, the result looks e.g. like this on gitlab:
 https://gitlab.com/huth/qemu/pipelines/29255979

 .gitlab-ci.yml | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)
 create mode 100644 .gitlab-ci.yml

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
new file mode 100644
index 0000000..18a77bc
--- /dev/null
+++ b/.gitlab-ci.yml
@@ -0,0 +1,48 @@
+before_script:
+ - apt-get update -qq
+ - apt-get install -y -qq flex bison libglib2.0-dev libpixman-1-dev
+
+build-system1:
+ script:
+ - apt-get install -y -qq libgtk-3-dev libvte-dev nettle-dev libcacard-dev
+      libusb-dev libvde-dev libspice-protocol-dev libgl1-mesa-dev
+ - ./configure --enable-werror --target-list="aarch64-softmmu alpha-softmmu
+      cris-softmmu hppa-softmmu lm32-softmmu moxie-softmmu microblazeel-softmmu
+      microblaze-softmmu mips-softmmu mips64el-softmmu m68k-softmmu ppc-softmmu"
+ - make -j2
+ - make -j2 check
+
+build-system2:
+ script:
+ - apt-get install -y -qq libsdl2-dev libgcrypt-dev libbrlapi-dev libaio-dev
+      libfdt-dev liblzo2-dev librdmacm-dev libibverbs-dev libibumad-dev
+ - ./configure --enable-werror --target-list="tricore-softmmu unicore32-softmmu
+      riscv32-softmmu riscv64-softmmu s390x-softmmu sh4-softmmu sparc-softmmu
+      sparc64-softmmu x86_64-softmmu xtensa-softmmu nios2-softmmu or1k-softmmu"
+ - make -j2
+ - make -j2 check
+
+build-clang:
+ script:
+ - apt-get install -y -qq clang libgtk-3-dev libsdl2-dev libbluetooth-dev
+      xfslibs-dev libiscsi-dev libnfs-dev libseccomp-dev gnutls-dev librbd-dev
+ - CC="clang" ./configure --enable-werror --target-list="tilegx-linux-user
+      arm-softmmu i386-softmmu ppc64-softmmu s390x-softmmu sparc-softmmu"
+ - make -j2
+ - make -j2 check
+
+build-disabled:
+ script:
+ - ./configure --enable-werror --disable-tcg --disable-slirp --disable-libxml2
+      --disable-capstone --disable-live-block-migration --disable-glusterfs
+      --disable-replication --disable-coroutine-pool --disable-smartcard
+      --disable-guest-agent --disable-curses --disable-curl --disable-tpm
+      --disable-qom-cast-debug --disable-spice --disable-vhost-vsock
+      --disable-vhost-net --disable-vhost-crypto --disable-vhost-user
+ - make -j2
+
+build-user:
+ script:
+ - ./configure --enable-werror --disable-system --disable-guest-agent
+ - make -j2
+ - make -j2 check
-- 
1.8.3.1
