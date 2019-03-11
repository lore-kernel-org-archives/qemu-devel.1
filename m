Received: from eggs.gnu.org ([209.51.188.92]:47710)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jandryuk@gmail.com>) id 1h3PHA-0003Af-40
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 14:03:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jandryuk@gmail.com>) id 1h3PH8-0002gd-12
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 14:03:47 -0400
Received: from mail-qt1-x842.google.com ([2607:f8b0:4864:20::842]:42651)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jandryuk@gmail.com>) id 1h3PH2-0002KB-PH
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 14:03:42 -0400
Received: by mail-qt1-x842.google.com with SMTP id u7so6108842qtg.9
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 11:03:18 -0700 (PDT)
From: Jason Andryuk <jandryuk@gmail.com>
Date: Mon, 11 Mar 2019 14:02:12 -0400
Message-Id: <20190311180216.18811-3-jandryuk@gmail.com>
In-Reply-To: <20190311180216.18811-1-jandryuk@gmail.com>
References: <20190311180216.18811-1-jandryuk@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 2/6] xen: Move xenstore initialization to
 common location
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: xen-devel@lists.xenproject.org, marmarek@invisiblethingslab.com, Jason Andryuk <jandryuk@gmail.com>, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul.durrant@citrix.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>

For the xen stubdom case, we'll want xenstore initialized, but we'll
want to skip the rest of xen_be_init.  Move the initialization to
xen_hvm_init so we can conditionalize calling xen_be_init.

xs_domain_open() is deprecated for xs_open(0), so make the replacement
as well.

Signed-off-by: Jason Andryuk <jandryuk@gmail.com>
---
 hw/i386/xen/xen-hvm.c       | 8 ++++++++
 hw/xen/xen-legacy-backend.c | 8 --------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/hw/i386/xen/xen-hvm.c b/hw/i386/xen/xen-hvm.c
index 2939122e7c..c20c4b27f6 100644
--- a/hw/i386/xen/xen-hvm.c
+++ b/hw/i386/xen/xen-hvm.c
@@ -1487,6 +1487,14 @@ void xen_hvm_init(PCMachineState *pcms, MemoryRegion **ram_memory)
 
     xen_bus_init();
 
+    xenstore = xs_open(0);
+    if (!xenstore) {
+        error_report("Can't connect to xenstored");
+        goto err;
+    }
+
+    qemu_set_fd_handler(xs_fileno(xenstore), xenstore_update, NULL, NULL);
+
     /* Initialize backend core & drivers */
     if (xen_be_init() != 0) {
         error_report("xen backend core setup failed");
diff --git a/hw/xen/xen-legacy-backend.c b/hw/xen/xen-legacy-backend.c
index 36fd1e9b09..bdf2fa917f 100644
--- a/hw/xen/xen-legacy-backend.c
+++ b/hw/xen/xen-legacy-backend.c
@@ -683,14 +683,6 @@ int xen_be_init(void)
 {
     xengnttab_handle *gnttabdev;
 
-    xenstore = xs_daemon_open();
-    if (!xenstore) {
-        xen_pv_printf(NULL, 0, "can't connect to xenstored\n");
-        return -1;
-    }
-
-    qemu_set_fd_handler(xs_fileno(xenstore), xenstore_update, NULL, NULL);
-
     if (xen_xc == NULL || xen_fmem == NULL) {
         /* Check if xen_init() have been called */
         goto err;
-- 
2.20.1
