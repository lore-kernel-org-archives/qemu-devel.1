Received: from eggs.gnu.org ([2001:4830:134:3::10]:41346)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dIxLx-0006vA-SE
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 09:19:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dIxLu-0003kB-J0
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 09:19:57 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49986
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1dIxLu-0003Rq-Cz
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 09:19:54 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v58DJ14X081269
	for <qemu-devel@nongnu.org>; Thu, 8 Jun 2017 09:19:12 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2axxux7krb-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 08 Jun 2017 09:19:10 -0400
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Thu, 8 Jun 2017 14:19:08 +0100
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Thu,  8 Jun 2017 15:19:00 +0200
In-Reply-To: <1496927940-13301-1-git-send-email-borntraeger@de.ibm.com>
References: <1496927940-13301-1-git-send-email-borntraeger@de.ibm.com>
Message-Id: <1496927940-13301-6-git-send-email-borntraeger@de.ibm.com>
Subject: [Qemu-devel] [PULL 5/5] s390x/cpumodel: improve defintion search
 without an IBC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, Cornelia Huck <cornelia.huck@de.ibm.com>, Stefan Hajnoczi <stefanha@gmail.com>, David Hildenbrand <david@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>

From: David Hildenbrand <david@redhat.com>

Currently, under z/VM on a 0x2827, QEMU will detect a 0x2828 if no
IBC value is provided. QEMU will simply take the last model of that HW
generation, which happens to be the BC version.

Let's improve our search for that case by selecting the latest CPU
definition that matches the CPU type. This for example will avoid
detecting an z13 as a z13s.

We might still detect a GA2 version on a GA1 system, but as we don't
have further information at hand, there isn't too much we can do about
it. The alternative of always presenting the oldest GA is not backward
compatible, e.g:
You're running on 0x2827 GA2.
Old QEMU version indicated "0x2828 GA1 == 0x2827 GA2". After you updated
QEMU, you suddenly detect "0x2827 GA1". You're previous libvirt guest
might suddenly refuse to run.

In the end presenting a newer GA level does not matter because:

1: All GAX models share the same base feature set. A GAX++ might
support "more features".
2: Without an IBC, the guest can't detect the GA version.

If we have no IBC (esp. unblocked_ibc == 0), the IBC we will present
to the guest in read_SCP_info() will be 0. The guest will not know
which GA version it has. The problem of missing IBC propagates.

If we don't have a feature of the GA++ version, also our guest won't
have it. So in summary, the guest also has no idea of its GA version.

Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20170531193434.6918-3-david@redhat.com>
Acked-by: Jason J. Herne <jjherne@linux.vnet.ibm.com>
Reviewed-by: Halil Pasic <pasic@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
[improve patch description by reusing mailing list discussion]
---
 target/s390x/cpu_models.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index 9e23535..b6220c8 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -184,6 +184,7 @@ const S390CPUDef *s390_find_cpu_def(uint16_t type, uint8_t gen, uint8_t ec_ga,
                                     S390FeatBitmap features)
 {
     const S390CPUDef *last_compatible = NULL;
+    const S390CPUDef *matching_cpu_type = NULL;
     int i;
 
     if (!gen) {
@@ -218,8 +219,16 @@ const S390CPUDef *s390_find_cpu_def(uint16_t type, uint8_t gen, uint8_t ec_ga,
         if (def->type == type && def->ec_ga == ec_ga) {
             return def;
         }
+        /* remember if we've at least seen one with the same cpu type */
+        if (def->type == type) {
+            matching_cpu_type = def;
+        }
         last_compatible = def;
     }
+    /* prefer the model with the same cpu type, esp. don't take the BC for EC */
+    if (matching_cpu_type) {
+        return matching_cpu_type;
+    }
     return last_compatible;
 }
 
-- 
2.7.4
