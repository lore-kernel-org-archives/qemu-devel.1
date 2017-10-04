Received: from eggs.gnu.org ([2001:4830:134:3::10]:56970)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dzk76-0000N7-0n
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 09:53:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dzk72-0006uw-4H
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 09:53:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34382)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dzk71-0006ud-U7
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 09:53:24 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Wed,  4 Oct 2017 15:53:19 +0200
Message-Id: <1507125199-22562-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH] hw/s390x/sclp: Mark the sclp device with
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
Cc: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Eric Farman <farman@linux.vnet.ibm.com>, Farhan Ali <alifm@linux.vnet.ibm.com>, Fei Li <sherrylf@linux.vnet.ibm.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>, Jason J Herne <jjherne@linux.vnet.ibm.com>, Jing Liu <liujbjl@linux.vnet.ibm.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, QingFeng Hao <haoqf@linux.vnet.ibm.com>, Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>, Yang Chen <bjcyang@linux.vnet.ibm.com>, Yi Min Zhao <zyimin@linux.vnet.ibm.com>

The "sclp" device is just an internal device that can not be instantiated
by the users. If they try to use it, they only get a simple error message:

$ qemu-system-s390x -nographic -device sclp
qemu-system-s390x: Option '-device s390-sclp-event-facility' cannot be
handled by this machine

Since sclp_init() tries to create a TYPE_SCLP_EVENT_FACILITY which is
a non-pluggable sysbus device, there is really no way that the "sclp"
device can be used by the user, so let's set the user_creatable = false
accordingly.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/s390x/sclp.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
index 30aefbf..9be0cb8 100644
--- a/hw/s390x/sclp.c
+++ b/hw/s390x/sclp.c
@@ -606,6 +606,11 @@ static void sclp_class_init(ObjectClass *oc, void *data)
     dc->realize = sclp_realize;
     dc->hotpluggable = false;
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
+    /*
+     * Reason: Creates TYPE_SCLP_EVENT_FACILITY in sclp_init
+     * which is a non-pluggable sysbus device
+     */
+    dc->user_creatable = false;
 
     sc->read_SCP_info = read_SCP_info;
     sc->read_storage_element0_info = read_storage_element0_info;
-- 
1.8.3.1
