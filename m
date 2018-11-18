Received: from eggs.gnu.org ([2001:4830:134:3::10]:36428)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gOTl2-0005Qx-6x
	for qemu-devel@nongnu.org; Sun, 18 Nov 2018 15:33:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gOTl1-0000gi-Dn
	for qemu-devel@nongnu.org; Sun, 18 Nov 2018 15:33:28 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435]:42467)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gOTl1-0000gH-80
	for qemu-devel@nongnu.org; Sun, 18 Nov 2018 15:33:27 -0500
Received: by mail-wr1-x435.google.com with SMTP id u5-v6so24579694wrn.9
	for <qemu-devel@nongnu.org>; Sun, 18 Nov 2018 12:33:27 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Sun, 18 Nov 2018 21:33:12 +0100
Message-Id: <20181118203312.5376-3-f4bug@amsat.org>
In-Reply-To: <20181118203312.5376-1-f4bug@amsat.org>
References: <20181118203312.5376-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH 2/2] shippable: Add the mipsr5900el
 linux-user target
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fredrik Noring <noring@nocrew.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Mike Frysinger <vapier@gentoo.org>

Shippable node pool must be updated to use at lease v5.8.2:

  http://docs.shippable.com/platform/runtime/machine-image/ami-v582/

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 .shippable.yml                                           | 2 ++
 tests/docker/dockerfiles/gentoo-mipsr5900el-cross.docker | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/.shippable.yml b/.shippable.yml
index f74a3de3ff..bd3316df91 100644
--- a/.shippable.yml
+++ b/.shippable.yml
@@ -25,6 +25,8 @@ env:
       TARGET_LIST=mips64el-softmmu,mips64el-linux-user
     - IMAGE=debian-ppc64el-cross
       TARGET_LIST=ppc64-softmmu,ppc64-linux-user,ppc64abi32-linux-user
+    - IMAGE=gentoo-mipsr5900el-cross
+      TARGET_LIST=mips64el-linux-user
 build:
   pre_ci:
     - make docker-image-${IMAGE} V=1
diff --git a/tests/docker/dockerfiles/gentoo-mipsr5900el-cross.docker b/tests/docker/dockerfiles/gentoo-mipsr5900el-cross.docker
index dbc2eb007b..b35f779718 100644
--- a/tests/docker/dockerfiles/gentoo-mipsr5900el-cross.docker
+++ b/tests/docker/dockerfiles/gentoo-mipsr5900el-cross.docker
@@ -37,3 +37,8 @@ ADD gcc-v7.2.0-ps2-llsc.patch /etc/portage/patches/cross-mipsr5900el-unknown-lin
 RUN crossdev -s3 -t mipsr5900el-unknown-linux-gnu --binutils ">=2.30" --gcc ">=7.2.0"
 
 ENV QEMU_CONFIGURE_OPTS --cross-prefix=mipsr5900el-unknown-linux-gnu-
+
+# kludge for Shippable which checks clang available.
+RUN ln -s /bin/true /usr/bin/clang
+
+RUN emerge -qv dev-vcs/git ">=dev-libs/glib-2.0" sys-libs/zlib dev-lang/python
-- 
2.17.2
