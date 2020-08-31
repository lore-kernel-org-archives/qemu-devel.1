Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,
	DATE_IN_FUTURE_06_12,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F2EEC433E6
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 07:21:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2597720936
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 07:21:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2597720936
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48066 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCe8A-0001vC-8V
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 03:21:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54228)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pannengyuan@huawei.com>)
 id 1kCe49-0002dd-Vr
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 03:17:21 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:40252 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pannengyuan@huawei.com>)
 id 1kCe45-0005tF-HV
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 03:17:21 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 8E186DBBDF9FE29AF761;
 Mon, 31 Aug 2020 15:17:10 +0800 (CST)
Received: from opensource.huawei.com (10.175.100.152) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.487.0; Mon, 31 Aug 2020 15:17:01 +0800
From: Pan Nengyuan <pannengyuan@huawei.com>
To: <qemu-devel@nongnu.org>
Subject: [PATCH v2 05/10] ui/gtk-gl-area: Plug memleak in
 gd_gl_area_create_context()
Date: Mon, 31 Aug 2020 09:43:10 -0400
Message-ID: <20200831134315.1221-6-pannengyuan@huawei.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <20200831134315.1221-1-pannengyuan@huawei.com>
References: <20200831134315.1221-1-pannengyuan@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.100.152]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.32;
 envelope-from=pannengyuan@huawei.com; helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/31 03:17:11
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DATE_IN_FUTURE_06_12=1.947,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: kuhn.chenqun@huawei.com, Gerd
 Hoffmann <kraxel@redhat.com>, Pan Nengyuan <pannengyuan@huawei.com>,
 zhang.zhanghailiang@huawei.com, euler.robot@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Receiving error in local variable err, and forgot to free it.
This patch check the return value of 'gdk_window_create_gl_context'
and 'gdk_gl_context_realize', then free err to fix it.

Reported-by: Euler Robot <euler.robot@huawei.com>
Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
---
Cc: Gerd Hoffmann <kraxel@redhat.com>
---
V2->V1: check the return value of  'gdk_window_create_gl_context'
and 'gdk_gl_context_realize' instead of omitting it(Suggested by Li Qiang)
---
 ui/gtk-gl-area.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/ui/gtk-gl-area.c b/ui/gtk-gl-area.c
index 85f9d14c51..98c22d23f5 100644
--- a/ui/gtk-gl-area.c
+++ b/ui/gtk-gl-area.c
@@ -147,10 +147,21 @@ QEMUGLContext gd_gl_area_create_context(DisplayChangeListener *dcl,
     gtk_gl_area_make_current(GTK_GL_AREA(vc->gfx.drawing_area));
     window = gtk_widget_get_window(vc->gfx.drawing_area);
     ctx = gdk_window_create_gl_context(window, &err);
+    if (err) {
+        g_printerr("Create gdk gl context failed: %s\n", err->message);
+        g_error_free(err);
+        return NULL;
+    }
     gdk_gl_context_set_required_version(ctx,
                                         params->major_ver,
                                         params->minor_ver);
     gdk_gl_context_realize(ctx, &err);
+    if (err) {
+        g_printerr("Realize gdk gl context failed: %s\n", err->message);
+        g_error_free(err);
+        g_clear_object(&ctx);
+        return NULL;
+    }
     return ctx;
 }
 
-- 
2.18.2


