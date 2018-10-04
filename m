Received: from eggs.gnu.org ([2001:4830:134:3::10]:34574)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tgolembi@redhat.com>) id 1g81tF-0003yi-Oc
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 07:34:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tgolembi@redhat.com>) id 1g81iZ-0003d3-NT
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 07:22:59 -0400
Received: from mail-wr1-f53.google.com ([209.85.221.53]:33690)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tgolembi@redhat.com>) id 1g81iZ-0003cT-GJ
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 07:22:55 -0400
Received: by mail-wr1-f53.google.com with SMTP id e4-v6so9519811wrs.0
	for <qemu-devel@nongnu.org>; Thu, 04 Oct 2018 04:22:55 -0700 (PDT)
From: =?UTF-8?q?Tom=C3=A1=C5=A1=20Golembiovsk=C3=BD?= <tgolembi@redhat.com>
Date: Thu,  4 Oct 2018 13:22:38 +0200
Message-Id: <b004cd17d0fa02ed169c5b101fdbbb7fa2b6b633.1538652143.git.tgolembi@redhat.com>
In-Reply-To: <cover.1538652143.git.tgolembi@redhat.com>
References: <cover.1538652143.git.tgolembi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 11/11] qga-win: demystify namespace striping
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Sameeh Jubran <sjubran@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Olga Krishtal <okrishtal@virtuozzo.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, =?UTF-8?q?Tom=C3=A1=C5=A1=20Golembiovsk=C3=BD?= <tgolembi@redhat.com>

It was not obvious what exactly the cryptic string copying does to the
GUID. This change makes the intent clearer.

Signed-off-by: Tomáš Golembiovský <tgolembi@redhat.com>
---
 qga/commands-win32.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index d0d969d0ce..82881aa749 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -507,7 +507,14 @@ static GuestPCIAddress *get_pci_info(char *guid, Error **errp)
     char dev_name[MAX_PATH];
     char *buffer = NULL;
     GuestPCIAddress *pci = NULL;
-    char *name = g_strdup(&guid[4]);
+    char *name = NULL;
+
+    if ((g_str_has_prefix(guid, "\\\\.\\") == TRUE) ||
+        (g_str_has_prefix(guid, "\\\\?\\") == TRUE)) {
+        name = g_strdup(&guid[4]);
+    } else {
+        name = g_strdup(guid);
+    }
 
     if (!QueryDosDevice(name, dev_name, ARRAY_SIZE(dev_name))) {
         error_setg_win32(errp, GetLastError(), "failed to get dos device name");
-- 
2.19.0
