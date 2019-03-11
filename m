Received: from eggs.gnu.org ([209.51.188.92]:47677)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jandryuk@gmail.com>) id 1h3PH6-00037x-5I
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 14:03:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jandryuk@gmail.com>) id 1h3PH1-0002e5-5u
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 14:03:42 -0400
Received: from mail-qt1-x843.google.com ([2607:f8b0:4864:20::843]:42652)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jandryuk@gmail.com>) id 1h3PGy-0002Oc-GN
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 14:03:37 -0400
Received: by mail-qt1-x843.google.com with SMTP id u7so6109064qtg.9
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 11:03:22 -0700 (PDT)
From: Jason Andryuk <jandryuk@gmail.com>
Date: Mon, 11 Mar 2019 14:02:13 -0400
Message-Id: <20190311180216.18811-4-jandryuk@gmail.com>
In-Reply-To: <20190311180216.18811-1-jandryuk@gmail.com>
References: <20190311180216.18811-1-jandryuk@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 3/6] xen: Skip backend initialization for
 stubdom
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

When QEMU is running in a stubdom, it does not provide any
Paravirtualized backends.  Those still run in dom0 or another driver
domain.  Therefore we skip backend initialization (xen_bus_init and
xen_be_init) for the stubdom case.

Original patch by Anthony PERARD <anthony.perard@citrix.com>

Signed-off-by: Jason Andryuk <jandryuk@gmail.com>
---
 hw/i386/xen/xen-hvm.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/hw/i386/xen/xen-hvm.c b/hw/i386/xen/xen-hvm.c
index c20c4b27f6..4b62f070cb 100644
--- a/hw/i386/xen/xen-hvm.c
+++ b/hw/i386/xen/xen-hvm.c
@@ -1485,8 +1485,6 @@ void xen_hvm_init(PCMachineState *pcms, MemoryRegion **ram_memory)
     QLIST_INIT(&state->dev_list);
     device_listener_register(&state->device_listener);
 
-    xen_bus_init();
-
     xenstore = xs_open(0);
     if (!xenstore) {
         error_report("Can't connect to xenstored");
@@ -1495,12 +1493,16 @@ void xen_hvm_init(PCMachineState *pcms, MemoryRegion **ram_memory)
 
     qemu_set_fd_handler(xs_fileno(xenstore), xenstore_update, NULL, NULL);
 
-    /* Initialize backend core & drivers */
-    if (xen_be_init() != 0) {
-        error_report("xen backend core setup failed");
-        goto err;
+    if (!xen_stubdom_enabled()) {
+        xen_bus_init();
+
+        /* Initialize backend core & drivers */
+        if (xen_be_init() != 0) {
+            error_report("xen backend core setup failed");
+            goto err;
+        }
+        xen_be_register_common();
     }
-    xen_be_register_common();
 
     QLIST_INIT(&xen_physmap);
     xen_read_physmap(state);
-- 
2.20.1
