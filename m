Received: from eggs.gnu.org ([2001:4830:134:3::10]:35061)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1gI61A-0000Cz-C5
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 01:59:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1gI617-00040w-72
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 01:59:44 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:35662)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1gI616-0003z6-W6
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 01:59:41 -0400
Received: by mail-pf1-x441.google.com with SMTP id z2-v6so6202350pfe.2
	for <qemu-devel@nongnu.org>; Wed, 31 Oct 2018 22:59:39 -0700 (PDT)
From: Li Qiang <liq3ea@gmail.com>
Date: Wed, 31 Oct 2018 22:59:31 -0700
Message-Id: <1541051971-28584-1-git-send-email-liq3ea@gmail.com>
Subject: [Qemu-devel] [PATCH] vl: Improve error message when we can't load
 fw_cfg from file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, armbru@redhat.com, philmd@redhat.com
Cc: qemu-devel@nongnu.org, Li Qiang <liq3ea@gmail.com>

parse_fw_cfg() reports "can't load" without further details.  Get
the details from g_file_get_contents(), and include them in the
error message.

Signed-off-by: Li Qiang <liq3ea@gmail.com>
---
 vl.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/vl.c b/vl.c
index 1fcacc5..f0bd899 100644
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
