Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A5C2C2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 18:44:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73738206C1
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 18:44:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SV5YG5Lo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73738206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56414 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaNmA-0005FV-Fi
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 13:44:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52268)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kaNjD-0000pL-94
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 13:41:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:59405)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kaNjB-0001yq-HZ
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 13:41:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604515308;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NLAI6E52qR6iiwo+p5ybiNDvz6sVMxaw+nStvrHSOQ4=;
 b=SV5YG5LoeENTMt06x8N14NK7j6VgLNIK4/5hF3tYf8A4fJVvpe8mcFjAMvDW1xS6panCVI
 TRKIEHbIQd5IpOE+NXLAzHxvtY46xwOUtzPs6LmqW1hIWGFb6QdluBhQ0fqnas3fBB4tbz
 MI8EmaD12GvdCVg4YW+LkEyroFwfF/I=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-268-0qRGICcRM1G3sEs39zBbyA-1; Wed, 04 Nov 2020 13:41:40 -0500
X-MC-Unique: 0qRGICcRM1G3sEs39zBbyA-1
Received: by mail-wm1-f71.google.com with SMTP id 3so1548185wms.9
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2020 10:41:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=NLAI6E52qR6iiwo+p5ybiNDvz6sVMxaw+nStvrHSOQ4=;
 b=VHLT5ZDF0lkaGUKT4l0bXsKIo4HdonuyZWGBpXHFCxixPi+PhOsHTjGpO9Kj31J90P
 J8wEJX6Xt616Ri5Af6eArhd/yDmxwFilbVxPZG2ZlgI7f5qvYnQglUXyK22ATuYpnOk3
 mqV6bX6DnFV8gdTCNMzKauGI9UeV9mrjXIhJatUac/oHJ7Ru9XQfDdzYJs+Ceu2H+qs9
 nHfosW+dl8yCSX6fTN6T3w1cMYIHEaRNrPitirPiJ3bfpu2ebfCO98QCbUIMsJ54SRb+
 iymE2JG4sVMYZRgdCUWIj8Sdrp/tq4QsRkmkhfjCxS0KLOfpqQP/vGlNH10UGM4y9EA5
 dYuQ==
X-Gm-Message-State: AOAM533Q6UP6S7amh1zsjxXmvmlrdbGBGFT7pu4bQ1c0vU1TQsxXqkQG
 D8qO4t1PYDmJnnuKjDEQCyH47tpDU47yBfo3QgoLwlYY3Ldf5B9XmzgLsaYQT6/SvlPTs4Gfgwf
 DcKN9aTMyXEhpoEk=
X-Received: by 2002:adf:ab02:: with SMTP id q2mr24439237wrc.320.1604515299402; 
 Wed, 04 Nov 2020 10:41:39 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwM5pQcB2Q47JqsuCG9QhpSXhMQZKVpxhMqups1Yy5GG/jafRJHJxOH3PwEQjk7BnsZSp+8Qw==
X-Received: by 2002:adf:ab02:: with SMTP id q2mr24439222wrc.320.1604515299267; 
 Wed, 04 Nov 2020 10:41:39 -0800 (PST)
Received: from redhat.com (bzq-79-176-118-93.red.bezeqint.net. [79.176.118.93])
 by smtp.gmail.com with ESMTPSA id f8sm3703180wrt.88.2020.11.04.10.41.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2020 10:41:38 -0800 (PST)
Date: Wed, 4 Nov 2020 13:41:36 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v3 07/31] virito-mem: Implement get_min_alignment()
Message-ID: <20201104184040.285057-8-mst@redhat.com>
References: <20201104184040.285057-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201104184040.285057-1-mst@redhat.com>
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
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 22:09:52
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


