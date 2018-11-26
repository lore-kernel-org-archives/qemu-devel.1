Received: from eggs.gnu.org ([2001:4830:134:3::10]:45269)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gRMkS-00084e-Db
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 14:40:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gRMkR-0004ca-Bh
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 14:40:48 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:41072)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gRMkR-0004Z9-5H
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 14:40:47 -0500
Received: by mail-wr1-x42f.google.com with SMTP id x10so20232379wrs.8
	for <qemu-devel@nongnu.org>; Mon, 26 Nov 2018 11:40:47 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 26 Nov 2018 20:40:26 +0100
Message-Id: <1543261235-2834-7-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1543261235-2834-1-git-send-email-pbonzini@redhat.com>
References: <1543261235-2834-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 06/15] vl: Improve error message when we can't
 load fw_cfg from file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Li Qiang <liq3ea@gmail.com>

From: Li Qiang <liq3ea@gmail.com>

parse_fw_cfg() reports "can't load" without further details.  Get
the details from g_file_get_contents(), and include them in the
error message.

Signed-off-by: Li Qiang <liq3ea@gmail.com>
Message-Id: <1541051971-28584-1-git-send-email-liq3ea@gmail.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 vl.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/vl.c b/vl.c
index fa25d1a..32ab6e6 100644
--- a/vl.c
+++ b/vl.c
@@ -2244,8 +2244,10 @@ static int parse_fw_cfg(void *opaque, QemuOpts *opts, Error **errp)
         size = strlen(str); /* NUL terminator NOT included in fw_cfg blob */
         buf = g_memdup(str, size);
     } else {
-        if (!g_file_get_contents(file, &buf, &size, NULL)) {
-            error_setg(errp, "can't load %s", file);
+        GError *err = NULL;
+        if (!g_file_get_contents(file, &buf, &size, &err)) {
+            error_setg(errp, "can't load %s: %s", file, err->message);
+            g_error_free(err);
             return -1;
         }
     }
-- 
1.8.3.1
