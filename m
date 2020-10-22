Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB801C388F9
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 05:18:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 566E72145D
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 05:18:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KxFfQCUO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 566E72145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52872 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVSzQ-0003ny-88
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 01:18:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33118)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kVSuB-0003qI-DR
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 01:12:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:56247)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kVSu6-0003z3-Ea
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 01:12:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603343563;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EHE9b9eKVG1dzNaFL1EsNVc3kfeOK24WmnbkwRy//wk=;
 b=KxFfQCUOqwmq2xfWbS5Y58Yk3cLrdygs85p6uDeUZphmmfjpB5udlLvLAEXhMM9dRXsBp4
 JIUgnH4uC05u+si8Q8GtdSzC0fSzMG7C/fnMEShsl9aPQmhqJhcIb46RjS+2IBz4ZEftHa
 zhPQ9E2QyBAoGXNrYSmTBgbw06kUA1U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-492-66_aL5dYNryDdnAoz6cUVw-1; Thu, 22 Oct 2020 01:12:41 -0400
X-MC-Unique: 66_aL5dYNryDdnAoz6cUVw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 49465186DD29
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2020 05:12:40 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-114-66.ams2.redhat.com
 [10.36.114.66])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A08305B4B8;
 Thu, 22 Oct 2020 05:12:31 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 21AEF204AD; Thu, 22 Oct 2020 07:12:24 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 14/14] opengl: build opengl helper code modular
Date: Thu, 22 Oct 2020 07:12:23 +0200
Message-Id: <20201022051223.6181-15-kraxel@redhat.com>
In-Reply-To: <20201022051223.6181-1-kraxel@redhat.com>
References: <20201022051223.6181-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/21 23:30:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Removes opengl dependency from core qemu.  The number of shared
libraries for qemu-system-x86_64 goes down from 66 to 60 on my system.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-id: 20201019075224.14803-15-kraxel@redhat.com
---
 util/module.c  | 7 +++++++
 ui/meson.build | 8 +++++++-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/util/module.c b/util/module.c
index 21237dcc24df..fe3b82dd4d37 100644
--- a/util/module.c
+++ b/util/module.c
@@ -181,6 +181,13 @@ static const struct {
     { "hw-display-qxl", "ui-spice-core" },
     { "ui-spice-app",   "ui-spice-core" },
     { "ui-spice-app",   "chardev-spice" },
+
+#ifdef CONFIG_OPENGL
+    { "ui-egl-headless", "ui-opengl"    },
+    { "ui-gtk",          "ui-opengl"    },
+    { "ui-sdl",          "ui-opengl"    },
+    { "ui-spice-core",   "ui-opengl"    },
+#endif
 };
 #endif
 
diff --git a/ui/meson.build b/ui/meson.build
index 537e5e067358..5d4906c023b9 100644
--- a/ui/meson.build
+++ b/ui/meson.build
@@ -33,7 +33,6 @@ vnc_ss.add(zlib, png, jpeg)
 vnc_ss.add(when: sasl, if_true: files('vnc-auth-sasl.c'))
 softmmu_ss.add_all(when: vnc, if_true: vnc_ss)
 softmmu_ss.add(when: vnc, if_false: files('vnc-stubs.c'))
-softmmu_ss.add(when: [opengl, 'CONFIG_OPENGL'], if_true: files('shader.c', 'console-gl.c', 'egl-helpers.c', 'egl-context.c'))
 specific_ss.add(when: ['CONFIG_SOFTMMU'], if_true: opengl)
 
 ui_modules = {}
@@ -44,6 +43,13 @@ if curses.found()
   ui_modules += {'curses' : curses_ss}
 endif
 
+if config_host.has_key('CONFIG_OPENGL')
+  opengl_ss = ss.source_set()
+  opengl_ss.add(when: [opengl, pixman, 'CONFIG_OPENGL'],
+               if_true: files('shader.c', 'console-gl.c', 'egl-helpers.c', 'egl-context.c'))
+  ui_modules += {'opengl' : opengl_ss}
+endif
+
 if config_host.has_key('CONFIG_OPENGL_DMABUF')
   egl_headless_ss = ss.source_set()
   egl_headless_ss.add(when: [opengl, pixman, 'CONFIG_OPENGL_DMABUF'],
-- 
2.27.0


