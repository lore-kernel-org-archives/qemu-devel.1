Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D4EDC4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 13:55:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBF14206C9
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 13:55:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ir8IhASS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBF14206C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54572 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLoCO-0001h2-EF
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 09:55:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35366)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1kLo6w-0003tm-1n
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 09:50:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43617)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1kLo6s-0000ps-0u
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 09:50:04 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601041798;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fLvjjbnseEvWZyZlxkrX+W1Hx+rNQ9Jg98KLgwjIUh0=;
 b=ir8IhASSfIG71X7ZkLp8wJzrmpD7klhPzoOvKNpE5GerdxbH8gp/RxQbD2lYJjGLE+wYuG
 Z65D3ifu8JFOnQe1MXCBo0Jvnr+U2ht6VdY3BUIv8C6oTEoIaDD2WUfiXq6o392tOuGY8l
 izfQpDhJqKVEiEd1aVFi+HBI1WnDh40=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-557-_u9TE8skM56EMqOW5PgM4Q-1; Fri, 25 Sep 2020 09:49:57 -0400
X-MC-Unique: _u9TE8skM56EMqOW5PgM4Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C183F1084C9E;
 Fri, 25 Sep 2020 13:49:55 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-113-81.ams2.redhat.com [10.36.113.81])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 742DE5D9DC;
 Fri, 25 Sep 2020 13:49:09 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, stefanha@redhat.com, fam@euphon.net,
 philmd@redhat.com, alex.williamson@redhat.com
Subject: [RFC 3/3] util/vfio-helpers: Rework the IOVA allocator to avoid IOVA
 reserved regions
Date: Fri, 25 Sep 2020 15:48:45 +0200
Message-Id: <20200925134845.21053-4-eric.auger@redhat.com>
In-Reply-To: <20200925134845.21053-1-eric.auger@redhat.com>
References: <20200925134845.21053-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eric.auger@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/25 02:48:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
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
Cc: lvivier@redhat.com, kwolf@redhat.com, cohuck@redhat.com, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 util/vfio-helpers.c | 55 +++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 51 insertions(+), 4 deletions(-)

diff --git a/util/vfio-helpers.c b/util/vfio-helpers.c
index 567bcf1ded..c98d0d882e 100644
--- a/util/vfio-helpers.c
+++ b/util/vfio-helpers.c
@@ -676,6 +676,48 @@ static bool qemu_vfio_verify_mappings(QEMUVFIOState *s)
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
+        if (s->usable_iova_ranges[i].end - s->low_water_mark + 1 >= size) {
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
+        if (s->high_water_mark - s->usable_iova_ranges[i].start + 1 >= size) {
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
@@ -702,7 +744,11 @@ int qemu_vfio_dma_map(QEMUVFIOState *s, void *host, size_t size,
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
@@ -714,15 +760,16 @@ int qemu_vfio_dma_map(QEMUVFIOState *s, void *host, size_t size,
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


