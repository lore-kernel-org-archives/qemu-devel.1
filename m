Return-Path: <SRS0=BZbV=DR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07129C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 08:03:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AFEB207C4
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 08:03:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CaSAEQdq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AFEB207C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40114 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kR9qN-00022i-OL
	for qemu-devel@archiver.kernel.org; Sat, 10 Oct 2020 04:03:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41222)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kR9lO-0004If-AT
 for qemu-devel@nongnu.org; Sat, 10 Oct 2020 03:57:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:27344)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kR9lJ-0006hw-Df
 for qemu-devel@nongnu.org; Sat, 10 Oct 2020 03:57:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602316672;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K3LXVZ6KMWOK4xQ4FlrQkIzFIzfkyJlH2adOkOKEJm4=;
 b=CaSAEQdqbeu6ctWPOoBiE5zruT899hcaNmDk9OVw9+ikyPtFqMB//R0kMN0Pj7tTXwO6l1
 kSYh/5BraIgSAGpa442zN/opb+FChd3ZUkDZ/Ym01FemZNgmvuI1r2lf1k693Ycx/fLgmh
 NGBVln8eHyB7+Z5aLYVhV6vVA8FxqZI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-264-H0icSZqgNQCCIid7at6hYg-1; Sat, 10 Oct 2020 03:57:50 -0400
X-MC-Unique: H0icSZqgNQCCIid7at6hYg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 764BC3FE7
 for <qemu-devel@nongnu.org>; Sat, 10 Oct 2020 07:57:47 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4585A6EF6E
 for <qemu-devel@nongnu.org>; Sat, 10 Oct 2020 07:57:47 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 18/39] qtest: unify extra_qtest_srcs and extra_qtest_deps
Date: Sat, 10 Oct 2020 03:57:18 -0400
Message-Id: <20201010075739.951385-19-pbonzini@redhat.com>
In-Reply-To: <20201010075739.951385-1-pbonzini@redhat.com>
References: <20201010075739.951385-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/10 03:36:24
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Currently the extra sources and extra dependencies of qtests are held
in two separate dictionaries.  Use the same trick as tests/meson.build
to combine them into one.  This will make it easier to update the
documentation for unit tests and qtests.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/qtest/meson.build | 55 +++++++++++++++++++----------------------
 1 file changed, 26 insertions(+), 29 deletions(-)

diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 0f32ca0895..28bafc02a2 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -193,35 +193,25 @@ qos_test_ss.add(
 qos_test_ss.add(when: 'CONFIG_VIRTFS', if_true: files('virtio-9p-test.c'))
 qos_test_ss.add(when: 'CONFIG_VHOST_USER', if_true: files('vhost-user-test.c'))
 
-extra_qtest_deps = {
-  'bios-tables-test': [io],
-  'ivshmem-test': [rt],
-  'qos-test': [chardev, io],
-  'tpm-crb-swtpm-test': [io],
-  'tpm-crb-test': [io],
-  'tpm-tis-swtpm-test': [io],
-  'tpm-tis-test': [io],
-  'tpm-tis-device-swtpm-test': [io],
-  'tpm-tis-device-test': [io],
-}
-extra_qtest_srcs = {
-  'bios-tables-test': files('boot-sector.c', 'acpi-utils.c', 'tpm-emu.c'),
-  'pxe-test': files('boot-sector.c'),
+tpmemu_files = ['tpm-emu.c', 'tpm-util.c', 'tpm-tests.c']
+
+qtests = {
+  'bios-tables-test': [io, 'boot-sector.c', 'acpi-utils.c', 'tpm-emu.c'],
   'cdrom-test': files('boot-sector.c'),
-  'migration-test': files('migration-helpers.c'),
-  'ivshmem-test': files('../../contrib/ivshmem-server/ivshmem-server.c'),
   'dbus-vmstate-test': files('migration-helpers.c') + dbus_vmstate1,
+  'ivshmem-test': [rt, '../../contrib/ivshmem-server/ivshmem-server.c'],
+  'migration-test': files('migration-helpers.c'),
+  'pxe-test': files('boot-sector.c'),
+  'qos-test': [chardev, io, qos_test_ss.apply(config_host, strict: false).sources()],
+  'tpm-crb-swtpm-test': [io, tpmemu_files],
+  'tpm-crb-test': [io, tpmemu_files],
+  'tpm-tis-swtpm-test': [io, tpmemu_files, 'tpm-tis-util.c'],
+  'tpm-tis-test': [io, tpmemu_files, 'tpm-tis-util.c'],
+  'tpm-tis-device-swtpm-test': [io, tpmemu_files, 'tpm-tis-util.c'],
+  'tpm-tis-device-test': [io, tpmemu_files, 'tpm-tis-util.c'],
   'vmgenid-test': files('boot-sector.c', 'acpi-utils.c'),
-  'tpm-crb-swtpm-test': files('tpm-emu.c', 'tpm-util.c', 'tpm-tests.c'),
-  'tpm-crb-test': files('tpm-emu.c', 'tpm-util.c', 'tpm-tests.c'),
-  'tpm-tis-device-swtpm-test': files('tpm-emu.c', 'tpm-util.c', 'tpm-tis-util.c', 'tpm-tests.c'),
-  'tpm-tis-device-test': files('tpm-emu.c', 'tpm-util.c', 'tpm-tis-util.c', 'tpm-tests.c'),
-  'tpm-tis-swtpm-test': files('tpm-emu.c', 'tpm-util.c', 'tpm-tis-util.c', 'tpm-tests.c'),
-  'tpm-tis-test': files('tpm-emu.c', 'tpm-util.c', 'tpm-tis-util.c', 'tpm-tests.c'),
-  'qos-test': qos_test_ss.apply(config_host, strict: false).sources()
 }
 
-
 qtest_executables = {}
 foreach dir : target_dirs
   if not dir.endswith('-softmmu')
@@ -230,7 +220,7 @@ foreach dir : target_dirs
 
   target_base = dir.split('-')[0]
   qtest_emulator = emulators['qemu-system-' + target_base]
-  qtests = get_variable('qtests_' + target_base, []) + qtests_generic
+  target_qtests = get_variable('qtests_' + target_base, []) + qtests_generic
 
   test_deps = []
   qtest_env = environment()
@@ -241,14 +231,21 @@ foreach dir : target_dirs
   qtest_env.set('G_TEST_DBUS_DAEMON', meson.source_root() / 'tests/dbus-vmstate-daemon.sh')
   qtest_env.set('QTEST_QEMU_BINARY', './qemu-system-' + target_base)
   
-  foreach test : qtests
+  foreach test : target_qtests
     # Executables are shared across targets, declare them only the first time we
     # encounter them
     if not qtest_executables.has_key(test)
+      src = [test + '.c']
+      deps = [qemuutil, qos]
+      if test in qtests
+        # use a sourceset to quickly separate sources and deps
+        test_ss = ss.source_set()
+        test_ss.add(qtests[test])
+        src += test_ss.all_sources()
+        deps += test_ss.all_dependencies()
+      endif
       qtest_executables += {
-        test: executable(test,
-                         files(test + '.c') + extra_qtest_srcs.get(test, []),
-                         dependencies: [qemuutil, qos] + extra_qtest_deps.get(test, []))
+        test: executable(test, src, dependencies: deps)
       }
     endif
     # FIXME: missing dependency on the emulator binary and qemu-img
-- 
2.26.2



