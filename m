Received: from eggs.gnu.org ([2001:4830:134:3::10]:49453)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1e01mi-0002nK-Lb
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 04:45:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1e01mf-0005xi-Jd
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 04:45:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:22533)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1e01mf-0005w2-D7
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 04:45:33 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Thu,  5 Oct 2017 10:45:05 +0200
Message-Id: <1507193105-15627-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH] hw/s390x: Mark the "sclpquiesce" device with
 user_creatable = false
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: David Hildenbrand <david@redhat.com>, Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Eric Farman <farman@linux.vnet.ibm.com>, Farhan Ali <alifm@linux.vnet.ibm.com>, Fei Li <sherrylf@linux.vnet.ibm.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>, Jason J Herne <jjherne@linux.vnet.ibm.com>, Jing Liu <liujbjl@linux.vnet.ibm.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, QingFeng Hao <haoqf@linux.vnet.ibm.com>, Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>, Yang Chen <bjcyang@linux.vnet.ibm.com>, Yi Min Zhao <zyimin@linux.vnet.ibm.com>

The "sclpquiesce" device is just an internal device that should not be
created by the user directly. Though it currently does not seem to cause
any obvious trouble when the user instantiates an additional device, let's
better mark it with user_creatable = false to avoid unexpected behavior,
e.g. because the quiesce notifier gets registered multiple times.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/s390x/sclpquiesce.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/hw/s390x/sclpquiesce.c b/hw/s390x/sclpquiesce.c
index 762cb18..0241643 100644
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
1.8.3.1
