Received: from eggs.gnu.org ([2001:4830:134:3::10]:50948)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dZi76-0001SG-Ca
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 14:29:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dZi75-000662-KC
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 14:29:52 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 24 Jul 2017 15:27:51 -0300
Message-Id: <20170724182751.18261-36-f4bug@amsat.org>
In-Reply-To: <20170724182751.18261-1-f4bug@amsat.org>
References: <20170724182751.18261-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH for 2.10 35/35] script to run docker image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 scripts/dockershell | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)
 create mode 100755 scripts/dockershell

diff --git a/scripts/dockershell b/scripts/dockershell
new file mode 100755
index 0000000000..f6a2276172
--- /dev/null
+++ b/scripts/dockershell
@@ -0,0 +1,30 @@
+#! /bin/sh
+
+# This script starts a docker shell with QEMU directory mounted
+#
+# Copyright (C) 2017 Philippe Mathieu-Daudé. GPLv2+.
+#
+# Usage:
+# ./scripts/dockershell qemu:debian-bleeding-dev
+
+if [ $# -lt 1 ]; then
+    echo
+    echo "error: missing image name"
+    echo
+    docker images qemu --no-trunc --format="- {{.Repository}}:{{.Tag}}"
+    exit 1
+fi
+
+SDIR=$(cd "$(dirname "$0")/.." && pwd -P)
+CDIR=$(pwd -P)
+
+VOLS="-v /tmp:/tmp"
+if [ "${SDIR}" = "${CDIR}" ]; then
+    VOLS="${VOLS} -v ${SDIR}:${SDIR} -w ${SDIR}"
+else
+    VOLS="${VOLS} -v ${SDIR}:${SDIR}:ro -v ${CDIR}:${CDIR} -w ${CDIR}"
+fi
+
+docker run --rm -it ${VOLS} \
+    -u $(id -u) \
+    $1
-- 
2.13.3
