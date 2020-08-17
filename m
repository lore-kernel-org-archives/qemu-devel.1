Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55C46C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 12:02:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24B092067C
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 12:02:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ALC3OvFa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24B092067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60972 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7dq6-0006Gu-Ba
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 08:02:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60608)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1k7dpC-000575-FB
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 08:01:14 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:42473
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1k7dpA-0003f9-Bk
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 08:01:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597665671;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/SGi55q2jwB6TI3P6SfjHR5zRUnfzg+rtb4hqKPtTco=;
 b=ALC3OvFacbw5A4JOXeGoAwPFWwEo4YHIZ81xyvTCHwD7QQXehiOpniVMkr9HtRPcIU06cM
 kJZXHYlSjif2EXeUqHhzw6LjW5uINKf4p0JuQKPmg61t4uRv+joa1FJ2xaYgu/wl3xOtaF
 AdaMrHIDA/BKbU3KDOKGgJ+fPdHmZ84=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-281-eGBrfme3OsWr-sn8pEWbyQ-1; Mon, 17 Aug 2020 08:01:08 -0400
X-MC-Unique: eGBrfme3OsWr-sn8pEWbyQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 64014CF983
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2020 12:01:07 +0000 (UTC)
Received: from localhost (unknown [10.36.110.38])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 658385D9D2;
 Mon, 17 Aug 2020 12:01:06 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Subject: [PATCH 1/4] edid: use physical dimensions if available
Date: Mon, 17 Aug 2020 16:00:53 +0400
Message-Id: <20200817120056.56751-2-marcandre.lureau@redhat.com>
In-Reply-To: <20200817120056.56751-1-marcandre.lureau@redhat.com>
References: <20200817120056.56751-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=marcandre.lureau@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/17 03:34:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Add width_mm/height_mm to qemu_edid_info, and use it if it is
set (non-zero) to generate the EDID.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/display/edid-generate.c | 21 +++++++++++++--------
 include/hw/display/edid.h  |  2 ++
 2 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/hw/display/edid-generate.c b/hw/display/edid-generate.c
index e58472fde5..14cfb94447 100644
--- a/hw/display/edid-generate.c
+++ b/hw/display/edid-generate.c
@@ -205,12 +205,8 @@ static void edid_desc_dummy(uint8_t *desc)
 
 static void edid_desc_timing(uint8_t *desc,
                              uint32_t xres, uint32_t yres,
-                             uint32_t dpi)
+                             uint32_t xmm, uint32_t ymm)
 {
-    /* physical display size */
-    uint32_t xmm = xres * dpi / 254;
-    uint32_t ymm = yres * dpi / 254;
-
     /* pull some realistic looking timings out of thin air */
     uint32_t xfront = xres * 25 / 100;
     uint32_t xsync  = xres *  3 / 100;
@@ -296,6 +292,7 @@ void qemu_edid_generate(uint8_t *edid, size_t size,
     uint32_t desc = 54;
     uint8_t *xtra3 = NULL;
     uint8_t *dta = NULL;
+    uint32_t width_mm, height_mm;
 
     /* =============== set defaults  =============== */
 
@@ -314,6 +311,13 @@ void qemu_edid_generate(uint8_t *edid, size_t size,
     if (!info->prefy) {
         info->prefy = 768;
     }
+    if (info->width_mm && info->height_mm) {
+        width_mm = info->width_mm;
+        height_mm = info->height_mm;
+    } else {
+        width_mm = info->prefx * info->dpi / 254;
+        height_mm = info->prefy * info->dpi / 254;
+    }
 
     /* =============== extensions  =============== */
 
@@ -360,8 +364,8 @@ void qemu_edid_generate(uint8_t *edid, size_t size,
     edid[20] = 0xa5;
 
     /* screen size: undefined */
-    edid[21] = info->prefx * 254 / 100 / info->dpi;
-    edid[22] = info->prefy * 254 / 100 / info->dpi;
+    edid[21] = width_mm / 10;
+    edid[22] = height_mm / 10;
 
     /* display gamma: 2.2 */
     edid[23] = 220 - 100;
@@ -387,7 +391,8 @@ void qemu_edid_generate(uint8_t *edid, size_t size,
 
     /* =============== descriptor blocks =============== */
 
-    edid_desc_timing(edid + desc, info->prefx, info->prefy, info->dpi);
+    edid_desc_timing(edid + desc, info->prefx, info->prefy,
+                     width_mm, height_mm);
     desc += 18;
 
     edid_desc_ranges(edid + desc);
diff --git a/include/hw/display/edid.h b/include/hw/display/edid.h
index 5b1de57f24..f98b49a944 100644
--- a/include/hw/display/edid.h
+++ b/include/hw/display/edid.h
@@ -6,6 +6,8 @@ typedef struct qemu_edid_info {
     const char *name;
     const char *serial;
     uint32_t    dpi;
+    uint16_t    width_mm;
+    uint16_t    height_mm;
     uint32_t    prefx;
     uint32_t    prefy;
     uint32_t    maxx;
-- 
2.26.2


