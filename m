Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFF7BC433E6
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 11:12:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B96F3207DF
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 11:12:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EV6Rx5zk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B96F3207DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50968 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBcIj-0001wg-00
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 07:12:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39604)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1kBcFX-0003Z7-Dt
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 07:08:51 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:26864
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1kBcFU-0000So-O1
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 07:08:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598612927;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PMzYvH/XagGy2DlxTxsTL5VV0dnEH9JusMzgMwaZZqQ=;
 b=EV6Rx5zkLtSTdXn6mKLVi+q2MU/YgWNQd6On7glMPzb3nDA2agRMvcBQq2z3zC6JnjBd4N
 bPfBniVbDMT7DjcSRR9grZ1Xi/DI8Rs7FLttLoCJXnTKTWDNqpEIPCO4FpUazC0lQaZhWg
 Tplr+XOT05+ct2HstuH6bleDy70gkb0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-388-stAQCPwvOXakvnclZTm8Bg-1; Fri, 28 Aug 2020 07:08:45 -0400
X-MC-Unique: stAQCPwvOXakvnclZTm8Bg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BCB7A88127C
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 11:08:44 +0000 (UTC)
Received: from localhost (unknown [10.36.110.10])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 116467D4F6;
 Fri, 28 Aug 2020 11:08:40 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Subject: [PATCH 07/16] meson: move keyutils dependency check
Date: Fri, 28 Aug 2020 15:07:25 +0400
Message-Id: <20200828110734.1638685-8-marcandre.lureau@redhat.com>
In-Reply-To: <20200828110734.1638685-1-marcandre.lureau@redhat.com>
References: <20200828110734.1638685-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=marcandre.lureau@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/28 07:07:45
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Since there is not minimum version specified, and it's a test-only
dependency, it's fair to depend on a version that ships with a .pc I
suppose.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 configure   | 25 -------------------------
 meson.build |  6 ++----
 2 files changed, 2 insertions(+), 29 deletions(-)

diff --git a/configure b/configure
index 2471483bec..cb81fbc9b3 100755
--- a/configure
+++ b/configure
@@ -6324,28 +6324,6 @@ but not implemented on your system"
     fi
 fi
 
-##########################################
-# check for usable keyutils.h
-
-if test "$linux" = "yes" ; then
-
-    have_keyutils=no
-    cat > $TMPC << EOF
-#include <errno.h>
-#include <asm/unistd.h>
-#include <unistd.h>
-#include <sys/types.h>
-#include <keyutils.h>
-int main(void) {
-    return request_key("user", NULL, NULL, 0);
-}
-EOF
-    if compile_prog "" "-lkeyutils"; then
-        have_keyutils=yes
-    fi
-fi
-
-
 ##########################################
 # End of CC checks
 # After here, no more $cc or $ld runs
@@ -7535,9 +7513,6 @@ fi
 
 if test "$secret_keyring" = "yes" ; then
   echo "CONFIG_SECRET_KEYRING=y" >> $config_host_mak
-  if test "$have_keyutils" = "yes" ; then
-    echo "CONFIG_KEYUTILS=y" >> $config_host_mak
-  fi
 fi
 
 if test "$tcg_interpreter" = "yes"; then
diff --git a/meson.build b/meson.build
index d69dd846d1..421f53083e 100644
--- a/meson.build
+++ b/meson.build
@@ -406,10 +406,7 @@ if 'CONFIG_TASN1' in config_host
   tasn1 = declare_dependency(compile_args: config_host['TASN1_CFLAGS'].split(),
                              link_args: config_host['TASN1_LIBS'].split())
 endif
-keyutils = not_found
-if 'CONFIG_KEYUTILS' in config_host
-  keyutils = declare_dependency(link_args: '-lkeyutils')
-endif
+keyutils = dependency('keyutils', required: false)
 
 # Create config-host.h
 
@@ -420,6 +417,7 @@ config_host_data.set('CONFIG_VNC_JPEG', jpeg.found())
 config_host_data.set('CONFIG_VNC_PNG', png.found())
 config_host_data.set('CONFIG_VNC_SASL', sasl.found())
 config_host_data.set('CONFIG_XKBCOMMON', xkbcommon.found())
+config_host_data.set('CONFIG_KEYUTILS', keyutils.found())
 config_host_data.set('QEMU_VERSION', '"@0@"'.format(meson.project_version()))
 config_host_data.set('QEMU_VERSION_MAJOR', meson.project_version().split('.')[0])
 config_host_data.set('QEMU_VERSION_MINOR', meson.project_version().split('.')[1])
-- 
2.26.2


