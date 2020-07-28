Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 130E7C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 18:39:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D47F120786
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 18:39:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WwXxJhDS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D47F120786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34268 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0UVZ-0001KY-3Z
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 14:39:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45698)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1k0UUN-00082j-22
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 14:38:11 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43715
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1k0UUL-0005Om-GS
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 14:38:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595961488;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=zrEIrVvtKcJBx3a3UhBSl61oVCnyNTvsVQLA8e8lV3w=;
 b=WwXxJhDS4RSPYSkfnPQVoStr/qeGrviTGB4cQ6o+ZJtRVAYmD/v/Oj9MBKWjzqACiACNov
 qSBbIsbgmpccCTkLhMCP8RlU6wsLLl2e1KQHlxk88gbcfftsYDB8HblUhZ/EXJLVjfIGiE
 9805lo/5+KzfTiwndwPViu40Jq/YPa0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-400-FBGxgYUNOFuC7zS6lNnkNg-1; Tue, 28 Jul 2020 14:38:04 -0400
X-MC-Unique: FBGxgYUNOFuC7zS6lNnkNg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9EA291005504;
 Tue, 28 Jul 2020 18:38:02 +0000 (UTC)
Received: from thuth.com (ovpn-112-56.ams2.redhat.com [10.36.112.56])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E8ADE60BF4;
 Tue, 28 Jul 2020 18:37:56 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-s390x@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH for-5.2 3/6] pc-bios/s390-ccw: Move the inner logic of
 find_subch() to a separate function
Date: Tue, 28 Jul 2020 20:37:31 +0200
Message-Id: <20200728183734.7838-4-thuth@redhat.com>
In-Reply-To: <20200728183734.7838-1-thuth@redhat.com>
References: <20200728183734.7838-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=205.139.110.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/28 10:31:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=unavailable autolearn_force=no
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
Cc: "Jason J . Herne" <jjherne@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Janosch Frank <frankja@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 Collin Walling <walling@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Move the code to a separate function to be able to re-use it from a
different spot later.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 pc-bios/s390-ccw/main.c | 99 ++++++++++++++++++++++++-----------------
 1 file changed, 57 insertions(+), 42 deletions(-)

diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
index 9b64eb0c24..9477313188 100644
--- a/pc-bios/s390-ccw/main.c
+++ b/pc-bios/s390-ccw/main.c
@@ -51,6 +51,60 @@ unsigned int get_loadparm_index(void)
     return atoui(loadparm_str);
 }
 
+static int check_sch_no(int dev_no, int sch_no)
+{
+    bool is_virtio;
+    Schib schib;
+    int r;
+
+    blk_schid.sch_no = sch_no;
+    r = stsch_err(blk_schid, &schib);
+    if (r == 3 || r == -EIO) {
+        return -EIO;
+    }
+    if (!schib.pmcw.dnv) {
+        return false;
+    }
+
+    enable_subchannel(blk_schid);
+    cutype = cu_type(blk_schid);
+
+    /*
+     * Note: we always have to run virtio_is_supported() here to make
+     * sure that the vdev.senseid data gets pre-initialized correctly
+     */
+    is_virtio = virtio_is_supported(blk_schid);
+
+    /* No specific devno given, just return 1st possibly bootable device */
+    if (dev_no < 0) {
+        switch (cutype) {
+        case CU_TYPE_VIRTIO:
+            if (is_virtio) {
+                /*
+                 * Skip net devices since no IPLB is created and therefore
+                 * no network bootloader has been loaded
+                 */
+                if (virtio_get_device_type() != VIRTIO_ID_NET) {
+                    return true;
+                }
+            }
+            return false;
+        case CU_TYPE_DASD_3990:
+        case CU_TYPE_DASD_2107:
+            return true;
+        default:
+            return false;
+        }
+    }
+
+    /* Caller asked for a specific devno */
+    if (schib.pmcw.dev == dev_no) {
+        return true;
+    }
+
+    return false;
+}
+
 /*
  * Find the subchannel connected to the given device (dev_no) and fill in the
  * subchannel information block (schib) with the connected subchannel's info.
@@ -62,53 +116,14 @@ unsigned int get_loadparm_index(void)
  */
 static bool find_subch(int dev_no)
 {
-    Schib schib;
     int i, r;
-    bool is_virtio;
 
     for (i = 0; i < 0x10000; i++) {
-        blk_schid.sch_no = i;
-        r = stsch_err(blk_schid, &schib);
-        if ((r == 3) || (r == -EIO)) {
+        r = check_sch_no(dev_no, i);
+        if (r < 0) {
             break;
         }
-        if (!schib.pmcw.dnv) {
-            continue;
-        }
-
-        enable_subchannel(blk_schid);
-        cutype = cu_type(blk_schid);
-
-        /*
-         * Note: we always have to run virtio_is_supported() here to make
-         * sure that the vdev.senseid data gets pre-initialized correctly
-         */
-        is_virtio = virtio_is_supported(blk_schid);
-
-        /* No specific devno given, just return 1st possibly bootable device */
-        if (dev_no < 0) {
-            switch (cutype) {
-            case CU_TYPE_VIRTIO:
-                if (is_virtio) {
-                    /*
-                     * Skip net devices since no IPLB is created and therefore
-                     * no network bootloader has been loaded
-                     */
-                    if (virtio_get_device_type() != VIRTIO_ID_NET) {
-                        return true;
-                    }
-                }
-                continue;
-            case CU_TYPE_DASD_3990:
-            case CU_TYPE_DASD_2107:
-                return true;
-            default:
-                continue;
-            }
-        }
-
-        /* Caller asked for a specific devno */
-        if (schib.pmcw.dev == dev_no) {
+        if (r == true) {
             return true;
         }
     }
-- 
2.18.1


