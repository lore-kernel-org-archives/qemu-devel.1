Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7623C4742C
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 18:49:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55B0520780
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 18:49:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FKRwzjqq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55B0520780
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45330 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaNqX-0003vz-Al
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 13:49:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52216)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kaNj6-0000dh-Ts
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 13:41:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:60688)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kaNj4-0001wf-VX
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 13:41:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604515302;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=73Mpz3vICh9QEBEOeL5uEWGSphcZBjM+o5MkFyzWxeI=;
 b=FKRwzjqqzp5CYquKT6GYF8e4KWzsf9tK49h/Gkmi4me72JejXutLQn4PsGGqXRyXqJNEJd
 qGSHh6rHPqFswAJNqRqTDJ1jCe9qhBnTg81t4iDCG7OSJ2MFeT/RmwBo/Uyv0uPGoVLcI4
 E9XS7RHDB3RD4hxQLaclxO2mU0YCSlE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-490-LYVv4JK5MGmW5bIZheAGiQ-1; Wed, 04 Nov 2020 13:41:38 -0500
X-MC-Unique: LYVv4JK5MGmW5bIZheAGiQ-1
Received: by mail-wr1-f72.google.com with SMTP id m20so9617684wrb.21
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2020 10:41:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=73Mpz3vICh9QEBEOeL5uEWGSphcZBjM+o5MkFyzWxeI=;
 b=U8vXoSa7DFdmUpdfY6StBkpzY9O9LAJlwcERit5qrsCTp/RUCqsPRu7lsokTmKUqpt
 cLk2DqJfZnTmvO2dR23n1/hXy/67cspBLh6meVqDg+1CxDUVOLuwDd1FO/aVkJ85HroU
 Y7/l3jflYmp0jAo4t8nVcyQCNoY2dwxY5Wt5uQ2HDFnuDY1c6a9k+mia5dgCZfpToHik
 WcjxCoskIXLHSce41mB2/nxPvZCC2H+SJ9hFVf3FxBNi6jwRd7mtKWPLzjM/cih5Bu0P
 ATsDeEr025J8rceiWStw95B1qV8hDbiANWjFddip8pzplvUr9E97q/knchYEfjCiWxVh
 ldSQ==
X-Gm-Message-State: AOAM530CeVFdg6ewhzaMYZE+byjZmg6UI5xzy+bgO1u0BtPadAVAWL3W
 X36E5Jk0Cn2jAsRITNB+Ooprzjcn3wVEH6iL5XjKKvx/t+mGIBKJyITJqAFgo6bX9ImxijIEkzv
 XHogU3VLBWzXG5+M=
X-Received: by 2002:a1c:99d3:: with SMTP id b202mr6012003wme.0.1604515296581; 
 Wed, 04 Nov 2020 10:41:36 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwOphEw6zEwJnClQGThbqzu7B+GB3A+b245i3U2i8A9zmLcfdortit7vCjQsRtLY+jsG/0UyA==
X-Received: by 2002:a1c:99d3:: with SMTP id b202mr6011987wme.0.1604515296427; 
 Wed, 04 Nov 2020 10:41:36 -0800 (PST)
Received: from redhat.com (bzq-79-176-118-93.red.bezeqint.net. [79.176.118.93])
 by smtp.gmail.com with ESMTPSA id m1sm3342310wme.48.2020.11.04.10.41.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2020 10:41:35 -0800 (PST)
Date: Wed, 4 Nov 2020 13:41:33 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v3 06/31] memory-device: Add get_min_alignment() callback
Message-ID: <20201104184040.285057-7-mst@redhat.com>
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

Add a callback that can be used to express additional alignment
requirements (exceeding the ones from the memory region).

Will be used by virtio-mem to express special alignment requirements due
to manually configured, big block sizes (e.g., 1GB with an ordinary
memory-backend-ram). This avoids failing later when realizing, because
auto-detection wasn't able to assign a properly aligned address.

Reviewed-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Wei Yang <richardw.yang@linux.intel.com>
Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20201008083029.9504-6-david@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/mem/memory-device.h | 10 ++++++++++
 hw/mem/memory-device.c         | 11 +++++++++--
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/include/hw/mem/memory-device.h b/include/hw/mem/memory-device.h
index 30d7e99f52..48d2611fc5 100644
--- a/include/hw/mem/memory-device.h
+++ b/include/hw/mem/memory-device.h
@@ -88,6 +88,16 @@ struct MemoryDeviceClass {
      */
     MemoryRegion *(*get_memory_region)(MemoryDeviceState *md, Error **errp);
 
+    /*
+     * Optional: Return the desired minimum alignment of the device in guest
+     * physical address space. The final alignment is computed based on this
+     * alignment and the alignment requirements of the memory region.
+     *
+     * Called when plugging the memory device to detect the required alignment
+     * during address assignment.
+     */
+    uint64_t (*get_min_alignment)(const MemoryDeviceState *md);
+
     /*
      * Translate the memory device into #MemoryDeviceInfo.
      */
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
-- 
MST


