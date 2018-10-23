Received: from eggs.gnu.org ([2001:4830:134:3::10]:42809)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tgolembi@redhat.com>) id 1gEumk-0001qq-JO
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 07:23:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tgolembi@redhat.com>) id 1gEumf-0007hn-WC
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 07:23:42 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42306)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tgolembi@redhat.com>) id 1gEumc-0007ah-8E
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 07:23:36 -0400
Received: by mail-wr1-f67.google.com with SMTP id a9so1256765wrx.9
	for <qemu-devel@nongnu.org>; Tue, 23 Oct 2018 04:23:32 -0700 (PDT)
From: =?UTF-8?q?Tom=C3=A1=C5=A1=20Golembiovsk=C3=BD?= <tgolembi@redhat.com>
Date: Tue, 23 Oct 2018 13:23:13 +0200
Message-Id: <0480ec44dcd79afecf5903a1c0f5ac2092732d9a.1540293795.git.tgolembi@redhat.com>
In-Reply-To: <cover.1540293795.git.tgolembi@redhat.com>
References: <cover.1540293795.git.tgolembi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v5 04/14] qga-win: prevent crash when executing
 fsinfo command
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

From: Sameeh Jubran <sjubran@redhat.com>

The fsinfo command is currently implemented for Windows only and it's disk
parameter can be enabled by adding the define "CONFIG_QGA_NTDDSCSI" to the qga
code. When enabled and executed the qemu-ga crashed with the following message:

------------------------------------------------
File qapi/qapi-visit-core.c, Line 49

Expression: !(v->type & VISITOR_OUTPUT) || *obj)
------------------------------------------------

After some digging, turns out that the GuestPCIAddress is null and the
qapi visitor doesn't like that, so we can always allocate it instead and
initiate all it's members to -1.

Signed-off-by: Sameeh Jubran <sjubran@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>

(cherry picked from commit ecb8293d90eafde5b0423ef90aacfeff718ed913)

Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>

Signed-off-by: Tomáš Golembiovský <tgolembi@redhat.com>
---
 qga/commands-win32.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index 98d9735389..8289e7d6ea 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -485,6 +485,11 @@ static GuestPCIAddress *get_pci_info(char *guid, Error **errp)
     char *buffer = NULL;
     GuestPCIAddress *pci = NULL;
     char *name = g_strdup(&guid[4]);
+    pci = g_malloc0(sizeof(*pci));
+    pci->domain = -1;
+    pci->slot = -1;
+    pci->function = -1;
+    pci->bus = -1;
 
     if (!QueryDosDevice(name, dev_name, ARRAY_SIZE(dev_name))) {
         error_setg_win32(errp, GetLastError(), "failed to get dos device name");
@@ -556,7 +561,6 @@ static GuestPCIAddress *get_pci_info(char *guid, Error **errp)
 
         func = addr & 0x0000FFFF;
         dev = (addr >> 16) & 0x0000FFFF;
-        pci = g_malloc0(sizeof(*pci));
         pci->domain = dev;
         pci->slot = slot;
         pci->function = func;
-- 
2.19.0
