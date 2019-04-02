Received: from eggs.gnu.org ([209.51.188.92]:49570)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hBLTm-0001eX-6y
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 11:37:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hBLTk-0000Vb-Mu
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 11:37:38 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Tue,  2 Apr 2019 18:37:21 +0300
Message-Id: <20190402153730.54145-2-vsementsov@virtuozzo.com>
In-Reply-To: <20190402153730.54145-1-vsementsov@virtuozzo.com>
References: <20190402153730.54145-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v5 01/10] tests/perf: Test qemu-img convert
 from raw to encrypted qcow2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, berto@igalia.com, pbonzini@redhat.com, vsementsov@virtuozzo.com, den@openvz.org, berrange@redhat.com

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 tests/perf/block/qcow2/convert-to-encrypted | 48 +++++++++++++++++++++
 1 file changed, 48 insertions(+)
 create mode 100755 tests/perf/block/qcow2/convert-to-encrypted

diff --git a/tests/perf/block/qcow2/convert-to-encrypted b/tests/perf/block/qcow2/convert-to-encrypted
new file mode 100755
index 0000000000..7a6b7b1cab
--- /dev/null
+++ b/tests/perf/block/qcow2/convert-to-encrypted
@@ -0,0 +1,48 @@
+#!/bin/bash
+#
+# Test qemu-img convert from raw to encrypted qcow2
+#
+# Copyright (c) 2019 Virtuozzo International GmbH. All rights reserved.
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 2 of the License, or
+# (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program.  If not, see <http://www.gnu.org/licenses/>.
+#
+
+if [ "$#" -lt 2 ]; then
+    echo "Usage: $0 SOURCE_FILE DESTINATION_FILE [additional qemu-img convert parameters]"
+    exit 1
+fi
+
+ROOT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/../../../.." >/dev/null 2>&1 && pwd )"
+QEMU_IMG="$ROOT_DIR/qemu-img"
+QEMU_IO="$ROOT_DIR/qemu-io"
+
+size=1G
+
+src="$1"
+shift
+
+dst="$1"
+shift
+
+(
+# create source
+$QEMU_IMG create -f raw "$src" $size
+$QEMU_IO -f raw -c "write -P 0xa 0 $size" "$src"
+
+# create target
+$QEMU_IMG create -f qcow2 --object secret,id=sec0,data=test -o encrypt.format=luks,encrypt.key-secret=sec0 "$dst" $size
+) > /dev/null
+
+# test with additional parameters left in $@
+/usr/bin/time -f %e $QEMU_IMG convert "$@" -f raw --object secret,id=sec0,data=test --target-image-opts -n "$src" "driver=qcow2,file.filename=$dst,encrypt.key-secret=sec0"
-- 
2.18.0
