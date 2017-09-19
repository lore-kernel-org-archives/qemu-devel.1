Received: from eggs.gnu.org ([2001:4830:134:3::10]:44277)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1duJxG-00023G-LS
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 10:56:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1duJxC-0007Lu-28
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 10:56:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39126)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1duJxB-0007La-Rw
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 10:56:49 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Tue, 19 Sep 2017 16:55:59 +0200
Message-Id: <20170919145636.9389-2-cohuck@redhat.com>
In-Reply-To: <20170919145636.9389-1-cohuck@redhat.com>
References: <20170919145636.9389-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 01/38] s390x/css: fix cc handling for XSCH
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, rth@twiddle.net, agraf@suse.de, thuth@redhat.com, borntraeger@de.ibm.com, david@redhat.com, Halil Pasic <pasic@linux.vnet.ibm.com>, Cornelia Huck <cohuck@redhat.com>

From: Halil Pasic <pasic@linux.vnet.ibm.com>

The function ioinst_handle_xsch is presenting cc 2 when it's supposed to
present cc 1 and the other way around, because css_do_xsch has the error
codes mixed up. Because cc 1 has precedence over cc 2 we also have to
swap the two checks.

Let us fix this.

Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
Reported-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
Message-Id: <20170831121828.85885-1-pasic@linux.vnet.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/s390x/css.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/s390x/css.c b/hw/s390x/css.c
index 901dc6a0f3..5d3de71c4c 100644
--- a/hw/s390x/css.c
+++ b/hw/s390x/css.c
@@ -1276,16 +1276,16 @@ int css_do_xsch(SubchDev *sch)
         goto out;
     }
 
+    if (s->ctrl & SCSW_CTRL_MASK_STCTL) {
+        ret = -EINPROGRESS;
+        goto out;
+    }
+
     if (!(s->ctrl & SCSW_CTRL_MASK_FCTL) ||
         ((s->ctrl & SCSW_CTRL_MASK_FCTL) != SCSW_FCTL_START_FUNC) ||
         (!(s->ctrl &
            (SCSW_ACTL_RESUME_PEND | SCSW_ACTL_START_PEND | SCSW_ACTL_SUSP))) ||
         (s->ctrl & SCSW_ACTL_SUBCH_ACTIVE)) {
-        ret = -EINPROGRESS;
-        goto out;
-    }
-
-    if (s->ctrl & SCSW_CTRL_MASK_STCTL) {
         ret = -EBUSY;
         goto out;
     }
-- 
2.13.5
