Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98A05C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 15:05:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57D8220786
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 15:05:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DQFJ8OOY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57D8220786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50202 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAaVw-0001JB-Hu
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 11:05:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54524)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1kAaV8-0008Ea-HF
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 11:04:42 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:38427
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1kAaV5-0003Dy-SS
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 11:04:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598367879;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zrB6eiMbxp32SBkm8uz7db0X+q445dB/jQqAAccAcZY=;
 b=DQFJ8OOYxPtBlrwzg5WmO6f9tIL68qNRlnyPMI2j8SoFTQC7/i2h5pFQddsDdX7kH/8OzS
 mvW/JwgxIw3jE/vRJJOYmKWozleN+ByD2SdNV4Cd40TGuLUgg+PLpqegSreUM6bmpgWhFs
 177fazbdTqi/vs5eMj70QbnpW87PXMI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-538-m0_tTZxOOYuyRiw8V58Sqg-1; Tue, 25 Aug 2020 11:04:33 -0400
X-MC-Unique: m0_tTZxOOYuyRiw8V58Sqg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 88C42800D53;
 Tue, 25 Aug 2020 15:04:32 +0000 (UTC)
Received: from localhost (unknown [10.36.110.43])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 40D3A1014161;
 Tue, 25 Aug 2020 15:04:27 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Subject: [PATCH 2/5] meson: use meson datadir instead of qemu_datadir
Date: Tue, 25 Aug 2020 19:04:06 +0400
Message-Id: <20200825150409.346957-3-marcandre.lureau@redhat.com>
In-Reply-To: <20200825150409.346957-1-marcandre.lureau@redhat.com>
References: <20200825150409.346957-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=marcandre.lureau@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/25 01:35:36
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.958,
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
Cc: pbonzini@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 sw@weilnetz.de
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

When cross-compiling, by default qemu_datadir is 'c:\Program
Files\QEMU', which is not recognized as being an absolute path, and
meson will end up adding the prefix again.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 contrib/vhost-user-gpu/meson.build | 2 +-
 meson.build                        | 3 ++-
 pc-bios/descriptors/meson.build    | 2 +-
 pc-bios/keymaps/meson.build        | 6 +++---
 pc-bios/meson.build                | 2 +-
 tools/virtiofsd/meson.build        | 2 +-
 trace/meson.build                  | 2 +-
 7 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/contrib/vhost-user-gpu/meson.build b/contrib/vhost-user-gpu/meson.build
index 6c1459f54a..8df4c13bc5 100644
--- a/contrib/vhost-user-gpu/meson.build
+++ b/contrib/vhost-user-gpu/meson.build
@@ -9,5 +9,5 @@ if 'CONFIG_TOOLS' in config_host and 'CONFIG_VIRGL' in config_host \
   configure_file(input: '50-qemu-gpu.json.in',
                  output: '50-qemu-gpu.json',
                  configuration: config_host,
-                 install_dir: config_host['qemu_datadir'] / 'vhost-user')
+                 install_dir: qemu_datadir / 'vhost-user')
 endif
diff --git a/meson.build b/meson.build
index f0fe5f8799..20f20a7bfc 100644
--- a/meson.build
+++ b/meson.build
@@ -17,6 +17,7 @@ config_all_disas = keyval.load(meson.current_build_dir() / 'config-all-disas.mak
 enable_modules = 'CONFIG_MODULES' in config_host
 enable_static = 'CONFIG_STATIC' in config_host
 build_docs = 'BUILD_DOCS' in config_host
+qemu_datadir = get_option('datadir') + get_option('confsuffix')
 config_host_data = configuration_data()
 genh = []
 
@@ -1039,7 +1040,7 @@ foreach target : target_dirs
                       output: exe_name + stp['ext'],
                       capture: true,
                       install: stp['install'],
-                      install_dir: config_host['qemu_datadir'] / '../systemtap/tapset',
+                      install_dir: qemu_datadir / '../systemtap/tapset',
                       command: [
                         tracetool, '--group=all', '--format=' + stp['fmt'],
                         '--binary=' + stp['bin'],
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
index b6389f5148..c11e52ba26 100644
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
index 56e870848e..5f0bf11cb5 100644
--- a/trace/meson.build
+++ b/trace/meson.build
@@ -55,7 +55,7 @@ trace_events_all = custom_target('trace-events-all',
                                  command: [ 'cat', '@INPUT@' ],
                                  capture: true,
                                  install: true,
-                                 install_dir: config_host['qemu_datadir'])
+                                 install_dir: qemu_datadir)
 
 foreach d : [
   ['generated-tcg-tracers.h', 'tcg-h'],
-- 
2.26.2


