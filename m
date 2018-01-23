Received: from eggs.gnu.org ([2001:4830:134:3::10]:36556)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ee7Ii-0002bp-Ts
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 17:44:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ee7If-0000oZ-7p
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 17:44:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37470)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1ee7If-0000nT-1T
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 17:44:17 -0500
Date: Wed, 24 Jan 2018 00:44:14 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1516747387-31760-2-git-send-email-mst@redhat.com>
References: <1516747387-31760-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1516747387-31760-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 1/1] kvm-all: Partially reverts 4fe6d78b2e to
 remove the cleanup call
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>, Anton Blanchard <anton@samba.org>, Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org

From: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>

This commit partially reverts the commit 4fe6d78b2e because of issues
reported in the virtio.

Examples:

$ qemu-system-ppc64 -cpu POWER8 -nographic -vga none -m 4G \
  -M pseries,accel=kvm -netdev type=user,id=net0 \
  -device virtio-net-pci,netdev=net0 -drive file=../disk.qcow2,if=virtio

Populating /vdevice/nvram@71000001
Populating /vdevice/v-scsi@71000002
       SCSI: Looking for devices
          8200000000000000 CD-ROM   : "QEMU     QEMU CD-ROM      2.5+"
Populating /pci@800000020000000
                     00 0000 (D) : 1af4 1000    virtio [ net ]
Aborted

$ qemu-system-x86_64 -m 4G -enable-kvm -drive file=util.qcow2,if=virtio

Running QEMU with GTK 2.x is deprecated, and will be removed
in a future release. Please switch to GTK 3.x instead
[1]    5282 abort

Reference http://lists.nongnu.org/archive/html/qemu-devel/2018-01/msg05457.html

Reported-by: Anton Blanchard <anton@samba.org>
Signed-off-by: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
Reviewed-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Tested-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 accel/kvm/kvm-all.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 071f4f5..f290f48 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -812,10 +812,6 @@ static void kvm_mem_ioeventfd_del(MemoryListener *listener,
     if (r < 0) {
         abort();
     }
-
-    if (e->cleanup) {
-        e->cleanup(e);
-    }
 }
 
 static void kvm_io_ioeventfd_add(MemoryListener *listener,
-- 
MST
