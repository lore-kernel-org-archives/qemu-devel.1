Return-Path: <SRS0=kYy5=B4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 374D1C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 14:36:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03B092076E
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 14:36:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S6bgA8VH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03B092076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34094 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k82iy-0000td-7s
	for qemu-devel@archiver.kernel.org; Tue, 18 Aug 2020 10:36:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60672)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k82Ke-0003uo-Rm
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 10:11:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50536)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k82KV-0007O9-75
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 10:11:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597759869;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qqdL9+hfpj3xO2gLQDBiI5vJuaapsdLAWlOqA5GFCik=;
 b=S6bgA8VHA2nxGb2dfjJvaJpDdzMdELsoSOsnM/JMwSPlLv11tftOQyyvMeUId4Af+9aQFL
 hqXcknqhPrnPLG7/wBFEdTqQ2HhUr46w/J8t8J6SMgK/flCJgOnsTSsp64t9MXuDAA4kPy
 LjRr1yfSdrvylqYlQ/kVuJ8EFSYS1yQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-333-oD9GhPXsMC6HG16eCMWqgQ-1; Tue, 18 Aug 2020 10:11:08 -0400
X-MC-Unique: oD9GhPXsMC6HG16eCMWqgQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5DB54802B47
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2020 14:11:07 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2335F5C64D
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2020 14:11:07 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 043/150] meson: convert dummy Windows qga/qemu-ga target
Date: Tue, 18 Aug 2020 10:08:38 -0400
Message-Id: <20200818141025.21608-44-pbonzini@redhat.com>
In-Reply-To: <20200818141025.21608-1-pbonzini@redhat.com>
References: <20200818141025.21608-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/18 03:22:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
index f8e5ebaff9..a61c66096e 100644
--- a/Makefile
+++ b/Makefile
@@ -441,11 +441,6 @@ qemu-img-cmds.h: $(SRC_PATH)/qemu-img-cmds.hx $(SRC_PATH)/scripts/hxtool
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
index 33f6db2865..2b91261427 100644
--- a/qga/meson.build
+++ b/qga/meson.build
@@ -44,6 +44,7 @@ qga = executable('qemu-ga', qga_ss.sources(),
                  link_args: config_host['LIBS_QGA'].split(),
                  dependencies: [qemuutil, libudev],
                  install: true)
+all_qga = [qga]
 
 if targetos == 'windows'
   if 'CONFIG_QGA_VSS' in config_host
@@ -72,6 +73,9 @@ if targetos == 'windows'
                               config_host['QEMU_GA_MSI_WITH_VSS'].split(),
                               config_host['QEMU_GA_MSI_MINGW_DLL_PATH'].split(),
                             ])
+    all_qga += [qga_msi]
     alias_target('msi', qga_msi)
   endif
 endif
+
+alias_target('qemu-ga', all_qga)
diff --git a/qga/vss-win32/meson.build b/qga/vss-win32/meson.build
index 1f39e05335..780c461432 100644
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
2.26.2



