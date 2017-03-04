Received: from eggs.gnu.org ([2001:4830:134:3::10]:57765)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ckEr3-0005yp-Pt
	for qemu-devel@nongnu.org; Sat, 04 Mar 2017 13:56:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ckEr3-0007eS-10
	for qemu-devel@nongnu.org; Sat, 04 Mar 2017 13:56:33 -0500
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:32918)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ckEr2-0007eE-T4
	for qemu-devel@nongnu.org; Sat, 04 Mar 2017 13:56:32 -0500
Received: by mail-qk0-x242.google.com with SMTP id j127so16933004qke.0
	for <qemu-devel@nongnu.org>; Sat, 04 Mar 2017 10:56:32 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Sat,  4 Mar 2017 15:55:33 -0300
Message-Id: <20170304185533.10618-4-f4bug@amsat.org>
In-Reply-To: <20170304185533.10618-1-f4bug@amsat.org>
References: <20170304185533.10618-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 3/3] qga: fix compiler warnings (clang 5)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Roth <mdroth@linux.vnet.ibm.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Alexander Graf <agraf@suse.de>, Gerd Hoffmann <kraxel@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

static code analyzer complain:

qga/commands-posix.c:2127:9: warning: Null pointer passed as an argument to a 'nonnull' parameter
        closedir(dp);
        ^~~~~~~~~~~~

Reported-by: Clang Static Analyzer
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 qga/commands-posix.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index ea37c097cf..9c4ef2d640 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -2119,9 +2119,11 @@ static void transfer_memory_block(GuestMemoryBlock *mem_blk, bool sys2memblk,
          * we think this VM does not support online/offline memory block,
          * any other solution?
          */
-        if (!dp && errno == ENOENT) {
-            result->response =
-                GUEST_MEMORY_BLOCK_RESPONSE_TYPE_OPERATION_NOT_SUPPORTED;
+        if (!dp) {
+            if (errno == ENOENT) {
+                result->response =
+                    GUEST_MEMORY_BLOCK_RESPONSE_TYPE_OPERATION_NOT_SUPPORTED;
+            }
             goto out1;
         }
         closedir(dp);
-- 
2.11.0
