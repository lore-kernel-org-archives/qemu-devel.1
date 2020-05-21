Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C94FC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 05:04:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 035A52070A
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 05:04:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sendgrid.net header.i=@sendgrid.net header.b="fM/pXi3k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 035A52070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44824 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbdNJ-0000Bn-6c
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 01:04:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60028)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <bounces+16159052-3d09-qemu-devel=nongnu.org@sendgrid.net>)
 id 1jbdK6-0003Oa-IB
 for qemu-devel@nongnu.org; Thu, 21 May 2020 01:00:50 -0400
Received: from o1.dev.nutanix.com ([198.21.4.205]:46399)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <bounces+16159052-3d09-qemu-devel=nongnu.org@sendgrid.net>)
 id 1jbdK5-0001HL-9c
 for qemu-devel@nongnu.org; Thu, 21 May 2020 01:00:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sendgrid.net;
 h=from:subject:in-reply-to:references:to:cc:content-type:
 content-transfer-encoding;
 s=smtpapi; bh=ch/5JdiTmKgvL+Uvq0cHRGXtmNKqcmujc8lt8mLXMF4=;
 b=fM/pXi3kFVcDs2rpCoHzw1A/6A2iTGpEVkeleAMsqLMUp+21XFD9+1FLz7arT4SEM5RX
 gIlBhfG3o/UXKvA+9H+MtlhHrnLxTu/9pigh7IG1uKnoCdSH6/YuSk44mOeo5zn0LPWLhZ
 ERZRdofEQtPsZCY1/vZuAaxluYHwEiqoY=
Received: by filterdrecv-p3iad2-8ddf98858-mlrf4 with SMTP id
 filterdrecv-p3iad2-8ddf98858-mlrf4-17-5EC60AFF-49
 2020-05-21 05:00:47.291654359 +0000 UTC m=+4852395.040164021
Received: from localhost.localdomain.com (unknown)
 by ismtpd0026p1las1.sendgrid.net (SG) with ESMTP
 id PCWxhi9MQIO9N93uVls3ag Thu, 21 May 2020 05:00:47.090 +0000 (UTC)
From: Raphael Norwitz <raphael.norwitz@nutanix.com>
Subject: [PATCH v4 06/10] Refactor out libvhost-user fault generation logic
Date: Thu, 21 May 2020 05:00:47 +0000 (UTC)
Message-Id: <1588533678-23450-7-git-send-email-raphael.norwitz@nutanix.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1588533678-23450-1-git-send-email-raphael.norwitz@nutanix.com>
References: <1588533678-23450-1-git-send-email-raphael.norwitz@nutanix.com>
X-SG-EID: =?us-ascii?Q?YCLURHX+pjNDm1i7d69iKyMnQi=2FdvWah9veFa8nllaoUC0ScIWrCgiaWGu43Vg?=
 =?us-ascii?Q?xFdB4istXUBpN9H93OJgc8zadGtPi4MZIvnRTVm?=
 =?us-ascii?Q?=2FI=2FhBcU37PSP4M8LvU0QdTbon6fDAtS7Vd9LbqV?=
 =?us-ascii?Q?QPMUYHc6Gdnppe1tOO5Dl7Ys4jladeHQdGNs=2FIc?=
 =?us-ascii?Q?D98ge36X1g1tjz6w9R6ToW=2FzFR9RfmYqJpKNCd2?=
 =?us-ascii?Q?gToK8ztftp=2FuPAlDb+lVOMKOZ5QYBmPWKWumyLc?=
 =?us-ascii?Q?Zsl801SWUZtdDTh8Vckcg=3D=3D?=
To: qemu-devel@nongnu.org, mst@redhat.com, marcandre.lureau@redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=198.21.4.205;
 envelope-from=bounces+16159052-3d09-qemu-devel=nongnu.org@sendgrid.net;
 helo=o1.dev.nutanix.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/21 01:00:23
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: raphael.s.norwitz@gmail.com, marcandre.lureau@gmail.com,
 Raphael Norwitz <raphael.norwitz@nutanix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In libvhost-user, the incoming postcopy migration path for setting the
backend's memory tables has become convolued. In particular, moving the
logic which starts generating faults, having received the final ACK from
qemu can be moved to a separate function. This simplifies the code
substantially.

This logic will also be needed by the postcopy path once the
VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS feature is supported.

Signed-off-by: Raphael Norwitz <raphael.norwitz@nutanix.com>
---
 contrib/libvhost-user/libvhost-user.c | 147 ++++++++++++++++++----------------
 1 file changed, 79 insertions(+), 68 deletions(-)

diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-user/libvhost-user.c
index 3bca996..cccfa22 100644
--- a/contrib/libvhost-user/libvhost-user.c
+++ b/contrib/libvhost-user/libvhost-user.c
@@ -584,6 +584,84 @@ map_ring(VuDev *dev, VuVirtq *vq)
 }
 
 static bool
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
+static bool
 vu_set_mem_table_exec_postcopy(VuDev *dev, VhostUserMsg *vmsg)
 {
     int i;
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
1.8.3.1


