Received: from eggs.gnu.org ([2001:4830:134:3::10]:36519)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d7qyz-0008GX-B4
	for qemu-devel@nongnu.org; Mon, 08 May 2017 18:18:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d7qyy-0006nk-CQ
	for qemu-devel@nongnu.org; Mon, 08 May 2017 18:18:21 -0400
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:33369)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d7qyy-0006n7-8K
	for qemu-devel@nongnu.org; Mon, 08 May 2017 18:18:20 -0400
Received: by mail-qk0-x244.google.com with SMTP id o85so12156086qkh.0
	for <qemu-devel@nongnu.org>; Mon, 08 May 2017 15:18:20 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon,  8 May 2017 19:17:41 -0300
Message-Id: <20170508221759.15616-4-f4bug@amsat.org>
In-Reply-To: <20170508221759.15616-1-f4bug@amsat.org>
References: <20170508221759.15616-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 03/21] docker: add 'apt-fake' script which
 generate fake debian packages
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

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 tests/docker/dockerfiles/debian-apt-fake.sh | 46 +++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)
 create mode 100755 tests/docker/dockerfiles/debian-apt-fake.sh

diff --git a/tests/docker/dockerfiles/debian-apt-fake.sh b/tests/docker/dockerfiles/debian-apt-fake.sh
new file mode 100755
index 0000000000..387522c174
--- /dev/null
+++ b/tests/docker/dockerfiles/debian-apt-fake.sh
@@ -0,0 +1,46 @@
+#! /bin/sh
+#
+# Generate fake debian package to resolve unimportant unmet dependencies held
+# by upstream multiarch broken packages.
+#
+# Copyright (c) 2017 Philippe Mathieu-Daudé <f4bug@amsat.org>
+#
+# This work is licensed under the terms of the GNU GPL, version 2
+# or (at your option) any later version. See the COPYING file in
+# the top-level directory.
+
+test $1 = "install" && shift 1
+
+fake_install()
+{
+    echo "Generating fake $2 $1 $3 ..."
+    (cd /var/cache/apt/archives
+        (cat << 'EOF'
+Section: misc
+Priority: optional
+Standards-Version: 3.9.2
+
+Package: NAME
+Version: VERSION
+Maintainer: qemu-devel@nongnu.org
+Architecture: any
+Multi-Arch: same
+Description: fake NAME
+EOF
+        ) | sed s/NAME/$2/g | sed s/VERSION/$3/g > $2.control
+        equivs-build -a $1 $2.control 1>/dev/null 2>/dev/null
+        dpkg -i $2_$3_$1.deb
+    )
+}
+
+try_install()
+{
+    name=$(echo $1|sed "s/\(.*\):\(.*\)=\(.*\)/\1/")
+    arch=$(echo $1|sed "s/\(.*\):\(.*\)=\(.*\)/\2/")
+    vers=$(echo $1|sed "s/\(.*\):\(.*\)=\(.*\)/\3/")
+    apt-get install -q -yy $1 || fake_install $arch $name $vers
+}
+
+for package in $*; do
+    try_install $package
+done
-- 
2.11.0
