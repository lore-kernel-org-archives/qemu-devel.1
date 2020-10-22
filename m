Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12D8BC388F7
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 05:19:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BEE82244C
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 05:19:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JZpGfif4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BEE82244C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVT0g-0005tJ-6J
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 01:19:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33060)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kVSu6-0003kO-Kd
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 01:12:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56348)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kVStv-0003wR-L3
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 01:12:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603343555;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=64f7Avxke8Zz3NS9yGXFYLUZfTJGps7pBALxKZB9KPU=;
 b=JZpGfif46sD3d3x1Tc+vE4Q0EcCdBqTRC4u265freZX5QFOR22bCWNM5lM58gBo1LNH5e8
 +ogGPqHzm4UcOTrVe0BdoQxFPecJNL3puyfuxuKOplXqk58HWyFEZflmFUVJggQTD/zC9C
 4+xXDIYj+luAtfa1CHBXSi31Pn7zSoc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-41-w0Jvt8xVMZK9KwU5ZbV0Tg-1; Thu, 22 Oct 2020 01:12:32 -0400
X-MC-Unique: w0Jvt8xVMZK9KwU5ZbV0Tg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A190A803F76
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2020 05:12:31 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-114-66.ams2.redhat.com
 [10.36.114.66])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5D16A1002C04;
 Thu, 22 Oct 2020 05:12:31 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 07D98204A7; Thu, 22 Oct 2020 07:12:24 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 12/14] spice: flip modules switch
Date: Thu, 22 Oct 2020 07:12:21 +0200
Message-Id: <20201022051223.6181-13-kraxel@redhat.com>
In-Reply-To: <20201022051223.6181-1-kraxel@redhat.com>
References: <20201022051223.6181-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/22 00:54:46
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-id: 20201019075224.14803-13-kraxel@redhat.com
---
 ui/meson.build | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/ui/meson.build b/ui/meson.build
index e89e298643a3..509739709ef2 100644
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


