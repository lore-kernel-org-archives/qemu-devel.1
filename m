Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 851AAC433E7
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 09:21:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50BD6206A5
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 09:21:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N+x/ePED"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50BD6206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37462 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD2Ty-0005Mn-G9
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 05:21:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33854)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kD2KZ-0003lM-3F
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 05:11:55 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24641
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kD2KX-0006sY-8t
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 05:11:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598951512;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CHD/T/2GtcjdtrkJkCuvpJR9JYXGP04bZaW+yoSYPLU=;
 b=N+x/ePEDQSh5aUbeDsgxye65ZUfgGIQseJ85LI2dYyhJON240QMFrxcycZ1k0UdWRX43+S
 jqyLLbd8WzOSC0bGIieuvMwNXdkRIhqYEIvr4K+9hIVCIksD6oQ+nfjuRzjkB1JDtwEi0V
 yFrQZurMwMKSNg5CN/2KnbqhKGAxCzQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-183-wGdiUIVnNRCT4FkSV8lq9g-1; Tue, 01 Sep 2020 05:11:43 -0400
X-MC-Unique: wGdiUIVnNRCT4FkSV8lq9g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5CAD4801FDE
 for <qemu-devel@nongnu.org>; Tue,  1 Sep 2020 09:11:42 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0E7B160C04;
 Tue,  1 Sep 2020 09:11:41 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 15/24] meson: use meson datadir instead of qemu_datadir
Date: Tue,  1 Sep 2020 05:11:23 -0400
Message-Id: <20200901091132.29601-16-pbonzini@redhat.com>
In-Reply-To: <20200901091132.29601-1-pbonzini@redhat.com>
References: <20200901091132.29601-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/01 00:57:59
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

When cross-compiling, by default qemu_datadir is 'c:\Program
Files\QEMU', which is not recognized as being an absolute path, and
meson will end up adding the prefix again.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20200826110419.528931-6-marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 contrib/vhost-user-gpu/meson.build | 2 +-
 meson.build                        | 3 ++-
 meson_options.txt                  | 2 +-
 pc-bios/descriptors/meson.build    | 2 +-
 pc-bios/keymaps/meson.build        | 6 +++---
 pc-bios/meson.build                | 2 +-
 tools/virtiofsd/meson.build        | 2 +-
 trace/meson.build                  | 2 +-
 8 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/contrib/vhost-user-gpu/meson.build b/contrib/vhost-user-gpu/meson.build
index 12d608c2e7..7d9b29da8b 100644
--- a/contrib/vhost-user-gpu/meson.build
+++ b/contrib/vhost-user-gpu/meson.build
@@ -10,5 +10,5 @@ if 'CONFIG_TOOLS' in config_host and 'CONFIG_VIRGL' in config_host \
   configure_file(input: '50-qemu-gpu.json.in',
                  output: '50-qemu-gpu.json',
                  configuration: config_host,
-                 install_dir: config_host['qemu_datadir'] / 'vhost-user')
+                 install_dir: qemu_datadir / 'vhost-user')
 endif
diff --git a/meson.build b/meson.build
index 8b28ecff28..bf6d1b3153 100644
--- a/meson.build
+++ b/meson.build
@@ -18,6 +18,7 @@ config_all_disas = keyval.load(meson.current_build_dir() / 'config-all-disas.mak
 enable_modules = 'CONFIG_MODULES' in config_host
 enable_static = 'CONFIG_STATIC' in config_host
 build_docs = 'BUILD_DOCS' in config_host
+qemu_datadir = get_option('datadir') / get_option('qemu_suffix')
 config_host_data = configuration_data()
 genh = []
 
@@ -1055,7 +1056,7 @@ foreach target : target_dirs
                       output: exe['name'] + stp['ext'],
                       capture: true,
                       install: stp['install'],
-                      install_dir: config_host['qemu_datadir'] / '../systemtap/tapset',
+                      install_dir: qemu_datadir / '../systemtap/tapset',
                       command: [
                         tracetool, '--group=all', '--format=' + stp['fmt'],
                         '--binary=' + stp['bin'],
diff --git a/meson_options.txt b/meson_options.txt
index dfdcf85063..f4275691bd 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -1,4 +1,4 @@
-option('qemu_suffix', type : 'string', value: '/qemu',
+option('qemu_suffix', type : 'string', value: 'qemu',
        description: 'Suffix for QEMU data/modules/config directories (can be empty)')
 option('gettext', type : 'boolean', value : true)
 option('sdl', type : 'feature', value : 'auto')
diff --git a/pc-bios/descriptors/meson.build b/pc-bios/descriptors/meson.build
index 7c715bace8..3798d32372 100644
--- a/pc-bios/descriptors/meson.build
+++ b/pc-bios/descriptors/meson.build
@@ -10,5 +10,5 @@ foreach f: [
                  output: f,
                  configuration: {'DATADIR': config_host['qemu_datadir']},
                  install: install_blobs,
-                 install_dir: config_host['qemu_datadir'] / 'firmware')
+                 install_dir: qemu_datadir / 'firmware')
 endforeach
diff --git a/pc-bios/keymaps/meson.build b/pc-bios/keymaps/meson.build
index b737c82230..bbac83ece3 100644
--- a/pc-bios/keymaps/meson.build
+++ b/pc-bios/keymaps/meson.build
@@ -44,13 +44,13 @@ foreach km, args: keymaps
                      build_by_default: true,
                      output: km,
                      command: [native_qemu_keymap, '-f', '@OUTPUT@', args.split()],
-                     install_dir: config_host['qemu_datadir'] / 'keymaps')
+                     install_dir: qemu_datadir / 'keymaps')
 endforeach
 if t.length() > 0
   alias_target('update-keymaps', t)
 else
   # install from the source tree
-  install_data(keymaps.keys(), install_dir: config_host['qemu_datadir'] / 'keymaps')
+  install_data(keymaps.keys(), install_dir: qemu_datadir / 'keymaps')
 endif
 
-install_data(['sl', 'sv'], install_dir: config_host['qemu_datadir'] / 'keymaps')
+install_data(['sl', 'sv'], install_dir: qemu_datadir / 'keymaps')
diff --git a/pc-bios/meson.build b/pc-bios/meson.build
index f608c2cdba..8087e5c0a7 100644
--- a/pc-bios/meson.build
+++ b/pc-bios/meson.build
@@ -19,7 +19,7 @@ if 'DECOMPRESS_EDK2_BLOBS' in config_host
                   input: '@0@.bz2'.format(f),
                   capture: true,
                   install: install_blobs,
-                  install_dir: config_host['qemu_datadir'],
+                  install_dir: qemu_datadir,
                   command: [ bzip2, '-dc', '@INPUT0@' ])
   endforeach
 endif
diff --git a/tools/virtiofsd/meson.build b/tools/virtiofsd/meson.build
index d1e23c5760..50022ed89e 100644
--- a/tools/virtiofsd/meson.build
+++ b/tools/virtiofsd/meson.build
@@ -16,4 +16,4 @@ executable('virtiofsd', files(
 configure_file(input: '50-qemu-virtiofsd.json.in',
                output: '50-qemu-virtiofsd.json',
                configuration: config_host,
-               install_dir: config_host['qemu_datadir'] / 'vhost-user')
+               install_dir: qemu_datadir / 'vhost-user')
diff --git a/trace/meson.build b/trace/meson.build
index 1c1fb31a61..b36937d3a6 100644
--- a/trace/meson.build
+++ b/trace/meson.build
@@ -58,7 +58,7 @@ trace_events_all = custom_target('trace-events-all',
                                  command: [ 'cat', '@INPUT@' ],
                                  capture: true,
                                  install: true,
-                                 install_dir: config_host['qemu_datadir'])
+                                 install_dir: qemu_datadir)
 
 foreach d : [
   ['generated-tcg-tracers.h', 'tcg-h'],
-- 
2.26.2



