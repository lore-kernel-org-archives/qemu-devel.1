Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB198C433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 07:59:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B59A22243
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 07:59:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SAXfaHgz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B59A22243
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41202 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUQ4u-0004gt-8f
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 03:59:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54276)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kUPyI-0005CV-2x
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 03:52:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:28240)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kUPyG-00086u-6O
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 03:52:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603093963;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jpBjHoJ7TJJFHT0NNFAxXbhXswV7KiWZ0nZ17TzYQcQ=;
 b=SAXfaHgzZbqpV4YFK8x1a4aw8LoHaaSxi2m1aT4SO4uCcEIJtWoQrvsNvsl5l4pohZwLsV
 S53JDMXMcQHJi4v+f5ZRKsj1BAM3DPWq7Eox0V8BoSniERHtkV6zJcM8wku9+Svfj3asoY
 eSBODij0MgFI+CQxi3sbuOQ4RIFI4g8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-256-MgXP2-mANK2W-lEAULE5AQ-1; Mon, 19 Oct 2020 03:52:41 -0400
X-MC-Unique: MgXP2-mANK2W-lEAULE5AQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9DA12846360
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2020 07:52:40 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-56.ams2.redhat.com
 [10.36.112.56])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5F6057B7A0;
 Mon, 19 Oct 2020 07:52:40 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id B023F9A94; Mon, 19 Oct 2020 09:52:24 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 12/14] spice: flip modules switch
Date: Mon, 19 Oct 2020 09:52:22 +0200
Message-Id: <20201019075224.14803-13-kraxel@redhat.com>
In-Reply-To: <20201019075224.14803-1-kraxel@redhat.com>
References: <20201019075224.14803-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/19 02:32:01
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

Build spice core code as module.  This removes libspice-server and a
handful of indirect dependencies from core qemu.  The number of shared
libraries for qemu-system-x86_64 goes down from 73 to 66 on my system.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 ui/meson.build | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/ui/meson.build b/ui/meson.build
index fc1b31daec47..996e1d13ab34 100644
--- a/ui/meson.build
+++ b/ui/meson.build
@@ -15,7 +15,6 @@ softmmu_ss.add(files(
 softmmu_ss.add([spice_headers, files('spice-module.c')])
 
 softmmu_ss.add(when: 'CONFIG_LINUX', if_true: files('input-linux.c'))
-softmmu_ss.add(when: [spice, 'CONFIG_SPICE'], if_true: files('spice-core.c', 'spice-input.c', 'spice-display.c'))
 softmmu_ss.add(when: cocoa, if_true: files('cocoa.m'))
 
 vnc_ss = ss.source_set()
@@ -71,6 +70,16 @@ if sdl.found()
   ui_modules += {'sdl' : sdl_ss}
 endif
 
+if config_host.has_key('CONFIG_SPICE')
+  spice_core_ss = ss.source_set()
+  spice_core_ss.add(spice, pixman, files(
+    'spice-core.c',
+    'spice-input.c',
+    'spice-display.c'
+  ))
+  ui_modules += {'spice-core' : spice_core_ss}
+endif
+
 if config_host.has_key('CONFIG_SPICE') and config_host.has_key('CONFIG_GIO')
   spice_ss = ss.source_set()
   spice_ss.add(spice, gio, pixman, files('spice-app.c'))
-- 
2.27.0


