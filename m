Return-Path: <SRS0=+PsZ=7Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C147C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 15:15:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 268442081A
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2020 15:15:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SmwMXk87"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 268442081A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43704 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjlPE-0001Bo-CC
	for qemu-devel@archiver.kernel.org; Fri, 12 Jun 2020 11:15:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50374)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jjl2v-0008P3-Ky
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 10:52:41 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:42571
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jjl2s-0001XI-VO
 for qemu-devel@nongnu.org; Fri, 12 Jun 2020 10:52:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591973558;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BPZRKzdJHdjypDoBiRtFVPoYSHFJQu69zEdmNF7eHNU=;
 b=SmwMXk87YBcLqs0+4TriyDQoGF6qc+ahecw1HLwfGEA4YQzlhFBRTvfdcng3ABVLmmLNGP
 /5T2haFuoqzWkIhLL0I2fYnMoNi0yxr6RpV3BXr86Jv1ETjAtHn5K9QrdVpUww3wuopkFJ
 TXQoBrfQlRV4NeMk8QkBlLBVA7e0h4k=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-477-afHpztCENh2Akq1uIUW2Cw-1; Fri, 12 Jun 2020 10:52:36 -0400
X-MC-Unique: afHpztCENh2Akq1uIUW2Cw-1
Received: by mail-wm1-f69.google.com with SMTP id h6so2035961wmb.7
 for <qemu-devel@nongnu.org>; Fri, 12 Jun 2020 07:52:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=BPZRKzdJHdjypDoBiRtFVPoYSHFJQu69zEdmNF7eHNU=;
 b=d91NQFnK5QRYQ3UDwJ4XsZ6Nm6Q/v0yK4kZ7aRMwB9IZjJg6adZL1FTSSFTtZIVBjh
 lGWNkeSwybirv/DYemY9wS/ePBwozS4ZADW+ukALapfNCu2URsAdmFp7ZL1CKLbESFfM
 LLs5ms4NfjPHXxhPm84cVRN7wO9lQB7G0yaagtTK/Gf1AnPhqHjDeKM4TLRSUHfZfcnH
 ThHaUJ2jY11OEl+N8e+UJJtjt45ztvwfx3rw1o8zNTAAe5jZb1eUnz65Rx8JbrKIrLXP
 cLd5MCHWKq2sBH1cCizBkVWQDxFR5uNX3JJ5zjchRxGDsrlFNTEIF57CiMVRpEyyJb34
 6zew==
X-Gm-Message-State: AOAM533a2FQhchmwX53B7esS/kzAipESAK30S1pZ2IyB943enKuPd1HX
 /EIBSw5x0YBP3dEOGR1M04yFQdgLBbF2rXIsFsmTtVHnlYwgo7mNMp2vDebsBINXk1KLG13OK6n
 UXfJZcTu9u1ETFSk=
X-Received: by 2002:a1c:7d4c:: with SMTP id y73mr2822986wmc.188.1591973554834; 
 Fri, 12 Jun 2020 07:52:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyMkVAl+fxrGpcrP3gSfXmo7XQVYdcF3It5T/Oz+ccM9f7Wmmmd1fFwtI3vaxekI0OiV7sk7w==
X-Received: by 2002:a1c:7d4c:: with SMTP id y73mr2822973wmc.188.1591973554565; 
 Fri, 12 Jun 2020 07:52:34 -0700 (PDT)
Received: from redhat.com (bzq-79-178-18-124.red.bezeqint.net. [79.178.18.124])
 by smtp.gmail.com with ESMTPSA id c65sm9778316wme.8.2020.06.12.07.52.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2020 07:52:34 -0700 (PDT)
Date: Fri, 12 Jun 2020 10:52:32 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 41/58] Refactor out libvhost-user fault generation logic
Message-ID: <20200612141917.9446-42-mst@redhat.com>
References: <20200612141917.9446-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200612141917.9446-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/12 08:07:17
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
Cc: Johannes Berg <johannes.berg@intel.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
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


