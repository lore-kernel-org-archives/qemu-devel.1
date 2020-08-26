Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08130C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 11:09:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4F832083B
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 11:09:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BhXdqNZ4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4F832083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46276 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAtJ1-0003AL-U6
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 07:09:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47550)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1kAtH2-0007yS-A6
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 07:07:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:35513)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1kAtF5-0003AU-O9
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 07:07:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598439922;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=karPnwRB29YKb9UlONxE3BzVQ4QV21LXDN2SYRgYcFQ=;
 b=BhXdqNZ4ZYyIA4fqbpEuSaTR92orCqyFvlQYP9HonWcjOPYD7hwweXBR4OISHLuu2xoeUk
 Y0QeZ1byc6TBs9BXzu4vW53T2KHTGCF7DMRguHtgELH8/dIv9T/Gm5rVDHujoI+TpwzF6f
 agnUhzhlQW3Eh74M4z5lArXNZuyLbEk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-10--tzdSrpSNhqnLL5mL9f5nA-1; Wed, 26 Aug 2020 07:05:18 -0400
X-MC-Unique: -tzdSrpSNhqnLL5mL9f5nA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7C79556BE3;
 Wed, 26 Aug 2020 11:05:17 +0000 (UTC)
Received: from localhost (unknown [10.36.110.43])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EFF0460C0F;
 Wed, 26 Aug 2020 11:05:13 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Subject: [PATCH v3 6/8] meson: pass docdir option
Date: Wed, 26 Aug 2020 15:04:17 +0400
Message-Id: <20200826110419.528931-7-marcandre.lureau@redhat.com>
In-Reply-To: <20200826110419.528931-1-marcandre.lureau@redhat.com>
References: <20200826110419.528931-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=marcandre.lureau@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/26 06:53:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: sw@weilnetz.de, berrange@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

When cross-compiling, by default qemu_docdir is 'c:\Program Files\QEMU\'
which is not recognized as being an absolute path, and meson will end up
adding the prefix again.

Add an option to pass docdir location to meson, pre-prefixed like we do
with other directories, build qemu_docdir with the common suffix and use
that instead of config_host['qemu_docdir'].

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 configure         | 1 +
 docs/meson.build  | 4 ++--
 meson.build       | 4 +++-
 meson_options.txt | 2 ++
 4 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/configure b/configure
index 05b944fb8e..7b6a4a8264 100755
--- a/configure
+++ b/configure
@@ -8223,6 +8223,7 @@ NINJA=$PWD/ninjatool $meson setup \
         --mandir "${pre_prefix}$mandir" \
         --sysconfdir "${pre_prefix}$sysconfdir" \
         --localstatedir "${pre_prefix}$local_statedir" \
+        -Ddocdir="${pre_prefix}$docdir" \
         -Dqemu_suffix="$qemu_suffix" \
         -Doptimization=$(if test "$debug" = yes; then echo 0; else echo 2; fi) \
         -Ddebug=$(if test "$debug_info" = yes; then echo true; else echo false; fi) \
diff --git a/docs/meson.build b/docs/meson.build
index 8b059a8e39..50f367349b 100644
--- a/docs/meson.build
+++ b/docs/meson.build
@@ -10,7 +10,7 @@ if build_docs
   configure_file(output: 'index.html',
                  input: files('index.html.in'),
                  configuration: {'VERSION': meson.project_version()},
-                 install_dir: config_host['qemu_docdir'])
+                 install_dir: qemu_docdir)
   manuals = [ 'devel', 'interop', 'tools', 'specs', 'system', 'user' ]
   man_pages = {
     'interop' : {
@@ -48,7 +48,7 @@ if build_docs
                           input_dir, output_dir])
     sphinxdocs += this_manual
     if build_docs and manual != 'devel'
-      install_subdir(output_dir, install_dir: config_host['qemu_docdir'])
+      install_subdir(output_dir, install_dir: qemu_docdir)
     endif
 
     these_man_pages = []
diff --git a/meson.build b/meson.build
index 9f0d7d3830..7570aab830 100644
--- a/meson.build
+++ b/meson.build
@@ -18,6 +18,7 @@ enable_modules = 'CONFIG_MODULES' in config_host
 enable_static = 'CONFIG_STATIC' in config_host
 build_docs = 'BUILD_DOCS' in config_host
 qemu_datadir = get_option('datadir') / get_option('qemu_suffix')
+qemu_docdir = get_option('docdir') / get_option('qemu_suffix')
 config_host_data = configuration_data()
 genh = []
 
@@ -1170,7 +1171,7 @@ if build_docs
                       input: input,
                       output: output,
                       install: true,
-                      install_dir: config_host['qemu_docdir'] / 'interop',
+                      install_dir: qemu_docdir / 'interop',
                       command: cmd + args)
       endforeach
       alias_target(ext, t)
@@ -1233,6 +1234,7 @@ if targetos != 'windows'
 else
   summary_info += {'local state directory': 'queried at runtime'}
 endif
+summary_info += {'Doc directory':     get_option('docdir')}
 summary_info += {'Build directory':   meson.current_build_dir()}
 summary_info += {'Source path':       meson.current_source_dir()}
 summary_info += {'GIT binary':        config_host['GIT']}
diff --git a/meson_options.txt b/meson_options.txt
index 9e8db82995..555b860902 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -1,5 +1,7 @@
 option('qemu_suffix', type : 'string', value: 'qemu',
        description: 'Suffix for QEMU data/modules/config directories (can be empty)')
+option('docdir', type : 'string', value : 'doc',
+       description: 'Base directory for documentation installation (can be empty)')
 option('gettext', type : 'boolean', value : true)
 option('sdl', type : 'feature', value : 'auto')
 option('sdl_image', type : 'feature', value : 'auto')
-- 
2.26.2


