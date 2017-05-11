Received: from eggs.gnu.org ([2001:4830:134:3::10]:36380)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d8pA5-0001k1-4W
	for qemu-devel@nongnu.org; Thu, 11 May 2017 10:33:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d8pA4-0006zn-3d
	for qemu-devel@nongnu.org; Thu, 11 May 2017 10:33:49 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Thu, 11 May 2017 16:32:18 +0200
Message-Id: <1494513181-7900-16-git-send-email-kwolf@redhat.com>
In-Reply-To: <1494513181-7900-1-git-send-email-kwolf@redhat.com>
References: <1494513181-7900-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 15/58] file-posix: Add 'locking' option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, stefanha@redhat.com, qemu-devel@nongnu.org

From: Fam Zheng <famz@redhat.com>

Making this option available even before implementing it will let
converting tests easier: in coming patches they can specify the option
already when necessary, before we actually write code to lock the
images.

Signed-off-by: Fam Zheng <famz@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/file-posix.c   | 5 +++++
 qapi/block-core.json | 4 ++++
 2 files changed, 9 insertions(+)

diff --git a/block/file-posix.c b/block/file-posix.c
index 19c48a0..d13e99c 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -392,6 +392,11 @@ static QemuOptsList raw_runtime_opts = {
             .type = QEMU_OPT_STRING,
             .help = "host AIO implementation (threads, native)",
         },
+        {
+            .name = "locking",
+            .type = QEMU_OPT_STRING,
+            .help = "file locking mode (on/off/auto, default: auto)",
+        },
         { /* end of list */ }
     },
 };
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 30d5952..52e3ecd 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -2127,11 +2127,15 @@
 #
 # @filename:    path to the image file
 # @aio:         AIO backend (default: threads) (since: 2.8)
+# @locking:     whether to enable file locking. If set to 'auto', only enable
+#               when Open File Descriptor (OFD) locking API is available
+#               (default: auto, since 2.10)
 #
 # Since: 2.9
 ##
 { 'struct': 'BlockdevOptionsFile',
   'data': { 'filename': 'str',
+            '*locking': 'OnOffAuto',
             '*aio': 'BlockdevAioOptions' } }
 
 ##
-- 
1.8.3.1
