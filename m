Received: from eggs.gnu.org ([2001:4830:134:3::10]:56151)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dhqv3-0002hg-F6
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 01:31:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dhqv0-0004Ez-Bi
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 01:31:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60310)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dhqv0-0004EI-6V
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 01:31:02 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Wed, 16 Aug 2017 07:30:58 +0200
Message-Id: <1502861458-30270-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH] hw/s390x/ipl: The s390-ipl device is not
 hot-pluggable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org
Cc: Christian Borntraeger <borntraeger@de.ibm.com>

The s390-ipl device can not be created by the user, since it is meant only
to  be instantiated once internally to load the ROMs and kernel. If the user
tries to do a "device_add s390-ipl" via the monitor later, QEMU aborts with
a "ROM images must be loaded at startup" error message.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/s390x/ipl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
index cc36003..0d06fc1 100644
--- a/hw/s390x/ipl.c
+++ b/hw/s390x/ipl.c
@@ -442,6 +442,8 @@ static void s390_ipl_class_init(ObjectClass *klass, void *data)
     dc->reset = s390_ipl_reset;
     dc->vmsd = &vmstate_ipl;
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
+    /* Reason: Loads the ROMs and thus can only be used one time - internally */
+    dc->user_creatable = false;
 }
 
 static const TypeInfo s390_ipl_info = {
-- 
1.8.3.1
