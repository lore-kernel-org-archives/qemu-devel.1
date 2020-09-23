Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B10EC2D0A8
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 11:40:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9011214D8
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 11:40:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S4ODfuGN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9011214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48960 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kL38q-0001DQ-PK
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 07:40:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35094)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1kL37U-0008ME-55
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 07:39:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:37711)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1kL37K-0006uQ-Qs
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 07:39:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600861158;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jax0ZbjHdYlCUPzJkR+nYwi8AqRUgX1iul9HZ6qyvvc=;
 b=S4ODfuGN9MQnrdTh+TBFiOxmbxzDNmPnYwgSLanevhlBCo9AGe39l16ebHask7tXj5LzgP
 b5QqbkLhnBlDDM7pfx0rUDbfOxshq1+9WzDECDLOdcBjpKJWOs7pAxmX87ICczCJSoRI9g
 0o2YLReF18ovHmsTne1K9NepZwwPn0U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-20-9yCqpOJPN1K5Iw5TYwQN3Q-1; Wed, 23 Sep 2020 07:39:16 -0400
X-MC-Unique: 9yCqpOJPN1K5Iw5TYwQN3Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4F211107464E;
 Wed, 23 Sep 2020 11:39:15 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-112-54.ams2.redhat.com [10.36.112.54])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C5516702E7;
 Wed, 23 Sep 2020 11:39:13 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 4/5] memory-device: Add get_min_alignment() callback
Date: Wed, 23 Sep 2020 13:38:59 +0200
Message-Id: <20200923113900.72718-5-david@redhat.com>
In-Reply-To: <20200923113900.72718-1-david@redhat.com>
References: <20200923113900.72718-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/23 00:53:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.228,
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
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, David Hildenbrand <david@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Wei Yang <richardw.yang@linux.intel.com>, Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Will be used by virtio-mem to express special alignment requirements due
to manually configured, big block sizes. This avoids failing later when
realizing, because auto-detection wasn't able to assign a properly
aligned address.

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Wei Yang <richardw.yang@linux.intel.com>
Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/mem/memory-device.c         | 11 +++++++++--
 include/hw/mem/memory-device.h | 11 +++++++++++
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/hw/mem/memory-device.c b/hw/mem/memory-device.c
index 8a736f1a26..cf0627fd01 100644
--- a/hw/mem/memory-device.c
+++ b/hw/mem/memory-device.c
@@ -259,7 +259,7 @@ void memory_device_pre_plug(MemoryDeviceState *md, MachineState *ms,
 {
     const MemoryDeviceClass *mdc = MEMORY_DEVICE_GET_CLASS(md);
     Error *local_err = NULL;
-    uint64_t addr, align;
+    uint64_t addr, align = 0;
     MemoryRegion *mr;
 
     mr = mdc->get_memory_region(md, &local_err);
@@ -267,7 +267,14 @@ void memory_device_pre_plug(MemoryDeviceState *md, MachineState *ms,
         goto out;
     }
 
-    align = legacy_align ? *legacy_align : memory_region_get_alignment(mr);
+    if (legacy_align) {
+        align = *legacy_align;
+    } else {
+        if (mdc->get_min_alignment) {
+            align = mdc->get_min_alignment(md);
+        }
+        align = MAX(align, memory_region_get_alignment(mr));
+    }
     addr = mdc->get_addr(md);
     addr = memory_device_get_free_addr(ms, !addr ? NULL : &addr, align,
                                        memory_region_size(mr), &local_err);
diff --git a/include/hw/mem/memory-device.h b/include/hw/mem/memory-device.h
index cde52e83c9..563893854a 100644
--- a/include/hw/mem/memory-device.h
+++ b/include/hw/mem/memory-device.h
@@ -88,6 +88,17 @@ struct MemoryDeviceClass {
      */
     MemoryRegion *(*get_memory_region)(MemoryDeviceState *md, Error **errp);
 
+    /*
+     * Optional: Return the desired minimum alignment of the device in guest
+     * physical address space, ignoring the alignment requirements of the
+     * memory region (e.g., based on the page size). The final alignment is
+     * computed by selecting the maximum of both alignments.
+     *
+     * Called when plugging the memory device to detect the required alignment
+     * during address assignment.
+     */
+    uint64_t (*get_min_alignment)(const MemoryDeviceState *md);
+
     /*
      * Translate the memory device into #MemoryDeviceInfo.
      */
-- 
2.26.2


