Received: from eggs.gnu.org ([2001:4830:134:3::10]:36069)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gZGNT-0001Ak-Pq
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 09:29:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gZGNO-00018b-WF
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 09:29:43 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Tue, 18 Dec 2018 15:28:51 +0100
Message-Id: <20181218142851.9477-5-laurent@vivier.eu>
In-Reply-To: <20181218142851.9477-1-laurent@vivier.eu>
References: <20181218142851.9477-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 4/4] error: Remove NULL checks on
 error_propagate() calls
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Halil Pasic <pasic@linux.ibm.com>, Laurent Vivier <laurent@vivier.eu>, qemu-block@nongnu.org, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Michael Tokarev <mjt@tls.msk.ru>, Richard Henderson <rth@twiddle.net>, Paolo Bonzini <pbonzini@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Eduardo Habkost <ehabkost@redhat.com>, qemu-s390x@nongnu.org, Collin Walling <walling@linux.ibm.com>, Markus Armbruster <armbru@redhat.com>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, David Hildenbrand <david@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-trivial@nongnu.org

From: Markus Armbruster <armbru@redhat.com>

Patch created mechanically by rerunning:

  $  spatch --sp-file scripts/coccinelle/error_propagate_null.cocci \
            --macro-file scripts/cocci-macro-file.h \
            --dir . --in-place

Whitespace tidied up manually.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20181213173113.11211-1-armbru@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 blockdev.c              | 4 +---
 hw/s390x/s390-pci-bus.c | 4 +---
 qga/commands-posix.c    | 7 ++-----
 3 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/blockdev.c b/blockdev.c
index e6c8349409..a6f71f9d83 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -992,9 +992,7 @@ DriveInfo *drive_new(QemuOpts *all_opts, BlockInterfaceType block_default_type,
     blk = blockdev_init(filename, bs_opts, &local_err);
     bs_opts = NULL;
     if (!blk) {
-        if (local_err) {
-            error_propagate(errp, local_err);
-        }
+        error_propagate(errp, local_err);
         goto fail;
     } else {
         assert(!local_err);
diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index 99d0368868..f7458445c0 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -731,9 +731,7 @@ static void s390_pcihost_realize(DeviceState *dev, Error **errp)
 
     css_register_io_adapters(CSS_IO_ADAPTER_PCI, true, false,
                              S390_ADAPTER_SUPPRESSIBLE, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
-    }
+    error_propagate(errp, local_err);
 }
 
 static int s390_pci_msix_init(S390PCIBusDevice *pbdev)
diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index 1877976522..2e719d9b6b 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -1573,10 +1573,7 @@ static bool systemd_supports_mode(SuspendMode mode, Error **errp)
         return true;
     }
 
-    if (local_err) {
-        error_propagate(errp, local_err);
-    }
-
+    error_propagate(errp, local_err);
     return false;
 }
 
@@ -1782,7 +1779,7 @@ static void guest_suspend(SuspendMode mode, Error **errp)
     if (!mode_supported) {
         error_setg(errp,
                    "the requested suspend mode is not supported by the guest");
-    } else if (local_err) {
+    } else {
         error_propagate(errp, local_err);
     }
 }
-- 
2.19.2
