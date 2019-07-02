Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 417D1C06510
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 15:39:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17B8A205ED
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 15:39:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17B8A205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54556 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiKs3-0002gP-9A
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 11:39:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58573)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mst@redhat.com>) id 1hiKNj-0006fm-Ek
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 11:07:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1hiKNf-0000Wl-Pj
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 11:07:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52190)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1hiKNd-0000Tz-RX
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 11:07:38 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9D2D0882FF;
 Tue,  2 Jul 2019 15:07:36 +0000 (UTC)
Received: from redhat.com (ovpn-124-209.rdu2.redhat.com [10.10.124.209])
 by smtp.corp.redhat.com (Postfix) with SMTP id 3DA6860C44;
 Tue,  2 Jul 2019 15:07:35 +0000 (UTC)
Date: Tue, 2 Jul 2019 11:07:34 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Message-ID: <20190619094907.10131-7-pagupta@redhat.com>
References: <20190702150606.24851-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190702150606.24851-1-mst@redhat.com>
X-Mutt-Fcc: =sent
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.28]); Tue, 02 Jul 2019 15:07:36 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 10/22] numa: Handle virtio-pmem in NUMA stats
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, David Hildenbrand <david@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190702150734.ek-eS3hjfb-fm2Fa58gGidmC4o-WmRHuc-eGxL071G0@z>

From: David Hildenbrand <david@redhat.com>

Account the memory to node 0 for now. Once (if ever) virtio-pmem
supports NUMA, we can account it to the right node.

Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20190619094907.10131-7-pagupta@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 numa.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/numa.c b/numa.c
index 955ec0c830..cfcdb8d943 100644
--- a/numa.c
+++ b/numa.c
@@ -549,6 +549,7 @@ static void numa_stat_memory_devices(NumaNodeMem node_mem[])
     MemoryDeviceInfoList *info_list = qmp_memory_device_list();
     MemoryDeviceInfoList *info;
     PCDIMMDeviceInfo     *pcdimm_info;
+    VirtioPMEMDeviceInfo *vpi;
 
     for (info = info_list; info; info = info->next) {
         MemoryDeviceInfo *value = info->value;
@@ -556,22 +557,21 @@ static void numa_stat_memory_devices(NumaNodeMem node_mem[])
         if (value) {
             switch (value->type) {
             case MEMORY_DEVICE_INFO_KIND_DIMM:
-                pcdimm_info = value->u.dimm.data;
-                break;
-
             case MEMORY_DEVICE_INFO_KIND_NVDIMM:
-                pcdimm_info = value->u.nvdimm.data;
-                break;
-
-            default:
-                pcdimm_info = NULL;
-                break;
-            }
-
-            if (pcdimm_info) {
+                pcdimm_info = value->type == MEMORY_DEVICE_INFO_KIND_DIMM ?
+                              value->u.dimm.data : value->u.nvdimm.data;
                 node_mem[pcdimm_info->node].node_mem += pcdimm_info->size;
                 node_mem[pcdimm_info->node].node_plugged_mem +=
                     pcdimm_info->size;
+                break;
+            case MEMORY_DEVICE_INFO_KIND_VIRTIO_PMEM:
+                vpi = value->u.virtio_pmem.data;
+                /* TODO: once we support numa, assign to right node */
+                node_mem[0].node_mem += vpi->size;
+                node_mem[0].node_plugged_mem += vpi->size;
+                break;
+            default:
+                g_assert_not_reached();
             }
         }
     }
-- 
MST


