Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FD6AC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 04:55:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 295D42072E
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 04:55:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FJjIa3qR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 295D42072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44800 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jislY-00060t-C7
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 00:55:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34200)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jisLU-0001Hc-C1
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 00:28:12 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:33704
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jisLT-0008Lw-4h
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 00:28:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591763290;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BPZRKzdJHdjypDoBiRtFVPoYSHFJQu69zEdmNF7eHNU=;
 b=FJjIa3qREH1Lz2wutLPR2cz+l/9BqUVcScMkXUkedyWGyn3YPqXJeRngEFjRBe80CV5gwG
 8vij5B7lLk9lSG4VDdpNszVb1voOc6KEFJSPdRoF3f0TYZZ+ualhM+DjdRktvI/vpTwnVq
 FedJJDMgPx5aG9yZQsGl1//13sYCX5Q=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-2-R6z-BUtWMdi2TBSPoAnkRw-1; Wed, 10 Jun 2020 00:28:08 -0400
X-MC-Unique: R6z-BUtWMdi2TBSPoAnkRw-1
Received: by mail-wm1-f72.google.com with SMTP id a7so74090wmf.1
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 21:28:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=BPZRKzdJHdjypDoBiRtFVPoYSHFJQu69zEdmNF7eHNU=;
 b=Vo6t3Rcz0pPNp8qD6L/ClLBwIy/Bl14U1Wett7gpwBazscyYWDAUU0R7Pb0KKugmV5
 xpJWkfXJb2jSio9O+3YlZQpl1R1djNl6aCL2iFskLeOJ+rwJknT5W/EIxjlzCVTs8Y6x
 V8qNQRisZK5fmL6HNHBLRQ6LpAuQHfK8zeNKCokcIMj1GWrWuffa8CSpT/RBiESXSIv5
 kTn3S+wWkRgHQyS7RKwrnSe71fprgFZLLz8QqWYJ20xhjIg5MCZ7smpwWCFFrJSvUdJN
 j/qWAvYI4QwhPqDRek0k9piOXuWQu+m+0Oj9uM3W2n+5WfUehblKs4YC192ORoBaERx3
 RrlA==
X-Gm-Message-State: AOAM531VhD+r6yLOQgYfNbe+vQJLJYdGlPd1hZwTJ9JGXA82Kvdgc8kA
 +RiYh8hLd3Eb/9UlCIeUlg9LhXnApiRYRN39V1MR27wTboc1n5Y6zielzZIYW1kma5hEQs7GWoi
 pkU4G7rfuG3EKTOs=
X-Received: by 2002:adf:fb92:: with SMTP id a18mr1317501wrr.263.1591763286624; 
 Tue, 09 Jun 2020 21:28:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyA0I/oUGfjZcLgz3L4GZcQ47Wi9gLvT0S7ybNiP1n/L+ymahUjY2s7XxB9/MNPjSFhN4+h9w==
X-Received: by 2002:adf:fb92:: with SMTP id a18mr1317479wrr.263.1591763286304; 
 Tue, 09 Jun 2020 21:28:06 -0700 (PDT)
Received: from redhat.com (bzq-79-181-55-232.red.bezeqint.net. [79.181.55.232])
 by smtp.gmail.com with ESMTPSA id i3sm6176454wrm.83.2020.06.09.21.28.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2020 21:28:05 -0700 (PDT)
Date: Wed, 10 Jun 2020 00:28:04 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 41/56] Refactor out libvhost-user fault generation logic
Message-ID: <20200610042613.1459309-42-mst@redhat.com>
References: <20200610042613.1459309-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200610042613.1459309-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 23:51:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 Stefan Hajnoczi <stefanha@redhat.com>, Johannes Berg <johannes.berg@intel.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Raphael Norwitz <raphael.norwitz@nutanix.com>

In libvhost-user, the incoming postcopy migration path for setting the
backend's memory tables has become convolued. In particular, moving the
logic which starts generating faults, having received the final ACK from
qemu can be moved to a separate function. This simplifies the code
substantially.

This logic will also be needed by the postcopy path once the
VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS feature is supported.

Signed-off-by: Raphael Norwitz <raphael.norwitz@nutanix.com>
Message-Id: <1588533678-23450-7-git-send-email-raphael.norwitz@nutanix.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 contrib/libvhost-user/libvhost-user.c | 147 ++++++++++++++------------
 1 file changed, 79 insertions(+), 68 deletions(-)

diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-user/libvhost-user.c
index 3bca996c62..cccfa22209 100644
--- a/contrib/libvhost-user/libvhost-user.c
+++ b/contrib/libvhost-user/libvhost-user.c
@@ -583,6 +583,84 @@ map_ring(VuDev *dev, VuVirtq *vq)
     return !(vq->vring.desc && vq->vring.used && vq->vring.avail);
 }
 
+static bool
+generate_faults(VuDev *dev) {
+    int i;
+    for (i = 0; i < dev->nregions; i++) {
+        VuDevRegion *dev_region = &dev->regions[i];
+        int ret;
+#ifdef UFFDIO_REGISTER
+        /*
+         * We should already have an open ufd. Mark each memory
+         * range as ufd.
+         * Discard any mapping we have here; note I can't use MADV_REMOVE
+         * or fallocate to make the hole since I don't want to lose
+         * data that's already arrived in the shared process.
+         * TODO: How to do hugepage
+         */
+        ret = madvise((void *)(uintptr_t)dev_region->mmap_addr,
+                      dev_region->size + dev_region->mmap_offset,
+                      MADV_DONTNEED);
+        if (ret) {
+            fprintf(stderr,
+                    "%s: Failed to madvise(DONTNEED) region %d: %s\n",
+                    __func__, i, strerror(errno));
+        }
+        /*
+         * Turn off transparent hugepages so we dont get lose wakeups
+         * in neighbouring pages.
+         * TODO: Turn this backon later.
+         */
+        ret = madvise((void *)(uintptr_t)dev_region->mmap_addr,
+                      dev_region->size + dev_region->mmap_offset,
+                      MADV_NOHUGEPAGE);
+        if (ret) {
+            /*
+             * Note: This can happen legally on kernels that are configured
+             * without madvise'able hugepages
+             */
+            fprintf(stderr,
+                    "%s: Failed to madvise(NOHUGEPAGE) region %d: %s\n",
+                    __func__, i, strerror(errno));
+        }
+        struct uffdio_register reg_struct;
+        reg_struct.range.start = (uintptr_t)dev_region->mmap_addr;
+        reg_struct.range.len = dev_region->size + dev_region->mmap_offset;
+        reg_struct.mode = UFFDIO_REGISTER_MODE_MISSING;
+
+        if (ioctl(dev->postcopy_ufd, UFFDIO_REGISTER, &reg_struct)) {
+            vu_panic(dev, "%s: Failed to userfault region %d "
+                          "@%p + size:%zx offset: %zx: (ufd=%d)%s\n",
+                     __func__, i,
+                     dev_region->mmap_addr,
+                     dev_region->size, dev_region->mmap_offset,
+                     dev->postcopy_ufd, strerror(errno));
+            return false;
+        }
+        if (!(reg_struct.ioctls & ((__u64)1 << _UFFDIO_COPY))) {
+            vu_panic(dev, "%s Region (%d) doesn't support COPY",
+                     __func__, i);
+            return false;
+        }
+        DPRINT("%s: region %d: Registered userfault for %"
+               PRIx64 " + %" PRIx64 "\n", __func__, i,
+               (uint64_t)reg_struct.range.start,
+               (uint64_t)reg_struct.range.len);
+        /* Now it's registered we can let the client at it */
+        if (mprotect((void *)(uintptr_t)dev_region->mmap_addr,
+                     dev_region->size + dev_region->mmap_offset,
+                     PROT_READ | PROT_WRITE)) {
+            vu_panic(dev, "failed to mprotect region %d for postcopy (%s)",
+                     i, strerror(errno));
+            return false;
+        }
+        /* TODO: Stash 'zero' support flags somewhere */
+#endif
+    }
+
+    return true;
+}
+
 static bool
 vu_set_mem_table_exec_postcopy(VuDev *dev, VhostUserMsg *vmsg)
 {
@@ -655,74 +733,7 @@ vu_set_mem_table_exec_postcopy(VuDev *dev, VhostUserMsg *vmsg)
     }
 
     /* OK, now we can go and register the memory and generate faults */
-    for (i = 0; i < dev->nregions; i++) {
-        VuDevRegion *dev_region = &dev->regions[i];
-        int ret;
-#ifdef UFFDIO_REGISTER
-        /* We should already have an open ufd. Mark each memory
-         * range as ufd.
-         * Discard any mapping we have here; note I can't use MADV_REMOVE
-         * or fallocate to make the hole since I don't want to lose
-         * data that's already arrived in the shared process.
-         * TODO: How to do hugepage
-         */
-        ret = madvise((void *)(uintptr_t)dev_region->mmap_addr,
-                      dev_region->size + dev_region->mmap_offset,
-                      MADV_DONTNEED);
-        if (ret) {
-            fprintf(stderr,
-                    "%s: Failed to madvise(DONTNEED) region %d: %s\n",
-                    __func__, i, strerror(errno));
-        }
-        /* Turn off transparent hugepages so we dont get lose wakeups
-         * in neighbouring pages.
-         * TODO: Turn this backon later.
-         */
-        ret = madvise((void *)(uintptr_t)dev_region->mmap_addr,
-                      dev_region->size + dev_region->mmap_offset,
-                      MADV_NOHUGEPAGE);
-        if (ret) {
-            /* Note: This can happen legally on kernels that are configured
-             * without madvise'able hugepages
-             */
-            fprintf(stderr,
-                    "%s: Failed to madvise(NOHUGEPAGE) region %d: %s\n",
-                    __func__, i, strerror(errno));
-        }
-        struct uffdio_register reg_struct;
-        reg_struct.range.start = (uintptr_t)dev_region->mmap_addr;
-        reg_struct.range.len = dev_region->size + dev_region->mmap_offset;
-        reg_struct.mode = UFFDIO_REGISTER_MODE_MISSING;
-
-        if (ioctl(dev->postcopy_ufd, UFFDIO_REGISTER, &reg_struct)) {
-            vu_panic(dev, "%s: Failed to userfault region %d "
-                          "@%p + size:%zx offset: %zx: (ufd=%d)%s\n",
-                     __func__, i,
-                     dev_region->mmap_addr,
-                     dev_region->size, dev_region->mmap_offset,
-                     dev->postcopy_ufd, strerror(errno));
-            return false;
-        }
-        if (!(reg_struct.ioctls & ((__u64)1 << _UFFDIO_COPY))) {
-            vu_panic(dev, "%s Region (%d) doesn't support COPY",
-                     __func__, i);
-            return false;
-        }
-        DPRINT("%s: region %d: Registered userfault for %"
-               PRIx64 " + %" PRIx64 "\n", __func__, i,
-               (uint64_t)reg_struct.range.start,
-               (uint64_t)reg_struct.range.len);
-        /* Now it's registered we can let the client at it */
-        if (mprotect((void *)(uintptr_t)dev_region->mmap_addr,
-                     dev_region->size + dev_region->mmap_offset,
-                     PROT_READ | PROT_WRITE)) {
-            vu_panic(dev, "failed to mprotect region %d for postcopy (%s)",
-                     i, strerror(errno));
-            return false;
-        }
-        /* TODO: Stash 'zero' support flags somewhere */
-#endif
-    }
+    (void)generate_faults(dev);
 
     return false;
 }
-- 
MST


