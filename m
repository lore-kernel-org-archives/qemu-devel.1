Received: from eggs.gnu.org ([2001:4830:134:3::10]:59348)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e0PS7-0006wB-Fu
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 06:02:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e0PRx-0000Fu-Uj
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 06:01:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50882)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1e0PRx-0000Er-Nh
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 06:01:45 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Fri,  6 Oct 2017 11:59:52 +0200
Message-Id: <20171006095956.27534-30-cohuck@redhat.com>
In-Reply-To: <20171006095956.27534-1-cohuck@redhat.com>
References: <20171006095956.27534-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 29/33] s390/kvm: make TOD setting failures fatal
 for migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, rth@twiddle.net, agraf@suse.de, thuth@redhat.com, borntraeger@de.ibm.com, david@redhat.com, "Collin L. Walling" <walling@linux.vnet.ibm.com>, Cornelia Huck <cohuck@redhat.com>

From: "Collin L. Walling" <walling@linux.vnet.ibm.com>

If we fail to set a proper TOD clock on the target system,  this can
already result in some problematic cases. We print several warn messages
on source and target in that case.

If kvm fails to set a nonzero epoch index, then we must ultimately fail
the migration as this will result in a giant time leap backwards. This
patch lets the migration fail if we can not set the guest time on the
target.

On failure the guest will resume normally on the original host machine.

Signed-off-by: Collin L. Walling <walling@linux.vnet.ibm.com>
Reviewed-by: Eric Farman <farman@linux.vnet.ibm.com>
Reviewed-by: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
[split failure change from epoch index change, minor fixups]
Message-Id: <20171004105751.24655-3-borntraeger@de.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/s390x/s390-virtio-ccw.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 76156ce873..32d3f11d8a 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -189,13 +189,10 @@ static int gtod_load(QEMUFile *f, void *opaque, int version_id)
 
     r = s390_set_clock(&tod_high, &tod_low);
     if (r) {
-        warn_report("Unable to set guest clock for migration: %s",
-                    strerror(-r));
-        error_printf("Guest clock will not be restored "
-                     "which could cause the guest to hang.");
+        error_report("Unable to set KVM guest TOD clock: %s", strerror(-r));
     }
 
-    return 0;
+    return r;
 }
 
 static SaveVMHandlers savevm_gtod = {
-- 
2.13.6
