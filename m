Return-Path: <SRS0=QvPl=BU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B39DFC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 17:24:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C3A520825
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 17:24:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dw2fD9wg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C3A520825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43674 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5BXN-0001L0-K1
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 13:24:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45604)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k5BJV-0007X2-6i
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 13:10:21 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:42924
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k5BJS-0002pT-BG
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 13:10:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597079417;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=1BWOI/nEMBAbcdH3Hg9U1VAqfDrfVzd49qKJhFbH1K4=;
 b=Dw2fD9wgU9J7BMJXGf4YV9zKvDIbN+H98eHCRTlHxQlNhNJP1Mu4msEAvt+wg3Jg704Uz8
 d4Shm0X3M44ak7ces6myFBhPtSH7sH6cQeeAUnE6zsXJ/wwToJ3WzxXTOkGftccIXKYtQl
 gLGAmf1PX7CcNmLC9QPTDvEK0j5oCmQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-336-OK-pLXFWNU6RnRWZK8ibMA-1; Mon, 10 Aug 2020 13:10:14 -0400
X-MC-Unique: OK-pLXFWNU6RnRWZK8ibMA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A1D0D19057AC
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2020 17:10:13 +0000 (UTC)
Received: from 640k.localdomain.com (unknown [10.36.110.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E79BC71927
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2020 17:10:12 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 039/147] meson: convert dummy Windows qga/qemu-ga target
Date: Mon, 10 Aug 2020 19:07:17 +0200
Message-Id: <1597079345-42801-40-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1597079345-42801-1-git-send-email-pbonzini@redhat.com>
References: <1597079345-42801-1-git-send-email-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/10 03:29:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile                  | 5 -----
 qga/meson.build           | 4 ++++
 qga/vss-win32/meson.build | 2 ++
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/Makefile b/Makefile
index 3aeadfb..b844b06 100644
--- a/Makefile
+++ b/Makefile
@@ -434,11 +434,6 @@ qemu-img-cmds.h: $(SRC_PATH)/qemu-img-cmds.hx $(SRC_PATH)/scripts/hxtool
 qemu-keymap$(EXESUF): LIBS += $(XKBCOMMON_LIBS)
 qemu-keymap$(EXESUF): QEMU_CFLAGS += $(XKBCOMMON_CFLAGS)
 
-ifneq ($(EXESUF),)
-.PHONY: qga/qemu-ga
-qga/qemu-ga: qga/qemu-ga$(EXESUF) $(QGA_VSS_PROVIDER) $(QEMU_GA_MSI)
-endif
-
 module_block.h: $(SRC_PATH)/scripts/modules/module_block.py config-host.mak
 	$(call quiet-command,$(PYTHON) $< $@ \
 	$(addprefix $(SRC_PATH)/,$(patsubst %.mo,%.c,$(block-obj-m))), \
diff --git a/qga/meson.build b/qga/meson.build
index 2d33c09..7e7174b 100644
--- a/qga/meson.build
+++ b/qga/meson.build
@@ -44,6 +44,7 @@ qga = executable('qemu-ga', qga_ss.sources(),
                  link_args: config_host['LIBS_QGA'].split(),
                  dependencies: [qemuutil, libudev],
                  install: true)
+all_qga = [qga]
 
 if host_machine.system() == 'windows'
   if 'CONFIG_QGA_VSS' in config_host
@@ -72,6 +73,9 @@ if host_machine.system() == 'windows'
                               config_host['QEMU_GA_MSI_WITH_VSS'].split(),
                               config_host['QEMU_GA_MSI_MINGW_DLL_PATH'].split(),
                             ])
+    all_qga += [qga-msi]
     alias_target('msi', qga_msi)
   endif
 endif
+
+alias_target('qemu-ga', all_qga)
diff --git a/qga/vss-win32/meson.build b/qga/vss-win32/meson.build
index 1f39e05..780c461 100644
--- a/qga/vss-win32/meson.build
+++ b/qga/vss-win32/meson.build
@@ -14,6 +14,8 @@ if add_languages('cpp', required: false)
                                cc.find_library('shlwapi'),
                                cc.find_library('uuid'),
                                cc.find_library('intl')])
+
+  all_qga += qga_vss
 endif
 
 # rules to build qga-vss.tlb
-- 
1.8.3.1



