Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76571C2D0A8
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 11:56:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0B782073A
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 11:56:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NCMdaqDy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0B782073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51946 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMrlN-0002Y1-UN
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 07:56:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38136)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1kMrfM-0004eh-PI
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 07:50:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:51152)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1kMrfK-000806-Uk
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 07:50:00 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601293797;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KuYLl0P+5v5GMn1mAxRjxDP/Lo7F1PDNzMsC1nKu8ZI=;
 b=NCMdaqDyNOBhdwVnBOJsZ2zZ68lJGlUe0VO6l6eFmRykex543r1NZqDaIwo6FSO2DVW4mN
 BzBP+pco66fMAtGiD2TxUk7Jw+ovQD7KjxbQB55YCyPhfAirL/WBwdFJTSx2JvEdCN9h8c
 7ZkBkhKc9SAV3snM2ASxDwDMi7+817M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-338-lu1CcXDUNzGIiesVfd0AwA-1; Mon, 28 Sep 2020 07:49:55 -0400
X-MC-Unique: lu1CcXDUNzGIiesVfd0AwA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4DFE4873115;
 Mon, 28 Sep 2020 11:49:54 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-115-97.ams2.redhat.com [10.36.115.97])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3668455765;
 Mon, 28 Sep 2020 11:49:50 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 5/5] virito-mem: Implement get_min_alignment()
Date: Mon, 28 Sep 2020 13:49:09 +0200
Message-Id: <20200928114909.20791-6-david@redhat.com>
In-Reply-To: <20200928114909.20791-1-david@redhat.com>
References: <20200928114909.20791-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 03:47:08
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
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

The block size determines the alignment requirements. Implement
get_min_alignment() of the TYPE_MEMORY_DEVICE interface.

This allows auto-assignment of a properly aligned address in guest
physical address space. For example, when specifying a 2GB block size
for a virtio-mem device with 10GB with a memory setup "-m 4G, 20G",
we'll no longer fail when realizing.

Reviewed-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Wei Yang <richardw.yang@linux.intel.com>
Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/virtio/virtio-mem-pci.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/virtio/virtio-mem-pci.c b/hw/virtio/virtio-mem-pci.c
index 590cec041b..aac975a17c 100644
--- a/hw/virtio/virtio-mem-pci.c
+++ b/hw/virtio/virtio-mem-pci.c
@@ -75,6 +75,12 @@ static void virtio_mem_pci_fill_device_info(const MemoryDeviceState *md,
     info->type = MEMORY_DEVICE_INFO_KIND_VIRTIO_MEM;
 }
 
+static uint64_t virtio_mem_pci_get_min_alignment(const MemoryDeviceState *md)
+{
+    return object_property_get_uint(OBJECT(md), VIRTIO_MEM_BLOCK_SIZE_PROP,
+                                    &error_abort);
+}
+
 static void virtio_mem_pci_size_change_notify(Notifier *notifier, void *data)
 {
     VirtIOMEMPCI *pci_mem = container_of(notifier, VirtIOMEMPCI,
@@ -109,6 +115,7 @@ static void virtio_mem_pci_class_init(ObjectClass *klass, void *data)
     mdc->get_plugged_size = virtio_mem_pci_get_plugged_size;
     mdc->get_memory_region = virtio_mem_pci_get_memory_region;
     mdc->fill_device_info = virtio_mem_pci_fill_device_info;
+    mdc->get_min_alignment = virtio_mem_pci_get_min_alignment;
 }
 
 static void virtio_mem_pci_instance_init(Object *obj)
-- 
2.26.2


