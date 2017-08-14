Received: from eggs.gnu.org ([2001:4830:134:3::10]:57838)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dhOaa-0004Xa-Sg
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 19:16:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dhOaV-0002NW-GE
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 19:16:02 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:35621)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dhOaV-0002Mh-AF
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 19:15:59 -0400
Received: by mail-wr0-x241.google.com with SMTP id u89so2079562wrc.2
	for <qemu-devel@nongnu.org>; Mon, 14 Aug 2017 16:15:57 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 15 Aug 2017 01:15:52 +0200
Message-Id: <20170814231552.24593-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH for 2.10?] qxl: call
 qemu_spice_display_init_common for secondary devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: ademaria@redhat.com, peter.maydell@linaro.org, kraxel@redhat.com

Fixes this 2.10 regression:

  $ qemu-system-x86_64  -cpu host -m 6144 -vga qxl -device qxl
  qemu-system-x86_64: util/qemu-thread-posix.c:64: qemu_mutex_lock: Assertion `mutex->initialized' failed.

Reported-by: ademaria@redhat.com
Cc: kraxel@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/display/qxl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/display/qxl.c b/hw/display/qxl.c
index 7f8c73b56d..ae3677fd1e 100644
--- a/hw/display/qxl.c
+++ b/hw/display/qxl.c
@@ -2054,6 +2054,7 @@ static void qxl_realize_common(PCIQXLDevice *qxl, Error **errp)
     uint32_t pci_device_rev;
     uint32_t io_size;
 
+    qemu_spice_display_init_common(&qxl->ssd);
     qxl->mode = QXL_MODE_UNDEFINED;
     qxl->generation = 1;
     qxl->num_memslots = NUM_MEMSLOTS;
@@ -2176,7 +2177,6 @@ static void qxl_realize_primary(PCIDevice *dev, Error **errp)
     portio_list_add(&qxl->vga_port_list, pci_address_space_io(dev), 0x3b0);
 
     vga->con = graphic_console_init(DEVICE(dev), 0, &qxl_ops, qxl);
-    qemu_spice_display_init_common(&qxl->ssd);
 
     qxl_realize_common(qxl, &local_err);
     if (local_err) {
-- 
2.13.5
