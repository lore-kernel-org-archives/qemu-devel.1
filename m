Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7967C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 12:28:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9232220825
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 12:28:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sendgrid.net header.i=@sendgrid.net header.b="LwrYJoZL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9232220825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nutanix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52824 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jb1MT-0004oY-L5
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 08:28:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51684)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <bounces+16159052-3d09-qemu-devel=nongnu.org@sendgrid.net>)
 id 1jb1Ja-00005F-7S
 for qemu-devel@nongnu.org; Tue, 19 May 2020 08:25:46 -0400
Received: from o1.dev.nutanix.com ([198.21.4.205]:37010)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <bounces+16159052-3d09-qemu-devel=nongnu.org@sendgrid.net>)
 id 1jb1JY-00038O-Lc
 for qemu-devel@nongnu.org; Tue, 19 May 2020 08:25:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sendgrid.net;
 h=from:subject:in-reply-to:references:to:cc:content-type:
 content-transfer-encoding;
 s=smtpapi; bh=ch/5JdiTmKgvL+Uvq0cHRGXtmNKqcmujc8lt8mLXMF4=;
 b=LwrYJoZLndOaENL74G/+sJJeuAVlN0ibbaJaXlnQoderZhxGUS2aobwborqNtU/XRIlP
 MDXt+y+I+dEMmY7b+ePoKnMh/1hPxT9FX1gIW9RBq6Se/SImummrNETqKKCcw4m3V8rnpS
 Y0FE2vwLgNaaDAjnt74zd2upIwFh9TAyM=
Received: by filterdrecv-p3iad2-8ddf98858-mlrf4 with SMTP id
 filterdrecv-p3iad2-8ddf98858-mlrf4-17-5EC3D045-31
 2020-05-19 12:25:41.600499812 +0000 UTC m=+4706289.349009473
Received: from localhost.localdomain.com (unknown)
 by ismtpd0002p1lon1.sendgrid.net (SG) with ESMTP
 id pmoYwUktQe-OK3lDLJGMqg Tue, 19 May 2020 12:25:41.321 +0000 (UTC)
From: Raphael Norwitz <raphael.norwitz@nutanix.com>
Subject: [PATCH v3 06/10] Refactor out libvhost-user fault generation logic
Date: Tue, 19 May 2020 12:25:41 +0000 (UTC)
Message-Id: <1588473683-27067-7-git-send-email-raphael.norwitz@nutanix.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1588473683-27067-1-git-send-email-raphael.norwitz@nutanix.com>
References: <1588473683-27067-1-git-send-email-raphael.norwitz@nutanix.com>
X-SG-EID: =?us-ascii?Q?YCLURHX+pjNDm1i7d69iKyMnQi=2FdvWah9veFa8nllaoUC0ScIWrCgiaWGu43Vg?=
 =?us-ascii?Q?xFdB4istXUBpN9H93OJgc8zcHs6ANfyz+yj7wQh?=
 =?us-ascii?Q?8uN2B1ngVHR9BoF3GXkiOVpe7YhVBycgTqGFCX0?=
 =?us-ascii?Q?ildLNMkTFuwuqNSJCzzzYq6OMyVEjEEKonlPcfd?=
 =?us-ascii?Q?jjwSn5=2F3fhRWEWp29KjCAWC=2FzaGRB=2FfWZwgqIEV?=
 =?us-ascii?Q?+nz4RBgAwynjAgZRYj4Taf1ucVkjvNiGISvwvZ6?=
 =?us-ascii?Q?X20Exladh46=2FF6M7wi18A=3D=3D?=
To: qemu-devel@nongnu.org, mst@redhat.com, marcandre.lureau@redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=198.21.4.205;
 envelope-from=bounces+16159052-3d09-qemu-devel=nongnu.org@sendgrid.net;
 helo=o1.dev.nutanix.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/19 08:25:15
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


