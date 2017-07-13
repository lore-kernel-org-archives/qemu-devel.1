Received: from eggs.gnu.org ([2001:4830:134:3::10]:55911)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dVaz0-0006El-BK
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 06:04:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dVayw-0005ZA-1H
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 06:04:30 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:36256)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dVayv-0005Yn-Sg
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 06:04:25 -0400
Received: by mail-qk0-f196.google.com with SMTP id v17so5133127qka.3
	for <qemu-devel@nongnu.org>; Thu, 13 Jul 2017 03:04:25 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 13 Jul 2017 07:03:10 -0300
Message-Id: <20170713100311.20037-2-f4bug@amsat.org>
In-Reply-To: <20170713100311.20037-1-f4bug@amsat.org>
References: <20170713100311.20037-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH RESEND 1/2] scripts: helper to keep console
 alive
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

useful to avoid Travis CI jobs getting killed after 10min of inactivity.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 MAINTAINERS          |  1 +
 scripts/aliveness.sh | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+)
 create mode 100755 scripts/aliveness.sh

diff --git a/MAINTAINERS b/MAINTAINERS
index 9529c9484c..c39f418a13 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1866,6 +1866,7 @@ S: Maintained
 F: .travis.yml
 F: .shippable.yml
 F: tests/docker/
+F: scripts/aliveness.sh
 W: https://travis-ci.org/qemu/qemu
 W: https://app.shippable.com/github/qemu/qemu
 W: http://patchew.org/QEMU/
diff --git a/scripts/aliveness.sh b/scripts/aliveness.sh
new file mode 100755
index 0000000000..1c2b6136b9
--- /dev/null
+++ b/scripts/aliveness.sh
@@ -0,0 +1,32 @@
+#! /usr/bin/env sh
+#
+# Send an "Alive!" message regularly to stderr
+#
+# Copyright (C) 2017 Philippe Mathieu-Daudé
+#
+# Author: Philippe Mathieu-Daudé <f4bug@amsat.org>
+#
+# This work is licensed under the terms of the GNU LGPL, version 2+.
+# See the COPYING file in the top-level directory.
+
+TIMEOUT_S=$1
+shift 1
+{
+  set -e
+  while true
+  do
+    sleep ${TIMEOUT_S}
+    echo "Alive!" >&2
+  done
+} &
+WATCHDOG_PID=$!
+
+cleanup() {
+    echo "killing watchdog ${WATCHDOG_PID}" >&2
+    kill -TERM ${WATCHDOG_PID}
+    exit $((1 - $#))
+}
+trap cleanup INT
+
+$*
+cleanup 0
-- 
2.13.2
