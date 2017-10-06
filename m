Received: from eggs.gnu.org ([2001:4830:134:3::10]:59379)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e0PSF-00072h-VY
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 06:02:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e0PSA-0000UC-Dv
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 06:02:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60196)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1e0PSA-0000TC-8Q
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 06:01:58 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Fri,  6 Oct 2017 11:59:56 +0200
Message-Id: <20171006095956.27534-34-cohuck@redhat.com>
In-Reply-To: <20171006095956.27534-1-cohuck@redhat.com>
References: <20171006095956.27534-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 33/33] hw/s390x: Mark the "sclpquiesce" device
 with user_creatable = false
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, rth@twiddle.net, agraf@suse.de, thuth@redhat.com, borntraeger@de.ibm.com, david@redhat.com, Cornelia Huck <cohuck@redhat.com>

From: Thomas Huth <thuth@redhat.com>

The "sclpquiesce" device is just an internal device that should not be
created by the user directly. Though it currently does not seem to cause
any obvious trouble when the user instantiates an additional device, let's
better mark it with user_creatable = false to avoid unexpected behavior,
e.g. because the quiesce notifier gets registered multiple times.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <1507193105-15627-1-git-send-email-thuth@redhat.com>
Reviewed-by: Halil Pasic <pasic@linux.vnet.ibm.com>
Reviewed-by: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/s390x/sclpquiesce.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/hw/s390x/sclpquiesce.c b/hw/s390x/sclpquiesce.c
index 762cb184ac..02416435a1 100644
--- a/hw/s390x/sclpquiesce.c
+++ b/hw/s390x/sclpquiesce.c
@@ -118,8 +118,13 @@ static void quiesce_class_init(ObjectClass *klass, void *data)
     dc->reset = quiesce_reset;
     dc->vmsd = &vmstate_sclpquiesce;
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
-    k->init = quiesce_init;
+    /*
+     * Reason: This is just an internal device - the notifier should
+     * not be registered multiple times in quiesce_init()
+     */
+    dc->user_creatable = false;
 
+    k->init = quiesce_init;
     k->get_send_mask = send_mask;
     k->get_receive_mask = receive_mask;
     k->can_handle_event = can_handle_event;
-- 
2.13.6
