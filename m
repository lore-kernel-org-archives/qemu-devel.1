Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FDD7C4727E
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 08:05:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 237192083B
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 08:05:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z7ZjG7DO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 237192083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50334 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQ4SI-0003kB-0f
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 04:05:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41750)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kQ4Qt-0002MQ-Oj
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 04:04:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36790)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kQ4Qq-0006NY-Mn
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 04:04:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602057855;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yyOz4gChudRcDBkXc683lx3khv8tEJBu3NrOoB1QVkw=;
 b=Z7ZjG7DOj3xcdRojQEV/lBMc/f5sR1fkMVuG/hMP/usBJ12XI9RihDjSN3fYe2LEBQIhcP
 3d2GskiCiD6mNeJlZIAjFq0f5lHXoZmZ85BuJnU9BBOqHig3olsFv9gFaP+F8wOkpvoZg2
 WU7O1IdOraHd1huzE1VBGNl5vQvx5qM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-253-iBq2NYnBNMCtyoHvRvnlMA-1; Wed, 07 Oct 2020 04:04:14 -0400
X-MC-Unique: iBq2NYnBNMCtyoHvRvnlMA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 374E51054F99
 for <qemu-devel@nongnu.org>; Wed,  7 Oct 2020 08:03:13 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F3C3755786
 for <qemu-devel@nongnu.org>; Wed,  7 Oct 2020 08:03:12 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/2] qtest: unify extra_qtest_srcs and extra_qtest_deps
Date: Wed,  7 Oct 2020 04:03:11 -0400
Message-Id: <20201007080312.566464-2-pbonzini@redhat.com>
In-Reply-To: <20201007080312.566464-1-pbonzini@redhat.com>
References: <20201007080312.566464-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/07 00:54:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.733,
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
index ad33ac311d..550a0b51a6 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -192,35 +192,25 @@ qos_test_ss.add(
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
@@ -229,7 +219,7 @@ foreach dir : target_dirs
 
   target_base = dir.split('-')[0]
   qtest_emulator = emulators['qemu-system-' + target_base]
-  qtests = get_variable('qtests_' + target_base, []) + qtests_generic
+  target_qtests = get_variable('qtests_' + target_base, []) + qtests_generic
 
   test_deps = []
   qtest_env = environment()
@@ -240,14 +230,21 @@ foreach dir : target_dirs
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



