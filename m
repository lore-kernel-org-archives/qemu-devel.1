Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72D97C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 07:08:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A632122260
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 07:08:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V4BQJkpo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A632122260
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54398 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQmWP-0000X0-Hz
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 03:08:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56910)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kQmDI-0000EN-Nd
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 02:49:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:39880)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kQmDG-0001aP-SI
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 02:49:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602226148;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OMrLk0g04u5nH4vC+xcSxbxkdfMz69tDaASLL1Fon74=;
 b=V4BQJkpo7959CgQ3sC1UVR0chit1uSfLUezGelq61mBNcwkDjEkROMrws0RKsV1N6OK5i9
 Ron9KeZdt1raMViRu85FzaNqtTEY25UG1GwRcY9EKU+rUF7QunnHWr948M3msaQXFkOEiV
 KuLky3su1oXcv2f5EYviUUKRwuK8z50=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-226-eUmShL3cNm-84PKkPqjYog-1; Fri, 09 Oct 2020 02:49:06 -0400
X-MC-Unique: eUmShL3cNm-84PKkPqjYog-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DE8F284A61C;
 Fri,  9 Oct 2020 06:49:05 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-182.ams2.redhat.com
 [10.36.112.182])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1A94D7664F;
 Fri,  9 Oct 2020 06:49:00 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 99259112CE14; Fri,  9 Oct 2020 08:48:58 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 2/2] error: Use error_fatal to simplify obvious fatal errors
 (again)
Date: Fri,  9 Oct 2020 08:48:58 +0200
Message-Id: <20201009064858.323624-3-armbru@redhat.com>
In-Reply-To: <20201009064858.323624-1-armbru@redhat.com>
References: <20201009064858.323624-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/09 02:34:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: peter.maydell@linaro.org, David Hildenbrand <david@redhat.com>,
 Eric Auger <eric.auger@redhat.com>
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
Message-Id: <20200722084048.1726105-5-armbru@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
---
 exec.c                     | 11 +++--------
 hw/s390x/s390-virtio-ccw.c |  7 +------
 hw/virtio/vhost.c          | 10 +++-------
 3 files changed, 7 insertions(+), 21 deletions(-)

diff --git a/exec.c b/exec.c
index ec68f4a9ca..bca441f7fd 100644
--- a/exec.c
+++ b/exec.c
@@ -623,8 +623,7 @@ static void tcg_register_iommu_notifier(CPUState *cpu,
      */
     MemoryRegion *mr = MEMORY_REGION(iommu_mr);
     TCGIOMMUNotifier *notifier;
-    Error *err = NULL;
-    int i, ret;
+    int i;
 
     for (i = 0; i < cpu->iommu_notifiers->len; i++) {
         notifier = g_array_index(cpu->iommu_notifiers, TCGIOMMUNotifier *, i);
@@ -653,12 +652,8 @@ static void tcg_register_iommu_notifier(CPUState *cpu,
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
index 28266a3a35..e52182f946 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -161,7 +161,6 @@ static void virtio_ccw_register_hcalls(void)
 static void s390_memory_init(MemoryRegion *ram)
 {
     MemoryRegion *sysmem = get_system_memory();
-    Error *local_err = NULL;
 
     /* allocate RAM for core */
     memory_region_add_subregion(sysmem, 0, ram);
@@ -170,11 +169,7 @@ static void s390_memory_init(MemoryRegion *ram)
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
index 68f0a75134..3077fa6ef5 100644
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


