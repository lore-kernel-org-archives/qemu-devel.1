Return-Path: <SRS0=JoQ+=DX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2787CC43457
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 11:52:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86AB2206DD
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 11:52:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gwFKZrXW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86AB2206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51094 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTOHV-0005Wp-3S
	for qemu-devel@archiver.kernel.org; Fri, 16 Oct 2020 07:52:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34404)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kTODh-0000RU-8s
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 07:48:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60767)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kTODe-0002om-Qa
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 07:48:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602848902;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7HRmR8DrzmfanXflfW4M/oc151NJvYgLvn5iOnqRT2Y=;
 b=gwFKZrXW93G959cbJCIE6+ewcBZ0xukY4y0Qr2HJ8AIg3RJXKF5J9HrLLCurQm5O7zMQ40
 LpCxTlexCmMkVw11g3MTDK+yCDGDrtatvGdD+ys2o+HPiGzVNNMwmaPe7rl6SBXY/fS6kE
 wowSw7f2P36F08c1t4ZySrzcJ4TtfBk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-439-YrK84pQdOcK-yrLNTOXmUw-1; Fri, 16 Oct 2020 07:48:20 -0400
X-MC-Unique: YrK84pQdOcK-yrLNTOXmUw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3D98A64155;
 Fri, 16 Oct 2020 11:48:19 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EB5A75C1D0;
 Fri, 16 Oct 2020 11:48:18 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 11/22] build: add --enable/--disable-libudev
Date: Fri, 16 Oct 2020 07:48:03 -0400
Message-Id: <20201016114814.1564523-12-pbonzini@redhat.com>
In-Reply-To: <20201016114814.1564523-1-pbonzini@redhat.com>
References: <20201016114814.1564523-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/15 20:29:24
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
Cc: Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Initially, libudev detection was bundled with --enable-mpath because
qemu-pr-helper was the only user of libudev.  Recently however the USB
U2F emulation has also started using libudev, so add a separate
option.  This also allows 1) disabling libudev if desired for static
builds and 2) for non-static builds, requiring libudev even if
multipath support is undesirable.

The multipath test is adjusted, because it is now possible to enter it
with configurations that should fail, such as --static --enable-mpath
--disable-libudev.

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure         |  8 +++++++-
 meson.build       | 50 ++++++++++++++++++++++++++---------------------
 meson_options.txt |  2 ++
 3 files changed, 37 insertions(+), 23 deletions(-)

diff --git a/configure b/configure
index 9317349044..c83a2eeb9d 100755
--- a/configure
+++ b/configure
@@ -303,6 +303,7 @@ netmap="no"
 sdl="auto"
 sdl_image="auto"
 virtfs=""
+libudev="auto"
 mpath="auto"
 vnc="enabled"
 sparse="auto"
@@ -1002,6 +1003,10 @@ for opt do
   ;;
   --enable-virtfs) virtfs="yes"
   ;;
+  --disable-libudev) libudev="disabled"
+  ;;
+  --enable-libudev) libudev="enabled"
+  ;;
   --disable-mpath) mpath="disabled"
   ;;
   --enable-mpath) mpath="enabled"
@@ -1759,6 +1764,7 @@ disabled with --disable-FEATURE, default is enabled if available:
   vnc-png         PNG compression for VNC server
   cocoa           Cocoa UI (Mac OS X only)
   virtfs          VirtFS
+  libudev         Use libudev to enumerate host devices
   mpath           Multipath persistent reservation passthrough
   xen             xen backend driver support
   xen-pci-passthrough    PCI passthrough support for Xen
@@ -7060,7 +7066,7 @@ NINJA=$ninja $meson setup \
         -Dvnc=$vnc -Dvnc_sasl=$vnc_sasl -Dvnc_jpeg=$vnc_jpeg -Dvnc_png=$vnc_png \
         -Dgettext=$gettext -Dxkbcommon=$xkbcommon -Du2f=$u2f \
         -Dcapstone=$capstone -Dslirp=$slirp -Dfdt=$fdt \
-        -Diconv=$iconv -Dcurses=$curses \
+        -Diconv=$iconv -Dcurses=$curses -Dlibudev=$libudev\
         $cross_arg \
         "$PWD" "$source_path"
 
diff --git a/meson.build b/meson.build
index 2c93e22382..0c0f4f9fd8 100644
--- a/meson.build
+++ b/meson.build
@@ -380,10 +380,11 @@ endif
 libudev = not_found
 if targetos == 'linux' and (have_system or have_tools)
   libudev = dependency('libudev',
-                       required: get_option('mpath').enabled(),
+                       required: get_option('libudev'),
                        static: enable_static)
 endif
 
+mpathlibs = [libudev]
 mpathpersist = not_found
 mpathpersist_new_api = false
 if targetos == 'linux' and have_tools and not get_option('mpath').disabled()
@@ -414,35 +415,40 @@ if targetos == 'linux' and have_tools and not get_option('mpath').disabled()
           mpath_lib_init(udev);
           return 0;
       }'''
-  mpathlibs = [libudev]
-  if enable_static
-    mpathlibs += cc.find_library('devmapper',
-                                   required: get_option('mpath'),
-                                   static: enable_static)
-  endif
-  mpathlibs += cc.find_library('multipath',
-                               required: get_option('mpath'),
-                               static: enable_static)
-  mpathlibs += cc.find_library('mpathpersist',
-                               required: get_option('mpath'),
-                               static: enable_static)
-  foreach lib: mpathlibs
-    if not lib.found()
-      mpathlibs = []
-      break
+  libmpathpersist = cc.find_library('mpathpersist',
+                                    required: get_option('mpath'),
+                                    static: enable_static)
+  if libmpathpersist.found()
+    mpathlibs += libmpathpersist
+    if enable_static
+      mpathlibs += cc.find_library('devmapper',
+                                     required: get_option('mpath'),
+                                     static: enable_static)
     endif
-  endforeach
-  if mpathlibs.length() > 0
-    if cc.links(mpath_test_source_new, dependencies: mpathlibs)
+    mpathlibs += cc.find_library('multipath',
+                                 required: get_option('mpath'),
+                                 static: enable_static)
+    foreach lib: mpathlibs
+      if not lib.found()
+        mpathlibs = []
+        break
+      endif
+    endforeach
+    if mpathlibs.length() == 0
+      msg = 'Dependencies missing for libmpathpersist'
+    elif cc.links(mpath_test_source_new, dependencies: mpathlibs)
       mpathpersist = declare_dependency(dependencies: mpathlibs)
       mpathpersist_new_api = true
     elif cc.links(mpath_test_source_old, dependencies: mpathlibs)
       mpathpersist = declare_dependency(dependencies: mpathlibs)
     else
+      msg = 'Cannot detect libmpathpersist API'
+    endif
+    if not mpathpersist.found()
       if get_option('mpath').enabled()
-        error('Cannot detect libmpathpersist API')
+        error(msg)
       else
-        warning('Cannot detect libmpathpersist API, disabling')
+        warning(msg + ', disabling')
       endif
     endif
   endif
diff --git a/meson_options.txt b/meson_options.txt
index e6cb1e589b..77b3fabd00 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -36,6 +36,8 @@ option('iconv', type : 'feature', value : 'auto',
        description: 'Font glyph conversion support')
 option('curses', type : 'feature', value : 'auto',
        description: 'curses UI')
+option('libudev', type : 'feature', value : 'auto',
+       description: 'Use libudev to enumerate host devices')
 option('sdl', type : 'feature', value : 'auto',
        description: 'SDL user interface')
 option('sdl_image', type : 'feature', value : 'auto',
-- 
2.26.2



