Received: from eggs.gnu.org ([2001:4830:134:3::10]:43730)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ek4wg-0002Mb-97
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 04:26:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ek4wd-0006JV-CL
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 04:26:14 -0500
From: Cornelia Huck <cohuck@redhat.com>
Date: Fri,  9 Feb 2018 10:25:15 +0100
Message-Id: <20180209092524.31348-21-cohuck@redhat.com>
In-Reply-To: <20180209092524.31348-1-cohuck@redhat.com>
References: <20180209092524.31348-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 20/29] s390x/sclp: fix event mask handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, borntraeger@de.ibm.com, rth@twiddle.net, agraf@suse.de, david@redhat.com, thuth@redhat.com, Cornelia Huck <cohuck@redhat.com>, "Jason J . Herne" <jjherne@linux.vnet.ibm.com>, qemu-stable@nongnu.org

From: Christian Borntraeger <borntraeger@de.ibm.com>

commit 67915de9f038 ("s390x/event-facility: variable-length event
masks") switched the sclp receive/send mask. This broke the sclp
lm console.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Fixes: commit 67915de9f038 ("s390x/event-facility: variable-length event masks")
Cc: Cornelia Huck <cohuck@redhat.com>
Cc: Jason J. Herne <jjherne@linux.vnet.ibm.com>
Cc: qemu-stable@nongnu.org
Message-Id: <20180202094241.59537-1-borntraeger@de.ibm.com>
Reviewed-by: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/s390x/event-facility.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/s390x/event-facility.c b/hw/s390x/event-facility.c
index b0f71f4554..155a69467b 100644
--- a/hw/s390x/event-facility.c
+++ b/hw/s390x/event-facility.c
@@ -293,10 +293,10 @@ static void write_event_mask(SCLPEventFacility *ef, SCCB *sccb)
     ef->receive_mask = be32_to_cpu(tmp_mask);
 
     /* return the SCLP's capability masks to the guest */
-    tmp_mask = cpu_to_be32(get_host_send_mask(ef));
+    tmp_mask = cpu_to_be32(get_host_receive_mask(ef));
     copy_mask(WEM_RECEIVE_MASK(we_mask, mask_length), (uint8_t *)&tmp_mask,
               mask_length, sizeof(tmp_mask));
-    tmp_mask = cpu_to_be32(get_host_receive_mask(ef));
+    tmp_mask = cpu_to_be32(get_host_send_mask(ef));
     copy_mask(WEM_SEND_MASK(we_mask, mask_length), (uint8_t *)&tmp_mask,
               mask_length, sizeof(tmp_mask));
 
-- 
2.13.6
