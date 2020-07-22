Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A584C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 08:44:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5F30205CB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 08:44:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IaPa2Sbb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5F30205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52760 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyAMQ-00080n-48
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 04:44:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44356)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jyAJC-0003ov-80
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 04:41:02 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:27111
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jyAJA-0000P9-63
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 04:41:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595407259;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cZsRHA+6UlTuB0PRoHEFLy2Ee/c0JGlbkBfkb86ChPY=;
 b=IaPa2SbbnP8/ZmduYnfRzbwljhw0UVjvyGYFBqUsyu+SUOlcH410M0Q1978ThGaFo4J3cO
 8li+28N252yTZaqJBZfJOhXrdSCNtKXaQClp7LPL+ZIw9y3QSfuIx1rFA5MNJGNxlILsf9
 uOPI+oYW51zcGchC3ZNncqCGRC+zgI4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-239-k6OphLYUOrSoZIN3CBiSig-1; Wed, 22 Jul 2020 04:40:57 -0400
X-MC-Unique: k6OphLYUOrSoZIN3CBiSig-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 813E6801E6A
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2020 08:40:56 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7147E5D9D7;
 Wed, 22 Jul 2020 08:40:50 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0ECCF10593DD; Wed, 22 Jul 2020 10:40:49 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 4/4] error: Use error_fatal to simplify obvious fatal errors
 (again)
Date: Wed, 22 Jul 2020 10:40:48 +0200
Message-Id: <20200722084048.1726105-5-armbru@redhat.com>
In-Reply-To: <20200722084048.1726105-1-armbru@redhat.com>
References: <20200722084048.1726105-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/21 23:34:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Eric Auger <eric.auger@redhat.com>, David Hildenbrand <david@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Patch created mechanically by rerunning:

    $ spatch --in-place --sp-file scripts/coccinelle/use-error_fatal.cocci \
	     --macro-file scripts/cocci-macro-file.h --use-gitgrep .

Variables now unused dropped manually.

Cc: Eric Auger <eric.auger@redhat.com>
Cc: David Hildenbrand <david@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 exec.c                     | 11 +++--------
 hw/s390x/s390-virtio-ccw.c |  6 +-----
 hw/virtio/vhost.c          | 10 +++-------
 3 files changed, 7 insertions(+), 20 deletions(-)

diff --git a/exec.c b/exec.c
index 6f381f98e2..61b46a62f8 100644
--- a/exec.c
+++ b/exec.c
@@ -627,8 +627,7 @@ static void tcg_register_iommu_notifier(CPUState *cpu,
      */
     MemoryRegion *mr = MEMORY_REGION(iommu_mr);
     TCGIOMMUNotifier *notifier;
-    Error *err = NULL;
-    int i, ret;
+    int i;
 
     for (i = 0; i < cpu->iommu_notifiers->len; i++) {
         notifier = g_array_index(cpu->iommu_notifiers, TCGIOMMUNotifier *, i);
@@ -657,12 +656,8 @@ static void tcg_register_iommu_notifier(CPUState *cpu,
                             0,
                             HWADDR_MAX,
                             iommu_idx);
-        ret = memory_region_register_iommu_notifier(notifier->mr, &notifier->n,
-                                                    &err);
-        if (ret) {
-            error_report_err(err);
-            exit(1);
-        }
+        memory_region_register_iommu_notifier(notifier->mr, &notifier->n,
+                                              &error_fatal);
     }
 
     if (!notifier->active) {
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 8cc2f25d8a..4fc92559fb 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -170,11 +170,7 @@ static void s390_memory_init(MemoryRegion *ram)
      * Configure the maximum page size. As no memory devices were created
      * yet, this is the page size of initial memory only.
      */
-    s390_set_max_pagesize(qemu_maxrampagesize(), &local_err);
-    if (local_err) {
-        error_report_err(local_err);
-        exit(EXIT_FAILURE);
-    }
+    s390_set_max_pagesize(qemu_maxrampagesize(), &error_fatal);
     /* Initialize storage key device */
     s390_skeys_init();
     /* Initialize storage attributes device */
diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 1a1384e7a6..cc8c1f89d5 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -712,9 +712,8 @@ static void vhost_iommu_region_add(MemoryListener *listener,
                                          iommu_listener);
     struct vhost_iommu *iommu;
     Int128 end;
-    int iommu_idx, ret;
+    int iommu_idx;
     IOMMUMemoryRegion *iommu_mr;
-    Error *err = NULL;
 
     if (!memory_region_is_iommu(section->mr)) {
         return;
@@ -737,11 +736,8 @@ static void vhost_iommu_region_add(MemoryListener *listener,
     iommu->iommu_offset = section->offset_within_address_space -
                           section->offset_within_region;
     iommu->hdev = dev;
-    ret = memory_region_register_iommu_notifier(section->mr, &iommu->n, &err);
-    if (ret) {
-        error_report_err(err);
-        exit(1);
-    }
+    memory_region_register_iommu_notifier(section->mr, &iommu->n,
+                                          &error_fatal);
     QLIST_INSERT_HEAD(&dev->iommu_list, iommu, iommu_next);
     /* TODO: can replay help performance here? */
 }
-- 
2.26.2


