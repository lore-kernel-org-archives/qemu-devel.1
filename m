Return-Path: <SRS0=MBD3=C4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6E45C43463
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2020 16:44:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FD36208DB
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2020 16:44:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZnukCOnH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FD36208DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50682 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJfyQ-00045B-8d
	for qemu-devel@archiver.kernel.org; Sat, 19 Sep 2020 12:44:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51778)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kJfHb-0005kW-Ua
 for qemu-devel@nongnu.org; Sat, 19 Sep 2020 12:00:15 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36314
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kJfHM-0007R2-KQ
 for qemu-devel@nongnu.org; Sat, 19 Sep 2020 12:00:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600531190;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e2sJKZqKafTOzd1p5yXwll+9kazSOrzlw8kQ0zp2kLk=;
 b=ZnukCOnHP8foRx5You4kXVpKurnMV7AORTCKRKsVP0jR5XyGGRkL0z5uRu3RYU0EnSF/4U
 Il6+q/DdDz4ruuaJ6xNNYdY3uwGFaEyIiOnAeDRRBl/T2Krya3oYV0dWP+LaC/7zT5L3S4
 5LGewgyaaqMWmk+lqTllHHHFItE1HG8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-432-7ZdZ8lw3M2aOvYjGT9OaxQ-1; Sat, 19 Sep 2020 11:59:48 -0400
X-MC-Unique: 7ZdZ8lw3M2aOvYjGT9OaxQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BBC7E186DD4B
 for <qemu-devel@nongnu.org>; Sat, 19 Sep 2020 15:59:47 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 794B310016DA;
 Sat, 19 Sep 2020 15:59:47 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 38/57] meson: qtest: set "depends" correctly
Date: Sat, 19 Sep 2020 11:58:57 -0400
Message-Id: <20200919155916.1046398-39-pbonzini@redhat.com>
In-Reply-To: <20200919155916.1046398-1-pbonzini@redhat.com>
References: <20200919155916.1046398-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/19 11:59:21
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
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
index 848223778d..f5c9c04e40 100644
--- a/meson.build
+++ b/meson.build
@@ -1094,7 +1094,7 @@ common_all = static_library('common',
 
 feature_to_c = find_program('scripts/feature_to_c.sh')
 
-emulators = []
+emulators = {}
 foreach target : target_dirs
   config_target = config_target_mak[target]
   target_name = config_target['TARGET_NAME']
@@ -1213,7 +1213,8 @@ foreach target : target_dirs
     }]
   endif
   foreach exe: execs
-    emulators += executable(exe['name'], exe['sources'],
+    emulators += {exe['name']:
+         executable(exe['name'], exe['sources'],
                install: true,
                c_args: c_args,
                dependencies: arch_deps + deps + exe['dependencies'],
@@ -1222,6 +1223,7 @@ foreach target : target_dirs
                link_depends: [block_syms, qemu_syms] + exe.get('link_depends', []),
                link_args: link_args,
                gui_app: exe['gui'])
+    }
 
     if 'CONFIG_TRACE_SYSTEMTAP' in config_host
       foreach stp: [
@@ -1267,7 +1269,6 @@ if xkbcommon.found()
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



