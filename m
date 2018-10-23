Received: from eggs.gnu.org ([2001:4830:134:3::10]:42924)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tgolembi@redhat.com>) id 1gEumr-0001yi-RQ
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 07:23:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tgolembi@redhat.com>) id 1gEumm-0007qN-TY
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 07:23:49 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37850)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tgolembi@redhat.com>) id 1gEumm-0007pO-M4
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 07:23:44 -0400
Received: by mail-wm1-f68.google.com with SMTP id x19-v6so1365265wmc.2
	for <qemu-devel@nongnu.org>; Tue, 23 Oct 2018 04:23:44 -0700 (PDT)
From: =?UTF-8?q?Tom=C3=A1=C5=A1=20Golembiovsk=C3=BD?= <tgolembi@redhat.com>
Date: Tue, 23 Oct 2018 13:23:23 +0200
Message-Id: <f41ccdea9e33e09fc014b1db8111b45d15592a85.1540293796.git.tgolembi@redhat.com>
In-Reply-To: <cover.1540293795.git.tgolembi@redhat.com>
References: <cover.1540293795.git.tgolembi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v5 14/14] qga-win: demystify namespace stripping
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
 qga/commands-win32.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index 12aba8cc50..779c8ce1fa 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -507,13 +507,21 @@ static GuestPCIAddress *get_pci_info(char *guid, Error **errp)
     char dev_name[MAX_PATH];
     char *buffer = NULL;
     GuestPCIAddress *pci = NULL;
-    char *name = g_strdup(&guid[4]);
+    char *name = NULL;
+
     pci = g_malloc0(sizeof(*pci));
     pci->domain = -1;
     pci->slot = -1;
     pci->function = -1;
     pci->bus = -1;
 
+    if (g_str_has_prefix(guid, "\\\\.\\") ||
+        g_str_has_prefix(guid, "\\\\?\\")) {
+        name = g_strdup(guid + 4);
+    } else {
+        name = g_strdup(guid);
+    }
+
     if (!QueryDosDevice(name, dev_name, ARRAY_SIZE(dev_name))) {
         error_setg_win32(errp, GetLastError(), "failed to get dos device name");
         goto out;
-- 
2.19.0
