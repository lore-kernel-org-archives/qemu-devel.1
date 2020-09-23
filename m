Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E98DC2D0A8
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 09:23:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42AF1206C3
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 09:23:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OPqVuKMC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42AF1206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58922 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kL0zi-0007dH-C9
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 05:23:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53134)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kL0ob-0001FZ-RQ
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 05:11:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:59617)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kL0oS-0002NK-Jz
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 05:11:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600852300;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Zol1UWcSpKQ8U9Job7N6WZnjxvZkufjGjnAueQatn84=;
 b=OPqVuKMCwrxSAKZLluDReOokuAU9sdzGiZfXPHETV+pbtBqfA0wpKg+tfg4a+8zlzymJK9
 hGxytBEFCpKTzl+I0WkHm8BY7uG1K5kRaS2UVgXmPGHaSEcfz39Hz8RyLik0TadNiIcUPn
 uKS+wiyKAHmOwlZtbtBWLliivPcWCr4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-422-11yM0X-1NKCTnXLYL3MXNw-1; Wed, 23 Sep 2020 05:11:39 -0400
X-MC-Unique: 11yM0X-1NKCTnXLYL3MXNw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 217331005E72;
 Wed, 23 Sep 2020 09:11:38 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C5A0919D61;
 Wed, 23 Sep 2020 09:11:37 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 10/12] configure: move OpenBSD W^X test to meson
Date: Wed, 23 Sep 2020 05:11:29 -0400
Message-Id: <20200923091131.1591563-11-pbonzini@redhat.com>
In-Reply-To: <20200923091131.1591563-1-pbonzini@redhat.com>
References: <20200923091131.1591563-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/23 00:53:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
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
Cc: richard.henderson@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The TCG option is now passed through to Meson.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure   | 15 ---------------
 meson.build |  8 +++++++-
 2 files changed, 7 insertions(+), 16 deletions(-)

diff --git a/configure b/configure
index 6e60de3e07..fb450858ff 100755
--- a/configure
+++ b/configure
@@ -1598,10 +1598,6 @@ if [ "$ARCH" = "unknown" ]; then
   linux_user="no"
 fi
 
-if [ "$bsd_user" = "no" -a "$linux_user" = "no" -a "$softmmu" = "no" ] ; then
-  tcg="disabled"
-fi
-
 default_target_list=""
 deprecated_targets_list=ppc64abi32-linux-user,tilegx-linux-user,lm32-softmmu,unicore32-softmmu
 deprecated_features=""
@@ -6062,17 +6058,6 @@ if test "$mingw32" = "yes" ; then
     done
 fi
 
-# Disable OpenBSD W^X if available
-if test "$tcg" = "enabled" && test "$targetos" = "OpenBSD"; then
-    cat > $TMPC <<EOF
-    int main(void) { return 0; }
-EOF
-    wx_ldflags="-Wl,-z,wxneeded"
-    if compile_prog "" "$wx_ldflags"; then
-        QEMU_LDFLAGS="$QEMU_LDFLAGS $wx_ldflags"
-    fi
-fi
-
 qemu_confdir="$sysconfdir/$qemu_suffix"
 qemu_moddir="$libdir/$qemu_suffix"
 qemu_datadir="$datadir/$qemu_suffix"
diff --git a/meson.build b/meson.build
index d25ead3ad5..c66bc19e07 100644
--- a/meson.build
+++ b/meson.build
@@ -124,6 +124,7 @@ socket = []
 version_res = []
 coref = []
 iokit = []
+emulator_link_args = []
 cocoa = not_found
 hvf = not_found
 if targetos == 'windows'
@@ -146,6 +147,11 @@ elif targetos == 'haiku'
   socket = [cc.find_library('posix_error_mapper'),
             cc.find_library('network'),
             cc.find_library('bsd')]
+elif targetos == 'openbsd'
+  if not get_option('tcg').disabled() and target_dirs.length() > 0
+    # Disable OpenBSD W^X if available
+    emulator_link_args = cc.get_supported_link_arguments('-Wl,-z,wxneeded')
+  endif
 endif
 
 accelerators = []
@@ -1231,7 +1237,7 @@ foreach target : target_dirs
   c_args = ['-DNEED_CPU_H',
             '-DCONFIG_TARGET="@0@-config-target.h"'.format(target),
             '-DCONFIG_DEVICES="@0@-config-devices.h"'.format(target)]
-  link_args = []
+  link_args = emulator_link_args
 
   config_target += config_host
   target_inc = [include_directories('target' / config_target['TARGET_BASE_ARCH'])]
-- 
2.26.2



