Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 893C2C4346E
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 08:59:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CF56206DC
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 08:59:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ot5MiPe8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CF56206DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39814 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNBU0-0004rO-3n
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 04:59:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52770)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1kNBQs-0000xQ-6J
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 04:56:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24962)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1kNBQq-0000GH-LN
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 04:56:21 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601369779;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JNg0jJ8QHbPOvKUGkvHLxcaUNNqbmVByG1qEKoxw+k8=;
 b=Ot5MiPe8gzj672AUhnbbeAD99/ahqWMqepazjKxgnJWD8TsHA7xe7ims244NXwZSVVcTf6
 95Q5cMY24lDsb10PsZHKSA1JRLN8RPJ0g5Zn1Ii2ZyzVSgu7vWu6FbO0VLgqht3rwgx7Nt
 nxU0iAxdY049RhYzK7B+PoeNUWCa9qY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-61-_y3SV-8SMDKI2kXAVy9ZYA-1; Tue, 29 Sep 2020 04:56:14 -0400
X-MC-Unique: _y3SV-8SMDKI2kXAVy9ZYA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0A7559CC08;
 Tue, 29 Sep 2020 08:56:13 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-113-210.ams2.redhat.com [10.36.113.210])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5956055773;
 Tue, 29 Sep 2020 08:56:10 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, stefanha@redhat.com, fam@euphon.net,
 philmd@redhat.com, alex.williamson@redhat.com
Subject: [PATCH v2 2/2] util/vfio-helpers: Rework the IOVA allocator to avoid
 IOVA reserved regions
Date: Tue, 29 Sep 2020 10:55:50 +0200
Message-Id: <20200929085550.30926-3-eric.auger@redhat.com>
In-Reply-To: <20200929085550.30926-1-eric.auger@redhat.com>
References: <20200929085550.30926-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eric.auger@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/29 02:22:44
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: lvivier@redhat.com, kwolf@redhat.com, cohuck@redhat.com, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Introduce the qemu_vfio_find_fixed/temp_iova helpers which
respectively allocate IOVAs from the bottom/top parts of the
usable IOVA range, without picking within host IOVA reserved
windows. The allocation remains basic: if the size is too big
for the remaining of the current usable IOVA range, we jump
to the next one, leaving a hole in the address map.

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---

v1 -> v2:
- handle possible wrap
---
 util/vfio-helpers.c | 57 +++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 53 insertions(+), 4 deletions(-)

diff --git a/util/vfio-helpers.c b/util/vfio-helpers.c
index ba0ee6e21c..71145970f3 100644
--- a/util/vfio-helpers.c
+++ b/util/vfio-helpers.c
@@ -667,6 +667,50 @@ static bool qemu_vfio_verify_mappings(QEMUVFIOState *s)
     return true;
 }
 
+static int
+qemu_vfio_find_fixed_iova(QEMUVFIOState *s, size_t size, uint64_t *iova)
+{
+    int i;
+
+    for (i = 0; i < s->nb_iova_ranges; i++) {
+        if (s->usable_iova_ranges[i].end < s->low_water_mark) {
+            continue;
+        }
+        s->low_water_mark =
+            MAX(s->low_water_mark, s->usable_iova_ranges[i].start);
+
+        if (s->usable_iova_ranges[i].end - s->low_water_mark + 1 >= size ||
+            s->usable_iova_ranges[i].end - s->low_water_mark + 1 == 0) {
+            *iova = s->low_water_mark;
+            s->low_water_mark += size;
+            return 0;
+        }
+    }
+    return -ENOMEM;
+}
+
+static int
+qemu_vfio_find_temp_iova(QEMUVFIOState *s, size_t size, uint64_t *iova)
+{
+    int i;
+
+    for (i = s->nb_iova_ranges - 1; i >= 0; i--) {
+        if (s->usable_iova_ranges[i].start > s->high_water_mark) {
+            continue;
+        }
+        s->high_water_mark =
+            MIN(s->high_water_mark, s->usable_iova_ranges[i].end + 1);
+
+        if (s->high_water_mark - s->usable_iova_ranges[i].start + 1 >= size ||
+            s->high_water_mark - s->usable_iova_ranges[i].start + 1 == 0) {
+            *iova = s->high_water_mark - size;
+            s->high_water_mark = *iova;
+            return 0;
+        }
+    }
+    return -ENOMEM;
+}
+
 /* Map [host, host + size) area into a contiguous IOVA address space, and store
  * the result in @iova if not NULL. The caller need to make sure the area is
  * aligned to page size, and mustn't overlap with existing mapping areas (split
@@ -693,7 +737,11 @@ int qemu_vfio_dma_map(QEMUVFIOState *s, void *host, size_t size,
             goto out;
         }
         if (!temporary) {
-            iova0 = s->low_water_mark;
+            if (qemu_vfio_find_fixed_iova(s, size, &iova0)) {
+                ret = -ENOMEM;
+                goto out;
+            }
+
             mapping = qemu_vfio_add_mapping(s, host, size, index + 1, iova0);
             if (!mapping) {
                 ret = -ENOMEM;
@@ -705,15 +753,16 @@ int qemu_vfio_dma_map(QEMUVFIOState *s, void *host, size_t size,
                 qemu_vfio_undo_mapping(s, mapping, NULL);
                 goto out;
             }
-            s->low_water_mark += size;
             qemu_vfio_dump_mappings(s);
         } else {
-            iova0 = s->high_water_mark - size;
+            if (qemu_vfio_find_temp_iova(s, size, &iova0)) {
+                ret = -ENOMEM;
+                goto out;
+            }
             ret = qemu_vfio_do_mapping(s, host, size, iova0);
             if (ret) {
                 goto out;
             }
-            s->high_water_mark -= size;
         }
     }
     if (iova) {
-- 
2.21.3


