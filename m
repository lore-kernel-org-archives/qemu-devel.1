Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F9DAC433E2
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 07:04:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B86A206D4
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 07:04:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cagvFsm3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B86A206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41816 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kE5lf-0005eu-7o
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 03:04:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58586)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kE5iv-00026B-Lk
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 03:01:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23663
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kE5it-0002KY-KM
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 03:01:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599202882;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BaguJ2WSzeibm8mZbk8IKzsTNlpI0vXc3Qjo2TYJ018=;
 b=cagvFsm3bMQ0SopSGysUQOoRswhvE9fCOl4z1M6/nb2cSqBHKnLD4BEhAEXaGXGKfEvCP0
 bSye0iZFG3EuvP3jTr0u7HZZEOJCOit0JeGEY8CLovD6WIuc/8ZuB0mMI+gsyA6seJ/xQ6
 V4w57LMm92xTc9e1iPL6erUcyaufwSE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-136-4rbTlfKuNkeICelIIyNq3Q-1; Fri, 04 Sep 2020 03:01:18 -0400
X-MC-Unique: 4rbTlfKuNkeICelIIyNq3Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A558E101962A;
 Fri,  4 Sep 2020 07:01:17 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-62.ams2.redhat.com
 [10.36.112.62])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4BB515D9D2;
 Fri,  4 Sep 2020 07:01:13 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 05FA0241; Fri,  4 Sep 2020 09:01:13 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 1/4] ui/gtk-gl-area: Plug memleak in gd_gl_area_create_context()
Date: Fri,  4 Sep 2020 09:01:09 +0200
Message-Id: <20200904070112.7315-2-kraxel@redhat.com>
In-Reply-To: <20200904070112.7315-1-kraxel@redhat.com>
References: <20200904070112.7315-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=kraxel@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/04 01:57:12
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: Pan Nengyuan <pannengyuan@huawei.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Euler Robot <euler.robot@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Pan Nengyuan <pannengyuan@huawei.com>

Receiving error in local variable err, and forgot to free it.
This patch check the return value of 'gdk_window_create_gl_context'
and 'gdk_gl_context_realize', then free err to fix it.

Reported-by: Euler Robot <euler.robot@huawei.com>
Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
Message-Id: <20200831134315.1221-6-pannengyuan@huawei.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 ui/gtk-gl-area.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/ui/gtk-gl-area.c b/ui/gtk-gl-area.c
index 85f9d14c51f1..98c22d23f501 100644
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
2.27.0


