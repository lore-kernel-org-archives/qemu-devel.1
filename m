Received: from eggs.gnu.org ([2001:4830:134:3::10]:59354)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e0PS7-0006wK-U5
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 06:02:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e0PS2-0000MK-C9
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 06:01:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42846)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1e0PS2-0000KY-6y
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 06:01:50 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Fri,  6 Oct 2017 11:59:53 +0200
Message-Id: <20171006095956.27534-31-cohuck@redhat.com>
In-Reply-To: <20171006095956.27534-1-cohuck@redhat.com>
References: <20171006095956.27534-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 30/33] s390x/sclp: Mark the sclp device with
 user_creatable = false
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
Message-Id: <1507125199-22562-1-git-send-email-thuth@redhat.com>
Reviewed-by: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
Reviewed-by: Farhan Ali <alifm@linux.vnet.ibm.com>
Acked-by: Halil Pasic <pasic@linux.vnet.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/s390x/sclp.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
index 30aefbfd15..9be0cb80ad 100644
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
2.13.6
