Received: from eggs.gnu.org ([2001:4830:134:3::10]:60360)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1gHfUu-0000YP-DT
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 21:40:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1gHfUt-0002IS-EW
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 21:40:40 -0400
Received: from mail-qt1-x82b.google.com ([2607:f8b0:4864:20::82b]:43411)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <flukshun@gmail.com>) id 1gHfUt-00028B-5h
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 21:40:39 -0400
Received: by mail-qt1-x82b.google.com with SMTP id q41-v6so15954314qtq.10
	for <qemu-devel@nongnu.org>; Tue, 30 Oct 2018 18:40:23 -0700 (PDT)
Sender: fluxion <flukshun@gmail.com>
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Tue, 30 Oct 2018 20:38:13 -0500
Message-Id: <20181031013821.24023-17-mdroth@linux.vnet.ibm.com>
In-Reply-To: <20181031013821.24023-1-mdroth@linux.vnet.ibm.com>
References: <20181031013821.24023-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL v2 16/24] qga-win: demystify namespace stripping
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, =?UTF-8?q?Tom=C3=A1=C5=A1=20Golembiovsk=C3=BD?= <tgolembi@redhat.com>

From: Tomáš Golembiovský <tgolembi@redhat.com>

It was not obvious what exactly the cryptic string copying does to the
GUID. This change makes the intent clearer.

Signed-off-by: Tomáš Golembiovský <tgolembi@redhat.com>
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 qga/commands-win32.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index 30d6c639c3..a1b7512d46 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -521,7 +521,7 @@ static GuestPCIAddress *get_pci_info(char *guid, Error **errp)
     char dev_name[MAX_PATH];
     char *buffer = NULL;
     GuestPCIAddress *pci = NULL;
-    char *name = g_strdup(&guid[4]);
+    char *name = NULL;
     bool partial_pci = false;
     pci = g_malloc0(sizeof(*pci));
     pci->domain = -1;
@@ -529,6 +529,13 @@ static GuestPCIAddress *get_pci_info(char *guid, Error **errp)
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
2.17.1
