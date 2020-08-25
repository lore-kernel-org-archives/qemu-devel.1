Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AB4CC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 15:06:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 370E92075F
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 15:06:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sc/A1iCm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 370E92075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56030 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAaX3-0003ic-GS
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 11:06:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54558)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1kAaVC-0008LZ-20
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 11:04:46 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47469
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1kAaVA-0003EY-AP
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 11:04:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598367883;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=408pICv+ubcqoi+Lk7I4/D0jqt+4yOugK8fHMuPjHi4=;
 b=Sc/A1iCmwxL2oCeQhgJhecmOtVtKr7DRpF/oxZwa4EOSuCw98MCoQoFPX6FSlVhLnNbu+4
 fT0bl09KS64TSNkwvW2U/zgBhUvj1NGE6LBFG6SImrqP3zb4IzbwJy1wZI1jF6cetnUp0L
 1aG8HFeeWb9A4dMN6c7iHKDbJ8SjqIY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-4-I36FZexcOli2_TQq-VT93w-1; Tue, 25 Aug 2020 11:04:38 -0400
X-MC-Unique: I36FZexcOli2_TQq-VT93w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E1D1218B9F84;
 Tue, 25 Aug 2020 15:04:37 +0000 (UTC)
Received: from localhost (unknown [10.36.110.43])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BE0C41002382;
 Tue, 25 Aug 2020 15:04:36 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Subject: [PATCH 3/5] meson: add docdir option and pass pre-prefix qemu_docdir
Date: Tue, 25 Aug 2020 19:04:07 +0400
Message-Id: <20200825150409.346957-4-marcandre.lureau@redhat.com>
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
Received-SPF: pass client-ip=205.139.110.120;
 envelope-from=marcandre.lureau@redhat.com; helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/25 10:39:45
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.958,
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
Cc: pbonzini@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 sw@weilnetz.de
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

When cross-compiling, by default qemu_docdir is 'c:\Program Files\QEMU\'
which is not recognized as being an absolute path, and meson will end up
adding the prefix again.

Add an option to pass docdir location to meson, pre-prefixed like we do
with other directories and use that instead of config_host['qemu_docdir'].

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 configure         | 1 +
 docs/meson.build  | 4 ++--
 meson.build       | 3 ++-
 meson_options.txt | 1 +
 4 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/configure b/configure
index e19e2de2f0..e644841299 100755
--- a/configure
+++ b/configure
@@ -8223,6 +8223,7 @@ NINJA=$PWD/ninjatool $meson setup \
         --sysconfdir "${pre_prefix}$sysconfdir" \
         --localstatedir "${pre_prefix}$local_statedir" \
         -Dconfsuffix="$confsuffix" \
+        -Ddocdir="${pre_prefix}$qemu_docdir" \
         -Doptimization=$(if test "$debug" = yes; then echo 0; else echo 2; fi) \
         -Ddebug=$(if test "$debug_info" = yes; then echo true; else echo false; fi) \
         -Dwerror=$(if test "$werror" = yes; then echo true; else echo false; fi) \
diff --git a/docs/meson.build b/docs/meson.build
index 8b059a8e39..e27f4632dc 100644
--- a/docs/meson.build
+++ b/docs/meson.build
@@ -10,7 +10,7 @@ if build_docs
   configure_file(output: 'index.html',
                  input: files('index.html.in'),
                  configuration: {'VERSION': meson.project_version()},
-                 install_dir: config_host['qemu_docdir'])
+                 install_dir: get_option('docdir'))
   manuals = [ 'devel', 'interop', 'tools', 'specs', 'system', 'user' ]
   man_pages = {
     'interop' : {
@@ -48,7 +48,7 @@ if build_docs
                           input_dir, output_dir])
     sphinxdocs += this_manual
     if build_docs and manual != 'devel'
-      install_subdir(output_dir, install_dir: config_host['qemu_docdir'])
+      install_subdir(output_dir, install_dir: get_option('docdir'))
     endif
 
     these_man_pages = []
diff --git a/meson.build b/meson.build
index 20f20a7bfc..33281cecc3 100644
--- a/meson.build
+++ b/meson.build
@@ -1170,7 +1170,7 @@ if build_docs
                       input: input,
                       output: output,
                       install: true,
-                      install_dir: config_host['qemu_docdir'] / 'interop',
+                      install_dir: get_option('docdir') / 'interop',
                       command: cmd + args)
       endforeach
       alias_target(ext, t)
@@ -1233,6 +1233,7 @@ if targetos != 'windows'
 else
   summary_info += {'local state directory': 'queried at runtime'}
 endif
+summary_info += {'Doc directory':     get_option('docdir')}
 summary_info += {'Build directory':   meson.current_build_dir()}
 summary_info += {'Source path':       meson.current_source_dir()}
 summary_info += {'GIT binary':        config_host['GIT']}
diff --git a/meson_options.txt b/meson_options.txt
index 7bb2c0fca9..fb9312fddd 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -1,4 +1,5 @@
 option('confsuffix', type : 'string', value: 'qemu')
+option('docdir', type : 'string', value : 'doc/qemu')
 option('gettext', type : 'boolean', value : true)
 option('sdl', type : 'feature', value : 'auto')
 option('sdl_image', type : 'feature', value : 'auto')
-- 
2.26.2


