Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CEA4C43603
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 14:48:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05A7521835
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 14:48:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A8aApw5n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05A7521835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38900 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idEtj-0000Dc-3K
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 09:47:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59602)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wainersm@redhat.com>) id 1idEOL-0001T3-Lg
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:15:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wainersm@redhat.com>) id 1idEOK-0001Zc-DI
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:15:33 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:46173
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wainersm@redhat.com>) id 1idEOJ-0001Yh-Jx
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:15:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575641731;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0ygww+v1oU+33ypIhc68siMy+/iwT5tY9NlCzUkIOiA=;
 b=A8aApw5nNVPodUplLF5mGvlNUrTv9FBQ+p9DE7UcJuaU2GuqLVLfVZA+07E3Rs8wKSvDjt
 g6tyRptEfuW2QTfnPWlPfoyb7pq+E8r795XGTKMu5WWqSm2COJB0AoHzCXQBshA2LlFvAj
 7yKjsgGE27nHnsfOS/3Fr7KIJ2uE2o8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-119-DQjdipU1PaOFvZ-KIQj4Mg-1; Fri, 06 Dec 2019 09:00:18 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8DEA2593AB;
 Fri,  6 Dec 2019 14:00:17 +0000 (UTC)
Received: from virtlab501.virt.lab.eng.bos.redhat.com
 (virtlab501.virt.lab.eng.bos.redhat.com [10.19.152.162])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A059E60FC1;
 Fri,  6 Dec 2019 14:00:16 +0000 (UTC)
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/2] tests/acceptance: Add PVH boot test
Date: Fri,  6 Dec 2019 09:00:11 -0500
Message-Id: <20191206140012.15517-2-wainersm@redhat.com>
In-Reply-To: <20191206140012.15517-1-wainersm@redhat.com>
References: <20191206140012.15517-1-wainersm@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: DQjdipU1PaOFvZ-KIQj4Mg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: fam@euphon.net, alex.bennee@linaro.org, wrampazz@redhat.com,
 crosa@redhat.com, philmd@redhat.com, sgarzare@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

QEMU 4.0 onward is able to boot an uncompressed kernel
image by using the x86/HVM direct boot ABI. It needs
Linux >=3D 4.21 built with CONFIG_PVH=3Dy.

This introduces an acceptance test which checks an
uncompressed Linux kernel image boots properly.

Signed-off-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
---
 tests/acceptance/pvh.py | 48 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)
 create mode 100644 tests/acceptance/pvh.py

diff --git a/tests/acceptance/pvh.py b/tests/acceptance/pvh.py
new file mode 100644
index 0000000000..c68489c273
--- /dev/null
+++ b/tests/acceptance/pvh.py
@@ -0,0 +1,48 @@
+# Copyright (c) 2019 Red Hat, Inc.
+#
+# Author:
+#  Wainer dos Santos Moschetta <wainersm@redhat.com>
+#
+# This work is licensed under the terms of the GNU GPL, version 2 or
+# later.  See the COPYING file in the top-level directory.
+
+"""
+x86/HVM direct boot acceptance tests.
+"""
+
+from avocado.utils.kernel import KernelBuild
+from avocado_qemu import Test
+from avocado_qemu import wait_for_console_pattern
+
+
+class Pvh(Test):
+    """
+    Test suite for x86/HVM direct boot feature.
+
+    :avocado: tags=3Dslow,arch=3Dx86_64,machine=3Dq35
+    """
+    def test_boot_vmlinux(self):
+        """
+        Boot uncompressed kernel image.
+        """
+        # QEMU can boot a vmlinux image for kernel >=3D 4.21 built
+        # with CONFIG_PVH=3Dy
+        kernel_version =3D '5.4.1'
+        kbuild =3D KernelBuild(kernel_version, work_dir=3Dself.workdir)
+        try:
+            kbuild.download()
+            kbuild.uncompress()
+            kbuild.configure(targets=3D['defconfig', 'kvmconfig'],
+                             extra_configs=3D['CONFIG_PVH=3Dy'])
+            kbuild.build()
+        except:
+            self.cancel("Unable to build vanilla kernel %s" % kernel_versi=
on)
+
+        self.vm.set_machine('q35')
+        self.vm.set_console()
+        kernel_command_line =3D 'printk.time=3D0 console=3DttyS0'
+        self.vm.add_args('-kernel', kbuild.vmlinux,
+                         '-append', kernel_command_line)
+        self.vm.launch()
+        wait_for_console_pattern(self, 'Kernel command line: %s' %
+                                 kernel_command_line)
--=20
2.21.0


