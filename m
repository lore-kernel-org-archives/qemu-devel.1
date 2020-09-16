Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FEABC43461
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 09:09:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 063892076C
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 09:09:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZuBoI/hf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 063892076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56382 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kITRX-0006a5-5h
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 05:09:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40848)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kITMf-0000lB-CF
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 05:04:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52489)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kITMb-0002ON-PQ
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 05:04:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600247066;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=EASTyF67oq66+Vc2RV+pd6rY0bAWEKeB8siyCBB3t2s=;
 b=ZuBoI/hf5EVb/txNJgDlIgMEXFn20GdQQFAJHHG6ucIxlDiD1CcQHvfcFfz9Sn5TEbsLGe
 TedLiDZkuD4aCLPNtWPjOiSUCNaiEidRN/VCsQTUrkJBVYMowXivGZDPfsRgX8Lm6sQBbV
 1/d+ZDLAiBXkVp2R8ODl1oxID80vlXI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-183-zSoEZgXuNVSG6GXQ_cvV6Q-1; Wed, 16 Sep 2020 05:04:24 -0400
X-MC-Unique: zSoEZgXuNVSG6GXQ_cvV6Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B18A88015FD
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2020 09:04:23 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6E49678806;
 Wed, 16 Sep 2020 09:04:23 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] meson: qtest: set "depends" correctly
Date: Wed, 16 Sep 2020 05:04:22 -0400
Message-Id: <20200916090422.9695-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 02:16:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
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
Cc: Thomas Huth <thuth@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This does not have any effect on Meson's behavior itself, since "meson test"
always rebuilds everything (that is one reason why we are not using it...).
However, mtest2make can use this information to do a selective rebuild
for the requested suite.

Cc: Thomas Huth <thuth@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build             | 7 ++++---
 tests/qtest/meson.build | 2 ++
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/meson.build b/meson.build
index c94e92d774..31ddd7cc29 100644
--- a/meson.build
+++ b/meson.build
@@ -1011,7 +1011,7 @@ common_all = static_library('common',
 
 feature_to_c = find_program('scripts/feature_to_c.sh')
 
-emulators = []
+emulators = {}
 foreach target : target_dirs
   config_target = config_target_mak[target]
   target_name = config_target['TARGET_NAME']
@@ -1130,7 +1130,8 @@ foreach target : target_dirs
     }]
   endif
   foreach exe: execs
-    emulators += executable(exe['name'], exe['sources'],
+    emulators += {exe['name']:
+         executable(exe['name'], exe['sources'],
                install: true,
                c_args: c_args,
                dependencies: arch_deps + deps + exe['dependencies'],
@@ -1139,6 +1140,7 @@ foreach target : target_dirs
                link_depends: [block_syms, qemu_syms] + exe.get('link_depends', []),
                link_args: link_args,
                gui_app: exe['gui'])
+    }
 
     if 'CONFIG_TRACE_SYSTEMTAP' in config_host
       foreach stp: [
@@ -1184,7 +1186,6 @@ if xkbcommon.found()
                            dependencies: [qemuutil, xkbcommon], install: have_tools)
 endif
 
-qemu_block_tools = []
 if have_tools
   qemu_img = executable('qemu-img', [files('qemu-img.c'), hxdep],
              dependencies: [authz, block, crypto, io, qom, qemuutil], install: true)
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 874b5be62b..359a6cde64 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -228,6 +228,7 @@ foreach dir : target_dirs
   endif
 
   target_base = dir.split('-')[0]
+  qtest_emulator = emulators['qemu-system-' + target_base]
   qtests = get_variable('qtests_' + target_base, []) + qtests_generic
 
   qtest_env = environment()
@@ -248,6 +249,7 @@ foreach dir : target_dirs
     # FIXME: missing dependency on the emulator binary and qemu-img
     test('qtest-@0@: @1@'.format(target_base, test),
          qtest_executables[test],
+         depends: [qemu_img, qtest_emulator],
          env: qtest_env,
          args: ['--tap', '-k'],
          protocol: 'tap',
-- 
2.26.2


