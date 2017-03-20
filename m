Received: from eggs.gnu.org ([2001:4830:134:3::10]:38216)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cpt9W-0005Xu-5B
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 04:58:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cpt9T-00029l-5y
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 04:58:58 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58293)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1cpt9S-00029G-St
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 04:58:55 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v2K8s01I084577
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 04:58:53 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0a-001b2d01.pphosted.com with ESMTP id 29906v1k2v-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 04:58:52 -0400
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Mon, 20 Mar 2017 08:58:50 -0000
From: Cornelia Huck <cornelia.huck@de.ibm.com>
Date: Mon, 20 Mar 2017 09:58:44 +0100
In-Reply-To: <20170320085844.15178-1-cornelia.huck@de.ibm.com>
References: <20170320085844.15178-1-cornelia.huck@de.ibm.com>
Message-Id: <20170320085844.15178-2-cornelia.huck@de.ibm.com>
Subject: [Qemu-devel] [PULL for-2.9 1/1] s390x/css: reassign subchannel if
 schid is changed after migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: borntraeger@de.ibm.com, agraf@suse.de, qemu-devel@nongnu.org, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, qemu-stable@nongnu.org, Cornelia Huck <cornelia.huck@de.ibm.com>

From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>

The subchannel is a means to access a device. While the device number is
assigned by the administrator, the subchannel number is assigned by
the channel subsystem in an ascending order on cold and hot plug.
When doing unplug and replug operations, the same device may end up on
a different subchannel; for example

- We start with a device fe.1.2222, which ends up at subchannel
  fe.1.0000.
- Now we detach the device, attach a device fe.1.3333 (which would get
  the now-free subchannel fe.1.0000), re-attach fe.1.2222 (which ends
  up at subchannel fe.1.0001) and detach fe.1.3333.
- We now have the same device (fe.1.2222) available to the guest; it
  just shows up on a different subchannel.

In such a case, the subchannel numbers are different from what a
QEMU would create during cold plug when parsing the command line.

As this would cause a guest visible change on migration, we do restore
the source system's value of the subchannel number on load.

So we are now fine from the guest perspective. From the host
perspective this will cause an inconsistent state in our internal data
structures, though.

For example, the subchannel 0 might not be at array position 0. This will
lead to problems when we continue doing hot (un/re) plug operations.

Let's fix this by cleaning up our internal data structures.

Reported-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Cc: qemu-stable@nongnu.org
Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 hw/s390x/css.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/hw/s390x/css.c b/hw/s390x/css.c
index e32b2a4d42..37caa98195 100644
--- a/hw/s390x/css.c
+++ b/hw/s390x/css.c
@@ -1675,12 +1675,27 @@ void subch_device_save(SubchDev *s, QEMUFile *f)
 
 int subch_device_load(SubchDev *s, QEMUFile *f)
 {
+    SubchDev *old_s;
+    uint16_t old_schid = s->schid;
     int i;
 
     s->cssid = qemu_get_byte(f);
     s->ssid = qemu_get_byte(f);
     s->schid = qemu_get_be16(f);
     s->devno = qemu_get_be16(f);
+    /* Re-assign subch. */
+    if (old_schid != s->schid) {
+        old_s = channel_subsys.css[s->cssid]->sch_set[s->ssid]->sch[old_schid];
+        /*
+         * (old_s != s) means that some other device has its correct
+         * subchannel already assigned (in load).
+         */
+        if (old_s == s) {
+            css_subch_assign(s->cssid, s->ssid, old_schid, s->devno, NULL);
+        }
+        /* It's OK to re-assign without a prior de-assign. */
+        css_subch_assign(s->cssid, s->ssid, s->schid, s->devno, s);
+    }
     s->thinint_active = qemu_get_byte(f);
     /* SCHIB */
     /*     PMCW */
-- 
2.11.0
