Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 656E4C433E6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 09:17:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2991B206A5
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 09:17:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TmAM3eYY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2991B206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47950 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD2Q8-0006dm-Cf
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 05:17:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33826)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kD2KV-0003dF-DY
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 05:11:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:28118)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kD2KT-0006rv-Hz
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 05:11:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598951508;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b9AKTtufJsM2KUAdKcbxs9ux5QGHnOstuHgTA3nWgas=;
 b=TmAM3eYYczgzYS3cUkUzgnTJrEpqEO17z/JBUivVXMlLUMcLwxaQRC3XeYu5ji3/Y9lVtx
 DvlTfOw1kk6qso1bqrKPi1J7BK1GApXsl/IY4Co+5d1uXnr/U1p3AgiRZuiU64XMRpp0IP
 q0v2f5zu3HQQLF7C8yJNTEvf1xrrFFM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-342---aZYPn4M22r4u2TadzsuA-1; Tue, 01 Sep 2020 05:11:46 -0400
X-MC-Unique: --aZYPn4M22r4u2TadzsuA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1ED4F10082E6
 for <qemu-devel@nongnu.org>; Tue,  1 Sep 2020 09:11:46 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DF56A78B45
 for <qemu-devel@nongnu.org>; Tue,  1 Sep 2020 09:11:45 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 22/24] meson: use pkg-config method to find dependencies
Date: Tue,  1 Sep 2020 05:11:30 -0400
Message-Id: <20200901091132.29601-23-pbonzini@redhat.com>
In-Reply-To: <20200901091132.29601-1-pbonzini@redhat.com>
References: <20200901091132.29601-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/31 23:17:53
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We do not need to ask cmake for the dependencies, so just use the
pkg-config mechanism.  Keep "auto" for SDL so that it tries using
sdl-config too.

The documentation is adjusted to use SDL2_image as the example,
rather than SDL which does not use the "pkg-config" method.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/devel/build-system.rst | 27 ++++++++++++++-------------
 meson.build                 |  8 ++++----
 2 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/docs/devel/build-system.rst b/docs/devel/build-system.rst
index 58bf392430..0c09fb9a54 100644
--- a/docs/devel/build-system.rst
+++ b/docs/devel/build-system.rst
@@ -66,46 +66,47 @@ following tasks:
    upon completion.
 
 
-Taking the probe for SDL as an example, we have the following pieces
+Taking the probe for SDL2_Image as an example, we have the following pieces
 in configure::
 
   # Initial variable state
-  sdl=auto
+  sdl_image=auto
 
   ..snip..
 
   # Configure flag processing
-  --disable-gnutls) sdl=disabled
+  --disable-sdl-image) sdl_image=disabled
   ;;
-  --enable-gnutls) sdl=enabled
+  --enable-sdl-image) sdl_image=enabled
   ;;
 
   ..snip..
 
   # Help output feature message
-  sdl             SDL UI
+  sdl-image         SDL Image support for icons
 
   ..snip..
 
   # Meson invocation
-  -Dsdl=$sdl
+  -Dsdl_image=$sdl_image
 
 In meson_options.txt::
 
-  option('sdl', type : 'feature', value : 'auto')
+  option('sdl', type : 'feature', value : 'auto',
+         description: 'SDL Image support for icons')
 
 In meson.build::
 
   # Detect dependency
-  sdl = dependency('sdl2',
-                   required: get_option('sdl'),
-                   static: enable_static)
+  sdl_image = dependency('SDL2_image', required: get_option('sdl_image'),
+                         method: 'pkg-config',
+                         static: enable_static)
 
-  # Create config-host.h
-  config_host_data.set('CONFIG_SDL', sdl.found())
+  # Create config-host.h (if applicable)
+  config_host_data.set('CONFIG_SDL_IMAGE', sdl_image.found())
 
   # Summary
-  summary_info += {'SDL support':       sdl.found()}
+  summary_info += {'SDL image support': sdl_image.found()}
 
 
 
diff --git a/meson.build b/meson.build
index 78ac86f3a1..0e2d884f5c 100644
--- a/meson.build
+++ b/meson.build
@@ -129,7 +129,7 @@ endif
 pixman = not_found
 if have_system or have_tools
   pixman = dependency('pixman-1', required: have_system, version:'>=0.21.8',
-                      static: enable_static)
+                      method: 'pkg-config', static: enable_static)
 endif
 pam = not_found
 if 'CONFIG_AUTH_PAM' in config_host
@@ -168,7 +168,7 @@ if get_option('xkbcommon').auto() and not have_system and not have_tools
   xkbcommon = not_found
 else
   xkbcommon = dependency('xkbcommon', required: get_option('xkbcommon'),
-                         static: enable_static)
+                         method: 'pkg-config', static: enable_static)
 endif
 slirp = not_found
 if config_host.has_key('CONFIG_SLIRP')
@@ -247,7 +247,7 @@ if sdl.found()
   sdl = declare_dependency(compile_args: '-Wno-undef',
                            dependencies: sdl)
   sdl_image = dependency('SDL2_image', required: get_option('sdl_image'),
-                         static: enable_static)
+                         method: 'pkg-config', static: enable_static)
 else
   if get_option('sdl_image').enabled()
     error('sdl-image required, but SDL was @0@',
@@ -332,7 +332,7 @@ sasl = not_found
 if get_option('vnc').enabled()
   vnc = declare_dependency() # dummy dependency
   png = dependency('libpng', required: get_option('vnc_png'),
-                   static: enable_static)
+                   method: 'pkg-config', static: enable_static)
   jpeg = cc.find_library('jpeg', has_headers: ['jpeglib.h'],
                          required: get_option('vnc_jpeg'),
                          static: enable_static)
-- 
2.26.2



