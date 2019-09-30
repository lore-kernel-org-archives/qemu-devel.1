Return-Path: <SRS0=LaQQ=XZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F4DCC32792
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 13:30:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6430A215EA
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 13:30:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6430A215EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=de.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52460 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iEvkk-0007z5-Qt
	for qemu-devel@archiver.kernel.org; Mon, 30 Sep 2019 09:30:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42430)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <borntraeger@de.ibm.com>) id 1iEvbO-0004Qd-Hc
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 09:20:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <borntraeger@de.ibm.com>) id 1iEvbI-0005DO-Jc
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 09:20:32 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54970)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
 id 1iEvbI-00051j-1m
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 09:20:28 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x8UDIRdI099497
 for <qemu-devel@nongnu.org>; Mon, 30 Sep 2019 09:20:08 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2va2b5wxw5-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 30 Sep 2019 09:20:07 -0400
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
 Mon, 30 Sep 2019 14:20:03 +0100
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
 by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 30 Sep 2019 14:19:59 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id x8UDJwvN46465296
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 30 Sep 2019 13:19:58 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 41E8D52052;
 Mon, 30 Sep 2019 13:19:58 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 26A085204E;
 Mon, 30 Sep 2019 13:19:58 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 25651)
 id E0428E01C8; Mon, 30 Sep 2019 15:19:57 +0200 (CEST)
From: Christian Borntraeger <borntraeger@de.ibm.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 08/12] kvm: extract kvm_log_clear_one_slot
Date: Mon, 30 Sep 2019 15:19:51 +0200
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190930131955.101131-1-borntraeger@de.ibm.com>
References: <20190930131955.101131-1-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19093013-0020-0000-0000-000003730FBA
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19093013-0021-0000-0000-000021C8EA25
Message-Id: <20190930131955.101131-9-borntraeger@de.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-09-30_08:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=941 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1909300138
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 148.163.158.5
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Thomas Huth <thuth@redhat.com>, Janosch Frank <frankja@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, David Hildenbrand <david@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Peter Xu <peterx@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 qemu-s390x <qemu-s390x@nongnu.org>, kvm@vger.kernel.org,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>,
 Collin Walling <walling@linux.ibm.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Paolo Bonzini <pbonzini@redhat.com>

We may need to clear the dirty bitmap for more than one KVM memslot.
First do some code movement with no semantic change.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Message-Id: <20190924144751.24149-2-imammedo@redhat.com>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
[fixup line break]
---
 accel/kvm/kvm-all.c | 103 ++++++++++++++++++++++++--------------------
 1 file changed, 57 insertions(+), 46 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index b09bad08048d..a85ec09486dd 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -575,55 +575,14 @@ out:
 #define KVM_CLEAR_LOG_ALIGN  (qemu_real_host_page_size << KVM_CLEAR_LOG_SHIFT)
 #define KVM_CLEAR_LOG_MASK   (-KVM_CLEAR_LOG_ALIGN)
 
-/**
- * kvm_physical_log_clear - Clear the kernel's dirty bitmap for range
- *
- * NOTE: this will be a no-op if we haven't enabled manual dirty log
- * protection in the host kernel because in that case this operation
- * will be done within log_sync().
- *
- * @kml:     the kvm memory listener
- * @section: the memory range to clear dirty bitmap
- */
-static int kvm_physical_log_clear(KVMMemoryListener *kml,
-                                  MemoryRegionSection *section)
+static int kvm_log_clear_one_slot(KVMSlot *mem, int as_id, uint64_t start,
+                                  uint64_t size)
 {
     KVMState *s = kvm_state;
+    uint64_t end, bmap_start, start_delta, bmap_npages;
     struct kvm_clear_dirty_log d;
-    uint64_t start, end, bmap_start, start_delta, bmap_npages, size;
     unsigned long *bmap_clear = NULL, psize = qemu_real_host_page_size;
-    KVMSlot *mem = NULL;
-    int ret, i;
-
-    if (!s->manual_dirty_log_protect) {
-        /* No need to do explicit clear */
-        return 0;
-    }
-
-    start = section->offset_within_address_space;
-    size = int128_get64(section->size);
-
-    if (!size) {
-        /* Nothing more we can do... */
-        return 0;
-    }
-
-    kvm_slots_lock(kml);
-
-    /* Find any possible slot that covers the section */
-    for (i = 0; i < s->nr_slots; i++) {
-        mem = &kml->slots[i];
-        if (mem->start_addr <= start &&
-            start + size <= mem->start_addr + mem->memory_size) {
-            break;
-        }
-    }
-
-    /*
-     * We should always find one memslot until this point, otherwise
-     * there could be something wrong from the upper layer
-     */
-    assert(mem && i != s->nr_slots);
+    int ret;
 
     /*
      * We need to extend either the start or the size or both to
@@ -694,7 +653,7 @@ static int kvm_physical_log_clear(KVMMemoryListener *kml,
     /* It should never overflow.  If it happens, say something */
     assert(bmap_npages <= UINT32_MAX);
     d.num_pages = bmap_npages;
-    d.slot = mem->slot | (kml->as_id << 16);
+    d.slot = mem->slot | (as_id << 16);
 
     if (kvm_vm_ioctl(s, KVM_CLEAR_DIRTY_LOG, &d) == -1) {
         ret = -errno;
@@ -717,6 +676,58 @@ static int kvm_physical_log_clear(KVMMemoryListener *kml,
                  size / psize);
     /* This handles the NULL case well */
     g_free(bmap_clear);
+    return ret;
+}
+
+
+/**
+ * kvm_physical_log_clear - Clear the kernel's dirty bitmap for range
+ *
+ * NOTE: this will be a no-op if we haven't enabled manual dirty log
+ * protection in the host kernel because in that case this operation
+ * will be done within log_sync().
+ *
+ * @kml:     the kvm memory listener
+ * @section: the memory range to clear dirty bitmap
+ */
+static int kvm_physical_log_clear(KVMMemoryListener *kml,
+                                  MemoryRegionSection *section)
+{
+    KVMState *s = kvm_state;
+    uint64_t start, size;
+    KVMSlot *mem = NULL;
+    int ret, i;
+
+    if (!s->manual_dirty_log_protect) {
+        /* No need to do explicit clear */
+        return 0;
+    }
+
+    start = section->offset_within_address_space;
+    size = int128_get64(section->size);
+
+    if (!size) {
+        /* Nothing more we can do... */
+        return 0;
+    }
+
+    kvm_slots_lock(kml);
+
+    /* Find any possible slot that covers the section */
+    for (i = 0; i < s->nr_slots; i++) {
+        mem = &kml->slots[i];
+        if (mem->start_addr <= start &&
+            start + size <= mem->start_addr + mem->memory_size) {
+            break;
+        }
+    }
+
+    /*
+     * We should always find one memslot until this point, otherwise
+     * there could be something wrong from the upper layer
+     */
+    assert(mem && i != s->nr_slots);
+    ret = kvm_log_clear_one_slot(mem, kml->as_id, start, size);
 
     kvm_slots_unlock(kml);
 
-- 
2.21.0


