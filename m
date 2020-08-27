Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD5CFC433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 17:13:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 921ED20737
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 17:13:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ihjjv1xs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 921ED20737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55738 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBLSp-0001SI-RX
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 13:13:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50902)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kBLGF-0006EU-Dh
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 13:00:27 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21514
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kBLGB-0005R0-3K
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 13:00:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598547622;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0GIS4sJrpYwSxVl4OBe0grTnM0NESHgzmK3QC9d6C6k=;
 b=Ihjjv1xsq17BaQfXHVO19xff2aFUtBGlU71omy3UwaJ4j1JA/cBt9l4N0MixzQbAn/6XFt
 8k0d1jYIdL1a+9bMzId6gdZxyg3/yyBaLbhp5IDoJ2LmQah9qrTlpTQfxm6PZLzENCeNVu
 2xafNXzTrUh3v4JjN6p3AI6z838llsE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-558-9hIK1qE8PH2DAu-RBAoawg-1; Thu, 27 Aug 2020 13:00:20 -0400
X-MC-Unique: 9hIK1qE8PH2DAu-RBAoawg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 92F09800683;
 Thu, 27 Aug 2020 17:00:19 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3FD7D50B3F;
 Thu, 27 Aug 2020 17:00:19 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 09/17] meson: skip SDL2 detection if --disable-system
Date: Thu, 27 Aug 2020 12:59:48 -0400
Message-Id: <20200827165956.12925-10-pbonzini@redhat.com>
In-Reply-To: <20200827165956.12925-1-pbonzini@redhat.com>
References: <20200827165956.12925-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/27 00:13:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
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
Cc: Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

SDL is only used for system emulation; avoid spurious warnings for
static --disable-system emulation by skipping the detection of
the library if there are no system emulation targets.

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/meson.build b/meson.build
index 86a6d13192..a3baa2dbf0 100644
--- a/meson.build
+++ b/meson.build
@@ -20,6 +20,16 @@ build_docs = 'BUILD_DOCS' in config_host
 config_host_data = configuration_data()
 genh = []
 
+target_dirs = config_host['TARGET_DIRS'].split()
+have_user = false
+have_system = false
+foreach target : target_dirs
+  have_user = have_user or target.endswith('-user')
+  have_system = have_system or target.endswith('-softmmu')
+endforeach
+have_tools = 'CONFIG_TOOLS' in config_host
+have_block = have_system or have_tools
+
 add_project_arguments(config_host['QEMU_CFLAGS'].split(),
                       native: false, language: ['c', 'objc'])
 add_project_arguments(config_host['QEMU_CXXFLAGS'].split(),
@@ -227,9 +237,12 @@ if 'CONFIG_BRLAPI' in config_host
   brlapi = declare_dependency(link_args: config_host['BRLAPI_LIBS'].split())
 endif
 
-sdl = dependency('sdl2', required: get_option('sdl'), static: enable_static,
-                 include_type: 'system')
-sdl_image = not_found
+sdl = not_found
+if have_system
+  sdl = dependency('sdl2', required: get_option('sdl'), static: enable_static,
+                   include_type: 'system')
+  sdl_image = not_found
+endif
 if sdl.found()
   # work around 2.0.8 bug
   sdl = declare_dependency(compile_args: '-Wno-undef',
@@ -426,9 +439,6 @@ endforeach
 genh += configure_file(output: 'config-host.h', configuration: config_host_data)
 
 minikconf = find_program('scripts/minikconf.py')
-target_dirs = config_host['TARGET_DIRS'].split()
-have_user = false
-have_system = false
 config_devices_mak_list = []
 config_devices_h = {}
 config_target_h = {}
@@ -449,7 +459,6 @@ kconfig_external_symbols = [
 ]
 ignored = ['TARGET_XML_FILES', 'TARGET_ABI_DIR', 'TARGET_DIRS']
 foreach target : target_dirs
-  have_user = have_user or target.endswith('-user')
   config_target = keyval.load(meson.current_build_dir() / target / 'config-target.mak')
 
   config_target_data = configuration_data()
@@ -472,8 +481,6 @@ foreach target : target_dirs
                                                configuration: config_target_data)}
 
   if target.endswith('-softmmu')
-    have_system = true
-
     base_kconfig = []
     foreach sym : kconfig_external_symbols
       if sym in config_target or sym in config_host
@@ -503,8 +510,6 @@ foreach target : target_dirs
   endif
   config_target_mak += {target: config_target}
 endforeach
-have_tools = 'CONFIG_TOOLS' in config_host
-have_block = have_system or have_tools
 
 grepy = find_program('scripts/grepy.sh')
 # This configuration is used to build files that are shared by
-- 
2.26.2



