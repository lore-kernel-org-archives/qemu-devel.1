Received: from eggs.gnu.org ([209.51.188.92]:50709)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1hH5GI-0002lT-Iv
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 07:31:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1hH5GF-0004Ws-S7
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 07:31:26 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55400)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1hH5GF-0004UA-BE
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 07:31:23 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x3IBTRPf101384
	for <qemu-devel@nongnu.org>; Thu, 18 Apr 2019 07:31:22 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2rxqyu18ys-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 18 Apr 2019 07:31:21 -0400
Received: from localhost
	by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Thu, 18 Apr 2019 12:31:19 +0100
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Thu, 18 Apr 2019 13:31:10 +0200
In-Reply-To: <20190418113110.160664-1-borntraeger@de.ibm.com>
References: <20190418113110.160664-1-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20190418113110.160664-11-borntraeger@de.ibm.com>
Subject: [Qemu-devel] [PATCH 10/10] s390x/cpumodel: do not claim csske for
 expanded models in qmp
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>, David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Richard Henderson <rth@twiddle.net>, Collin Walling <walling@linux.ibm.com>, "Jason J . Herne" <jjherne@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>

While we have removed csske and bpb from the default model, the very
common case of "host-model" in libvirt (expanded to a base model
+ features) would still contain bpb and csske. This can prevent
migration to a future machine for a host-model machine. Let us fence
bpb and csske when we run on a generation 15. If necessary the
user can still use -cpu 8561,csske=on,bpb=on to force enable these
features.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 target/s390x/cpu_models.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index e727519686..03bdca1fb8 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -629,6 +629,17 @@ CpuModelExpansionInfo *qmp_query_cpu_model_expansion(CpuModelExpansionType type,
         return NULL;
     }
 
+    /*
+     * Do not claim CSSKE and BPB if the host model expands to
+     * generation 15 or newer
+     */
+    if (s390_model.def->gen >= 15) {
+        clear_bit(S390_FEAT_CONDITIONAL_SSKE,
+                  (unsigned long *) &s390_model.features);
+        clear_bit(S390_FEAT_BPB,
+                  (unsigned long *) &s390_model.features);
+    }
+
     if (type == CPU_MODEL_EXPANSION_TYPE_STATIC) {
         delta_changes = true;
     } else if (type != CPU_MODEL_EXPANSION_TYPE_FULL) {
-- 
2.19.1
