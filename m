Received: from eggs.gnu.org ([2001:4830:134:3::10]:52255)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sameeh@daynix.com>) id 1fXpcK-0003lP-71
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 11:10:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sameeh@daynix.com>) id 1fXpcI-00089h-0N
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 11:10:52 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:34899)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sameeh@daynix.com>) id 1fXpcH-00089U-Pg
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 11:10:49 -0400
Received: by mail-wm0-x242.google.com with SMTP id z137-v6so2266299wmc.0
	for <qemu-devel@nongnu.org>; Tue, 26 Jun 2018 08:10:49 -0700 (PDT)
From: Sameeh Jubran <sameeh@daynix.com>
Date: Tue, 26 Jun 2018 18:10:37 +0300
Message-Id: <20180626151038.24771-2-sameeh@daynix.com>
In-Reply-To: <20180626151038.24771-1-sameeh@daynix.com>
References: <20180626151038.24771-1-sameeh@daynix.com>
Subject: [Qemu-devel] [PATCH 1/2] qga-win: prevent crash when executing
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
Cc: Yan Vugenfirer <yan@daynix.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

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
---
 qga/commands-win32.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index 2d48394748..c5f1c884e1 100644
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
2.13.6
