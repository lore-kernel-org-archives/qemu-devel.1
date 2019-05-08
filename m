Return-Path: <SRS0=nSo8=TI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94858C04AAB
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 08:58:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A487216C4
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 08:58:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A487216C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33418 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOIPZ-0000QQ-GX
	for qemu-devel@archiver.kernel.org; Wed, 08 May 2019 04:58:49 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42037)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hOINk-0007Tq-4G
	for qemu-devel@nongnu.org; Wed, 08 May 2019 04:56:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hOINj-0002w5-0w
	for qemu-devel@nongnu.org; Wed, 08 May 2019 04:56:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56118)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1hOINi-0002uV-QJ
	for qemu-devel@nongnu.org; Wed, 08 May 2019 04:56:54 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 02DC1C058CC0;
	Wed,  8 May 2019 08:56:53 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-45.ams2.redhat.com
	[10.36.116.45])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 1F11E4106;
	Wed,  8 May 2019 08:56:47 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
	id D103AA1E3; Wed,  8 May 2019 10:56:45 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed,  8 May 2019 10:56:36 +0200
Message-Id: <20190508085645.11595-5-kraxel@redhat.com>
In-Reply-To: <20190508085645.11595-1-kraxel@redhat.com>
References: <20190508085645.11595-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.32]);
	Wed, 08 May 2019 08:56:53 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 04/13] tests/vm: use ssh with pty
 unconditionally
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Fam Zheng <fam@euphon.net>, Ed Maste <emaste@freebsd.org>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Kamil Rytarowski <kamil@netbsd.org>, Gerd Hoffmann <kraxel@redhat.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	Li-Wen Hsu <lwhsu@freebsd.org>, Brad Smith <brad@comstyle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Allways ask ssh to run with a pseudo terminal.
Not having a terminal causes problems now and then.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 tests/vm/basevm.py | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
index 20eec5420dbf..9c6bb317ac89 100755
--- a/tests/vm/basevm.py
+++ b/tests/vm/basevm.py
@@ -120,16 +120,14 @@ class BaseVM(object):
         os.rename(fname + ".download", fname)
         return fname
 
-    def _ssh_do(self, user, cmd, check, interactive=False):
-        ssh_cmd = ["ssh", "-q",
+    def _ssh_do(self, user, cmd, check):
+        ssh_cmd = ["ssh", "-q", "-t",
                    "-o", "StrictHostKeyChecking=no",
                    "-o", "UserKnownHostsFile=" + os.devnull,
                    "-o", "ConnectTimeout=1",
                    "-p", self.ssh_port, "-i", self._ssh_key_file]
         for var in self.envvars:
             ssh_cmd += ['-o', "SendEnv=%s" % var ]
-        if interactive:
-            ssh_cmd += ['-t']
         assert not isinstance(cmd, str)
         ssh_cmd += ["%s@127.0.0.1" % user] + list(cmd)
         logging.debug("ssh_cmd: %s", " ".join(ssh_cmd))
@@ -141,9 +139,6 @@ class BaseVM(object):
     def ssh(self, *cmd):
         return self._ssh_do(self.GUEST_USER, cmd, False)
 
-    def ssh_interactive(self, *cmd):
-        return self._ssh_do(self.GUEST_USER, cmd, False, True)
-
     def ssh_root(self, *cmd):
         return self._ssh_do("root", cmd, False)
 
@@ -297,9 +292,9 @@ def main(vmcls):
         return 2
 
     if args.interactive:
-        if vm.ssh_interactive(*cmd) == 0:
+        if vm.ssh(*cmd) == 0:
             return 0
-        vm.ssh_interactive()
+        vm.ssh()
         return 3
     else:
         if vm.ssh(*cmd) != 0:
-- 
2.18.1


