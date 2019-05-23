Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0445C282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 10:44:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8251220851
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 10:44:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8251220851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33343 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTlDC-0004qS-Oz
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 06:44:38 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50180)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1hTkx0-0007IO-Rx
	for qemu-devel@nongnu.org; Thu, 23 May 2019 06:27:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1hTkwz-0002hJ-Vs
	for qemu-devel@nongnu.org; Thu, 23 May 2019 06:27:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46590)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pagupta@redhat.com>) id 1hTkwz-0002gl-RO
	for qemu-devel@nongnu.org; Thu, 23 May 2019 06:27:53 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 189133060485;
	Thu, 23 May 2019 10:27:51 +0000 (UTC)
Received: from dhcp201-121.englab.pnq.redhat.com (ovpn-116-162.sin2.redhat.com
	[10.67.116.162])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B2F4969181;
	Thu, 23 May 2019 10:27:29 +0000 (UTC)
From: Pankaj Gupta <pagupta@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 23 May 2019 15:54:48 +0530
Message-Id: <20190523102449.2642-7-pagupta@redhat.com>
In-Reply-To: <20190523102449.2642-1-pagupta@redhat.com>
References: <20190523102449.2642-1-pagupta@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.47]);
	Thu, 23 May 2019 10:27:53 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 6/7] numa: Handle virtio-pmem in NUMA stats
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: kwolf@redhat.com, aarcange@redhat.com, cohuck@redhat.com,
	xiaoguangrong.eric@gmail.com, mst@redhat.com, pagupta@redhat.com,
	riel@surriel.com, david@redhat.com, armbru@redhat.com,
	ehabkost@redhat.com, lcapitulino@redhat.com, stefanha@redhat.com,
	pbonzini@redhat.com, imammedo@redhat.com,
	dan.j.williams@intel.com, nilal@redhat.com, dgilbert@redhat.com,
	rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: David Hildenbrand <david@redhat.com>

Account the memory to node 0 for now. Once (if ever) virtio-pmem
supports NUMA, we can account it to the right node.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 numa.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/numa.c b/numa.c
index 3875e1efda..42cca616e7 100644
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
2.14.5


