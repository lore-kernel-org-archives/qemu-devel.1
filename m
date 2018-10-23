Received: from eggs.gnu.org ([2001:4830:134:3::10]:42807)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tgolembi@redhat.com>) id 1gEumk-0001qo-JF
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 07:23:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tgolembi@redhat.com>) id 1gEumg-0007iP-6W
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 07:23:42 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36636)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tgolembi@redhat.com>) id 1gEumf-0007dP-HL
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 07:23:38 -0400
Received: by mail-wr1-f68.google.com with SMTP id y16so1273816wrw.3
	for <qemu-devel@nongnu.org>; Tue, 23 Oct 2018 04:23:34 -0700 (PDT)
From: =?UTF-8?q?Tom=C3=A1=C5=A1=20Golembiovsk=C3=BD?= <tgolembi@redhat.com>
Date: Tue, 23 Oct 2018 13:23:15 +0200
Message-Id: <549ee1b2bd426c958e09aff0cec73443880c1348.1540293795.git.tgolembi@redhat.com>
In-Reply-To: <cover.1540293795.git.tgolembi@redhat.com>
References: <cover.1540293795.git.tgolembi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v5 06/14] *additonal fixup for NULL
 pci_controller field
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

From: Michael Roth <mdroth@linux.vnet.ibm.com>

(cherry picked from commit 51fe925a7b473c76e06b60ddb8a862c91901b290)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
Signed-off-by: Tomáš Golembiovský <tgolembi@redhat.com>
---
 qga/commands-win32.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index a8967abf06..44b6b1ce88 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -627,6 +627,10 @@ static GuestDiskAddressList *build_guest_disk_info(char *guid, Error **errp)
 
     disk = g_malloc0(sizeof(*disk));
     disk->bus_type = find_bus_type(bus);
+    /* always set pci_controller as required by schema. get_pci_info() should
+     * report -1 values for non-PCI buses rather than fail.
+     */
+    disk->pci_controller = get_pci_info(name, errp);
     if (bus == BusTypeScsi || bus == BusTypeAta || bus == BusTypeRAID
 #if (_WIN32_WINNT >= 0x0600)
             /* This bus type is not supported before Windows Server 2003 SP1 */
@@ -641,12 +645,9 @@ static GuestDiskAddressList *build_guest_disk_info(char *guid, Error **errp)
             disk->unit = addr.Lun;
             disk->target = addr.TargetId;
             disk->bus = addr.PathId;
-            disk->pci_controller = get_pci_info(name, errp);
         }
         /* We do not set error in this case, because we still have enough
          * information about volume. */
-    } else {
-         disk->pci_controller = NULL;
     }
 
     list = g_malloc0(sizeof(*list));
-- 
2.19.0
