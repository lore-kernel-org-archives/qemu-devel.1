Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 615ADC433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 07:32:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31A0B207C3
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 07:32:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31A0B207C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=winhong.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45522 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiYkB-0003jN-Ci
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 03:32:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40228)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yili@winhong.com>) id 1jiYil-0002vr-TQ
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 03:30:56 -0400
Received: from regular1.263xmail.com ([211.150.70.202]:58308)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yili@winhong.com>) id 1jiYig-0007E9-Lh
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 03:30:54 -0400
Received: from localhost (unknown [192.168.167.8])
 by regular1.263xmail.com (Postfix) with ESMTP id 7E82C43E
 for <qemu-devel@nongnu.org>; Tue,  9 Jun 2020 15:30:32 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-SKE-CHECKED: 1
X-ABS-CHECKED: 1
Received: from localhost.localdomain (unknown [14.18.236.69])
 by smtp.263.net (postfix) whith ESMTP id
 P14513T140696163952384S1591687825745897_; 
 Tue, 09 Jun 2020 15:30:32 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <248b8a305ae9aee3f8b1cdd569821f8e>
X-RL-SENDER: yili@winhong.com
X-SENDER: yili@winhong.com
X-LOGIN-NAME: yili@winhong.com
X-FST-TO: qemu-devel@nongnu.org
X-SENDER-IP: 14.18.236.69
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
X-System-Flag: 0
From: Yi Li <yili@winhong.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] rbd: Use RBD fast-diff for querying actual allocation
Date: Tue,  9 Jun 2020 15:30:01 +0800
Message-Id: <20200609073001.3668811-1-yili@winhong.com>
X-Mailer: git-send-email 2.25.3
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=211.150.70.202; envelope-from=yili@winhong.com;
 helo=regular1.263xmail.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 03:30:36
X-ACL-Warn: Detected OS   = ???
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
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
Cc: yilikernel@gmail.com, yili@winhong.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since Ceph version Infernalis (9.2.0) the new fast-diff mechanism
of RBD allows for querying actual rbd image usage.

Prior to this version there was no easy and fast way to query how
much allocation a RBD image had inside a Ceph cluster.

To use the fast-diff feature it needs to be enabled per RBD image
and is only supported by Ceph cluster running version Infernalis
(9.2.0) or newer.

Without the fast-diff feature enabled qemu-img will report an allocation
identical to the image capacity.

'qemu-img info rbd:cepharm/liyi-rbd' might output for example:

  image: json:{"driver": "raw", "file": {"pool": "cepharm",
  "image": "liyi-rbd", "driver": "rbd"}}
  file format: raw
  virtual size: 20 GiB (21474836480 bytes)
  disk size: 0 B
  cluster_size: 4194304

Newly created rbds will have the fast-diff feature enabled.

Signed-off-by: Yi Li <yili@winhong.com>
---
 block/rbd.c | 60 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/block/rbd.c b/block/rbd.c
index 617553b022..f231653f7b 100644
--- a/block/rbd.c
+++ b/block/rbd.c
@@ -1107,6 +1107,65 @@ static int64_t qemu_rbd_getlength(BlockDriverState *bs)
     return info.size;
 }
 
+#if LIBRBD_VERSION_CODE > 265
+static int disk_usage_callback(uint64_t offset, size_t len, int exists,
+                               void *arg)
+{
+  uint64_t *used_size = (uint64_t *)(arg);
+  if (exists) {
+    (*used_size) += len;
+  }
+  return 0;
+}
+#endif
+
+static int64_t qemu_rbd_allocated_file_size(BlockDriverState *bs)
+{
+    BDRVRBDState *s = bs->opaque;
+    rbd_image_info_t info;
+    int r;
+    uint64_t used_size = 0;
+    uint64_t features = 0;
+
+    r = rbd_stat(s->image, &info, sizeof(info));
+    if (r < 0) {
+        return r;
+    }
+
+    r = rbd_get_features(s->image, &features);
+    if (r < 0) {
+        return r;
+    }
+
+   /*
+    * rbd_diff_iterate2() is available in versions above Ceph 0.94 (Hammer)
+    * It uses a object map inside Ceph which is faster than rbd_diff_iterate()
+    * which iterates all objects.
+    * LIBRBD_VERSION_CODE for Ceph 0.94 is 265. In 266 and upwards diff_iterate2
+    * is available
+    */
+#if LIBRBD_VERSION_CODE > 265
+    if (features & RBD_FEATURE_FAST_DIFF) {
+
+        /*
+         * RBD image fast-diff feature enabled
+         * Querying for actual allocation.
+         */
+        r = rbd_diff_iterate2(s->image, NULL, 0, info.size, 0, 1,
+                              &disk_usage_callback,
+                              &used_size);
+        if (r < 0) {
+            return r;
+        }
+    } else {
+        used_size = info.size;
+    }
+#else
+    used_size = info.size;
+#endif
+    return used_size;
+}
+
 static int coroutine_fn qemu_rbd_co_truncate(BlockDriverState *bs,
                                              int64_t offset,
                                              bool exact,
@@ -1316,6 +1375,7 @@ static BlockDriver bdrv_rbd = {
     .bdrv_get_info          = qemu_rbd_getinfo,
     .create_opts            = &qemu_rbd_create_opts,
     .bdrv_getlength         = qemu_rbd_getlength,
+    .bdrv_get_allocated_file_size = qemu_rbd_allocated_file_size,
     .bdrv_co_truncate       = qemu_rbd_co_truncate,
     .protocol_name          = "rbd",
 
-- 
2.25.3




