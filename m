Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBDF5C388F7
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 14:41:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B8EA2054F
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 14:41:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NCkyvIEl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B8EA2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34618 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZxVK-0004O9-7p
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 09:41:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:32946)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kZxOH-0003wN-0I
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 09:34:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:35490)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kZxOF-0006LJ-0u
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 09:34:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604414065;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NLAI6E52qR6iiwo+p5ybiNDvz6sVMxaw+nStvrHSOQ4=;
 b=NCkyvIEl972LcLfv05wlswi6bSCnEaFn5kBib2usKg1nS4/S7Mu+vC0JPqOHqJTMbZ02D8
 KL6/vPIXosnw5TOL8bFvu1VaTPQfp9nGw24RwHtax9bnyp6gC3UM/DXRP66rtLKc/Pbu3r
 kY9rzrn0KcL30UfI+FPxvjtPuIrdxU8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-16-TMIolHGuOZqm6-DePovCmw-1; Tue, 03 Nov 2020 09:34:23 -0500
X-MC-Unique: TMIolHGuOZqm6-DePovCmw-1
Received: by mail-wm1-f72.google.com with SMTP id o19so4682259wme.2
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2020 06:34:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=NLAI6E52qR6iiwo+p5ybiNDvz6sVMxaw+nStvrHSOQ4=;
 b=QgvY6/EqbszDxShRIU/yyxNddWrSxW16sIGpnububQnRd106azaH2cf+SzztFldpfQ
 QBjbGJFEQaJgxRQ0s4sqZ+47mh41p2M+Ykk5Hx14Bwa0cRzGgtB7YvKoGFn8C3HuNUIo
 9JYDcb96MxZq0T/7O1Z9J/+9AUn4d5KBhhtVfJNV7yV3wn7w3UvNcJUaGZmeoYzVVsbO
 pQCDTr2pKZTk9fORdbtfbXvBQ4ZoxCPcnn72uclGSCLCaklvIS8azgIs2O9h37PuvXqL
 8Qg2bNlMtStp9KiGjKE6xCmmedIuThC4O8YaoTKfx3Kpjt61S3J6KOutJmsMVf9NcEnG
 kd1w==
X-Gm-Message-State: AOAM53125iUs71aI/GKTvufD4ITkqokdiv+XcrIvHI7loK4/8AmDlJ+C
 E5uz5Evm4xPhMDF4seP9reF2MHJkH2t4Y5bqdZ8q9yutBeL49cTSSL1MzrbkGHcu2uPNfglZYrn
 TIlvNE2WAdgJULuY=
X-Received: by 2002:a1c:4d05:: with SMTP id o5mr64142wmh.94.1604414061893;
 Tue, 03 Nov 2020 06:34:21 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwCHAjnecwNLODgebl5fEP+/5wgCz6fGh5Lm8ODATab2hmtp2PDZ+MoutMgpzpfqO3rpATXhg==
X-Received: by 2002:a1c:4d05:: with SMTP id o5mr64135wmh.94.1604414061753;
 Tue, 03 Nov 2020 06:34:21 -0800 (PST)
Received: from redhat.com (bzq-79-176-118-93.red.bezeqint.net. [79.176.118.93])
 by smtp.gmail.com with ESMTPSA id 205sm3270214wme.38.2020.11.03.06.34.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2020 06:34:21 -0800 (PST)
Date: Tue, 3 Nov 2020 09:34:19 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 07/38] virito-mem: Implement get_min_alignment()
Message-ID: <20201103142306.71782-8-mst@redhat.com>
References: <20201103142306.71782-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201103142306.71782-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 01:02:05
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
 David Hildenbrand <david@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Wei Yang <richardw.yang@linux.intel.com>, Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: David Hildenbrand <david@redhat.com>

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
Message-Id: <20201008083029.9504-7-david@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/virtio-mem-pci.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/virtio/virtio-mem-pci.c b/hw/virtio/virtio-mem-pci.c
index 913f4a3326..fa5395cd88 100644
--- a/hw/virtio/virtio-mem-pci.c
+++ b/hw/virtio/virtio-mem-pci.c
@@ -76,6 +76,12 @@ static void virtio_mem_pci_fill_device_info(const MemoryDeviceState *md,
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
@@ -110,6 +116,7 @@ static void virtio_mem_pci_class_init(ObjectClass *klass, void *data)
     mdc->get_plugged_size = virtio_mem_pci_get_plugged_size;
     mdc->get_memory_region = virtio_mem_pci_get_memory_region;
     mdc->fill_device_info = virtio_mem_pci_fill_device_info;
+    mdc->get_min_alignment = virtio_mem_pci_get_min_alignment;
 }
 
 static void virtio_mem_pci_instance_init(Object *obj)
-- 
MST


