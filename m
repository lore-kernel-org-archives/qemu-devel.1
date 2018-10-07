Received: from eggs.gnu.org ([2001:4830:134:3::10]:47112)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bishara@daynix.com>) id 1g96pc-00057Z-Fc
	for qemu-devel@nongnu.org; Sun, 07 Oct 2018 07:02:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bishara@daynix.com>) id 1g96pa-0007RB-Nj
	for qemu-devel@nongnu.org; Sun, 07 Oct 2018 07:02:39 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:43416)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bishara@daynix.com>) id 1g96pa-0007QO-Ct
	for qemu-devel@nongnu.org; Sun, 07 Oct 2018 07:02:38 -0400
Received: by mail-wr1-x42f.google.com with SMTP id n1-v6so17725722wrt.10
	for <qemu-devel@nongnu.org>; Sun, 07 Oct 2018 04:02:37 -0700 (PDT)
From: Bishara AbuHattoum <bishara@daynix.com>
Date: Sun,  7 Oct 2018 14:02:22 +0300
Message-Id: <20181007110223.129692-7-bishara@daynix.com>
In-Reply-To: <20181007110223.129692-1-bishara@daynix.com>
References: <20181007110223.129692-1-bishara@daynix.com>
Subject: [Qemu-devel] [PATCH v2 6/7] qga-win: report specific error when
 failing to open channel
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: Yan Vugenfirer <yan@daynix.com>, Sameeh Jubran <sameeh@daynix.com>

From: Michael Roth <mdroth@linux.vnet.ibm.com>

Useful in general, but especially now that errors might occur more
frequently with --retry-path set.

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
2.17.0
