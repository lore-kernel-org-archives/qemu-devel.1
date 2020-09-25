Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A2DFC4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 14:01:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 013CB208A9
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 14:01:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PyEDghOG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 013CB208A9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46406 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLoIH-0001zX-45
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 10:01:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36160)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1kLo9f-0007Y5-QI
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 09:53:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:20245)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1kLo9d-0001FQ-Qg
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 09:52:55 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601041969;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w4av3mu/X0bQUvY/Z1ZG8P/ZXnjDHHI0bCj1uOdx9N8=;
 b=PyEDghOGitirRu3E+YK3JaKBIy+N82IIlDEWgeLAg4mulf5E/FLfMRjTIcIvepZLmLhBWW
 jOwcHdnvywJfQtBqyHq980pGD5E89a+ArAi21U+VDvz6Ien/EtVWrSKh7xRU/TwQhwBGlU
 fZ0XynWIjwcipq0xk9bUD5wMygnXNog=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-574-jNENJJaYNgO-RBv7uw8YKg-1; Fri, 25 Sep 2020 09:52:47 -0400
X-MC-Unique: jNENJJaYNgO-RBv7uw8YKg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 97D4EAF20B;
 Fri, 25 Sep 2020 13:52:45 +0000 (UTC)
Received: from localhost (unknown [10.36.110.56])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 309E65C1C2;
 Fri, 25 Sep 2020 13:52:35 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Subject: [PATCH v2 5/6] spice: get monitors physical dimension
Date: Fri, 25 Sep 2020 17:50:56 +0400
Message-Id: <20200925135057.291556-6-marcandre.lureau@redhat.com>
In-Reply-To: <20200925135057.291556-1-marcandre.lureau@redhat.com>
References: <20200925135057.291556-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=marcandre.lureau@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/25 01:07:33
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
Cc: spice-devel@lists.freedesktop.org, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Note that for consistency, we use the same logic as MonitorsConfig to
figure out the associated monitor. However, I can't find traces of the
discussion/patches about the "new spice-server" behaviour: it still uses
the multiple-configurations path in git master.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 include/ui/console.h | 3 +++
 ui/spice-display.c   | 9 +++++++++
 2 files changed, 12 insertions(+)

diff --git a/include/ui/console.h b/include/ui/console.h
index 353d2e49a1..e7303d8b98 100644
--- a/include/ui/console.h
+++ b/include/ui/console.h
@@ -119,6 +119,9 @@ typedef struct DisplaySurface {
 } DisplaySurface;
 
 typedef struct QemuUIInfo {
+    /* physical dimension */
+    uint16_t width_mm;
+    uint16_t height_mm;
     /* geometry */
     int       xoff;
     int       yoff;
diff --git a/ui/spice-display.c b/ui/spice-display.c
index b304c13149..a10f72bc5c 100644
--- a/ui/spice-display.c
+++ b/ui/spice-display.c
@@ -679,7 +679,16 @@ static int interface_client_monitors_config(QXLInstance *sin,
         info.width  = mc->monitors[head].width;
         info.height = mc->monitors[head].height;
     }
+#if SPICE_SERVER_VERSION >= 0x000e04 /* release 0.14.4 */
+    if (mc->flags & VD_AGENT_CONFIG_MONITORS_FLAG_PHYSICAL_SIZE) {
+        VDAgentMonitorMM *mm = (void *)&mc->monitors[mc->num_of_monitors];
 
+        if (mc->num_of_monitors > head) {
+            info.width_mm = mm[head].width;
+            info.height_mm = mm[head].height;
+        }
+    }
+#endif
     trace_qemu_spice_ui_info(ssd->qxl.id, info.width, info.height);
     dpy_set_ui_info(ssd->dcl.con, &info);
     return 1;
-- 
2.26.2


