Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7460CC433E7
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 20:32:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4B83205CA
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 20:32:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R7PR2twp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4B83205CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36918 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQcaR-0007gJ-SF
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 16:32:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38878)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kQcVn-0003VO-LJ
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 16:27:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20094)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kQcVl-0005wG-RM
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 16:27:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602188857;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+55CXXawNYtb20ChkObbYkrCRkauAWIFrii7iUH14No=;
 b=R7PR2twpfBHA1/bZfd983vj9at/sTCyS6CW/DWKOsA04z4nrCmijEtVz1Np+0u+bKJF3z4
 AXVB2YED6S4Ok6RmsNkktm+hOBUtA976CYaL3BdKTotK4+aQAEAbrEMvlsVUgpX9F/WtSC
 tlX9t7Aiz8TAakZ+4w6VJcmZP3Yjc9s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-377-bxDHFsg0PI2HMb21oynwlQ-1; Thu, 08 Oct 2020 16:27:31 -0400
X-MC-Unique: bxDHFsg0PI2HMb21oynwlQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C6EE218A8230;
 Thu,  8 Oct 2020 20:27:30 +0000 (UTC)
Received: from localhost (ovpn-119-102.rdu2.redhat.com [10.10.119.102])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E6D0D6EF4F;
 Thu,  8 Oct 2020 20:27:27 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/3] tests/acceptance: Test case for detecting -object crashes
Date: Thu,  8 Oct 2020 16:27:13 -0400
Message-Id: <20201008202713.1416823-4-ehabkost@redhat.com>
In-Reply-To: <20201008202713.1416823-1-ehabkost@redhat.com>
References: <20201008202713.1416823-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/08 02:56:27
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: Vikram Garhwal <fnu.vikram@xilinx.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Pavel Pisa <pisa@cmp.felk.cvut.cz>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add a simple test case that will run QEMU directly (without QMP)
just to check for crashes when using `-object`.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Cc: Cleber Rosa <crosa@redhat.com>
Cc: "Philippe Mathieu-Daudé" <philmd@redhat.com>
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>
Cc: qemu-devel@nongnu.org
---
 tests/acceptance/object_option.py | 49 +++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)
 create mode 100644 tests/acceptance/object_option.py

diff --git a/tests/acceptance/object_option.py b/tests/acceptance/object_option.py
new file mode 100644
index 0000000000..2b8bd00db1
--- /dev/null
+++ b/tests/acceptance/object_option.py
@@ -0,0 +1,49 @@
+# Copyright (c) 2020 Red Hat, Inc.
+#
+# Author:
+#  Eduardo Habkost <ehabkost@redhat.com>
+#
+# This work is licensed under the terms of the GNU GPL, version 2 or
+# later.  See the COPYING file in the top-level directory.
+
+import avocado_qemu
+import subprocess
+import shlex
+
+class ObjectOption(avocado_qemu.Test):
+    """Check if ``-object`` option behaves as expected"""
+
+    def run(self, cmd, *args, **kwargs):
+        cmdstr = ' '.join(shlex.quote(c) for c in cmd)
+        self.log.info("Command: %s", cmdstr)
+        return subprocess.run(cmd, encoding='utf-8', *args, **kwargs)
+
+    def devices(self):
+        out = self.run([self.qemu_bin, '-object', 'help'],
+                       check=True, stdout=subprocess.PIPE).stdout
+        lines = out.split('\n')
+        return [l.strip() for l in lines[1:] if l.strip()]
+
+    def test_help(self):
+        """Check if ``-object ...,help`` behaves as expected"""
+        for device in self.devices():
+            self.run([self.qemu_bin, '-object', '%s,help' % (device)],
+                     check=True,
+                     stdout=subprocess.DEVNULL)
+
+    def test_crash(self):
+        """Check for crashes when using ``-object ...``"""
+        for device in self.devices():
+            r = self.run([self.qemu_bin, '-object',
+                                '%s,id=obj0' % (device),
+                                '-monitor', 'stdio'],
+                         input='quit\n',
+                         stdout=subprocess.DEVNULL,
+                         stderr=subprocess.PIPE)
+            if r.returncode not in (0, 1):
+                self.log.warn("QEMU stderr: %s", r.stderr)
+                self.log.warn("QEMU exit code: %d", r.returncode)
+                if r.returncode < 0:
+                    self.fail("QEMU crashed")
+                else:
+                    self.fail("Unexpected exit code")
-- 
2.26.2


