Received: from eggs.gnu.org ([2001:4830:134:3::10]:38982)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dzlsv-0006mJ-L9
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 11:47:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dzlsq-0008QK-Mz
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 11:46:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49786)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dzlsq-0008Ph-Fx
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 11:46:52 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Wed,  4 Oct 2017 17:46:47 +0200
Message-Id: <20171004154647.7572-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PATCH] s390x/sclp: mark sclp-cpu-hotplug as
 non-usercreatable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, agraf@suse.de, rth@twiddle.net, thuth@redhat.com, Cornelia Huck <cohuck@redhat.com>

A TYPE_SCLP_CPU_HOTPLUG device for handling cpu hotplug events
is already created by the sclp event facility. Adding a second
TYPE_SCLP_CPU_HOTPLUG device via -device sclp-cpu-hotplug creates
an ambiguity in raise_irq_cpu_hotplug(), leading to a crash once
a cpu is hotplugged.

To fix this, disallow creating a sclp-cpu-hotplug device manually.

Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/s390x/sclpcpu.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/s390x/sclpcpu.c b/hw/s390x/sclpcpu.c
index 023d059a46..3ee890b392 100644
--- a/hw/s390x/sclpcpu.c
+++ b/hw/s390x/sclpcpu.c
@@ -82,6 +82,12 @@ static void cpu_class_init(ObjectClass *oc, void *data)
     k->get_receive_mask = receive_mask;
     k->read_event_data = read_event_data;
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
+    /*
+     * Reason: raise_irq_cpu_hotplug() depends on an unique
+     * TYPE_SCLP_CPU_HOTPLUG device, which is already created
+     * by the sclp event facility
+     */
+    dc->user_creatable = false;
 }
 
 static const TypeInfo sclp_cpu_info = {
-- 
2.13.6
