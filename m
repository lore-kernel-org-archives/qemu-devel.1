Received: from eggs.gnu.org ([2001:4830:134:3::10]:46622)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1gHVHI-0008W1-1d
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 10:45:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1gHVHC-0001gd-36
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 10:45:55 -0400
Received: from mail-qt1-x842.google.com ([2607:f8b0:4864:20::842]:37575)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <flukshun@gmail.com>) id 1gHVHB-0001Fy-S3
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 10:45:49 -0400
Received: by mail-qt1-x842.google.com with SMTP id d14-v6so13746559qto.4
	for <qemu-devel@nongnu.org>; Tue, 30 Oct 2018 07:45:30 -0700 (PDT)
Sender: fluxion <flukshun@gmail.com>
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Tue, 30 Oct 2018 09:43:41 -0500
Message-Id: <20181030144358.23144-8-mdroth@linux.vnet.ibm.com>
In-Reply-To: <20181030144358.23144-1-mdroth@linux.vnet.ibm.com>
References: <20181030144358.23144-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 07/24] qga-win: prevent crash when executing
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
Cc: peter.maydell@linaro.org, Sameeh Jubran <sjubran@redhat.com>, =?UTF-8?q?Tom=C3=A1=C5=A1=20Golembiovsk=C3=BD?= <tgolembi@redhat.com>

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
Signed-off-by: Tomáš Golembiovský <tgolembi@redhat.com>
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 qga/commands-win32.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index 347577f2a4..f0e6f6128b 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -499,6 +499,11 @@ static GuestPCIAddress *get_pci_info(char *guid, Error **errp)
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
@@ -570,7 +575,6 @@ static GuestPCIAddress *get_pci_info(char *guid, Error **errp)
 
         func = addr & 0x0000FFFF;
         dev = (addr >> 16) & 0x0000FFFF;
-        pci = g_malloc0(sizeof(*pci));
         pci->domain = dev;
         pci->slot = slot;
         pci->function = func;
-- 
2.17.1
