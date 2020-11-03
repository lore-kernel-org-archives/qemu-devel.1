Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9BF3C2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 14:41:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A38F2054F
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 14:41:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QUCF3kR8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A38F2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34552 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZxVJ-0004MV-65
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 09:41:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:32936)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kZxOF-0003tn-N4
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 09:34:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:34122)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kZxOD-0006Kf-Q3
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 09:34:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604414064;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=73Mpz3vICh9QEBEOeL5uEWGSphcZBjM+o5MkFyzWxeI=;
 b=QUCF3kR8X6dV29s5VM/SJpo1HzCsGUOitzcppHIwgqLFC6lR+Tvnl/ddHcncI6wZcTUV5k
 kzTnEpWMT34BGdeJStwX7w+9tdvQ02vy5bdJhRvFLGI+aVScdwFoYdC0IkY/StwbU3zijk
 JYQfKNS/JeyuNFIBJ7rQlaMKtuHVFQU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-236-izI3nhs_OUmQKGHTzrZ9vw-1; Tue, 03 Nov 2020 09:34:22 -0500
X-MC-Unique: izI3nhs_OUmQKGHTzrZ9vw-1
Received: by mail-wr1-f70.google.com with SMTP id m20so7902707wrb.21
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2020 06:34:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=73Mpz3vICh9QEBEOeL5uEWGSphcZBjM+o5MkFyzWxeI=;
 b=DTCrUFu9iwokP0jBmqKLfMyi4c55Ch063ZL5IUBFD1lC+t8SEWOZ3f6qVTiUJeH+2y
 vp2z8gWykZCX/HtiBRF44X4eqlggIEf5lcdDqPmLF7WJG1wUug+GQCOca7qPKvf2rle0
 JErtzOOqOLVbvCETKufV0XjIEPfAu7TsL14dlL7ADV7dnG8s15dO5ldvRyBWneThuSzu
 12i+z/qEjnVkj7V0R1brlblUHgNqqAZ5mTBp1A2euh4zDOl0hpmQfrMWgbnQSbwdjM4L
 noxneSjmgNvhx7clQJYTYR92qMyI36EJJxlY4xFk74vyI6Ag8aPeI4dzKLf/92/TcqDp
 ZciA==
X-Gm-Message-State: AOAM532b9PveQ7E3Q6wUAZggc6auWYw7EYSA+E5GDTrF7CZYxNvw4Ssk
 rMYnjylcmQHLRlL/M76INVsUbTfH6sz9Q6rRZXdoCWleRq+7g5JhHPxO4POuO69ygZExo3/gfE1
 SkSZYEOsVtfXFeIc=
X-Received: by 2002:a1c:6355:: with SMTP id x82mr2996wmb.177.1604414059400;
 Tue, 03 Nov 2020 06:34:19 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwwehOhhxX92t6WHcMnh72YlZ6mLyzC7XCcu6K7unY+bgsEConpgt0c4SXjzYSbtIPxQcC3Jg==
X-Received: by 2002:a1c:6355:: with SMTP id x82mr2976wmb.177.1604414059191;
 Tue, 03 Nov 2020 06:34:19 -0800 (PST)
Received: from redhat.com (bzq-79-176-118-93.red.bezeqint.net. [79.176.118.93])
 by smtp.gmail.com with ESMTPSA id y185sm3040543wmb.29.2020.11.03.06.34.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2020 06:34:18 -0800 (PST)
Date: Tue, 3 Nov 2020 09:34:16 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 06/38] memory-device: Add get_min_alignment() callback
Message-ID: <20201103142306.71782-7-mst@redhat.com>
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


