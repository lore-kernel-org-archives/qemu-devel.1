Received: from eggs.gnu.org ([2001:4830:134:3::10]:60763)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d5ann-0004O9-Lz
	for qemu-devel@nongnu.org; Tue, 02 May 2017 12:37:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d5anm-0000kh-RP
	for qemu-devel@nongnu.org; Tue, 02 May 2017 12:37:27 -0400
From: Fam Zheng <famz@redhat.com>
Date: Wed,  3 May 2017 00:35:50 +0800
Message-Id: <20170502163558.7611-16-famz@redhat.com>
In-Reply-To: <20170502163558.7611-1-famz@redhat.com>
References: <20170502163558.7611-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v17 15/23] file-posix: Add 'locking' option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, famz@redhat.com, Max Reitz <mreitz@redhat.com>, eblake@redhat.com

Making this option available even before implementing it will let
converting tests easier: in coming patches they can specify the option
already when necessary, before we actually write code to lock the
images.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 block/file-posix.c   | 5 +++++
 qapi/block-core.json | 4 ++++
 2 files changed, 9 insertions(+)

diff --git a/block/file-posix.c b/block/file-posix.c
index 1941fb6..261563d 100644
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
index 1cf29a1..29d3040 100644
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
2.9.3
