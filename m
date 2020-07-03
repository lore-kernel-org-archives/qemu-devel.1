Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F142AC433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 10:09:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA69420720
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 10:09:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DiznWLYc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA69420720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48048 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrIdZ-000897-UN
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 06:09:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56920)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jrIbq-0004bx-JF
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 06:07:54 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:30627
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jrIbn-0005q9-Aj
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 06:07:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593770868;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xB9Td40Gom2guvgy4uKWs21zVgcepHvrpo8kia4g794=;
 b=DiznWLYcpKMDgcVVi0rZziuGpusnH8cVr0vJnYBLOX6c4+HclMdSrKIddKs45nLJcqpm2Q
 TmEqfrPR7QVD5IOrvIgaZ+GUOXdSZSlDilFrmnLWry8ZsCvaty1/FAaHshND0WuT+HvMso
 0c/vKRj8BEYvPYolyGzMJAp8vG8wSk4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-214-4SHSFBp1Pfyas5RK84s6cg-1; Fri, 03 Jul 2020 06:07:42 -0400
X-MC-Unique: 4SHSFBp1Pfyas5RK84s6cg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 856AB56B29;
 Fri,  3 Jul 2020 10:07:41 +0000 (UTC)
Received: from localhost (ovpn-113-54.ams2.redhat.com [10.36.113.54])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 27F897923E;
 Fri,  3 Jul 2020 10:07:40 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 13/14] virtio-ccw: fix virtio_set_ind_atomic
Date: Fri,  3 Jul 2020 12:06:49 +0200
Message-Id: <20200703100650.621212-14-cohuck@redhat.com>
In-Reply-To: <20200703100650.621212-1-cohuck@redhat.com>
References: <20200703100650.621212-1-cohuck@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=cohuck@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/03 03:17:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Cornelia Huck <cohuck@redhat.com>, Andre Wild <Andre.Wild1@ibm.com>,
 qemu-devel@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Halil Pasic <pasic@linux.ibm.com>

The atomic_cmpxchg() loop is broken because we occasionally end up with
old and _old having different values (a legit compiler can generate code
that accessed *ind_addr again to pick up a value for _old instead of
using the value of old that was already fetched according to the
rules of the abstract machine). This means the underlying CS instruction
may use a different old (_old) than the one we intended to use if
atomic_cmpxchg() performed the xchg part.

Let us use volatile to force the rules of the abstract machine for
accesses to *ind_addr. Let us also rewrite the loop so, we that the
new old is used to compute the new desired value if the xchg part
is not performed.

Fixes: 7e7494627f ("s390x/virtio-ccw: Adapter interrupt support.")
Reported-by: Andre Wild <Andre.Wild1@ibm.com>
Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Message-Id: <20200616045035.51641-2-pasic@linux.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/s390x/virtio-ccw.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
index c1f4bb1d331d..3c988a000b5b 100644
--- a/hw/s390x/virtio-ccw.c
+++ b/hw/s390x/virtio-ccw.c
@@ -786,9 +786,10 @@ static inline VirtioCcwDevice *to_virtio_ccw_dev_fast(DeviceState *d)
 static uint8_t virtio_set_ind_atomic(SubchDev *sch, uint64_t ind_loc,
                                      uint8_t to_be_set)
 {
-    uint8_t ind_old, ind_new;
+    uint8_t expected, actual;
     hwaddr len = 1;
-    uint8_t *ind_addr;
+    /* avoid  multiple fetches */
+    uint8_t volatile *ind_addr;
 
     ind_addr = cpu_physical_memory_map(ind_loc, &len, true);
     if (!ind_addr) {
@@ -796,14 +797,15 @@ static uint8_t virtio_set_ind_atomic(SubchDev *sch, uint64_t ind_loc,
                      __func__, sch->cssid, sch->ssid, sch->schid);
         return -1;
     }
+    actual = *ind_addr;
     do {
-        ind_old = *ind_addr;
-        ind_new = ind_old | to_be_set;
-    } while (atomic_cmpxchg(ind_addr, ind_old, ind_new) != ind_old);
-    trace_virtio_ccw_set_ind(ind_loc, ind_old, ind_new);
-    cpu_physical_memory_unmap(ind_addr, len, 1, len);
+        expected = actual;
+        actual = atomic_cmpxchg(ind_addr, expected, expected | to_be_set);
+    } while (actual != expected);
+    trace_virtio_ccw_set_ind(ind_loc, actual, actual | to_be_set);
+    cpu_physical_memory_unmap((void *)ind_addr, len, 1, len);
 
-    return ind_old;
+    return actual;
 }
 
 static void virtio_ccw_notify(DeviceState *d, uint16_t vector)
-- 
2.25.4


