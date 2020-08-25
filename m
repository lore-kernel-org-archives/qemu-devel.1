Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40ECDC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 16:27:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0744A2076C
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 16:27:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LZ8hOXZZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0744A2076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34188 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAbnK-0006zk-8Z
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 12:27:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50932)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kAbmf-0006Vm-Os
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 12:26:53 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:28529
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kAbmc-00085H-U5
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 12:26:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598372809;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=p70MgYLFVbMqoyV7PfmUoHB3+RfBuvpZtgT4MVyxYQw=;
 b=LZ8hOXZZMxiT9BJhvw0FCAGNy1R1RL2anGmAYpn12ya5mSFQDAj9AhyXqyNQV10c1g2g0v
 8PiNw38DtwctgPnGYFDk1c7ARvxRuHiOOXxR3ArNIoVwxiAAeuQvtswKrVtVQV3kzSZs8c
 PbzQMQwB+XgHwNNgW8cWyAzZNQtlKmA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-216--j2S_XGJM76PfA1c42VzOg-1; Tue, 25 Aug 2020 12:26:46 -0400
X-MC-Unique: -j2S_XGJM76PfA1c42VzOg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 42E45186A567;
 Tue, 25 Aug 2020 16:26:45 +0000 (UTC)
Received: from thuth.com (ovpn-112-152.ams2.redhat.com [10.36.112.152])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2531A5C1C2;
 Tue, 25 Aug 2020 16:26:33 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH] configure / meson: Fix building with --disable-system and
 virglrenderer
Date: Tue, 25 Aug 2020 18:26:28 +0200
Message-Id: <20200825162628.182885-1-thuth@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=thuth@redhat.com;
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Rafael Kitover <rkitover@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When pixman is not installed (or too old), but virglrenderer is available
and "configure" has been run with "--disable-system", the build currently
aborts when trying to compile vhost-user-gpu (since it requires pixman).
Let's add a proper CONFIG_PIXMAN switch so we can skip the build of
vhost-user-gpu when pixman is not installed or too old.

Fixes: 9b52b17ba5 ("configure: Allow to build tools without pixman")
Reported-by: Rafael Kitover <rkitover@gmail.com>
Reported-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 configure                          | 20 +++++++++++++-------
 contrib/vhost-user-gpu/meson.build |  3 ++-
 meson.build                        | 12 +++++++-----
 3 files changed, 22 insertions(+), 13 deletions(-)

diff --git a/configure b/configure
index b1e11397a8..bddda91477 100755
--- a/configure
+++ b/configure
@@ -3925,15 +3925,18 @@ fi
 ##########################################
 # pixman support probe
 
-if test "$softmmu" = "no"; then
-  pixman_cflags=
-  pixman_libs=
-elif $pkg_config --atleast-version=0.21.8 pixman-1 > /dev/null 2>&1; then
+if $pkg_config --atleast-version=0.21.8 pixman-1 > /dev/null 2>&1; then
+  pixman="yes"
   pixman_cflags=$($pkg_config --cflags pixman-1)
   pixman_libs=$($pkg_config --libs pixman-1)
 else
+  pixman="no"
+  pixman_cflags=
+  pixman_libs=
+fi
+if test "$softmmu" = "yes" && test "$pixman" = "no"; then
   error_exit "pixman >= 0.21.8 not present." \
-      "Please install the pixman devel package."
+      "Please install the pixman devel package or use --disable-system."
 fi
 
 ##########################################
@@ -8054,8 +8057,11 @@ fi
 
 done # for target in $targets
 
-echo "PIXMAN_CFLAGS=$pixman_cflags" >> $config_host_mak
-echo "PIXMAN_LIBS=$pixman_libs" >> $config_host_mak
+if test "$pixman" = "yes"; then
+  echo "CONFIG_PIXMAN=y" >> $config_host_mak
+  echo "PIXMAN_CFLAGS=$pixman_cflags" >> $config_host_mak
+  echo "PIXMAN_LIBS=$pixman_libs" >> $config_host_mak
+fi
 
 if [ "$fdt" = "git" ]; then
   subdirs="$subdirs dtc"
diff --git a/contrib/vhost-user-gpu/meson.build b/contrib/vhost-user-gpu/meson.build
index 6c1459f54a..142daebfd7 100644
--- a/contrib/vhost-user-gpu/meson.build
+++ b/contrib/vhost-user-gpu/meson.build
@@ -1,5 +1,6 @@
 if 'CONFIG_TOOLS' in config_host and 'CONFIG_VIRGL' in config_host \
-    and 'CONFIG_GBM' in config_host and 'CONFIG_LINUX' in config_host
+    and 'CONFIG_GBM' in config_host and 'CONFIG_LINUX' in config_host \
+    and 'CONFIG_PIXMAN' in config_host
   executable('vhost-user-gpu', files('vhost-user-gpu.c', 'virgl.c', 'vugbm.c'),
              link_with: libvhost_user,
              dependencies: [qemuutil, pixman, gbm, virgl],
diff --git a/meson.build b/meson.build
index 7fbb7ab2fb..9eecea549c 100644
--- a/meson.build
+++ b/meson.build
@@ -113,8 +113,11 @@ if 'CONFIG_GNUTLS' in config_host
   gnutls = declare_dependency(compile_args: config_host['GNUTLS_CFLAGS'].split(),
                               link_args: config_host['GNUTLS_LIBS'].split())
 endif
-pixman = declare_dependency(compile_args: config_host['PIXMAN_CFLAGS'].split(),
-                            link_args: config_host['PIXMAN_LIBS'].split())
+pixman = not_found
+if 'CONFIG_PIXMAN' in config_host
+  pixman = declare_dependency(compile_args: config_host['PIXMAN_CFLAGS'].split(),
+                              link_args: config_host['PIXMAN_LIBS'].split())
+endif
 pam = not_found
 if 'CONFIG_AUTH_PAM' in config_host
   pam = cc.find_library('pam')
@@ -1095,9 +1098,7 @@ if have_tools
   if 'CONFIG_VHOST_USER' in config_host
     subdir('contrib/libvhost-user')
     subdir('contrib/vhost-user-blk')
-    if 'CONFIG_LINUX' in config_host
-      subdir('contrib/vhost-user-gpu')
-    endif
+    subdir('contrib/vhost-user-gpu')
     subdir('contrib/vhost-user-input')
     subdir('contrib/vhost-user-scsi')
   endif
@@ -1278,6 +1279,7 @@ summary_info += {'SDL image support': sdl_image.found()}
 # TODO: add back version
 summary_info += {'GTK support':       config_host.has_key('CONFIG_GTK')}
 summary_info += {'GTK GL support':    config_host.has_key('CONFIG_GTK_GL')}
+summary_info += {'pixman support':    config_host.has_key('CONFIG_PIXMAN')}
 # TODO: add back version
 summary_info += {'VTE support':       config_host.has_key('CONFIG_VTE')}
 summary_info += {'TLS priority':      config_host['CONFIG_TLS_PRIORITY']}
-- 
2.18.2


