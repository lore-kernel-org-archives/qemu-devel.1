Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3F0AC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 08:07:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D5662225A
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 08:07:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AcobUEl2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D5662225A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57484 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUQCi-0003Zz-51
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 04:07:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54320)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kUPyM-0005Mv-Ca
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 03:52:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38379)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kUPyK-00088i-JY
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 03:52:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603093967;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Tm6/MNbwNq63pw9+cN47JYN39/ddzwMPceZFcEgV8sk=;
 b=AcobUEl2DgJck9zaSt4rHln+BREMZ6ZPGXgdp6ap+InER8f3jEqVTCD5rJTwbwfl7z2xhn
 q8cZFmGilQu/I3DOUqVKPLHcz8oqad8qmpjkQpa3rPm0pKKAJa57Z7sa4GW4jhr7OTs2Oe
 Z2DH/ch747ZxFj7F+kqO2v+e1Q7Yg0o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-261-Fg_a4wiiPDyHi7LOZLut4w-1; Mon, 19 Oct 2020 03:52:45 -0400
X-MC-Unique: Fg_a4wiiPDyHi7LOZLut4w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 496241019630
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2020 07:52:44 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-56.ams2.redhat.com
 [10.36.112.56])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B95015D994;
 Mon, 19 Oct 2020 07:52:43 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id B8E0743BFB2; Mon, 19 Oct 2020 09:52:24 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 13/14] opengl: build egl-headless display modular
Date: Mon, 19 Oct 2020 09:52:23 +0200
Message-Id: <20201019075224.14803-14-kraxel@redhat.com>
In-Reply-To: <20201019075224.14803-1-kraxel@redhat.com>
References: <20201019075224.14803-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/19 01:44:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 ui/meson.build | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/ui/meson.build b/ui/meson.build
index 996e1d13ab34..3cf03d2c297b 100644
--- a/ui/meson.build
+++ b/ui/meson.build
@@ -34,7 +34,6 @@ vnc_ss.add(when: sasl, if_true: files('vnc-auth-sasl.c'))
 softmmu_ss.add_all(when: vnc, if_true: vnc_ss)
 softmmu_ss.add(when: vnc, if_false: files('vnc-stubs.c'))
 softmmu_ss.add(when: [opengl, 'CONFIG_OPENGL'], if_true: files('shader.c', 'console-gl.c', 'egl-helpers.c', 'egl-context.c'))
-softmmu_ss.add(when: [opengl, 'CONFIG_OPENGL_DMABUF'], if_true: files('egl-headless.c'))
 specific_ss.add(when: ['CONFIG_SOFTMMU'], if_true: opengl)
 
 ui_modules = {}
@@ -45,6 +44,13 @@ if curses.found()
   ui_modules += {'curses' : curses_ss}
 endif
 
+if config_host.has_key('CONFIG_OPENGL_DMABUF')
+  egl_headless_ss = ss.source_set()
+  egl_headless_ss.add(when: [opengl, pixman, 'CONFIG_OPENGL_DMABUF'],
+                      if_true: files('egl-headless.c'))
+  ui_modules += {'egl-headless' : egl_headless_ss}
+endif
+
 if config_host.has_key('CONFIG_GTK')
   softmmu_ss.add(when: 'CONFIG_WIN32', if_true: files('win32-kbd-hook.c'))
 
-- 
2.27.0


