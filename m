Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0E0AC433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 10:18:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB94E20720
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 10:18:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vv2Zrnq3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB94E20720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53240 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrImO-0006gU-Vu
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 06:18:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56880)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jrIbp-0004Xk-3M
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 06:07:53 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:35874
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jrIbn-0005pc-6A
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 06:07:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593770866;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YfVEVmjau3G6Kev/27aLeUkr71n8IWpHubQtmPsf6WQ=;
 b=Vv2Zrnq3PcgObNtwskWJDLIQWgoZebrQebTF2tXH+m5e8DOQmh3GgUlMWsYd9KGzBK4QOa
 pn3GclqVSok6AWLUzpTbMdQm/2q7tEAZ/6D7y3xp4BeO4QtT/7gMJc63OWzfMDeJ2bYqoF
 FFefD2tEhZ04JL6D1mzgebaquBOXFCY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-276-TEqoii_7NXytrLAvgyd-7g-1; Fri, 03 Jul 2020 06:07:44 -0400
X-MC-Unique: TEqoii_7NXytrLAvgyd-7g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A5171188361A;
 Fri,  3 Jul 2020 10:07:43 +0000 (UTC)
Received: from localhost (ovpn-113-54.ams2.redhat.com [10.36.113.54])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 48B1B7BD56;
 Fri,  3 Jul 2020 10:07:43 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 14/14] s390x/pci: fix set_ind_atomic
Date: Fri,  3 Jul 2020 12:06:50 +0200
Message-Id: <20200703100650.621212-15-cohuck@redhat.com>
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
Cc: Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org
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

Fixes: 8cba80c3a0 ("s390: Add PCI bus support")
Reported-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Message-Id: <20200616045035.51641-3-pasic@linux.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/s390x/s390-pci-bus.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index 142e52a8ffdd..736965c9287f 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -637,22 +637,24 @@ static AddressSpace *s390_pci_dma_iommu(PCIBus *bus, void *opaque, int devfn)
 
 static uint8_t set_ind_atomic(uint64_t ind_loc, uint8_t to_be_set)
 {
-    uint8_t ind_old, ind_new;
+    uint8_t expected, actual;
     hwaddr len = 1;
-    uint8_t *ind_addr;
+    /* avoid  multiple fetches */
+    uint8_t volatile *ind_addr;
 
     ind_addr = cpu_physical_memory_map(ind_loc, &len, true);
     if (!ind_addr) {
         s390_pci_generate_error_event(ERR_EVENT_AIRERR, 0, 0, 0, 0);
         return -1;
     }
+    actual = *ind_addr;
     do {
-        ind_old = *ind_addr;
-        ind_new = ind_old | to_be_set;
-    } while (atomic_cmpxchg(ind_addr, ind_old, ind_new) != ind_old);
-    cpu_physical_memory_unmap(ind_addr, len, 1, len);
+        expected = actual;
+        actual = atomic_cmpxchg(ind_addr, expected, expected | to_be_set);
+    } while (actual != expected);
+    cpu_physical_memory_unmap((void *)ind_addr, len, 1, len);
 
-    return ind_old;
+    return actual;
 }
 
 static void s390_msi_ctrl_write(void *opaque, hwaddr addr, uint64_t data,
-- 
2.25.4


