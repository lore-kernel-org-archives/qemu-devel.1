Received: from eggs.gnu.org ([209.51.188.92]:51523)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gtYhv-00025L-RE
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 09:06:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gtYhu-0006u0-BD
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 09:06:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35870)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gtYht-0006s3-TD
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 09:06:42 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Tue, 12 Feb 2019 15:06:19 +0100
Message-Id: <20190212140621.17009-2-philmd@redhat.com>
In-Reply-To: <20190212140621.17009-1-philmd@redhat.com>
References: <20190212140621.17009-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 1/3] Revert "contrib/vhost-user-blk: fix the
 compilation issue"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: Changpeng Liu <changpeng.liu@intel.com>, Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, "open list:X86" <kvm@vger.kernel.org>

Commit a56de056c91f8 squashed the following two unrelated commits
at once:

- "contrib/vhost-user-blk: fix the compilation issue"
  (Message-Id: 1547615970-23545-2-git-send-email-changpeng.liu@intel.com)
- "i386/kvm: ignore masked irqs when update msi routes"
  (Message-Id: 20190116030815.27273-5-peterx@redhat.com)

While the git history remains bisectable, having a commit that changes
MSI/MSIX code but describes it as "fix vhost-user-blk compilation" is
rather confusing.
Revert the offending commit to properly apply both patches separately.

Reported-by: Peter Xu <peterx@redhat.com>
Fixes: a56de056c91f8
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 contrib/vhost-user-blk/vhost-user-blk.c |  6 +-----
 target/i386/kvm.c                       | 14 +++-----------
 2 files changed, 4 insertions(+), 16 deletions(-)

diff --git a/contrib/vhost-user-blk/vhost-user-blk.c b/contrib/vhost-user=
-blk/vhost-user-blk.c
index 43583f2659..5c2092e13a 100644
--- a/contrib/vhost-user-blk/vhost-user-blk.c
+++ b/contrib/vhost-user-blk/vhost-user-blk.c
@@ -20,10 +20,6 @@
 #include "contrib/libvhost-user/libvhost-user-glib.h"
 #include "contrib/libvhost-user/libvhost-user.h"
=20
-#if defined(__linux__)
-#include <linux/fs.h>
-#include <sys/ioctl.h>
-#endif
=20
 struct virtio_blk_inhdr {
     unsigned char status;
@@ -525,7 +521,7 @@ vub_get_blocksize(int fd)
=20
 #if defined(__linux__) && defined(BLKSSZGET)
     if (ioctl(fd, BLKSSZGET, &blocksize) =3D=3D 0) {
-        return blocksize;
+        return blocklen;
     }
 #endif
=20
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index beae1b99da..9af4542fb8 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -3894,7 +3894,7 @@ static QLIST_HEAD(, MSIRouteEntry) msi_route_list =3D=
 \
 static void kvm_update_msi_routes_all(void *private, bool global,
                                       uint32_t index, uint32_t mask)
 {
-    int cnt =3D 0, vector;
+    int cnt =3D 0;
     MSIRouteEntry *entry;
     MSIMessage msg;
     PCIDevice *dev;
@@ -3902,19 +3902,11 @@ static void kvm_update_msi_routes_all(void *priva=
te, bool global,
     /* TODO: explicit route update */
     QLIST_FOREACH(entry, &msi_route_list, list) {
         cnt++;
-        vector =3D entry->vector;
         dev =3D entry->dev;
-        if (msix_enabled(dev) && !msix_is_masked(dev, vector)) {
-            msg =3D msix_get_message(dev, vector);
-        } else if (msi_enabled(dev) && !msi_is_masked(dev, vector)) {
-            msg =3D msi_get_message(dev, vector);
-        } else {
-            /*
-             * Either MSI/MSIX is disabled for the device, or the
-             * specific message was masked out.  Skip this one.
-             */
+        if (!msix_enabled(dev) && !msi_enabled(dev)) {
             continue;
         }
+        msg =3D pci_get_msi_message(dev, entry->vector);
         kvm_irqchip_update_msi_route(kvm_state, entry->virq, msg, dev);
     }
     kvm_irqchip_commit_routes(kvm_state);
--=20
2.20.1
