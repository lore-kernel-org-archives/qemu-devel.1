Return-Path: <SRS0=MBD3=C4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9AFFC43464
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2020 16:42:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 188AB208DB
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2020 16:42:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DiFZ/ghY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 188AB208DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42470 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJfw1-0000jF-8e
	for qemu-devel@archiver.kernel.org; Sat, 19 Sep 2020 12:42:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51648)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kJfHW-0005bA-KB
 for qemu-devel@nongnu.org; Sat, 19 Sep 2020 12:00:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57886)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kJfHG-0007Qg-SV
 for qemu-devel@nongnu.org; Sat, 19 Sep 2020 12:00:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600531190;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y+CCxhNxxcmW4M13TN325UTuixWJIJ7Gk7glKz9O1Xc=;
 b=DiFZ/ghYaIlgeCiy2RezibS7W45yAiE7XFoFqQbUUzUJdSov3GI97seoComXitf8CxENv6
 o/lZp/K60j3gMU5ukzmcuDV5s+uk+xvbeU3qtD1VOjShUBOhVdU91GGRPeERTZFUK4F0GT
 0Ufuw0sOjguUcomzWcZ27RQk/epQrOU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-295-8daarbd3PUamJUiY4HpObw-1; Sat, 19 Sep 2020 11:59:48 -0400
X-MC-Unique: 8daarbd3PUamJUiY4HpObw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E69FF1074644;
 Sat, 19 Sep 2020 15:59:46 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A849910016DA;
 Sat, 19 Sep 2020 15:59:43 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 36/57] configure: move cocoa option to Meson
Date: Sat, 19 Sep 2020 11:58:55 -0400
Message-Id: <20200919155916.1046398-37-pbonzini@redhat.com>
In-Reply-To: <20200919155916.1046398-1-pbonzini@redhat.com>
References: <20200919155916.1046398-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/19 06:41:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
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
Cc: Christophe de Dinechin <dinechin@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

While detection of the framework was already there, moving
the option allows for better error reporting.

Reported-by: Christophe de Dinechin <dinechin@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure         | 17 +++++++----------
 meson.build       |  9 +++++++--
 meson_options.txt |  2 ++
 ui/meson.build    |  2 +-
 4 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/configure b/configure
index f4499f52a4..96446e10b0 100755
--- a/configure
+++ b/configure
@@ -448,7 +448,7 @@ bsd="no"
 linux="no"
 solaris="no"
 profiler="no"
-cocoa="no"
+cocoa="auto"
 softmmu="yes"
 linux_user="no"
 bsd_user="no"
@@ -868,7 +868,7 @@ Darwin)
     QEMU_CFLAGS="-arch x86_64 $QEMU_CFLAGS"
     QEMU_LDFLAGS="-arch x86_64 $QEMU_LDFLAGS"
   fi
-  cocoa="yes"
+  cocoa="enabled"
   audio_drv_list="coreaudio try-sdl"
   audio_possible_drivers="coreaudio sdl"
   QEMU_LDFLAGS="-framework CoreFoundation -framework IOKit $QEMU_LDFLAGS"
@@ -1239,10 +1239,10 @@ for opt do
   ;;
   --enable-profiler) profiler="yes"
   ;;
-  --disable-cocoa) cocoa="no"
+  --disable-cocoa) cocoa="disabled"
   ;;
   --enable-cocoa)
-      cocoa="yes" ;
+      cocoa="enabled" ;
       audio_drv_list="coreaudio $(echo $audio_drv_list | sed s,coreaudio,,g)"
   ;;
   --disable-system) softmmu="no"
@@ -2387,8 +2387,8 @@ fi
 # cocoa implies not SDL or GTK
 # (the cocoa UI code currently assumes it is always the active UI
 # and doesn't interact well with other UI frontend code)
-if test "$cocoa" = "yes"; then
-    if test "$sdl" = "yes"; then
+if test "$cocoa" = "enabled"; then
+    if test "$sdl" = "enabled"; then
         error_exit "Cocoa and SDL UIs cannot both be enabled at once"
     fi
     if test "$gtk" = "yes"; then
@@ -6552,9 +6552,6 @@ if test "$have_x11" = "yes" && test "$need_x11" = "yes"; then
   echo "X11_CFLAGS=$x11_cflags" >> $config_host_mak
   echo "X11_LIBS=$x11_libs" >> $config_host_mak
 fi
-if test "$cocoa" = "yes" ; then
-  echo "CONFIG_COCOA=y" >> $config_host_mak
-fi
 if test "$iconv" = "yes" ; then
   echo "CONFIG_ICONV=y" >> $config_host_mak
   echo "ICONV_CFLAGS=$iconv_cflags" >> $config_host_mak
@@ -7857,7 +7854,7 @@ NINJA=${ninja:-$PWD/ninjatool} $meson setup \
         -Db_pie=$(if test "$pie" = yes; then echo true; else echo false; fi) \
         -Db_coverage=$(if test "$gcov" = yes; then echo true; else echo false; fi) \
 	-Dmalloc=$malloc -Dmalloc_trim=$malloc_trim \
-	-Dmpath=$mpath -Dsdl=$sdl -Dsdl_image=$sdl_image \
+	-Dcocoa=$cocoa -Dmpath=$mpath -Dsdl=$sdl -Dsdl_image=$sdl_image \
 	-Dvnc=$vnc -Dvnc_sasl=$vnc_sasl -Dvnc_jpeg=$vnc_jpeg -Dvnc_png=$vnc_png \
 	-Dgettext=$gettext -Dxkbcommon=$xkbcommon -Du2f=$u2f\
         $cross_arg \
diff --git a/meson.build b/meson.build
index 808980b508..848223778d 100644
--- a/meson.build
+++ b/meson.build
@@ -101,7 +101,7 @@ socket = []
 version_res = []
 coref = []
 iokit = []
-cocoa = []
+cocoa = not_found
 hvf = []
 if targetos == 'windows'
   socket = cc.find_library('ws2_32')
@@ -114,7 +114,7 @@ if targetos == 'windows'
 elif targetos == 'darwin'
   coref = dependency('appleframeworks', modules: 'CoreFoundation')
   iokit = dependency('appleframeworks', modules: 'IOKit')
-  cocoa = dependency('appleframeworks', modules: 'Cocoa')
+  cocoa = dependency('appleframeworks', modules: 'Cocoa', required: get_option('cocoa'))
   hvf = dependency('appleframeworks', modules: 'Hypervisor')
 elif targetos == 'sunos'
   socket = [cc.find_library('socket'),
@@ -126,6 +126,10 @@ elif targetos == 'haiku'
             cc.find_library('bsd')]
 endif
 
+if not cocoa.found() and get_option('cocoa').enabled()
+  error('Cocoa not available on this platform')
+endif
+
 ################
 # Dependencies #
 ################
@@ -542,6 +546,7 @@ endif
 
 # Create config-host.h
 
+config_host_data.set('CONFIG_COCOA', cocoa.found())
 config_host_data.set('CONFIG_LIBUDEV', libudev.found())
 config_host_data.set('CONFIG_MPATH', mpathpersist.found())
 config_host_data.set('CONFIG_MPATH_NEW_API', mpathpersist_new_api)
diff --git a/meson_options.txt b/meson_options.txt
index 8a59ec263d..46ea1d889a 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -11,6 +11,8 @@ option('malloc_trim', type : 'feature', value : 'auto',
 option('malloc', type : 'combo', choices : ['system', 'tcmalloc', 'jemalloc'],
        value: 'system', description: 'choose memory allocator to use')
 
+option('cocoa', type : 'feature', value : 'auto',
+       description: 'Cocoa user interface (macOS only)')
 option('mpath', type : 'feature', value : 'auto',
        description: 'Multipath persistent reservation passthrough')
 option('sdl', type : 'feature', value : 'auto',
diff --git a/ui/meson.build b/ui/meson.build
index dd6c110136..8a080c38e3 100644
--- a/ui/meson.build
+++ b/ui/meson.build
@@ -15,7 +15,7 @@ softmmu_ss.add(files(
 
 softmmu_ss.add(when: 'CONFIG_LINUX', if_true: files('input-linux.c'))
 softmmu_ss.add(when: 'CONFIG_SPICE', if_true: files('spice-core.c', 'spice-input.c', 'spice-display.c'))
-softmmu_ss.add(when: [cocoa, 'CONFIG_COCOA'], if_true: files('cocoa.m'))
+softmmu_ss.add(when: cocoa, if_true: files('cocoa.m'))
 
 vnc_ss = ss.source_set()
 vnc_ss.add(files(
-- 
2.26.2



