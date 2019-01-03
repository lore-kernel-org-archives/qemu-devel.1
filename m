Received: from eggs.gnu.org ([208.118.235.92]:34407)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <basil@daynix.com>) id 1gf22C-0005FV-Eq
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 07:23:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <basil@daynix.com>) id 1gf229-0004Cd-9d
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 07:23:36 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:40604)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <basil@daynix.com>) id 1gf228-0004Bi-S8
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 07:23:33 -0500
Received: by mail-wm1-x343.google.com with SMTP id f188so30104076wmf.5
	for <qemu-devel@nongnu.org>; Thu, 03 Jan 2019 04:23:32 -0800 (PST)
From: Basil Salman <basil@daynix.com>
Date: Thu,  3 Jan 2019 14:23:21 +0200
Message-Id: <20190103122323.1273034-3-basil@daynix.com>
In-Reply-To: <20190103122323.1273034-1-basil@daynix.com>
References: <20190103122323.1273034-1-basil@daynix.com>
Subject: [Qemu-devel] [PATCH 2/4] qga: fix send_response error handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: Yan Vugenfirer <yan@daynix.com>, Bishara AbuHattoum <bishara@daynix.com>

Sometimes qemu-ga fails to send a response to client due to memory allocation
issues due to a large response message, this can be experienced while trying
to read large number of bytes using QMP command guest-file-read.

Added a check to send an error response to qemu-ga client in such cases.

Signed-off-by: Basil Salman <basil@daynix.com>
---
 qga/main.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/qga/main.c b/qga/main.c
index 87a0711c14..964275c40c 100644
--- a/qga/main.c
+++ b/qga/main.c
@@ -561,6 +561,8 @@ static void process_command(GAState *s, QDict *req)
 {
     QDict *rsp;
     int ret;
+    QDict *ersp;
+    Error *err = NULL;
 
     g_assert(req);
     g_debug("processing command");
@@ -569,9 +571,20 @@ static void process_command(GAState *s, QDict *req)
         ret = send_response(s, rsp);
         if (ret < 0) {
             g_warning("error sending response: %s", strerror(-ret));
+            goto err;
         }
         qobject_unref(rsp);
     }
+    return;
+err:
+    error_setg(&err, "Insufficient system resources exist to "
+                      "complete the requested service");
+    ersp = qmp_error_response(err);
+    ret = send_response(s, ersp);
+    if (ret < 0) {
+        g_warning("error sending error response: %s", strerror(-ret));
+    }
+    qobject_unref(ersp);
 }
 
 /* handle requests/control events coming in over the channel */
-- 
2.17.2
