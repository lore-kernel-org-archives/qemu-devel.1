Received: from eggs.gnu.org ([2001:4830:134:3::10]:46459)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1gHVGa-0007wm-Q9
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 10:45:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1gHVGZ-0000om-Jw
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 10:45:12 -0400
Received: from mail-qt1-x82f.google.com ([2607:f8b0:4864:20::82f]:40703)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <flukshun@gmail.com>) id 1gHVGZ-0000nc-An
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 10:45:11 -0400
Received: by mail-qt1-x82f.google.com with SMTP id k12so7857772qtf.7
	for <qemu-devel@nongnu.org>; Tue, 30 Oct 2018 07:45:11 -0700 (PDT)
Sender: fluxion <flukshun@gmail.com>
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Tue, 30 Oct 2018 09:43:57 -0500
Message-Id: <20181030144358.23144-24-mdroth@linux.vnet.ibm.com>
In-Reply-To: <20181030144358.23144-1-mdroth@linux.vnet.ibm.com>
References: <20181030144358.23144-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 23/24] qga-win: report specific error when
 failing to open channel
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

Useful in general, but especially now that errors might occur more
frequently with --retry-path set.

Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 qga/channel-win32.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/qga/channel-win32.c b/qga/channel-win32.c
index b3597a8a0f..c86f4388db 100644
--- a/qga/channel-win32.c
+++ b/qga/channel-win32.c
@@ -302,7 +302,8 @@ static gboolean ga_channel_open(GAChannel *c, GAChannelMethod method,
                            OPEN_EXISTING,
                            FILE_FLAG_NO_BUFFERING | FILE_FLAG_OVERLAPPED, NULL);
     if (c->handle == INVALID_HANDLE_VALUE) {
-        g_critical("error opening path %s", newpath);
+        g_critical("error opening path %s: %s", newpath,
+                   g_win32_error_message(GetLastError()));
         return false;
     }
 
-- 
2.17.1
