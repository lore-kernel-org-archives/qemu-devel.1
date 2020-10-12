Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A1DDC4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 03:36:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2862420708
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 03:36:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fk/HSFS6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2862420708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40070 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRodP-0002kK-B9
	for qemu-devel@archiver.kernel.org; Sun, 11 Oct 2020 23:36:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56094)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kRocO-0001tl-K3
 for qemu-devel@nongnu.org; Sun, 11 Oct 2020 23:35:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:28601)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kRocM-0001u5-7r
 for qemu-devel@nongnu.org; Sun, 11 Oct 2020 23:35:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602473721;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fpHisvGdMfu2rLolCV/TUlcZ1mNSmd8f85VTiCWgp/8=;
 b=Fk/HSFS6rrR3/i3niqdrGTww19oqJgcfikmrxpCAjYpqz8c7KSJzqWQC2Bsb1QG/rhFzca
 tcrbbOp62rBVDJ4kF1N4FNerosCo4rbR9oYkUnwq+H8xA9tgO/fbuuoOB++StUvpWgmMzC
 /zPk2bqHdmVKdGmi9AU73ZEbaRyGiZc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-466--JjOiOXdM0aSYkLBP-Jx_w-1; Sun, 11 Oct 2020 23:35:19 -0400
X-MC-Unique: -JjOiOXdM0aSYkLBP-Jx_w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2F930425D5;
 Mon, 12 Oct 2020 03:35:18 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-119-55.rdu2.redhat.com
 [10.10.119.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CB449709BB;
 Mon, 12 Oct 2020 03:35:16 +0000 (UTC)
From: Cleber Rosa <crosa@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/1] hw/i386: prevent crash when an invalid number of dies is
 given
Date: Sun, 11 Oct 2020 23:35:07 -0400
Message-Id: <20201012033507.906096-2-crosa@redhat.com>
In-Reply-To: <20201012033507.906096-1-crosa@redhat.com>
References: <20201012033507.906096-1-crosa@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=crosa@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=crosa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/11 21:16:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Thomas Huth <thuth@redhat.com>, Beraldo Leal <bleal@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Willian Rampazzo <wrampazz@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When parsing the topology, the right default value of 1 is given to
dies, but if an invalid number such as 0 is given, QEMU will crash
with a floating point exception.

The alternative approach is to silently set dies to a valid value,
as it's done with cores and threads.

Signed-off-by: Cleber Rosa <crosa@redhat.com>
---
 hw/i386/pc.c                          |  5 +++++
 tests/acceptance/cpu_topology_dies.py | 31 +++++++++++++++++++++++++++
 2 files changed, 36 insertions(+)
 create mode 100644 tests/acceptance/cpu_topology_dies.py

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index e87be5d29a..209e44663d 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -713,6 +713,11 @@ void pc_smp_parse(MachineState *ms, QemuOpts *opts)
         unsigned cores   = qemu_opt_get_number(opts, "cores", 0);
         unsigned threads = qemu_opt_get_number(opts, "threads", 0);
 
+        if (dies <= 0) {
+            error_report("Invalid CPU topology: dies must be 1 or greater");
+            exit(1);
+        }
+
         /* compute missing values, prefer sockets over cores over threads */
         if (cpus == 0 || sockets == 0) {
             cores = cores > 0 ? cores : 1;
diff --git a/tests/acceptance/cpu_topology_dies.py b/tests/acceptance/cpu_topology_dies.py
new file mode 100644
index 0000000000..d73b7b30a2
--- /dev/null
+++ b/tests/acceptance/cpu_topology_dies.py
@@ -0,0 +1,31 @@
+# Check for crash when using invalid dies value for -smp
+#
+# Copyright (c) 2020 Red Hat, Inc.
+#
+# Author:
+#  Cleber Rosa <crosa@redhat.com>
+#
+# This work is licensed under the terms of the GNU GPL, version 2 or
+# later.  See the COPYING file in the top-level directory.
+from avocado_qemu import Test
+
+class CPUTolopogyDies(Test):
+    """
+    :avocado: tags=arch:x86_64
+    :avocado: tags=machine:pc
+    """
+    def test_invalid(self):
+        self.vm.add_args('-S', '-display', 'none', '-smp', '1,dies=0')
+        self.vm.set_qmp_monitor(enabled=False)
+        self.vm.launch()
+        self.vm.wait()
+        self.assertEquals(self.vm.exitcode(), 1, "QEMU exit code should be 1")
+        self.assertRegex(self.vm.get_log(),
+                         r'Invalid CPU topology: dies must be 1 or greater')
+
+    def test_valid(self):
+        self.vm.add_args('-S', '-display', 'none', '-smp', '1,dies=1')
+        self.vm.launch()
+        self.vm.command('quit')
+        self.vm.wait()
+        self.assertEquals(self.vm.exitcode(), 0, "QEMU exit code should be 0")
-- 
2.25.4


